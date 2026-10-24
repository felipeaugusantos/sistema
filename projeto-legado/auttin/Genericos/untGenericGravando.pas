unit untGenericGravando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractGravando, AppEvnts, Menus, StdCtrls, CheckLst, Buttons, BitBtnLockedIncrem, ExtCtrls, Gauges,
  untAbstractGravandoExecucao, untIGravandoExecucao, ActnList, System.Actions;

type
  TArrayGravandoExecucao = array of TAbstractGravandoExecucao;
  TArrayIGravandoExecucao = array of IGravandoExecucao;

  TfrmGenericGravando = class(TfrmAbstractGravando)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    arrGravandoExecucao: TArrayGravandoExecucao;
    arrIGravandoExecucao: TArrayIGravandoExecucao;
    procedure pConstroiOpcoes;
    function GetSelecionados: Integer;
  public
    constructor Create(AOwner: TComponent; const strNomeTinta: string; arrGravandoExecucao: TArrayGravandoExecucao); reintroduce;
    destructor Destroy; override;
    { Public declarations }
  end;


var
  frmGenericGravando: TfrmGenericGravando;

implementation

uses untStatusGravando, untFuncoesSimples;

{$R *.dfm}

{ TfrmGenericGravando }

procedure TfrmGenericGravando.btnConfirmaGeracaoClick(Sender: TObject);
var
  intIndex: Integer;
begin

  Try
    Try
      pSetFocus(btnSair);
      btnConfirmaGeracao.Enabled := False;
      EnableMenuItem(GetSystemMenu(Handle, False),
        SC_CLOSE,
        MF_BYCOMMAND + MF_GRAYED);
      mmoSaida.Clear;
      chklstOpcoes.Enabled := False;
      Application.ProcessMessages;

      if GetSelecionados = 0 then
      begin
        fMensagem('ATENÇÃO!', 'É necessário que seja selecionada ao menos uma opção', ['OK']);
        Exit;
      end;      

      for intIndex := 0 to chklstOpcoes.Count - 1 do
      begin
        Try
          if chklstOpcoes.Checked[intIndex] then
          begin
            chklstOpcoes.ItemIndex := intIndex;
            gravandoExecucao := arrIGravandoExecucao[intIndex];

            status := sgGravando;
            SetTexto('Iniciando ' + chklstOpcoes.Items[intIndex] + '...');
            gravandoExecucao.Executar(Self);

            if status <> sgCancelado then
            begin
              status := sgFinalizado;
              SetTexto(chklstOpcoes.Items[intIndex] + ' finalizado ');
            end;

            if status = sgCancelado then
              Exit;

            Application.ProcessMessages;
          end;
        Finally
          
        End;
      end;

      fMensagem('SUCESSO', 'Os arquivos foram importados com sucesso!', ['&OK']);
    Except
      on E: Exception do
      begin
        SetTexto(E.ClassName + ': ' + E.Message);
      end;
    End;
  Finally
    EnableMenuItem(GetSystemMenu(Handle, False),
      SC_CLOSE,
      MF_BYCOMMAND + MF_ENABLED);
    chklstOpcoes.Enabled := True;
    btnConfirmaGeracao.Enabled := True;
  End;
end;

constructor TfrmGenericGravando.Create(AOwner: TComponent; const strNomeTinta: string; arrGravandoExecucao: TArrayGravandoExecucao);
begin
  inherited Create(AOwner);
  Self.Caption := 'Geração de Arquivos de Cadastro - ' + strNomeTinta;
  pnlCabecalho.Caption := Self.Caption;
  Self.arrGravandoExecucao := arrGravandoExecucao;
  pConstroiOpcoes;
end;

destructor TfrmGenericGravando.Destroy;
begin  
  inherited Destroy;
end;

function TfrmGenericGravando.GetSelecionados: Integer;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to chklstOpcoes.Count - 1 do
  begin
    if chklstOpcoes.Checked[intCont] then
      Result := Result + 1;
  end;

end;

procedure TfrmGenericGravando.pConstroiOpcoes;
var
  intCont: Integer;
  intGraExc: Integer;
begin
  SetLength(arrIGravandoExecucao, 0);

  intGraExc := 0;


  for intCont := 0 to Length(arrGravandoExecucao) - 1 do
  begin
    If (arrGravandoExecucao[intCont].fHabilitaOpcao) Then
    Begin
      SetLength(arrIGravandoExecucao, Length(arrIGravandoExecucao) + 1);
      arrIGravandoExecucao[intGraExc] := arrGravandoExecucao[intCont];
      chklstOpcoes.Items.Add(arrGravandoExecucao[intCont].fGetNomeGravacao);

      Inc(intGraExc);
    End;
  end;

  grpOpcoes.Height := chklstOpcoes.Items.Count * chklstOpcoes.Canvas.TextHeight('T') +
    (grpOpcoes.Height - chklstOpcoes.Height) + 5;
end;


  
end.
