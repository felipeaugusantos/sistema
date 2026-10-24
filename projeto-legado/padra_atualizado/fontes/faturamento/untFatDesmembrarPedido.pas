unit untFatDesmembrarPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, untTypesCRM,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, untAtualizaOcorrenciasCRM,
  ExtCtrls, DB, Uni, BitBtnLockedIncrem, Mask, MaskEditFocus, untTypesSistema, untFuncoesCRM,
  cxProgressBar, TypInfo, Faturamento.Classes.TAlterarPedido, frxClass, frxExportCSVTestabilidade,
  Vcl.Grids, DBGridCitel, Vcl.DBGrids, UniClientDataSet, UniDataSetProvider, untMsgInterna,
  untLiberacao, System.Math, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untTSituacaoPedidoVenda,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid;

type
  TOpcFin = (ofNovoPedido, ofVendaPerdida, ofRequisicaoCompra);


  TfrmFatDesmembrarPedido = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlBusca: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    pnlItens: TPanel;
    btnCopiarQtd: TBitBtnLocked;
    lblQtdProd: TLabel;
    pnlOpcaoFinalizacao: TPanel;
    Label7: TLabel;
    cmbOpcFinalizacao: TComboBox;
    lblReqCompra: TLabel;
    btnAltCndPag: TBitBtnLocked;
    btnEstLoj: TBitBtnLocked;
    cxgItens: TcxGrid;
    cxgItensDados: TcxGridDBTableView;
    cxgItensNivel: TcxGridLevel;
    cxgItensDadosCODITE: TcxGridDBColumn;
    cxgItensDadosDESITE: TcxGridDBColumn;
    cxgItensDadosSIGUNI: TcxGridDBColumn;
    cxgItensDadosQTDORI: TcxGridDBColumn;
    cxgItensDadosUNITAR: TcxGridDBColumn;
    cxgItensDadosTOTITE: TcxGridDBColumn;
    cxgItensDadosSALDOS: TcxGridDBColumn;
    cxgItensDadosSALDIS: TcxGridDBColumn;
    cxgItensDadosSALDISLIBCOM: TcxGridDBColumn;
    cxgItensDadosQTDITE: TcxGridDBColumn;
    cxgItensDadosUNITMP: TcxGridDBColumn;
    cxgItensDadosTOTTMP: TcxGridDBColumn;
    cxgItensDadosSTATUSITEM: TcxGridDBColumn;
    cxgItensDadosQTDBAI: TcxGridDBColumn;
    cxgItensDadosQTDPEN: TcxGridDBColumn;
    pnlDadosDocumento: TPanel;
    pnl3: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCodCli: TEditFocus;
    edtDtaEnt: TEditFocus;
    edtDesCli: TEditFocus;
    edtVlrCon: TEditFocus;
    edtCodVen: TEditFocus;
    edtTotPro: TEditFocus;
    edtDesEsp: TEditFocus;
    edtTotIpi: TEditFocus;
    edtTotRet: TEditFocus;
    edtDesAce: TEditFocus;
    edtTotFre: TEditFocus;
    lblTotCBS: TLabel;
    lblTotIBS: TLabel;
    lblTotIS: TLabel;
    edtTotCBS: TEditFocus;
    edtTotIBS: TEditFocus;
    edtTotIS: TEditFocus;
    pnl2: TPanel;
    lbl8: TLabel;
    edtCodCndAtu: TEditFocus;
    mskCndPagAtu: TMaskEditFocus;
    edtDesCndAtu: TEditFocus;
    pnlForPagAtu: TPanel;
    lbl7: TLabel;
    edtForPagAtu: TEditFocus;
    edtDesFpgAtu: TEditFocus;
    pnlMensagemPedido: TPanel;
    memMensagens: TMemo;
    lblMensagens: TLabel;
    cxgItensDadosQTDREC: TcxGridDBColumn;
    cxgItensDadosQTORI2: TcxGridDBColumn;
    cxgItensDadosQTDATE: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaErro(Sender: TWinControl; strMsgErro: string;
      E: Exception);
    procedure btnCopiarQtdClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnAltCndPagClick(Sender: TObject);
    procedure cmbOpcFinalizacaoChange(Sender: TObject);
    procedure btnEstLojClick(Sender: TObject);
    procedure cxgItensEnter(Sender: TObject);
    procedure cxgItensDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensDadosEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensExit(Sender: TObject);
    procedure cxgItensDadosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxgItensDadosEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    { Private declarations }
    dtsDados : TDataSource;
    cdsDados : TUniClientDataSet;

    cdsVendaBkp : TUniClientDataSet;

    intSemaforoValidar : Integer;

    objAltDoc: TAlterarPedido;

    strInRqCp: String;

    cdsInfAdcItem : TUniClientDataSet;
    objLiberacao : TLiberacao;
    blnOnShow    : Boolean;

    FblnAlterouCndPag: Boolean;
    FstrCodCndNovo: String;
    FstrCndPagNovo: String;
    FstrCodFpgNovo: String;
    FstrCodCndBkp: String;
    FstrCndPagBkp: String;
    FstrCodFpgBkp: String;
    blnRetirarNovoPedidoDoRegimeEspecial: Boolean;
    blnValidandoAfterPost: Boolean;

    FItensComRequisicaoCompra: TStringList;
    objCdsVinculos: TUniClientDataSet;
    procedure pLimparTela;
    procedure pAtualizaDadosDocumento;
    function fCalcularSalDis(pgbStatus: TcxProgressBar = NIL) : Boolean;

    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);

    function fCalcValorNovoDoc(strCampo: String): Double;

    function fQuantidadeOriginalTodosItens: Boolean;
    function fQuantidadeZeradaTodosItens: Boolean;

    procedure pExecutaBeforePostTodosItens;

    procedure pZerarQuantidadeProdutos;
    procedure pAtualizarValorProdutos;
    procedure pCopiarQuantidadeOriginal;

    procedure pAtualizarLabelQtdProd;

    procedure pAdicionarItensReservarSemEstoque;
    procedure pAcertarQuantidadeDocNovo;
    procedure pAcertarQuantidadeDocOriginal;

    procedure pLimparItens;

    procedure pCriaClientInfAdcItem;
    procedure pProcessaClientInfAdcItem;
    function fFinanceiroPermiteDesmembramento: Boolean;
    procedure pAcertaMensagem(strNumDocNovoA, strEspDocNovoA, strNumDocNovoB, strEspDocNovoB: String);
    procedure pAcertaNumeroPedidoItensRequisicaoCompra(strNumDocNovo: String);
    procedure pConfirmar;
    function fCarregarDocumento(): Boolean; overload;
    function fCarregarDocumento(strNumPed, strEspPed, strEmpPed: String): Boolean; overload;
    function fCarregarQtdDesmExp: Boolean;

    procedure pDesmembrarPedidosUsandoMesmoCliente;
    procedure pDesmembrarPedidosUsandoClienteFilialNovoPedido;
    procedure pDesmembrarPedidosVendaPerdida;
    procedure pDesmembrarPedidosRequisicaoCompra;

    procedure pEnviarEmailPedidoFaltaEstoqueGerado(strVendedor, strNovoPedido, strItensAlterados: String);

    procedure pReprocessaSaldoAmbosPedidos(strNumDocNovo: String);
    procedure pExcluirNovoDocumentoGerado(strNumDocNovo: String);
    procedure pExcluirNovaVendaPerdidaGerada(strCodigo: String);
    procedure pFecharDesmExpedicao(blnDesmem: Boolean);
    function fMontarMensagemCorteParaDigitador: String;
    procedure pEnviarMensagemCorteParaDigitador(strMsg: String);

    function fEmpresaParaFaturamentoUsaWMS(strCodEmp: String): Boolean;
    function fEhEmissaoDocumentoWMS(strCodEmp: String): Boolean;
    function fTemItemEspecialOrcamento(strNumDoc, strCodEmp: String): Boolean;
    procedure pAddColunasGrid;
    procedure AjustarTamanhoDaColunaDescricaoDaGrid;
    procedure pCarregaOpcaoFinalizacao;
    function fIncluiVendaPerdida(var strCodigo: String): Boolean;
    function fIncluiRequisicaoCompra(var strCodigo: String): Boolean;
    function fOpcaoFinalizacao: TOpcFin;
    function fValidaRequisicaoCompra: Boolean;
    procedure pVerificaRequisicaoCompra;
    function fRetornaOrigemDesmembramento: String;
    function fPermiteOpcaoGerarNovoPedido():Boolean;
    procedure pRetornaStatusItem;
    procedure pConfiguraIconesProdutos(cxProdutos: TcxGridDBTableView);
    procedure pRetQuantidadePendenteFaturado;
    procedure pAtualizaCdsDados;
    function fValidaQuantidadePendente: Boolean;
    function fTravaDesmembramento: Boolean;
    function fPermiteDesmembrarReqCompra: Boolean;
    procedure pMontaMensagensPedido;
    function fValidouFaturamentoMinimo: Boolean;
  public
    { Public declarations }
    blnUsarClienteFilialParaNovoPedido: Boolean;
    arrIteExpPed : TItensExpedidosPedido;
    blnDesmembrou: Boolean;
    blnCRM: Boolean;
    strNumPed, strEspPed, strEmpPed: String;
    blnLiberacaoPedido: Boolean;
    blnPermiteAlterarCndPag: Boolean;
    blnExpedicao: Boolean;
    blnDesmembramentoAutomaticoPelaExpedicao: Boolean;
    blnVendaPerdidaAutomatica: Boolean;
    blnDesmembrarOrcamentoPedido: Boolean;
    blnPedidoRegimeEspecial: Boolean;
    blnPermiteApenasGerarRequisicaoParaItensSemEstoque : Boolean;
    procedure pOnShow;
    procedure pGravaQtdeNovoDoc;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

CONST
  OPC_FIN_NOVO_PEDIDO = 'Gerar novo pedido';
  OPC_FIN_NOVO_ORCAMENTO = 'Gerar novo orçamento';
  OPC_FIN_VENDA_PERDIDA = 'Gerar vendas perdidas';
  OPC_FIN_REQUISICAO_COMPRA = 'Gerar requisição de compra';
  AGUARDANDO_SEPARACAO = 'Aguardando separação';

implementation

uses StrUtils, untConsultas, untPanelCxPedOrc, System.UITypes, untPnlDadosPedOrc,
     untFuncoes, untConstantes, untFuncoesSimples, untFuncFat, untGravando, untDigOcorrencia,
     untAdiantamentoCliente, untFatRequisicaoCompras, untTEnvioEmail, cxImageComboBox,
     untAdiantamentoClienteGenerico, untIFatReservaSaldo, untTFatReservaSaldo, untFuncTinta,
     untTFatReprocessarSaldoItem, Yapay.Api.Facade, untVendasPerdidas, untMensagemExplicativa,
     untDigCndPagamentoEsp, untFatMostraEstoqueEmp, untTCdsVinculosRequisicoes,
     Shared.Functions.DataSet;

{$R *.dfm}

procedure TfrmFatDesmembrarPedido.btnConfirmaErro(Sender: TWinControl;
  strMsgErro: string; E: Exception);
begin
  inherited;
  If E Is EAbort Then
    Exit;

  If E Is Exception Then
    pMensagensErro(E.Message, '');
end;

procedure TfrmFatDesmembrarPedido.btnCopiarQtdClick(Sender: TObject);
begin
  inherited;
  If Not btnCopiarQtd.Enabled Then
    Exit;

  If Assigned(cdsDados) And (Not cdsDados.IsEmpty) Then
    pCopiarQuantidadeOriginal
  Else
    pMensagemOk('É necessário selecionar um documento!');
end;

procedure TfrmFatDesmembrarPedido.btnEstLojClick(Sender: TObject);
var
  frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  inherited;
  if (not cdsDados.Active) or cdsDados.IsEmpty then
    Exit;

  if (not fVerificaAcessoSistema('PVISPF')) then
  begin
    fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de saldo de produtos no faturamento.',['&OK']);
    Exit;
  end;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    frmFatMostraEstoqueEmp.blnFaturamento := True;
    frmFatMostraEstoqueEmp.strCodIte    := cdsDados.FieldByName('ITE_CODITE').AsString;
    frmFatMostraEstoqueEmp.fltQtdIte    := cdsDados.FieldByName('ITE_QTDORI').AsFloat;
    frmFatMostraEstoqueEmp.strTabPre    := cdsDados.FieldByName('ITE_TABPRE').AsString;
    frmFatMostraEstoqueEmp.blnPedCorte  := objAltDoc.objVenda.blnPedCorte;
    frmFatMostraEstoqueEmp.edtItem.Text := cdsDados.FieldByName('ITE_CODITE').AsString + ' - ' + cdsDados.FieldByName('ITE_DESITE').AsString;
    frmFatMostraEstoqueEmp.pnlSelecEmpresa.Visible := False;

    frmFatMostraEstoqueEmp.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[btnEstLojClick]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;

procedure TfrmFatDesmembrarPedido.cmbOpcFinalizacaoChange(Sender: TObject);
begin
  inherited;
  btnAltCndPag.Visible :=
    AnsiMatchText(cmbOpcFinalizacao.Text, [OPC_FIN_NOVO_PEDIDO, OPC_FIN_NOVO_ORCAMENTO]) and
    blnPermiteAlterarCndPag and
    fCfgSis('CNDDES', varBoolean);
end;

procedure TfrmFatDesmembrarPedido.cxgItensDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsDados Do
  Begin

    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (AViewInfo.GridRecord.Values[cxgItensDadosQTDITE.Index] <> NULL) And
       (fFormataFloat(AViewInfo.GridRecord.Values[cxgItensDadosQTDITE.Index], 2) > 0) Then
    Begin
      ACanvas.Brush.Color:= clMoneyGreen ;
      ACanvas.Font.Color := clBlack;
    End;

  End;
end;

procedure TfrmFatDesmembrarPedido.cxgItensDadosEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
Var
  strValor: String;
begin
  inherited;
  AAllow := True;

  If (Not cxgItensDadosSTATUSITEM.Visible) Or (Not fCfgSis('DPDAFP', varBoolean)) Then
    Exit;

  If (TAdiantamento.fGetTotaisAdiantamento(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                       objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                       objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString).fltValLan <= 0) Then
    Exit;


  strValor := (Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, cxgItensDadosSTATUSITEM.Index]);
  if strValor <> AGUARDANDO_SEPARACAO then
    AAllow := False;

end;

procedure TfrmFatDesmembrarPedido.cxgItensDadosEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_Return) then
    pGravaQtdeNovoDoc;
end;

procedure TfrmFatDesmembrarPedido.cxgItensDadosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pGravaQtdeNovoDoc;
end;

procedure TfrmFatDesmembrarPedido.cxgItensEnter(Sender: TObject);
begin
  inherited;
  cdsDados.FieldByName('ITE_QTDITE').FocusControl;
end;

procedure TfrmFatDesmembrarPedido.cxgItensExit(Sender: TObject);
begin
  inherited;
  pGravaQtdeNovoDoc;
end;

procedure TfrmFatDesmembrarPedido.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strEspDoc : String;
    arrDoc    : TConsultasArray;
    objfrmPnl : TPanelCxPedOrc;
    qryFatGor : TUniQuery;
begin
  Try
    inherited;

    strEspDoc := 'OR';

    If fEntraCons(Key) Then
    Begin
      If blnUsarClienteFilialParaNovoPedido Then
        strEspDoc := 'PD'
      Else If (fMensagem('', 'Escolha: ', ['&Orçamento', '&Pedido']) = 2) Then
        strEspDoc := 'PD'
      Else
        strEspDoc := 'OR';

      objfrmPnl  := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, strEspDoc);

      qryFatGor := fCriarQuery('SELECT * FROM FATGOR F ' +
                               'LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ' +
                               'LEFT JOIN SERGOR S ON S.FGO_SEQFGO = F.AUTOINCREM ' +
                               'WHERE FALSE', Self);

      If fPesqPedOrc(conPedCompleta, Self, strEspDoc, strEspDoc, VS_strCodEmp ,edtNumDoc, edtEspDoc, edtCodEmp, qryFatGor, Key, arrDoc, True, objfrmPnl, '') Then
      Begin
        pCriarModuloLegenda;

        edtNumDoc.Text := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
        edtEspDoc.Text := qryFatGor.FieldByName('FGO_ESPDOC').AsString;

        fValidaCampos(edtEspDoc);
      End;

      FreeAndNil(qryFatGor);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatDesmembrarPedido.edtNumDocKeyPress]');
  End;
end;

function TfrmFatDesmembrarPedido.fFinanceiroPermiteDesmembramento: Boolean;
begin
  Result := True;

  If (Not fEmptyStr(edtNumDoc.Text)) And (SameText(edtEspDoc.Text, 'PD')) And
          (TFatVenda.fTotalDuplicataQuitada(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                            objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Não é permitido alterar um pedido que possua contas a receber quitado!', ['&OK']);
  End

  Else If (Not fEmptyStr(edtNumDoc.Text)) And (SameText(edtEspDoc.Text, 'PD')) And (Not fCfgSis('DPDAFP', varBoolean)) And
          (TAdiantamento.fGetTotaisAdiantamento(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString).fltValLan > 0) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Não é permitido desmembrar um pedido que possua adiantamento de cliente!', ['&OK']);
  End

  Else If (SameText(edtEspDoc.Text, 'PD')) And
          (Not fEmptyStr(edtNumDoc.Text))  And
          (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
                          objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                          objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                          objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                          objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Não é permitido desmembrar um pedido ' +
                          'com boleto de adiantamento '+
                          'que ainda não foi baixado pela '+
                          'remessa bancária!', ['&OK']);
  End;
end;

procedure TfrmFatDesmembrarPedido.pAcertaMensagem(strNumDocNovoA, strEspDocNovoA, strNumDocNovoB, strEspDocNovoB: String);
  Var
    blnTransacaoLocal : Boolean;
    strMen001,
    strMen002,
    strDocOri,
    strNumOrigem,
    strEspOrigem,
    strEmpOrigem,
    strSQLSet: String;
    objOcoCrm: TAtuOcoCrm;
    qryGen: TUniQuery;

   procedure pExecutaUpdate(strNumDoc, strEspDoc: String);
   begin
     strMen001 := fCampoTabela('FGO_MEN001', 'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'], [strNumDoc, strEspDoc, VS_strCodEmp]);
     strMen002 := fCampoTabela('FGO_MEN002', 'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'], [strNumDoc, strEspDoc, VS_strCodEmp]);

     If Length(strMen001+IIF(fEmptyStr(strMen001),'',' ')+strMen001+strDocOri) <= 80 Then
     begin
       strSQLSet := 'FGO_MEN001 = '+ QuotedStr(strMen001+IIF(fEmptyStr(strMen001),'',' ')+strDocOri);
     end
     Else
     Begin
       strSQLSet := 'FGO_MEN002 = '+ QuotedStr(strMen002+IIF(fEmptyStr(strMen002),'',' ')+strDocOri);
     End;

     untFuncoesSimples.fExecutaSQL(' UPDATE FATGOR ' +
                                   '    SET ' + strSQLSet +
                                   ' WHERE FGO_NUMDOC = ' + QuotedStr(strNumDoc) +
                                   '   AND FGO_ESPDOC = ' + QuotedStr(strEspDoc) +
                                   '   AND FGO_CODEMP = ' + QuotedStr(VS_strCodEmp));
   end;

