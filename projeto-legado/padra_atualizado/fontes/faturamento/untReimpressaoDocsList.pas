unit untReimpressaoDocsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  StrUtils, untReimpressao, Uni, DB, AppEvnts, frxDBSet, UniClientDataSet, Printers,
  BitBtnLockedIncrem, DateUtils, frxClass, frxExportCSVTestabilidade, dxScreenTip,
  cxClasses, dxCustomHint, cxHint, untFatGeraPdfEmail, untLiberacao, untTypesSistema,
  untImagemBase64, untOpcoesDocEnvioEmail;

type
  TfrmReimpressaoDocsList = class(TfrmPai)
    pnlFundo: TPanel;
    dbgDocumentos: TDBGridCitel;
    lblSelecione: TLabel;
    lblBusca: TLabel;
    lblDocConf: TLabel;
    lblDocFat: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mnuOperacoesNfe: TPopupMenu;
    mnuReimprimirDanfe: TMenuItem;
    lblOpeNfe: TLabel;
    mnuNotaSubstituicaoNFSe: TMenuItem;
    HintControler: TcxHintStyleController;
    lblVolPed: TLabel;
    lblVendedores: TLabel;
    mnuGerarDanfePDF: TMenuItem;
    mnuReimprimirTermoAceiteCV: TMenuItem;
    mnuTermoTinta: TMenuItem;
    lblDocDev: TLabel;
    lblEnvWpp: TLabel;
    mnuEndEntr: TMenuItem;
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuReimprimirDanfeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuNotaSubstituicaoNFSeClick(Sender: TObject);
    procedure dbgDocumentosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgDocumentosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure mnuGerarDanfePDFClick(Sender: TObject);
    procedure mnuOperacoesNfePopup(Sender: TObject);
    procedure mnuReimprimirTermoAceiteCVClick(Sender: TObject);
    procedure mnuTermoTintaClick(Sender: TObject);
    procedure mnuEndEntrClick(Sender: TObject);
    procedure dbgDocumentosCellClick(Column: TColumn);
  private
    { Private declarations }
    intMouseY, intMouseX: Integer;
    objLiberacao : TLiberacao;
    strPrgPor : String;
    strNomCliSel : String;
    blnEndEnt: Boolean;
    enumOpReimpPdOr : TOpcaoPedido;

    procedure pMostraDocumentosConfirmados;
    procedure pMostraDocumentosFaturados;
    procedure pMostraDocumentosDevolvidos;
    procedure pMostraVendedoresDocumento;
    procedure pImprimirDocumento;
    procedure pEnviarDocPorEmail;
    procedure pVisualizarDocumento;
    procedure pOnDataChange(Sender: TObject; Field: TField);

    Function fReimprimeDocumento(blnVisualizar, blnF10: Boolean; Var opcEdtFstImp: TOpcEditorFast): Boolean;

    procedure pGravaNumeroNotaSubstituida;
    procedure pLimpaMovObs;
    procedure pEnviarNotaSubstituicao(strNovoNumero: String);
    procedure pMudarNumeroDocumento(strNovoNumero: String);
    procedure pReimprimirNFCe(blnGerarPDF: Boolean = False);
    procedure pReimprimeVolumesPedido;
    function fPermitirReimpressaoPedOrdProd(): Boolean;
    function fPermiteReimpressaoNaoAutorizados: Boolean;

    function fEhEmissaoDeNotaDeServicoPeloNfeImpressao: boolean;
    function fEhEmissaoDeNotaDeProdutoPeloNfeImpressao(strEmpresa: String): boolean;
    function fEhEmissaoDeCupomFiscalPeloNfeImpressao: boolean;
    function fGeraArquivoConfirmacao(strAutoInc : String; strPath : String; var arrArquivos: TStringArray) : Boolean;
    function fMontaArquivosConfirmacao(strAutInc, strNumDoc, strEmpDoc, strEspDoc, strCodCli : String; Var strPath : String) : String;
    function fMontaArquivosXML(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTipFC, strNumSer, strPath: String;
     blnExibiMsg: Boolean = True): String;
    function fMontaPDFDANFeNFCe(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTipFC: String; Var strNumSer: String; strPath : String; blnGerandoParaDisparoDeGatilho: Boolean):String;
    function fBuscaBoletos(strNumDoc, strEmpDoc, strEspDoc, strCodCli : String): String;
    procedure pApagarArquivosConfirmacao(strPath : String; arrArquivos: TStringArray);
    function fValidaDireitoAcessoReimprimirDanfe: Boolean;
    function fValidaDireitoAcessoGerarDanfe: Boolean;
    function fImprimeTermoAceite: Boolean;
    procedure pExibirListaDocumentosNaoDigitalizados(const strMensagem: String);

    function fGerarPDFDanfe(const blnAbrirPDF: Boolean=True;
      const strCaminhoArquivo: String=''; blnExibiMsg: Boolean = True; blnGerandoParaDisparoDeGatilho: Boolean = False): String;

    procedure pEnviarEmail(const strEspDoc, strAssunto : String; const arrDestinatarios,
          arrCorpoMensagem, arrArquivos: TStringArray; ADadosAutenticacao: TDadosLoginEmail;
          const blnHabilitarDivisaoAnexosPorEmail: Boolean=False);

    function fDocumentoOrigemFF_DV_TR(const strAutInc, strNumDoc, strEspDoc,
      strCodEmp, strCodCli: String): Boolean;

    function fEhBoletoCarneReimpressaoMonitorAtivo: Boolean;
    procedure pEnviarDocPorWhatsapp;
    function fEnviaWhatsapp: Boolean;
    function fDocumentoAutorizado: Boolean;

    function VerificaSeArquivoBoletoExiste(ADataset: TDataset;
                                           ACaminhoArquivo: String;
                                           var ANomeArquivo: String): Boolean;
    procedure pReimprimirCupEndEnt;

    function RetornaDadosPixPedido: TUniClientDataset;
    procedure HabOpcoesEnvioEmail(var recExibirOpcoes : TExibirOpcoesReimpressao);
    function fProcessouBoletos(var stlCadRecs : TStringList): Boolean;
    function fTemBoletoASerImpresso(const cdsDocumento : TUniClientDataSet; var stlCadRecs : TStringList): Boolean;
  public
    { Public declarations }
    reiReimpressao : TReimpressao;
    cdsGenDoc      : TUniClientDataSet;
    dtsGenDoc      : TDataSource;
    blnSoConsulta  : Boolean;

    intConfirmando : Integer;
    blnReabrir: Boolean;
    intRecNo: Integer;
  end;

var
  frmReimpressaoDocsList: TfrmReimpressaoDocsList;

implementation

uses  untQckFatImpNFCe, untfuncoesSimples, untReimpressaoDocsBusca, untGravando,
      untConstantes, untPesqAux, untDigEmail, untFuncoesGenerica,
      untLibNfe, untComprovanteServicosExecutar, untWord,
      untFatExpedicaoItens, untFatGor, untFuncFat,
      untTEnvioEmail, untQckFatImp40Col2Comprov, untFuncoes, VirtualUI_SDK,
      untCfgRel, untFuncFatTypes,frxDMPClass, untFuncoesEditorFast, untFuncoesRel,
      untFuncoesRel2, untTermoAceiteCompraVenda, untDanfePDF,
      untObservacao, untUtilMonitor, untCadRec, untBoleto,
      untIDocumento, untDocumento, untFuncoesBoleto, untFilaEContatoEnvio, untDisparaSMSAut,
      untConfirmacaoMemo;

{$R *.dfm}

function TfrmReimpressaoDocsList.fPermiteReimpressaoNaoAutorizados: Boolean;
Var
  strAcesso,
  strNumSer: String;
  blnTemPer: Boolean;

  function fEhCupomFiscal(strSerie: String): Boolean;
  Var
    qryAux: TUniQuery;
  Begin
    Result := False;

    qryAux := fCriaQuery;
    Try
      qryAux.Close;
      qryAux.SQL.Text := 'SELECT ECF_CODECF FROM CADECF WHERE ECF_NUMSER = :NUMSER';
      qryAux.ParamByName('NUMSER').AsString := strSerie;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
        Result := True;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
begin
  blnTemPer := fVerificaAcessoSistema('RENAUT');

  Result := blnTemPer;

  If blnTemPer Then
    Exit;

  If Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'IF_NF_') <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  strAcesso := fRetornaChaveAcesso(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                   cdsGenDoc.FieldByName('ESPDOC').AsString,
                                   cdsGenDoc.FieldByName('CODEMP').AsString,
                                   cdsGenDoc.FieldByName('CODCLI').AsString,
                                   cdsGenDoc.FieldByName('SERIE_').AsString,
                                   cdsGenDoc.FieldByName('TIP_FC').AsString,
                                   strNumSer);

  If cdsGenDoc.FieldByName('ESPDOC').AsString = 'IF' Then
  Begin
    If fEhCupomFiscal(strNumSer) Then
      Result := True
    Else
      Result := Not fEmptyStr(strAcesso);
  End
  Else If cdsGenDoc.FieldByName('ESPDOC').AsString = 'NF' Then
  Begin
    Result := Not fEmptyStr(strAcesso);
  End;
end;

function TfrmReimpressaoDocsList.fPermitirReimpressaoPedOrdProd: Boolean;
begin
  If (Not fEmptyStr(dtsGenDoc.DataSet.FieldByName('ORDPRO').AsString)) Then Begin
    If (Not fVerificaAcessoSistema('REIPOP', strLoginUsuarioLogado)) Then Begin
      objLiberacao.Clear;

      objLiberacao.objMsgLibera.pAddTexto('Operador sem permissão para reimpressão de Pedido de Ordem de Produção');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTextoCaption('Data'      , dtsGenDoc.DataSet.FieldByName('DTAENT').AsString                         , 9);
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'   , dtsGenDoc.DataSet.FieldByName('CODEMP').AsString + '-' +
                                                               fRetNomeEmpresa(dtsGenDoc.DataSet.FieldByName('CODEMP').AsString)        , 9);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'  , dtsGenDoc.DataSet.FieldByName('CODVEN').AsString + '-' +
                                                               fRetNomVendRep(dtsGenDoc.DataSet.FieldByName('CODVEN').AsString)         , 9);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'   , dtsGenDoc.DataSet.FieldByName('NOMCLI').AsString                         , 9);
      objLiberacao.objMsgLibera.pAddTextoCaption('Documento' , dtsGenDoc.DataSet.FieldByName('NUMDOC').AsString + '-' +
                                                               dtsGenDoc.DataSet.FieldByName('ESPDOC').AsString                         , 9);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor'     , FormatFloat('#,##0.00', dtsGenDoc.DataSet.FieldByName('VLRCON').AsFloat) , 9);


      objLiberacao.strDirAce := 'REIPOP';
      objLiberacao.strMsgSen := 'Reimpressão de Documentos';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;

      Result := objLiberacao.fLibera;
    End Else Result := True;
  End Else Result := True;
end;

function TfrmReimpressaoDocsList.fProcessouBoletos(
  var stlCadRecs: TStringList): Boolean;
var
  objDocumentoBoleto : TDocumento;
begin
  Result := True;
  objDocumentoBoleto := TDocumento.Create;

  If (Not objDocumentoBoleto.fGerarPDFBoleto(stlCadRecs.DelimitedText)) Then
    Exit(False);
end;

Function TfrmReimpressaoDocsList.fReimprimeDocumento(blnVisualizar, blnF10: Boolean; Var opcEdtFstImp: TOpcEditorFast): Boolean;
Var
  objPdfEma: TPdfEma;
Begin
  Result := false;

  Try
    pnlInfo.Caption := 'Aguarde, realizando a impressão...';
    Application.ProcessMessages;

    objPdfEma := TPdfEma.Create(Self);

    objPdfEma.setEdtFst(opcEmail);

    If enumOpReimpPdOr = oppPergunta Then
    Begin
      If SameText(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD') Then
      Begin
        If fMensagem('', 'Selecione o tipo de quantidade?', ['&Original', '&Pendente'], 2) = 1 Then
        Begin
          objPdfEma.blnQtdOri := True;
          enumOpReimpPdOr     := oppOriginal;
        End Else
        Begin
          objPdfEma.blnQtdOri := False;
          enumOpReimpPdOr     := oppPendente;
        End;
      End;
    End;

    objPdfEma.setPedVen(enumOpReimpPdOr);
    objPdfEma.setVeiF10(blnF10);
    objPdfEma.setSoCons(blnSoConsulta);
    objPdfEma.setVisual(blnVisualizar);
    objPdfEma.setNumDoc(cdsGenDoc.FieldByName('NUMDOC').AsString);
    objPdfEma.setEspDoc(cdsGenDoc.FieldByName('ESPDOC').AsString);
    objPdfEma.setCodEmp(cdsGenDoc.FieldByName('CODEMP').AsString);
    objPdfEma.setDocCan(cdsGenDoc.FieldByName('DOCCAN').AsString);

    If ((Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'OR_PD_') > 0) And (fCfgSis('MOVDAV') = '2')) Then
      objPdfEma.setEdtFst(opcEdtFstImp);

    If (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'RL_') > 0) And blnVisualizar Then
      objPdfEma.setEdtFst(opcVideo);

    objPdfEma.setReimpr(reiReimpressao);

    Result := objPdfEma.fReimprimeDocumento;

    opcEdtFstImp := objPdfEma.getEdtFstImp;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fReimprimeDocumento]');
    End;
  End;

  FreeAndNil(objPdfEma);

  pnlInfo.Caption := '';
End;


function TfrmReimpressaoDocsList.fTemBoletoASerImpresso(
  const cdsDocumento: TUniClientDataSet; var stlCadRecs: TStringList): Boolean;
var
  qryCadRec : TUniQuery;
  intContador: Integer;
begin
  For intContador := 0 To Pred(dbgDocumentos.SelectedRows.Count) Do
  Begin
    cdsGenDoc.GotoBookmark(dbgDocumentos.SelectedRows.Items[intContador]);
    stlCadRecs.Text := stlCadRecs.Text + GetIncrementosCadRec(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                              cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                              cdsGenDoc.FieldByName('CODEMP').AsString,
                                                              cdsGenDoc.FieldByName('CODCLI').AsString).Text;
  End;

  If (stlCadRecs.Count = 0) Then
    Exit(False);

  qryCadRec := fCriaQuery(Self);
  Try
    qryCadRec.Close;
    qryCadRec.SQL.Text := TBoleto.fGetSQLBoletos(True);
    qryCadRec.SQL.Text := StringReplace(qryCadRec.SQL.Text, 'AUTINC', fCommaText(stlCadRecs, False), []);
    qryCadRec.Open;
    Result := (qryCadRec.RecordCount > 0);
  Finally
    FreeAndNil(qryCadRec);
  End;
end;

procedure TfrmReimpressaoDocsList.dbgDocumentosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Const
  MSG_MULTI_SELECAO : String = 'Múltiplos documentos selecionados, permitido somente operações de envio de e-mail e whatsApp';

  function fEhMultiSelecao: Boolean;
  begin
    Result := dbgDocumentos.SelectedRows.Count > 1;
  end;

  function fOperacaoPermiteMultiSelecao: Boolean;
  begin
    Result := (Key in [VK_F5, VK_F9, VK_CONTROL]);
  end;

