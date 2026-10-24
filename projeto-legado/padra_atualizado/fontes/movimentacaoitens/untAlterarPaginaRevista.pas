unit untAlterarPaginaRevista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, uni, untTypesSistema;

type
  TfrmAlterarPaginaRevista = class(TfrmPai)
    Panel1: TPanel;
    grbProduto: TGroupBox;
    grbRevista: TGroupBox;
    edtRevista: TEditFocus;
    Label1: TLabel;
    Label3: TLabel;
    edtRefere: TEditFocus;
    Label4: TLabel;
    edtCodUni: TEditFocus;
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lblFornec: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtDesIte: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryConIte: TUniQuery;

    procedure pCarregaProduto(qryConsulta: TUniQuery);
    procedure pLimpaTela;

    function fGravouRevista: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  public
    { Public declarations }
  end;

var
  frmAlterarPaginaRevista: TfrmAlterarPaginaRevista;

implementation
uses
    untPesqAux, untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmAlterarPaginaRevista.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If fGravouRevista Then
      pLimpaTela;
  End;
end;

procedure TfrmAlterarPaginaRevista.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      Begin
        If fValidaCampos(edtCodIte, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPrincipal.pConsultaItem]');
      End;
    End;
  End;
end;

function TfrmAlterarPaginaRevista.fGravouRevista: Boolean;
var
  qryUpd: TUniQuery;
begin
  Result := True;
  Try
    qryUpd := fCriaQuery(Nil);
    Try
      With qryUpd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE CADITE ');
        SQL.Add('    SET ITE_PAGREV = :PAGREV ');
        SQL.Add('  WHERE ITE_CODITE = :CODITE ');
        SQL.Add('    AND ITE_CODEMP = :CODEMP ');

        ParamByName('PAGREV').AsString := edtRevista.Text;
        ParamByName('CODITE').AsString := edtCodIte.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        ExecSQL;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmAlterarPaginaRevista.fGravouRevista]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TfrmAlterarPaginaRevista.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryConIte) Then
    FreeAndNil(qryConIte);
end;

procedure TfrmAlterarPaginaRevista.FormCreate(Sender: TObject);
begin
  inherited;
  qryConIte := fCriaQuery(Nil);
end;

procedure TfrmAlterarPaginaRevista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
  Begin
    btnConfirmar.Click;
    Key := 0;
  End;


end;

function TfrmAlterarPaginaRevista.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o código do produto!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaProduto(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do produto não encontrado!',['&O K']);
          pLimpaTela;
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtRevista) Then
    Begin
      If fEmptyStr(edtRevista.Text) Then
      Begin
        fMensagem('ATENÇÃO','O número da página da revista deve ser informado!',['&O K']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) And Sender.CanFocus Then
    pSetFocus(Sender);

end;

procedure TfrmAlterarPaginaRevista.pCarregaProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtCodIte.Text, '');
  With qryConsulta Do
  Begin
    edtDesIte.Text  := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtRefere.Text  := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtCodUni.Text  := fRetSiglaUni(qryConsulta.FieldByName('ITE_CODUNI').AsString);
    edtCodMar.Text  := qryConsulta.FieldByName('ITE_CODMAR').AsString;
    edtDesMar.Text  := fRetNomeMarca(qryConsulta.FieldByName('ITE_CODMAR').AsString);
    edtCodFor.Text  := qryConsulta.FieldByName('ITE_CODFOR').AsString;
    edtNomFor.Text  := fRetNomFornecedor(qryConsulta.FieldByName('ITE_CODFOR').AsString);
  End;
end;

procedure TfrmAlterarPaginaRevista.pLimpaTela;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtCodUni.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtRevista.Clear;
  pSetFocus(edtCodIte);
end;

end.
