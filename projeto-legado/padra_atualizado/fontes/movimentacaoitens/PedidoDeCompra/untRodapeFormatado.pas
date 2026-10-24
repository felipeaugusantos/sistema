unit untRodapeFormatado;

{**********************************************************************}
{* RODAPE DE TOTAIS EM LINHA CORRIDA: ROTULO EM AZUL E NEGRITO E      *}
{* VALOR EM PRETO, DESENHADOS NO PROPRIO PAINEL POR UM TPAINTBOX.     *}
{* OS TLABEL E OS EDITS DO PAINEL CONTINUAM EXISTINDO (O FORM LE E    *}
{* GRAVA O TEXTO DELES): VAO PARA UM PAINEL OCULTO E SERVEM DE FONTE. *}
{* CADA ROTULO MOSTRA O EDIT A DIREITA DELE NA MESMA LINHA; ROTULO OU *}
{* EDIT INVISIVEL NAO APARECE. QUEBRA A LINHA QUANDO NAO CABE.        *}
{* REDESENHA QUANDO UM CAMPO MUDA DE TEXTO OU DE VISIBLE (GANCHO NO   *}
{* WINDOWPROC DE CADA CONTROLE).                                      *}
{* O ROTULO INFORMADO COMO ULTIMO (EX.: TOTAL) FECHA A LINHA, E A     *}
{* ALTURA DO PAINEL FICA SO A DAS LINHAS USADAS.                      *}
{**********************************************************************}

interface

uses
  Winapi.Messages, System.Classes, System.Generics.Collections, Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TRodapeFormatado = class;

  // Um por controle do painel: repassa a mensagem ao WindowProc original e avisa o rodape.
  TGanchoCampoRodape = class
  private
    FctlCampo: TControl;
    FwndOriginal: TWndMethod;
    FobjRodape: TRodapeFormatado;
    procedure pMensagem(Var AmsgCampo: TMessage);
  public
    constructor Create(Const ActlCampo: TControl; Const AobjRodape: TRodapeFormatado);
    destructor Destroy; override;
  end;

  TRodapeFormatado = class(TComponent)
  private
    FpnlRodape: TPanel;
    FpnlCampos: TPanel;
    FpbxRodape: TPaintBox;
    FlstGanchos: TObjectList<TGanchoCampoRodape>;
    FlblUltimo: TLabel;
    FblnAjustandoAltura: Boolean;
    procedure pAjustarAltura(Const AintLinhas, AintAlturaLinha: Integer);
    function fRotulosEmOrdem: TArray<TLabel>;
    function fValorDoRotulo(Const AlblRotulo: TLabel): TCustomEdit;
    procedure pDesenhar(Sender: TObject);
  public
    // Os controles do painel passam para o painel oculto; o objeto e liberado pelo dono (o form).
    // AlblUltimo: rotulo que vai sempre por ultimo (ex.: TOTAL); Nil segue a ordem da tela.
    constructor Create(AOwner: TComponent; Const ApnlRodape: TPanel; Const AlblUltimo: TLabel = Nil); reintroduce;
    destructor Destroy; override;
    // Redesenha (ex.: depois de mudar o Visible de um rotulo ou edit).
    procedure pAtualizar;
  end;

implementation

uses
  System.SysUtils, System.Math, System.Generics.Defaults, Vcl.Graphics;

Const
  INT_MARGEM = 4;
  // Folga acima e abaixo das linhas.
  INT_MARGEM_VERTICAL = 3;
  // Diferenca de Top que ainda e a mesma linha do painel original.
  INT_TOLERANCIA_LINHA = 8;
  STR_ENTRE_CAMPOS = '    ';
  COR_ROTULO = clBlue;
  COR_VALOR = clBlack;

{ TGanchoCampoRodape }

constructor TGanchoCampoRodape.Create(Const ActlCampo: TControl; Const AobjRodape: TRodapeFormatado);
begin
  inherited Create;
  FctlCampo := ActlCampo;
  FobjRodape := AobjRodape;
  FwndOriginal := FctlCampo.WindowProc;
  FctlCampo.WindowProc := pMensagem;
end;