begin
  inherited;

  If fEhMultiSelecao And (Not fOperacaoPermiteMultiSelecao) Then
  Begin
    fMensagem('Atenção', MSG_MULTI_SELECAO, ['&Ok']);
    Exit;
  End;

  If (Key = VK_Return) And (Not blnSoConsulta) Then
  Begin
    dbgDocumentosDblClick(Sender);
  End

  Else If (Key = VK_F3) And (Not blnSoConsulta) Then
  Begin
    pCriarForm(TfrmReimpressaoDocsBusca,frmReimpressaoDocsBusca);
  End

  Else If (Key = VK_F4) And (lblDocConf.Visible) Then
  Begin
    TfrmGravando.fExecutarModal(pMostraDocumentosConfirmados, 'Aguarde, carregando documentos confirmados...', '');
    dbgDocumentos.Refresh;
  End

  Else If (Key = VK_F5) And (Not blnSoConsulta) and (lblEnvWpp.Visible)  Then
  Begin
    Key := 0;
    If InterlockedIncrement(intConfirmando) = 0 Then
    Begin
      Try
        TfrmGravando.fExecutarModal(pEnviarDocPorWhatsapp, 'Aguarde, enviando Whatsapp...', '');
        dbgDocumentos.Refresh;
      Finally
        InterlockedDecrement(intConfirmando);
      End;
    End
    Else
      InterlockedDecrement(intConfirmando);
  End

  Else If (Key = VK_F11) And (lblDocFat.Visible) Then
  Begin
    TfrmGravando.fExecutarModal(pMostraDocumentosFaturados, 'Aguarde, carregando documentos faturados...', '');
    dbgDocumentos.Refresh;
  End

  Else If (Key = VK_F6) And (lblDocDev.Visible) Then
  Begin
    TfrmGravando.fExecutarModal(pMostraDocumentosDevolvidos, 'Aguarde, carregando documentos devolvidos...', '');
    dbgDocumentos.Refresh;
  End

  Else If (Key = VK_F8) And (lblVendedores.Visible) Then
  Begin
    HintControler.HideHint;
    TfrmGravando.fExecutarModal(pMostraVendedoresDocumento, 'Aguarde, carregando vendedores do documento...', '');
    dbgDocumentos.Refresh;
    dbgDocumentosMouseUp(dbgDocumentos, mbLeft, [], intMouseX, intMouseY);
  End

  Else If (Key = VK_F9) And (Not blnSoConsulta) and (Label2.Visible)Then
  Begin
    Key := 0;
    If InterlockedIncrement(intConfirmando) = 0 Then
    Begin
      Try
        TfrmGravando.fExecutarModal(pEnviarDocPorEmail, 'Aguarde, carregando documento para envio de E-mail...', '');
        dbgDocumentos.Refresh;
      Finally
        InterlockedDecrement(intConfirmando);
      End;
    End
    Else
      InterlockedDecrement(intConfirmando);
  End

  Else If Key = VK_F10 Then
  Begin
    Key := 0;
    If InterlockedIncrement(intConfirmando) = 0 Then
    Begin
      Try
        TfrmGravando.fExecutarModal(pVisualizarDocumento, 'Aguarde, carregando visualização do documento...', '');
        dbgDocumentos.Refresh;
      Finally
        InterlockedDecrement(intConfirmando);
      End;
    End
    Else
      InterlockedDecrement(intConfirmando);
  End

  Else If Key = VK_F7 Then
  Begin
    If lblVolPed.Visible Then
      pReimprimeVolumesPedido;
  End

  Else If Key = VK_Escape Then
  Begin
    btnSair.Click;
  End;

end;

procedure TfrmReimpressaoDocsList.dbgDocumentosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  If lblDocConf.Visible And ((Y <= (intMouseY - 10)) Or (Y >= (intMouseY + 10))) Then
     HintControler.HideHint;

  If lblDocFat.Visible And ((Y <= (intMouseY - 10)) Or (Y >= (intMouseY + 10))) Then
     HintControler.HideHint;
end;

procedure TfrmReimpressaoDocsList.dbgDocumentosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  strMsg: String;
begin
  inherited;

  if (cdsGenDoc.Active) then
  Begin
    strMsg := EmptyStr;

    If (lblDocConf.Visible)  Then
    Begin
      strMsg := 'Esse documento possui mais que uma origem.' + sLineBreak +
                'Pressione [F4] para visualizá-las.';
    End;

    If (lblDocFat.Visible)  Then
    Begin
      if not fEmptyStr(strMsg) then
        strMsg := strMsg + sLineBreak + sLineBreak;

      strMsg := 'Esse documento possui mais que um documento faturado.' + sLineBreak +
                'Pressione [F11] para visualizá-las.';
    End;

    if lblVendedores.Visible then
    begin
      if not fEmptyStr(strMsg) then
        strMsg := strMsg + sLineBreak + sLineBreak;

      strMsg := strMsg + 'Esse documento possui mais que um vendedor.' + sLineBreak +
                         'Pressione [F8] para visualizá-los.';
    end;

    if not fEmptyStr(strMsg) then
    begin
      intMouseY := Y;
      intMouseX := X;
      HintControler.ShowHint(Self.Left+dbgDocumentos.Left+X+10, Self.Top+dbgDocumentos.Top+Y+20, '', strMsg);
    end;
  End;
end;

function TfrmReimpressaoDocsList.fEhBoletoCarneReimpressaoMonitorAtivo: Boolean;
begin
  Result := fCfgSis('REIMPB', varBoolean) And (fCfgSis('NOVLAY', varString) = 'C');
end;

function TfrmReimpressaoDocsList.fEhEmissaoDeCupomFiscalPeloNfeImpressao: boolean;
begin
  Result := fCfgSis('PRNFCE', varBoolean) and (cdsGenDoc.FieldByName('ESPDOC').AsString='IF');
end;

function TfrmReimpressaoDocsList.fEhEmissaoDeNotaDeProdutoPeloNfeImpressao(strEmpresa: String): boolean;
begin
  Result := fCfgSis('CITINF', varBoolean, strEmpresa) and (cdsGenDoc.FieldByName('ESPDOC').AsString='NF');
end;

function TfrmReimpressaoDocsList.fEhEmissaoDeNotaDeServicoPeloNfeImpressao: boolean;
begin
  If (fCfgSis('NFSENO', varBoolean)) And (Not fPrefeituraComLayoutNfse(fCfgSis('CIDNFS'))) Then
    Result := fCfgSis('IMPNFS', varBoolean) and (cdsGenDoc.FieldByName('ESPDOC').AsString='NS')
  Else
    Result := (fCfgSis('IMPNFS', varBoolean)) and (fPrefeituraComLayoutNfse(fCfgSis('CIDNFS'))) and (cdsGenDoc.FieldByName('ESPDOC').AsString='NS');
end;

procedure TfrmReimpressaoDocsList.pVisualizarDocumento;
  Var
    opcEdtFstImp: TOpcEditorFast;
begin
  Try
    If (Not (fPermitirReimpressaoPedOrdProd())) Then
      Exit;

    If Not fPermiteReimpressaoNaoAutorizados Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso para imprimir documentos não autorizados!', ['&O k']);
      Exit;
    End;

    TFatVenda.pAtualizacaoCotacaoDolar(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                       cdsGenDoc.FieldByName('ESPDOC').AsString,
                                       cdsGenDoc.FieldByName('CODEMP').AsString);

    If (cdsGenDoc.FieldByName('ESPDOC').AsString = 'RL') Then
     opcEdtFstImp := opcVideo;

    fReimprimeDocumento(True, True, opcEdtFstImp);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[F10 - Visualizar Documento]');
    End;
  End;
end;

function TfrmReimpressaoDocsList.VerificaSeArquivoBoletoExiste(ADataset: TDataset;
  ACaminhoArquivo: String; var ANomeArquivo: String): Boolean;
begin
  ANomeArquivo := ADataset.FieldByName('NROBOLETO').AsString + '.pdf';
  Result := FileExists(ACaminhoArquivo + ANomeArquivo);
  If Not Result Then
  Begin
    ANomeArquivo := ADataset.FieldByName('CTR_NUMDUP').AsString + '.pdf';
    Result := FileExists(ACaminhoArquivo + ANomeArquivo);
  End;
end;

procedure TfrmReimpressaoDocsList.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  If (lblDocConf.Visible) And (Not Self.Active) Then
    HintControler.HideHint;

  If (lblDocFat.Visible) And (Not Self.Active) Then
    HintControler.HideHint;

  inherited;
end;

procedure TfrmReimpressaoDocsList.dbgDocumentosCellClick(Column: TColumn);
var
  dtsGrid: TUniClientDataSet;
begin
  inherited;
  dtsGrid := TUniClientDataSet(dbgDocumentos.DataSource.DataSet);

  Case dbgDocumentos.SelectedRows.Count Of
    0 : strNomCliSel := EmptyStr;
    1 : strNomCliSel := dtsGrid.FieldByName('NOMCLI').AsString;
    else
    Begin
      If strNomCliSel <> dtsGrid.FieldByName('NOMCLI').AsString Then
      Begin
        fMensagem('Atenção','Para executar este processo é preciso selecionar documentos que pertencem do mesmo cliente.', ['&Ok']);
        dbgDocumentos.SelectedRows.CurrentRowSelected := False;
      End;
    End
  End;
end;

procedure TfrmReimpressaoDocsList.dbgDocumentosDblClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(pImprimirDocumento, 'Aguarde, carregando documento para impressão...', '');
  dbgDocumentos.Refresh;
end;

procedure TfrmReimpressaoDocsList.pImprimirDocumento;
  Var
    frmQckFatImp40Col2Comprov: TfrmQckFatImp40Col2Comprov;
    blnQtdOri: Boolean;
    blnDocCan: Boolean;
    blnOpcFat: Boolean;
    intOpcMen: Integer;