begin
  blnTransacaoLocal := False;
  objOcoCrm := TAtuOcoCrm.Create(Nil);
  qryGen := fCriaQuery(Nil);
  Try
    Try
      If Not fInTransaction() Then
      Begin
        fStartTransaction();
        blnTransacaoLocal := True;
      End;

      qryGen.Close;
      qryGen.SQL.Text := ' SELECT FGO_NUMORI, FGO_ESPORI, FGO_EMPORI '+
                         '  FROM FATGOR INNER JOIN EXTGOR ON FGO_SEQFGO=AUTOINCREM '+
                         ' WHERE FGO_NUMDOC = :NUMDOC '+
                         '   AND FGO_ESPDOC = :ESPDOC '+
                         '   AND FGO_CODEMP = :CODEMP ';
      qryGen.ParamByName('NUMDOC').AsString := strNumDocNovoA;
      qryGen.ParamByName('ESPDOC').AsString := strEspDocNovoA;
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.Open;

      If Not qryGen.IsEmpty Then
      Begin
        strNumOrigem := qryGen.FieldByName('FGO_NUMORI').AsString;
        strEspOrigem := qryGen.FieldByName('FGO_ESPORI').AsString;
        strEmpOrigem := qryGen.FieldByName('FGO_EMPORI').AsString;

        strDocOri := Concat('PED.ORI.:',strNumOrigem,'-',strEspOrigem,'-',strEmpOrigem);

        pExecutaUpdate(strNumDocNovoA, strEspDocNovoA);
        pExecutaUpdate(strNumDocNovoB, strEspDocNovoB);

        If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
        Begin
          objOcoCrm := fAtualizaInformacoesCRM(strNumOrigem,
                                               strEspOrigem,
                                               strEmpOrigem,
                                               edtCodCli.Text,
                                               strNumOrigem,
                                               strEspOrigem,
                                               strLoginUsuarioLogado,
                                               afcNenhum);

          objOcoCrm.strCodOco := fRetornaCodigoOcorrencia(objOcoCrm.strNumOrc,objOcoCrm.strEspOrc,objOcoCrm.strCodCli,objOcoCrm.strCodEmp,'');
          objOcoCrm.strNomFrm := Self.Name;
          If Not fEmptyStr(objOcoCrm.strCodOco) Then
          Begin
            objOcoCrm.strDtaInc := VS_Date;
            objOcoCrm.strHorInc := fRetHoraServidor();
            objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
            objOcoCrm.strHorAge := objOcoCrm.strHorInc;
            objOcoCrm.strOpeHis := strLoginUsuarioLogado;
            objOcoCrm.strDtaCon := VS_Date;
            objOcoCrm.strHorCon := fNow;
            objOcoCrm.strDescri := 'FINALIZANDO OCORRÊNCIA.' + '<<csq>><<csq>>' +
                                   'Pedido do regime especial desmembrado em: '+strNumDocNovoA+'-'+strEspDocNovoA+'-'+VS_strCodEmp + ' e ' +
                                   strNumDocNovoB+'-'+strEspDocNovoB+'-'+VS_strCodEmp + ' para fins de expedição. ' + '<<csq>><<csq>>' +
                                   'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                    DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

            If (Not fEmptyStr(objOcoCrm.strCodOco)) Then
            Begin
              objOcoCrm.pInsereHistoricoOcorrencia;
              objOcoCrm.pAtualizaOcorrencia;
            End;
          End;
        End;
      End;

      If blnTransacaoLocal Then
        fCommit();
    Except
      If blnTransacaoLocal Then
        fRollBack();

      Raise;
    End;
  Finally
    FreeAndNil(objOcoCrm);
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatDesmembrarPedido.pAcertaNumeroPedidoItensRequisicaoCompra(strNumDocNovo: String);
  Var
    blnCommit: Boolean;
    strCodigo: String;
    strAutInc: String;
    qryMovRcg: TUniQuery;
    qryMovRcd: TUniQuery;

  function fLocateItemMovRcd(strCodIte: String): Boolean;
  begin
    Result := False;
    qryMovRcd.First;
    While Not qryMovRcd.Eof Do
    Begin
      If (qryMovRcd.FieldByName('RCD_CODITE').AsString = strCodIte) And
         (qryMovRcd.FieldByName('RCD_DOCPDV').AsString <> strNumDocNovo) Then
      Begin
        Result := True;
        Break;
      End;
      qryMovRcd.Next;
    End;
  end;

  procedure pAtualizaSequencialRequisicaoNovoPedido;
  begin
    untFuncoesSimples.fExecutaSQL(' UPDATE FATGOR ' +
                                  '   INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                                  ' SET FGO_INRQCP = ' + QuotedStr(strAutInc) +
                                  ' WHERE FGO_NUMDOC = ' + QuotedStr(strNumDocNovo) +
                                  '   AND FGO_ESPDOC = ' + QuotedStr(edtEspDoc.Text) +
                                  '   AND FGO_CODEMP = ' + QuotedStr(edtCodEmp.Text) );
  end;

  procedure pIncluirNovaRequisicaoCompra;
    Var
      intField : Integer;
      arrValues: Array Of Variant;
  begin
    strCodigo := fAtualizaProCod('MOVRCG', 'RCG_CODIGO');
    strAutInc := fRetAutoIncrem('MOVRCG', VS_strCodEmp);

    SetLength(arrValues, qryMovRcg.Fields.Count);

    For intField := 0 To qryMovRcg.Fields.Count -1 Do
      arrValues[intField] := qryMovRcg.Fields[intField].Value;

    qryMovRcg.Append;

    For intField := 0 To qryMovRcg.Fields.Count -1 Do
      qryMovRcg.Fields[intField].Value := arrValues[intField];

    qryMovRcg.FieldByName('RCG_CODIGO').AsString := strCodigo;
    qryMovRcg.FieldByName('AUTOINCREM').AsString := strAutInc;

    qryMovRcg.Post;

    pAtualizaSequencialRequisicaoNovoPedido;
  end;

  procedure pCarregarRequisicaoCompraOriginal;
  begin
    qryMovRcg.SQL.Text := ' SELECT * FROM MOVRCG WHERE RCG_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                          ' AND RCG_CODIGO = ' + QuotedStr(strCodigo);
    qryMovRcg.Open;
  end;

  procedure pcarregarItensRequisicaoCompraOriginal;
  begin
    qryMovRcd.SQL.Text := ' SELECT * FROM MOVRCD WHERE RCD_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                          ' AND RCD_CODIGO = ' + QuotedStr(strCodigo);
    qryMovRcd.Open;
  end;

  procedure pAlterarRequisicaoCompraDoItem;
  begin
    qryMovRcd.Edit;
    qryMovRcd.FieldByName('RCD_CODIGO').AsString := strCodigo;
    qryMovRcd.FieldByName('RCD_DOCPDV').AsString := strNumDocNovo;
    qryMovRcd.Post;
  end;

  procedure pDesmembrarRequisicaoCompraDoItem;
    Var
      intField : Integer;
      arrValues: Array Of Variant;
  begin
    SetLength(arrValues, qryMovRcd.Fields.Count);

    For intField := 0 To qryMovRcd.Fields.Count -1 Do
      arrValues[intField] := qryMovRcd.Fields[intField].Value;

    qryMovRcd.Edit;

    qryMovRcd.FieldByName('RCD_QTDITE').AsFloat :=
      qryMovRcd.FieldByName('RCD_QTDITE').AsFloat -
       cdsDados.FieldByName('ITE_QTDITE').AsFloat;

    qryMovRcd.Post;

    qryMovRcd.Append;

    For intField := 0 To qryMovRcd.Fields.Count -1 Do
      qryMovRcd.Fields[intField].Value := arrValues[intField];

    qryMovRcd.FieldByName('RCD_CODIGO').AsString := strCodigo;
    qryMovRcd.FieldByName('RCD_DOCPDV').AsString := strNumDocNovo;
    qryMovRcd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVRCD', VS_strCodEmp);
    qryMovRcd.FieldByName('RCD_QTDITE').AsFloat  := cdsDados.FieldByName('ITE_QTDITE').AsFloat;

    qryMovRcd.Post;
  end;

begin
  If fEmptystr(strInRqCp) Then
    Exit;

  blnCommit := False;

  strCodigo := fCampoTabela('RCG_CODIGO', 'MOVRCG', ['AUTOINCREM'], [strInRqCp]);

  qryMovRcg := fCriaQuery(Nil);
  qryMovRcd := fCriaQuery(Nil);

  fStartTransaction;

  Try
    pCarregarRequisicaoCompraOriginal;
    pcarregarItensRequisicaoCompraOriginal;

    strCodigo := '';

    cdsDados.First;

    While Not cdsDados.Eof Do
    Begin
      If Not fTravaDesmembramento Then
      Begin
        cdsDados.Next;
        Continue;
      End;

      If (cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0) And
         (fLocateItemMovRcd(cdsDados.FieldByName('ITE_CODITE').AsString)) Then
      Begin
        If fEmptyStr(strCodigo) Then
          pIncluirNovaRequisicaoCompra;

        If cdsDados.FieldByName('ITE_QTDITE').AsFloat >= qryMovRcd.FieldByName('RCD_QTDITE').AsFloat Then
          pAlterarRequisicaoCompraDoItem
        Else
          pDesmembrarRequisicaoCompraDoItem;
      End;
      cdsDados.Next;
    End;

    cdsDados.First;

    blnCommit := fCommit;
  Finally
    If Not blnCommit Then
      fRollBack;

    FreeAndNil(qryMovRcg);
    FreeAndNil(qryMovRcd);
  End;

end;

procedure TfrmFatDesmembrarPedido.pAcertarQuantidadeDocNovo;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsVenda.Locate('ITE_SEQDET', cdsDados.FieldByName('ITE_SEQDET').AsString, []) Then
      Begin
        If cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0 Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_QTDITE').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat;

          //Ajusta embalagem tinta automotiva
          If (cdsVenda.FieldByName('ITE_IDEPRO').AsString <> 'NOR') Then
          Begin
            If Not fTintaBaixaProduto(cdsVenda.FieldByName('ITE_IDEPRO').AsString) Then
              If (cdsVenda.FieldByName('ITE_QTDEMB').AsFloat > 0) Then
                cdsVenda.FieldByName('ITE_QTDEMB').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat;
          End;

          If (Length(arrIteExpPed) > 0) Then
            cdsVenda.FieldByName('ITE_QTDEXP').AsFloat := 0;

          If (blnRetirarNovoPedidoDoRegimeEspecial) Then
            cdsVenda.FieldByName('ITE_REGESP').AsString := 'N';

          cdsVenda.Post;
        End
        Else
          cdsVenda.Delete;
      End;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

