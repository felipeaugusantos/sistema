unit untRelacaoPixParaGerarCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxMaskEdit, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, Uni, UniClientDataset, cxTextEdit;

type
  TfrmRelacaoPixParaGerarCC = class(TfrmPai)
    pnlFundo: TPanel;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosDadosMPX_CODEMP: TcxGridDBColumn;
    grdLancamentosDadosMPX_DTAHOR: TcxGridDBColumn;
    grdLancamentosDadosMPX_TX_ID_: TcxGridDBColumn;
    grdLancamentosDadosBANCO: TcxGridDBColumn;
    grdLancamentosDadosPORTADOR: TcxGridDBColumn;
    grdLancamentosDadosMPX_VALREC: TcxGridDBColumn;
    grdLancamentosDadosDATARECEBIMENTO: TcxGridDBColumn;
    grdLancamentosDadosMPX_SOLPAG: TcxGridDBColumn;
    grdLancamentosDadosVENDEDOR: TcxGridDBColumn;
    grdLancamentosDadosMPX_QRCODE: TcxGridDBColumn;
    grdLancamentosNivel: TcxGridLevel;
    btnGerarCC: TBitBtnLocked;
    grdLancamentosDadosLOG_CODCLI: TcxGridDBColumn;
    grdLancamentosDadosMPX_CHADOC: TcxGridDBColumn;
    grdLancamentosDadosMPX_VALDOC: TcxGridDBColumn;
    grdLancamentosDadosLOG_QTDITE: TcxGridDBColumn;
    grdLancamentosDadosLOG_NOMTEL: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarCCClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdLancamentosDadosLOG_CODCLIGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    FDatasetMovPix: TUniClientDataset;

    procedure CriaTemporaria;

    procedure GeraCCPixSelecionado;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelacaoPixParaGerarCC: TfrmRelacaoPixParaGerarCC;

implementation
Uses untFuncoesSimples, untGravando, untTCreditoClientePixAutcom,
     untTFuncoesPixAutcom;

{$R *.dfm}

procedure TfrmRelacaoPixParaGerarCC.btnGerarCCClick(Sender: TObject);
begin
  inherited;
  If FDatasetMovPix.IsEmpty Then
    Exit;

  If fMensagem('ATENÇÃO', 'Tem certeza que deseja gerar o Crédito da cobrança Pix selecionada?', ['&Sim', '&Não']) = 2 Then
    Exit;

  TfrmGravando.fExecutarModal(GeraCCPixSelecionado, 'Aguarde... Gerando o CC do Pix.', '');
end;

procedure TfrmRelacaoPixParaGerarCC.CriaTemporaria;
begin
  FDatasetMovPix := TFuncoesPixAutcom.RetornaDatasetPixPagosSemConfirmacao(strLoginUsuarioLogado);

  grdLancamentosDados.DataController.DataSource := fCriaDataSource(FDatasetMovPix);
end;

procedure TfrmRelacaoPixParaGerarCC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FDatasetMovPix);
end;

procedure TfrmRelacaoPixParaGerarCC.FormCreate(Sender: TObject);
begin
  inherited;
  FDatasetMovPix := TUniClientDataset.Create(Nil);
end;

procedure TfrmRelacaoPixParaGerarCC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click
  Else If Key = VK_F10 Then
    btnGerarCC.Click;
end;

procedure TfrmRelacaoPixParaGerarCC.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Carregando registros.', '');

  pSetFocus(grdLancamentos);
end;

procedure TfrmRelacaoPixParaGerarCC.GeraCCPixSelecionado;
  Var
    LCodigoCliente: String;

    LObjetoCreditoPix: TCreditoClientePixAutcom;
begin
  Try
    LObjetoCreditoPix := TCreditoClientePixAutcom.Create;
    Try
      If Not LObjetoCreditoPix.GerarCCPixPagoNaoConfirmado(FDatasetMovPix) Then
        Exit;

      LCodigoCliente := LObjetoCreditoPix.ClienteSelecionado;

      LObjetoCreditoPix.AtualizaRegistroPixCCGerado(FDatasetMovPix);

      fCommit;

      LObjetoCreditoPix.ClienteSelecionado := EmptyStr;

      fMensagem('ATENÇÃO', 'Crédito de cliente gerado para o cliente ' +
                           LCodigoCliente + '-' + fRetNomCliente(LCodigoCliente) + ' ' +
                           'com sucesso.', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;

        pMensagensErro('Ocorreu um erro ao gerar o Crédito do Cliente para o Pix.' + #13 +
                       'Erro gerado: ' + E.Message, '[TfrmRelacaoPixParaGerarCC.GeraCCPixSelecionado]');
      End;
    End;
  Finally
    FreeAndNil(LObjetoCreditoPix);

    TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Recarregando registros.', '');
  End;
end;

procedure TfrmRelacaoPixParaGerarCC.grdLancamentosDadosLOG_CODCLIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not AText.IsEmpty Then
    AText := AText + '-' + fRetNomCliente(AText);
end;

end.