begin
  inherited;
  blnOpcFat := False;

  If blnSoConsulta Then
    Exit;

  If (Not (fPermitirReimpressaoPedOrdProd())) Then
    Exit;

  If Not fPermiteReimpressaoNaoAutorizados Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso para imprimir documentos não autorizados!', ['&O k']);
    Exit;
  End;

  TFatVenda.pAtualizacaoCotacaoDolar(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                     cdsGenDoc.FieldByName('ESPDOC').AsString,
                                     cdsGenDoc.FieldByName('CODEMP').AsString);

  If InterlockedIncrement(intConfirmando) = 0 Then
  Begin

    {Default, sempre = "True", para que em casos de reimpressão de documentos, seja impressa
     a quantidade original. Pois no caso de (Reimpressão de OR "Orçamento") não é questionado
     o tipo de quantidade.}
    blnQtdOri := True;

    Try

      //If fMensagem('','Deseja Reimprimir este documento?',['&Sim','&Não'],2) = 1 Then
      Begin
        If SameText(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD') Then
        Begin
          intOpcMen := fMensagem('','Selecione o tipo de quantidade?',['&Original','&Pendente', '&Faturado'], 2);

          If (intOpcMen <> 1) Then
          Begin
            blnQtdOri := False;
            blnOpcFat := intOpcMen = 3;
          End;
        End;

        If cdsGenDoc.FieldByName('DOCCAN').AsString = 'C' Then
          blnDocCan := True
        Else
          blnDocCan := False;

        pnlInfo.Caption := 'Aguarde, realizando a impressão...';

        Application.ProcessMessages;

        reiReimpressao.blnTelaReimpressao := True;
        reiReimpressao.pReimprimeDocumento(False, blnQtdOri, blnDocCan, True,
          SameText(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD'), opcPergunta,
          False, libAmbos, False, False, '', False, blnOpcFat);

        If (Not blnQtdOri) And (Not reiReimpressao.blnImprimiuEditor) Then
        Begin
          If (blnOpcFat) Then
            pMensagemOK('Não há itens faturados para impressão!')
          Else
            pMensagemOK('Não há itens pendentes para impressão!');
        End;

        if fCfgSis('IMPSER', varBoolean) then
        Begin
          If cdsGenDoc.FieldByName('ESPDOC').AsString = 'NS' Then
          Begin
            If (Not TfrmComprovanteServicosExecutar.fImprimeLayoutEditor(cdsGenDoc.FieldByName('NUMDOC').AsString, cdsGenDoc.FieldByName('ESPDOC').AsString,
                                         cdsGenDoc.FieldByName('CODEMP').AsString, cdsGenDoc.FieldByName('CODCLI').AsString)) Then
            Begin
              TfrmComprovanteServicosExecutar.pImprime(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                       cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                       cdsGenDoc.FieldByName('CODEMP').AsString);
            End;
          End;
        End;

        If (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'OR_PD_') > 0) And (fCfgSis('IMPCPV', varBoolean)) Then
        Begin
          pCriarFormularios(TfrmQckFatImp40Col2Comprov, frmQckFatImp40Col2Comprov);
          Try
            frmQckFatImp40Col2Comprov.pImprimeComprovante(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                          cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                          cdsGenDoc.FieldByName('CODEMP').AsString);
          Finally
            pFreeAndNil(frmQckFatImp40Col2Comprov);
          End;
        End;

        If fImprimeTermoAceite Then
        Begin
          TTermoAceiteCompraVenda.pImprimeTermoDoc(cdsGenDoc.FieldByName('DTAENT').asDateTime, cdsGenDoc.FieldByName('NUMDOC').AsString, cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                   cdsGenDoc.FieldByName('CODEMP').AsString, fCadEmp('NOMFAN'),fCadEmp('EMAIL_'),fCadEmp('FONE01'),cdsGenDoc.FieldByName('CLINOM').AsString,fRetNomVendRep(cdsGenDoc.FieldByName('CODVEN').AsString));
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[dbgDocumentosDblClick]');
      End;
    End;
    InterlockedDecrement(intConfirmando);

    pnlInfo.Caption := '';

    pSetFocus(btnSair);
    pSetFocus(dbgDocumentos);

  End
  Else
  Begin
    InterlockedDecrement(intConfirmando);
  End;

end;


procedure TfrmReimpressaoDocsList.pMostraDocumentosConfirmados;
Var
  strTipRel: String;
  strColDocOri : String;
Begin

  If (Not lblDocConf.Visible) Then
    Exit;

  strColDocOri := cdsGenDoc.FieldByName('DOCORI').AsString;

  If fRetTipDocOri(strColDocOri) = TTDOPedOrc Then
  Begin
    strTipRel := '1';
  End
  Else
  Begin

    If fRetTipDocOri(strColDocOri) = TTDODocConf Then
    Begin
      strTipRel := '2';
    End
    Else
    Begin
      strTipRel := '3';
    end;

  end;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(151, 6958, [6959,6960],
                        ['TIPREL','NUMDOC','ESPDOC','CODEMP','CODCLI','AUTINC'],
                        [strTipRel,
                        cdsGenDoc.FieldByName('NUMDOC').AsString,
                        cdsGenDoc.FieldByName('ESPDOC').AsString,
                        cdsGenDoc.FieldByName('CODEMP').AsString,
                        cdsGenDoc.FieldByName('CODCLI').AsString,
                        cdsGenDoc.FieldByName('AUTINC').AsString],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmReimpressaoDocsList.pMostraDocumentosFaturados;
Var
  strTipRel: String;
  strColNumFat : String;
Begin

  If (Not lblDocFat.Visible) Then
    Exit;

  strColNumFat := cdsGenDoc.FieldByName('NUMFAT').AsString;

  If fRetTipDocOri(strColNumFat) = TTDODetFat Then
  Begin
    strTipRel := '1';
  End
  Else
  Begin

    If fRetTipDocOri(strColNumFat) = TTDOFatFat Then
    Begin
      strTipRel := '2';
    End
    Else
    Begin
      strTipRel := '3';
    end;

  end;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(353, 16382, [16383,16384],
                        ['TIPREL','NUMDOC','ESPDOC','CODEMP','CODCLI','AUTINC'],
                        [strTipRel,
                        cdsGenDoc.FieldByName('NUMDOC').AsString,
                        cdsGenDoc.FieldByName('ESPDOC').AsString,
                        cdsGenDoc.FieldByName('CODEMP').AsString,
                        cdsGenDoc.FieldByName('CODCLI').AsString,
                        cdsGenDoc.FieldByName('AUTINC').AsString],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmReimpressaoDocsList.pMostraVendedoresDocumento;
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(218, 7697, [],
                        ['TIPREL','NUMDOC','ESPDOC','CODEMP'],
                        [IfThen(Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'OR_PD') > 0,'1','2'),
                        cdsGenDoc.FieldByName('NUMDOC').AsString,
                        cdsGenDoc.FieldByName('ESPDOC').AsString,
                        cdsGenDoc.FieldByName('CODEMP').AsString],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmReimpressaoDocsList.FormShow(Sender: TObject);
begin
  inherited;
  If fCfgSis('MONCAI', varBoolean) And (fCfgSis('IMPCAI', varString) = '2') Then
    lblVolPed.Tag := 1;

  If Not fVerificaAcessoSistema('REIMCI') Then
  Begin
    blnSoConsulta           := True;
    lblBusca.Visible        := False;
    lblDocConf.Visible      := False;
    lblDocFat.Visible       := False;
    Label2.Visible          := False;
    dbgDocumentos.PopupMenu := Nil;
  End;

  cdsGenDoc := reiReimpressao.objDocumentos.cdsDocumentos;
  dtsGenDoc := fCriaDataSource(cdsGenDoc);
  dtsGenDoc.OnDataChange := pOnDataChange;
  dbgDocumentos.DataSource:= dtsGenDoc;

  if not cdsGenDoc.IsEmpty then
    dbgDocumentos.SelectedRows.CurrentRowSelected := True;

  reiReimpressao.pSetaDocumentoOriginalConcreto(cdsGenDoc, 'DOCORI', True);

  pOnDataChange(Nil, Nil);

  mnuNotaSubstituicaoNFSe.Visible := fCfgSis('NFESER', varBoolean);
  strPrgPor := fCfgSis('PRGPOR');

  lblEnvWpp.Visible := fEnviaWhatsapp;
end;

procedure TfrmReimpressaoDocsList.pReimprimeVolumesPedido;
  Var
    objPedido : TPedidoVenda;
begin
  objPedido := TPedidoVenda.Create;
  Try
    objPedido.strNumDoc := dtsGenDoc.DataSet.FieldByName('NUMDOC').AsString;
    objPedido.strEspDoc := dtsGenDoc.DataSet.FieldByName('ESPDOC').AsString;
    objPedido.strCodEmp := dtsGenDoc.DataSet.FieldByName('CODEMP').AsString;
    objPedido.strCodCli := dtsGenDoc.DataSet.FieldByName('CODCLI').AsString;
    objPedido.strSeqGer := dtsGenDoc.DataSet.FieldByName('AUTINC').AsString;
    objPedido.fltDesCon := 0;

    TfrmFatExpedicaoItens.pReimprimeListaCaixas(objPedido);

  Finally
    FreeAndNil(objPedido);

  End;

end;

procedure TfrmReimpressaoDocsList.mnuEndEntrClick(Sender: TObject);
begin
  inherited;
  pReimprimirCupEndEnt;
end;

procedure TfrmReimpressaoDocsList.mnuGerarDanfePDFClick(Sender: TObject);
begin
  inherited;
  fGerarPDFDanfe;
end;

procedure TfrmReimpressaoDocsList.mnuNotaSubstituicaoNFSeClick(Sender: TObject);
  Var
    strNovoNumero: String;
    qryNota: TDataSet;
begin
  inherited;
  If Not fVerificaAcessoSistema('SUBNFS') Then
  Begin
    pMensagemOk('Este usuário não tem acesso à enviar nota de substituição de NFSe.');
    Exit;
  End;

  If dbgDocumentos.DataSource.DataSet.FieldByName('ESPDOC').AsString <> 'NS' Then
  Begin
    pMensagemOk('Só é permitido enviar nota de substituição para NFSe.');
    Exit;
  End;

  If Not TLibNfe.fVerificaCancelamentosPendentesPainel('NS') Then
  Begin
    pMensagemOk('Há notas de serviço não autorizadas. Por favor tente novamente em alguns instantes.');
    Exit;
  End;

  qryNota := dbgDocumentos.DataSource.DataSet;

  fStartTransaction;
  Try
    strNovoNumero := fRetSequencial('PRO_NS', VS_strCodEmp, fTamDocCadRec);

    pGravaNumeroNotaSubstituida;
    pLimpaMovObs;
    pMudarNumeroDocumento(strNovoNumero);
    pEnviarNotaSubstituicao(strNovoNumero);

    fCommit;

    fMensagem('ATENÇÃO!', 'Nota de substituição enviada com sucesso. Novo número: ' + strNovoNumero, ['&Ok']);
    blnReabrir := True;
    intRecNo := qryNota.RecNo;
    btnSair.Click;
  Except
    On E: ExceptionAutCom Do
    Begin
      fRollBack;
      pDeletaLogNfe(strNovoNumero,
                    qryNota.FieldByName('ESPDOC').AsString,
                    qryNota.FieldByName('CODEMP').AsString,
                    qryNota.FieldByName('CODCLI').AsString,
                    qryNota.FieldByName('SERIE_').AsString,
                    qryNota.FieldByName('TIP_FC').AsString);
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    begin
      fRollBack;
      pDeletaLogNfe(strNovoNumero,
                    qryNota.FieldByName('ESPDOC').AsString,
                    qryNota.FieldByName('CODEMP').AsString,
                    qryNota.FieldByName('CODCLI').AsString,
                    qryNota.FieldByName('SERIE_').AsString,
                    qryNota.FieldByName('TIP_FC').AsString);
      pMensagensErro(e.Message, '[Envio de NFSe de substituição]');
    end;
  end;
end;

procedure TfrmReimpressaoDocsList.mnuOperacoesNfePopup(Sender: TObject);
begin
  inherited;
  mnuReimprimirTermoAceiteCV.Visible := fImprimeTermoAceite;
  mnuEndEntr.Visible := blnEndEnt and (dtsGenDoc.DataSet.FieldByName('ESPDOC').AsString = 'IF');
end;

procedure TfrmReimpressaoDocsList.mnuReimprimirDanfeClick(Sender: TObject);
  Var
    strAcesso: String;
    strSerie: String;
    strPontoImpressao: String;
    LErrorMsg: String;
    strEmpresa: String;
    strImpressora: String;
    libNfe: TLibNfe;
    blnPodeReimprimirDocumento: Boolean;
    blnAcesso: boolean;

  procedure pAtualizarPontoImpressaoNFe;
  begin
    fExecutaSQL(Format(
      ' UPDATE LOGNFE SET NFE_PONIMP = "%s" ' +
      ' WHERE NFE_NUMDOC = "%s" ' +
      '   AND NFE_ESPDOC = "%s" ' +
      '   AND NFE_CODEMP = "%s" ' +
      '   AND NFE_CODCLI = "%s" ' +
      '   AND NFE_SERIE_ = "%s" ', [strPontoImpressao,
                                    cdsGenDoc.FieldByName('NUMDOC').AsString,
                                    cdsGenDoc.FieldByName('ESPDOC').AsString,
                                    cdsGenDoc.FieldByName('CODEMP').AsString,
                                    cdsGenDoc.FieldByName('CODCLI').AsString,
                                    cdsGenDoc.FieldByName('SERIE_').AsString]));
  end;

begin
  inherited;
  If cdsGenDoc.FieldByName('ESPDOC').AsString = 'IF' Then
  Begin
    pReimprimirNFCe;
    Exit;
  End;

  blnPodeReimprimirDocumento := (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'NF_NS_CT') > 0);

  If not blnPodeReimprimirDocumento Then
  Begin
    pMensagemOk('Este documento não é uma NF/NS/CTE ou ainda não foi autorizada.');
    Exit;
  End;

  if Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'NF_NS_') > 0 then
  begin
    blnAcesso := fVerificaAcessoSistema('REDANF');
    if not blnAcesso then
      blnAcesso := fValidaDireitoAcessoReimprimirDanfe;

    If not blnAcesso Then
      exit;
  end;

  strAcesso := fRetornaChaveAcesso(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                   cdsGenDoc.FieldByName('ESPDOC').AsString,
                                   cdsGenDoc.FieldByName('CODEMP').AsString,
                                   cdsGenDoc.FieldByName('CODCLI').AsString,
                                   cdsGenDoc.FieldByName('SERIE_').AsString,
                                   cdsGenDoc.FieldByName('TIP_FC').AsString,
                                   strSerie);

  If fEmptyStr(strAcesso) Then
  Begin
    pMensagemOk('Esta nota não é uma NFe ou ainda não foi autorizada.');
    Exit;
  End;

  If (cdsGenDoc.FieldByName('ORIDOC').AsString = 'V') And (Not fRefazLogNfeCasoExcluido(strAcesso)) Then
  Begin
    pMensagemOk('Nao foi possível recriar a LOGNFE com a nota selecionada.');
    Exit;
  End;

  strImpressora := EmptyStr;

  strEmpresa := cdsGenDoc.FieldByName('CODEMP').AsString;

  If fEmptyStr(strEmpresa) Then
  Begin
    strEmpresa := VS_strCodEmp;
  End;

  If fEhEmissaoDeNotaDeProdutoPeloNfeImpressao(strEmpresa) Then
  Begin
    libNFe := TLibNfe.Create(VS_strCodEmp);
    Try
      strPontoImpressao := libNFe.fRetPontoImpressao(cdsGenDoc.FieldByName('ESPDOC').AsString, VS_strCodEmp);
      pAtualizarPontoImpressaoNFe;
      strImpressora := libNFe.fRetornaNomeImpressora(strPontoImpressao);
    Finally
      FreeAndNil(libNFe);
    End;
  End;

  If VirtualUI.Active Or (strImpressora <> EmptyStr) Or (TCfgRel.fExecutePrintDialog(strImpressora)) Then
  Begin
    If fEmptyStr(strImpressora) Then strImpressora := TCfgRel.fGetImpressoraSelecionada;
    Try
      If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao or fEhEmissaoDeNotaDeProdutoPeloNfeImpressao(strEmpresa)) Then
      Begin
        If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao) Then
          TImpressaoDiretaCitel.pImprimir(strEmpresa, strImpressora, strAcesso, 'NFS', True)
        Else
          TImpressaoDiretaCitel.pImprimir(strEmpresa, strImpressora, strAcesso, 'NFE', True)
      End
      Else
      Begin
        Try
          libNfe := TLibNfe.Create(VS_strCodEmp);
          Try
            if cdsGenDoc.FieldByName('ESPDOC').AsString = 'CT' then
              libNfe.pReimprimirConhecimentoEletronico(
                Copy(cdsGenDoc.FieldByName('NUMDOC').AsString, 4, 9),
                TCfgRel.fGetImpressoraSelecionada)
            else
              libNfe.pReimprimirDanfe(strAcesso, TCfgRel.fGetImpressoraSelecionada, cdsGenDoc.FieldByName('SERIE_').AsString);
          Except
            On E: Exception Do
            Begin
              LErrorMsg := E.Message;
              LErrorMsg := LErrorMsg.Replace(#13, ' ').Replace(#10, ' ').Replace('Erro ao reimprimir:', '');
              LErrorMsg := Trim(LErrorMsg);

              If Length(LErrorMsg) > 60 Then
                LErrorMsg := Copy(LErrorMsg, 1, 59) + sLineBreak +
                  fPadR(Copy(LErrorMsg, 60, 56) + '...', 59);

              pMensagemSonora(
                '------------------------------------------------------------' + sLineBreak +
                'Não é possível recuperar a DANFE na SEFAZ.                  ' + sLineBreak +
                'Verifique se existe acesso à Internet no seu computador.    ' + sLineBreak +
                'Caso o erro persista, procure o departamento de TI.         ' + sLineBreak +
                '                                                            ' + sLineBreak +
                '------------------------------------------------------------' + sLineBreak +
                'Mensagem retornada:                                         ' + sLineBreak +
                LErrorMsg                                                      + sLineBreak +
                '------------------------------------------------------------' , False, 11, 600);
            End;
          End;
        Finally
          FreeAndNil(libNfe);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[Reimpressão de Danfe.]');
      End;
    End;

  End;
end;

procedure TfrmReimpressaoDocsList.mnuReimprimirTermoAceiteCVClick(
  Sender: TObject);
begin
  inherited;
  TTermoAceiteCompraVenda.pImprimeTermoDoc(cdsGenDoc.FieldByName('DTAENT').asDateTime, cdsGenDoc.FieldByName('NUMDOC').AsString, cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                   cdsGenDoc.FieldByName('CODEMP').AsString, fCadEmp('NOMFAN'),fCadEmp('EMAIL_'),fCadEmp('FONE01'),cdsGenDoc.FieldByName('CLINOM').AsString,fRetNomVendRep(cdsGenDoc.FieldByName('CODVEN').AsString));
end;

procedure TfrmReimpressaoDocsList.mnuTermoTintaClick(Sender: TObject);
var
  strArquivo: string;
  blnImprime: Boolean;
  Word: TWord;
  strNomImp: string;
  strTipImp: string;
begin
  inherited;

  if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'TERMO DE VENDA') then
  begin
    fMensagem('ATENÇÃO', 'Diretório "TERMO DE VENDA" não encontrado.', ['&Ok']);
    Exit;
  end;

  strArquivo := ExtractFilePath(Application.ExeName) + 'TERMO DE VENDA\TermoVendaTintaMaquina_' + cdsGenDoc.FieldByName('NUMDOC').AsString +'_' + cdsGenDoc.FieldByName('ESPDOC').AsString + '_' +cdsGenDoc.FieldByName('CODEMP').AsString + '.docx';

  if not FileExists(strArquivo) then
  begin
    fMensagem('ATENÇÃO', 'Termo de venda não encontrado.', ['&Ok']);
    Exit;
  end;

  Word := TWord.fCriarWord(Self);

  if Word = nil then
    Exit;

  try
    if not Word.AbrirArquivo(strArquivo) Then
    begin
      fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
      exit;
    End;

    pCarregaConfImpr(qryCfgRel, 'TermoVendaTintaMaquina');
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    if fEmptyStr(strNomImp) then
    begin
      blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I');
    end
    else
    begin
      blnImprime := True;
    end;

    if blnImprime then
      TCfgRel.pPrintReport('TermoVendaTintaMaquina', ExtractFileName(strArquivo), strNomImp, Word);

    Word.pFechar;
    Application.ProcessMessages;
  finally
    FreeAndNil(Word);
  end;

end;

procedure TfrmReimpressaoDocsList.pReimprimirNFCe(blnGerarPDF: Boolean = False);
  Var
    strAcesso: String;
    strSerie: String;
    strImpressora: String;
    strPathDllDaruma: String;
begin
  Try
    strAcesso := fRetornaChaveAcesso(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                     cdsGenDoc.FieldByName('ESPDOC').AsString,
                                     cdsGenDoc.FieldByName('CODEMP').AsString,
                                     cdsGenDoc.FieldByName('CODCLI').AsString,
                                     cdsGenDoc.FieldByName('SERIE_').AsString,
                                     cdsGenDoc.FieldByName('TIP_FC').AsString,
                                     strSerie);

    If fEmptyStr(strAcesso) Then
    Begin
      pMensagemOk('Este documento não é uma NFCe ou ainda não foi autorizada.');
      Exit;
    End;

    strPathDllDaruma := fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini');

    strImpressora := EmptyStr;

    If fExisteFilaImpressaoNFCe Then
      strImpressora := fRetornaFilaImpressaoNFCe
    Else If (VirtualUI.Active Or (Not fEmptyStr(strPathDllDaruma)) Or TCfgRel.fExecutePrintDialog(strImpressora)) Then
    Begin
      If fEmptyStr(strImpressora) Then
        strImpressora := TCfgRel.fGetImpressoraSelecionada;
    End;

    If Not fEmptyStr(strImpressora) Then
    Begin
      pImprimirNFCe(cdsGenDoc.FieldByName('NUMDOC').AsString,
                    cdsGenDoc.FieldByName('ESPDOC').AsString,
                    cdsGenDoc.FieldByName('CODEMP').AsString,
                    cdsGenDoc.FieldByName('CODCLI').AsString,
                    cdsGenDoc.FieldByName('SERIE_').AsString,
                    cdsGenDoc.FieldByName('TIP_FC').AsString,
                    strImpressora,
                    False,
                    True,
                    blnGerarPDF);
    End;
  Except
    On E: EPrinter do
      pMensagemOk('Foi encontrado um problema durante a impressão do documento. Verifique!');

    On E: Exception do
      pMensagensErro(E.Message, '[TfrmReimpressaoDocsList.pReimprimirNFCe]');

  End;

end;

procedure TfrmReimpressaoDocsList.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgDocumentos);
end;

procedure TfrmReimpressaoDocsList.FormCreate(Sender: TObject);
begin
  inherited;

  cdsGenDoc      := TUniClientDataSet.Create(Self);
  objLiberacao   := TLiberacao.Create;
  blnSoConsulta  := False;
  intConfirmando := -1;

  blnReabrir := False;
  intRecNo := -1;
  blnEndEnt := fCfgSis('CUPEET', varBoolean) and
                (fCfgSis('USNFCE', varBoolean)
                or fCfgSis('USASAT', varBoolean));

end;

procedure TfrmReimpressaoDocsList.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmReimpressaoDocsList.HabOpcoesEnvioEmail(var recExibirOpcoes : TExibirOpcoesReimpressao);
Const
  ESPECIES_VALIDAS_XML_DANFE : String = 'NF_NS_IF_';
Var
  blnCitInf,
  blnDocOriPreenchido,
  blnMovDig: Boolean;

  strEspDocsSel: String;
  intContador : Integer;
Begin
  strEspDocsSel := EmptyStr;
  blnDocOriPreenchido := False;
  FillChar(recExibirOpcoes, SizeOf(recExibirOpcoes), #0);
  blnCitInf := fCfgSis('CITINF', varBoolean);
  blnMovDig := fCfgSis('MOVDIG', varBoolean);

  For intContador := 0 To Pred(dbgDocumentos.SelectedRows.Count) Do
  Begin
    cdsGenDoc.GotoBookmark(dbgDocumentos.SelectedRows.Items[intContador]);
    If (Not FEmptyStr(cdsGenDoc.FieldByName('DOCORI').AsString)) And (Not blnDocOriPreenchido) Then
      blnDocOriPreenchido := True;

    If (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, ESPECIES_VALIDAS_XML_DANFE) > 0)
     And fEmptyStr(strEspDocsSel) Then
      strEspDocsSel := strEspDocsSel + cdsGenDoc.FieldByName('ESPDOC').AsString;
  End;

  recExibirOpcoes.blnExibirDigConf  := (blnDocOriPreenchido And blnMovDig);
  recExibirOpcoes.blnExibirXMLDANFe := (blnCitInf and (Pos(strEspDocsSel, ESPECIES_VALIDAS_XML_DANFE) > 0));