procedure TfrmFatDesmembrarPedido.pAcertarQuantidadeDocOriginal;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsVenda.Locate('ITE_SEQDET', cdsDados.FieldByName('ITE_SEQDET').AsString, []) Then
      Begin
        If cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0 Then
        Begin
          If fFormataFloat(cdsDados.FieldByName('ITE_QTDORI').AsFloat, fCfgSis('DECQTD', varInteger)) =
             fFormataFloat(cdsDados.FieldByName('ITE_QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) Then
          Begin
            cdsVenda.Delete;
          End
          Else
          Begin
            cdsVenda.Edit;
            cdsVenda.FieldByName('ITE_QTDITE').AsFloat := cdsDados.FieldByName('ITE_QTDORI').AsFloat -
                                                          cdsDados.FieldByName('ITE_QTDITE').AsFloat;

            //Ajusta embalagem tinta automotiva
            If (cdsVenda.FieldByName('ITE_IDEPRO').AsString <> 'NOR') Then
            Begin
              If Not fTintaBaixaProduto(cdsVenda.FieldByName('ITE_IDEPRO').AsString) Then
                If (cdsVenda.FieldByName('ITE_QTDEMB').AsFloat > 0) Then
                  cdsVenda.FieldByName('ITE_QTDEMB').AsFloat := cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
            End;

            cdsVenda.Post;
          End;
        End;
      End;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

procedure TfrmFatDesmembrarPedido.pAddColunasGrid;
var
  strEmpresa: String;

  procedure pAddColuna(const strFieldName, strCaption: String);
  begin
    cxgItensDados.CreateColumn;
    cxgItensDados.Columns[cxgItensDados.ColumnCount - 1].DataBinding.FieldName := strFieldName;
    cxgItensDados.Columns[cxgItensDados.ColumnCount - 1].HeaderAlignmentHorz := taRightJustify;
    cxgItensDados.Columns[cxgItensDados.ColumnCount - 1].Caption := strCaption;
    cxgItensDados.Columns[cxgItensDados.ColumnCount - 1].Options.Editing := False;
    cxgItensDados.Columns[cxgItensDados.ColumnCount - 1].Options.Filtering := False;
  end;

begin
  If (Not fCfgSis('EXISAL', varBoolean)) Then
    Exit;

  cxgItensDados.BeginUpdate();
  try
    If (Not Assigned(cxgItensDados.GetColumnByFieldName('ESTLOJ'))) Then
    Begin
      pAddColuna('ESTLOJ', 'Qtde Loja');
      pAddColuna('ESTFIL', 'Qtde Filiais');

      If Assigned(objAltDoc.stlEmpresas) Then
      Begin
        For strEmpresa In objAltDoc.stlEmpresas Do
          pAddColuna('EST_EMP_' + LeftStr(strEmpresa, 3), Copy(strEmpresa, 5, 5));
      End;
    End;
  finally
    cxgItensDados.EndUpdate();
  end;
end;

procedure TfrmFatDesmembrarPedido.pAdicionarItensReservarSemEstoque;
  Var
    intIndex: Integer;
    intAutInc: Integer;
    fltSaldoDisponivel: Double;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0 Then
      Begin
        fltSaldoDisponivel := fRetornaSaldoDisponivel(cdsDados.FieldByName('ITE_CODITE').AsString, False, True, EmptyStr, True, VS_strCodEmp, EmptyStr);

        If fltSaldoDisponivel > 0 Then
        Begin
          If TAggregateField(cdsVenda.FieldByName('MAX_AUTINC')).Value = Null Then
            intAutInc := 1
          Else
            intAutInc := TAggregateField(cdsVenda.FieldByName('MAX_AUTINC')).Value + 1;

          cdsVenda.Append;

          For intIndex := 0 To cdsDados.Fields.Count - 1 Do
            cdsVenda.Fields[intIndex].Value := cdsDados.Fields[intIndex].Value;

          cdsVenda.FieldByName('ITE_QTDITE').AsFloat   := fltSaldoDisponivel;
          cdsVenda.FieldByName('AUTOINCREM').AsInteger := intAutInc;
          cdsVenda.FieldByName('ITE_SEQDET').AsString  := '';
          cdsVenda.FieldByName('ITE_SEQIND').AsInteger := -1;
          cdsVenda.FieldByName('ITE_QTDBAI').AsFloat   := 0;
          cdsVenda.FieldByName('ITE_QTDORI').AsFloat   := 0;
          cdsVenda.FieldByName('ITE_NUMORC').AsString  := '';
          cdsVenda.FieldByName('ITE_ESPORC').AsString  := '';
          cdsVenda.FieldByName('ITE_EMPORC').AsString  := '';

          cdsVenda.Post;
        End;
      End;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

procedure TfrmFatDesmembrarPedido.pAfterInsert(DataSet: TDataSet);
begin
  If (cdsDados.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatDesmembrarPedido.pAfterOpen(DataSet: TDataSet);
  Var
    strEmpresa: String;
begin
  With DataSet Do
  Begin
    If FindField('ITE_TOTITE') <> nil Then
      TFloatField(FieldByName('ITE_TOTITE')).DisplayFormat := fMskDigitos(2);

    If FindField('ITE_TOTTMP') <> nil Then
      TFloatField(FieldByName('ITE_TOTTMP')).DisplayFormat := fMskDigitos(2);

    If FindField('ITE_UNITAR') <> nil Then
      TFloatField(FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

    If FindField('ITE_UNITMP') <> nil Then
      TFloatField(FieldByName('ITE_UNITMP')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

    If FindField('ITE_QTDITE') <> nil Then
      TFloatField(FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If FindField('ITE_QTDORI') <> nil Then
      TFloatField(FieldByName('ITE_QTDORI')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If FindField('ITE_QTDBAI') <> nil Then
      TFloatField(FieldByName('ITE_QTDBAI')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If FindField('ITE_QTDPEN') <> nil Then
      TFloatField(FieldByName('ITE_QTDPEN')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If FindField('ITE_QTDREC') <> nil Then
      TFloatField(FieldByName('ITE_QTDREC')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If FindField('ITE_QTORI2') <> nil Then
      TFloatField(FieldByName('ITE_QTORI2')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If FindField('ITE_QTDATE') <> nil Then
      TFloatField(FieldByName('ITE_QTDATE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If fCfgSis('EXISAL', varBoolean) Then
    Begin
      If Assigned(FindField('ESTLOJ')) Then
        TFloatField(FieldByName('ESTLOJ')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));

      If Assigned(FindField('ESTFIL')) Then
        TFloatField(FieldByName('ESTFIL')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));

      If Assigned(objAltDoc.stlEmpresas) Then
      Begin
        For strEmpresa In objAltDoc.stlEmpresas Do
        Begin
          If Assigned(FindField('EST_EMP_' + LeftStr(strEmpresa, 3))) Then
            TFloatField(FieldByName('EST_EMP_' + LeftStr(strEmpresa, 3))).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));
        End;
      End;
    End;
  End;
end;

procedure TfrmFatDesmembrarPedido.pAfterPost(DataSet: TDataSet);
begin


  If (Not blnValidandoAfterPost) And (FItensComRequisicaoCompra.IndexOf(DataSet.FieldByName('ITE_CODITE').AsString) > -1 ) And (fTravaDesmembramento) Then
  Begin
    blnValidandoAfterPost := True;
    if not fCfgSis('PDOPRC', varBoolean) then
    begin
      fMensagem('ATENÇÃO!', 'Não é possível alterar este produto pois ele tem requisição de compra gerada!', ['&Ok']);
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_QTDITE').AsFloat := 0;
      cdsDados.Post;
    end
    else if (Not fPermiteDesmembrarReqCompra) then
    begin
      fMensagem('ATENÇÃO!', 'Não é possível alterar este produto pois a quantidade informada é superior a quantidade que não está em requisição de compra!', ['&Ok']);
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_QTDITE').AsFloat := 0;
      cdsDados.Post;
    end;
    blnValidandoAfterPost := False;
  End;

  If Not cdsDados.ControlsDisabled Then
    pAtualizarLabelQtdProd;
end;

procedure TfrmFatDesmembrarPedido.pAtualizaCdsDados;
begin
  cdsDados.DisableControls;
  cdsDados.BeforePost := Nil;

  try
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      cdsDados.Edit;
      pAtualizarValorProdutos;
      pRetQuantidadePendenteFaturado;
      pZerarQuantidadeProdutos;
      pRetornaStatusItem;
      cdsDados.Post;
      cdsDados.Next;
    end;

    pConfiguraIconesProdutos(cxgItensDados);
  finally
    cdsDados.First;
    cdsDados.BeforePost := pBeforePost;
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  end;
end;

procedure TfrmFatDesmembrarPedido.pAtualizaDadosDocumento;
var
  intIndex: Integer;
  intIndexSel: Integer;
begin
  cmbOpcFinalizacao.Enabled := True;

  With objAltDoc.objVenda, objAltDoc.qryFatGor Do
  Begin
    intIndexSel := cmbOpcFinalizacao.ItemIndex;
    intIndex := cmbOpcFinalizacao.Items.IndexOf(OPC_FIN_NOVO_PEDIDO);
    if (strEspDoc = 'OR') and (intIndex > -1) then
    begin
      cmbOpcFinalizacao.Items[intIndex] := OPC_FIN_NOVO_ORCAMENTO;
      cmbOpcFinalizacao.ItemIndex := intIndexSel;
    end;

    intIndexSel := cmbOpcFinalizacao.ItemIndex;
    intIndex := cmbOpcFinalizacao.Items.IndexOf(OPC_FIN_NOVO_ORCAMENTO);
    if (strEspDoc <> 'OR') and (intIndex > -1) then
    begin
      cmbOpcFinalizacao.Items[intIndex] := OPC_FIN_NOVO_PEDIDO;
      cmbOpcFinalizacao.ItemIndex := intIndexSel;
    end;

    If (strEspDoc = 'PD') And (fCfgSis('DPDAFP', varBoolean)) And
       (TAdiantamento.fGetTotaisAdiantamento(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                             objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                             objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString).fltValLan > 0) Then
    Begin
      cmbOpcFinalizacao.ItemIndex := cmbOpcFinalizacao.Items.IndexOf(OPC_FIN_NOVO_PEDIDO);
      cmbOpcFinalizacao.Enabled := False;
      lblReqCompra.Caption := 'Pedido possui adiantamento e portanto só é permitido gerar novo pedido.';
      lblReqCompra.Visible := True;
    End;

    edtCodCli.Text    := strCodCli;
    edtDesCli.Text    := strCliNom;
    edtCodCndAtu.Text := strCodCnd;
    mskCndPagAtu.Text := strConPag;
    edtDesCndAtu.Text := strDesCnd;
    edtForPagAtu.Text := strCodFpg;
    edtDesFpgAtu.Text := strDesFpg;
    edtCodVen.Text    := strCodVen + ' - ' + strNomVen;

    edtDtaEnt.Text := FormatDateTime('DD/MM/YYYY', FieldByName('FGO_DTAENT').AsDateTime);

    edtTotPro.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTPRO').AsFloat);
    edtDesEsp.Text := FormatFloat('##,#0.00', FieldByName('FGO_DESESP').AsFloat);
    edtTotIpi.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTIPI').AsFloat);
    edtTotRet.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTRET').AsFloat);
    edtDesAce.Text := FormatFloat('##,#0.00', FieldByName('FGO_DESACE').AsFloat);
    edtTotFre.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTFRE').AsFloat);
    edtTotCBS.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTCBS').AsFloat);
    edtTotIBS.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOTIBS').AsFloat);
    edtTotIS.Text := FormatFloat('##,#0.00', FieldByName('FGO_TOT_IS').AsFloat);
    lblTotCBS.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
    edtTotCBS.Visible := lblTotCBS.Visible;
    lblTotIBS.Visible := lblTotCBS.Visible;
    edtTotIBS.Visible := lblTotCBS.Visible;
    lblTotIS.Visible := lblTotCBS.Visible;
    edtTotIS.Visible := lblTotCBS.Visible;
    edtVlrCon.Text := FormatFloat('##,#0.00', FieldByName('FGO_VLRCON').AsFloat);

    pCloneDataSet(cdsDados, cdsVenda);

    pMontaMensagensPedido;

    {Req.: 103458 - Calcula saldo disponível}
    Try
      pCriarFormularios(TfrmGravando, frmGravando);

      frmGravando.lblGravando.Caption := 'Aguarde calculando saldo disponível';
      frmGravando.fExecutarAcao := fCalcularSalDis;
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;

    pProcessaClientInfAdcItem;

    TfrmGravando.fExecutarModal(pAtualizaCdsDados, 'Aguarde, Carregando Itens...', '');

    pnlItens.Enabled  := True;
    pnlBusca.Enabled  := False;
    btnConfirma.Enabled := True;

    If (Length(arrIteExpPed) = 0) Then
      btnCopiarQtd.Enabled := True;

    pVerificaRequisicaoCompra;

    cmbOpcFinalizacaoChange(cmbOpcFinalizacao);
    btnAltCndPag.Enabled := True;

    FblnAlterouCndPag := False;

    if not blnVendaPerdidaAutomatica then
    begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      pSetFocus(cxgItens);
    end;

    TCdsVinculosRequisicoes.pCarregarClientDataSet(FieldByName('FGO_NUMDOC').AsString,
                                                   FieldByName('FGO_ESPDOC').AsString,
                                                   FieldByName('FGO_CODCLI').AsString);

    {If fCfgSis('DPDAFP', varBoolean) Then
    Begin
      cdsDados.Filtered := False;
      cdsDados.Filter := 'ITE_JAFATU = False';
      cdsDados.Filtered := True;
    End;}
  End;
end;

procedure TfrmFatDesmembrarPedido.pMontaMensagensPedido;
begin
  memMensagens.Clear;
  If (Not objAltDoc.qryFatGor.FieldByName('FGO_MEN001').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('FGO_MEN001').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('FGO_MEN002').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('FGO_MEN002').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('AUX_MEN003').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('AUX_MEN003').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('AUX_MEN004').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('AUX_MEN004').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('AUX_MEN005').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('AUX_MEN005').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('FGO_MENEXP').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('FGO_MENEXP').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('FGO_MENEX2').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('FGO_MENEX2').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('FGO_MENEX3').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('FGO_MENEX3').AsString);

  If (Not objAltDoc.qryFatGor.FieldByName('FGO_MENEX4').AsString.IsEmpty) Then
    memMensagens.Lines.Add(objAltDoc.qryFatGor.FieldByName('FGO_MENEX4').AsString);

end;


procedure TfrmFatDesmembrarPedido.pAtualizarLabelQtdProd;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TuniClientDataSet.Create(nil);

  cdsTmp.Data := cdsDados.Data;
  cdsTmp.Filter := 'ITE_QTDITE > 0';
  cdsTmp.Filtered := True;

  lblQtdProd.Caption := 'Qtde Prod. Doc. Orig.: ' + cdsDados.RecordCount.ToString + ' / ' +
                        'Qtde Prod. Doc. Novo: '  + cdsTmp.RecordCount.ToString;

  FreeAndNil(cdsTmp);
end;

procedure TfrmFatDesmembrarPedido.pAtualizarValorProdutos;
begin
  If cdsInfAdcItem.FindKey([cdsDados.FieldByName('ITE_SEQDET').AsString]) Then
  Begin
    cdsDados.FieldByName('ITE_TOTITE').AsFloat := cdsInfAdcItem.FieldByName('ITE_TOTITE').AsFloat -
                                                  cdsInfAdcItem.FieldByName('ITE_DESESP').AsFloat;

    cdsDados.FieldByName('ITE_UNITAR').AsFloat := cdsDados.FieldByName('ITE_TOTITE').AsFloat /
                                                  cdsDados.FieldByName('ITE_QTDORI').AsFloat;

  End;
end;

function TfrmFatDesmembrarPedido.fCalcularSalDis(pgbStatus: TcxProgressBar = NIL) : Boolean;
var
  fltSaldos,
  fltSalDis,
  fltSalDisLibCom : Real;
  strNumLot : String;

  function fCodEmp : String;
  Begin
    If Not fEmptyStr(cdsDados.FieldByName('ITE_EMPITE').AsString) Then
      Result := cdsDados.FieldByName('ITE_EMPITE').AsString
    Else
    If Not fEmptyStr(cdsDados.FieldByName('ITE_CODEMP').AsString) Then
      Result := cdsDados.FieldByName('ITE_CODEMP').AsString
    Else
      Result := VS_strCodEmp;
  End;

Begin

  Result := True;

  Try

    cdsDados.BeforePost := nil;
    cdsDados.First;

    Try

      cdsDados.DisableControls;

      While Not cdsDados.Eof Do
      Begin

        cdsDados.Edit;

        strNumLot := IIF(fEhEmissaoDocumentoWMS(fCodEmp) Or
                         fEmpresaParaFaturamentoUsaWMS(fCodEmp),
                         IIF(cdsDados.FieldByName('ITE_NUMLOT').AsString = 'A DEFINIR', '',
                         cdsDados.FieldByName('ITE_NUMLOT').AsString),
                         cdsDados.FieldByName('ITE_NUMLOT').AsString);

        fltSaldos := fRetSaldosEmpresa(cdsDados.FieldByName('ITE_CODITE').AsString,
                                       fCodEmp,
                                       strNumLot,
                                       False);

        fltSalDis := fRetornaSaldoDisponivel(cdsDados.FieldByName('ITE_CODITE').AsString,
                                             False,
                                             True,
                                             strNumLot,
                                             True,
                                             fCodEmp);

        fltSalDisLibCom := fRetornaSaldoFisico(cdsDados.FieldByName('ITE_CODITE').AsString,
                                               True,
                                               strNumLot,
                                               fCodEmp) -
                           fRetornaSaldoLibCom(cdsDados.FieldByName('ITE_CODITE').AsString,
                                               strNumLot,
                                               fCodEmp);

        cdsDados.FieldByName('ITE_SALDOS').AsFloat := fltSaldos;
        cdsDados.FieldByName('ITE_SALDIS').AsFloat := fltSalDis;
        cdsDados.FieldByName('ITE_SALDISLIBCOM').AsFloat := fltSalDisLibCom;

        cdsDados.Post;

        cdsDados.Next;

      End;

      TFloatField(cdsDados.FieldByName('ITE_SALDOS')).DisplayFormat := '##,#0.000';
      TFloatField(cdsDados.FieldByName('ITE_SALDIS')).DisplayFormat := '##,#0.000';
      TFloatField(cdsDados.FieldByName('ITE_SALDISLIBCOM')).DisplayFormat := '##,#0.000';

      cdsDados.BeforePost := pBeforePost;

    Finally
      cdsDados.EnableControls;
    End;

  Except
    Result := False;
  End;

End;

function TfrmFatDesmembrarPedido.fCarregarDocumento: Boolean;
begin
  objAltDoc.strNumPed := edtNumDoc.Text;
  objAltDoc.strEspPed := edtEspDoc.Text;
  objAltDoc.strEmpPed := edtCodEmp.Text;

  objAltDoc.blnValidarMargemValorCndPagto := fCfgSis('DOMKUP', VarBoolean);

  objAltDoc.blnTelaDesmembramento := True;
  if ((blnExpedicao) and (fCfgSis('DESPVE', varString) = '1')) then
  begin
    objAltDoc.blnDesmembramentoExpedicao := True;
  end;

  objAltDoc.blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada := fCfgSis('DPDAFP', varBoolean);

  objAltDoc.blnExpedicaoPedidoBaixaEntregaFutura := (blnExpedicao) And (fPedidoBaixaEntregaFutura(objAltDoc.strNumPed,
                                                                                                  objAltDoc.strEspPed,
                                                                                                  objAltDoc.strEmpPed));
  Result := objAltDoc.fCarregarPedido;

  strInRqCp := objAltDoc.objVenda.strInRqCp;

  If Result Then
  Begin
    if (fCfgSis('DESPVE', varString) = '2') then
    begin
      objAltDoc.objVenda.blnManLib    := True;
    end;

    pAtualizaDadosDocumento;

    pCloneDataSet(cdsVendaBkp, cdsVenda);
    cxgItens.Enabled := True;
  End;
end;

function TfrmFatDesmembrarPedido.fPermiteDesmembrarReqCompra: Boolean;
var
  cdsBkp: TUniClientDataSet;
  fltTotQtdIte: Double;
  fltTotQtdOri: Double;
  fltQtdRec: Double;
  strCodIte: String;
begin
  Result := False;

  if not fCfgSis('PDOPRC', varBoolean) then
    Exit;

  strCodIte := cdsDados.FieldByName('ITE_CODITE').AsString;
  fltQtdRec := cdsDados.FieldByName('ITE_QTDREC').AsFloat;

  if not fEmptyStr(fCampoTabela('LOT_NUMLOT','CADLOT',['LOT_CODITE','LOT_CODEMP'],[strCodIte, cdsDados.FieldByName('ITE_EMPITE').AsString])) then
  begin
    if cdsDados.FieldByName('ITE_QTDITE').AsFloat > (cdsDados.FieldByName('ITE_QTDORI').AsFloat - fltQtdRec) then
      Exit
    else
      Exit(True);
  end;

  cdsBkp := TUniClientDataSet.Create(Nil);

  try
    fltTotQtdIte := 0;
    fltTotQtdOri := 0;

    pCloneDataSet(cdsBkp, cdsDados);

    cdsBkp.First;

    while not cdsBkp.Eof do
    begin
      if cdsBkp.FieldByName('ITE_CODITE').AsString = strCodIte then
      begin
        fltTotQtdIte := fltTotQtdIte + cdsBkp.FieldByName('ITE_QTDITE').AsFloat;
        fltTotQtdOri := fltTotQtdOri + cdsBkp.FieldByName('ITE_QTDORI').AsFloat;
      end;

      cdsBkp.Next;
    end;

    if fltTotQtdIte > (fltTotQtdOri - fltQtdRec) then
      Exit;

    Result := True;
  finally
    FreeAndNil(cdsBkp);
  end;
end;

function TfrmFatDesmembrarPedido.fPermiteOpcaoGerarNovoPedido: Boolean;
begin
  Result := True;

  If fEmptyStr(strEmpPed) Then
    Exit;

  If (strEmpPed <> VS_strCodEmp) And (Not blnPedidoRegimeEspecial) Then
    Result := False;
end;

function TfrmFatDesmembrarPedido.fQuantidadeOriginalTodosItens: Boolean;
begin
  Try
    cdsDados.DisableControls;
    Result := True;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      Result := fFormataFloat(cdsDados.FieldByName('ITE_QTDORI').AsFloat, fCfgSis('DECQTD', varInteger)) =
                fFormataFloat(cdsDados.FieldByName('ITE_QTDITE').AsFloat, fCfgSis('DECQTD', varInteger));

      If Not Result Then
        Break;

      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

function TfrmFatDesmembrarPedido.fQuantidadeZeradaTodosItens: Boolean;
begin
  Try
    cdsDados.DisableControls;
    Result := True;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      Result := cdsDados.FieldByName('ITE_QTDITE').AsFloat = 0;

      If Not Result Then
        Break;

      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

function TfrmFatDesmembrarPedido.fRetornaOrigemDesmembramento: String;
begin
  Result := EmptyStr;

  if blnExpedicao then
    Exit('EXPEDIÇÃO');

  if blnDesmembrarOrcamentoPedido then
    Exit('DESMEMBRAMENTO DE ORÇAMENTO / PEDIDO');

  if blnCRM then
    Exit('CRM - DESMEMBRAMENTO');

  if blnLiberacaoPedido then
    Exit('LIBERAÇÃO DE PEDIDO');
end;

function TfrmFatDesmembrarPedido.fTemItemEspecialOrcamento(strNumDoc,
  strCodEmp: String): Boolean;
begin
  Result := fCampoTabela('SUM(LOCATE("ITEM ESPECIAL", ITE_DESITE))',
    'FATDOR INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE',
    ['FDO_NUMDOC','FDO_ESPDOC','FDO_CODEMP'],
    [strNumDoc, 'OR', strCodEmp]) > 0;
end;

function TfrmFatDesmembrarPedido.fTravaDesmembramento: Boolean;
begin
  Result := True;

  if not cdsDados.Active then
    Exit;

  if cdsDados.RecordCount <= 0 then
    Exit;

  if cdsDados.RecNo <= 0 then
    Exit;

  if not fCfgSis('DPDAFP', varBoolean) then
    Exit;

  if cdsDados.FieldByName('STATUSITEM').AsString <> AGUARDANDO_SEPARACAO then
    Exit;

  Result := False;
end;

procedure TfrmFatDesmembrarPedido.pBeforePost(DataSet: TDataSet);
  Var
    fltValor,
    fltMltVen : Double;

    blnResult : Boolean;

  function fDesconsideraMultiploVenda(strCodBarEmb: String): Boolean;
  begin
    Result := ((Not fEmptyStr(strCodBarEmb)) and (fCfgSis('QPDMVC') = '2'))
           Or (fOpcaoFinalizacao <> ofNovoPedido)
           Or (blnOnShow And blnExpedicao);
  End;

  function fPedeSenhaMultiploVenda: Boolean;
    Var
      objLiberacao  : TLiberacao;
  begin
    objLiberacao := TLiberacao.create;
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Item ' + DataSet.FieldByName('ITE_CODITE').AsString + ' - ' +  LeftStr(DataSet.FieldByName('ITE_DESITE').AsString,50) + ' com quantidade fora do Múltiplo de Vendas.');
      objLiberacao.objMsgLibera.pAddTexto('Múltiplo de Venda: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3));
      objLiberacao.objMsgLibera.pAddTexto('Quantidade de Venda Digitada: ' + FloatToStrF(DataSet.FieldByName('ITE_QTDITE').AsFloat, ffNumber, 12, 3));

      objLiberacao.strDirAce := 'SENMTP';
      objLiberacao.strSenLib := fCfgSis('SENMTP');
      objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
      objLiberacao.strCodOpe := objAltDoc.objVenda.strCodVen;
      objLiberacao.strCodDig := objAltDoc.objVenda.strCodDig;
      objLiberacao.strCliente := objAltDoc.objVenda.strCodCli + '-' + objAltDoc.objVenda.strCliNom;
      objLiberacao.strCpfCnpj := objAltDoc.objVenda.strCliCgc;
      Result := objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  end;

begin
  pSetFocus(cxgItens);

  With DataSet Do
  Begin

    If (cxgItensDadosQTDPEN.Visible) And (FieldByName('ITE_QTDITE').AsFloat > FieldByName('ITE_QTDPEN').AsFloat) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é permitido informar uma quantidade maior que a quantidade pendente para gerar o novo documento!', ['&Ok']);
      Cancel;
      Abort;
    End;

    If (FieldByName('ITE_QTDITE').AsFloat > FieldByName('ITE_QTDORI').AsFloat) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é possível aumentar a quantidade do produto!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (fItemNaoFracionavel(edtEspDoc.Text, FieldByName('ITE_CODUNI').AsString)) And
            (Not fCfgSis('VENVID', varBoolean)) And //venda vidro
            (Not fCfgSis('VENMAD', varBoolean)) And //venda medeireira
            (Frac(fStrToFloat(FieldByName('ITE_QTDITE').AsString)) <> 0)              Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é possível informar valor fracionado para este produto!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (FieldByName('ITE_QTDITE').AsFloat < 0.00) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é permitido informar uma quantidade negativa!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (FieldByName('ITE_QTDITE').AsFloat > 0.00) Then
    Begin
      pProcessaClientInfAdcItem;

      If cdsInfAdcItem.FindKey([cdsDados.FieldByName('ITE_SEQDET').AsString]) Then
      Begin
        If (cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat > 0) And
           (Not fDesconsideraMultiploVenda(cdsInfAdcItem.FieldByName('BAR_CODBAR').AsString)) Then
        Begin
          If FieldByName('ITE_QTDITE').AsFloat < cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat Then
          Begin
            If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
            Begin
              If Not SameValue( FieldByName('ITE_QTDITE').AsFloat, FieldByName('ITE_SALDIS').AsFloat ) Then
              Begin
                fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
                If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
                  blnResult := fPedeSenhaMultiploVenda
                Else
                  blnResult := False;
                If (Not blnResult) Then
                Begin
                  {*****************************************}
                  {* TRAZ COMO SUGESTAO O PROXIMO MULTIPLO *}
                  {**************************************JC*}
                  cdsDados.FieldByName('ITE_QTDITE').AsFloat := fStrToFloat( FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, fCfgSis('DECQTD', varInteger)) )
                End;
              End;
            End
            Else If (fCfgSis('MLTVEN') = '3') Then  // Avisa
            Begin
              fMensagem('','A quantidade digitada não é múltiplo de: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
            End;
          End
          Else
          Begin
            {****************************************************************************************************************************************************}
            {* ESTOU CHAMANDO A fFormataFloatInterna, pois quando usa SAT ele utiliza a fArredondaABNT_NBR5891_77 que por sua vez gera os seguintes resultados: *}
            {* fArredondaABNT_NBR5891_77(12500, 4) = 12500                                                                                                      *}
            {* fArredondaABNT_NBR5891_77(125000, 4) = 0,0001                                                                                                    *}
            {*************************************************************************************************************************************************RN*}
            fltValor := fFormataFloatInterna(cdsDados.FieldByName('ITE_QTDITE').AsFloat / cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, 4);
            If (fltValor - Int(fltValor)) > 0 Then
            Begin
              If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
              Begin
                If Not SameValue( FieldByName('ITE_QTDITE').AsFloat, FieldByName('ITE_SALDIS').AsFloat ) Then
                Begin
                  fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
                  If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
                    blnResult := fPedeSenhaMultiploVenda
                  Else
                    blnResult := False;
                  If (Not blnResult) Then
                  Begin
                    {*****************************************}
                    {* TRAZ COMO SUGESTAO O PROXIMO MULTIPLO *}
                    {**************************************JC*}
                    fltValor  := cdsDados.FieldByName('ITE_QTDITE').AsFloat;
                    fltMltVen := cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat;
                    fltValor  := Int( ( ( fltValor + fltMltVen ) / fltMltVen ) ) * fltMltVen;

                    If (fCfgSis('MLTVEN') = '4') Then
                      cdsDados.FieldByName('ITE_QTDITE').AsFloat := fStrToFloat( FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, fCfgSis('DECQTD', varInteger)) )
                    Else
                      cdsDados.FieldByName('ITE_QTDITE').AsFloat := fStrToFloat( FloatToStrF(fltValor, ffNumber, 12, fCfgSis('DECQTD', varInteger)));
                  End;
                End;
              End
              Else If (fCfgSis('MLTVEN') = '3') Then // Avisa
              Begin
                fMensagem('','A quantidade digitada não é múltiplo de: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
              End;
            End;
          End;
        End;
      End;
    End;
  End;

  if cdsDados.FieldByName('ITE_UNITMP').AsFloat = 0 then
    cdsDados.FieldByName('ITE_UNITMP').AsFloat := cdsDados.FieldByName('ITE_UNITAR').AsFloat;

  cdsDados.FieldByName('ITE_TOTTMP').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat * cdsDados.FieldByName('ITE_UNITMP').AsFloat;
end;

procedure TfrmFatDesmembrarPedido.pCriaClientInfAdcItem;
begin
  cdsInfAdcItem := TUniClientDataSet.Create(Self);

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_SEQDET';
    DataType := ftString;
    Size := 20;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESESP';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_VALFRE';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESACE';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_TOTITE';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_MLTVEN';
    DataType := ftFloat;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAR_CODBAR';
    DataType := ftString;
  End;

  With cdsInfAdcItem.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_FRERAT';
    DataType := ftFloat;
  End;

  cdsInfAdcItem.CreateDataSet;
  cdsInfAdcItem.IndexFieldNames := 'ITE_SEQDET';
end;

procedure TfrmFatDesmembrarPedido.pLimparTela;
  Const
    TAG_NAO_LIMPAR = 1;
    TAG_VALORES = 2;
  Var
    intIdx: Integer;
begin
  If Assigned(objAltDoc) Then
    FreeAndNil(objAltDoc);

  objAltDoc := TAlterarPedido.Create(Self);

  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx].Tag <> TAG_NAO_LIMPAR Then
    Begin
      If Self.Components[intIdx] Is TEditFocus Then
        If Self.Components[intIdx].Tag = TAG_VALORES Then
          (Self.Components[intIdx] As TEditFocus).Text := '0,00'
        Else
          (Self.Components[intIdx] As TEditFocus).Clear;

      If Self.Components[intIdx] Is TMaskEditFocus Then
        (Self.Components[intIdx] As TMaskEditFocus).Clear;
    End;
  End;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'PD';

  lblQtdProd.Caption := 'Qtde Prod. Doc. Orig.: 0 / Qtde Prod. Doc. Novo: 0';

  btnConfirma.Enabled   := False;
  btnCopiarQtd.Enabled  := False;
  pnlItens.Enabled      := False;
  btnAltCndPag.Enabled  := False;
  pnlBusca.Enabled      := True;

  cmbOpcFinalizacao.Enabled := True;
  lblReqCompra.Visible := False;
  FblnAlterouCndPag := False;

  pSetFocus(edtNumDoc);
  pLimparItens;
end;

procedure TfrmFatDesmembrarPedido.pOnShow;
begin
  blnOnShow := True;
  Try
    If (Not fEmptyStr(strNumPed)) And (Not fEmptyStr(strEspPed)) And (Not fEmptyStr(strEmpPed)) Then Begin
      btnCopiarQtd.Enabled := False;

      If (Not fCarregarDocumento(strNumPed, strEspPed, strEmpPed)) Then
      Begin
        If (not blnCRM) Then
          fMensagem('ATENÇÃO!', 'Carregamento do pedido para desmembramento falhou. Operação cancelada!', ['&Ok']);

        blnDesmembrou := False;
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      End
      Else
      Begin
        If (Not blnPermiteApenasGerarRequisicaoParaItensSemEstoque) And (Not blnCRM) And (Not fCarregarQtdDesmExp()) Then
        Begin
          blnDesmembrou := False;
          PostMessage(Self.Handle, WM_CLOSE, 0, 0);
        End
        Else
        Begin
          if not blnVendaPerdidaAutomatica then
            pSetFocus(cxgItens);
        End;
      End;
    End;

    if blnLiberacaoPedido then
      fValidaCampos(edtEspDoc);

    pCarregaOpcaoFinalizacao;
  Finally
    blnOnShow := False;
  End;
end;

procedure TfrmFatDesmembrarPedido.pProcessaClientInfAdcItem;
  Var
    qryFatDor: TUniQuery;
begin
  qryFatDor := fCriaQuery(nil);

  qryFatDor.Sql.Text := 'SELECT F.FDO_DESESP, F.FDO_TOTFRE, F.FDO_DESACE, F.FDO_TOTITE, C.ITE_MLTVEN, I.BAR_CODBAR, IFNULL(E.FDO_FRERAT,0) AS FDO_FRERAT ' +
                        'FROM FATDOR F ' +
                        'LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM '+
                        'LEFT JOIN CADITE C ON C.ITE_CODITE = F.FDO_CODITE '+
                        'LEFT JOIN ITEBAR I ON I.BAR_CODITE = C.ITE_CODITE '+
                        'WHERE F.AUTOINCREM = :AUTINC ';

  cdsInfAdcItem.EmptyDataSet;

  cdsVenda.First;
  While Not cdsVenda.Eof Do
  Begin

    If Not cdsInfAdcItem.FindKey([cdsVenda.FieldByName('ITE_SEQDET').AsString]) Then
    Begin
      qryFatDor.Close;
      qryFatDor.ParamByName('AUTINC').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      qryFatDor.Open;

      cdsInfAdcItem.Append;
      cdsInfAdcItem.FieldByName('ITE_SEQDET').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      cdsInfAdcItem.FieldByName('ITE_DESESP').AsFloat  := qryFatDor.FieldByName('FDO_DESESP').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_VALFRE').AsFloat  := qryFatDor.FieldByName('FDO_TOTFRE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_DESACE').AsFloat  := qryFatDor.FieldByName('FDO_DESACE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_TOTITE').AsFloat  := qryFatDor.FieldByName('FDO_TOTITE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat  := qryFatDor.FieldByName('ITE_MLTVEN').AsFloat;
      cdsInfAdcItem.FieldByName('BAR_CODBAR').AsString := qryFatDor.FieldByName('BAR_CODBAR').AsString;
      cdsInfAdcItem.FieldByName('ITE_FRERAT').AsFloat :=  qryFatDor.FieldByName('FDO_FRERAT').AsFloat;
      cdsInfAdcItem.Post;
    End;

    cdsVenda.Next;
  End;

  FreeAndNil(qryFatDor);
end;

procedure TfrmFatDesmembrarPedido.pVerificaRequisicaoCompra;
var
  qryReqCom: TUniQuery;
  intIndex: Integer;
  strTexto: String;

begin
  FItensComRequisicaoCompra.Clear;

  qryReqCom := fCriaQuery;
  try
    If (objAltDoc.objVenda.strEspDoc = 'PD') And (fCfgSis('PDOPRC', varBoolean)) Then
    Begin
      qryReqCom.SQL.Add('  SELECT                                            ');
      qryReqCom.SQL.Add('    AUTOINCREM, RCD_CODIGO                          ');
      qryReqCom.SQL.Add('  FROM                                              ');
      qryReqCom.SQL.Add('    MOVRCD                                          ');
      qryReqCom.SQL.Add('    INNER JOIN                                      ');
      qryReqCom.SQL.Add('      (SELECT DISTINCT                              ');
      qryReqCom.SQL.Add('        FGO_NUMDOC,                                 ');
      qryReqCom.SQL.Add('        FGO_ESPDOC,                                 ');
      qryReqCom.SQL.Add('        FGO_CODEMP,                                 ');
      qryReqCom.SQL.Add('        FDO_CODITE                                  ');
      qryReqCom.SQL.Add('      FROM                                          ');
      qryReqCom.SQL.Add('        FATGOR                                      ');
      qryReqCom.SQL.Add('        LEFT JOIN EXTGOR                            ');
      qryReqCom.SQL.Add('          ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO  ');
      qryReqCom.SQL.Add('        INNER JOIN FATDOR                           ');
      qryReqCom.SQL.Add('          ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER  ');
      qryReqCom.SQL.Add('      WHERE (                                       ');
      qryReqCom.SQL.Add('          FGO_NUMORI =:NUMDOC                       ');
      qryReqCom.SQL.Add('          AND FGO_ESPORI =:ESPDOC                   ');
      qryReqCom.SQL.Add('          AND FGO_EMPORI =:CODEMP                   ');
      qryReqCom.SQL.Add('          AND FDO_CODITE =:CODITE                   ');
      qryReqCom.SQL.Add('        )                                           ');
      qryReqCom.SQL.Add('        OR (                                        ');
      qryReqCom.SQL.Add('          FGO_NUMDOC =:NUMDOC                       ');
      qryReqCom.SQL.Add('          AND FGO_ESPDOC =:ESPDOC                   ');
      qryReqCom.SQL.Add('          AND FGO_CODEMP =:CODEMP                   ');
      qryReqCom.SQL.Add('          AND FDO_CODITE =:CODITE                   ');
      qryReqCom.SQL.Add('        )) PEDIDOS                                  ');
      qryReqCom.SQL.Add('      ON MOVRCD.RCD_DOCPDV = PEDIDOS.FGO_NUMDOC     ');
      qryReqCom.SQL.Add('      AND MOVRCD.RCD_ESPPDV = PEDIDOS.FGO_ESPDOC    ');
      qryReqCom.SQL.Add('      AND MOVRCD.RCD_EMPPDV = PEDIDOS.FGO_CODEMP    ');
      qryReqCom.SQL.Add('      AND MOVRCD.RCD_CODITE = PEDIDOS.FDO_CODITE    ');
      qryReqCom.SQL.Add('      WHERE MOVRCD.RCD_REQNEG <> "S"                ');
    End
    Else
    Begin
      qryReqCom.SQL.Add('SELECT AUTOINCREM, RCD_CODIGO');
      qryReqCom.SQL.Add('FROM MOVRCD ');
      qryReqCom.SQL.Add('WHERE RCD_DOCPDV = :NUMDOC');
      qryReqCom.SQL.Add('  AND RCD_ESPPDV = :ESPDOC');
      qryReqCom.SQL.Add('  AND RCD_EMPPDV = :CODEMP');
      qryReqCom.SQL.Add('  AND RCD_CODITE = :CODITE');
      qryReqCom.SQL.Add('  AND RCD_REQNEG <> "S"');
    End;

    qryReqCom.ParamByName('NUMDOC').AsString := objAltDoc.objVenda.strNumDoc;
    qryReqCom.ParamByName('ESPDOC').AsString := objAltDoc.objVenda.strEspDoc;
    qryReqCom.ParamByName('CODEMP').AsString := objAltDoc.objVenda.strEmpDoc;

    cdsDados.DisableControls;
    Try
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        qryReqCom.Close;
        qryReqCom.ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
        qryReqCom.Open;

        if not qryReqCom.IsEmpty then
          FItensComRequisicaoCompra.Add(cdsDados.FieldByName('ITE_CODITE').AsString);

        cdsDados.Next;
      End;
      cdsDados.First;
    Finally
      cdsDados.EnableControls;
    End;

    if FItensComRequisicaoCompra.Count > 0 then
    begin
//      intIndex := cmbOpcFinalizacao.Items.IndexOf(OPC_FIN_REQUISICAO_COMPRA);
//      if intIndex < 0 then
//      begin
//        cmbOpcFinalizacao.Items.Add(OPC_FIN_REQUISICAO_COMPRA);
//        intIndex := cmbOpcFinalizacao.Items.IndexOf(OPC_FIN_REQUISICAO_COMPRA);
//      end;
//      cmbOpcFinalizacao.ItemIndex := intIndex;
//      cmbOpcFinalizacao.Enabled := False;

      strTexto := '';
      for intIndex := 0 to Pred(FItensComRequisicaoCompra.Count) do
      begin
        if intIndex = Pred(FItensComRequisicaoCompra.Count) then
          strTexto := strTexto + FItensComRequisicaoCompra[intIndex]
        else
        if intIndex = Pred(FItensComRequisicaoCompra.Count)-1 then
          strTexto := strTexto + FItensComRequisicaoCompra[intIndex] + ' e '
        else
          strTexto := strTexto + FItensComRequisicaoCompra[intIndex] + ', ';
      end;

      lblReqCompra.Caption := 'Este documento possui itens que tem requisição de compra gerada e portanto, não é possível realizar alterações.' +
                              ' Número da requisição: ' + qryReqCom.FieldByName('RCD_CODIGO').AsString +
                              ' Produtos: ' + strTexto;
      lblReqCompra.Visible := True;
    end;
  finally
    FreeAndNil(qryReqCom);
  end;
end;

procedure TfrmFatDesmembrarPedido.pZerarQuantidadeProdutos;
begin
  cdsDados.FieldByName('ITE_QTDITE').AsFloat := 0;
end;

procedure TfrmFatDesmembrarPedido.pLimparItens;
begin
  If cdsDados.Active Then
    cdsDados.EmptyDataSet;
end;

function TfrmFatDesmembrarPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnJaFatu,
    blnJaBaix,
    blnImpresso,
    blnSepImpresso: Boolean;
    strCodRom: String;
    strCodVen: String;
    strNumOse: String;
    objParametrosMensagem: TParametrosMensagem;

    function fDocEmRomaneio: Boolean;
    Begin
      strCodRom := '';
      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        strCodRom := fDocumentoEmRomaneio(edtNumDoc.Text, edtEspDoc.Text);
      End;
      Result := Not fEmptyStr(strCodRom);
    End;

    function fDocumentoVinculadoOrdemServico: Boolean;
    Begin
      strNumOse := fRetornaOrdemServicoPedido(edtNumDoc.Text, edtCodEmp.Text);
      Result := Not fEmptyStr(strNumOse);
    End;

begin

  Result    := True;
  blnJaFatu := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número do documento deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If edtEspDoc.ReadOnly Then
      Begin
        Result := fValidaCampos(edtEspDoc, blnBuscaPorChave);
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If InterlockedIncrement(intSemaforoValidar) = 0 Then
      Begin

        Try

          If (Pos(edtEspDoc.Text, 'OR_PD_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Espécie deve ser OR ou PD!', ['&O k']);
            Result := False;
          End
          Else If (Not fDocumentoFatExiste(objAltDoc.qryFatGor, edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, blnJaFatu, blnJaBaix, blnImpresso, strCodVen, blnSepImpresso)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If (blnJaFatu) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento já foi faturado!', ['&O k']);
            Result := False;
          End

          Else If (fPedidoFaturadoParcialmente(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) And (Not fCfgSis('DPDAFP', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documento faturado parcialmente não pode ser alterado!', ['&O k']);
            Result := False;
          End

          else if TYapayFacade.fPedidoPossuiCobrancaAtiva(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
          begin
            objParametrosMensagem := TParametrosMensagem.Create;
            try
              objParametrosMensagem.Titulo := 'Yapay';
              objParametrosMensagem.Texto := 'Pedido possuí Cobrança Yapay e não pode ser alterado/cancelado!';
              objParametrosMensagem.Opcoes := ['&OK'];
              objParametrosMensagem.Url.Caption := 'Visualizar cobrança';
              objParametrosMensagem.Url.Href :=
                TYapayFacade.fLinkPagamento(TYapayFacade.fGetAutIncFatGor(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text));
              fMensagem(objParametrosMensagem);
            finally
              objParametrosMensagem.Free;
            end;
            Result := False;
          End

          Else If fTemServico(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, '') Then
          Begin
            fMensagem('','Documento com serviços não pode ser alterado!',['&OK']);
            Result := False;
          End

          Else If fTemVidro(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('','Documento com vidros não pode ser alterado!',['&OK']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'OR') And (Not fVerificaAcessoSistema('VERORC')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'PD') And (Not fVerificaAcessoSistema('VERPED')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If (edtEspDoc.Text = 'PD') And (fDocumentoVinculadoOrdemServico) Then
          Begin
            pMensagemOk('Este pedido de venda foi gerado a partir' + #13 +
                        'da O.S. ' + strNumOse + ' e não pode ser alterado.' + #13 + #13 +
                        'As alterações devem ser feitas na própria O.S.!');
            Result := False;
          End

          Else If fDocEmRomaneio And (Not fCfgSis('USPRRO', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Documento está associado ao(s) Romaneio(s): ' + strCodRom + '.' + #13#10 +
                                  'Remova esse Documento do(s) romaneio(s) para poder alterá-lo!', ['&Ok']);
            Result := False;
          End

          Else If fPedidoBaixaEntregaFutura(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Pedidos de Baixa de Entrega Futura não podem ser alterados!', ['&Ok']);
            Result := False;
          End

          Else If (Not fFinanceiroPermiteDesmembramento) Then
          Begin
            Result := False;
          End

          Else If fEhPedOrcMultiloja(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                     objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                     objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'Não é permitido desmembrar um pedido ' +
                                  'multiloja por essa rotina!', ['&OK']);
          End;

          {**********************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS IMPRESSOS *}
          {*******************************************JC*}
          If Result And (Not fCfgSis('ALTPDI', varBoolean)) And (blnImpresso) And
                        (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'PD') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Documento já foi impresso portanto não é possível alterá-lo!', ['&Ok']);

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Esse Documento já foi impresso portanto não é possível alterá-lo!');
            objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                    objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                    objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 9);

            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                    fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 9);

            objLiberacao.strDirAce := 'ALTPDI';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.blnSempreVariavelUsuario := True;

            If objLiberacao.fLibera Then
            Begin
              Result := True;
            End
            Else
            Begin
              Result := False;
            End;
          End;

          {***********************************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS COM SEPARAÇÃO IMPRESSA *}
          {********************************************************MM*}
          If Result And (blnSepImpresso) And (Not fEmptyStr(edtNumDoc.Text)) Then
          Begin
            If fImpressaoParcialConsiderandoJaImpresso Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse Documento, pois a separação já foi impressa!', ['&Ok']);
              Result := False;
            End
            Else If (fCfgSis('ALTPDS') = 'N') Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse Documento, pois a separação já foi impressa!', ['&Ok']);

              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse Documento, pois a separação já foi impressa!');
              objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                      objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                      objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString         , 9);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                      fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 9);

              objLiberacao.strDirAce := 'ALTPDS';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;

              Result := objLiberacao.fLibera;
            End
            Else If (fCfgSis('ALTPDS') = 'C') And
                    (objAltDoc.qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S') And
                    (objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                    (objAltDoc.qryFatGor.FieldByName('FGO_EMP_CD').AsString <> VS_strCodEmp) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar, pois este pedido é entrega '
                                  + 'pelo CD e a separação já foi impressa. '
                                  + 'Somente será possível realizar alteração após limpar separação. '
                                  + 'Entre em contato com o responsável pelo CD.', ['&Ok']);
              Result := False;
            End;
          End;

          {***********************************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS COM ORDEM DE PRODUÇÃO  *}
          {* DE PRODUTOS TINTOMÉTRICOS IMPRESSA                      *}
          {********************************************************MM*}
          If (Result) And (Not fEmptyStr(edtNumDoc.Text)) And
             (VS_strUsaTmq = 'S')  And (Not fCfgSis('ALTPDT', varBoolean)) And

             (fTemProdutoTintometrico(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                      objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                      objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                      objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)) And

             (fTemOrdemProducaoTintaImpresso(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                             objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                             objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                             objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)) Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse Documento, pois a ordem de produção de produtos tintométricos já foi impressa!');
            objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                    objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                    objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString         , 9);

            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                    fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 9);

            objLiberacao.strDirAce := 'ALTPDT';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.blnSempreVariavelUsuario := True;

            If objLiberacao.fLibera Then
            Begin
              Result := True;
            End
            Else
            Begin
              Result := False;
            End;
          End;

          If Result Then
          Begin
            blnMudarFoco := False;
            Result := fCarregarDocumento;
          End;

          InterlockedDecrement(intSemaforoValidar);

        Except
          On E: Exception Do
          Begin
            Result := False;
            InterlockedDecrement(intSemaforoValidar);
            pMensagensErro(E.Message, '');
          End;
        End;

      End
      ELse
        InterlockedDecrement(intSemaforoValidar);
    End;

  End;

  If (Not Result) And (Not blnVendaPerdidaAutomatica) Then
    pSetFocus(Sender);
end;

function TfrmFatDesmembrarPedido.fValidaQuantidadePendente: Boolean;
begin
  Result := True;

  If (Not cxgItensDadosQTDPEN.Visible) Then
    Exit;

  cdsDados.DisableControls;
  cdsDados.BeforePost := Nil;

  try
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      If (cdsDados.FieldByName('ITE_QTDITE').AsFloat > cdsDados.FieldByName('ITE_QTDPEN').AsFloat) Then
      Begin
        Exit(False);
      End;
      cdsDados.Next;
    end;

  finally
    cdsDados.First;
    cdsDados.BeforePost := pBeforePost;
    cdsDados.EnableControls;
  end;
end;

procedure TfrmFatDesmembrarPedido.pExecutaBeforePostTodosItens;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.Post;

      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

procedure TfrmFatDesmembrarPedido.FormCreate(Sender: TObject);
begin
  inherited;
  blnPermiteApenasGerarRequisicaoParaItensSemEstoque := False;
  blnOnShow := False;

  intSemaforoValidar  := -1;
  blnUsarClienteFilialParaNovoPedido := fCfgSis('CLIDMP') = '2';
  objAltDoc := TAlterarPedido.Create(Self);

  objLiberacao := TLiberacao.Create;

  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.AfterInsert := pAfterInsert;
  cdsDados.BeforePost  := pBeforePost;
  cdsDados.AfterPost   := pAfterPost;
  cdsDados.AfterOpen   := pAfterOpen;

  cdsVendaBkp := TUniClientDataSet.Create(Self);
  dtsDados := fCriaDataSource(cdsDados);

  cxgItensDados.DataController.DataSource := dtsDados;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'PD';

  strNumPed := '';
  strEspPed := '';
  strEmpPed := '';
  blnDesmembrou := False;
  blnCRM := False;
  blnDesmembrarOrcamentoPedido := False;
  blnExpedicao := False;
  SetLength(arrIteExpPed, 0);

  pCriaClientInfAdcItem;

  If blnUsarClienteFilialParaNovoPedido Then
  Begin
    edtEspDoc.Text       := 'PD';
    edtEspDoc.ReadOnly   := True;
    edtEspDoc.TabStop    := False;
    edtEspDoc.Color      := $00FFDFB8;
    edtEspDoc.FocusColor := $00FFDFB8;
    Self.Caption         := 'Desmembramento de corte de pedido de venda por falta de estoque';
  End;

  If VS_strHabilitarCRM And fEmptyStr(fCfgSis('VENPED')) Then
  Begin
    pMensagemOk('A configuração "[CFG_VENPED] Tipo de Ocorrência - Venda - Pedido" deve ser informada para prosseguir!');
    blnFecharFormPai := True;
  End;

  If VS_strHabilitarCRM And blnUsarClienteFilialParaNovoPedido And fEmptyStr(fCfgSis('OCODMP')) Then
  Begin
    pMensagemOk('A configuração "[CFG_OCODMP] Tipo de Ocorrência - Desmembramento de corte de pedido de venda por falta de estoque" deve ser informada para prosseguir!');
    blnFecharFormPai := True;
  End;

  pAddColunasGrid();
  mskCndPagAtu.EditMask := MASK_CONPAG;
  blnLiberacaoPedido := False;

  blnPermiteAlterarCndPag := False;

  cxgItensDadosUNITMP.Visible := fCfgSis('CNDDES', varBoolean);
  cxgItensDadosTOTTMP.Visible := fCfgSis('CNDDES', varBoolean);
  cxgItensDadosSTATUSITEM.Visible := fCfgSis('EXISTA', varBoolean);
  cxgItensDadosQTDBAI.Visible := fCfgSis('DPDAFP', varBoolean);
  cxgItensDadosQTDPEN.Visible := fCfgSis('DPDAFP', varBoolean);
  cxgItensDadosQTDREC.Visible := fCfgSis('PDOPRC', varBoolean);
  cxgItensDadosQTORI2.Visible := cxgItensDadosQTDREC.Visible;
  cxgItensDadosQTDATE.Visible := cxgItensDadosQTDREC.Visible;      

  If cxgItensDadosQTORI2.Visible Then
    cxgItensDadosQTDORI.Caption := 'Qtde. Pedido';

  FItensComRequisicaoCompra := TStringList.Create;
  blnDesmembramentoAutomaticoPelaExpedicao := False;
  blnVendaPerdidaAutomatica := False;
  blnRetirarNovoPedidoDoRegimeEspecial := False;

  blnPedidoRegimeEspecial := False;
  blnValidandoAfterPost := False;
  objCdsVinculos := TCdsVinculosRequisicoes.fGetClientDataSet;

  pCriarModuloLegenda;
end;

procedure TfrmFatDesmembrarPedido.FormDestroy(Sender: TObject);
begin

  inherited;
  VS_blnTraceErrorMessage := False;
  If Assigned(objAltDoc)     Then FreeAndNil(objAltDoc);
  If Assigned(dtsDados)      Then FreeAndNil(dtsDados);
  If Assigned(cdsDados)      Then FreeAndNil(cdsDados);
  If Assigned(cdsVendaBkp)   Then FreeAndNil(cdsVendaBkp);
  If Assigned(cdsInfAdcItem) Then FreeAndNil(cdsInfAdcItem);
  if Assigned(objLiberacao)  Then FreeAndNil(objLiberacao);
  if Assigned(FItensComRequisicaoCompra)  Then FreeAndNil(FItensComRequisicaoCompra);
  If Assigned(objCdsVinculos) Then FreeAndNil(objCdsVinculos);

  SetLength(arrIteExpPed, 0);
end;

procedure TfrmFatDesmembrarPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3: btnCopiarQtd.Click;
    VK_F5: btnAltCndPag.Click;
    VK_F6: btnEstLoj.Click;
    VK_F10: btnConfirma.Click;
    VK_ESCAPE: If (fEmptyStr(strNumPed)) And (fEmptyStr(strEspPed)) And (fEmptyStr(strEmpPed)) Then
                 pEscapePressed;
    VK_DELETE: If ssCtrl In Shift Then Key := 0;
    VK_RETURN: If cxgItens.Focused Then
               Begin
                 If cdsDados.State = dsEdit Then
                   cdsDados.Post;

                 If cdsDados.RecNo < cdsDados.RecordCount Then
                 Begin
                   cdsDados.Next;
                   cdsDados.Edit;
                 End
                 Else
                   pSetFocus(btnConfirma);
               End;
  End;
End;

procedure TfrmFatDesmembrarPedido.FormResize(Sender: TObject);
begin
  inherited;
  AjustarTamanhoDaColunaDescricaoDaGrid;
end;


procedure TfrmFatDesmembrarPedido.AjustarTamanhoDaColunaDescricaoDaGrid;
Var
  ColumnDescricao : TcxGridDBColumn;
  intColumn       : Integer;
  intTamUti       : Integer;

 const
  intValMin: Integer = 480;
begin

  ColumnDescricao := cxgItensDadosDESITE;

  if Assigned(ColumnDescricao) then
  begin
    intTamUti := 0;

    For intColumn := 0 To cxgItensDados.ColumnCount -1 Do
      If (cxgItensDados.Columns[intColumn].Visible) And
       (cxgItensDados.Columns[intColumn].DataBinding.FieldName <> 'ITE_DESITE') Then
        Inc(intTamUti, cxgItensDados.Columns[intColumn].Width);

    If (cxgItens.Width - intTamUti - 43) >= intValMin Then
      ColumnDescricao.Width := (cxgItens.Width - intTamUti - 43)
    Else
      ColumnDescricao.Width := intValMin;
  end;

end;

procedure TfrmFatDesmembrarPedido.FormShow(Sender: TObject);
begin
  inherited;
  pOnShow;
end;

procedure TfrmFatDesmembrarPedido.btnAltCndPagClick(Sender: TObject);
var
  strCodCnd,
  strCndPag,
  strForPag,
  strForPagDes: String;
  blnConfirmaCndPag: Boolean;
  blnCalculaTaxCndF3InicioBkp: Boolean;
begin
  inherited;
  if (not btnAltCndPag.Visible) or (not btnAltCndPag.Enabled) then
    Exit;

  if (not cdsDados.Active) or cdsDados.IsEmpty then
    Exit;

  If Not fVerificaAcessoSistema('CNDDES') Then
  Begin
    fMensagem('ATENÇÃO!', 'Operador não possui acesso para alterar a condição de pagamento do novo ' +
      'documento que será gerado através da rotina de desmembramento de orçamentos/pedidos.!', ['&O k']);
    Exit;
  End;

  if (TAdiantamento.fGetTotaisAdiantamento(
        objAltDoc.objVenda.strNumDoc,
        objAltDoc.objVenda.strEspDoc,
        objAltDoc.objVenda.strEmpDoc).fltValLan > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido já possui adiantamento e por isso a condição de pagamento do novo pedido não pode ser alterada.', ['&O k']);
    Exit;
  End;

  if (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
        objAltDoc.objVenda.strNumDoc,
        objAltDoc.objVenda.strEspDoc,
        objAltDoc.objVenda.strEmpDoc,
        objAltDoc.objVenda.strCodCli) > 0) then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido possui boleto de adiantamento e por isso a condição de pagamento do novo pedido não pode ser alterada.', ['&O k']);
    Exit;
  End;

  strCodCnd := objAltDoc.objVenda.strCodCnd;
  strCndPag := objAltDoc.objVenda.strConPag;
  strForPag := objAltDoc.objVenda.strCodFpg;
  strForPagDes := fRetDesFpg(objAltDoc.objVenda.strCodFpg);

  TfrmDigCndPagamentoEsp.pExibe(
    strCodCnd,
    strCndPag,
    strForPag,
    strForPagDes,
    blnConfirmaCndPag);

  if not blnConfirmaCndPag then
    Exit;

  FblnAlterouCndPag := blnConfirmaCndPag;

  FstrCodCndNovo := strCodCnd;
  FstrCndPagNovo := strCndPag;
  FstrCodFpgNovo := strForPag;

  FstrCodCndBkp := objAltDoc.objVenda.strCodCnd;
  FstrCndPagBkp := objAltDoc.objVenda.strConPag;
  FstrCodFpgBkp := objAltDoc.objVenda.strCodFpg;

  if fCfgSis('RECCND', varBoolean) then
  begin
    objAltDoc.objVenda.strCodCnd := strCodCnd;
    objAltDoc.objVenda.strConPag := strCndPag;
    objAltDoc.objVenda.strCodFpg := strForPag;

    blnCalculaTaxCndF3InicioBkp := objAltDoc.objVenda.blnCalculaTaxCndF3Inicio;
    objAltDoc.objVenda.blnCalculaTaxCndF3Inicio := True;
    objAltDoc.pCarregaCondicao(strCodCnd, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);
    objAltDoc.blnRecalculaPrecos := True;
    objAltDoc.fCalculaTotalPedido;
    objAltDoc.objVenda.blnCalculaTaxCndF3Inicio := blnCalculaTaxCndF3InicioBkp;

    cdsVenda.DisableControls;
    cdsDados.DisableControls;
    cdsDados.BeforePost := nil;
    try
      cdsVenda.First;
      while not cdsVenda.Eof do
      begin
        if cdsDados.Locate('AUTOINCREM', cdsVenda.FieldByName('AUTOINCREM').AsString, []) then
        begin
          cdsDados.Edit;
          cdsDados.FieldByName('ITE_UNITMP').AsFloat := cdsVenda.FieldByName('ITE_UNITAR').AsFloat;
          cdsDados.FieldByName('ITE_TOTTMP').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat * cdsDados.FieldByName('ITE_UNITMP').AsFloat;
          cdsDados.Post;
        end;

        cdsVenda.Next;
      end;
    finally
      cdsVenda.EnableControls;
      cdsDados.EnableControls;
      cdsDados.BeforePost := pBeforePost;
    end;

    objAltDoc.objVenda.strCodCnd := FstrCodCndBkp;
    objAltDoc.objVenda.strConPag := FstrCndPagBkp;
    objAltDoc.objVenda.strCodFpg := FstrCodFpgBkp;

    objAltDoc.pCarregaCondicao(FstrCodCndBkp, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);
    objAltDoc.blnRecalculaPrecos := True;
    objAltDoc.fCalculaTotalPedido;
  end;

end;

procedure TfrmFatDesmembrarPedido.btnConfirmaClick(Sender: TObject);
begin
  If Assigned(cdsDados) And (Not cdsDados.IsEmpty) Then
    TfrmGravando.fExecutarModal(pConfirmar, 'Aguarde, Desmembrando documento...', '')
  Else
    pMensagemOk('É necessário selecionar um documento!');
end;

function TfrmFatDesmembrarPedido.fCarregarQtdDesmExp: Boolean;
  Var
    i: Integer;
begin
  Result := False;

  If (Length(arrIteExpPed) > 0) Then Begin
    Try
      cdsDados.DisableControls;

      For i := 0 To Length(arrIteExpPed) - 1 Do Begin
        If (cdsDados.Locate('ITE_SEQDET', arrIteExpPed[i].strSeqIte, [])) Then Begin
          cdsDados.Edit;
          cdsDados.FieldByName('ITE_QTDITE').AsFloat := arrIteExpPed[i].fltQtdDes;
          cdsDados.Post;
        End Else Begin
          fMensagem('ATENÇÃO!', 'O item ' + QuotedStr(arrIteExpPed[i].strCodIte) +
            ' não foi encontrado para desmembramento. Operação cancelada!', ['&Ok']);
          Exit;
        End;
      End;

      cdsDados.First;

      Result := True;
    Finally
      cdsDados.EnableControls;
      pAtualizarLabelQtdProd;
    End;
  End;
end;

function TfrmFatDesmembrarPedido.fEhEmissaoDocumentoWMS(
  strCodEmp: String): Boolean;
begin
  Result := fUsaRotinaWMS(strCodEmp) And
            MatchStr(edtEspDoc.Text, ['PD','OR', 'EF', 'OE']);
end;

function TfrmFatDesmembrarPedido.fEmpresaParaFaturamentoUsaWMS(
  strCodEmp: String): Boolean;
begin
  If Not fPermiteInformarEmpresaNoItem(edtEspDoc.Text) Then
    Result := fEhEmissaoDocumentoWMS(strCodEmp)
  Else
    Result := (Not fEmptyStr(strCodEmp)) And fUsaRotinaWMS(strCodEmp);
end;

procedure TfrmFatDesmembrarPedido.pCarregaOpcaoFinalizacao;
var
  strDmpOpc: String;
begin
  cmbOpcFinalizacao.Items.Clear;
  cmbOpcFinalizacao.Sorted := False;
  Try
    strDmpOpc := fCfgSis('DMPOPC', varString);

    If (blnPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
    Begin
      if Copy(strDmpOpc, 3, 1) = 'S' then
        cmbOpcFinalizacao.Items.Add(OPC_FIN_REQUISICAO_COMPRA);
      Exit;
    End;

    if (Copy(strDmpOpc, 1, 1) = 'S') And fPermiteOpcaoGerarNovoPedido() then
      cmbOpcFinalizacao.Items.Add(OPC_FIN_NOVO_PEDIDO);

    if Copy(strDmpOpc, 2, 1) = 'S' then
      cmbOpcFinalizacao.Items.Add(OPC_FIN_VENDA_PERDIDA);

    if Copy(strDmpOpc, 3, 1) = 'S' then
      cmbOpcFinalizacao.Items.Add(OPC_FIN_REQUISICAO_COMPRA);
  Finally
    if cmbOpcFinalizacao.Items.Count > 0 then
      cmbOpcFinalizacao.ItemIndex := 0;
  End;
end;

procedure TfrmFatDesmembrarPedido.pConfirmar;
begin
  inherited;

  If Not btnConfirma.Enabled Then
    Exit;

  If Not fValidaQuantidadePendente Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido informar uma quantidade maior que a quantidade pendente para gerar o novo documento!', ['&Ok']);

    Exit;
  End;

  If (fQuantidadeOriginalTodosItens) And (Not blnPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
  Begin
    pMensagemOk('A quantidade digitada em todos os produtos é igual a quantidade original, ' +
                'portanto não há produtos para desmembrar em um novo documento!');
    Exit;
  End;

  If fQuantidadeZeradaTodosItens Then
  Begin
    pMensagemOk('Favor informar a quantidade nos produtos antes de gerar o novo documento!');
    Exit;
  End;

  If Not fEmptyStr(strInRqCp) Then
  Begin
    objAltDoc.objVenda.strInRqCp := '';
    If objAltDoc.objVenda.cdsMovRcd.Active Then
      objAltDoc.objVenda.cdsMovRcd.EmptyDataSet;
  End;

  If blnUsarClienteFilialParaNovoPedido And fEmptyStr(fRetornaClienteFilial(VS_strCodEmp)) Then
  Begin
    pMensagemOk('Não foi definido o cliente filial para a empresa logada. Favor verificar o cadastro de empresa!');
    Exit;
  End;

  If (objAltDoc.objVenda.fEhDesmembramentoExpedicaoRegimeEspecial) Then
  Begin
    If (Not fFinanceiroPermiteDesmembramento) Then
      Exit;
  End;

  If blnExpedicao Then
    pExecutaBeforePostTodosItens;

  objAltDoc.blnDesmembramentoAutomaticoPelaExpedicao := Self.blnDesmembramentoAutomaticoPelaExpedicao;

  objAltDoc.objVenda.cdsVinculos := objCdsVinculos;

  case fOpcaoFinalizacao of
    ofNovoPedido:
      begin
        If objAltDoc.qryFatGor.FieldByName('FGO_REGDES').AsString = 'S' Then
        Begin
          If fMensagem('REGIME ESPECIAL',
                       'Você está desmembrando um pedido de venda de Regime Especial.'+ sLineBreak +
                       'O novo pedido deve ser gerado da seguinte forma:',
                       ['Manter no Regime', 'Sair do Regime'], 2, False, 1, 200) = 2 Then
            blnRetirarNovoPedidoDoRegimeEspecial := True;
        End;

        If blnUsarClienteFilialParaNovoPedido Then
          pDesmembrarPedidosUsandoClienteFilialNovoPedido
        Else
          pDesmembrarPedidosUsandoMesmoCliente;
      end;
    ofVendaPerdida:
      begin
        pDesmembrarPedidosVendaPerdida;
      end;
    ofRequisicaoCompra:
      begin
        if fValidaRequisicaoCompra then
          pDesmembrarPedidosRequisicaoCompra
      end;
  end;
End;

procedure TfrmFatDesmembrarPedido.pExcluirNovaVendaPerdidaGerada(strCodigo: String);
begin
  fExecutaSQL('DELETE FROM MOVVPD WHERE VPD_CODIGO = "' + strCodigo + '"');
  fExecutaSQL('DELETE FROM MOVVPG WHERE VPG_CODIGO = "' + strCodigo + '"');
end;

procedure TfrmFatDesmembrarPedido.pReprocessaSaldoAmbosPedidos(strNumDocNovo: String);
begin
  {Reprocessar Pedido Original}
  TReprocessarSaldoItem.New
    .AddItensDoDocumento(
      TItensReprocessarDoDocumento.New
        .Documento(edtNumDoc.Text)
        .Especie(edtEspDoc.Text)
        .Empresa(edtCodEmp.Text)
      ).NotificarRoboParaReprocessarSaldos;

  {Reprocessar Pedido Novo}
  TReprocessarSaldoItem.New
    .AddItensDoDocumento(
      TItensReprocessarDoDocumento.New
        .Documento(strNumDocNovo)
        .Especie(edtEspDoc.Text)
        .Empresa(edtCodEmp.Text)
      ).NotificarRoboParaReprocessarSaldos;
end;

procedure TfrmFatDesmembrarPedido.pRetornaStatusItem;
var
  strStatus: String;
begin
  if not cxgItensDadosSTATUSITEM.Visible then
    Exit;

  strStatus := TStatus.New(
    TParamStatus.New()
      .NumDoc(cdsDados.FieldByName('ITE_NUMORC').AsString)
      .EspDoc(cdsDados.FieldByName('ITE_ESPORC').AsString)
      .CodEmp(cdsDados.FieldByName('ITE_EMPORC').AsString)
      .SeqFdo(cdsDados.FieldByName('ITE_SEQDET').AsString)
  ).fGetStatus().fGetDescricao;

  cdsDados.FieldByName('STATUSITEM').AsString := strStatus;
end;

procedure TfrmFatDesmembrarPedido.pRetQuantidadePendenteFaturado;
begin
  if not cxgItensDadosQTDPEN.Visible then
    Exit;

  cdsDados.FieldByName('ITE_QTDPEN').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat - cdsDados.FieldByName('ITE_QTDBAI').AsFloat;
end;

procedure TfrmFatDesmembrarPedido.pConfiguraIconesProdutos(cxProdutos: TcxGridDBTableView);
var
  item: TcxImageComboBoxItem;
  coluna: TcxGridDBColumn;
  strKey: String;
begin
  If Not fCfgSis('EXISTA', varBoolean) Then
    Exit;

  coluna := cxProdutos.GetColumnByFieldName('STATUSITEM');

  If Not Assigned(coluna) Then
    Exit;

  coluna.Visible         := True;
  coluna.SortIndex       := -1;
  coluna.Options.Editing := False;

  If Not SameText(coluna.PropertiesClassName, 'TcxImageComboBoxProperties') Then
  Begin
    coluna.PropertiesClass := TcxImageComboBoxProperties;

    TcxImageComboBoxProperties(coluna.Properties).Images := frmModuloLegenda.imglLegenda;
    For strKey In TSituacaoPedidoVenda.fRetornaLegenda.Keys Do
    Begin
      item := TcxImageComboBoxProperties(coluna.Properties).Items.Add;
      item.ImageIndex := TSituacaoPedidoVenda.fRetornaLegenda.Items[strKey];
      item.Value      := strKey;
      item.Description:= item.Value;
    End;
  End;
end;

procedure TfrmFatDesmembrarPedido.pExcluirNovoDocumentoGerado(strNumDocNovo: String);
Var
  blnTransacaoLocal : Boolean;
begin

  blnTransacaoLocal := False;

  Try

    If Not fInTransaction() Then
    Begin
      fStartTransaction();
      blnTransacaoLocal := True;
    End;

    {Reprocessar Saldos}
    TReprocessarSaldoItem.New
      .AddItensDoDocumento(
        TItensReprocessarDoDocumento.New
          .Documento(strNumDocNovo)
          .Especie(edtEspDoc.Text)
          .Empresa(edtCodEmp.Text)
        ).NotificarRoboParaReprocessarSaldos;

    fExecutaSQL('DELETE FROM FATGOR WHERE FGO_NUMDOC = "' + strNumDocNovo + '" AND ' +
                'FGO_ESPDOC = "' + edtEspDoc.Text + '" AND FGO_CODEMP = "' + edtCodEmp.Text + '"');

    If blnTransacaoLocal Then
      fCommit();

  Except

    If blnTransacaoLocal Then
      fRollBack();

    Raise;

  End;

end;

procedure TfrmFatDesmembrarPedido.pFecharDesmExpedicao(blnDesmem: Boolean);
begin
  If (Length(arrIteExpPed) > 0) Or
    blnCRM Then
  Begin
    blnDesmembrou := blnDesmem;
    btnSair.Click();
  End;
end;

procedure TfrmFatDesmembrarPedido.pGravaQtdeNovoDoc;
begin
  if (cdsDados.State = dsEdit) then
    cdsDados.Post;
end;

procedure TfrmFatDesmembrarPedido.pDesmembrarPedidosRequisicaoCompra;
var
  strSeqRqCmp: String;
begin
  if fIncluiRequisicaoCompra(strSeqRqCmp) then
  Begin
    pMensagemOk('Requisição de compra ' + strSeqRqCmp + ' emitida com sucesso!' );
    pLimparTela;

    pFecharDesmExpedicao(True);
  End
  Else Begin
    pMensagemOk('Não foi possível gerar a requisição de compra!');

    pFecharDesmExpedicao(False);
  End;
end;

procedure TfrmFatDesmembrarPedido.pDesmembrarPedidosUsandoClienteFilialNovoPedido;
  Var
    strNumDocNovo: String;
    strMsgCorteParaDigitador: String;
    blnCarregouPedido: Boolean;

  procedure pPreparaItensParaGravarSemValor;
    Var
      i: Integer;
  begin
    objAltDoc.objVenda.pPreencheMatrizFechamento();

    For i := Low(objAltDoc.objVenda.arrMatItens) To High(objAltDoc.objVenda.arrMatItens) Do
    Begin
      objAltDoc.objVenda.arrMatItens[i].fltUniTmp := 0;
      objAltDoc.objVenda.arrMatItens[i].fltUniDig := 0;
      objAltDoc.objVenda.arrMatItens[i].fltUnitar := 0;
      objAltDoc.objVenda.arrMatItens[i].fltUniVis := 0;
      objAltDoc.objVenda.arrMatItens[i].fltDescon := 0;
      objAltDoc.objVenda.arrMatItens[i].fltTotIte := 0;
    End;

    objAltDoc.objVenda.pCalculaTotGer(True, False);

    { Deve ficar apos a calculatotger }
    objAltDoc.objVenda.strEspDoc := edtEspDoc.Text;

    { Não alterar esta mensagem pois é utilizada pela view VW_SALDO_RESERVADO_PEDIDO_ANALITICO_FATDOR }
    objAltDoc.objVenda.strMen001 := 'PEDIDO DE RESERVA DE ESTOQUE';

    FillChar(objAltDoc.objVenda.arrDuplicata, SizeOf(objAltDoc.objVenda.arrDuplicata), #0);
  end;

begin
  { Carrega os dados do cliente filial da empresa logada para gravar o pedido }
  objAltDoc.objVenda.pCarregaDadosClienteBaixa(fRetornaClienteFilial(VS_strCodEmp));

  objAltDoc.objVenda.blnGravandoPedidoCorteFaltaEstoque := True;

  pCloneDataSet(cdsVenda, cdsVendaBkp);//Restaura o backup

  pAcertarQuantidadeDocNovo;
  pAdicionarItensReservarSemEstoque;

  strMsgCorteParaDigitador := fMontarMensagemCorteParaDigitador;

  objAltDoc.objVenda.blnDesmembrarOrPd := True;

  objAltDoc.objVenda.strNumOrigem := objAltDoc.objVenda.strNumOrc;
  objAltDoc.objVenda.strEspOrigem := objAltDoc.objVenda.strEspOrc;
  objAltDoc.objVenda.strEmpOrigem := objAltDoc.objVenda.strEmpOri;

  objAltDoc.objVenda.strNumOrc := '';//Necessario para gravar um novo documento
  objAltDoc.objVenda.strEspOrc := '';//Necessario para gravar um novo documento

  objAltDoc.objVenda.fltDesEsp := 0.0;
  objAltDoc.objVenda.fltValFre := 0.0;
  objAltDoc.objVenda.fltDesAce := 0.0;

  pPreparaItensParaGravarSemValor;

  if FblnAlterouCndPag then
  begin
    objAltDoc.objVenda.strCodCnd := FstrCodCndNovo;
    objAltDoc.objVenda.strConPag := FstrCndPagNovo;
    objAltDoc.objVenda.strCodFpg := FstrCodFpgNovo;
  end;

  objAltDoc.objVenda.strComplementoFrmLogGor := '('+cmbOpcFinalizacao.Text +' pDesmembrarPedidosUsandoClienteFilialNovoPedido (1)'+')';
  
  If Not objAltDoc.fGravarPedido Then
  Begin
    pMensagemOk('Não foi possível gerar o novo documento!');
    pFecharDesmExpedicao(False);
    pLimparTela;
    Exit;
  End;

  strNumDocNovo := objAltDoc.objVenda.strNumDoc;

  { Acredito ser mais seguro carregar o pedido novamente pois ao trocar para o cliente filial
    e depois voltar para o cliente original pode ocorrer de variaveis nao serem carregadas corretamente.
    Pode ser condicao de pagamento, endereco de entrega, etc... Por precaução melhor carregar
    o pedido novamente e alterar as quantidades originais preservando a integridade do documento.
  }
  If Assigned(objAltDoc) Then
    FreeAndNil(objAltDoc);

  objAltDoc := TAlterarPedido.Create(Self);

  objAltDoc.strNumPed := edtNumDoc.Text;
  objAltDoc.strEspPed := edtEspDoc.Text;
  objAltDoc.strEmpPed := edtCodEmp.Text;

  objAltDoc.blnValidarMargemValorCndPagto := fCfgSis('DOMKUP', VarBoolean);

  blnCarregouPedido := objAltDoc.fCarregarPedido;

  objAltDoc.objVenda.blnDesmembrarOrPd := True;

  If (fCfgSis('DESPVE', varString) = '2') Then
  Begin
    objAltDoc.objVenda.blnManLib    := True;
  End;

  objAltDoc.objVenda.strNumOrigem := '';
  objAltDoc.objVenda.strEspOrigem := '';
  objAltDoc.objVenda.strEmpOrigem := '';

  If blnCarregouPedido Then
    pAcertarQuantidadeDocOriginal;

  objAltDoc.objVenda.strComplementoFrmLogGor := '('+cmbOpcFinalizacao.Text +' pDesmembrarPedidosUsandoClienteFilialNovoPedido (2)'+')';

  If (Not fEmptyStr(strInRqCp)) Or (fCfgSis('PDOPRC', varBoolean)) Then
  Begin
    objAltDoc.objVenda.blnApagarRequisicaoCompra := False;
  End;

  If blnCarregouPedido And
     objAltDoc.fCalculaTotalPedido And
     objAltDoc.fGravarPedido Then
  Begin
    pReprocessaSaldoAmbosPedidos(strNumDocNovo);
    
    pMensagemOk('Documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + ' alterado com sucesso!');
    pMensagemOk('Documento ' + strNumDocNovo  + '-' + edtEspDoc.Text + ' emitido com sucesso!' );
    
    If VS_strHabilitarCRM And (edtEspDoc.Text = 'PD') Then
      pEnviarEmailPedidoFaltaEstoqueGerado(objAltDoc.objVenda.strCodVen, strNumDocNovo, objAltDoc.objVenda.strModificacoesItensPedidoHtml);

    pEnviarMensagemCorteParaDigitador(strMsgCorteParaDigitador);

    pFecharDesmExpedicao(True);
    pLimparTela;
  End
  Else
  Begin
    pExcluirNovoDocumentoGerado(strNumDocNovo);
    pMensagemOk('Não foi possível alterar o documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + '!');
    pFecharDesmExpedicao(False);
    pLimparTela;
  End;

end;

function TfrmFatDesmembrarPedido.fMontarMensagemCorteParaDigitador: String;
  Var
    blnTemReservaItensSemEstoque: Boolean;
    intTamCodIte : Integer;

  function fInfPed(strCampo: String): Variant;
  begin
    Result := objAltDoc.qryFatGor.FieldByName('FGO_' + strCampo).Value;
  end;

begin
  Result := '';

  intTamCodIte := fTamCodIte;

  Result := Result + '.' + fPadC('', 85 + (intTamCodIte - 6), '-') + '.' + STRING_QUEBRA;
  Result := Result + '|' + fPadC('Desmembramento de corte de Pedido de venda por falta de estoque', 85 + (intTamCodIte - 6)) + '|' + STRING_QUEBRA;
  Result := Result + '|' + fPadC('', 85 + (intTamCodIte - 6), '-') + '|' + STRING_QUEBRA;
  Result := Result + '| Pedido     : ' + fPadR(edtNumDoc.Text + '-' +
                                               edtEspDoc.Text + '-' +
                                               edtCodEmp.Text +

                     '   Dt.Emissão: ' + FormatDateTime('dd/MM/yyyy', fInfPed('DTAENT')), 70 + (intTamCodIte - 6)) + ' |' + STRING_QUEBRA;

  Result := Result + '| Cliente    : ' + fPadR(fInfPed('CODCLI') + '-' +
                                               fRetNomCliente(fInfPed('CODCLI')), 70 + (intTamCodIte - 6))         + ' |' + STRING_QUEBRA;

  Result := Result + '| Vendedor   : ' + fPadR(fInfPed('CODVEN') + '-' +
                                               fRetNomeOperador(fInfPed('CODVEN')), 70 + (intTamCodIte - 6))       + ' |' + STRING_QUEBRA;

  Result := Result + '| Cond.Pagto : ' + fPadR(fInfPed('CODCND') + '-' +
                                               fRetDesConPag(fInfPed('CODCND')), 70 + (intTamCodIte - 6))          + ' |' + STRING_QUEBRA;

  Result := Result + '|              ' + fPadR(fFormataCondPag(fInfPed('CONPAG')), 70 + (intTamCodIte - 6))        + ' |' + STRING_QUEBRA;

  Result := Result + '| Forma Pagto: ' + fPadR(fInfPed('CODFPG') + '-' +
                                               fRetDesFpg(fInfPed('CODFPG')), 70 + (intTamCodIte - 6))             + ' |' + STRING_QUEBRA;

  Result := Result + '| Vr.Pedido  : ' + fPadR(FormatFloat('#,##0.00', fInfPed('VLRCON')), 70 + (intTamCodIte - 6))+ ' |' + STRING_QUEBRA;
  Result := Result + '|' + fPadC('', 85 + (intTamCodIte - 6), '-') + '|' + STRING_QUEBRA;
  Result := Result + '| Operador que cortou: ' + fPadR(strLoginUsuarioLogado + '-' +
                                                       fRetNomeOperador(strLoginUsuarioLogado), 62 + (intTamCodIte - 6))  + ' |' + STRING_QUEBRA;

  Result := Result + '| Data corte         : ' + fPadR(FormatDateTime('dd/MM/yyyy', VS_Date) +
                              '  Hora Corte: ' +       FormatDateTime('hh:mm:ss', fTime()),  62 + (intTamCodIte - 6))      + ' |' + STRING_QUEBRA;
  Result := Result + '|' + fPadC('', 85 + (intTamCodIte - 6), '-') + '|' + STRING_QUEBRA;
  Result := Result + '| ' + fPadR('Código', intTamCodIte) + ' | Descrição                         |   UN   |  Qtd. Cortada | Vr. Tot. Cort.|' + STRING_QUEBRA;
  Result := Result + '|' + fPadC('', 85 + (intTamCodIte - 6), '-') + '|' + STRING_QUEBRA;

  blnTemReservaItensSemEstoque := False;

  cdsVenda.First;

  While Not cdsVenda.Eof Do
  Begin
    If fEmptyStr(cdsVenda.FieldByName('ITE_SEQDET').AsString) Then
      blnTemReservaItensSemEstoque := True
    Else
      Result :=
        Result + '| ' + fPadC(cdsVenda.FieldByName('ITE_CODITE').AsString, fTamCodIte + 1) + ' ' +
                 '| ' + fPadR(cdsVenda.FieldByName('ITE_DESITE').AsString, 33) + ' ' +
                 '| ' + fPadC(cdsVenda.FieldByName('ITE_SIGUNI').AsString, 06) + ' ' +
                 '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), cdsVenda.FieldByName('ITE_QTDITE').AsFloat), 13) + ' ' +
                 '| ' + fPadL(FormatFloat(fMskDigitos(2), cdsVenda.FieldByName('ITE_QTDITE').AsFloat * cdsVenda.FieldByName('ITE_UNITAR').AsFloat), 13) + ' ' +
                 '| ' + STRING_QUEBRA;

    cdsVenda.Next;
  End;

  cdsVenda.First;

  Result := Result + '.-------------------------------------------------------------------------------------.' + STRING_QUEBRA ;

  If Not blnTemReservaItensSemEstoque Then
    Exit;

  Result := Result + STRING_QUEBRA;
  Result := Result + '.-------------------------------------------------------------------------------------.' + STRING_QUEBRA;
  Result := Result + '|    Produtos removidos do estoque disponível para verificação de falta de estoque    |' + STRING_QUEBRA;
  Result := Result + '|-------------------------------------------------------------------------------------|' + STRING_QUEBRA;
  Result := Result + '| Código | Descrição                                         |   UN   |  Qtd. Reserv. |' + STRING_QUEBRA;
  Result := Result + '|-------------------------------------------------------------------------------------|' + STRING_QUEBRA;

  cdsVenda.First;

  While Not cdsVenda.Eof Do
  Begin
    If fEmptyStr(cdsVenda.FieldByName('ITE_SEQDET').AsString) Then
      Result :=
        Result + '| ' + fPadC(cdsVenda.FieldByName('ITE_CODITE').AsString, fTamCodIte + 1) + ' ' +
                 '| ' + fPadR(cdsVenda.FieldByName('ITE_DESITE').AsString, 49) + ' ' +
                 '| ' + fPadC(cdsVenda.FieldByName('ITE_SIGUNI').AsString, 06) + ' ' +
                 '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), cdsVenda.FieldByName('ITE_QTDITE').AsFloat), 13) + ' ' +
                 '| ' + STRING_QUEBRA;

    cdsVenda.Next;
  End;

  cdsVenda.First;

  Result := Result + '.-------------------------------------------------------------------------------------.' + STRING_QUEBRA ;
end;

function TfrmFatDesmembrarPedido.fOpcaoFinalizacao: TOpcFin;
begin
  Result := ofNovoPedido;

  if AnsiMatchText(cmbOpcFinalizacao.Text, [OPC_FIN_NOVO_PEDIDO, OPC_FIN_NOVO_ORCAMENTO]) then
    Result := ofNovoPedido
  else
  if cmbOpcFinalizacao.Text = OPC_FIN_VENDA_PERDIDA then
    Result := ofVendaPerdida
  else
  if cmbOpcFinalizacao.Text = OPC_FIN_REQUISICAO_COMPRA then
    Result := ofRequisicaoCompra;
end;

function TfrmFatDesmembrarPedido.fValidouFaturamentoMinimo: Boolean;
  Var
    fltTotGer1 : Double;
    fltTotGer2 : Double;
    fltFatMin : Double;
    fltFatMax : Double;
    objCampoTabela : IMyCampoTabela;
    objLiberacao : TLiberacao;
    blnTravar : Boolean;
    fltTotGerSav : Double;
    fltTotDesSav : Double;
    fltFreDigSav : Double;
    fltPorDesSav : Double;
    strEspDocSav : String;
    fltDesEspSav : Double;
    fltValFreSav : Double;
    fltFreRatSav : Double;
    fltValAdtSav : Double;
    fltDesAceSav : Double;
    fltTaxEntSav : Double;
    fltFreSugSav : Double;
    fltFreCotSav : Double;
    strEspOrcSav : String;
    strNumOrcSav : String;
    strEmpOriSav : String;
    strCodCndSav : String;
    strConPagSav : String;
    strCodFpgSav : String;
    blnAlterouCndPagSav : Boolean;
    blnRecalculaPrecosSav : Boolean;
begin
  Result := True;

  If (Not objAltDoc.blnValidarMargemValorCndPagto) Then
    Exit;

  If Not objAltDoc.objVenda.fEfetivarValidacaoDoPerfilDaCondicaoNosDocumentosDesmembrados Then
    Exit;

  fltTotGerSav := objAltDoc.objVenda.fltTotGer;
  fltTotDesSav := objAltDoc.objVenda.fltTotDes;
  fltFreDigSav := objAltDoc.objVenda.fltFreDig;
  fltPorDesSav := objAltDoc.objVenda.fltPorDes;
  strEspDocSav := objAltDoc.objVenda.strEspDoc;
  fltDesEspSav := objAltDoc.objVenda.fltDesEsp;
  fltValFreSav := objAltDoc.objVenda.fltValFre;
  fltFreRatSav := objAltDoc.objVenda.fltFreRat;
  fltValAdtSav := objAltDoc.objVenda.fltValAdt;
  fltDesAceSav := objAltDoc.objVenda.fltDesAce;
  fltTaxEntSav := objAltDoc.objVenda.fltTaxEnt;
  strEspOrcSav := objAltDoc.objVenda.strEspOrc;
  strNumOrcSav := objAltDoc.objVenda.strNumOrc;
  strEmpOriSav := objAltDoc.objVenda.strEmpOri;
  strCodCndSav := objAltDoc.objVenda.strCodCnd;
  strConPagSav := objAltDoc.objVenda.strConPag;
  strCodFpgSav := objAltDoc.objVenda.strCodFpg;
  blnAlterouCndPagSav := objAltDoc.blnAlterouCndPag;
  blnRecalculaPrecosSav := objAltDoc.blnRecalculaPrecos;
  fltFreSugSav := objAltDoc.objVenda.fltFreSug;
  fltFreCotSav := objAltDoc.objVenda.fltFreCot;

  Try
    pCloneDataSet(cdsVenda, cdsVendaBkp);
    pAcertarQuantidadeDocNovo;
    objAltDoc.objVenda.fltDesEsp := fCalcValorNovoDoc('DESESP');
    objAltDoc.objVenda.fltValFre := fCalcValorNovoDoc('VALFRE');
    objAltDoc.objVenda.fltDesAce := fCalcValorNovoDoc('DESACE');
    objAltDoc.objVenda.fltFreRat := fCalcValorNovoDoc('FRERAT');

    if FblnAlterouCndPag then
    begin
      objAltDoc.objVenda.strCodCnd := FstrCodCndNovo;
      objAltDoc.objVenda.strConPag := FstrCndPagNovo;
      objAltDoc.objVenda.strCodFpg := FstrCodFpgNovo;

      if fCfgSis('RECCND', varBoolean) then
      begin
        objAltDoc.blnAlterouCndPag := True;
        objAltDoc.pCarregaCondicao(objAltDoc.objVenda.strCodCnd, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);
        objAltDoc.blnRecalculaPrecos := True;
      end;
    end;

    If Not objAltDoc.fCalculaTotalPedido Then
      Exit(False);
    fltTotGer1 := objAltDoc.objVenda.fltTotGer;

    pCloneDataSet(cdsVenda, cdsVendaBkp);
    objAltDoc.objVenda.fltDesEsp := objAltDoc.qryFatGor.FieldByName('FGO_DESESP').AsFloat - fCalcValorNovoDoc('DESESP');
    objAltDoc.objVenda.fltValFre := objAltDoc.qryFatGor.FieldByName('FGO_TOTFRE').AsFloat - fCalcValorNovoDoc('VALFRE');
    objAltDoc.objVenda.fltDesAce := objAltDoc.qryFatGor.FieldByName('FGO_DESACE').AsFloat - fCalcValorNovoDoc('DESACE');
    objAltDoc.objVenda.fltFreRat := objAltDoc.qryFatGor.FieldByName('FGO_FRERAT').AsFloat - fCalcValorNovoDoc('FRERAT');

    if FblnAlterouCndPag then
    begin
      objAltDoc.objVenda.strCodCnd := FstrCodCndBkp;
      objAltDoc.objVenda.strConPag := FstrCndPagBkp;
      objAltDoc.objVenda.strCodFpg := FstrCodFpgBkp;

      if fCfgSis('RECCND', varBoolean) then
      begin
        objAltDoc.blnAlterouCndPag := True;
        objAltDoc.pCarregaCondicao(objAltDoc.objVenda.strCodCnd, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);
        objAltDoc.blnRecalculaPrecos := True;
      end;
    end;

    pAcertarQuantidadeDocOriginal;
    If Not objAltDoc.fCalculaTotalPedido Then
      Exit(False);
    fltTotGer2 := objAltDoc.objVenda.fltTotGer;

    objCampoTabela := fCampoTabela(['CND_FATMIN', 'CND_FATMAX'], 'CADCND', ['CND_CODIGO'], [objAltDoc.objVenda.strCodCnd]);
    fltFatMin := objCampoTabela.FieldByName('CND_FATMIN').AsFloat;
    fltFatMax := objCampoTabela.FieldByName('CND_FATMAX').AsFloat;

    blnTravar := (fFormataFloat(fltTotGer1, 2) < fFormataFloat(fltFatMin, 2)) or
                 (fFormataFloat(fltTotGer2, 2) < fFormataFloat(fltFatMin, 2));

    If (Not blnTravar) Then
      Exit;

    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.objMsgLibera.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Valor do Documento Fora do Intervalo Permitido:');
      objLiberacao.objMsgLibera.pAddSeparador(100);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor mínimo permitido ', FormatFloat('#,##0.00', fFormataFloat(fltFatMin, 2)), 35);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor máximo permitido ', FormatFloat('#,##0.00', fFormataFloat(fltFatMax, 2)), 35);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valores dos pedidos desmembrados ', EmptyStr, 35);
      objLiberacao.objMsgLibera.pAddTextoCaption( 'Documento (01) ', FormatFloat('#,##0.00', fltTotGer1), 35);
      objLiberacao.objMsgLibera.pAddTextoCaption( 'Documento (02) ', FormatFloat('#,##0.00', fltTotGer2), 35);
      objLiberacao.strDirAce := 'INTFAT';
      objLiberacao.strDirAceAuxiliar := 'INTFAT' + objAltDoc.objVenda.strCodCnd + fltTotGerSav.ToString;
      objLiberacao.strSenLib := fCfgSis('SENLBD');
      objLiberacao.strMsgSen := 'Liberação de Venda';
      objLiberacao.strCodOpe := objAltDoc.objVenda.strCodVen;
      objLiberacao.strCodDig := objAltDoc.objVenda.strCodDig;
      Result := objAltDoc.objVenda.fFatMensagemLiberacao(objLiberacao);
    Finally
      FreeAndNil(objLiberacao);
    End;
  Finally
    objAltDoc.objVenda.fltTotGer := fltTotGerSav;
    objAltDoc.objVenda.fltTotDes := fltTotDesSav;
    objAltDoc.objVenda.fltFreDig := fltFreDigSav;
    objAltDoc.objVenda.fltPorDes := fltPorDesSav;
    objAltDoc.objVenda.strEspDoc := strEspDocSav;
    objAltDoc.objVenda.fltDesEsp := fltDesEspSav;
    objAltDoc.objVenda.fltValFre := fltValFreSav;
    objAltDoc.objVenda.fltFreRat := fltFreRatSav;
    objAltDoc.objVenda.fltValAdt := fltValAdtSav;
    objAltDoc.objVenda.fltDesAce := fltDesAceSav;
    objAltDoc.objVenda.fltTaxEnt := fltTaxEntSav;
    objAltDoc.objVenda.strEspOrc := strEspOrcSav;
    objAltDoc.objVenda.strNumOrc := strNumOrcSav;
    objAltDoc.objVenda.strEmpOri := strEmpOriSav;
    objAltDoc.objVenda.strCodCnd := strCodCndSav;
    objAltDoc.objVenda.strConPag := strConPagSav;
    objAltDoc.objVenda.strCodFpg := strCodFpgSav;
    objAltDoc.blnAlterouCndPag := blnAlterouCndPagSav;
    objAltDoc.blnRecalculaPrecos := blnRecalculaPrecosSav;
    objAltDoc.objVenda.fltFreSug := fltFreSugSav;
    objAltDoc.objVenda.fltFreCot := fltFreCotSav;
    pCloneDataSet(cdsVenda, cdsVendaBkp);
    objAltDoc.fCalculaTotalPedido;
  End;
end;

procedure TfrmFatDesmembrarPedido.pDesmembrarPedidosUsandoMesmoCliente;
  Var
    strNumDocNovo,
    strEspDocNovo,
    strEspDocOld,
    strTipFatOld: String;
    dtaGraPedOld,
    dtaPrevisOld,
    dtaOriOld: TDateTime;
    blnSolicitouFecharOREmPD: Boolean;
begin
  blnSolicitouFecharOREmPD := False;
  strEspDocOld := objAltDoc.objVenda.strEspDoc;
  strTipFatOld := objAltDoc.objVenda.strTipFat;
  dtaGraPedOld := objAltDoc.objVenda.dtaGraPed;
  dtaPrevisOld := objAltDoc.objVenda.dtaPrevis;
  dtaOriOld    := objAltDoc.objVenda.dtaDtaOri;

  If Not fValidouFaturamentoMinimo Then
    Exit;

  pCloneDataSet(cdsVenda, cdsVendaBkp);//Restaura o backup

  pAcertarQuantidadeDocNovo;

  If fCfgSis('USAPDV', varBoolean) And (edtEspDoc.Text = 'OR') And
    (fEmptyStr(objAltDoc.objVenda.strProspe)) And
    IIF(Not fPermiteItemEspecial('PD'), Not fTemItemEspecialOrcamento(edtNumDoc.Text,
                                                                      objAltDoc.objVenda.strEmpDoc), True) And
    ((objAltDoc.objVenda.fRetornaStatusClienteVenda(edtCodCli.Text) = 'A') Or
     (Not fCfgSis('PTRASC', varBoolean))) Then
  Begin
    If (fMensagem('', 'Gravar como: ', ['&Orçamento', '&Pedido']) = 2) Then
    Begin
      blnSolicitouFecharOREmPD := True;
      objAltDoc.objVenda.blnSolicitouFecharOREmPD := True;
      objAltDoc.objVenda.strEspDoc := 'PD';
      objAltDoc.objVenda.strTipFat := 'PEDIDO';

      If fEmptyStr(objAltDoc.objVenda.strTipPed) and (not (fDefinirTipoDeDocumentoNaExpedicao(VS_strCodEmp))) Then
        objAltDoc.objVenda.strTipPed := 'A';
    End;
  End;

  if objAltDoc.objVenda.strEspDoc = 'PD' then
  begin
    If fCfgSis('DTORPD', varBoolean) Then
    Begin
     objAltDoc.objVenda.dtaGraPed := objAltDoc.objVenda.dtaDtaEntOri;
     objAltDoc.objVenda.dtaPrevis := objAltDoc.objVenda.dtaPreVisOri;
    End
    Else
    Begin
     objAltDoc.objVenda.dtaGraPed := VS_Date;
     objAltDoc.objVenda.dtaHorPed := fRetHoraServidor;
     objAltDoc.objVenda.dtaDtaOri := VS_Date;

     If objAltDoc.objVenda.dtaPreVis < objAltDoc.objVenda.dtaGraPed Then
       objAltDoc.objVenda.dtaPreVis := objAltDoc.objVenda.dtaGraPed;
    End;
  end;

  objAltDoc.objVenda.blnDesmembrarOrPd := True;
  objAltDoc.objVenda.blnImprimeSep := True;

  objAltDoc.objVenda.blnVaiApagarPdOriginalNoDesmembramentoRegEsp :=
    objAltDoc.objVenda.fEhDesmembramentoExpedicaoRegimeEspecial And
    objAltDoc.objVenda.fFatPedidoOutraLojaEmPedidoComEntCDOndeCDEhLojaAtual(objAltDoc.objVenda.arrMatItens);

  objAltDoc.objVenda.strNumOrigem := objAltDoc.objVenda.strNumOrc;
  objAltDoc.objVenda.strEspOrigem := objAltDoc.objVenda.strEspOrc;
  objAltDoc.objVenda.strEmpOrigem := objAltDoc.objVenda.strEmpOri;

  objAltDoc.objVenda.strNumOrc := '';//Necessario para gravar um novo documento
  objAltDoc.objVenda.strEspOrc := '';//Necessario para gravar um novo documento

  objAltDoc.objVenda.fltDesEsp := fCalcValorNovoDoc('DESESP');
  objAltDoc.objVenda.fltValFre := fCalcValorNovoDoc('VALFRE');
  objAltDoc.objVenda.fltDesAce := fCalcValorNovoDoc('DESACE');
  objAltDoc.objVenda.fltFreRat := fCalcValorNovoDoc('FRERAT');

  If (Length(arrIteExpPed) = 0) Then
  Begin
    objAltDoc.blnPerguntaSeRecalculaVolume := True;
    objAltDoc.blnRecalculaVolumeDireto := False;
  End;

  objAltDoc.objVenda.strComplementoFrmLogGor := '('+cmbOpcFinalizacao.Text +' pDesmembrarPedidosUsandoMesmoCliente (1)'+')';

  if FblnAlterouCndPag then
  begin
    objAltDoc.objVenda.strCodCnd := FstrCodCndNovo;
    objAltDoc.objVenda.strConPag := FstrCndPagNovo;
    objAltDoc.objVenda.strCodFpg := FstrCodFpgNovo;

    if fCfgSis('RECCND', varBoolean) then
    begin
      objAltDoc.blnAlterouCndPag := True;
      objAltDoc.pCarregaCondicao(objAltDoc.objVenda.strCodCnd, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);
      objAltDoc.blnRecalculaPrecos := True;
    end;
  end;

  objAltDoc.objVenda.blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada := fCfgSis('DPDAFP', varBoolean);

  If (Not fEmptyStr(strInRqCp)) Or (fCfgSis('PDOPRC', varBoolean)) Then
  Begin
    objAltDoc.objVenda.blnApagarRequisicaoCompra := False;
  End;

  If objAltDoc.fCalculaTotalPedido And objAltDoc.fGravarPedido Then
  Begin
    If fCfgSis('DPDAFP', varBoolean) Then
    Begin
      TAdiantamento.pDesmembraAdiantamento(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                           objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                           objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                           objAltDoc.objVenda.strNumDoc,
                                           objAltDoc.objVenda.strEspDoc,
                                           objAltDoc.objVenda.strEmpDoc,
                                           objAltDoc.qryFatGor.FieldByName('FGO_VLRCON').AsFloat,
                                           objAltDoc.objVenda.fltTotGer);
    End;

    strNumDocNovo := objAltDoc.objVenda.strNumDoc;
    strEspDocNovo := objAltDoc.objVenda.strEspDoc;

    If blnSolicitouFecharOREmPD Then
    Begin
      objAltDoc.objVenda.blnSolicitouFecharOREmPD := False;
      objAltDoc.objVenda.strEspDoc := strEspDocOld;
      objAltDoc.objVenda.strTipFat := strTipFatOld;
      objAltDoc.objVenda.dtaGraPed := dtaGraPedOld;
      objAltDoc.objVenda.dtaDtaOri := dtaOriOld;
      objAltDoc.objVenda.dtaPrevis := dtaPrevisOld;
    End;

    pCloneDataSet(cdsVenda, cdsVendaBkp);//Restaura o backup

    objAltDoc.objVenda.strNumOrc := edtNumDoc.Text;//Necessario para gravar alterar o documento
    objAltDoc.objVenda.strEspOrc := edtEspDoc.Text;//Necessario para gravar alterar o documento

    if FblnAlterouCndPag then
    begin
      objAltDoc.objVenda.strCodCnd := FstrCodCndBkp;
      objAltDoc.objVenda.strConPag := FstrCndPagBkp;
      objAltDoc.objVenda.strCodFpg := FstrCodFpgBkp;

      if fCfgSis('RECCND', varBoolean) then
      begin
        objAltDoc.blnAlterouCndPag := True;
        objAltDoc.pCarregaCondicao(objAltDoc.objVenda.strCodCnd, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);
        objAltDoc.blnRecalculaPrecos := True;
      end;
    end;

    objAltDoc.objVenda.strNumOrigem := '';
    objAltDoc.objVenda.strEspOrigem := '';
    objAltDoc.objVenda.strEmpOrigem := '';

    With objAltDoc.qryFatGor Do
    Begin
      objAltDoc.objVenda.fltDesEsp := FieldByName('FGO_DESESP').AsFloat - fCalcValorNovoDoc('DESESP');
      objAltDoc.objVenda.fltValFre := FieldByName('FGO_TOTFRE').AsFloat - fCalcValorNovoDoc('VALFRE');
      objAltDoc.objVenda.fltDesAce := FieldByName('FGO_DESACE').AsFloat - fCalcValorNovoDoc('DESACE');
      objAltDoc.objVenda.fltFreRat := FieldByName('FGO_FRERAT').AsFloat - fCalcValorNovoDoc('FRERAT');
    End;

    If Not fEmptyStr(strInRqCp) Then
    Begin
      objAltDoc.objVenda.strInRqCp := strInRqCp;
      objAltDoc.objVenda.pCarregaItensMovRcd;
    End;

    objAltDoc.objVenda.pBackupExpRet(edtNumDoc.Text,
                                     edtEspDoc.Text,
                                     edtCodEmp.Text);

    pAcertarQuantidadeDocOriginal;

    objAltDoc.objVenda.strComplementoFrmLogGor := '('+cmbOpcFinalizacao.Text +' pDesmembrarPedidosUsandoMesmoCliente (2)'+')';

    If Not fEmptyStr(strInRqCp) Then
    Begin
      objAltDoc.objVenda.blnApagarRequisicaoCompra := False;
    End;

    If objAltDoc.fCalculaTotalPedido And objAltDoc.fGravarPedido Then
    Begin
      pAcertaNumeroPedidoItensRequisicaoCompra(strNumDocNovo);
      pReprocessaSaldoAmbosPedidos(strNumDocNovo);

      If (objAltDoc.objVenda.blnApagaPedOrcOrigem) Then
      Begin
        pAcertaMensagem(strNumDocNovo, strEspDocNovo, objAltDoc.objVenda.strNumDoc, objAltDoc.objVenda.strEspDoc);
        pMensagemOk('Documento '+strNumDocNovo+'-'+strEspDocNovo+' e '+objAltDoc.objVenda.strNumDoc+'-'+objAltDoc.objVenda.strEspDoc+' emitidos com sucesso!');
      End
      Else
      Begin
        If (objAltDoc.objVenda.strNumOrc <> edtNumDoc.Text) And
           (objAltDoc.objVenda.strEspOrc <> edtEspDoc.Text) Then
        Begin
          pMensagemOk('Atenção o sistema não alterou o documento original e criou um segundo pedido: '
                      +objAltDoc.objVenda.strNumOrc+'-'+objAltDoc.objVenda.strEspOrc+#10#13
                      +'Exclua os pedidos criados em duplicidade e entre em contato com a Citel caso consiga reproduzir novamente esse erro!');
        End
        Else
        Begin
          pMensagemOk('Documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + ' alterado com sucesso!');
        End;

        pMensagemOk('Documento ' + strNumDocNovo  + '-' + IIF(blnSolicitouFecharOREmPD, 'PD', edtEspDoc.Text) + ' emitido com sucesso!' );
      End;

      objAltDoc.objVenda.pMostraDocumentosGerados;

      pLimparTela;
      pFecharDesmExpedicao(True);
    End
    Else
    Begin
      pExcluirNovoDocumentoGerado(strNumDocNovo);
      pMensagemOk('Não foi possível alterar o documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + '!');

      pFecharDesmExpedicao(False);
    End;
  End
  Else Begin
    pMensagemOk('Não foi possível gerar o novo documento!');

    pFecharDesmExpedicao(False);
  End;
end;

procedure TfrmFatDesmembrarPedido.pDesmembrarPedidosVendaPerdida;
var
  strNumDocNovo: String;
begin
  if fIncluiVendaPerdida(strNumDocNovo) then
  begin

    pAcertarQuantidadeDocOriginal;

    objAltDoc.objVenda.blnDesmembrarOrPd := True;

    objAltDoc.objVenda.blnVaiApagarPdOriginalNoDesmembramentoRegEsp :=
      objAltDoc.objVenda.fEhDesmembramentoExpedicaoRegimeEspecial And
      objAltDoc.objVenda.fFatPedidoOutraLojaEmPedidoComEntCDOndeCDEhLojaAtual(objAltDoc.objVenda.arrMatItens);

    objAltDoc.objVenda.strComplementoFrmLogGor := '('+cmbOpcFinalizacao.Text +' pDesmembrarPedidosVendaPerdida'+')';

    objAltDoc.objVenda.blnEmGeracaoVendasPerdidas := True;

    objAltDoc.objVenda.strEmpDoc := objAltDoc.strEmpPed;
    objAltDoc.objVenda.strPedEmp := objAltDoc.strEmpPed;

    VS_blnTraceErrorMessage := blnVendaPerdidaAutomatica;

    If objAltDoc.fCalculaTotalPedido And objAltDoc.fGravarPedido Then
    Begin
      If not blnVendaPerdidaAutomatica then
      begin
        pMensagemOk('Documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + ' alterado com sucesso!' + sLineBreak +
                    'Venda Perdida ' + strNumDocNovo + ' emitida com sucesso!' );
      end;
      pLimparTela;

      pFecharDesmExpedicao(True);
    End
    else
    begin
      pExcluirNovaVendaPerdidaGerada(strNumDocNovo);
      If (VS_strAllErrorsMessages.IsEmpty) Then
        pMensagemOk('Não foi possível alterar o documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + '!')
      Else
        pMensagemSonora('Não foi possível alterar o documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + '!' + sLineBreak +
                        'Motivos: ' + sLineBreak + VS_strAllErrorsMessages);
      pFecharDesmExpedicao(False);
    end;
  End
  Else
  Begin
    pMensagemOk('Não foi possível gerar a venda perdida!');
    pFecharDesmExpedicao(False);
  End;
end;

procedure TfrmFatDesmembrarPedido.pCopiarQuantidadeOriginal;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If (fCfgSis('DPDAFP', varBoolean)) And (cdsDados.FieldByName('STATUSITEM').AsString <> AGUARDANDO_SEPARACAO) Then
      Begin
        cdsDados.Next;
        Continue;
      End;

      cdsDados.Edit;
      cdsDados.FieldByName('ITE_QTDITE').AsFloat := cdsDados.FieldByName('ITE_QTDORI').AsFloat;
      cdsDados.Post;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
    pAtualizarLabelQtdProd;
  End;
end;

function TfrmFatDesmembrarPedido.fCalcValorNovoDoc(strCampo: String): Double;
begin
  Result := 0.00;

  With cdsDados Do
  Begin
    First;
    While Not Eof Do
    Begin
      If cdsInfAdcItem.Locate('ITE_SEQDET', FieldByName('ITE_SEQDET').AsString, []) Then
      Begin
        Result := Result + fFormataFloat(cdsInfAdcItem.FieldByName('ITE_' + strCampo).AsFloat *
                                         FieldByName('ITE_QTDITE').AsFloat /
                                         FieldByName('ITE_QTDORI').AsFloat , 2);
      End;
      Next;
    End;
  End;

end;

function TfrmFatDesmembrarPedido.fCarregarDocumento(strNumPed, strEspPed,
  strEmpPed: String): Boolean;
begin
  Result := False;

  edtNumDoc.Text := strNumPed;
  edtEspDoc.Text := strEspPed;
  edtCodEmp.Text := strEmpPed;

  If blnCRM Then
  Begin
    If fVerificaCampos() Then
      Result := True;
  End
  Else
  Begin
    Result := fCarregarDocumento();
    cxgItens.Enabled := Result;
  End;
end;

procedure TfrmFatDesmembrarPedido.pEnviarEmailPedidoFaltaEstoqueGerado(strVendedor, strNovoPedido, strItensAlterados: String);
  Var
    strTexto: String;
    strEmail: String;
    arrDestinatarios,
    arrArquivos: TStringArray;
begin
  strEmail := fCampoTabela('OPE_E_MAIL', 'CADOPE', ['OPE_CODOPE'], [strVendedor]);
  strVendedor := strVendedor + '-' + fRetNomeOperador(strVendedor);

  strTexto := 'Prezado Vendedor ' + strVendedor + ', ' + STRING_ENTER +
              STRING_ENTER +
              'Foi gerado um desmembramento de corte de pedido por falta de estoque. ' + STRING_ENTER +
              STRING_ENTER +
              ' - Pedido alterado: ' + edtNumDoc.Text + '-' + edtEspDoc.Text + STRING_ENTER +
              ' - Pedido de corte: ' + strNovoPedido  + '-' + edtEspDoc.Text + STRING_ENTER +
              STRING_ENTER + strItensAlterados;

  pCriarArrayAnexosEDestinatarios('', strEmail, arrDestinatarios, arrArquivos);

  TEnvioEmail.EnviarEmail(Application.GetParentComponent(),
                          strLoginUsuarioLogado,
                          'Desmembramento de corte de pedido de venda ' + edtNumDoc.Text,
                          arrDestinatarios,
                          [],
                          [],
                          TEnvioEmail.ContruirArrayMensagem(strTexto),
                          arrArquivos);
end;

procedure TfrmFatDesmembrarPedido.pEnviarMensagemCorteParaDigitador(strMsg: String);
  Var
    msgInterna: TMsgInterna;
begin
  msgInterna := TMsgInterna.Create(nil);

  msgInterna.fEnviaMensagem('Desmembramento de corte de Pedido de venda por falta de estoque (' +
    edtNumDoc.Text + '-' + edtEspDoc.Text + '-' + edtCodEmp.Text + ')', strMsg,
      strLoginUsuarioLogado, IIF(Not fEmptyStr(objAltDoc.qryFatGor.FieldByName('FGO_CODDIG').AsString),
                                 objAltDoc.qryFatGor.FieldByName('FGO_CODDIG').AsString,
                                 objAltDoc.qryFatGor.FieldByName('FGO_CODVEN').AsString), 'N', '');

  FreeAndNil(msgInterna);
end;

procedure TfrmFatDesmembrarPedido.pEscapePressed;
begin
  If (ActiveControl <> edtNumDoc) Then
    pLimparTela
  Else
    inherited;
end;

function TfrmFatDesmembrarPedido.fIncluiVendaPerdida(var strCodigo: String): Boolean;
const
  OBS = 'Venda perdida gerada no desmembramento do pedido de venda %s';
var
  strDocumento: String;
Begin
  strCodigo := fAtualizaProCod('MOVVPG', 'VPG_CODIGO');

  pIncluiMovVpg(
    strCodigo,                    // strCodigo,
    objAltDoc.objVenda.strCodCli, // strCodCli,
    objAltDoc.objVenda.strCodVen, // strCodVen,
    '',                           // strCpfCon: String;
    VS_Date,                      // dtaDtaCad: TDate;
    objAltDoc.objVenda.strNumDoc,                           // strNumDoc,
    objAltDoc.objVenda.strEspDoc,                           // strEspDoc,
    '',                           // strSerie: String;
    fRetornaOrigemDesmembramento);                   // strOrigem: String = '');

  cdsDados.DisableControls;
  cdsDados.First;
  Try
    strDocumento := objAltDoc.objVenda.strNumOrc + '-' + objAltDoc.objVenda.strEspOrc + '-' + objAltDoc.objVenda.strEmpDoc;

    While Not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0 Then
      Begin
        pIncluiMovVpd(
          strCodigo,                                    // strCodigo,
          cdsDados.FieldByName('ITE_CODITE').AsString,  // strCodIte,
          cdsDados.FieldByName('ITE_DESITE').AsString,  // strDesIte,
          fCfgSis('DMPMVP', varString),                 // strMotivo: String;
          cdsDados.FieldByName('ITE_QTDITE').AsFloat,   // fltQtdIte,
          cdsDados.FieldByName('ITE_UNIORI').AsFloat,   // fltUniOri,
          cdsDados.FieldByName('ITE_UNITAR').AsFloat,   // fltUnitar,
          cdsDados.FieldByName('ITE_QTDITE').AsFloat * cdsDados.FieldByName('ITE_UNITAR').AsFloat, // fltTotIte: Double;
          Format(OBS, [strDocumento]),                  // strObserv: String = '';
          '',                                           // strCodCon: String = '';
          0,                                            // fltVlrCon: Double = 0);
          cdsDados.FieldByName('ITE_NUMCMP').AsString);
      End;
      cdsDados.Next;
    End;
  Finally
    cdsDados.First;
    cdsDados.EnableControls;
  End;

  Result := True;
end;

function TfrmFatDesmembrarPedido.fIncluiRequisicaoCompra(
  var strCodigo: String): Boolean;
const
  OBS = 'Requisição de compra gerada através da rotina de desmembramento referente ao pedido de venda %s';
var
  cdsMovRcd: TUniClientDataSet;
  qryMovRcd: TUniQuery;
  strDocumento: String;
begin
  qryMovRcd := fCriaQuery();
  try
    qryMovRcd.SQL.Add('SELECT * FROM MOVRCD WHERE 1 = 2');
    qryMovRcd.Open;

    cdsMovRcd := fCriaClientDatset(qryMovRcd, True);
  finally
    FreeAndNil(qryMovRcd);
  end;

  try
    cdsDados.DisableControls;
    cdsDados.First;
    Try
      strDocumento := objAltDoc.objVenda.strNumOrc + '-' + objAltDoc.objVenda.strEspOrc + '-' + objAltDoc.objVenda.strEmpDoc;
      While Not cdsDados.Eof Do
      Begin
        If cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0 Then
        Begin
          cdsMovRcd.Insert;
          cdsMovRcd.FieldByName('RCD_CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
          cdsMovRcd.FieldByName('RCD_DESITE').AsString := cdsDados.FieldByName('ITE_DESITE').AsString;
          cdsMovRcd.FieldByName('RCD_OBSERV').AsString := Format(OBS, [strDocumento]);
          cdsMovRcd.FieldByName('RCD_DOCPDV').AsString := objAltDoc.objVenda.strNumDoc;
          cdsMovRcd.FieldByName('RCD_ESPPDV').AsString := objAltDoc.objVenda.strEspDoc;
          cdsMovRcd.FieldByName('RCD_EMPPDV').AsString := objAltDoc.objVenda.strEmpDoc;
          cdsMovRcd.FieldByName('RCD_QTDITE').AsFloat  := cdsDados.FieldByName('ITE_QTDITE').AsFloat;
          cdsMovRcd.Post;
        End;
        cdsDados.Next;
      End;
    Finally
      cdsDados.First;
      cdsDados.EnableControls;
    End;

    Result := TfrmFatRequisicaoCompras.fGravaRequisicaoCompra(
      strCodigo,
      objAltDoc.objVenda.strCodCli,
      objAltDoc.objVenda.strCodVen,
      objAltDoc.objVenda.strCliCgc,
      cdsMovRcd,
      False);
  finally
    FreeAndNil(cdsMovRcd);
  end;
end;

function TfrmFatDesmembrarPedido.fValidaRequisicaoCompra: Boolean;
const
  MENSAGEM = 'Só é permitido gerar a requisição de compra da quantidade que não tem em estoque.';
var
  strMensagem: String;
  fltQtdMaxima: Double;
begin
  cdsDados.DisableControls;
  cdsDados.First;
  Try
    strMensagem := EmptyStr;
    While Not cdsDados.Eof Do
    Begin
      If (cdsDados.FieldByName('ITE_QTDITE').AsFloat > 0) then
      begin
        if cdsDados.FieldByName('ITE_SALDIS').AsFloat >= cdsDados.FieldByName('ITE_QTDORI').AsFloat then
          fltQtdMaxima := 0
        else
          fltQtdMaxima := cdsDados.FieldByName('ITE_QTDORI').AsFloat - cdsDados.FieldByName('ITE_SALDIS').AsFloat;

        if (cdsDados.FieldByName('ITE_QTDITE').AsFloat > fltQtdMaxima) Then
        begin
          strMensagem := strMensagem + sLineBreak +
            '|' + cdsDados.FieldByName('ITE_CODITE').AsString.PadRight(5) + '|' +
            Copy(cdsDados.FieldByName('ITE_DESITE').AsString, 1, 30).PadRight(35) + '|' +
            FormatFloat('##,#0.000', cdsDados.FieldByName('ITE_SALDIS').AsFloat).PadLeft(15) + '|' +
            FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsDados.FieldByName('ITE_QTDORI').AsFloat).PadLeft(15) + '|' +
            FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), fltQtdMaxima).PadLeft(15) + '|' +
            FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsDados.FieldByName('ITE_QTDITE').AsFloat).PadLeft(15) + '|';

        end;
      end;

      cdsDados.Next;
    End;

    Result := fEmptyStr(strMensagem);

    if not Result then
    begin
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      Try
        frmMensagemExplicativa.Caption := 'Quantidade máxima permitida para requisição de compra';
        frmMensagemExplicativa.Width   := 1024;
        frmMensagemExplicativa.Height  := 500;
        frmMensagemExplicativa.mmoInstru.Font.Style := [];
        frmMensagemExplicativa.mmoInstru.Lines.Text :=
          MENSAGEM + sLineBreak + sLineBreak +
          '|' + 'Item'.PadRight(5) + '|' +
          'Descrição'.PadRight(35) + '|' +
          'Sal. Disponível'.PadLeft(15) + '|' +
          'Qtde. Pedido'.PadLeft(15) + '|' +
          'Qtde. Máx. Req.'.PadLeft(15) + '|' +
          'Qtde. Informada'.PadLeft(15) + '|' +
          strMensagem;

        frmMensagemExplicativa.ShowModal;
      finally
        pFreeAndNil(frmMensagemExplicativa);
      End;
    end;

  Finally
    cdsDados.First;
    cdsDados.EnableControls;
  End;
end;

end.