// Com o form em destruicao (csDestroying propagado ao rodape), o campo ja foi liberado junto com o painel pai:
// nao ha WindowProc para restaurar.
destructor TGanchoCampoRodape.Destroy;
begin
  If Not (csDestroying In FobjRodape.ComponentState) Then
    FctlCampo.WindowProc := FwndOriginal;
  inherited;
end;

procedure TGanchoCampoRodape.pMensagem(Var AmsgCampo: TMessage);
begin
  FwndOriginal(AmsgCampo);
  If ((AmsgCampo.Msg = CM_TEXTCHANGED) Or (AmsgCampo.Msg = CM_VISIBLECHANGED)) And
     Not (csDestroying In FobjRodape.ComponentState) Then
    FobjRodape.pAtualizar;
end;

{ TRodapeFormatado }

constructor TRodapeFormatado.Create(AOwner: TComponent; Const ApnlRodape: TPanel; Const AlblUltimo: TLabel);
  Var
    intPos: Integer;
    ctlCampo: TControl;
begin
  inherited Create(AOwner);
  FpnlRodape := ApnlRodape;
  FlblUltimo := AlblUltimo;
  FlstGanchos := TObjectList<TGanchoCampoRodape>.Create(True);

  FpnlCampos := TPanel.Create(Self);
  FpnlCampos.Visible := False;
  FpnlCampos.Parent := FpnlRodape;

  // De tras para frente: cada controle sai da lista do painel ao trocar de pai.
  For intPos := FpnlRodape.ControlCount - 1 DownTo 0 Do
  Begin
    ctlCampo := FpnlRodape.Controls[intPos];
    If ctlCampo = FpnlCampos Then
      Continue;
    ctlCampo.Parent := FpnlCampos;
    FlstGanchos.Add(TGanchoCampoRodape.Create(ctlCampo, Self));
  End;

  FpbxRodape := TPaintBox.Create(Self);
  FpbxRodape.Parent := FpnlRodape;
  FpbxRodape.Align := alClient;
  FpbxRodape.OnPaint := pDesenhar;
end;

// Liberado sozinho: os ganchos restauram o WindowProc dos campos antes do FpnlCampos (dono: Self) liberar os campos.
// Liberado pelo form: os campos ja foram liberados pelo painel pai, e os ganchos so saem da memoria.
destructor TRodapeFormatado.Destroy;
begin
  FreeAndNil(FlstGanchos);
  inherited;
end;

procedure TRodapeFormatado.pAtualizar;
begin
  If Assigned(FpbxRodape) Then
    FpbxRodape.Invalidate;
end;

// Na ordem da tela: linha do painel original (Top), depois da esquerda para a direita.
function TRodapeFormatado.fRotulosEmOrdem: TArray<TLabel>;
  Var
    intPos: Integer;
    lstRotulos: TList<TLabel>;
begin
  lstRotulos := TList<TLabel>.Create;
  Try
    For intPos := 0 To FpnlCampos.ControlCount - 1 Do
      If FpnlCampos.Controls[intPos] Is TLabel Then
        lstRotulos.Add(TLabel(FpnlCampos.Controls[intPos]));
    lstRotulos.Sort(TComparer<TLabel>.Construct(
      function(Const A, B: TLabel): Integer
      begin
        If Abs(A.Top - B.Top) > INT_TOLERANCIA_LINHA Then
          Result := A.Top - B.Top
        Else
          Result := A.Left - B.Left;
      end));
    If Assigned(FlblUltimo) And (lstRotulos.Remove(FlblUltimo) >= 0) Then
      lstRotulos.Add(FlblUltimo);
    Result := lstRotulos.ToArray;
  Finally
    FreeAndNil(lstRotulos);
  End;
end;

// Painel com a altura das linhas usadas. A altura nao muda a largura, entao o redesenho que ela provoca ja acha a
// altura certa (a trava so evita reentrar enquanto o painel realinha).
procedure TRodapeFormatado.pAjustarAltura(Const AintLinhas, AintAlturaLinha: Integer);
  Var
    intAltura: Integer;