End;

procedure TfrmReimpressaoDocsList.pEnviarDocPorEmail;
  Var
    qryGenCli : TUniQuery;
    strDestinatario     : String;
    strEmailDestinatario: String;
    blnConfirma : Boolean;
    strArqHtml  : String;
    strAssunto  : String;
    blnEnvDoc   : Boolean;
    strTexto    : String;
    blnAnexar   : Boolean;
    qryFatDor   : TUniQuery;
    arrArquivos, arrDestinatarios : TStringArray;
    opcEdtFstImp: TOpcEditorFast;
    blnImpDocSel : Boolean;
    blnImpBoleto : Boolean;
    blnImpDocConf : Boolean;
    blnXML : Boolean;
    blnDANFe : Boolean;
    strTodosArquivos,
    strTodosArquivosMultiSelecao : String;
    LstrPath : String;
    strDirReimp: String;
    strDirXML : String;
    strArqXml : String;
    strArqPDF : String;
    strNumSer : String;
    LDadosAutenticacao: TDadosLoginEmail;
    LExibirOpcoes : TExibirOpcoesReimpressao;
    stlCadRecs : TStringList;
    LDatasetPix: TUniClientDataset;
    intContador: Integer;
    stlDocsNaoTransmitidos: TStringList;
    strDocsNaoTransmitidos: String;
    strTermoDeAceite,
    strBoleto,
    strDocConfirmacao : String;
    blnMultiSel,
    blnExibiMsg: Boolean;
    strDanfeBase64: String;
    strAcesso: String;
begin
  blnAnexar              := False;
  blnEnvDoc              := False;
  strTodosArquivos       := '';
  LstrPath               := '';
  Self.enumOpReimpPdOr   := oppPergunta;
  strDirReimp            := IncludeTrailingPathDelimiter( ExtractFilePath(ParamStr(0)) )+ 'Docs_Env_Reimp';
  strDirXML              := IncludeTrailingPathDelimiter( ExtractFilePath(ParamStr(0)) )+ 'Docs_Env_XML';
  stlCadRecs             := TStringList.Create;
  stlDocsNaoTransmitidos := TStringList.Create;
  blnMultiSel := IIF(dbgDocumentos.SelectedRows.Count <= 1, False, True);
  blnExibiMsg := Not(blnMultiSel);
  cdsGenDoc.DisableControls;
  pCriarFormularios(TfrmDigEmail, frmDigEmail);
  pCriarFormularios(TfrmConfirmacaoMemo, frmConfirmacaoMemo);

  Try
    If (Not (fPermitirReimpressaoPedOrdProd())) Then
      Exit;

    If Not fPermiteReimpressaoNaoAutorizados Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso para imprimir documentos não autorizados!', ['&O k']);
      Exit;
    End;

    If Not DirectoryExists(strDirReimp) Then
      CreateDir(strDirReimp);

    If dbgDocumentos.SelectedRows.Count <= 0 Then
      dbgDocumentos.SelectedRows.CurrentRowSelected := True;

    HabOpcoesEnvioEmail(LExibirOpcoes);
    LExibirOpcoes.blnExibirBoletos  := fTemBoletoASerImpresso(cdsGenDoc, stlCadRecs);
    {ABRIR AS OPÇÕES DE ENVIO DE DOCUMENTOS - KM}
    blnConfirma := TfrmOpcoesDocEnvioEmail.fAbrirOpcoesDocEnvioEmail(LExibirOpcoes,
                                                                     blnImpDocSel,
                                                                     blnImpBoleto,
                                                                     blnImpDocConf,
                                                                     blnXML,
                                                                     blnDANFe);
    If (not blnConfirma) Then
      Exit;

    If (blnImpBoleto) Then
    Begin
      If (Not fProcessouBoletos(stlCadRecs)) Then
        Exit;
    End;

    TFatVenda.pAtualizacaoCotacaoDolar(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                       cdsGenDoc.FieldByName('ESPDOC').AsString,
                                       cdsGenDoc.FieldByName('CODEMP').AsString);
    Try
      Try
        If (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString,'GF_GR_') <= 0) Then
        Begin
          qryGenCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
          pPesquisaCadCli(qryGenCli, qryGenCli, cdsGenDoc.FieldByName('CODCLI').AsString);
          frmDigEmail.edtEmail.Text   := qryGenCli.FieldByName('CLI_EMAIL_').AsString;
          frmDigEmail.edtContato.Text := qryGenCli.FieldByName('CLI_CONTAT').AsString;
        End
        Else
        Begin
          qryGenCli := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
          pPesquisaCadFor(qryGenCli, qryGenCli, cdsGenDoc.FieldByName('CODCLI').AsString);
          frmDigEmail.edtEmail.Text   := qryGenCli.FieldByName('FOR_EMAIL_').AsString;
          frmDigEmail.edtContato.Text := qryGenCli.FieldByName('FOR_CONTAT').AsString;
        End;

        frmDigEmail.chkAnexar.Visible := (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD_OR_') > 0) and SameText(cdsGenDoc.FieldByName('TABELA').AsString, 'FATGOR');

        blnConfirma := (frmDigEmail.ShowModal = mrOk);
        FreeAndNil(qryGenCli);

        If (blnConfirma) Then
        Begin
          strDestinatario      := frmDigEmail.edtContato.Text;
          strEmailDestinatario := frmDigEmail.edtEmail.Text;
          blnAnexar            := frmDigEmail.chkAnexar.Checked;
        End;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmReimpressaoDocsList.pEnviarDocPorEmail]');
        End;
      End;

      If (Not blnConfirma) Then
      Begin
        Exit;
      End;

      For intContador := 0 To Pred(dbgDocumentos.SelectedRows.Count) Do
      Begin
        strArqHtml := '';
        cdsGenDoc.GotoBookmark(dbgDocumentos.SelectedRows.Items[intContador]);

        If blnImpDocSel And
          ((Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD_OR') > 0) Or (Not blnDANFe)) Then
        Begin
          If fReimprimeDocumento(False, False, opcEdtFstImp) Then
          Begin
            strArqHtml := reiReimpressao.strArqPDF;
            strTodosArquivosMultiSelecao := strTodosArquivosMultiSelecao + strArqHtml + ';';
          End
          Else
            stlDocsNaoTransmitidos.Add(reiReimpressao.strArqPDF);
        End;
      End;

      {************************************************}
      {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O  ARQUIVO *}
      {*********************************************LU*}
      If fEmptyStr(strTodosArquivosMultiSelecao) And (Not blnDanfe) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
        Exit;
      End
      Else
      Begin
        strAssunto := fRetNomeEmpresa + ' - Envio de documento(s)';
        strTexto := 'Segue documento(s) em anexo.';
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
        strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

        If (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD_OR') > 0) And (Not blnMultiSel) Then
        Begin
          LDatasetPix := RetornaDadosPixPedido;

          pRetornarModeloEmailAutomatico(strEmailDestinatario,
                                         cdsGenDoc.FieldByName('NUMDOC').AsString,
                                         cdsGenDoc.FieldByName('ESPDOC').AsString,
                                         cdsGenDoc.FieldByName('ESPDOC').AsString,
                                         '',
                                         'CR',
                                         cdsGenDoc.FieldByName('CODEMP').AsString,
                                         cdsGenDoc.FieldByName('CODCLI').AsString,
                                         strTexto,
                                         strAssunto,
                                         LDadosAutenticacao,
                                         blnEnvDoc,
                                         LDatasetPix.FieldByName('MPX_QRCODE').AsString,
                                         LDatasetPix.FieldByName('MPX_LNKCIT').AsString);

          If Assigned(LDatasetPix) Then
            FreeAndNil(LDatasetPix);
        End;

        {ANEXAR OS ARQUIVOS SELECIONADOS EM OpcoesDocEnvioEmail}
        If blnImpDocSel Then
        Begin
          strTodosArquivos := strTodosArquivosMultiSelecao;
          strTodosArquivosMultiSelecao := EmptyStr;
        End;

        For intContador := 0 To Pred(dbgDocumentos.SelectedRows.Count) Do
        Begin
          cdsGenDoc.GotoBookmark(dbgDocumentos.SelectedRows.Items[intContador]);
          If blnImpBoleto then
          Begin

            strBoleto := fBuscaBoletos(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                       cdsGenDoc.FieldByName('CODEMP').AsString,
                                       cdsGenDoc.FieldByName('ESPDOC').AsString,
                                       cdsGenDoc.FieldByName('CODCLI').AsString);

           strTodosArquivos := IIF(fEmptyStr(strTodosArquivos), strBoleto, strTodosArquivos + ';' + strBoleto);
          End;

          If blnImpDocConf Then
          Begin
            strDocConfirmacao := fMontaArquivosConfirmacao(cdsGenDoc.FieldByName('AUTINC').AsString,
                                                            cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                            cdsGenDoc.FieldByName('CODEMP').AsString,
                                                            cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                            cdsGenDoc.FieldByName('CODCLI').AsString,
                                                            LstrPath);

            strTodosArquivos := IIF(fEmptyStr(strTodosArquivos), strDocConfirmacao, strTodosArquivos + ';' + strDocConfirmacao);
          End;

           If fImprimeTermoAceite And (Not fEmptyStr(strTodosArquivos)) Then
          Begin
            strTermoDeAceite := TTermoAceiteCompraVenda.fRetArqTermoDoc(cdsGenDoc.FieldByName('DTAENT').asDateTime,
                                                                                              cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                                                              cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                                                              cdsGenDoc.FieldByName('CODEMP').AsString,
                                                                                              fCadEmp('NOMFAN'),
                                                                                              fCadEmp('EMAIL_'),
                                                                                              fCadEmp('FONE01'),
                                                                                              cdsGenDoc.FieldByName('CLINOM').AsString,
                                                                                              fRetNomVendRep(cdsGenDoc.FieldByName('CODVEN').AsString),
                                                                                              blnExibiMsg);
            strTodosArquivos := IIF(fEmptyStr(strTodosArquivos), strTermoDeAceite, strTodosArquivos + ';' + strTermoDeAceite);

            if fEmptyStr(strTermoDeAceite) then
              stlDocsNaoTransmitidos.Add(Format('TERMO_ACEITE_COMPRA_VENDA_%s-%s-%s.doc',[cdsGenDoc.FieldByName('NUMDOC').AsString ,
                                                                                          fUpper(cdsGenDoc.FieldByName('ESPDOC').AsString),
                                                                                          cdsGenDoc.FieldByName('CODEMP').AsString]));
          End;

          if blnXML And (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'NF_IF_NS') > 0) then
          begin
            strArqXml := fMontaArquivosXML(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                           cdsGenDoc.FieldByName('ESPDOC').AsString,
                                           cdsGenDoc.FieldByName('CODEMP').AsString,
                                           cdsGenDoc.FieldByName('CODCLI').AsString,
                                           cdsGenDoc.FieldByName('SERIE_').AsString,
                                           cdsGenDoc.FieldByName('TIP_FC').AsString,
                                           '',
                                           strDirXML,
                                           blnExibiMsg);
            if fEmptyStr(strArqXml) then
              stlDocsNaoTransmitidos.Add(Format('%s_%s_%s.xml',[fUpper(cdsGenDoc.FieldByName('ESPDOC').AsString),
                                                                cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                                cdsGenDoc.FieldByName('CODEMP').AsString]));

            strTodosArquivosMultiSelecao := strTodosArquivosMultiSelecao + strArqXml + ';';

            if (not fEmptyStr(strTodosArquivos)) then
              strTodosArquivos := strTodosArquivos + ';' + strTodosArquivosMultiSelecao
            else
              strTodosArquivos := strTodosArquivosMultiSelecao;

            strTodosArquivosMultiSelecao := EmptyStr;
          end;

          if (blnDANFe) then
          begin
            strNumSer := '';

            if (String('NF_NS_').Contains(cdsGenDoc.FieldByName('ESPDOC').AsString)) then
            begin
              strArqPDF := IncludeTrailingPathDelimiter( strDirReimp ) + fUpper(cdsGenDoc.FieldByName('ESPDOC').AsString) + '_'
                         + cdsGenDoc.FieldByName('NUMDOC').AsString+'_'
                         + cdsGenDoc.FieldByName('CODEMP').AsString
                         + '.pdf';

              strAcesso := fRetornaChaveAcesso(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                 cdsGenDoc.FieldByName('ESPDOC').AsString,
                                 cdsGenDoc.FieldByName('CODEMP').AsString,
                                 cdsGenDoc.FieldByName('CODCLI').AsString,
                                 cdsGenDoc.FieldByName('SERIE_').AsString,
                                 cdsGenDoc.FieldByName('TIP_FC').AsString,
                                 strNumSer);

              strDanfeBase64 := EmptyStr;
              if not fEmptyStr(strAcesso) then
                strDanfeBase64 := fRetDanfeBase64(strAcesso);

              if fEmptyStr(strDanfeBase64) then
                strArqPDF := fGerarPDFDanfe(False, strArqPDF, blnExibiMsg, True)
              Else
                strArqPDF := fRetBase64ParaArquivo(strDanfeBase64, strArqPDF);

              if fEmptyStr(strArqPDF) then
                stlDocsNaoTransmitidos.Add(Format('%s_%s_%s.pdf',[fUpper(cdsGenDoc.FieldByName('ESPDOC').AsString),
                                                                  cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                                  cdsGenDoc.FieldByName('CODEMP').AsString]));

              strTodosArquivosMultiSelecao := strTodosArquivosMultiSelecao + strArqPDF + ';';

            end
            else if (String('IF_').Contains(cdsGenDoc.FieldByName('ESPDOC').AsString)) then
            begin
              strArqPDF := fMontaPDFDANFeNFCe(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                              cdsGenDoc.FieldByName('ESPDOC').AsString,
                                              cdsGenDoc.FieldByName('CODEMP').AsString,
                                              cdsGenDoc.FieldByName('CODCLI').AsString,
                                              cdsGenDoc.FieldByName('SERIE_').AsString,
                                              cdsGenDoc.FieldByName('TIP_FC').AsString,
                                              strNumSer,
                                              strDirReimp,
                                              True);

              if fEmptyStr(strArqPDF) then
                stlDocsNaoTransmitidos.Add(Format('%s_%s_%s.pdf',[fUpper(cdsGenDoc.FieldByName('ESPDOC').AsString),
                                                                  cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                                  cdsGenDoc.FieldByName('CODEMP').AsString]));

              strTodosArquivosMultiSelecao := strTodosArquivosMultiSelecao + strArqPDF + ';';
            end;

            if (not fEmptyStr(strTodosArquivos)) then
              strTodosArquivos := strTodosArquivos + ';' + strTodosArquivosMultiSelecao
            else
              strTodosArquivos := strTodosArquivosMultiSelecao;

            strTodosArquivosMultiSelecao := EmptyStr;
          end;
        End;

        if fEmptyStr(strTodosArquivos) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não foi possível gerar o email pois não existe nenhum documento a ser anexado!', ['&Ok']);
          Exit;
        End;

        If (stlDocsNaoTransmitidos.Count > 0) And blnMultiSel Then
        Begin
          stlDocsNaoTransmitidos.Delimiter := #13;

          strDocsNaoTransmitidos := IIF((stlDocsNaoTransmitidos.Count > 1),
                                        'Há inconsistência nos documentos listados abaixo:',
                                        'Há inconsistência no documento listado abaixo:');

          strDocsNaoTransmitidos := strDocsNaoTransmitidos + #13#10 + stlDocsNaoTransmitidos.DelimitedText;
          frmConfirmacaoMemo.fInformarMensagem('Anexos', 'Lista de documento(s) não anexado(s)', strDocsNaoTransmitidos);
        End;

        If not blnAnexar Then Begin
          pCriarArrayAnexosEDestinatarios(strTodosArquivos, strEmailDestinatario, arrDestinatarios, arrArquivos);

          pEnviarEmail(cdsGenDoc.FieldByName('ESPDOC').AsString, strAssunto, arrDestinatarios, TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos,
                       LDadosAutenticacao,
                       (fCfgSis('TAMANX', varInteger) > 0) And
                        fDocumentoOrigemFF_DV_TR(cdsGenDoc.FieldByName('AUTINC').AsString,
                                                 cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                 cdsGenDoc.FieldByName('ESPDOC').AsString,
                                                 cdsGenDoc.FieldByName('CODEMP').AsString,
                                                 cdsGenDoc.FieldByName('CODCLI').AsString));
        End
        Else
        Begin
          pCriarArrayAnexosEDestinatarios(strTodosArquivos, strEmailDestinatario, arrDestinatarios, arrArquivos);

          qryFatDor := fCriaQuery(Self);
          Try
            With qryFatDor, SQL Do
            Begin
              Close;
              Clear;
              Add(' SELECT SQL_NO_CACHE        ');
              Add('        FDO_CODITE          ');
              Add(' FROM FATDOR                ');
              Add(' WHERE FDO_NUMDOC = :NUMDOC ');
              Add('   AND FDO_ESPDOC = :ESPDOC ');
              Add('   AND FDO_CODEMP = :CODEMP ');

              ParamByName('NUMDOC').AsString := cdsGenDoc.FieldByName('NUMDOC').AsString;
              ParamByName('ESPDOC').AsString := cdsGenDoc.FieldByName('ESPDOC').AsString;
              ParamByName('CODEMP').AsString := cdsGenDoc.FieldByName('CODEMP').AsString;

              Open;

              While Not Eof Do
              Begin
                If FileExists(fCfgSis('PATIMG', varString) + FieldByName('FDO_CODITE').AsString +'.jpg') Then
                Begin
                  Setlength(arrArquivos, Length(arrArquivos)+1);
                  arrArquivos[High(arrArquivos)] := fCfgSis('PATIMG', varString) + FieldByName('FDO_CODITE').AsString +'.jpg';
                End;

                Next;
              End;

            End;

            pEnviarEmail(cdsGenDoc.FieldByName('ESPDOC').AsString, strAssunto, arrDestinatarios, TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos, LDadosAutenticacao);
          Finally
            FreeAndNil(qryFatDor);
          End;
        End;

        {REMOVENDO O DIRETORIO CRIADO PARA OS ARQUIVOS DIGITALIZADOS DE CONFIRMAÇÃO}
        If blnImpDocConf Then
          pApagarArquivosConfirmacao(LstrPath, arrArquivos);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[EnviaEmail]');
      End;
    End;
  Finally
    cdsGenDoc.EnableControls;
    FreeAndNil(stlCadRecs);
    FreeAndNil(stlDocsNaoTransmitidos);
    pFreeAndNil(frmConfirmacaoMemo);
    pFreeAndNil(frmDigEmail);
  End;
End;

function TfrmReimpressaoDocsList.RetornaDadosPixPedido: TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT M.MPX_QRCODE, ' +
                          '       M.MPX_LNKCIT  ' +
                          'FROM FATGOR F ' +
                          'JOIN EXTGOR E ON E.FGO_SEQFGO=F.AUTOINCREM ' +
                          'JOIN MOVPIX M ON M.MPX_CODEMP=E.FGO_EMPPIX ' +
                          '             AND M.MPX_TX_ID_=E.FGO_TX_PIX ' +
                          'WHERE F.FGO_NUMDOC=:NUMDOC ' +
                          '  AND F.FGO_ESPDOC=:ESPDOC ' +
                          '  AND F.FGO_CODEMP=:CODEMP ' +
                          '  AND F.FGO_CODCLI=:CODCLI ';

    LConsulta.ParamByName('NUMDOC').AsString := cdsGenDoc.FieldByName('NUMDOC').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := cdsGenDoc.FieldByName('ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := cdsGenDoc.FieldByName('CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := cdsGenDoc.FieldByName('CODCLI').AsString;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmReimpressaoDocsList.pEnviarDocPorWhatsapp;
  function fRetDestinatarioWhatsapp(strCodCli, strNomCli: String) : TDestinatarioWhatsapp;
  var
    strCelular: String;
  Begin
    Result := Nil;
    strCelular := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);

    if fEmptyStr(strCelular) then
      Exit
    else
      Result := TDestinatarioWhatsapp.Create;

    if fRetFilaEContatoEnvio(Result.FAutIncCtt,
                             strCelular,
                             Result.FIDFila,
                             strCodCli,
                             strNomCli,
                             '',
                             '',
                             True) Then
    begin
      Result.FTo := strCelular;
    end;
  End;
var
  strOpcDoc,
  strEspDoc,
  strEspOrc,
  strFisAce,
  strCelular: String;

  tipoArquivo: TTipoArquivoAnexo;

  strNumSer: String;

  blnEnviado: Boolean;

  LDatasetPix: TUniClientDataset;

  intContador: Integer;
  objDestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  strOpcDoc   := EmptyStr;
  strEspDoc   := EmptyStr;
  strEspOrc   := EmptyStr;
  strFisAce   := EmptyStr;
  tipoArquivo := arqArquivo;
  blnEnviado  := False;
  strCelular  := '';
  objDestinatarioWhatsapp := nil;

  try
    if not fEnviaWhatsapp then
    Exit;

    if not fDocumentoAutorizado then
    begin
      fMensagem('Atenção!', 'O documento selecionado ainda não foi autorizado. Somente é permitido enviar Whatsapp depois '+
                            'que o documento for autorizado. Aguarde alguns instantes e tente novamente.', ['&O k']);
      Exit;
    end;

    if Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'IF_NF_') > 0 then
    begin
      tipoArquivo := arqBase64;
      strOpcDoc := 'AN';
      strEspDoc := cdsGenDoc.FieldByName('ESPDOC').AsString;
      strEspOrc := 'RI';

      strFisAce := fRetornaChaveAcesso(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                       cdsGenDoc.FieldByName('ESPDOC').AsString,
                                       cdsGenDoc.FieldByName('CODEMP').AsString,
                                       cdsGenDoc.FieldByName('CODCLI').AsString,
                                       cdsGenDoc.FieldByName('SERIE_').AsString,
                                       cdsGenDoc.FieldByName('TIP_FC').AsString,
                                       strNumSer);
    end
    else if cdsGenDoc.FieldByName('ESPDOC').AsString = 'FF' then
    begin
      strOpcDoc := cdsGenDoc.FieldByName('ESPDOC').AsString;
      strEspDoc := cdsGenDoc.FieldByName('ESPDOC').AsString;
      strEspOrc := 'RI';
    end
    else if Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'PD_OR_') > 0 then
    begin
      strOpcDoc := cdsGenDoc.FieldByName('ESPDOC').AsString;
      strEspDoc := cdsGenDoc.FieldByName('ESPDOC').AsString;
      strEspOrc := 'CR';
    end;

    if not fGatilhoEmailWhatsappSmsEstaAtivado(notWhatsapp, strOpcDoc, strEspDoc, EmptyStr, strEspOrc) then
      Exit;

    LDatasetPix := RetornaDadosPixPedido;

    if dbgDocumentos.SelectedRows.Count <= 0 then
    begin
      dbgDocumentos.SelectedRows.CurrentRowSelected := True
    end;

    if dbgDocumentos.SelectedRows.Count > 0 then
    begin
      objDestinatarioWhatsapp := fRetDestinatarioWhatsapp(cdsGenDoc.FieldByName('CODCLI').AsString,
                                                          cdsGenDoc.FieldByName('NOMCLI').AsString);

      if objDestinatarioWhatsapp = nil then
        Exit;
    end;

    For intContador := 0 To Pred(dbgDocumentos.SelectedRows.Count) Do
    Begin
      cdsGenDoc.GotoBookmark(dbgDocumentos.SelectedRows.Items[intContador]);
      blnEnviado := fDisparaWhatsappAutomatico(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                               strOpcDoc,
                                               strEspDoc,
                                               '',
                                               strEspOrc,
                                               cdsGenDoc.FieldByName('CODEMP').AsString,
                                               cdsGenDoc.FieldByName('CODCLI').AsString,
                                               RetonaQRCodePixPedido(LDatasetPix.FieldByName('MPX_QRCODE').AsString,
                                                                     LDatasetPix.FieldByName('MPX_LNKCIT').AsString,
                                                                     False),
                                               False,
                                               '',
                                               TGeraArquivoAnexoEmailAutomatico.New(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                                                                    strEspDoc,
                                                                                    cdsGenDoc.FieldByName('CODEMP').AsString,
                                                                                    cdsGenDoc.FieldByName('CODCLI').AsString,
                                                                                    False,
                                                                                    strOpcDoc,
                                                                                    strFisAce,
                                                                                    cdsGenDoc.FieldByName('SERIE_').AsString,
                                                                                    tipoArquivo),
                                               '',
                                               strFisAce,
                                               cdsGenDoc.FieldByName('SERIE_').AsString,
                                               Self.UnitName,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             False,
                                             False,
                                               objDestinatarioWhatsapp);
    End;
  finally
    fMensagem('', IIF(blnEnviado, 'Whatsapp enviado com sucesso!', 'Whatsapp não enviado!'), ['&O k']);
    FreeAndNil(LDatasetPix);
  end;
