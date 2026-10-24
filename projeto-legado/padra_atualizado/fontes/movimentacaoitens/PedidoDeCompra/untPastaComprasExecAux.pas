unit untPastaComprasExecAux;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  Vcl.StdCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untTExecucoesPastaCompra, Uni,
  untFuncoesAuxiliares, untFuncoesSimples;

type
  TfrmPastaComprasExecAux = class(TfrmPaiConfirma)
    gpbExecucoes: TGroupBox;
    Label5: TLabel;
    btnExecutar: TBitBtnLocked;
    pgbExecucoes: TcxProgressBar;
    btnAbortar: TBitBtnLocked;
    lblProcesso: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure btnAbortarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FobjExecucoes: TExecucoes;
    FStlListaProceduresInexistentes: TStringList;
    procedure pExecutaProgress(posAtual,  maxPosition: integer);
    procedure pGetMsg(AStrMsg: String; blnNoShow: Boolean = False);
    procedure pCriaThread;
    function fVerificaExistenciaProcedures: Boolean;
    procedure pHabilitarBotoes(ABlnMostrarAbortar: Boolean);
  public
  end;

var
  frmPastaComprasExecAux: TfrmPastaComprasExecAux;

implementation

{$R *.dfm}

{ TfrmPastaComprasExecAux }

procedure TfrmPastaComprasExecAux.btnAbortarClick(Sender: TObject);
begin
  inherited;
  Try
    FobjExecucoes.Terminate;

    If Assigned(FobjExecucoes.qryExecucao) Then
      FobjExecucoes.qryExecucao.BreakExec;

    pHabilitarBotoes(False);

    pgbExecucoes.Position := 0;

    pMensagemOk('Execução abortada!');
  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmPastaCompraConsulta.btnAbortarClick');
    End;
  End;
end;

procedure TfrmPastaComprasExecAux.pHabilitarBotoes(ABlnMostrarAbortar: Boolean);
begin
  If ABlnMostrarAbortar Then
  Begin
    btnExecutar.Visible := False;
    btnAbortar.Visible := True;
    btnAbortar.Top := btnExecutar.Top;
    btnAbortar.Left := btnExecutar.Left;
  End
  Else
  Begin
    btnExecutar.Visible := True;
    btnAbortar.Visible := False;
    btnExecutar.Top := btnAbortar.Top;
    btnExecutar.Left := btnAbortar.Left;
  End;

  lblProcesso.Caption := '';
end;

procedure TfrmPastaComprasExecAux.btnExecutarClick(Sender: TObject);
begin
  inherited;
  If Not (fMensagem('', 'Confirma a execução?', ['&Sim', '&Não']) = 1) Then
    Exit;

  pCriaThread;

  pHabilitarBotoes(True);

  FobjExecucoes.Start;
end;

procedure TfrmPastaComprasExecAux.FormActivate(Sender: TObject);
begin
  inherited;
  If Not fVerificaExistenciaProcedures Then
  Begin
    pMensagemOk('Não foram encontradas no banco de dados as seguintes rotinas: ' + #13 + fCommaText(FstlListaProceduresInexistentes,True, ',') + #13 + 'É necessário executar os scripts de criação no banco de dados!');
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  End;
end;

procedure TfrmPastaComprasExecAux.FormCreate(Sender: TObject);
begin
  inherited;
  FStlListaProceduresInexistentes := TStringList.Create;
end;

procedure TfrmPastaComprasExecAux.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FStlListaProceduresInexistentes);
end;

procedure TfrmPastaComprasExecAux.pCriaThread;
begin
  If Assigned(FObjExecucoes) Then
    FreeAndNil(FObjExecucoes);

  FobjExecucoes := TExecucoes.Create(pExecutaProgress, pGetMsg);
end;

procedure TfrmPastaComprasExecAux.pExecutaProgress(posAtual,
  maxPosition: integer);
begin
  pgbExecucoes.Properties.Max := maxPosition;
  pgbExecucoes.Position := posAtual;
end;

procedure TfrmPastaComprasExecAux.pGetMsg(AStrMsg: String; blnNoShow: Boolean = False);
begin
  If blnNoShow then
  begin
    lblProcesso.Caption := AStrMsg;
    Application.ProcessMessages;
  End
  Else
  begin
    pMensagemOk(AStrMsg);
    pHabilitarBotoes(False);
    pgbExecucoes.Position := 0;
  End
end;

function TfrmPastaComprasExecAux.fVerificaExistenciaProcedures: Boolean;
begin
  FStlListaProceduresInexistentes.Clear;
  If (Not (fExisteProcedure('pRotinasNoturnasRecalculoGiroSaidaDias'))) Then
    FStlListaProceduresInexistentes.Add('pRotinasNoturnasRecalculoGiroSaidaDias');

  If (Not (fExisteProcedure('pAtualizaSaldoPedidoCompra'))) Then
    FStlListaProceduresInexistentes.Add('pAtualizaSaldoPedidoCompra');

  If fTipoPastaDeCompraGlobal Then
  Begin
    If (Not (fExisteProcedure('pRotinasNoturnasGeraPreOrcamentoCompraGlobal'))) Then
      FStlListaProceduresInexistentes.Add('pRotinasNoturnasGeraPreOrcamentoCompraGlobal');
  End
  Else
  Begin
    If (Not (fExisteProcedure('pRotinasNoturnasGeraPreOrcamentoCompra'))) Then
      FStlListaProceduresInexistentes.Add('pRotinasNoturnasGeraPreOrcamentoCompra');
  End;

  Result := FStlListaProceduresInexistentes.Count = 0;
end;

end.