begin
  intAltura := AintLinhas * AintAlturaLinha + 2 * INT_MARGEM_VERTICAL;
  If FblnAjustandoAltura Or (FpnlRodape.ClientHeight = intAltura) Then
    Exit;
  FblnAjustandoAltura := True;
  Try
    FpnlRodape.ClientHeight := intAltura;
  Finally
    FblnAjustandoAltura := False;
  End;
end;

// O edit mais perto, a direita do rotulo, na mesma linha.
function TRodapeFormatado.fValorDoRotulo(Const AlblRotulo: TLabel): TCustomEdit;
  Var
    intPos: Integer;
    ctlCampo: TControl;
begin
  Result := Nil;
  For intPos := 0 To FpnlCampos.ControlCount - 1 Do
  Begin
    ctlCampo := FpnlCampos.Controls[intPos];
    If (ctlCampo Is TCustomEdit) And (ctlCampo.Left >= AlblRotulo.Left) And
       (Abs((ctlCampo.Top + ctlCampo.Height Div 2) - (AlblRotulo.Top + AlblRotulo.Height Div 2)) <=
        INT_TOLERANCIA_LINHA) And
       ((Result = Nil) Or (ctlCampo.Left < Result.Left)) Then
      Result := TCustomEdit(ctlCampo);
  End;
end;

procedure TRodapeFormatado.pDesenhar(Sender: TObject);
  Var
    cnvRodape: TCanvas;
    arrRotulos: TArray<TLabel>;
    intAlturaLinha,
    intLinhas,
    intX,
    intY: Integer;

  // Uma passada mede (quantas linhas), a outra desenha centralizado na altura.
  procedure pPercorrer(Const AblnDesenhar: Boolean);
    Var
      lblRotulo: TLabel;
      edtValor: TCustomEdit;
      strRotulo,
      strValor: String;
      intLargura,
      intTopo: Integer;
  begin
    intX := INT_MARGEM;
    intLinhas := 1;
    For lblRotulo In arrRotulos Do
    Begin
      edtValor := fValorDoRotulo(lblRotulo);
      If (Not lblRotulo.Visible) Or (Not Assigned(edtValor)) Or (Not edtValor.Visible) Then
        Continue;
      strRotulo := Trim(lblRotulo.Caption) + ' ';
      strValor := Trim(edtValor.Text) + STR_ENTRE_CAMPOS;

      cnvRodape.Font.Assign(lblRotulo.Font);
      cnvRodape.Font.Style := [fsBold];
      intLargura := cnvRodape.TextWidth(strRotulo);
      cnvRodape.Font.Style := [];
      intLargura := intLargura + cnvRodape.TextWidth(strValor);

      // Nao cabe: proxima linha (o primeiro da linha fica, mesmo cortado).
      If (intX > INT_MARGEM) And (intX + intLargura > FpbxRodape.Width - INT_MARGEM) Then
      Begin
        intX := INT_MARGEM;
        Inc(intLinhas);
      End;

      If AblnDesenhar Then
      Begin
        intTopo := intY + (intLinhas - 1) * intAlturaLinha;
        cnvRodape.Font.Style := [fsBold];
        cnvRodape.Font.Color := COR_ROTULO;
        cnvRodape.TextOut(intX, intTopo, strRotulo);
        Inc(intX, cnvRodape.TextWidth(strRotulo));
        cnvRodape.Font.Style := [];
        cnvRodape.Font.Color := COR_VALOR;
        cnvRodape.TextOut(intX, intTopo, strValor);
        Inc(intX, cnvRodape.TextWidth(strValor));
      End
      Else
        Inc(intX, intLargura);
    End;
  end;

begin
  arrRotulos := fRotulosEmOrdem;
  If Length(arrRotulos) = 0 Then
    Exit;

  cnvRodape := FpbxRodape.Canvas;
  cnvRodape.Brush.Style := bsClear;
  cnvRodape.Font.Assign(arrRotulos[0].Font);
  intAlturaLinha := cnvRodape.TextHeight('Ag') + 2;

  intY := 0;
  pPercorrer(False);
  pAjustarAltura(intLinhas, intAlturaLinha);
  intY := Max(0, (FpbxRodape.Height - intLinhas * intAlturaLinha) Div 2);
  pPercorrer(True);
end;

end.