end;

function TfrmReimpressaoDocsList.fEnviaWhatsapp: Boolean;
begin
  Result := True;

  if not fCfgSis('UTIWPP', varBoolean) then
    Exit(False);

  if not fVerificaAcessoSistema('WPPREI') then
    Exit(False);

  if Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'OR_PD_IF_NF_FF_') = 0 then
    Exit(False);
end;

function TfrmReimpressaoDocsList.fDocumentoAutorizado: Boolean;
begin
  Result := True;

  if Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'IF_NF_') = 0 then
    Exit;

  if (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'IF_') > 0) and (not fCfgSis('USNFCE', varBoolean)) then
    Exit(False);

  if not fDocumentoFiscalAutorizado(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                    cdsGenDoc.FieldByName('ESPDOC').AsString,
                                    cdsGenDoc.FieldByName('CODEMP').AsString,
                                    cdsGenDoc.FieldByName('SERIE_').AsString,
                                    cdsGenDoc.FieldByName('TIP_FC').AsString,
                                    cdsGenDoc.FieldByName('CODCLI').AsString) then
    Exit(False);
end;

procedure TfrmReimpressaoDocsList.pEnviarEmail(const strEspDoc,
  strAssunto: String; const arrDestinatarios, arrCorpoMensagem,
  arrArquivos: TStringArray; ADadosAutenticacao: TDadosLoginEmail;
  const blnHabilitarDivisaoAnexosPorEmail: Boolean=False);
begin
  TEnvioEmail.EnviarEmail(Self,
                          strLoginUsuarioLogado,
                          strAssunto,
                          arrDestinatarios,
                          [],
                          [],
                          arrCorpoMensagem,
                          arrArquivos,
                          True,
                          False,
                          EmptyStr,
                          EmptyStr,
                          0,
                          False,
                          ADadosAutenticacao.Senha,
                          ADadosAutenticacao.Email,
                          ADadosAutenticacao.Login,
                          ADadosAutenticacao.Remetente,
                          ADadosAutenticacao.Provedor,
                          ADadosAutenticacao.PortaSMTP,
                          ADadosAutenticacao.PortaIMAP,
                          ADadosAutenticacao.ServidorSMTP,
                          ADadosAutenticacao.ServidorImap,
                          ADadosAutenticacao.LimiteArquivos,
                          ADadosAutenticacao.ImagemAssinatura,
                          ADadosAutenticacao.TextoAssinatura,
                          ADadosAutenticacao.ImagemAssinaturaStream,
                          EmptyStr,
                          EmptyStr,
                          ADadosAutenticacao.AutenticacaoSSL,
                          ADadosAutenticacao.AutenticacaoSSLImap,
                          ADadosAutenticacao.GravaPastaEnviados,
                          'N',
                          EmptyStr,
                          EmptyStr,
                          True,
                          True,
                          True,
                          Nil,
                          False,
                          blnHabilitarDivisaoAnexosPorEmail);
end;

procedure TfrmReimpressaoDocsList.pOnDataChange(Sender: TObject;
  Field: TField);
begin
  lblDocConf.Visible := (Pos(TIP_DOC_ORI_SIMBOL, dtsGenDoc.DataSet.FieldByName('DOCORI').AsString) > 0) And (Not blnSoConsulta);
  lblDocFat.Visible  := (Pos(TIP_DOC_ORI_SIMBOL, dtsGenDoc.DataSet.FieldByName('NUMFAT').AsString) > 0) And (Not blnSoConsulta);
  lblVolPed.Visible  := (lblVolPed.Tag = 1) And (dtsGenDoc.DataSet.FieldByName('ESPDOC').AsString = 'PD');
  lblVendedores.Visible := (Pos('+1', dtsGenDoc.DataSet.FieldByName('CODVEN').AsString) > 0);
  lblDocDev.Visible := (dtsGenDoc.DataSet.FieldByName('ESPDOC').AsString = 'DV') or (Pos(dtsGenDoc.DataSet.FieldByName('CLAFIS').AsString, VS_strClaDev) > 0);
  lblEnvWpp.Visible := fEnviaWhatsapp;

  HintControler.HideHint;
end;

procedure TfrmReimpressaoDocsList.pGravaNumeroNotaSubstituida;
  Var
    qryIns: TUniQuery;
    qryIncFis: TUniQuery;
    qryNota: TDataSet;
begin
  qryIns := fCriaQuery(Self);
  qryIncFis := fCriaQuery(Self);
  qryNota := dbgDocumentos.DataSource.DataSet;

  Try

    qryIncFis.SQL.Add('SELECT ');
    qryIncFis.SQL.Add('  AUTOINCREM ');
    qryIncFis.SQL.Add('FROM ');
    qryIncFis.SQL.Add('  CADFIS ');
    qryIncFis.SQL.Add('WHERE ');
    qryIncFis.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryIncFis.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryIncFis.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryIncFis.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
    qryIncFis.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
    qryIncFis.SQL.Add('  FIS_TIP_FC = :TIP_FC ');

    qryIncFis.ParamByName('NUMDOC').AsString := qryNota.FieldByName('NUMDOC').AsString;
    qryIncFis.ParamByName('ESPDOC').AsString := qryNota.FieldByName('ESPDOC').AsString;
    qryIncFis.ParamByName('CODEMP').AsString := qryNota.FieldByName('CODEMP').AsString;
    qryIncFis.ParamByName('FORCLI').AsString := qryNota.FieldByName('CODCLI').AsString;
    qryIncFis.ParamByName('SERIE_').AsString := qryNota.FieldByName('SERIE_').AsString;
    qryIncFis.ParamByName('TIP_FC').AsString := qryNota.FieldByName('TIP_FC').AsString;
    qryIncFis.Open;

    qryIns.SQL.Clear;
    qryIns.SQL.Add('SELECT ');
    qryIns.SQL.Add('  COUNT(*) AS QTD ');
    qryIns.SQL.Add('FROM ');
    qryIns.SQL.Add('  SUBNFS ');
    qryIns.SQL.Add('WHERE ');
    qryIns.SQL.Add('  SUB_SEQGER = :SEQGER AND ');
    qryIns.SQL.Add('  SUB_NUMRPS LIKE :NUMRPS ');
    qryIns.ParamByName('SEQGER').AsString := qryIncFis.FieldByName('AUTOINCREM').AsString;
    qryIns.ParamByName('NUMRPS').AsString := '%' + qryNota.FieldByName('NUMDOC').AsString + '%';
    qryIns.Open;

    If qryIns.FieldByName('QTD').AsInteger = 0 Then
    Begin
      qryIns.Close;
      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO SUBNFS (SUB_SEQGER, SUB_NUMRPS, SUB_SERRPS, SUB_ENVIAD)');
      qryIns.SQL.Add('VALUES (:SEQGER, :NUMRPS, :SERRPS, 1) ');

      qryIns.ParamByName('SEQGER').AsString := qryIncFis.FieldByName('AUTOINCREM').AsString;
      qryIns.ParamByName('NUMRPS').AsString := IntToStr(YearOf(qryNota.FieldByName('DTAENT').AsDateTime)) + fStrZero(RightStr(qryNota.FieldByName('NUMDOC').AsString, 11), 11);
      qryIns.ParamByName('SERRPS').AsString := qryNota.FieldByName('SERIE_').AsString;
    End
    Else
    Begin
      qryIns.Close;
      qryIns.SQL.Clear;
      qryIns.SQL.Add('UPDATE SUBNFS SET SUB_ENVIAD = 1 WHERE SUB_SEQGER = :SEQGER ');
      qryIns.ParamByName('SEQGER').AsString := qryIncFis.FieldByName('AUTOINCREM').AsString;
    End;

    qryIns.ExecSQL;
  Finally
    FreeAndNil(qryIncFis);
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmReimpressaoDocsList.pLimpaMovObs;
  Var
    qryUpd: TUniQuery;
    qryMovGer: TUniQuery;
    qryNota: TDataSet;

    function fSQL(strTabela: String): String;
    begin
      Result := '';
      Result := Result + 'SELECT ';
      Result := Result + '  AUTOINCREM ';
      Result := Result + 'FROM ';
      Result := Result + '  ' + strTabela + ' ';
      Result := Result + 'WHERE ';
      Result := Result + '  GER_NUMDOC = :NUMDOC AND ';
      Result := Result + '  GER_ESPDOC = :ESPDOC AND ';
      Result := Result + '  GER_CODEMP = :CODEMP AND ';
      Result := Result + '  GER_CODCLI = :CODCLI AND ';
      Result := Result + '  GER_SERIE_ = :SERIE_ AND ';
      Result := Result + '  GER_TIP_FC = :TIP_FC ';
    end;

    procedure pSetaParametrosEAbre;
    begin
      qryMovGer.ParamByName('NUMDOC').AsString := qryNota.FieldByName('NUMDOC').AsString;
      qryMovGer.ParamByName('ESPDOC').AsString := qryNota.FieldByName('ESPDOC').AsString;
      qryMovGer.ParamByName('CODEMP').AsString := qryNota.FieldByName('CODEMP').AsString;
      qryMovGer.ParamByName('CODCLI').AsString := qryNota.FieldByName('CODCLI').AsString;
      qryMovGer.ParamByName('SERIE_').AsString := qryNota.FieldByName('SERIE_').AsString;
      qryMovGer.ParamByName('TIP_FC').AsString := qryNota.FieldByName('TIP_FC').AsString;
      qryMovGer.Open;
    end;

begin
  qryUpd := fCriaQuery(Self);
  qryNota := dbgDocumentos.DataSource.DataSet;

  qryMovGer := fCriaQuery(Self);
  qryMovGer.SQL.Clear;
  qryMovGer.SQL.Add(fSQL('MOVGER'));
  pSetaParametrosEAbre;
  If qryMovGer.IsEmpty Then
  Begin
    qryMovGer.SQL.Clear;
    qryMovGer.SQL.Add(fSQL('NOTGER'));
    pSetaParametrosEAbre;
  end;

  qryUpd.SQL.Add('UPDATE MOVOBS SET MOV_OBSERV = "", MOV_OBSFIS = "" WHERE MOV_SEQGER = :SEQGER ');
  qryUpd.ParamByName('SEQGER').AsString := qryMovGer.FieldByName('AUTOINCREM').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
  FreeAndNil(qryMovGer);
end;

procedure TfrmReimpressaoDocsList.pMudarNumeroDocumento(
  strNovoNumero: String);
  Var
    qryUpd: TUniQuery;
    qryNota: TDataSet;

    procedure pSetaParametros;
    begin
      qryUpd.ParamByName('NOVO_NUMDOC').AsString := strNovoNumero;

      qryUpd.ParamByName('NUMDOC').AsString := qryNota.FieldByName('NUMDOC').AsString;
      qryUpd.ParamByName('ESPDOC').AsString := qryNota.FieldByName('ESPDOC').AsString;
      qryUpd.ParamByName('CODEMP').AsString := qryNota.FieldByName('CODEMP').AsString;
      qryUpd.ParamByName('FORCLI').AsString := qryNota.FieldByName('CODCLI').AsString;

      If Assigned(qryUpd.Params.FindParam('SERIE_')) Then
      Begin
        qryUpd.ParamByName('SERIE_').AsString := qryNota.FieldByName('SERIE_').AsString;
      End;

      If Assigned(qryUpd.Params.FindParam('TIP_FC')) Then
      Begin
        qryUpd.ParamByName('TIP_FC').AsString := qryNota.FieldByName('TIP_FC').AsString;
      End;
    end;

begin
  qryNota := dbgDocumentos.DataSource.DataSet;
  qryUpd := fCriaQuery(Self);
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE CADFIS SET ');
    qryUpd.SQL.Add('  FIS_NUMDOC = :NOVO_NUMDOC ');
    qryUpd.SQL.Add('WHERE ');
    qryUpd.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryUpd.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryUpd.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryUpd.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
    qryUpd.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
    qryUpd.SQL.Add('  FIS_TIP_FC = :TIP_FC ');

    pSetaParametros;
    qryUpd.ExecSQL;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE MOVGER SET ');
    qryUpd.SQL.Add('  GER_NUMDOC = :NOVO_NUMDOC ');
    qryUpd.SQL.Add('WHERE ');
    qryUpd.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryUpd.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryUpd.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryUpd.SQL.Add('  GER_CODCLI = :FORCLI AND ');
    qryUpd.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND ');
    qryUpd.SQL.Add('  GER_TIP_FC = :TIP_FC ');

    pSetaParametros;
    qryUpd.ExecSQL;

    If VS_AffectedRows > 0 Then
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE MOVDET SET ');
      qryUpd.SQL.Add('  DET_NUMDOC = :NOVO_NUMDOC ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      qryUpd.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      qryUpd.SQL.Add('  DET_CODEMP = :CODEMP AND ');
      qryUpd.SQL.Add('  DET_CODCLI = :FORCLI AND ');
      qryUpd.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
      qryUpd.SQL.Add('  DET_TIP_FC = :TIP_FC ');

      pSetaParametros;
      qryUpd.ExecSQL;
    End
    Else
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE NOTGER SET ');
      qryUpd.SQL.Add('  GER_NUMDOC = :NOVO_NUMDOC ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryUpd.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryUpd.SQL.Add('  GER_CODEMP = :CODEMP AND ');
      qryUpd.SQL.Add('  GER_CODCLI = :FORCLI AND ');
      qryUpd.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND ');
      qryUpd.SQL.Add('  GER_TIP_FC = :TIP_FC ');

      pSetaParametros;
      qryUpd.ExecSQL;

      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE NOTDET SET ');
      qryUpd.SQL.Add('  DET_NUMDOC = :NOVO_NUMDOC ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      qryUpd.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      qryUpd.SQL.Add('  DET_CODEMP = :CODEMP AND ');
      qryUpd.SQL.Add('  DET_CODCLI = :FORCLI AND ');
      qryUpd.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
      qryUpd.SQL.Add('  DET_TIP_FC = :TIP_FC ');

      pSetaParametros;
      qryUpd.ExecSQL;
    End;

  Finally
    FreeAndNil(qryUpd);
  end;
end;

procedure TfrmReimpressaoDocsList.pEnviarNotaSubstituicao(strNovoNumero: String);
  Var
    qryNota: TDataSet;
begin
  qryNota := dbgDocumentos.DataSource.DataSet;

  Try
    fEnviarNotaLibNfe(strNovoNumero,
                      qryNota.FieldByName('ESPDOC').AsString,
                      qryNota.FieldByName('CODEMP').AsString,
                      qryNota.FieldByName('SERIE_').AsString,
                      qryNota.FieldByName('CODCLI').AsString,
                      qryNota.FieldByName('TIP_FC').AsString,
                      True);
  Except
    On E: Exception Do
    Begin
      Raise ExceptionAutcom.Create('Não foi possível enviar a NFSe substituta. Por favor, tente novamente.' + #13#10 +
        'Motivo: ' + E.Message);
    End;
  End;
end;

function TfrmReimpressaoDocsList.fMontaArquivosConfirmacao(strAutInc, strNumDoc, strEmpDoc, strEspDoc, strCodCli : String; Var strPath : String) : String;
{BUSCA E GERA DOCUMENTOS DA CONFIRMAÇÃO}
Var
  LqryDocs                : TUniQuery;
  LstrTipRel              : String;
  LarrArquivos            : TStringArray;
  LstrColDocOri           : String;
  SLArquivosNaoDig        : TStringList;
  LstrArquivosCompactados : String;
  LblnEspDoc_FF_DV_TR     : Boolean;
  LstrMensagemExcecao     : String;
Begin
  Result := '';
  setLength(LarrArquivos, 0);
  SLArquivosNaoDig    := TStringList.Create;
  LblnEspDoc_FF_DV_TR := False;
  Try

    If (lblDocConf.Visible) Then
    Begin
      LstrColDocOri := cdsGenDoc.FieldByName('DOCORI').AsString;

      {DOCUMENTOS DA CONFIRMAÇÃO}
      If fRetTipDocOri(LstrColDocOri) = TTDOPedOrc Then
        LstrTipRel := '1'
      Else
      Begin
        If fRetTipDocOri(LstrColDocOri) = TTDODocConf Then
          LstrTipRel := '2'
        Else
          LstrTipRel := '3';
      end;
    End
    Else
      LstrTipRel := 'X'; {QUANDO TROUXER SOMENTE 1 DOCUMENTO, COMO NÃO TENHO O AUTOINCREM DELE, NEM O ESPDOC, BUSCO EM TODAS AS ORIGENS}

    Try
      LqryDocs := fCriaQuery;
      LqryDocs.Close;
      LqryDocs.SQL.Clear;

      If (LstrTipRel = '1') Or (LstrTipRel = 'X') Then
      Begin
        LqryDocs.SQL.Add('SELECT DISTINCT FGO_DTAENT AS DTAENT, ');
        LqryDocs.SQL.Add('       CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC) AS NUMDOC,');
        LqryDocs.SQL.Add('       FGO_CODEMP AS CODEMP,');
        LqryDocs.SQL.Add('       FATGOR.AUTOINCREM,   ');
        LqryDocs.SQL.Add('       FGO_ESPDOC AS ESPDOC ');
        LqryDocs.SQL.Add('FROM FATGOR');
        LqryDocs.SQL.Add('INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
        LqryDocs.SQL.Add('WHERE FDO_NUMFAT = :NUMDOC');
        LqryDocs.SQL.Add('  AND FDO_TIPFAT = :ESPDOC');
        LqryDocs.SQL.Add('  AND FDO_EMPFAT = :CODEMP');
        LqryDocs.SQL.Add('  AND FDO_CODCLI = :CODCLI');
        LqryDocs.SQL.Add('  AND FDO_JAFATU = 1');
        LqryDocs.ParamByName('NUMDOC').AsString := strNumDoc;
        LqryDocs.ParamByName('ESPDOC').AsString := strEspDoc;
        LqryDocs.ParamByName('CODEMP').AsString := strEmpDoc;
        LqryDocs.ParamByName('CODCLI').AsString := strCodCli;

        If (LstrTipRel = 'X') Then
          LqryDocs.SQL.Add('  UNION ALL ');
      End;

      If (LstrTipRel = '2') Or (LstrTipRel = 'X') Then
      Begin
        LqryDocs.SQL.Add('SELECT DISTINCT GER_DTAENT AS DTAENT,');
        LqryDocs.SQL.Add('       CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC,');
        LqryDocs.SQL.Add('       GER_CODEMP AS CODEMP,');
        LqryDocs.SQL.Add('       MOVGER.AUTOINCREM,   ');
        LqryDocs.SQL.Add('       GER_ESPDOC AS ESPDOC ');
        LqryDocs.SQL.Add('FROM MOVGER ');
        LqryDocs.SQL.Add('  INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM');
        LqryDocs.SQL.Add('WHERE DET_NUMFAT = :NUMDOC');
        LqryDocs.SQL.Add('  AND DET_TIPFAT = :ESPDOC');
        LqryDocs.SQL.Add('  AND DET_EMPFAT = :CODEMP');
        LqryDocs.ParamByName('NUMDOC').AsString := strNumDoc;
        LqryDocs.ParamByName('ESPDOC').AsString := strEspDoc;
        LqryDocs.ParamByName('CODEMP').AsString := strEmpDoc;

        If (LstrTipRel = 'X') Then
          LqryDocs.SQL.Add('  UNION ALL ');
      End;

      If (LstrTipRel = '3') Or (LstrTipRel = 'X') Then
      Begin
        LqryDocs.SQL.Add('SELECT DISTINCT GER_DTAENT AS DTAENT,');
        LqryDocs.SQL.Add('       CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC,');
        LqryDocs.SQL.Add('       GER_CODEMP AS CODEMP,');
        LqryDocs.SQL.Add('       MOVGER.AUTOINCREM,   ');
        LqryDocs.SQL.Add('       GER_ESPDOC AS ESPDOC ');
        LqryDocs.SQL.Add('FROM MOVGER          ');
        LqryDocs.SQL.Add('  INNER JOIN MOVDET  ');
        LqryDocs.SQL.Add('    ON (             ');
        LqryDocs.SQL.Add('      DET_SEQGER = :AUTINC');
        LqryDocs.SQL.Add('      AND MOVGER.GER_NUMDOC = MOVDET.DET_DOCFUT');
        LqryDocs.SQL.Add('      AND MOVGER.GER_ESPDOC = MOVDET.DET_ESPFUT');
        LqryDocs.SQL.Add('      AND MOVGER.GER_CODEMP = MOVDET.DET_EMPFUT');
        LqryDocs.SQL.Add('      )');
        LqryDocs.SQL.Add(' WHERE TRUE ');
        LqryDocs.ParamByName('AUTINC').AsString := strAutInc;
      End;

      LqryDocs.Open;

      If Not LqryDocs.IsEmpty Then
      Begin
        strPath := ExtractFilePath(Application.ExeName);
        strPath := IncludeTrailingPathDelimiter(strPath) + IncludeTrailingPathDelimiter(FormatDateTime('yyyymmdd_hhnnsszzz', fNow));

        if not CreateDir(strPath) then
          raise Exception.CreateFmt('Não foi possível criar o diretório %s', [strPath]);

        {VERIFICAR SE TODOS FORAM DIGITALIZADOS}
        LqryDocs.First;
        While not LqryDocs.EOF do
        Begin
          If (Pos(LqryDocs.FieldbyName('ESPDOC').AsString, 'FF_DV_TR_') > 0) Then
            LblnEspDoc_FF_DV_TR := True;

          If (Pos(LqryDocs.FieldbyName('ESPDOC').AsString, 'FF_DV_TR_') > 0) And
             Not fGeraArquivoConfirmacao(LqryDocs.FieldbyName('AUTOINCREM').asString, strPath, LarrArquivos ) then
          Begin
            SLArquivosNaoDig.Add( LqryDocs.FieldbyName('NUMDOC').AsString + '-' +  LqryDocs.FieldbyName('CODEMP').AsString) ;
          End;
          LqryDocs.Next;
        End;

        If SLArquivosNaoDig.Count > 0  Then
        Begin
          pExibirListaDocumentosNaoDigitalizados('Há documentos que pertencem a essa confirmação que ainda não foram digitalizados. ' +
                                                 'Por favor, digitalize-os para prosseguir!' + #13#10 + #13#10 +
                                                 SLArquivosNaoDig.Text);

          {REMOVENDO O DIRETORIO CRIADO PARA OS ARQUIVOS DIGITALIZADOS DE CONFIRMAÇÃO}
          pApagarArquivosConfirmacao(strPath, LarrArquivos);
          setLength(LarrArquivos, 0);
        End;

      End;
    Finally
      FreeAndNil(LqryDocs);
    End;

    {Compactando arquivos }
    if Length(LarrArquivos) > 0 then
    begin
      LstrArquivosCompactados := EmptyStr;
      LstrMensagemExcecao     := EmptyStr;
      If (LblnEspDoc_FF_DV_TR) And
         (fCfgSis('TAMANX', varInteger) > 0) Then
      Begin
        If (untTEnvioEmail.CompactarArquivos(strPath, 'Documentos Digitalizados.zip', LarrArquivos, LstrArquivosCompactados, LstrMensagemExcecao, True, fCfgSis('TAMANX', varInteger))) Then
          Result := LstrArquivosCompactados;

        If Not fEmptyStr(LstrMensagemExcecao) Then
          raise Exception.Create(LstrMensagemExcecao)
      End
      Else If untTEnvioEmail.CompactarArquivos(strPath, 'Documentos Digitalizados.zip', LarrArquivos) Then
        Result := strPath + 'Documentos Digitalizados.zip'
      Else
        raise Exception.Create('Não foi possível criar o arquivo compactado!');
    end;

  Finally
    FreeAndNil(SLArquivosNaoDig);
  End;
End;

function TfrmReimpressaoDocsList.fMontaArquivosXML(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTipFC, strNumSer, strPath: String;
  blnExibiMsg: Boolean): String;
var
  strPathXML    : String;
  strArquivoXML : String;
  strAcesso     : String;


  function fGetXMLFIT():String;
  var
    objLibNFe : TLibNFe;
  begin
    objLibNFe := TLibNfe.Create(strCodEmp);
    try
      Result := objLibNFe.fXMLNFE(strCodEmp, strAcesso);
    finally
      FreeAndNil(objLibNFe);
    end;
  end;

  procedure pGravarArquivoXML();
  var
    stlXMLFile : TStringList;
  begin
    if (not FileExists(ExtractFilePath(strPathXML))) then
      ForceDirectories(ExtractFilePath(strPathXML));

    stlXMLFile := TStringList.Create;
    try
      stlXMLFile.Text := strArquivoXML;
      stlXMLFile.SaveToFile(strPathXML);
    finally
      FreeAndNil(stlXMLFile);
    end;
  end;
begin
  Result := '';

  strAcesso := fRetornaChaveAcesso(strNumDoc,
                                   strEspDoc,
                                   strCodEmp,
                                   strCodCli,
                                   strSerie,
                                   strTipFC,
                                   strNumSer);

  If fEmptyStr(strAcesso) Then
  Begin
    If blnExibiMsg Then
      pMensagemOk('Esta nota não é uma NFe/NFSe/NFCe ou ainda não foi autorizada.');
    Exit;
  End;

  if (SameText(strEspDoc, 'IF')) then
  begin
    strArquivoXML := fGetXMLFIT();
  end
  else if (String('NF_NS_').Contains(strEspDoc)) then
  begin
    strArquivoXML := fRetornaArquivoXMLNFe(strAcesso);

    if (fEmptyStr(strArquivoXML)) then
      strArquivoXML := fGetXMLFIT();
  end;

  if (fEmptyStr(strArquivoXML)) then
  begin
    If blnExibiMsg Then
      pMensagemOk('Arquivo XML não foi encontrado.');
    Exit;
  end;

  strPathXML := IncludeTrailingPathDelimiter(strPath) + fUpper(strEspDoc) + '_' + strNumDoc + '_'+ strCodEmp + '.xml';

  pGravarArquivoXML();

  Result := strPathXML;
end;

function TfrmReimpressaoDocsList.fMontaPDFDANFeNFCe(strNumDoc,
                                                    strEspDoc,
                                                    strCodEmp,
                                                    strCodCli,
                                                    strSerie,
                                                    strTipFC : String;
                                                    Var strNumSer : String;
                                                    strPath : String;
                                                    blnGerandoParaDisparoDeGatilho: Boolean): String;
var
  strAcesso : String;
  frmQckFatImpNFCe : TfrmQckFatImpNFCe;
begin
  Result := '';

  if (not SameText(strEspDoc, 'IF')) then
  begin
    pMensagemOK('Documento não é uma NFC-e!');
    Exit;
  end;

  strAcesso := fRetornaChaveAcesso(strNumDoc,
                                   strEspDoc,
                                   strCodEmp,
                                   strCodCli,
                                   strSerie,
                                   strTipFC,
                                   strNumSer);

  strPath := IncludeTrailingPathDelimiter(strPath) + fUpper(strEspDoc) + '_' + strNumDoc + '_' + strCodEmp + '.pdf';

  frmQckFatImpNFCe := TfrmQckFatImpNFCe.Create(nil);
  try
    frmQckFatImpNFCe.pImprimirDanfeNFCe(strNumDoc,
                                        strEspDoc,
                                        strCodEmp,
                                        strCodCli,
                                        strSerie,
                                        strTipFC,
                                        '',
                                        True,
                                        strAcesso,
                                        False,
                                        strPath,
                                        -1,
                                        blnGerandoParaDisparoDeGatilho);

    if (FileExists(frmQckFatImpNFCe.frxExpPDF.FileName)) then
      Result := frmQckFatImpNFCe.frxExpPDF.FileName;
  finally
    FreeAndNil(frmQckFatImpNFCe);
  end;
end;
procedure TfrmReimpressaoDocsList.pExibirListaDocumentosNaoDigitalizados(const strMensagem: String);
var
  frmObservacao: TfrmObservacao;
Begin
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Atenção!';
    frmObservacao.lblMensagem.Visible := False;
    frmObservacao.memObs.Text := strMensagem;
    frmObservacao.memObs.SelStart := 0;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
End;

function TfrmReimpressaoDocsList.fGeraArquivoConfirmacao(strAutoInc : String; strPath : String; var arrArquivos: TStringArray ): Boolean;
{GERA FISICAMENTE OS ARQUIVOS DIGITALIZADOS PARA POSTERIOR USO/ENVIO}
var
  LqryConsulta: TUniQuery;
  LstrSQL: String;
  LtmpImg: TBytesStream;
  LstrNomArq: String;
  LintSeqArq: Integer;
begin
  Result := False;

  If Not DirectoryExists(strPath) Then
  Begin
    If Not CreateDir(strPath) Then
      raise Exception.CreateFmt('Não foi possível criar o diretório %s', [strPath]);
  End;

  LqryConsulta := fCriaQuery;
  try
    Try
      LstrSQL := '';
      LstrSQL := LstrSQL + 'SELECT ';
      LstrSQL := LstrSQL + '  DIG_NUMDOC, ';
      LstrSQL := LstrSQL + '  DIG_ESPDOC, ';
      LstrSQL := LstrSQL + '  DIG_EMPDOC, ';
      LstrSQL := LstrSQL + '  DIG_NOMARQ, ';
      LstrSQL := LstrSQL + '  DIG_IMGB64  ';
      LstrSQL := LstrSQL + 'FROM MOVDIG   ';
      LstrSQL := LstrSQL + 'WHERE DIG_SEQGER = :AUTOINCREM';

      LqryConsulta.SQL.Text := LstrSQL;
      LqryConsulta.ParamByName('AUTOINCREM').AsString := strAutoInc;
      LqryConsulta.Open;

      If not LqryConsulta.IsEmpty then
      Begin
        LqryConsulta.First;
        while not LqryConsulta.Eof do
        begin
          LstrNomArq :=
            LqryConsulta.FieldByName('DIG_NUMDOC').AsString +
            '-' +
            LqryConsulta.FieldByName('DIG_ESPDOC').AsString +
            '-' +
            LqryConsulta.FieldByName('DIG_EMPDOC').AsString +
            ExtractFileExt(LqryConsulta.FieldByName('DIG_NOMARQ').AsString);

          LintSeqArq := 0;
          while FileExists(strPath + LstrNomArq) do
          begin
            inc(LintSeqArq);

            LstrNomArq :=
              LqryConsulta.FieldByName('DIG_NUMDOC').AsString +
              '-' +
              LqryConsulta.FieldByName('DIG_ESPDOC').AsString +
              '-' +
              LqryConsulta.FieldByName('DIG_EMPDOC').AsString +
              '-' +
              IntToStr(LintSeqArq) +
              ExtractFileExt(LqryConsulta.FieldByName('DIG_NOMARQ').AsString);
          end;

          setLength(arrArquivos, Length(arrArquivos) + 1);
          arrArquivos[High(arrArquivos)] := LstrNomArq;

          LtmpImg := TBytesStream.Create(nil);
          Try
            fStreamFromBase64(LqryConsulta.FieldByName('DIG_IMGB64').AsString, LtmpImg);
            If (LtmpImg.Size > 0) Then
              LtmpImg.SaveToFile(IncludeTrailingPathDelimiter(strPath) + LstrNomArq);
          Finally
            LtmpImg.Free;
          End;

          LqryConsulta.Next;
        end;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Ocorreram Erros ao gerar fisicamente arquivos da confirmação digitalizados: ' + E.Message, '[fGeraArquivoConfirmacao]');
        Result := False;
      End;
    End;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;

function TfrmReimpressaoDocsList.fBuscaBoletos(strNumDoc, strEmpDoc, strEspDoc, strCodCli : String): String;
{AGRUPANDO OS BOLETOS GERADOS PARA O DOCUMENTO PARA O ENVIO POR EMAIL}
var
  LstrPath     : String;
  LqryConsulta : TUniQuery;
  LstrNomArq   : String;
  LarrArquivos : TStringArray;
  AParams: String;
  LStringBoletosAnexo : String;

  LArquivoExiste: Boolean;
begin
  Result := '';

  LStringBoletosAnexo := '';

  If (fCfgSis('GRVBOL') = '1') Then //And (Not ABoletoCarne) Then
     LstrPath :=  ExtractFilePath(Application.ExeName) + 'Boletos\'
  Else
     LstrPath :=  ExtractFilePath(Application.ExeName) + 'Boletos_'+ strEmpDoc +'\';

  //LstrPath :=  ExtractFilePath(Application.ExeName) + 'Boletos\';
  setLength(LarrArquivos, 0);

  LqryConsulta := fCriaQuery;
  try
    Try
      LqryConsulta.SQL.Clear;
      LqryConsulta.SQL.Add('SELECT ');

      If fEhBoletoCarneReimpressaoMonitorAtivo Then
        LqryConsulta.SQL.Add(' CTR_NUMDUP AS NROBOLETO ')
      Else
        LqryConsulta.SQL.Add(' CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NROBOLETO ');

      LqryConsulta.SQL.Add(', AUTOINCREM, ');
      LqryConsulta.SQL.Add('  CTR_NUMDUP ');
      LqryConsulta.SQL.Add('FROM CADREC   ');
      LqryConsulta.SQL.Add('WHERE CTR_CODEMP  = :CODEMP');
      LqryConsulta.SQL.Add('  AND CTR_NUMDUP  = :NUMDOC');
      LqryConsulta.SQL.Add('  AND CTR_ESPDOC  = :ESPDOC');
      LqryConsulta.SQL.Add('  AND CTR_CODCLI  = :CODCLI');
      LqryConsulta.SQL.Add('  AND CTR_VALDUP > 0.00 AND CTR_DTAREC IS NULL');
      LqryConsulta.SQL.Add('ORDER BY CTR_NUMDUP, CTR_PARCEL');

      If fEhBoletoCarneReimpressaoMonitorAtivo Then
        LqryConsulta.SQL.Add(' LIMIT 1 ');

      LqryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
      LqryConsulta.ParamByName('CODEMP').AsString := strEmpDoc;
      LqryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
      LqryConsulta.ParamByName('CODCLI').AsString := strCodCli;
      LqryConsulta.Open;

      If not LqryConsulta.IsEmpty then
      Begin
        LqryConsulta.First;
        while not LqryConsulta.Eof do
        begin
          LArquivoExiste := VerificaSeArquivoBoletoExiste(LqryConsulta,
                                                          LstrPath,
                                                          LstrNomArq);

          If Not LArquivoExiste Then
          Begin
            IF fCfgSis('REIMPB', varBoolean) Then
            Begin
              AParams := '';
              AParams := Concat(AParams, ' ', VS_strCodEmp);
              AParams := Concat(AParams, ' ', 'PDF');
              AParams := Concat(AParams, ' ', LqryConsulta.FieldByName('AUTOINCREM').AsString);

              TUtilMonitor.pTestInactivity(spIdInactivityMonitorEmail,
                                           spTimeLimitMonitorEmail,
                                           VS_objProcessoMonitorEmail,
                                           VS_dtaUltimaExecucaoMonitorEmail);

              TUtilMonitor.pRunMonitor(spIdMonitorEmail,
                                       VS_objProcessoMonitorEmail,
                                       VS_dtaUltimaExecucaoMonitorEmail,
                                       spEnviaEmailBoletoExeName,
                                       AParams);

              TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorEmail, [VS_strCodEmp]),
                                              spAttemptsLockMonitorEmail);

              Sleep(3000);
              LstrNomArq := LqryConsulta.FieldByName('NROBOLETO').AsString + '.pdf';
              LArquivoExiste := FileExists(LstrPath + LstrNomArq);

              pTrimAppMemorySize;
              Application.ProcessMessages;

            End;
          End;

          If LArquivoExiste Then
          Begin
            If Pos(LstrPath + LstrNomArq + ';', LStringBoletosAnexo) = 0 Then
            Begin
              setLength(LarrArquivos, Length(LarrArquivos) + 1);
              LarrArquivos[High(LarrArquivos)] := LstrNomArq;

              LStringBoletosAnexo := LStringBoletosAnexo + (LstrPath + LstrNomArq) + ';';
            End;
          End;

          LqryConsulta.Next;

        End;

        {Compactando arquivos }
        If Length(LarrArquivos) > 0 then
        begin
           Result := LStringBoletosAnexo;
          { Req: 251803;
          If untTEnvioEmail.CompactarArquivos(LstrPath, 'Boletos.zip', LarrArquivos) then
            Result := LstrPath + 'Boletos.zip'
          Else
            raise Exception.Create('Não foi possível criar o arquivo compactado!');}
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Ocorreram Erros ao buscar boletos: ' + E.Message, '[fBuscaBoletos]');
        Result := '';
      End;
    End;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;

function TfrmReimpressaoDocsList.fDocumentoOrigemFF_DV_TR(const strAutInc,
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
Var
  LqryDocs      : TUniQuery;
  LstrTipRel    : String;
  LstrColDocOri : String;
begin
  LqryDocs := fCriaQuery;
  Try
    LqryDocs.Close;
    LqryDocs.SQL.Clear;

    If (lblDocConf.Visible) Then
    Begin
      LstrColDocOri := cdsGenDoc.FieldByName('DOCORI').AsString;

      {DOCUMENTOS DA CONFIRMAÇÃO}
      If fRetTipDocOri(LstrColDocOri) = TTDOPedOrc Then
        LstrTipRel := '1'
      Else
      Begin
        If fRetTipDocOri(LstrColDocOri) = TTDODocConf Then
          LstrTipRel := '2'
        Else
          LstrTipRel := '3';
      end;
    End
    Else
      LstrTipRel := 'X'; {QUANDO TROUXER SOMENTE 1 DOCUMENTO, COMO NÃO TENHO O AUTOINCREM DELE, NEM O ESPDOC, BUSCO EM TODAS AS ORIGENS}

    If (LstrTipRel = '1') Or (LstrTipRel = 'X') Then
    Begin
      LqryDocs.SQL.Add('SELECT DISTINCT FGO_DTAENT AS DTAENT, ');
      LqryDocs.SQL.Add('       CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC) AS NUMDOC,');
      LqryDocs.SQL.Add('       FGO_CODEMP AS CODEMP,');
      LqryDocs.SQL.Add('       FATGOR.AUTOINCREM,   ');
      LqryDocs.SQL.Add('       FGO_ESPDOC AS ESPDOC ');
      LqryDocs.SQL.Add('FROM FATGOR');
      LqryDocs.SQL.Add('INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
      LqryDocs.SQL.Add('WHERE FDO_NUMFAT = :NUMDOC');
      LqryDocs.SQL.Add('  AND FDO_TIPFAT = :ESPDOC');
      LqryDocs.SQL.Add('  AND FDO_EMPFAT = :CODEMP');
      LqryDocs.SQL.Add('  AND FDO_CODCLI = :CODCLI');
      LqryDocs.SQL.Add('  AND FDO_JAFATU = 1');
      LqryDocs.ParamByName('NUMDOC').AsString := strNumDoc;
      LqryDocs.ParamByName('ESPDOC').AsString := strEspDoc;
      LqryDocs.ParamByName('CODEMP').AsString := strCodEmp;
      LqryDocs.ParamByName('CODCLI').AsString := strCodCli;

      If (LstrTipRel = 'X') Then
        LqryDocs.SQL.Add('  UNION ALL ');
    End;

    If (LstrTipRel = '2') Or (LstrTipRel = 'X') Then
    Begin
      LqryDocs.SQL.Add('SELECT DISTINCT GER_DTAENT AS DTAENT,');
      LqryDocs.SQL.Add('       CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC,');
      LqryDocs.SQL.Add('       GER_CODEMP AS CODEMP,');
      LqryDocs.SQL.Add('       MOVGER.AUTOINCREM,   ');
      LqryDocs.SQL.Add('       GER_ESPDOC AS ESPDOC ');
      LqryDocs.SQL.Add('FROM MOVGER ');
      LqryDocs.SQL.Add('  INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM');
      LqryDocs.SQL.Add('WHERE DET_NUMFAT = :NUMDOC');
      LqryDocs.SQL.Add('  AND DET_TIPFAT = :ESPDOC');
      LqryDocs.SQL.Add('  AND DET_EMPFAT = :CODEMP');
      LqryDocs.ParamByName('NUMDOC').AsString := strNumDoc;
      LqryDocs.ParamByName('ESPDOC').AsString := strEspDoc;
      LqryDocs.ParamByName('CODEMP').AsString := strCodEmp;

      If (LstrTipRel = 'X') Then
        LqryDocs.SQL.Add('  UNION ALL ');
    End;

    If (LstrTipRel = '3') Or (LstrTipRel = 'X') Then
    Begin
      LqryDocs.SQL.Add('SELECT DISTINCT GER_DTAENT AS DTAENT,');
      LqryDocs.SQL.Add('       CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC,');
      LqryDocs.SQL.Add('       GER_CODEMP AS CODEMP,');
      LqryDocs.SQL.Add('       MOVGER.AUTOINCREM,   ');
      LqryDocs.SQL.Add('       GER_ESPDOC AS ESPDOC ');
      LqryDocs.SQL.Add('FROM MOVGER          ');
      LqryDocs.SQL.Add('  INNER JOIN MOVDET  ');
      LqryDocs.SQL.Add('    ON (             ');
      LqryDocs.SQL.Add('      DET_SEQGER = :AUTINC');
      LqryDocs.SQL.Add('      AND MOVGER.GER_NUMDOC = MOVDET.DET_DOCFUT');
      LqryDocs.SQL.Add('      AND MOVGER.GER_ESPDOC = MOVDET.DET_ESPFUT');
      LqryDocs.SQL.Add('      AND MOVGER.GER_CODEMP = MOVDET.DET_EMPFUT');
      LqryDocs.SQL.Add('      )');
      LqryDocs.SQL.Add(' WHERE TRUE ');
      LqryDocs.ParamByName('AUTINC').AsString := strAutInc;
    End;

    LqryDocs.Open;
  Finally
    Result := (Assigned(LqryDocs)) And (LqryDocs.Active) And (Not LqryDocs.IsEmpty);
    FreeAndNil(LqryDocs);
  End;
end;

procedure TfrmReimpressaoDocsList.pApagarArquivosConfirmacao(strPath : String; arrArquivos: TStringArray);
Var intCont : Integer;
Begin
  {Apagar arquivos digitalizados da pasta}
  If DirectoryExists(strPath) Then
  Begin
    For intCont := 0 To Length(arrArquivos) - 1 Do
    Begin
      If FileExists(strPath + ExtractFileName(arrArquivos[intCont])) Then
        DeleteFile(strPath + ExtractFileName(arrArquivos[intCont]));
    End;
    RemoveDir(strPath);
  End;
End;

function TfrmReimpressaoDocsList.fValidaDireitoAcessoReimprimirDanfe: boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'REDANF';
  objLiberacao.strMsgSen    := 'Permitir Reimprimir DANFE na Reimpressão de Documentos.';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Permitir Reimprimir DANFE na Reimpressão de Documentos.' + sLineBreak +
                                      cdsGenDoc.FieldByName('ESPDOC').AsString + ': ' +
                                      cdsGenDoc.FieldByName('NUMDOC').AsString + '-' +
                                      cdsGenDoc.FieldByName('ESPDOC').AsString + '-' +
                                      cdsGenDoc.FieldByName('CODEMP').AsString);

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    cdsGenDoc.FieldByName('NUMDOC').AsString,
                    cdsGenDoc.FieldByName('ESPDOC').AsString,
                    cdsGenDoc.FieldByName('CODEMP').AsString);

  Result := objLiberacao.fLibera;
end;

function TfrmReimpressaoDocsList.fValidaDireitoAcessoGerarDanfe: boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'GEDANFRD';
  objLiberacao.strMsgSen    := 'Permitir Gerar Danfe em PDF na Reimpressão de Documentos.';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Permitir Gerar Danfe em PDF na Reimpressão de Documentos.' + sLineBreak +
                                      cdsGenDoc.FieldByName('ESPDOC').AsString + ': ' +
                                      cdsGenDoc.FieldByName('NUMDOC').AsString + '-' +
                                      cdsGenDoc.FieldByName('ESPDOC').AsString + '-' +
                                      cdsGenDoc.FieldByName('CODEMP').AsString);

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    cdsGenDoc.FieldByName('NUMDOC').AsString,
                    cdsGenDoc.FieldByName('ESPDOC').AsString,
                    cdsGenDoc.FieldByName('CODEMP').AsString);

  Result := objLiberacao.fLibera;
end;

function TfrmReimpressaoDocsList.fGerarPDFDanfe(const blnAbrirPDF: Boolean;
  const strCaminhoArquivo: String; blnExibiMsg: Boolean; blnGerandoParaDisparoDeGatilho: Boolean): String;
var
  strAcesso: String;
  strSerie: String;
  libNfe: TLibNfe;
  blnPodeReimprimirDocumento : Boolean;
  strDirCompleto : String;
  srtNfeImpressaoExe: String;
  blnAcesso : Boolean;
  strEmpresa: String;
  LDiretorioDanfe: String;

begin
  inherited;
  Result := EmptyStr;

  blnPodeReimprimirDocumento := (Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'NF_NS_CT_IF') > 0);

  If not blnPodeReimprimirDocumento Then
  Begin
    If blnExibiMsg Then
      pMensagemOk('Este documento não é uma NF/NS/CTE ou ainda não foi autorizada.');

    Exit;
  End;

  If Pos(cdsGenDoc.FieldByName('ESPDOC').AsString, 'NF_NS_') > 0 Then
  Begin
    blnAcesso := fVerificaAcessoSistema('GEDANFRD');
    If (Not blnAcesso) Then
      blnAcesso := fValidaDireitoAcessoGerarDanfe;

    If (not blnAcesso) Then
      exit;
  End;

  strAcesso := fRetornaChaveAcesso(cdsGenDoc.FieldByName('NUMDOC').AsString,
                                   cdsGenDoc.FieldByName('ESPDOC').AsString,
                                   cdsGenDoc.FieldByName('CODEMP').AsString,
                                   cdsGenDoc.FieldByName('CODCLI').AsString,
                                   cdsGenDoc.FieldByName('SERIE_').AsString,
                                   cdsGenDoc.FieldByName('TIP_FC').AsString,
                                   strSerie);

  If fEmptyStr(strAcesso) Then
  Begin
    If blnExibiMsg Then
      pMensagemOk('Esta nota não é uma NFe ou ainda não foi autorizada.');

    Exit;
  End;

  If (cdsGenDoc.FieldByName('ORIDOC').AsString = 'V') And (Not fRefazLogNfeCasoExcluido(strAcesso)) Then
  Begin
    If blnExibiMsg Then
      pMensagemOk('Nao foi possível recriar a LOGNFE com a nota selecionada.');

    Exit;
  End;

  LDiretorioDanfe := fRetornaDiretorioDanfe(blnGerandoParaDisparoDeGatilho);

  strEmpresa := cdsGenDoc.FieldByName('CODEMP').AsString;

  If fEmptyStr(strEmpresa) Then
  Begin
    strEmpresa := VS_strCodEmp;
  End;

  Try

    If Not DirectoryExists(LDiretorioDanfe) Then
      CreateDir(LDiretorioDanfe);

    if fEmptyStr(strCaminhoArquivo) then
    begin
      strDirCompleto := LDiretorioDanfe + 'Tela' + strAcesso + '.pdf'
    end
    else
      strDirCompleto := strCaminhoArquivo;

    If (cdsGenDoc.FieldByName('ESPDOC').AsString = 'IF') And (Not fCfgSis('PRNFCE', varBoolean)) Then
    Begin
      pReimprimirNFCe(True);
      Exit;
    End;

    If fCfgSis('CITINF', varBoolean) Then
    Begin
      srtNfeImpressaoExe :=  TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel;
      If Not FileExists(srtNfeImpressaoExe) Then
      Begin
        If blnExibiMsg Then
          fMensagem('', 'Não foi encontrado o arquivo NFeImpressao.exe para a impressão.' + #13#10 +
                        'Arquivo informado:' + srtNfeImpressaoExe, ['&O k']);
        Exit;
      End;
    End;

    If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao or fEhEmissaoDeNotaDeProdutoPeloNfeImpressao(strEmpresa) or fEhEmissaoDeCupomFiscalPeloNfeImpressao) Then
    Begin

      If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao) Then
        TImpressaoDiretaCitel.pImprimirPDF(strEmpresa,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFS',
                                           True,
                                           strDirCompleto,
                                           blnAbrirPDF)

      Else

      If (fEhEmissaoDeCupomFiscalPeloNfeImpressao) Then
        TImpressaoDiretaCitel.pImprimirPDF(strEmpresa,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFCE',
                                           True,
                                           strDirCompleto,
                                           blnAbrirPDF)
      Else

        TImpressaoDiretaCitel.pImprimirPDF(strEmpresa,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFE',
                                           True,
                                           strDirCompleto,
                                           blnAbrirPDF)
    End
    Else
    Begin

      libNfe := TLibNfe.Create(strEmpresa);
      Try
        if cdsGenDoc.FieldByName('ESPDOC').AsString = 'CT' then
          libNfe.pReimprimirConhecimentoEletronico(
            Copy(cdsGenDoc.FieldByName('NUMDOC').AsString, 4, 9),
            'ImpressaoEmTelaPDF')
        else
          libNfe.pReimprimirDanfe(strAcesso, '', cdsGenDoc.FieldByName('SERIE_').AsString, 'TelaPDF');
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[Reimpressão de Danfe.]');
        End;
      End;
      FreeAndNil(libNfe);

    End;

    Result := strDirCompleto;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Reimpressão de Danfe.]');
    End;
  End;
end;

function TfrmReimpressaoDocsList.fImprimeTermoAceite: Boolean;
Begin
  Result := (((cdsGenDoc.FieldByName('ESPDOC').AsString = 'PD') and ((strPrgPor = '1') or (strPrgPor = '3'))) or
             ((cdsGenDoc.FieldByName('ESPDOC').AsString = 'OR') and ((strPrgPor = '2') or (strPrgPor = '3'))));
End;

procedure TfrmReimpressaoDocsList.pMostraDocumentosDevolvidos;
begin

  If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(333, 13280, [13280],
                          ['NUMDOC',
                           'ESPDOC',
                           'CODEMP',
                           'SERIE_',
                           'TIP_FC',
                           'CODCLI'],
                          [cdsGenDoc.FieldByName('NUMDOC').AsString,
                           cdsGenDoc.FieldByName('ESPDOC').AsString,
                           cdsGenDoc.FieldByName('CODEMP').AsString,
                           cdsGenDoc.FieldByName('SERIE_').AsString,
                           cdsGenDoc.FieldByName('TIP_FC').AsString,
                           cdsGenDoc.FieldByName('CODCLI').AsString],
                          lblDocDev,
                          Nil,
                          True);

end;

procedure TfrmReimpressaoDocsList.pReimprimirCupEndEnt;
  function fRetSqlEndEnt : string;
  begin
    Result := '';

    Result := Result + '  SELECT  ';
    Result := Result + '   CID_NOMCID AS NOMCID, ';
    Result := Result + '   CID_ESTADO AS ESTADO, ';
    Result := Result + '   ETC_ENDENT AS ENDENT, ';
    Result := Result + '   ETC_BAIENT AS BAIENT, ';
    Result := Result + '   ETC_CEPENT AS CEPENT  ';
    Result := Result + '  FROM         ';
    Result := Result + '    ENTCLI     ';
    Result := Result + '    INNER JOIN AUXMOV ';
    Result := Result + '      ON AUX_ENTGER = AUTOINCREM ';
    Result := Result + '      AND AUX_SEQGER = :AUTOINCREM ';
    Result := Result + '    INNER JOIN CADCID              ';
    Result := Result + '      ON CID_CODCID = ETC_CIDENT   ';
    Result := Result + '  UNION                            ';
    Result := Result + '  ALL                              ';
    Result := Result + '  SELECT                           ';
    Result := Result + '   CID_NOMCID AS NOMCID, ';
    Result := Result + '   CID_ESTADO AS ESTADO, ';
    Result := Result + '   ETC_ENDENT AS ENDENT, ';
    Result := Result + '   ETC_BAIENT AS BAIENT, ';
    Result := Result + '   ETC_CEPENT AS CEPENT ';
    Result := Result + '  FROM                             ';
    Result := Result + '    ENTCLI                         ';
    Result := Result + '    INNER JOIN AUXNOT              ';
    Result := Result + '      ON AUX_ENTGER = AUTOINCREM   ';
    Result := Result + '      AND AUX_SEQGER = :AUTOINCREM ';
    Result := Result + '    INNER JOIN CADCID              ';
    Result := Result + '      ON CID_CODCID = ETC_CIDENT   ';
  end;

  function fRetSqlDupCadRec(strNumDoc, strEmpDoc, strEspDoc : string) : string;
  begin
    Result := '';
    Result := Result + ' SELECT CTR_VALDUP AS VALDUP FROM CADREC ';
    Result := Result + Format(' WHERE CTR_NUMDUP = %s AND CTR_CODEMP = %s AND CTR_ESPDOC = %s',
                         [QuotedStr(strNumDoc),
                          QuotedStr(strEmpDoc),
                          QuotedStr(strEspDoc)]);
  end;

  procedure pValidaEndCliente(var recDadosImpVen : TDadosImpressaoVenda);
  var
    qryEnd : TUniQuery;
  begin
    qryEnd := fCriaQuery();
    try
      try
        qryEnd.SQL.Text := fRetSqlEndEnt;
        qryEnd.ParamByName('AUTOINCREM').AsString := dtsGenDoc.DataSet.FieldByName('AUTINC').AsString;
        qryEnd.Open;
        if not qryEnd.IsEmpty then
        begin
          recDadosImpVen.recEndEnt.strCepEnt := qryEnd.FieldByName('CEPENT').AsString;
          recDadosImpVen.recEndEnt.strBaiEnt := qryEnd.FieldByName('BAIENT').AsString;
          recDadosImpVen.recEndEnt.strEndEnt := qryEnd.FieldByName('ENDENT').AsString;
          recDadosImpVen.recEndEnt.strNomCid := qryEnd.FieldByName('NOMCID').AsString;
          recDadosImpVen.recEndEnt.strEstEnt := qryEnd.FieldByName('ESTADO').AsString;
        end;

        recDadosImpVen.strCliCep := dtsGenDoc.DataSet.FieldByName('C_E_P_').AsString;
        recDadosImpVen.strCliEnd := dtsGenDoc.DataSet.FieldByName('ENDERE').AsString +
          IIF(fEmptyStr(dtsGenDoc.DataSet.FieldByName('ENDNUM').AsString)
              , ''
              , ', ' + dtsGenDoc.DataSet.FieldByName('ENDNUM').AsString);
        recDadosImpVen.strCliBai := dtsGenDoc.DataSet.FieldByName('BAIRRO').AsString;
        recDadosImpVen.strCliCid := fRetNomCidade(dtsGenDoc.DataSet.FieldByName('CODCID').AsString,0);
        recDadosImpVen.strCliEst := fRetNomCidade(dtsGenDoc.DataSet.FieldByName('CODCID').AsString,1);
      except on e:Exception do
        pMensagensErro(e.Message, '[TfrmReimpressaoDocsList.pValidaEndCliente]');
      end
    finally
      FreeAndNil(qryEnd);
    end;
  end;

var
  intContador : integer;
  recDadosImpVenda : TDadosImpressaoVenda;
  qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery();
  FillChar(recDadosImpVenda, SizeOf(recDadosImpVenda), #0);
  try
    recDadosImpVenda.strNumDoc := dtsGenDoc.DataSet.FieldByName('NUMDOC').AsString;
    recDadosImpVenda.strEspDoc := dtsGenDoc.DataSet.FieldByName('ESPDOC').AsString;
    recDadosImpVenda.strEmpDoc := dtsGenDoc.DataSet.FieldByName('CODEMP').AsString;
    recDadosImpVenda.strCodCli := dtsGenDoc.DataSet.FieldByName('CODCLI').AsString;
    recDadosImpVenda.strTip_FC := dtsGenDoc.DataSet.FieldByName('TIP_FC').AsString;
    recDadosImpVenda.strSerFsc := dtsGenDoc.DataSet.FieldByName('SERIE_').AsString;
    recDadosImpVenda.strCliNom := dtsGenDoc.DataSet.FieldByName('CLINOM').AsString;
    recDadosImpVenda.strMen001 := dtsGenDoc.DataSet.FieldByName('MEN001').AsString;
    recDadosImpVenda.strMen002 := dtsGenDoc.DataSet.FieldByName('MEN002').AsString;
    recDadosImpVenda.strMen003 := dtsGenDoc.DataSet.FieldByName('MEN003').AsString;
    recDadosImpVenda.strMen004 := dtsGenDoc.DataSet.FieldByName('MEN004').AsString;
    recDadosImpVenda.strConPag := dtsGenDoc.DataSet.FieldByName('CONPAG').AsString;
    recDadosImpVenda.strCliCgc := dtsGenDoc.DataSet.FieldByName('C_G_C_').AsString;
    recDadosImpVenda.strCliIes := dtsGenDoc.DataSet.FieldByName('I_E_S_').AsString;
    try
      pValidaEndCliente(recDadosImpVenda);
      qryTmp.SQL.Text := fRetSqlDupCadRec(recDadosImpVenda.strNumDoc,
                                          recDadosImpVenda.strEmpDoc,
                                          recDadosImpVenda.strEspDoc);
      qryTmp.Open;
      if not qryTmp.IsEmpty then
      begin
        qryTmp.First;
        for intContador := 0 to Pred(qryTmp.RecordCount) do
        begin
          recDadosImpVenda.arrDuplicatasCND[intContador].curValor := qryTmp.FieldByName('VALDUP').AsFloat;
          qryTmp.Next;
        end;
      end;
    except on e:Exception do
      pMensagensErro(e.Message, '[TfrmReimpressaoDocsList.pMostraDocumentosDevolvidos]');
    end;
    pImprimirDadosEntregaNFCe(recDadosImpVenda);
  finally
    FreeAndNil(qryTmp);
  end;
end;

end.

