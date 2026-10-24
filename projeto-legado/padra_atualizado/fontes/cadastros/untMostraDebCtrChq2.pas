unit untMostraDebCtrChq2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, StrUtils, DB, Mask, DBCtrls, DBEditFocus,
  Uni, AppEvnts, UniDataSetProvider, UniClientDataSet, DBMemoFocus, BitBtnLockedIncrem,
  frxClass, MemDS, DBAccess, Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, DateUtils, untInfCobrancaAgeRelHist, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untGravando,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxButtonEdit,
  cxGridCitel, cxHyperLinkEdit, untIDocumento,untTypesSistema,untFuncoesConsulta,
  untILiberacao, untLiberacaoFactory, cxLabel, untSelClienteFiltro,
  untTMostraDebCtrChq2;

Type
  TtpGatilho = (gatCfg, gatCtt);

type
  TfrmMostraDebCtrChq2 = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    pnlDebCtr: TPanel;
    pnlDebChq: TPanel;
    dbgCheques: TDBGridCitel;
    pnlTitChq: TPanel;
    pnlTitCtr: TPanel;
    dtsTemporaria: TDataSource;
    dtsTemporaria2: TDataSource;
    dtsTemporaria3: TDataSource;
    cdsTemporaria: TUniClientDataSet;
    cpvTemporaria: TUniDataSetProvider;
    cdsTemporaria2: TUniClientDataSet;
    cpvTemporaria2: TUniDataSetProvider;
    cdsTemporaria3: TUniClientDataSet;
    cpvTemporaria3: TUniDataSetProvider;
    cdsRelatorio: TUniClientDataSet;
    cpvRelatorio: TUniDataSetProvider;
    qryRelatorio: TUniQuery;
    Label4: TLabel;
    dbeNomEmi: TDBEditFocus;
    Label6: TLabel;
    edtTotTel: TEditFocus;
    Label8: TLabel;
    edtTotNao: TEditFocus;
    edtChqTot: TEditFocus;
    Label7: TLabel;
    cdsNaoTelecheque: TUniClientDataSet;
    cdsTelecheque: TUniClientDataSet;
    lbl2: TLabel;
    lbl3: TLabel;
    shp3: TShape;
    shp2: TShape;
    btnFechar: TBitBtnLocked;
    btnVisCtr: TBitBtnLocked;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    pnlRodapeCR: TPanel;
    lblDupOri: TLabel;
    lblJurRec: TLabel;
    lblCorDif: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    lblDupCor: TLabel;
    Label5: TLabel;
    edtDupOri: TEditFocus;
    edtJurRec: TEditFocus;
    edtCorDif: TEditFocus;
    edtTotVencido: TEditFocus;
    edtTotVencer: TEditFocus;
    dbeHist01: TDBMemoFocus;
    dbeRecebi: TDBEditFocus;
    btnMarcarTudo: TBitBtnLocked;
    btnDesmarcarTudo: TBitBtnLocked;
    edtDupCor: TEditFocus;
    btnVisChq: TBitBtnLocked;
    btnEnviarEmail: TBitBtnLocked;
    btnAgrupamentos: TBitBtnLocked;
    btnProdutos: TBitBtnLocked;
    btnObsDoc: TBitBtnLocked;
    btnRelatorio: TBitBtnLocked;
    edtTotVencidoOrig: TEditFocus;
    Label14: TLabel;
    btnAgeHis: TBitBtnLocked;
    dbgDuplicatas: TcxGridCitel;
    dbgDuplicatasDados: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    Label15: TLabel;
    dbeHistBai: TDBMemoFocus;
    flwBotoesRodape: TFlowPanel;
    Label16: TLabel;
    btnCfgRec: TBitBtnLocked;
    BtnImprimirBoleto: TBitBtnLocked;
    btnAlterarPortador: TBitBtnLocked;
    btnEnviarNF: TBitBtnLocked;
    PnlInfCob: TPanel;
    lblHist: TLabel;
    grdHistDups: TcxGridCitel;
    grdHistDupsTableView1: TcxGridDBTableViewCitel;
    grdHistDupsCob_DtaLan: TcxGridDBColumn;
    grdHistDupsDATA: TcxGridDBColumn;
    grdHistDupsAGEREL: TcxGridDBColumn;
    grdHistDupsTableCOB_CODOPE: TcxGridDBColumn;
    grdHistDupsLevel1: TcxGridLevel;
    mdbHisDup: TDBMemoFocus;
    grdHistDupsTableCOB_BAIXAD: TcxGridDBColumn;
    btnAcompEntrega: TBitBtnLocked;
    btnEnviarWhatsapp: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pSomaTotVencimento;
    procedure pMostraDebCheque;
    procedure pMostraDebCadRec;
    procedure CriarAggregates;
    procedure PreencherTotalizadores;
    procedure pCriaTemporaria;
    procedure pCalculaValorCorrigido;
    procedure btnVisChqClick(Sender: TObject);
    procedure btnVisCtrClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnAgrupamentosClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgChequesTitleClick(Column: TColumn);
    procedure dbgChequesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnObsDocClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnDesmarcarTudoClick(Sender: TObject);
    procedure btnMarcarTudoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAgeHisClick(Sender: TObject);
    procedure dbgDuplicatasDadosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasDadosColumnHeaderClick(
      Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure btnCfgRecClick(Sender: TObject);
    procedure BtnImprimirBoletoClick(Sender: TObject);
    procedure btnAlterarPortadorClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnEnviarNFClick(Sender: TObject);
    procedure grdHistDupsAGERELGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdHistDupsTableCOB_BAIXADGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnAcompEntregaClick(Sender: TObject);
    procedure dtsTemporaria2DataChange(Sender: TObject; Field: TField);
    procedure btnEnviarWhatsappClick(Sender: TObject);
  private
    { Private declarations }
    qryCdsTmp1,
    qryCdsTmp3: TUniQuery;

    qryConsultaBoleto : TUniQuery;

    cdsHistDups: TUniClientDataSet;
    dtsHistDups: TDataSource;

    strMensagemRel   : String;
    strNomeArquivo   : String;
    bChkContaCorrente: Boolean;
    bChkProduto      : Boolean;
    FExibirCredito   : Boolean;
    bChkCheque       : Boolean;
    bChkObservacao   : Boolean;
    bDocAgrup        : Boolean;
    bChkDtaVen       : Boolean;
    bChkBancoDoBoleto: Boolean;
    bChkNumPedFF     : Boolean;
    bChkJuros        : Boolean;
    blnkEndEre       : Boolean;
    fltTotVen        : Double;
    fltTotVenOrig    : Double;
    fltTotAve        : Double;
    strDtaVen        : String;

    FOrdemRelatorio: Integer;

    strLista         : String;
    listaImpressa, listaNaoImpressa : TStringList;
    strListaJaImpresso : String;
    arrDuplicatas        : Array of Array of String;
    matrizDadosDuplicata : Array of String;

    blnDescFinanSomenteAteVenc : boolean;


    strEspDoc : String;
    strCodigoCliente : String;

    FMostraDebCtrChq2Obj: TMostraDebCtrChq2;

    procedure pGerarHtmlContaCorrente;
    procedure pEnviarRelatorioPorWhatsApp(AWppDestinatario: String; AArquivoEnvioWPP: String);
    procedure pEnviarWppContaCorrente;
    procedure pGeraEmail(blnAbrirEmVideo: Boolean; AGerarArquivoWpp: Boolean = False);
    procedure pAtualizaDados(DataSet: TDataSet);
    function fRetDupSel: String;
    function fRetAutoincremDuplicatas: String;

    function fGetSqlValDup(strTabela: String = ''): String;
    function fGetSqlValOri(blnSomAgr: Boolean = False): String;
    function fGetSqlVenctoOriginal_QtProrrogados : String;
    function fGetSqlTaxaJuros: String;
    function fGetSqlTolerancia: String;
    function fGetSqlValorJuros(strValDup: String): String;
    function fGetSqlDtaVen(blnAjuVen: Boolean): String;

    procedure pMarcarDesmarcarTudo(blnMarcar: Boolean);
    procedure pMarcarDuplicata;

    procedure pAjustaDataCheque;
    function fCriaClientDataSet: TUniClientDataSet;
    procedure pConsultaNotaFiscal;
    procedure pConsultaBoleto;
    procedure PropertiesButtonNFClick(Sender: TObject; AButtonIndex: Integer);
    procedure PropertiesButtonBoletoClick(Sender: TObject; AButtonIndex: Integer);
    procedure PropertiesButtonAnexosClick(Sender: TObject; AButtonIndex: Integer);

    procedure pBotaoConfigurar;
    procedure pGravarConfiguracoesDebCtrChq2;
    procedure pCarregarColunasPDFNFBoleto;
    procedure pChamaAnexos;
    function fAlteraDuplicatas: Boolean;
    function fGravaDuplicatas(strDescon, strCodPor, strCodEve,
      strCodCta: String): Boolean;
    function fGravaTabela(strDescon, strCodPor, strCodEve,
      strCodCta: String): Boolean;
    function fGetListaCaixa: String;
    function fAutorizaGravarDup(strLista, strCodPor: String): Boolean;
    function fBoletoJaImpresso(chaveBoleto: String): Boolean;
    function fPortadorDiferente(chaveDuplicata, strCodPor: String): Boolean;
    function fSenhaPortador: Boolean;
    function fVerificaQtdeSelecionados: Integer;
    function fRetEmailCliente(strCodCli : String) : String;
    procedure AdicionaListaSelecao(strAutoin: String);
    procedure RemoveDaListaSelecao(strAutoin: String);
    procedure pAtualizaTabTempCamposAlterados(strLista, strCodPor, strCodEve : String);
    procedure pTrazHistoricoDuplicata(strAutoIn: String);
    procedure CriaTempotariaHistoricoCobranca;
    function  fVerificaDireitoAcesso(ADirAce: String): Boolean;
    Procedure pPosicionaDuplicata;
    procedure pEnviaWhatsapp;
    procedure pEnviaEmail;
    procedure pMostraVideo;
    Function  fGravaGatilhoNotFic(Const strAutInc, strGatilho, strTipo, strCodigoCli : String): Boolean;
    Function  fRetAutoIncremCadFis(strNumDoc, strEspDoc, strCodEmp, strCodCli : String):String;

    function fTemEmailAtivo: Boolean;
    function fTemModeloAtivoWpp(tpGatilho: TtpGatilho = gatCfg): Boolean;
    function fTemRegistrosMarcados: Boolean;
    procedure IniciandoTemporarias;
    function fTemPermissaoAcessarDocumento: Boolean;
  public
    { Public declarations }

    strCodCli : String;
    strCodPor : String;
    strDtaIni : String;
    strDtaFin : String;
    strRedLoj : String;
    strCodEmp : String;
    arrEmp    : TConsultasArray;
    arrPort   : TConsultasArray;
    blnSelDocumentosDeb: Boolean; {se veio pelo Resumo de Caixa}
    blnQryVaziaCadRec: Boolean;
    blnQryVaziaCadChq: Boolean;
    blnVencidos: Boolean;
    blnAjuDta: Boolean;
    blnDtaVen: Boolean;
    objDocumento: IDocumento;

    stlListSelecao : TStringList;

    blnSoConsulta  : Boolean;

    function fInicializa : Boolean;
    class procedure pMostraContaCorrente(strCodCli: String = '';strTipFil: String = '';
                                         blnSelDocumentos: Boolean = FALSE; blnVencidos: Boolean = FALSE;
                               blnAjuDta: Boolean = False;strFiltro: String = '';
                               objDocumento: IDocumento = nil;blnFiltraEmp : Boolean = False;
                               arrPort: TConsultasArray = nil; dtInicial : Tdate = 0; dtfinal :Tdate = 0; blnInfCob : Boolean = False);
  published
    property Constraints;
  end;

implementation

uses untFuncoesSimples, untFuncoesRel2, untQckHTMLCliente, TypesRel,
  untRelCtrDebitosCliente, untDigEmailCtaCorrente, untDigWppCtaCorrente, untObservacao,
  untFuncoesAuxiliares, System.UITypes, untRelFatVendasClienteF9, untModuloSPR,
  untTEnvioEmail, untConfigMostraDebCtrChq2, untCfgColDebCtr, untcxGridDBColumnHelper,
  untCtrDescontadaConf,  untLogCtr, untfuncoes, untAtualizaOcorrenciasCRM, untTypesCRM,
  untMsgLiberacao, untQualiZapEnqueueMessageToSend, untQualiZapUploadFile, untRestApi,
  untFuncoesGenerica;


{$R *.dfm}

function TfrmMostraDebCtrChq2.fVerificaDireitoAcesso(ADirAce: String): Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    objLiberacao : ILiberacao;
    LDescricaoDireito : String;
begin

  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;

  If ADirAce.Equals('frmImpBoletosIndiv') Then LDescricaoDireito := 'IMPRESSÃO DE BOLETOS - [CADASTRO DE CLIENTE > F6 - CONTA CORRENTE]'
  Else LDescricaoDireito := 'REIMPRESSÃO DE DOCUMENTOS - [CADASTRO DE CLIENTE > F6 - CONTA CORRENTE]';


   objLiberacao.objMsgLibera.pAddTexto(LDescricaoDireito, alCentro, teAmbos, '', 89) ;

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DOCUMENTO'  , 17 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'    , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CADASTRO', 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENCTO'  , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VALOR'      , 19 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DOCUMENTO'  , cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString +
                                     cdsTemporaria2.FieldByName('CTR_PARCEL').AsString + '-' +
                                     cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString + '-' +
                                     cdsTemporaria2.FieldByName('CTR_CODEMP').AsString                                , 17 , alEsquerda );
  objLinha.pAddColuna('CLIENTE'    , cdsTemporaria2.FieldByName('CTR_CODCLI').AsString + '-' + fRetNomCliente(cdsTemporaria2.FieldByName('CTR_CODCLI').AsString) , 21 , alEsquerda );
  objLinha.pAddColuna('DT.CADASTRO', FormatDateTime('dd/mm/yyyy', cdsTemporaria2.FieldByName('CTR_DTACAD').AsDateTime)                     , 11 , alCentro   );
  objLinha.pAddColuna('DT.VENCTO'  , FormatDateTime('dd/mm/yyyy', cdsTemporaria2.FieldByName('CTR_DTAVEN').AsDateTime)                     , 10 , alCentro   );
  objLinha.pAddColuna('VALOR'      , FloatToStrF(cdsTemporaria2.FieldByName('CTR_VALDUP').AsFloat, ffFixed, 11, 2)                         , 19 , alDireita  );
  objTabela.lstLinhas.Add(objLinha);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlTotal;
  objLinha.pAddColuna(''      , 'TOTAL'                                , 65 , alDireita, teAutcom );
  objLinha.pAddColuna('VALOR' , FloatToStrF(cdsTemporaria2.FieldByName('CTR_VALDUP').AsFloat, ffFixed, 11, 2) , 19 , alDireita);
  objTabela.lstLinhas.Add(objLinha);


  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := ADirAce;
  objLiberacao.strMsgSen := LDescricaoDireito;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString,
                    cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString,
                    cdsTemporaria2.FieldByName('CTR_CODEMP').AsString);

  Result := objLiberacao.fLibera;
end;

function TfrmMostraDebCtrChq2.fTemEmailAtivo: Boolean;
 Var
     strSQL,
     FCodigo,
     FCodGru : String;

     qryGeneric: TUniQuery;
begin

  Result := False;

  FCodigo := '001';
  FCodGru := '022';

  Try
    qryGeneric := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT       ';
    strSQL := strSQL + '  EMA_CODIGO,';
    strSQL := strSQL + '  EMA_MDROBO,';
    strSQL := strSQL + '  MOD_ENVDOC ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  EMASAI     ';
    strSQL := strSQL + '  INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  EMA_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  EMA_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_STATUS = "A"     AND ';
    strSQL := strSQL + '  EMA_ENTSAI = "S"         ';

//    If fCfgSis('EMASAI', VarString) = 'Desativado' Then
//    Begin
//      strSQL := strSQL + ' AND FALSE ';
//    End;

    qryGeneric.Close;
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add(strSQL);

    If qryGeneric.IsEmpty Then
    Begin
      qryGeneric.Close;
      qryGeneric.ParamByName('CODIGO').AsString := FCodigo;
      qryGeneric.ParamByName('CODGRU').AsString := FCodGru;
      qryGeneric.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGeneric.Open;
    End;

    Result := (Not qryGeneric.IsEmpty);

  Except
    On E: Exception Do
       pMensagensErro(e.Message, '[TfrmMostraDebCtrChq2.fTemEmailAtivo]');
  End;

end;

function TfrmMostraDebCtrChq2.fTemModeloAtivoWpp(tpGatilho: TtpGatilho = gatCfg): Boolean;
Var
   strSQL,
   FCodigo,
   FCodGru : String;
   qryGeneric: TUniQuery;
begin

  FCodigo := '001';
  FCodGru := '022';

  Result := False;

  Try
    qryGeneric := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT       ';
    strSQL := strSQL + '  WPP_CODIGO,';
    strSQL := strSQL + '  WPP_MDROBO,';
    strSQL := strSQL + '  MOD_ENVDOC ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  WPPSAI     ';
    strSQL := strSQL + '  INNER JOIN MODWPP ON WPPSAI.AUTOINCREM = MODWPP.MOD_SEQGER ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  WPP_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  WPP_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  WPP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  WPP_STATUS = "A"         ';

    strSQL := strSQL + IIF(tpGatilho = gatCtt,
                           ' AND WPP_SEQCTT IN ( SELECT '+
                           '                       AUTOINCREM '+
                           '                     FROM '+
                           '                       CLICTT '+
                           '                     WHERE '+
                           '                       CLI_CODCLI = :CODCLI )',
                           ' AND WPP_SEQCTT IS NULL ');

    qryGeneric.Close;
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add(strSQL);

    qryGeneric.Close;

    if tpGatilho = gatCtt then
       qryGeneric.ParamByName('CODCLI').AsString := strCodigoCliente;

    qryGeneric.ParamByName('CODIGO').AsString := FCodigo;
    qryGeneric.ParamByName('CODGRU').AsString := FCodGru;
    qryGeneric.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGeneric.Open;

    Result := (Not qryGeneric.IsEmpty);

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmMostraDebCtrChq2.fTemModeloAtivoWpp]');
  End;
end;

function TfrmMostraDebCtrChq2.fTemPermissaoAcessarDocumento: Boolean;
begin
  Result := True;

  if (cdsTemporaria2.FieldByName('CTR_CODVEN').AsString = strLoginUsuarioLogado) then
    Exit;

  if (not fVerificaAcessoSistema('RIMPDC')) then
  begin
    fMensagem('ATENÇÃO!', 'Você não tem permissão para acessar arquivos deste documento.' + #13#10 +
                          'Entre em contato com a Gerência.' + #13#10 + #13#10 +
                          'Direito de Acesso: "RIMPDC - Reimpressão de Documentos (Geral)"', ['&Ok']);
    Exit(False);
  end;
end;

Function TfrmMostraDebCtrChq2.fRetAutoIncremCadFis(strNumDoc, strEspDoc, strCodEmp, strCodCli : String): String;
var
  qryAutNot: TUniQuery;
begin
  qryAutNot := fCriaQuery;

  Result := '';

  try
    qryAutNot.Close;
    qryAutNot.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM, '+
    '   FIS_NUMDOC, '+
    '   FIS_ESPDOC, '+
    '   FIS_CODEMP, '+
    '   FIS_FORCLI, '+
    '   FIS_ACESSO, '+
    '   FIS_SERIE_  '+
    ' FROM '+
    '   CADFIS '+
    ' WHERE '+
    '   FIS_NUMDOC = :NUMDOC AND '+
    '   FIS_ESPDOC = :ESPDOC AND '+
    '   FIS_CODEMP = :CODEMP AND '+
    '   FIS_FORCLI = :FORCLI AND '+
//    '   AUTOINCREM = :SEQGER AND '+
    '   FIS_TIP_FC = "C" ';
//    ' AND IFNULL(FIS_ACESSO, "") <> "" ';

    qryAutNot.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAutNot.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAutNot.ParamByName('CODEMP').AsString := strCodEmp;
    qryAutNot.ParamByName('FORCLI').AsString := strCodCli;

    qryAutNot.Open;

    if Not qryAutNot.IsEmpty then
       Result := qryAutNot.FieldByName('AUTOINCREM').AsString;

  finally
    FreeAndNil(qryAutNot);
  end;

End;

Function TfrmMostraDebCtrChq2.fGravaGatilhoNotFic(Const strAutInc, strGatilho, strTipo, strCodigoCli : String) : Boolean;  //strTipo ='E'-EMAIL; 'W'-WHATS APP;
var
  strNotEma,
  strNotSms,
  strNotWpp: String;

  strCelular,
  strAutIncCtt: String;

  strFilaEnv: String;

  blnEnvioCancelado: Boolean;

  intCount: Integer;
  arrCelular: TArray<String>;
  arrAutIncCtt: TArray<String>;
  arrFila: TArray<String>;

  qryNotFic: TUniQuery;
begin
  strNotEma := 'N';
  strNotSms := 'N';
  strNotWpp := 'N';

  blnEnvioCancelado := False;

  Result := False;

  try
    try

      If StrTipo = 'E' Then
      Begin
         If fTemEmailAtivo Then
            strNotEma := 'S';
      End;

      If StrTipo = 'W' Then
      Begin

         //strCodCli := strCodigoCliente;

         if (fCfgSis('UTIWPP', varBoolean)) and (fTemModeloAtivoWpp) then
         begin

           blnEnvioCancelado := not fRetFilaEContatoEnvio(strAutIncCtt,
                                                          strCelular,
                                                          strFilaEnv,
                                                          strCodCli,
                                                          fRetNomCliente(strCodCli),
                                                          '001',
                                                          '022',
                                                          True);

           If Not blnEnvioCancelado Then
              strNotWpp := 'S';

         end;

      End;

      if fEmptyStr(strCelular) then
        strCelular := Chr(32);

      if fEmptyStr(strAutIncCtt) then
        strAutIncCtt := Chr(32);

      if fEmptyStr(strFilaEnv) then
        strFilaEnv := Chr(32);

      arrCelular := strCelular.Split(['_']);
      arrAutIncCtt := strAutIncCtt.Split(['_']);
      arrFila := strFilaEnv.Split(['_']);
      for intCount := 0 to High(arrCelular) do
      begin
        if (strNotEma = 'S') or
           (strNotSms = 'S') or
           (strNotWpp = 'S') then
        begin
          qryNotFic := fCriaQuery;
          try
            qryNotFic.Close;
            qryNotFic.SQL.Text :=
            ' INSERT INTO '+
            ' NOTFIC '+
            '  (AUTOINCREM, '+
            '   NOT_SEQGER, '+
            '   NOT_NOTENV, '+
            '   NOT_DTAHOR, '+
            '   NOT_GATILH, '+
            '   NOT_ENVEMA, '+
            '   NOT_ENVSMS, '+
            '   NOT_ENVWPP, '+
            '   NOT_CODEMP, '+
            '   NOT_CELULA, '+
            '   NOT_IDFILA, '+
            '   NOT_SEQCTT) '+
            ' VALUES '+
            '  (:AUTINC, '+
            '   :SEQGER, '+
            '   :NOTENV, '+
            '   :DTAHOR, '+
            '   :GATILH, '+
            '   :ENVEMA, '+
            '   :ENVSMS, '+
            '   :ENVWPP, '+
            '   :CODEMP, '+
            '   :CELULA, '+
            '   :IDFILA, '+
            '   :SEQCTT) ';

            qryNotFic.ParamByName('AUTINC').AsString := fRetAutoIncrem('NOTFIC', VS_StrCodEmp);
            qryNotFic.ParamByName('SEQGER').AsString := strAutInc;
            qryNotFic.ParamByName('NOTENV').AsString := 'N';
            qryNotFic.ParamByName('DTAHOR').AsDateTime := fNow;
            qryNotFic.ParamByName('GATILH').AsString := strGatilho;
            qryNotFic.ParamByName('ENVEMA').AsString := strNotEma;
            qryNotFic.ParamByName('ENVSMS').AsString := 'N';
            qryNotFic.ParamByName('ENVWPP').AsString := IIF(blnEnvioCancelado, 'N', strNotWpp);
            qryNotFic.ParamByName('CODEMP').AsString := VS_strCodEmp;
            qryNotFic.ParamByName('CELULA').AsString := arrCelular[intCount].Trim;
            qryNotFic.ParamByName('IDFILA').AsString := arrFila[intCount].Trim;
            qryNotFic.ParamByName('SEQCTT').AsString := IIF(arrAutIncCtt[intCount] = 'CLIENTE', EmptyStr, arrAutIncCtt[intCount]);
            qryNotFic.ExecSQl;

            Result := True;
          finally
            FreeAndNil(qryNotFic);
          end;
        end
        else
          Break;

        strNotEma := 'N';
        strNotSms := 'N';
      end;
    except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fGravaGatilhoAutorizacaoDocFiscal]');
      end;
    end;
  finally
  end;
end;

Function TfrmMostraDebCtrChq2.fRetEmailCliente(strCodCli : String) : String;
  Var
    strSQL: String;
    qryCli : TUniQuery;
begin

  result := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_EMAIL_ AS EMAIL ';
  strSQL := strSQL + 'FROM         ';
  strSQL := strSQL + '  CADCLI CLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

  Try

    qryCli := fCriaQuery(Self);

    If cdsTemporaria2.IsEmpty Then
       Exit;

    qryCli.Close;
    qryCli.SQL.Clear;
    qryCli.SQL.Add(strSQL);
    qryCli.ParamByName('CODCLI').AsString := strCodCli;
    qryCli.Open;

    If Not qryCli.IsEmpty Then
       result := qryCli.FieldByName('EMAIL').AsString;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmMostraDebCtrChq2.fRetEmailCliente]');
    End;
  End;

End;


{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
Function TfrmMostraDebCtrChq2.fAlteraDuplicatas: Boolean;
  Var
    strEmpSemAcesso: String;
Begin
  Try
    Result := False;
    pCriarFormularios(TfrmCtrDescontadaConf,frmCtrDescontadaConf);
    If Assigned(frmCtrDescontadaConf) Then
    Begin
      With frmCtrDescontadaConf Do
      Begin
        Result := (ShowModal = mrOk);

        If Result Then
        Begin
          If Not fEmptyStr(edtCodPor.Text) Then
          Begin
            {*REQ*145940**********RP*}
            If Not fEmpresasTemAcessoPortador(edtCodPor.Text,
                                              dtsTemporaria2.DataSet,
                                              'CTR_CODEMP',
                                              strEmpSemAcesso,
                                              'AUTOINCREM_CADREC IN('+ fCommaText(stlListSelecao) +')') Then
            Begin
              fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
              exit(False);
            End;
          End;

          Result := fGravaDuplicatas(edtDescon.Text, edtCodPor.Text, fraCentroCusto.edtCodEve.Text, fraPlanoDeContas.MskCodCta.Text);
        End;
      End;
    End;
  Finally
    FreeAndNil(frmCtrDescontadaConf);
  End;
End;

Procedure TfrmMostraDebCtrChq2.AdicionaListaSelecao( strAutoin : String );
Begin
  stlListSelecao.add( '''' + strAutoin + '''' );
End;

Procedure TfrmMostraDebCtrChq2.RemoveDaListaSelecao( strAutoin : String );
 Var
     intIndex : Integer;
Begin

    intIndex := stlListSelecao.IndexOf( '''' + strAutoin + '''' );
    If intIndex > -1 then
       stlListSelecao.Delete(intIndex);

End;

Function TfrmMostraDebCtrChq2.fVerificaQtdeSelecionados : Integer;
 //Var
 //   cdsVerDup : TUniClientDataSet;
Begin

   Result := stlListSelecao.Count;

  //Result := 0;

{  Try
    cdsVerDup := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsVerDup, cdsTemporaria2);

    cdsVerDup.Filtered := False;
    cdsVerDup.Filter := ' CTR_MARDES = ' + QuotedStr('M');
    cdsVerDup.Filtered := True;

    Result := cdsVerDup.Recordcount;
    FreeAndnil(cdsVerDup);
  Except
    FreeAndnil(cdsVerDup);
  End; }

End;

procedure TfrmMostraDebCtrChq2.grdHistDupsAGERELGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If (AText = 'R') Then
      AText := 'Relig.'
  Else
  If (AText = 'A') Then
    AText := 'Agend.';
end;

procedure TfrmMostraDebCtrChq2.grdHistDupsTableCOB_BAIXADGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If (AText = 'S') Then
      AText := 'Sim'
  Else
  If (AText = 'N') Then
    AText := 'Não';
end;

procedure TfrmMostraDebCtrChq2.IniciandoTemporarias;
begin
  pCriaTemporaria;
  pMostraDebCadRec;
  pMostraDebCheque;
  pSomaTotVencimento;
end;

Procedure TfrmMostraDebCtrChq2.pTrazHistoricoDuplicata( strAutoIn : String );
begin

  If cdsTemporaria2.IsEmpty Then
    Exit;

  Try

    cdsHistDups.Filtered := False;
    cdsHistDups.Filter := ' DUP_SEQDUP = ' + QuotedStr(strAutoIn);
    cdsHistDups.Filtered := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmMostraDebCtrChq2.pTrazHistoricoDuplicata]');
    End;
  End;

End;

Procedure TfrmMostraDebCtrChq2.pAtualizaTabTempCamposAlterados(strLista, strCodPor, strCodEve : String);
  Var
     iRec : Integer;
Begin

    iRec := cdsTemporaria2.recno;
    cdsTemporaria2.disableControls;

    If (Not fEmptyStr(strCodPor)) Or (Not fEmptyStr(strCodPor)) Then
    Begin

      If (cdsTemporaria2.Locate('AUTOINCREM_CADREC', strLista, [])) Then
      Begin

         cdsTemporaria2.Edit;

         If Not fEmptyStr(strCodPor) Then
            cdsTemporaria2.FieldByName('NOMPOR').AsString := strCodPor + ' - ' + fRetNomPortador(strCodPor);

         If Not fEmptyStr(strCodEve) Then
            cdsTemporaria2.FieldByName('EVENTO').AsString := strCodEve + ' - ' + fRetNomEvento(strCodEve);

         cdsTemporaria2.Post;

      End;

    End;

    cdsTemporaria2.recno := iRec;
    cdsTemporaria2.enableControls;

End;

Function TfrmMostraDebCtrChq2.fGravaDuplicatas(strDescon, strCodPor, strCodEve, strCodCta: String): Boolean;
Var
    qryTabela: TUniQuery;
Begin

  Application.ProcessMessages;

  Try
    fStartTransaction;

    Result := fGravaTabela(strDescon, strCodPor, strCodEve, strCodCta);

    If Result Then
    Begin

      pAtualizaTabTempCamposAlterados( fRetiraQuotedLista(strLista), strCodPor, strCodEve );

      qryTabela := fCriaQuery;
      qryTabela.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM IN (' + strLista + ')';
      qryTabela.Open;

      qryTabela.First;
      While Not qryTabela.Eof Do
      Begin
        untLogCtr.GravaLogCtr(qryTabela.FieldByName('AUTOINCREM').AsString, 'ALTERAÇÃO', Self.Name);

       If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
        Begin
          TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                                   qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                                   qryTabela.FieldByName('CTR_CODEMP').AsString,
                                                   qryTabela.FieldByName('CTR_CODCLI').AsString,
                                                   qryTabela.FieldByName('CTR_PARCEL').AsString,
                                                   strLoginUsuarioLogado,
                                                   fRetCgcCpf(qryTabela.FieldByName('CTR_CODCLI').AsString),
                                                   afcAlteraPorDesEvento);
        End;
        qryTabela.Next;
      End;
      qryTabela.Close;
      FreeAndNil(qryTabela);

      fCommit;
    End
    Else
      fRollBack;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := FALSE;
      pMensagensErro('Erro ao atualizar duplicatas. ' + E.Message , '[fGravaDuplicatas]');
    End;

  End;


End;

Function TfrmMostraDebCtrChq2.fGravaTabela(strDescon, strCodPor, strCodEve, strCodCta: String): Boolean;
  Var
    qryCadRec: TUniQuery;

Begin
  Try
    Result   := False;

    listaNaoImpressa.Clear;
    listaImpressa.Clear;

    strLista := fGetListaCaixa;

    //  inicio a busca de autorização para gravação dos registros.
    //  passo a lista com as duplicatas marcadas para poder consultar uma a uma
    //  se o portador em especifico é diferente e com elas construir uma matriz
    //  para informar a tela de senha.

    if (listaImpressa.Count > 0) and (not fAutorizaGravarDup(strListaJaImpresso,strCodPor)) then
      listaImpressa.Clear;

    if listaImpressa.Count > 0 then
      strLista := listaImpressa.CommaText;
    if (listaImpressa.Count > 0) and (listaNaoImpressa.Count > 0) then
      strLista := strLista + ',' + listaNaoImpressa.CommaText;
    if (listaImpressa.Count = 0) and (listaNaoImpressa.Count > 0) then
      strLista := listaNaoImpressa.CommaText;
    if (listaImpressa.Count = 0) and (listaNaoImpressa.Count = 0) then
      strLista := '';

    If Not fEmptyStr(strLista) Then
    Begin
      qryCadRec := fCriaQuery;
      qryCadRec.BeforePost := TGravaAlteracaoDePortador.SalvarBeforePost;

      With qryCadRec, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT ');
        Add('  AUTOINCREM, CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC,');
        Add('  CTR_CODEMP, CTR_CODCLI, CTR_SEQBAI, CTR_DESCON,');
        Add('  CTR_CODPOR, CTR_CODEVE, CTR_CODCTA ');
        Add('FROM CADREC');
        Add('WHERE AUTOINCREM IN (' + strLista + ')');
        Open;

        qryCadRec.First;
        while not qryCadRec.Eof do
        begin
          qryCadRec.Edit;

          If Not fEmptyStr(strDescon) Then
            FieldByName('CTR_DESCON').AsString := strDescon;

          If Not fEmptyStr(strCodPor) Then
            FieldByName('CTR_CODPOR').AsString := strCodPor;

          If Not fEmptyStr(strCodEve) Then
            FieldByName('CTR_CODEVE').AsString := strCodEve;

          If Not fEmptyStr(strCodCta) Then
            FieldByName('CTR_CODCTA').AsString := strCodCta;

          qryCadRec.Post;
          qryCadRec.Next;
        end;
      End;
      FreeAndNil(qryCadRec);
      Result := True;
    End;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro('Erro ao atualizar duplicatas. ' + E.Message , '[fGravaTabela]');
    End;

  End;

End;

Function TfrmMostraDebCtrChq2.fGetListaCaixa: String;
  Var
    intIndice: Integer;
    sltLista : TStringList;
    strAutInc: String;

Begin
  sltLista := TStringList.Create;
  sltLista.Clear;

  For intIndice := 0 To stlListSelecao.Count - 1 Do
  Begin
    strAutInc := Copy(stlListSelecao[intIndice],2,21);

    sltLista.Add(QuotedStr(LeftStr(strAutInc,20)));

    if fBoletoJaImpresso(Copy(stlListSelecao[intIndice],2,21)) then
      listaImpressa.Add(QuotedStr(LeftStr(strAutInc,20)))
    else
      listaNaoImpressa.Add(QuotedStr(LeftStr(strAutInc,20)))

  End;

  strListaJaImpresso  := listaImpressa.CommaText;

  Result := sltLista.CommaText;
End;

function TfrmMostraDebCtrChq2.fAutorizaGravarDup(strLista, strCodPor: String): Boolean;
Var
  strListDup:TStringList;
  i,j : integer;
  temPortadorDiferente:Boolean;
begin

  temPortadorDiferente := False;

  if fEmptyStr(strCodPor) then
  begin
    result := True;
    Exit;
  end;

  strListDup           := TStringList.Create;

  // explodo a lista das duplicatas dentro de uma matriz para buscar uma a uma
  extractStrings([','],[' '], PChar(strLista), strListDup);

  for i:=0 to strListDup.Count -1 do
    // função para consultar específicamente o portador dentro de um select
    // caso no select seja retornado valor é porque já nele o parametro de consulta
    // strCodPor deve ser diferente do que está registrado em banco
    // caso retorne verdadeiro, já retorna uma matriz global da unit com os dados daquele
    // registro para inserção em uma matriz final que deverá ser informada a tela de senha

    if fPortadorDiferente(strListDup[i], strCodPor) then
    begin
      temPortadorDiferente := True;
      SetLength(arrDuplicatas,length(arrDuplicatas)+1);
      SetLength(arrDuplicatas[length(arrDuplicatas)-1],10);

      for j:=0 to 9 do
        arrDuplicatas[length(arrDuplicatas)-1,j] := matrizDadosDuplicata[j];

    end;

  if length(arrDuplicatas) > 0 then
  begin
    // inicio a manipulação da tela para solicitação da senha e poder continuar
    If Not fSenhaPortador Then
     temPortadorDiferente := False;

  end;

  Result := temPortadorDiferente;

end;

function TfrmMostraDebCtrChq2.fBoletoJaImpresso(chaveBoleto: String): Boolean;
begin


  qryConsultaBoleto.SQL.Clear;
  qryConsultaBoleto.SQL.Add(' SELECT CTR_NOSNUM FROM CADREC WHERE AUTOINCREM = :CHAVE ');
  qryConsultaBoleto.ParamByName('CHAVE').AsString := StringReplace(chaveBoleto,'''','',[rfreplaceAll]);
  qryConsultaBoleto.Open;

  Result := not fEmptyStr(qryConsultaBoleto.FieldByName('CTR_NOSNUM').AsString);

end;

function TfrmMostraDebCtrChq2.fPortadorDiferente(chaveDuplicata, strCodPor: String): Boolean;
Var
  strSQL: String;
  i:integer;
  qryBuscaDadosDup : TUniquery;
Begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   R.AUTOINCREM, ';
  strSQL := strSQL + '   CONCAT(R.CTR_NUMDUP,''-'',R.CTR_PARCEL,''-'',R.CTR_ESPDOC) AS CTR_DUPLICATA, ';
  strSQL := strSQL + '   CONCAT(R.CTR_CODCLI,''-'',CLI_NOMCLI) AS CTR_NOMCLI, ';
  strSQL := strSQL + '   R.CTR_DTACAD, ';
  strSQL := strSQL + '   R.CTR_DTAVEN, ';
  strSQL := strSQL + '   R.CTR_VALDUP, ';
  strSQL := strSQL + '   POR_CODPOR, CONCAT(POR_CODPOR,"-",POR_NOMPOR) AS CTR_NOMPOR, CTR_CODEMP ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC R';
  strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ';

  strSQL := strSQL + ' WHERE ';

  if fEmptyStr(chaveDuplicata) then
  begin
    fMensagem('ATENÇÃO!', 'Chave de duplicata necessário!', ['&O k']);
    Result := False;
    Exit;
  end else
    strSQL := strSQL + '  R.AUTOINCREM = :AUTOINCREM AND POR_CODPOR <> :CODPOR  ';

//  If Not fEmptyStr(edtCodEmp.Text) Then
//    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
//  Else
    strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  qryBuscaDadosDup := fCriaQuery;

  qryBuscaDadosDup.SQL.Clear;
  qryBuscaDadosDup.SQL.Add(strSQL);
  qryBuscaDadosDup.ParamByName('AUTOINCREM').AsString := StringReplace(chaveDuplicata,'''','',[rfreplaceAll]);
  qryBuscaDadosDup.ParamByName('CODPOR').AsString     := strCodPor;
  //If Not fEmptyStr(edtCodEmp.Text) Then
  //  qryBuscaDadosDup.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  qryBuscaDadosDup.Open;

  SetLength(matrizDadosDuplicata,10);
  for i:= 0 to 9 do
    matrizDadosDuplicata[i] := '';

  if not qryBuscaDadosDup.IsEmpty then
  begin
    for i:=0 to qryBuscaDadosDup.FieldCount -1 do
      matrizDadosDuplicata[i] := qryBuscaDadosDup.Fields[i].AsString;
    matrizDadosDuplicata[8] := strCodPor + '-' + fRetNomPortador(strCodPor);
  end;

  Result := matrizDadosDuplicata[1] <> '';

End;

{********************************************************}
{* SENHA PARA ALTERAÇÃO DE PORTADOR NAS DUPLICATAS      *}
{*****************************************************FA*}
function TfrmMostraDebCtrChq2.fSenhaPortador: Boolean;
  Var
    i          : integer;
    duplicata, especie: String;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;

    objLiberacao : ILiberacao;
begin

  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('>> ALTERAÇÃO DE PORTADORES APÓS EMISSÃO DE BOLETOS <<');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(121);
  objLiberacao.objMsgLibera.pAddTexto('ACESSO A ALTERAÇÃO DE PORTADORES APÓS EMISSÃO DE BOLETOS', alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('NOVO PORTADOR', Copy(arrDuplicatas[0,8],1,80), 0, alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddQuebra;

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'         , 19 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'           , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'          , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'         , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DUPLICATA'      , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'PORTADOR ORIGINAL' , 20 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  for i:= 0 to length(arrDuplicatas)-1 do
  begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'         , arrDuplicatas[i,1]                       , 19 , alEsquerda );
    objLinha.pAddColuna('CLIENTE'           , arrDuplicatas[i,2]                                        , 33 , alEsquerda );
    objLinha.pAddColuna('DT. CAD.'          , FormatDateTime('dd/mm/yyyy', StrToDate(arrDuplicatas[i,3])) , 12 , alCentro   );
    objLinha.pAddColuna('DT. VENC.'         , FormatDateTime('dd/mm/yyyy', StrToDate(arrDuplicatas[i,4])) , 12 , alCentro   );
    objLinha.pAddColuna('VR.DUPLICATA'      , FormatFloat('#,###,##0.00', Abs(fStrToFloat(arrDuplicatas[i,5])))     , 12 , alDireita  );
    objLinha.pAddColuna('PORTADOR ORIGINAL' , Copy(arrDuplicatas[i,7],1,21)                                                                  , 20 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);
  end;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddSeparador(121);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('>> EMPRESA  SOLICITANTE', VS_strCodEmp);
  objLiberacao.objMsgLibera.pAddTextoCaption('>> OPERADOR SOLICITANTE', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

  objLiberacao.strDirAce := 'ALTPORBOL';
  objLiberacao.strMsgSen := 'Senha para alteração de portador da duplicata';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  if Result then
    for i:= 0 to length(arrDuplicatas)-1 do
    begin
      Duplicata := Copy(arrDuplicatas[i,1],1,12);
      especie   := Copy(arrDuplicatas[i,1],length(arrDuplicatas[i,1])-1,2);
      pGeraLogLiberacao(duplicata,
                        especie,
                        arrDuplicatas[i,9]);
    end;

end;


function TfrmMostraDebCtrChq2.fInicializa : Boolean;
begin

  cdsTemporaria2.AfterScroll := Nil;
  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');
  TFrmGravando.fExecutarModal(IniciandoTemporarias, 'Aguarde... Carregando Títulos!', '');

  Result := Not ((blnQryVaziaCadRec) And (blnQryVaziaCadChq));
  pBotaoConfigurar;
  cdsTemporaria2.AfterScroll := pAtualizaDados;
end;

{***************************************}
{* CARREGA OS DADOS DO CHEQUE          *}
{************************************AF*}
procedure TfrmMostraDebCtrChq2.pMostraDebCheque;
var
  strSQL: String;
  intContador: Integer;
  blnConsChqRepassado: Boolean;

  LVariaveisFiltro: TVariaveisMostraDebCtrChq2;
begin
  blnConsChqRepassado := fCfgSis('CHQNVT', varBoolean);

  cdsTemporaria3.Close;
  cdsTemporaria3.SetProvider(cpvTemporaria3);

  LVariaveisFiltro.ConsideraRepassados := blnConsChqRepassado;
  LVariaveisFiltro.Vencidos := blnVencidos;
  LVariaveisFiltro.RedeLoja := strRedLoj;
  LVariaveisFiltro.CodigoCliente := strCodCli;
  LVariaveisFiltro.CodigoPortador := strCodPor;
  LVariaveisFiltro.TipoFiltro := strTipFil;
  LVariaveisFiltro.DataInicial := strDtaIni;
  LVariaveisFiltro.DataFinal := strDtaFin;
  LVariaveisFiltro.Ordem := FOrdemRelatorio;
  FMostraDebCtrChq2Obj.CarregaOutrasVariaveis(LVariaveisFiltro);

  strSQL := FMostraDebCtrChq2Obj.RetornaSQLCheques;

  With qryCdsTmp3 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If Not fEmptyStr(strRedLoj) Then
      ParamByName('REDE').AsString   := strRedLoj
    Else
       ParamByName('CODCLI').AsString   := strCodCli;

    If Params.FindParam('CODPOR') <> nil Then
      ParamByName('CODPOR').AsString := strCodPor;

    If blnVencidos Then
    Begin
      ParamByName('DTAINI').AsDateTime := VS_Date;
    End
    Else If (Not fEmptyDate(strDtaIni)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(strDtaIni);
      ParamByName('DTAFIN').AsDateTime := StrToDate(strDtaFin);
    End;
      
    Open;

    pSetaClient(qryCdsTmp3);

    With TAggregateField.Create(Self) Do
    Begin
      Name          := 'CHQ_TOTCHQ';
      FieldName     := 'CHQ_TOTCHQ';
      DataSet       := cdsTemporaria3;
      Expression    := 'SUM(CHQ_VALCHQ)';
      DisplayFormat := '#,##0.00';
      Active        := True;
    End;

    cdsTemporaria3.Open;

    For intContador := 0 To cdsTemporaria3.FieldDefs.Count - 1 Do
      cdsTemporaria3.FieldDefs[intContador].Required := False;

    (cdsTemporaria3.FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';

    {***************************************}
    {* AJUSTAR VENCTO CONSIDERANDO SÁBADO, *}
    {* DOMINGO E FERIADO                   *}
    {************************************RV*}
    If blnAjuDta Then
      pAjustaDataCheque;

    If Not cdsTemporaria3.IsEmpty Then
      edtChqTot.Text := FloatToStrF(TAggregateField(cdsTemporaria3.FieldByName('CHQ_TOTCHQ')).Value, ffNumber, 12, 2)
    Else
    Begin
      blnQryVaziaCadChq := True;
      edtChqTot.Text    := '0,00';
    End;

  End;

  {****************************************}
  {* SOMATÓRIO DOS CHEQUES COM TELECHEQUE *}
  {*************************************RV*}
  cdsTelecheque.Data := cdsTemporaria3.Data;
  With cdsTelecheque Do
  Begin
    Close;
    Filtered := False;
    Filter   := 'CHQ_TELCHE = ' + QuotedStr('S');
    Filtered := True;
    With TAggregateField.Create(Self) Do
    Begin
      Name          := 'CHQ_TOTTEL';
      FieldName     := 'CHQ_TOTTEL';
      DataSet       := cdsTelecheque;
      Expression    := 'SUM(CHQ_VALCHQ)';
      DisplayFormat := '#,##0.00';
      Active        := True;
    End;
    Open;
    If Not IsEmpty Then
      edtTotTel.Text := FloatToStrF(TAggregateField(FieldByName('CHQ_TOTTEL')).Value, ffNumber, 12, 2)
    Else
      edtTotTel.Text    := '0,00';
  End;

  {****************************************}
  {* SOMATÓRIO DOS CHEQUES SEM TELECHEQUE *}
  {*************************************RV*}
  cdsNaoTelecheque.Data := cdsTemporaria3.Data;
  With cdsNaoTelecheque Do
  Begin
    Close;
    Filtered := False;
    Filter   := 'CHQ_TELCHE <> ' + QuotedStr('S');
    Filtered := True;
    With TAggregateField.Create(Self) Do
    Begin
      Name          := 'CHQ_TOTNAO';
      FieldName     := 'CHQ_TOTNAO';
      DataSet       := cdsNaoTelecheque;
      Expression    := 'SUM(CHQ_VALCHQ)';
      DisplayFormat := '#,##0.00';
      Active        := True;
    End;
    Open;
    If Not IsEmpty Then
      edtTotNao.Text := FloatToStrF(TAggregateField(FieldByName('CHQ_TOTNAO')).Value, ffNumber, 12, 2)
    Else
      edtTotNao.Text    := '0,00';
  End;

  pSetFocus(dbgDuplicatas);
end;

{***************************************}
{* CARREGA DADOS DO CADREC             *}
{************************************AF*}
class procedure TfrmMostraDebCtrChq2.pMostraContaCorrente(strCodCli,
  strTipFil: String; blnSelDocumentos, blnVencidos, blnAjuDta: Boolean;
  strFiltro: String; objDocumento: IDocumento; blnFiltraEmp: Boolean;
  arrPort: TConsultasArray; dtInicial, dtfinal: Tdate; blnInfCob: Boolean);
Var
  strDtaIni: String;
  strDtaFin: String;
  strCodPor: String;
  blnConf : Boolean;
  strRedLoj: String;
  frmSelClienteFiltro : TfrmSelClienteFiltro;
  strCodEmpSel : String;
  arrEmpSel: TConsultasArray;
  arrPortador: TConsultasArray;

  frmMostraDebCtrChq2: TfrmMostraDebCtrChq2;
Begin
  blnConf := True;
  strRedLoj := '';
  frmSelClienteFiltro := nil;
  frmMostraDebCtrChq2 := Nil;
  //********************************************************//
  // SE O CODIGO DO CLIENTE QUE EH INFORMADO POR PARAMENTRO //
  // ESTIVER EM BRANCO ENTAO ABRE A TELA DE SELECAO DE CLI- //
  // -NTE COM CAMPO CODIGO DO CLIENTE HABILITADO            //
  //*****************************************************ED*//
  If (fEmptyStr(strTipFil)) And ((Not blnVencidos) Or fEmptyStr(strCodCli)) Then
  Begin
    if Assigned(frmSelClienteFiltro) then
      pFreeAndNil(frmSelClienteFiltro);

    pCriarFormularios(TfrmSelClienteFiltro, frmSelClienteFiltro);
    try
      Try
        frmSelClienteFiltro.blnFiltraEmp := blnFiltraEmp;
        If fEmptyStr(strCodCli) Then
        Begin
          If Not fEmptyStr(strFiltro) Then
            frmSelClienteFiltro.edtFiltro.Text := strFiltro;

          frmSelClienteFiltro.edtCodCliente.Clear;
          frmSelClienteFiltro.edtDesCliente.Clear;
          frmSelClienteFiltro.blnSoVencidos := blnVencidos;
          frmSelClienteFiltro.edtCodCliente.ReadOnly := False;

          if Not (arrPort = nil) then
          begin
             frmSelClienteFiltro.arrPortador := arrPort;
             if length(frmSelClienteFiltro.arrPortador) > 1 then
             Begin
                frmSelClienteFiltro.edtCodPor.Text := '00000';
                frmSelClienteFiltro.edtNomPor.Text := '+1';
             end
             else
             if length(frmSelClienteFiltro.arrPortador) = 1 then
             Begin
                frmSelClienteFiltro.edtCodPor.Text := frmSelClienteFiltro.arrPortador[0].strCodigo;
                frmSelClienteFiltro.edtNomPor.Text := frmSelClienteFiltro.arrPortador[0].strDescri;
             End;
          end;

          If (Not (dtInicial = 0)) And (Not (dtfinal = 0)) Then
          Begin
             frmSelClienteFiltro.mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',dtInicial);
             frmSelClienteFiltro.mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',dtfinal);
          End
          Else
          Begin
             frmSelClienteFiltro.mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
             frmSelClienteFiltro.mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
          End;

          frmSelClienteFiltro.ShowModal;
        End
        Else
        Begin
          If Not fEmptyStr(strFiltro) Then
            frmSelClienteFiltro.edtFiltro.Text := strFiltro;

          frmSelClienteFiltro.edtCodCliente.Text     := strCodCli;
          frmSelClienteFiltro.edtDesCliente.Text     := fRetNomCliente(strCodCli);
          frmSelClienteFiltro.edtCodCliente.ReadOnly := True;

          if Not (arrPort = nil) then
          begin
             frmSelClienteFiltro.arrPortador := arrPort;
             if length(frmSelClienteFiltro.arrPortador) > 1 then
             Begin
                frmSelClienteFiltro.edtCodPor.Text := '00000';
                frmSelClienteFiltro.edtNomPor.Text := '+1';
             end
             else
             if length(frmSelClienteFiltro.arrPortador) = 1 then
             Begin
                frmSelClienteFiltro.edtCodPor.Text := frmSelClienteFiltro.arrPortador[0].strCodigo;
                frmSelClienteFiltro.edtNomPor.Text := frmSelClienteFiltro.arrPortador[0].strDescri;
             End;
          end;

          If (Not (dtInicial = 0)) And (Not (dtfinal = 0)) Then
          Begin
             frmSelClienteFiltro.mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',dtInicial);
             frmSelClienteFiltro.mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',dtfinal);
          End;

          frmSelClienteFiltro.ShowModal;
        End;

        blnConf := frmSelClientefiltro.blnConfirma;
        strCodCli := frmSelClienteFiltro.edtCodCliente.Text;
        If frmSelClienteFiltro.chkRedLoj.Checked = True  Then
          strRedLoj := frmSelClienteFiltro.strRedLoj;
        strCodPor   := frmSelClienteFiltro.edtCodPor.Text;
        arrPortador := frmSelClienteFiltro.arrPortador;

        If Not fEmptyStr(fTiraCaracEspeciais(frmSelClienteFiltro.mskDtaIni.Text)) Then
        Begin
          strDtaIni := frmSelClienteFiltro.mskDtaIni.Text;
          strDtaFin := frmSelClienteFiltro.mskDtaFin.Text;
        End
        Else
        Begin
          strDtaIni := '';
          strDtaFin := '';
        End;

        blnAjuDta := frmSelClienteFiltro.chkAjuDta.Checked;

        If blnFiltraEmp Then
        Begin
            strCodEmpSel := frmSelClienteFiltro.edtCodEmp.Text;
            arrEmpSel    := frmSelClienteFiltro.arrEmp;
        End;

      Except
        On E: Exception Do
        begin
          blnConf := False;
          pMensagensErro(E.Message, '[pMostraContaCorrente]');
        end;
      End;
    finally
      pFreeAndNil(frmSelClienteFiltro);
    end;
  End;

  If Not blnConf Then
    Exit;

  If fEmptyStr(strCodCli) Then
    Exit;

  pCriarFormularios(TfrmMostraDebCtrChq2, frmMostraDebCtrChq2);
  try
    Try
      If blnVencidos Then
        strTipFil :=  'A';  // Abertos;

      frmMostraDebCtrChq2.BtnImprimirBoleto.visible  := blnInfCob;
      frmMostraDebCtrChq2.BtnAlterarPortador.visible := blnInfCob;
      frmMostraDebCtrChq2.BtnEnviarNF.visible        := blnInfCob;

      frmMostraDebCtrChq2.strRedLoj := strRedLoj;
      frmMostraDebCtrChq2.strCodCli := strCodCli;

      If blnFiltraEmp Then
      Begin
        frmMostraDebCtrChq2.strCodEmp := strCodEmpSel;
        frmMostraDebCtrChq2.arrEmp    := arrEmpSel;
      End;

      frmMostraDebCtrChq2.strCodPor := strCodPor;
      frmMostraDebCtrChq2.arrPort   := arrPortador;

      If Not fEmptyStr(strDtaIni) Then
      Begin
        frmMostraDebCtrChq2.strDtaIni := strDtaIni;
        frmMostraDebCtrChq2.strDtaFin := strDtaFin;
      End
      Else
      Begin
        frmMostraDebCtrChq2.strDtaIni := '';
        frmMostraDebCtrChq2.strDtaFin := '';
      End;

      frmMostraDebCtrChq2.blnVencidos := blnVencidos;
      frmMostraDebCtrChq2.blnAjuDta   := blnAjuDta;

      frmMostraDebCtrChq2.blnSelDocumentosDeb := blnSelDocumentos;
      frmMostraDebCtrChq2.objDocumento        := objDocumento;

      If (Not fEmptyStr(strTipFil)) Then
        untFuncoesSimples.strTipFil := strTipFil;

      // Antes de abrir a tela verifica se terá informações para mostrar
      if frmMostraDebCtrChq2.fInicializa Then
        frmMostraDebCtrChq2.ShowModal
      Else
        fMensagem('','Não ha registros para essa consulta !',['&O K']);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pMostraContaCorrente]');
    End;
  finally
    pFreeAndNil(frmMostraDebCtrChq2);
  end;
End;

procedure TfrmMostraDebCtrChq2.pMostraDebCadRec;
  Var
    intContador: Integer;
begin
  lblDupOri.Caption := IIF(strTipFil = 'A', 'V. Ori.', 'V. Corrig.');
  lblJurRec.Caption := IIF(strTipFil = 'A', 'V. Juros', 'V. Receb.');
  lblCorDif.Caption := IIF(strTipFil = 'A', 'V. Corrig.', 'Diferença');

  if strTipFil <> 'A' then
  begin
    lblDupCor.Caption := 'V. Ori.';
  end
  else
  begin
    lblDupCor.Visible := False;
    edtDupCor.Visible := False;
  end;

  With cdsTemporaria2 Do
  Begin
    IndexFieldNames := 'CTR_HIST01;CTR_NUMDUP;NOMARQ';

    {***************************************}
    {* CONFIGURA O GRID DE RECEBIMENTOS    *}
    {************************************AF*}
    With dbgDuplicatasDados Do
    Begin

      ClearItems;

      intContador := 0;

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'SITUACAO';
      Columns[intContador].Caption               := 'Situação';
      Columns[intContador].Width                 := 50;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.Alignment.Horz := taCenter;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'NUMDUP';
      Columns[intContador].Caption               := 'Nº Dupl.';
      Columns[intContador].Width                 := IIF(strTipFil = 'A', 100, 87);
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CLIENTE';
      Columns[intContador].Caption               := 'Cliente';
      Columns[intContador].Width                 := 170;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'NOMPOR';
      Columns[intContador].Caption               := 'Portador';
      Columns[intContador].Width                 := 90;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_ESPDOC';
      Columns[intContador].Caption               := 'Esp.';
      Columns[intContador].Width                 := 27;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_CODEMP';
      Columns[intContador].Caption               := 'Emp.';
      Columns[intContador].Width                 := 27;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_CODVEN';
      Columns[intContador].Caption               := 'Ven.';
      Columns[intContador].Width                 := 27;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'EVENTO';
      Columns[intContador].Caption               := 'Centro de Custo';
      Columns[intContador].Width                 := 100;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_BOLETO';
      Columns[intContador].Caption               := 'Bol';
      Columns[intContador].Width                 := 27;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_BCOENV';
      Columns[intContador].Caption               := 'Bco';
      Columns[intContador].Width                 := 27;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_BCOBOL';
      Columns[intContador].Caption               := 'Bco. Bol.';
      Columns[intContador].Width                 := 45;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_DTAENV';
      Columns[intContador].Caption               := 'Dt. Env.';
      Columns[intContador].Width                 := 50;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_NOSNUM';
      Columns[intContador].Caption               := 'Nosso Nº';
      Columns[intContador].Width                 := 70;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_DTACAD';
      Columns[intContador].Caption               := 'Dt. Cad.';
      Columns[intContador].Width                 := 50;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      If ((fCfgSis('CVOREF') = 'S')) Then
      Begin
        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'VENORI';
        Columns[intContador].Caption               := 'Vcto. Orig.';
        Columns[intContador].Width                 := 60;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);
      End;

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_DTAVEN';
      Columns[intContador].Caption               := 'Dt. Ven.';
      Columns[intContador].Width                 := 50;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      If ((fCfgSis('CVOREF') = 'S')) Then
      Begin
        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'QTDE_PRO';
        Columns[intContador].Caption               := 'Qt. Prorrog.';
        Columns[intContador].Width                 := 70;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'DIAS_PRO';
        Columns[intContador].Caption               := 'Dias 1ª Prorrog.';
        Columns[intContador].Width                 := 83;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);
      End;

      IF strTipFil = 'A' THEN
      BEGIN
        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_VALORI';
        Columns[intContador].Caption               := 'V. Orig.';
        Columns[intContador].Width                 := 55;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'JUROS';
        Columns[intContador].Caption               := 'V. Juros';
        Columns[intContador].Width                 := 50;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_VALCAL';
        Columns[intContador].Caption               := 'V. Corrig.';
        Columns[intContador].Width                 := 50;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'DIASATRASO';
        Columns[intContador].Caption               := 'Dias Atraso';
        Columns[intContador].Width                 := 65;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_SEQBAI';
        Columns[intContador].Caption               := 'SeqBai';
        Columns[intContador].Width                 := -1;
        Columns[intContador].Visible               := False;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_DTAREC';
        Columns[intContador].Visible               := False;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        If fCfgSis('AUTCEN') = 'S' Then
        Begin
          CreateColumn;
          Columns[intContador].DataBinding.FieldName := 'INFVEI';
          Columns[intContador].Caption               := ' Placa Vei. - Km. ';
          Columns[intContador].Width                 := 120;
          Columns[intContador].PropertiesClass       := TcxTextEditProperties;
          Columns[intContador].Properties.ReadOnly   := True;
          Inc(intContador);
        End;

      END
      ELSE
      BEGIN
        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_VALORI';
        Columns[intContador].Caption               := 'V. Orig.';
        Columns[intContador].Width                 := 55;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_VALCAL';
        Columns[intContador].Caption               := 'V. Corrig.';
        Columns[intContador].Width                 := 50;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_DTAREC';
        Columns[intContador].Caption               := 'Dt. Rec.';
        Columns[intContador].Width                 := 50;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_VALREC';
        Columns[intContador].Caption               := 'V. Receb.';
        Columns[intContador].Width                 := 50;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_DIFERE';
        Columns[intContador].Caption               := 'Diferença';
        Columns[intContador].Width                 := 50;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'DIASATRASO';
        Columns[intContador].Caption               := 'Dias Atraso';
        Columns[intContador].Width                 := 65;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        CreateColumn;
        Columns[intContador].DataBinding.FieldName := 'CTR_SEQBAI';
        Columns[intContador].Caption               := 'SeqBai';
        Columns[intContador].Width                 := -1;
        Columns[intContador].Visible               := False;
        Columns[intContador].PropertiesClass       := TcxTextEditProperties;
        Columns[intContador].Properties.ReadOnly   := True;
        Inc(intContador);

        If fCfgSis('AUTCEN') = 'S' Then
        Begin
          CreateColumn;
          Columns[intContador].DataBinding.FieldName := 'INFVEI';
          Columns[intContador].Caption               := ' Placa Vei. - Km. ';
          Columns[intContador].Width                 := 120;
          Columns[intContador].PropertiesClass       := TcxTextEditProperties;
          Columns[intContador].Properties.ReadOnly   := True;
          Inc(intContador);
        End;
      End;

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_MARDES';
      Columns[intContador].Visible               := False;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'PORBAI';
      Columns[intContador].Caption               := 'Portador Baixa';
      Columns[intContador].Width                 := 100;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;
      Inc(intContador);

      CreateColumn;
      Columns[intContador].DataBinding.FieldName := 'CTR_VALDUP';
      Columns[intContador].Caption               := 'V. Dpl.';
      Columns[intContador].Width                 := 50;
      Columns[intContador].PropertiesClass       := TcxTextEditProperties;
      Columns[intContador].Properties.ReadOnly   := True;

      pCarregarColunasPDFNFBoleto;
    End;

    CriarAggregates;
  End;

  cdsTemporaria2.Data := cdsTemporaria.Data;

  CriaTempotariaHistoricoCobranca;

  PreencherTotalizadores;

  {***************************************************}
  {*    MASCARAS                                     *}
  {***************************************************}
  With cdsTemporaria2 Do
    For intContador := 0 To Fields.Count-1 Do
    Begin
      Case Fields[intContador].DataType Of
        ftFloat, ftCurrency, ftBCD: TFloatField(Fields[intContador]).DisplayFormat := '#,##0.00';
        ftDate: TDateField(Fields[intContador]).DisplayFormat := 'dd/mm/yy';
      End;
    End;

end;


procedure TfrmMostraDebCtrChq2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsTemporaria2.AfterScroll := Nil;
end;

procedure TfrmMostraDebCtrChq2.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMostraDebCtrChq2.BtnImprimirBoletoClick(Sender: TObject);
begin
  inherited;
  pConsultaBoleto();
end;

procedure TfrmMostraDebCtrChq2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnFechar.Click;
    VK_F9    : btnEnviarEmail.Click;
    VK_F8    : btnAgrupamentos.Click;
    VK_F7    : If btnProdutos.Enabled Then btnProdutos.Click;
    VK_F5    : btnRelatorio.Click;
    VK_F6    : btnObsDoc.Click;
    VK_F4    : btnDesmarcarTudo.Click;
    VK_F3    : btnMarcarTudo.Click;
    VK_SPACE : pMarcarDuplicata;
    VK_F10   : If btnAgeHis.Visible Then btnAgeHis.Click;
    VK_F11   : If btnAlterarPortador.Visible Then btnAlterarPortador.Click;
    VK_F2    : If btnEnviarNF.Visible Then btnEnviarNF.Click;
  End;
end;

procedure TfrmMostraDebCtrChq2.FormResize(Sender: TObject);
begin
  inherited;

  If (Screen.Width > 1024) Then
  Begin
        flwBotoesRodape.height := 27;
        flwBotoesRodape.width  := flwBotoesRodape.width + 380;
        pnlRodapeCR.height     := 191;
  End
  Else
  Begin
        flwBotoesRodape.height := 54;
        flwBotoesRodape.width  := 994;
        pnlRodapeCR.height     := 222;
  End;

end;

procedure TfrmMostraDebCtrChq2.FormShow(Sender: TObject);
begin
  inherited;

  {Se resolução disponível for inferior à (1024 x 768), maximiza tela!}
  If (Screen.Width < 1024) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

  If(strTipFil <> 'A')Then
      btnAgeHis.Visible := False;

  btnCfgRec.Visible := fVerificaAcessoSistema('EXBDCT');
  btnEnviarWhatsapp.Visible := fCfgSis('UTIWPP', varBoolean);

  pAtualizaDados(cdstemporaria2);
end;

procedure TfrmMostraDebCtrChq2.pCriaTemporaria;
  Var
    strSQL     : String;
    intContador: Integer;
begin
  fExecutaSQL('SET @ABRINDO_CONSULTA=TRUE');
  cdsTemporaria.Close;
  cdsTemporaria.SetProvider(cpvTemporaria);
  strDtaVen := StringReplace(fGetSqlDtaVen(blnAjuDta), 'TABELA.', EmptyStr, [rfReplaceAll]);
  If blnAjuDta Then
    strDtaVen := 'IF(CTR_DTAREC IS NULL, ' + strDtaVen + ', ' +
                 'IF(CTR_DTAREC <= FRETPROXDIAUTIL(CTR_DTAVEN), FRETPROXDIAUTIL(CTR_DTAVEN), ' +
                 strDtaVen + ')) ';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  GROUP_CONCAT(CONCAT(''"'', CADREC.AUTOINCREM, ''"'') SEPARATOR '','') AS DUPLICATAS_CARREGADAS, ';
  strSQL := strSQL + '  IF(CTR_DTAREC IS NULL, "A", "B") AS SITUACAO, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP, ';
  strSQL := strSQL + '  CTR_NUMDUP, CTR_PARCEL, CADREC.AUTOINCREM AS SEQDUP,  ';
  strSQL := strSQL + '  IF(CTR_ESPDOC = "", NULL, CTR_ESPDOC) AS CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  IF(CTR_CODVEN = "", NULL, CTR_CODVEN) AS CTR_CODVEN, ';
  strSQL := strSQL + '  IF((CTR_NOSNUM IS NOT NULL) OR (COALESCE(CTR_BCOBOL, "")= "999" AND CTR_DTABOL IS NOT NULL), "Sim", "Não") AS CTR_BOLETO, ';
  strSQL := strSQL + '  IF(CTR_DTAENV IS NOT NULL, "Sim", "Não") AS CTR_BCOENV, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CONCAT(EVE_CODEVE,  " - ", EVE_DESEVE) AS EVENTO, ';
  strSQL := strSQL + strDtaVen + ' AS CTR_DTAVEN, ';

  strSQL := strSQL + 'SUM(' + StringReplace(fGetSqlValDup, 'TABELA.', EmptyStr, [rfReplaceAll]) + ') AS VALDUP, ';

  strSQL := strSQL + '  SUM(IF(' + strDtaVen + ' < ' + fCurrentDate + ', (CTR_VALDUP + IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), 0)), 0.00)) AS CTR_DUPVEN, ';
  strSQL := strSQL + '  SUM(IF(' + strDtaVen + ' >= ' + fCurrentDate + ', (CTR_VALDUP + IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), 0)), 0.00)) AS CTR_DUPAVE, ';
  strSQL := strSQL + ' + SUM(' + fGetSqlValOri + ') AS VALORI, ';
  strSQL := strSQL + ' SUM(IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI)) AS CTR_VALORI, ';

  strSQL := strSQL + StringReplace(' SUM(( ' + fGetSqlValorJuros(fGetSqlValDup) + ' )) AS JUROS, ', 'TABELA.', EmptyStr, [rfReplaceAll]);

  strSQL := strSQL + '    SUM(IF((CTR_DTAREC IS NULL AND ' + strDtaVen + ' >= CURRENT_DATE) OR (CTR_VALDUP < 0), ';
  strSQL := strSQL +        StringReplace(fGetSqlValDup, 'TABELA.', EmptyStr, [rfReplaceAll]) + ', ';
  strSQL := strSQL + '      ( '+ StringReplace(fGetSqlValDup + ' + ('+ fGetSqlValorJuros(fGetSqlValDup), 'TABELA.', EmptyStr, [rfReplaceAll]) +'))';
  strSQL := strSQL + '    )) AS CTR_VALCAL, ' + #13;

  strSQL := strSQL + '  SUM(CTR_JURSUJ) AS CTR_JURSUJ, ';
  strSQL := strSQL + '  SUM(CTR_VALDES) AS CTR_VALDES, ';
  strSQL := strSQL + '  SUM(CTR_DESCON) AS CTR_DESCON, ';
  strSQL := strSQL + '  SUM(CTR_DESSUJ) AS CTR_DESSUJ, ';
  strSQL := strSQL + '  IF(CTR_VALREC > 0, CTR_VALREC - (IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0))), 0) AS CTR_DIFERE, '; //TODOS VAL. JUROS
  strSQL := strSQL + '  IF((' + strDtaVen + ' >= IF(CTR_DTAREC IS NULL, CURRENT_DATE, CTR_DTAREC)) OR (CTR_VALORI < 0) , 0, ' + #13;
  strSQL := strSQL + '     IF(CTR_DTAREC <= FRETPROXDIAUTIL(CTR_DTAVEN), 0, DATEDIFF(IF(CTR_DTAREC IS NULL, ' + #13;
  strSQL := strSQL + '                 CURRENT_DATE, ' + #13;
  strSQL := strSQL + '                 CTR_DTAREC), ' + strDtaVen + '))) AS DIASATRASO, ' + #13;
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  SUM(IFNULL(CTR_VALREC, 0)) AS CTR_VALREC, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CAST(IF(CTR_HIST01 IS NULL, "", CTR_HIST01) AS CHAR(255)) AS CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST01 AS CTR_HIST99, ';
  strSQL := strSQL + '  CAST(IF(CTR_HISBAI IS NULL, "", CTR_HISBAI) AS CHAR(255)) AS CTR_HISBAI, ';
  strSQL := strSQL + '  CAST(IF(CTR_HIST02 IS NULL, "", CTR_HIST02) AS CHAR(50)) AS CTR_HIST02, ';
  strSQL := strSQL + '  CONCAT(P.POR_CODPOR, " - ", P.POR_NOMPOR) AS NOMPOR,';
  strSQL := strSQL + '  "CADREC"   AS NOMARQ,     ';
  strSQL := strSQL + '  "M"        AS CTR_MARDES, ';
  If ((fCfgSis('AUTCEN') = 'S')) Then
  Begin
    strSQL := strSQL + ' ' + '  CONCAT(SUBSTRING(A.AUX_PLAVEI,1,3),"-",SUBSTRING(A.AUX_PLAVEI,4,4)," - ",';
    strSQL := strSQL + '  TRIM(LEADING "0" FROM REPLACE(FORMAT(A.AUX_KM_VEI,0),",", "."))) AS INFVEI,';
  End;
  strSQL := strSQL + '  CTR_BCOBOL, ';

  If ((fCfgSis('AUTCEN') <> 'S')) Then
  Begin

    strSQL := strSQL + ' (SELECT                               ';
    strSQL := strSQL + '    DET_NUM_PD                         ';
    strSQL := strSQL + '  FROM                                 ';
    strSQL := strSQL + '    MOVDET                             ';
    strSQL := strSQL + '  WHERE                                ';
    strSQL := strSQL + '    DET_NUMDOC = CTR_NUMDUP AND        ';
    strSQL := strSQL + '    DET_ESPDOC = CTR_ESPDOC AND        ';
    strSQL := strSQL + '    DET_CODEMP = CTR_CODEMP AND        ';
    strSQL := strSQL + '    DET_CODCLI = CTR_CODCLI AND        ';
    strSQL := strSQL + '    DET_ESP_PD = "PD"                  ';
    strSQL := strSQL + '  GROUP BY                             ';
    strSQL := strSQL + '    DET_NUMDOC,                        ';
    strSQL := strSQL + '    DET_ESPDOC,                        ';
    strSQL := strSQL + '    DET_CODEMP,                        ';
    strSQL := strSQL + '    DET_CODCLI) AS FGO_NUMDOC,         ';

  End;

  strSQL := strSQL + '  CTR_DTAENV, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CADREC.AUTOINCREM AS AUTOINCREM_CADREC, ';
  strSQL := strSQL + '  CONCAT(CTR_PORBAI, " - ", B.POR_NOMPOR) AS PORBAI, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CONCAT( ';
  strSQL := strSQL + '  IF(CTR_DINHEI IS NOT NULL AND CTR_DINHEI <> 0, CONCAT("DIN: ",FORMAT(SUM(CTR_DINHEI),2), "   "), ""),           ';
  strSQL := strSQL + '  IF(CTR_CHQAVI IS NOT NULL AND CTR_CHQAVI <> 0, CONCAT("CHV: ",FORMAT(SUM(CTR_CHQAVI),2), "   "), ""),           ';
  strSQL := strSQL + '  IF(CTR_CHQPRE IS NOT NULL AND CTR_CHQPRE <> 0, CONCAT("CHP: ",FORMAT(SUM(CTR_CHQPRE),2), "   "), ""),           ';
  strSQL := strSQL + '  IF(CTR_CARTAO IS NOT NULL AND CTR_CARTAO <> 0, CONCAT("CAR: ",FORMAT(SUM(CTR_CARTAO),2), "   "), "")) AS RECEBI ';

  strSQL := strSQL + fGetSqlVenctoOriginal_QtProrrogados;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC  ';
  strSQL := strSQL + 'INNER JOIN CADCLI ';
  strSQL := strSQL + '  ON CLI_CODCLI = CTR_CODCLI ';

  If ((fCfgSis('AUTCEN') = 'S')) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN MOVGER M ON M.GER_NUMDOC = CTR_NUMDUP AND ';
    strSQL := strSQL + '                        M.GER_ESPDOC = CTR_ESPDOC AND ';
    strSQL := strSQL + '                        M.GER_CODEMP = CTR_CODEMP AND ';
    strSQL := strSQL + '                        M.GER_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV A ON A.AUX_SEQGER = M.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADPOR P ON CTR_CODPOR = P.POR_CODPOR ';
  End
  Else
  strSQL := strSQL + ' LEFT JOIN CADPOR P ON CTR_CODPOR = P.POR_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN CADEVE ON EVE_CODEVE = CTR_CODEVE ';

  strSQL := strSQL + '  LEFT JOIN CADPOR B ON CTR_PORBAI = B.POR_CODPOR ';

  strSQL := strSQL + 'WHERE ' + TMostraDebCtrChq2.GetWhareDuplicataTroco + '(' ;
  If Not fEmptyStr(strRedLoj) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE'
  Else
  Begin
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
    If fCfgSis('TRFTCR', varString) = '2' Then
    Begin
      strSQL := strSQL + '    OR CLI_CODRED = ';
      strSQL := strSQL + '    (SELECT ';
      strSQL := strSQL + '       CLI_CODRED ';
      strSQL := strSQL + '     FROM ';
      strSQL := strSQL + '       CADCLI ';
      strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI) ';
    End;
  End;
  strSQL := strSQL + ')';
  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMPCCC') = '1' Then
    strSQL := strSQL + '  AND LOCATE(CTR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Assigned(arrEmp) And Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + fStrLocate(strCodEmp, arrEmp, 'CTR_CODEMP', 'CODEMP');

//  If Not fEmptyStr(strCodPor) Then
//    strSQL := strSQL + '  AND CTR_CODPOR = :CODPOR ';

  If Assigned(arrPort) And Not fEmptyStr(strCodPor) Then
    strSQL := strSQL + fStrLocate(strCodPor, arrPort, 'CTR_CODPOR', 'CODPOR');

  If Not fEmptyStr(fCfgSis('POOCRE')) Then
    strSQL := strSQL + 'AND IF((CTR_VALDUP < 0),IFNULL(CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString+',TRUE)';

  If fCfgSis('EXIPOR', varBoolean) Then
    strSQL := strSQL + ' AND ((IFNULL(P.POR_EXIPOR, "") = "") OR (P.POR_EXIPOR = "S"))  ';

  If strTipFil = 'A' Then
  Begin
    strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';

    If blnVencidos Then
      strSQL := strSQL + '  AND ' + strDtaVen + ' <= :DTAINI '
    Else If (Not fEmptyDate(strDtaIni)) Then
      strSQL := strSQL + '  AND ' + strDtaVen + ' BETWEEN :DTAINI AND :DTAFIN ';
  End
  Else
  Begin
    If (strTipFil = 'B') Then
    Begin
      strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';

      If blnVencidos Then
        strSQL := strSQL + '  AND CTR_DTAREC <= :DTAINI '
      Else If (Not fEmptyDate(strDtaIni)) Then
        strSQL := strSQL + '  AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';
    End
    Else
      If blnVencidos Then
        strSQL := strSQL + '  AND ' + strDtaVen + ' <= :DTAINI '
      Else If (Not fEmptyDate(strDtaIni)) Then
        strSQL := strSQL + '  AND ' + strDtaVen + ' BETWEEN :DTAINI AND :DTAFIN ';
  End;

  strSQL := strSQL + ' GROUP BY CTR_NUMDUP,CTR_PARCEL,CTR_ESPDOC,CTR_CODEMP,CTR_CODCLI,IFNULL(CTR_SEQCON,""),IFNULL(CTR_EMPBAI,""),IFNULL(CTR_DTABAI,"") ';


  With qryCdsTmp1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strRedLoj) Then
      ParamByName('REDE').AsString   := strRedLoj
    Else
      ParamByName('CODCLI').AsString := strCodCli;

//    If Params.FindParam('CODPOR') <> nil Then
//      ParamByName('CODPOR').AsString := strCodPor;

    If Assigned(arrPort) And Not fEmptyStr(strCodPor) Then
      pSetaParam(strCodPor, arrPort, strCodPor, 'CODPOR', qryCdsTmp1);

    If Assigned(arrEmp) And Not fEmptyStr(strCodEmp) Then
      pSetaParam(strCodEmp, arrEmp, strCodEmp, 'CODEMP', qryCdsTmp1);

    If blnVencidos Then
    Begin
      ParamByName('DTAINI').AsDateTime := VS_Date;
    End
    Else If (Not fEmptyDate(strDtaIni)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(strDtaIni);
      ParamByName('DTAFIN').AsDateTime := StrToDate(strDtaFin);
    End;

    Open;


    pSetaClient(qryCdsTmp1);

    cdsTemporaria.Open;

    For intContador := 0 To cdsTemporaria.FieldDefs.Count - 1 Do
      cdsTemporaria.FieldDefs[intContador].Required := False;

    If cdsTemporaria.IsEmpty Then
      blnQryVaziaCadRec := True;
  End;
end;

{***************************************}
{* CALCULA VALOR CORRIGIDO             *}
{************************************AF*}
procedure TfrmMostraDebCtrChq2.pCalculaValorCorrigido;
  Var
    fltJuros: Double;
begin
  Try

    With cdsTemporaria Do
    Begin
      First;
      DisableControls;

      While Not Eof Do
      Begin

        fltJuros := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                        FieldByName('VALDUP').AsFloat,
                                        fCfgSis('JURATR', varDouble));

        Edit;

        if FieldByName('CTR_DTAREC').AsDateTime > 0 Then
        begin
          FieldByName('CTR_VALCAL').AsFloat := FieldByName('VALORI').AsFloat;
          FieldByName('CTR_DIFERE').AsFloat := FieldByName('CTR_VALREC').AsFloat - FieldByName('VALORI').AsFloat;
        end
        else
        begin
          IF fltJuros = 0 THEN
            FieldByName('CTR_VALCAL').AsFloat := FieldByName('VALORI').AsFloat
          ELSE
            FieldByName('CTR_VALCAL').AsFloat := fltJuros + FieldByName('VALDUP').AsFloat;
        end;

        FieldByName('JUROS').AsFloat := FieldByName('JUROS').AsFloat + fltJuros;
        Post;

        Next;
      End;

    End;

  Finally
    cdsTemporaria.EnableControls;
  End;
end;

procedure TfrmMostraDebCtrChq2.pCarregarColunasPDFNFBoleto;
var
  intContador : Integer;
begin
  If Assigned(objDocumento) Then
  Begin
    intContador := dbgDuplicatasDados.ColumnCount;

    If Not Assigned(TcxGridDBColumnHelper.fFindColumnByName(dbgDuplicatasDados, 'PDF_NF')) Then
    Begin
      dbgDuplicatasDados.CreateColumn;
      dbgDuplicatasDados.Columns[intContador].Name                  := 'PDF_NF';
      dbgDuplicatasDados.Columns[intContador].Caption               := 'PDF NF';
      dbgDuplicatasDados.Columns[intContador].Width                 := 60;
      dbgDuplicatasDados.Columns[intContador].PropertiesClass       := TcxButtonEditProperties;
      dbgDuplicatasDados.Columns[intContador].Properties.OnButtonClick := PropertiesButtonNFClick;
      dbgDuplicatasDados.Columns[intContador].Properties.Buttons[0].Default := True;
      dbgDuplicatasDados.Columns[intContador].Properties.Buttons[0].Kind    := bkEllipsis;
      dbgDuplicatasDados.Columns[intContador].Properties.ReadOnly           := True;
      dbgDuplicatasDados.Columns[intContador].Options.ShowEditButtons       := isebAlways;
      Inc(intContador);
    End
    Else
      TcxGridDBColumnHelper.fFindColumnByName(dbgDuplicatasDados, 'PDF_NF').Visible := True;

    If Not Assigned(TcxGridDBColumnHelper.fFindColumnByName(dbgDuplicatasDados, 'PDF_BOLETO')) Then
    Begin
      dbgDuplicatasDados.CreateColumn;
      dbgDuplicatasDados.Columns[intContador].Name                  := 'PDF_BOLETO';
      dbgDuplicatasDados.Columns[intContador].Caption               := 'PDF Boleto';
      dbgDuplicatasDados.Columns[intContador].Width                 := 60;
      dbgDuplicatasDados.Columns[intContador].PropertiesClass       := TcxButtonEditProperties;
      dbgDuplicatasDados.Columns[intContador].Properties.OnButtonClick := PropertiesButtonBoletoClick;
      dbgDuplicatasDados.Columns[intContador].Properties.Buttons[0].Default := True;
      dbgDuplicatasDados.Columns[intContador].Properties.Buttons[0].Kind    := bkEllipsis;
      dbgDuplicatasDados.Columns[intContador].Properties.ReadOnly           := True;
      dbgDuplicatasDados.Columns[intContador].Options.ShowEditButtons       := isebAlways;
      Inc(intContador);
    End
    Else
      TcxGridDBColumnHelper.fFindColumnByName(dbgDuplicatasDados, 'PDF_BOLETO').Visible := True;

    If Not Assigned(TcxGridDBColumnHelper.fFindColumnByName(dbgDuplicatasDados, 'ANEXOS')) Then
    Begin
      dbgDuplicatasDados.CreateColumn;
      dbgDuplicatasDados.Columns[intContador].Name                  := 'ANEXOS';
      dbgDuplicatasDados.Columns[intContador].Caption               := 'Anexos';
      dbgDuplicatasDados.Columns[intContador].Width                 := 60;
      dbgDuplicatasDados.Columns[intContador].PropertiesClass       := TcxButtonEditProperties;
      dbgDuplicatasDados.Columns[intContador].Properties.OnButtonClick := PropertiesButtonAnexosClick;
      dbgDuplicatasDados.Columns[intContador].Properties.Buttons[0].Default := True;
      dbgDuplicatasDados.Columns[intContador].Properties.Buttons[0].Kind    := bkEllipsis;
      dbgDuplicatasDados.Columns[intContador].Properties.ReadOnly           := True;
      dbgDuplicatasDados.Columns[intContador].Options.ShowEditButtons       := isebAlways;
    End
    Else
      TcxGridDBColumnHelper.fFindColumnByName(dbgDuplicatasDados, 'ANEXOS').Visible := True;

  End;
end;

procedure TfrmMostraDebCtrChq2.btnVisChqClick(Sender: TObject);
begin
  inherited;
  btnVisChq.Enabled := False;
  btnVisCtr.Enabled := True;
  pSetFocus(dbgCheques);
end;

procedure TfrmMostraDebCtrChq2.btnVisCtrClick(Sender: TObject);
begin
  inherited;
  btnVisChq.Enabled := True;
  btnVisCtr.Enabled := False;
  pSetFocus(dbgDuplicatas);
end;

procedure TfrmMostraDebCtrChq2.CriarAggregates;
  Var
    LInc : Integer;

  Const
    arrCampos : Array [0..7] Of String = ('TOT_VALORI','TOT_VALREC','TOT_DIFERE',
                                          'TOT_VALDUP','TOT_VALJUR','TOT_VALCAL',
                                          'TOT_DUPVEN','TOT_DUPAVE');

    arrExpres : Array [0..7] Of String = ('VALORI','CTR_VALREC','CTR_DIFERE',
                                          'VALDUP','JUROS','CTR_VALCAL',
                                          'CTR_DUPVEN','CTR_DUPAVE');
begin
    {***************************************}
    {* CRIA OS AGGREGATES                  *}
    {************************************AF*}
    For LInc := Low(arrCampos) To High(arrCampos) Do
    Begin

      With TAggregateField.Create(Self) Do
      Begin
        Name          := arrCampos[LInc];
        FieldName     := arrCampos[LInc];
        DataSet       := cdsTemporaria2;
        Expression    := 'SUM(' + arrExpres[LInc] + ')';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

    End;

end;

procedure TfrmMostraDebCtrChq2.CriaTempotariaHistoricoCobranca;
  Var
    strSQL: String;
    qryHistDups : TUniQuery;
    dspHistDups : TUniDataSetProvider;
begin

  Try
    cdsHistDups.Close;
    qryHistDups := fCriaQuery(Self);
    dspHistDups:= TUniDataSetProvider.Create(Self);
    dspHistDups.DataSet := qryHistDups;
    cdsHistDups.SetProvider(dspHistDups);

    If cdsTemporaria2.IsEmpty Then
      Exit;

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   DUP_SEQDUP, COB_DTALAN, COB_HORLAN, COB_DTAAGE, COB_DTAREL, COB_BAIXAD, COB_HISCOB, COB_OPEBAI, ';
      strSQL := strSQL + '   CONCAT(COB_CODOPE,"-",OPE_NOMOPE) AS COB_CODOPE, ';
      strSQL := strSQL + '   IF(COB_DTAAGE IS NOT NULL, ''A'', ''R'') AS AGEREL, ';
      strSQL := strSQL + '   COALESCE(COB_DTAAGE,COB_DTAREL) AS DTA ';
      strSQL := strSQL + ' FROM DUPCOB ';
      strSQL := strSQL + ' INNER JOIN CADCOB ON CADCOB.AUTOINCREM = DUPCOB.DUP_SEQCOB ';
      strSQL := strSQL + ' INNER JOIN CADOPE ON COB_CODOPE = OPE_CODOPE ';
      strSQL := strSQL + ' WHERE DUP_SEQDUP IN('+fRetAutoincremDuplicatas+') ';
      strSQL := strSQL + '  ORDER BY COB_DTALAN DESC, COB_HORLAN DESC ';

      With qryHistDups Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
        If Not IsEmpty Then
        Begin
          pSetaClient(qryHistDups);
          cdsHistDups.Open;
          pSetaClient(cdsHistDups);
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmMostraDebCtrChq2.pTrazHistoricoDuplicata]');
      End;
    End;
  Finally
    cdsHistDups.SetProvider(nil);
    pFreeAndNil(dspHistDups);
    pFreeAndNil(qryHistDups);
  End;

End;

{**************************************}
{* TOTAL DUPLICATA VENCIDA E À VENCER *}
{***********************************AF*}
procedure TfrmMostraDebCtrChq2.pSomaTotVencimento;
begin
  Try
    fltTotVen := 0;
    fltTotVenOrig := 0;
    fltTotAve := 0;

    edtTotVencer.Text  := '0,00';
    edtTotVencido.Text := '0,00';
    edtTotVencidoOrig.Text := '0,00';

    If strTipFil = 'B' Then
      Exit;

    With cdsTemporaria Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        if (FieldByName('CTR_DTAREC').IsNull ) then
        begin
          If (FieldByName('CTR_DTAVEN').AsDateTime < VS_Date) Then
          Begin
            fltTotVen := fFormataFloat(fltTotVen + FieldByName('CTR_VALCAL').AsFloat,2);
            fltTotVenOrig := fFormataFloat(fltTotVenOrig + FieldByName('VALORI').AsFloat,2);
          End
          Else
            fltTotAve := fFormataFloat(fltTotAve + FieldByName('CTR_VALCAL').AsFloat,2);
        end;
        Next;
      End;
    End;

    edtTotVencido.Text := FloatToStrF(fltTotVen, ffNumber, 12, 2);
    edtTotVencidoOrig.Text := FloatToStrF(fltTotVenOrig, ffNumber, 12, 2);
    edtTotVencer.Text  := FloatToStrF(fltTotAve, ffNumber, 12, 2);

  Finally
    cdsTemporaria.First;
    cdsTemporaria.EnableControls;
  End;

end;

procedure TfrmMostraDebCtrChq2.pEnviarWppContaCorrente;
  Var
    LDestinatario    : String;
    LWppDestinatario : String;
    LArquivoEnvioWPP : String;
    LConfirmado : Boolean;
    LMensagem   : String;
    frmDigWppCtaCorrente : TfrmDigWppCtaCorrente;
    LCheckBoxSelecionados     : TCheckBoxMostraDebCtrChq2;
    LVariaveisFiltro          : TVariaveisMostraDebCtrChq2;
begin
  If (cdsTemporaria2.IsEmpty) And (cdsTemporaria3.IsEmpty) Then
    Exit;

  If (Not fEnviarWhatsappParaCliente(strCodCli)) Then
    Exit;

  LDestinatario      := fRetNomCliente(strCodCli);
  LWppDestinatario   := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  bChkObservacao     := True;

  pCriarFormularios(TfrmDigWppCtaCorrente, frmDigWppCtaCorrente);
  Try
    Try
      frmDigWppCtaCorrente.edtWhatsapp.Text := LWppDestinatario;
      frmDigWppCtaCorrente.edtContato.Text  := LDestinatario;
      LConfirmado := (frmDigWppCtaCorrente.ShowModal = mrOk);

      If (LConfirmado) Then
      Begin
        LDestinatario     := frmDigWppCtaCorrente.edtContato.Text;
        LWppDestinatario  := frmDigWppCtaCorrente.edtWhatsapp.Text;
        LMensagem         := frmDigWppCtaCorrente.memObservacoes.Text;
        bChkContaCorrente := frmDigWppCtaCorrente.chkContaCorrente.Checked;
        bChkProduto       := frmDigWppCtaCorrente.chkProduto.Checked;
        bChkCheque        := frmDigWppCtaCorrente.chkCheque.Checked;
        bChkDtaVen        := frmDigWppCtaCorrente.chkDtaVen.Checked;
        bChkJuros         := frmDigWppCtaCorrente.chkJuros.Checked;
        strMensagemRel    := LMensagem;
      End;
    Except
      On E: Exception Do
      Begin
        LConfirmado := False;
        pMensagensErro(E.Message, '[frmMostraDebCtrChq2.pEnviarWppContaCorrente]');
      End;
    End;
  Finally
    pFreeAndNil(frmDigWppCtaCorrente);
  End;

  If (Not LConfirmado) Then
    Exit;

  LCheckBoxSelecionados.ContaCorrente := bChkContaCorrente;
  LCheckBoxSelecionados.Produto       := bChkProduto;
  LCheckBoxSelecionados.Cheque        := bChkCheque;
  LCheckBoxSelecionados.Observacao    := bChkObservacao;
  LCheckBoxSelecionados.Juros         := bChkJuros;
  LCheckBoxSelecionados.DocAg         := bDocAgrup;
  LCheckBoxSelecionados.DtaVen        := blnDtaVen;
  LCheckBoxSelecionados.AjuDta        := blnAjuDta;
  LCheckBoxSelecionados.EndEre        := blnkEndEre;
  LCheckBoxSelecionados.BancoDoBoleto := bChkBancoDoBoleto;
  LCheckBoxSelecionados.NumPedFF      := bChkNumPedFF;
  LCheckBoxSelecionados.Credito       := FExibirCredito;

  FMostraDebCtrChq2Obj.SetCheckBoxSelecionados(LCheckBoxSelecionados);

  LVariaveisFiltro.RedeLoja          := strRedLoj;
  LVariaveisFiltro.TipoFiltro        := strTipFil;
  LVariaveisFiltro.CodigoCliente     := strCodCli;
  LVariaveisFiltro.CodigoPortador    := strCodPor;
  LVariaveisFiltro.ArrPortador       := arrPort;
  LVariaveisFiltro.MensagemRelatorio := LMensagem;
  LVariaveisFiltro.cdsTemporaria2    := cdsTemporaria2;
  LVariaveisFiltro.cdsTemporaria3    := cdsTemporaria3;
  LVariaveisFiltro.Ordem             := FOrdemRelatorio;
  LVariaveisFiltro.ConsideraRepassados := fCfgSis('CHQNVT', varBoolean);
  LVariaveisFiltro.Vencidos          := blnVencidos;

  FMostraDebCtrChq2Obj.CarregaOutrasVariaveis(LVariaveisFiltro);

  pGeraEmail(False, True);

  LArquivoEnvioWPP := FMostraDebCtrChq2Obj.ArquivoRelatorioEmail;

  If (Not fEmptyStr(LArquivoEnvioWPP)) Then
  Begin
    pEnviarRelatorioPorWhatsApp(LWppDestinatario, LArquivoEnvioWPP);
    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
end;

procedure TfrmMostraDebCtrChq2.pEnviarRelatorioPorWhatsApp(AWppDestinatario: String; AArquivoEnvioWPP: String);
var
  LIDFila: Extended;
  LApiKey: string;
  UploadFile: TUploadFile;
  EnqueueMessageToSend: TEnqueueMessageToSend;
  ReturnUploadFile: TReturnUploadFile;
begin
  If fEmptyStr(AWppDestinatario) Then
    Exit;

  LIDFila := fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE'));

  If LIDFila = 0 Then
    Exit;

  LApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [LIDFila]);

  If fEmptyStr(LApiKey) Then
    Exit;

  If (Not FileExists(AArquivoEnvioWPP)) Then
    Exit;

  EnqueueMessageToSend := TEnqueueMessageToSend.Create(False, False, False, True);
  try
    EnqueueMessageToSend.queueId := LIDFila;
    EnqueueMessageToSend.apiKey  := LApiKey;
    EnqueueMessageToSend.number  := AWppDestinatario;

    if FileExists(AArquivoEnvioWPP) then
    begin
      UploadFile := TUploadFile.Create;
      try
        UploadFile.queueId  := LIDFila;
        UploadFile.apiKey   := LApiKey;
        UploadFile.fileName := ExtractFileName(AArquivoEnvioWPP);
        UploadFile.mimeType := 'application/pdf';
        UploadFile.data     := RetornaArquivoBase64(AArquivoEnvioWPP);
        UploadFile.title    := 'Relação de Duplicata(s) - CONTAS A RECEBER';

        ReturnUploadFile := TControllerUploadFile.fUploadFile(UploadFile, '');

        If (Not Assigned(ReturnUploadFile)) Then
        Begin
          pMensagemOK('Erro ao fazer upload.');
          Exit();
        End;

        EnqueueMessageToSend.fileId  := ReturnUploadFile.fileId;
        EnqueueMessageToSend.file_id := ReturnUploadFile.fileId;
        EnqueueMessageToSend.text := 'Relação de Duplicata(s) - CONTAS A RECEBER';

        If (Not TControllerEnqueueMessageToSend.fSendMessage(EnqueueMessageToSend,
                                                            'Relação de Duplicata(s) - CONTAS A RECEBER',
                                                            'TfrmMostraDebCtrChq2.pEnviarRelatorioPorWhatsApp',
                                                            '')) Then
        Begin
          pMensagemOK('Erro ao enviar a mensagem.');
          Exit();
        End;
      Finally
        FreeAndNil(UploadFile);
      End;
    End
  Finally
    FreeAndNil(EnqueueMessageToSend);
  End;
end;

procedure TfrmMostraDebCtrChq2.pGerarHtmlContaCorrente;
  Var
    strDestinatario     : String;
    strEmailDestinatario: String;
    blnConfirma: Boolean;
    strMensagem: String;
    strTexto: String;
    arrDestinatarios, arrArquivos : TStringArray;
    frmDigEmailCtaCorrente : TfrmDigEmailCtaCorrente;

    LCheckBoxSelecionados: TCheckBoxMostraDebCtrChq2;

    LVariaveisFiltro: TVariaveisMostraDebCtrChq2;
begin

  If (cdsTemporaria2.IsEmpty) And (cdsTemporaria3.IsEmpty) Then
    Exit;

  strDestinatario      := fRetNomCliente(strCodCli);
  strEmailDestinatario := fRetEmailCliente(strCodCli);
  bChkObservacao       := True;

  Try
    pCriarFormularios(TfrmDigEmailCtaCorrente, frmDigEmailCtaCorrente);
    frmDigEmailCtaCorrente.edtEmail.Text   := strEmailDestinatario;
    frmDigEmailCtaCorrente.edtContato.Text := strDestinatario;
    blnConfirma := (frmDigEmailCtaCorrente.ShowModal = mrOk);

    If (blnConfirma) Then
    Begin
      strDestinatario      := frmDigEmailCtaCorrente.edtContato.Text;
      strEmailDestinatario := frmDigEmailCtaCorrente.edtEmail.Text;
      strMensagem          := frmDigEmailCtaCorrente.memObservacoes.Text;
      bChkContaCorrente    := frmDigEmailCtaCorrente.chkContaCorrente.Checked;
      bChkProduto          := frmDigEmailCtaCorrente.chkProduto.Checked;
      bChkCheque           := frmDigEmailCtaCorrente.chkCheque.Checked;
      bChkDtaVen           := frmDigEmailCtaCorrente.chkDtaVen.Checked;
      bChkJuros            := frmDigEmailCtaCorrente.chkJuros.Checked;
      strMensagemRel       := strMensagem;
    End;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmMostraDebCtrChq2.pGerarHtmlContaCorrente]');
    End;
  End;

  pFreeAndNil(frmDigEmailCtaCorrente);

  If (Not blnConfirma) Then
    Exit;

  {*******************************************}
  {* GERO AS INFORMAÇÕES DAS DUPLICATAS E    *}
  {* EXPORTO O HTML.                         *}
  {****************************************AC*}
  LCheckBoxSelecionados.ContaCorrente := bChkContaCorrente;
  LCheckBoxSelecionados.Produto := bChkProduto;
  LCheckBoxSelecionados.Cheque := bChkCheque;
  LCheckBoxSelecionados.Observacao := bChkObservacao;
  LCheckBoxSelecionados.Juros := bChkJuros;
  LCheckBoxSelecionados.DocAg := bDocAgrup;
  LCheckBoxSelecionados.DtaVen := blnDtaVen;
  LCheckBoxSelecionados.AjuDta := blnAjuDta;
  LCheckBoxSelecionados.EndEre := blnkEndEre;
  LCheckBoxSelecionados.BancoDoBoleto := bChkBancoDoBoleto;
  LCheckBoxSelecionados.NumPedFF := bChkNumPedFF;
  LCheckBoxSelecionados.Credito := FExibirCredito;

  FMostraDebCtrChq2Obj.SetCheckBoxSelecionados(LCheckBoxSelecionados);

  LVariaveisFiltro.RedeLoja := strRedLoj;
  LVariaveisFiltro.TipoFiltro := strTipFil;
  LVariaveisFiltro.CodigoCliente := strCodCli;
  LVariaveisFiltro.CodigoPortador := strCodPor;
  LVariaveisFiltro.ArrPortador := arrPort;
  LVariaveisFiltro.MensagemRelatorio := strMensagem;
  LVariaveisFiltro.cdsTemporaria2 := cdsTemporaria2;
  LVariaveisFiltro.cdsTemporaria3 := cdsTemporaria3;
  LVariaveisFiltro.Ordem := FOrdemRelatorio;
  LVariaveisFiltro.ConsideraRepassados := fCfgSis('CHQNVT', varBoolean);
  LVariaveisFiltro.Vencidos := blnVencidos;

  FMostraDebCtrChq2Obj.CarregaOutrasVariaveis(LVariaveisFiltro);

  pGeraEmail(False);

  strNomeArquivo := FMostraDebCtrChq2Obj.ArquivoRelatorioEmail;

  {*******************************************}
  {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O     *}
  {* ARQUIVO.                                *}
  {****************************************AC*}
  If (Not fEmptyStr(strNomeArquivo)) Then
  Begin
    strTexto := 'Segue em anexo Conta Corrente.';
    strTexto := strTexto + #13#10 + #13#10;
    strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
    strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

    pCriarArrayAnexosEDestinatarios(strNomeArquivo, strEmailDestinatario, arrDestinatarios, arrArquivos);

    TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, fRetNomeEmpresa + ' : Conta Corrente ',
      arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);

    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

end;

procedure TfrmMostraDebCtrChq2.pGravarConfiguracoesDebCtrChq2;
begin
  TCfgColDebCtr.pCarregarDadosSalvos(dbgDuplicatasDados);
  pCarregarColunasPDFNFBoleto;
end;

procedure TfrmMostraDebCtrChq2.btnEnviarEmailClick(Sender: TObject);
begin
  inherited;
  pGerarHtmlContaCorrente;
end;

procedure TfrmMostraDebCtrChq2.btnEnviarNFClick(Sender: TObject);
 Var
    iOpcao : Integer;
begin
  inherited;

  If fEmptyStr(fRetAutoIncremCadFis(cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString,
                                    cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString,
                                    cdsTemporaria2.FieldByName('CTR_CODEMP').AsString,
                                    cdsTemporaria2.FieldByName('CTR_CODCLI').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este registro não possui documento fiscal!', ['&Ok']);
    Exit;
  End;

  iOpcao := fMensagem('','Opção:',['Video','E-Mail','Whatsapp']);

  If iOpcao <> 1 Then
  Begin
     If (Not fVerificaDireitoAcesso('RIMPDC')) Then
     Begin
       fMensagem('ATENÇÃO!', 'Este operador não tem permissão para reimpressão de documentos!', ['&Ok']);
       Exit;
     End;
  End;

  pPosicionaDuplicata();

  Case iOpcao Of
   1: pMostraVideo();
   2: pEnviaEmail();
   3: pEnviaWhatsapp();
  End;

end;

procedure TfrmMostraDebCtrChq2.btnEnviarWhatsappClick(Sender: TObject);
begin
  pEnviarWppContaCorrente;
end;

Procedure TfrmMostraDebCtrChq2.pPosicionaDuplicata();
Begin
  If stlListSelecao.strings[0] <> '' Then
  Begin
    cdsTemporaria2.disableControls;
    cdsTemporaria2.First;
    cdsTemporaria2.Locate('AUTOINCREM_CADREC', fRetiraQuotedLista(stlListSelecao.strings[0]), []);
    cdsTemporaria2.EnableControls;
  End;
End;

procedure TfrmMostraDebCtrChq2.pMostraVideo;
Begin

  If Assigned(objDocumento) Then
  Begin
    pPosicionaDuplicata();

    if (not fTemPermissaoAcessarDocumento) then
      Exit;

    objDocumento.pImprimeNotaFiscal(cdsTemporaria2.FieldByName('SEQDUP').AsString, False);
  End;

End;

procedure TfrmMostraDebCtrChq2.pEnviaEmail;
 Var
     strAutoIn : String;
begin

   strEspDoc := 'NF';

   strAutoIn := fRetAutoIncremCadFis(cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString,
                                     cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString,
                                     cdsTemporaria2.FieldByName('CTR_CODEMP').AsString,
                                     cdsTemporaria2.FieldByName('CTR_CODCLI').AsString);

   If Not fEmptyStr(strAutoIn) Then
   Begin
      If fGravaGatilhoNotFic(strAutoIn, 'RC', 'E', cdsTemporaria2.FieldByName('CTR_CODCLI').AsString) Then
      Begin
         fMensagem('', 'E-Mail enviado com sucesso!', ['&Ok']);
         Exit;
      End;
   End;

End;

procedure TfrmMostraDebCtrChq2.pEnviaWhatsapp;
  Var
      strAutoIn : String;
begin

   strEspDoc := 'NF';

   strAutoIn := fRetAutoIncremCadFis(cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString,
                                     cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString,
                                     cdsTemporaria2.FieldByName('CTR_CODEMP').AsString,
                                     cdsTemporaria2.FieldByName('CTR_CODCLI').AsString);

   If Not fEmptyStr(strAutoIn) Then
   Begin
      If fGravaGatilhoNotFic(strAutoIn, 'RC', 'W', cdsTemporaria2.FieldByName('CTR_CODCLI').AsString) Then
      Begin
         fMensagem('', 'Mensagem via WhatsApp enviada com sucesso!', ['&Ok']);
         Exit;
      End;
   End;

end;


procedure TfrmMostraDebCtrChq2.btnAlterarPortadorClick(Sender: TObject);
begin
  inherited;

  If stlListSelecao.Count > 0 Then
  Begin
     setlength(arrDuplicatas,0);
     setlength(matrizDadosDuplicata,0);
     If fAlteraDuplicatas Then
     Begin
       fMensagem('', 'Registros alterados com sucesso!', ['&OK']);
     End

  End;

end;

procedure TfrmMostraDebCtrChq2.btnAcompEntregaClick(Sender: TObject);
Var
  intRecNo : Integer;
  cdsInfDuplicatas     : TUniClientDataSet;
begin
  inherited;

  If (Not fVerificaAcessoSistema('PERACOMENT')) Then Begin
    fMensagem('', 'Operador não tem direito de acesso ao Acompanhamento da Entrega!', ['&OK']);
    Exit;
  End;

  If (Not cdsTemporaria2.Active) or (cdsTemporaria2.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  If Not fTemRegistrosMarcados Then
  Begin
    fMensagem('ATENÇÃO!','Selecione um registro !',['&OK']);
    pSetFocus(dbgDuplicatas);
    Exit;
  End;

  cdsInfDuplicatas := TUniClientDataSet.Create(Self);

  If cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString = 'AG' then
    fMensagem('', 'Esse documento é um Agrupamento, portanto não possui acompanhamento de entrega vinculado!', ['&OK']);

  Try
    pCloneDataSet(cdsInfDuplicatas, cdsTemporaria2);
    intRecNo := cdsTemporaria2.RecNo;
    If Assigned(pProcAcompEntMostraDebCtrChq2) Then
    Begin
      pProcAcompEntMostraDebCtrChq2(cdsInfDuplicatas, cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString);
    End;
    cdsTemporaria2.RecNo := intRecNo;
  Finally
    FreeAndNil(cdsInfDuplicatas);
  End;
end;

procedure TfrmMostraDebCtrChq2.btnAgeHisClick(Sender: TObject);
Var
  cdsCadRec,
  cdsAux : TUniClientDataSet;
  frmInfCobrancaAgeRelHist : TfrmInfCobrancaAgeRelHist;
begin
  inherited;
  Try
    cdsCadRec := fCriaClientDataSet;
    cdsAux    := TUniClientDataSet.Create(Nil);
    cdsAux.Data := cdsTemporaria2.Data;
    Try
      cdsAux.First;
      With cdsAux Do
      Begin
        While Not Eof Do
        Begin
          If (FieldByName('CTR_MARDES').AsString = 'M') Then
          Begin
            cdsCadRec.Append;
            cdsCadRec.FieldByName('CTR_DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
            cdsCadRec.FieldByName('CTR_NUMDUP').AsString   := FieldByName('CTR_NUMDUP').AsString;
            cdsCadRec.FieldByName('AUTOINCREM').AsString   := FieldByName('SEQDUP').AsString;
            cdsCadRec.FieldByName('CTR_PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
            cdsCadRec.FieldByName('CTR_ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
            cdsCadRec.FieldByName('CTR_CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
            cdsCadRec.FieldByName('CTR_VALORI').AsFloat    := FieldByName('CTR_VALORI').AsFloat;
            cdsCadRec.FieldByName('CTR_VALCAL').AsFloat    := FieldByName('CTR_VALCAL').AsFloat;
            cdsCadRec.FieldByName('CTR_VALJUR').AsFloat    := FieldByName('JUROS').AsFloat;
            cdsCadRec.Post;
          End;
          Next;
        End;
      End;
      If Not(cdsCadRec.IsEmpty) Then
      Begin
        pCriarFormularios(TfrmInfCobrancaAgeRelHist, frmInfCobrancaAgeRelHist);
        frmInfCobrancaAgeRelHist.cdsInfCob := cdsCadRec;
        frmInfCobrancaAgeRelHist.strCodCli := strCodCli;
        frmInfCobrancaAgeRelHist.strCodEmp := VS_strCodEmp;
        frmInfCobrancaAgeRelHist.blnVeioMostraDebCtrChq2 := True;
        frmInfCobrancaAgeRelHist.blnApagarInfoClient := False;
        frmInfCobrancaAgeRelHist.ShowModal;
      End
      Else
      Begin
        fMensagem('ATENÇÃO','Selecione uma Duplicata!',['&OK']);
        pSetFocus(dbgDuplicatas);
      End;
    Except
      On E: Exception Do
      Begin
      pMensagensErro(E.Message, '[frmMostraDebCtrChq2.btnAgeHisClick]');
      End;
    End;
  Finally
    pFreeAndNil(cdsAux);
    pFreeAndNil(cdsCadRec);
    If Assigned(frmInfCobrancaAgeRelHist) Then
      pFreeAndNil(frmInfCobrancaAgeRelHist);
  End;
end;

procedure TfrmMostraDebCtrChq2.btnAgrupamentosClick(Sender: TObject);
begin
  inherited;

  If (cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString = 'AG') Then
  Begin
    pMostraDuplicatasAgrupadas(LeftStr(cdsTemporaria2.FieldByName('NUMDUP').AsString, fTamDocCadRec),
                               LeftStr(cdsTemporaria2.FieldByName('CTR_CODEMP').AsString, 3),
                               cdsTemporaria2.FieldByName('CTR_CODCLI').AsString,
                               blnSelDocumentosDeb);
  End;

end;

procedure TfrmMostraDebCtrChq2.btnCfgRecClick(Sender: TObject);
var
  LFrmConfigMostraDebCtrChq2 : TfrmConfigMostraDebCtrChq2;
  LSalvaIndexFieldNames      : String;
  LSalvaIndexName            : String;
begin
  inherited;
  If (btnCfgRec.Visible) Then
  Begin
    LSalvaIndexFieldNames := cdsTemporaria2.IndexFieldNames;
    LSalvaIndexName       := cdsTemporaria2.IndexName;

    pCriarFormularios(tfrmConfigMostraDebCtrChq2, LFrmConfigMostraDebCtrChq2);
    Try
      LFrmConfigMostraDebCtrChq2.frmMostraDebCtrChq2 := Self;
      LFrmConfigMostraDebCtrChq2.ShowModal;

      If (LFrmConfigMostraDebCtrChq2.blnConfirma) Then
        TFrmGravando.fExecutarModal( pGravarConfiguracoesDebCtrChq2, 'Aguarde... Gravando Configurações!', '')
      else
      begin
        if (not fEmptyStr(LSalvaIndexName)) then
          cdsTemporaria2.IndexName := LSalvaIndexName
        else
        if (not fEmptyStr(LSalvaIndexFieldNames)) then
          cdsTemporaria2.IndexFieldNames := LSalvaIndexFieldNames;
      end;
    Finally
      pFreeAndNil(LFrmConfigMostraDebCtrChq2);
    End;
  End;
end;

procedure TfrmMostraDebCtrChq2.btnProdutosClick(Sender: TObject);
var
  frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;
  qryVerProdServ: TUniQuery;
  strSQL,
  strNumDoc,
  strEspDoc,
  strCodEmp: String;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);
    frmRelFatVendasClienteF9.blnMostraDebCtrChq2 := True;
    frmRelFatVendasClienteF9.dtsRelVenCli.DataSet := frmModuloSPR.qryRelatorio;
    frmRelFatVendasClienteF9.blnMosVenMtl := fCfgSis('VENMTL', varBoolean);

    strNumDoc:= '';
    strEspDoc:= '';
    strCodEmp:= '';

    With frmRelFatVendasClienteF9 Do
    Begin
      qryVerProdServ := fCriaQuery(Self);
      strSql := 'SELECT SQL_NO_CACHE '+
                '  DET_CODITE, "MOVGER" AS TABELA '+
                'FROM '+
                '  MOVDET '+
                'WHERE '+
                '  DET_NUMDOC = :NUMDOC '+
                '  AND DET_ESPDOC = :ESPDOC '+
                '  AND DET_CODEMP = :CODEMP '+
                IfThen(Not fEmptyStr(cdsTemporaria2.FieldByName('CTR_CODCLI').AsString),
                '  AND DET_CODCLI = :CODCLI ','')+
                '  AND DET_CODCLI NOT IN (' + VS_strCliFil + ') '+
                '  AND (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0) '+
                '  AND DET_PROEMB <> "S" '+
                '  AND DET_TIP_FC = "C" ';

      qryVerProdServ.Sql.Text := strSQl + ' UNION ALL ' +
                                 AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

      If Copy(cdsTemporaria2.FieldByName('CTR_HIST01').AsString, 1, 31) = 'REF. LANC. CREDITO ( GARANTIA )' Then
      Begin
        If Copy(cdsTemporaria2.FieldByName('CTR_HIST01').AsString, 100, 12) <> '' Then
        Begin
          strNumDoc:= Copy(cdsTemporaria2.FieldByName('CTR_HIST01').AsString, 100, 12);
          strEspDoc:= Copy(cdsTemporaria2.FieldByName('CTR_HIST01').AsString, 113, 2);
          strCodEmp:= Copy(cdsTemporaria2.FieldByName('CTR_HIST01').AsString, 116, 3);

          qryVerProdServ.ParamByName('NUMDOC').AsString := strNumDoc;
          qryVerProdServ.ParamByName('ESPDOC').AsString := strEspDoc;
          qryVerProdServ.ParamByName('CODEMP').AsString := strCodEmp;
        End;
      End
      Else
      Begin
        strNumDoc:= LeftStr(cdsTemporaria2.FieldByName('NUMDUP').AsString, fTamDocCadRec);
        strEspDoc:= cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString;
        strCodEmp:= LeftStr(cdsTemporaria2.FieldByName('CTR_CODEMP').AsString, 3);

        qryVerProdServ.ParamByName('NUMDOC').AsString := strNumDoc;
        qryVerProdServ.ParamByName('ESPDOC').AsString := strEspDoc;
        qryVerProdServ.ParamByName('CODEMP').AsString := strCodEmp
      End;

      If Not fEmptyStr(cdsTemporaria2.FieldByName('CTR_CODCLI').AsString) Then
        qryVerProdServ.ParamByName('CODCLI').AsString := cdsTemporaria2.FieldByName('CTR_CODCLI').AsString;

      qryVerProdServ.Open;

      {*********************************************}
      {** Aqui verifico se a Duplicata em questão **}
      {** é de Produtos ou Serviços               **}
      {******************Req.73064**11/04/2018**WS**}
      If (qryVerProdServ.FieldByName('DET_CODITE').AsString = fCfgSis('SERTER', varString)) or
         (qryVerProdServ.FieldByName('DET_CODITE').AsString = fCfgSis('ITESER', varString)) Then
      Begin
        pMostrarServicos(LeftStr(cdsTemporaria2.FieldByName('NUMDUP').AsString, fTamDocCadRec),
                         cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString,
                         LeftStr(cdsTemporaria2.FieldByName('CTR_CODEMP').AsString, 3),
                         qryVerProdServ.FieldByName('TABELA').AsString,
                         False,
                         cdsTemporaria2.FieldByName('CTR_CODCLI').AsString);
      End
      Else
      Begin
        pMostrarProdutos(strNumDoc,
                         strEspDoc,
                         strCodEmp,
                         False,
                         cdsTemporaria2.FieldByName('CTR_CODCLI').AsString);
      End;

      qryVerProdServ.Close;
      FreeAndNil(qryVerProdServ);

      ShowModal;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnProdutosClick]');
    End;
  End;

  pFreeAndNil(frmRelFatVendasClienteF9);
end;

procedure TfrmMostraDebCtrChq2.pAjustaDataCheque;
  Var
    strSQL   : String;
    dtaDtaVen: TDateTime;
    dtaDtaAnt: TDateTime;
    qryCadFer: TUniQuery;
Begin
  Try
    qryCadFer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FER_DTAFER ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FER_DTAFER = :DTAFER ';

    cdsTemporaria3.First;
    While Not cdsTemporaria3.Eof Do
    Begin

      dtaDtaVen := cdsTemporaria3.FieldByName('CHQ_DTAVEN').AsDateTime;
      dtaDtaAnt := cdsTemporaria3.FieldByName('CHQ_DTAVEN').AsDateTime;

      {*********************************************************}
      {* VERIFICA SE O VENCIMENTO EXISTE NA TABELA DE FERIADOS *}
      {******************************************************RV*}
      With qryCadFer Do
      Begin
        SQL.Clear;
        SQL.add(strSQL);
        ParamByName('DTAFER').AsDateTime := dtaDtaVen;
        Open;
      End;

      {*****************************************}
      {* CASO SEJA FERIADO SOMA MAIS 1 NA DATA *}
      {**************************************RV*}
      If (qryCadFer.RecordCount > 0) Then
        dtaDtaVen := dtaDtaVen + 1;

      {*************************}
      {* VERIFICA SE É SÁBADO  *}
      {**********************RV*}
      If (DayOfWeek(dtaDtaVen) = 7) Then
        dtaDtaVen := dtaDtaVen + 2
      Else
      {*************************}
      {* VERIFICA SE É DOMINGO *}
      {**********************RV*}
      Begin
        If (DayOfWeek(dtaDtaVen) = 1) Then
          dtaDtaVen := dtaDtaVen + 1;
      End;

      {************************************************}
      {* CASO TENHA SIDO NECESSARIA ALTERACAO NA DATA *}
      {*********************************************RV*}
      If (dtaDtaVen <> dtaDtaAnt) Then
      Begin
        cdsTemporaria3.Edit;
        cdsTemporaria3.FieldByName('CHQ_DTAVEN').AsDateTime := dtaDtaVen;
        cdsTemporaria3.Post;
      End;

      cdsTemporaria3.Next;
    End;
    cdsTemporaria3.First;

    FreeAndNil(qryCadFer);

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmMostraDebCtrChq2.pAtualizaDados(DataSet: TDataSet);
begin

  {*******************************************}
  {* HABILITA / DESABILITA BOTÃO QUE CHAMA   *}
  {* TELA DE DUPLICATAS AGRUPADAS            *}
  {****************************************RL*}
  If DataSet.FieldByName('CTR_ESPDOC').AsString = 'AG' Then
  Begin
    btnAgrupamentos.Enabled := True;
    btnProdutos.Enabled     := False;
  End
  Else
  Begin
    btnAgrupamentos.Enabled := False;
    btnProdutos.Enabled     := True;
  End;

  btnImprimirBoleto.Enabled  := (fVerificaQtdeSelecionados() = 1);
  btnAlterarPortador.Enabled := (fVerificaQtdeSelecionados() = 1);
  btnEnviarNF.Enabled        := (fVerificaQtdeSelecionados() = 1);

  pTrazHistoricoDuplicata(DataSet.FieldByName('AUTOINCREM_CADREC').AsString);

end;

procedure TfrmMostraDebCtrChq2.pBotaoConfigurar;
begin
  If (dbgDuplicatasDados.DataController.DataSet <> Nil) Then
  begin
    If (Not dbgDuplicatasDados.DataController.DataSet.IsEmpty) Then
    Begin
      TCfgColDebCtr.pIniciar(dbgDuplicatas, dbgDuplicatasDados);
      pCarregarColunasPDFNFBoleto;

      btnCfgRec.Enabled := btnCfgRec.Visible;
    End;
  End;
end;

procedure TfrmMostraDebCtrChq2.FormCreate(Sender: TObject);
begin
  inherited;

  qryCdsTmp1 := fCriaQuery(Self);
  cpvTemporaria.DataSet := qryCdsTmp1;

  qryCdsTmp3 := fCriaQuery(Self);
  cpvTemporaria3.DataSet := qryCdsTmp3;

  qryConsultaBoleto := fCriaQuery(qryConsultaBoleto);

  If (Screen.Width > 1024) Then
  Begin
        flwBotoesRodape.height := 27;
        flwBotoesRodape.width  := flwBotoesRodape.width + 380;
        pnlRodapeCR.height     := 191;
        PnlInfCob.width        := 523;

        grdHistDupsTableView1.Columns[1].Visible := True;
        grdHistDupsTableView1.Columns[3].Visible := True;
        mdbHisDup.width := 185;

  End
  Else
  Begin
        flwBotoesRodape.height := 54;
        flwBotoesRodape.width  := 994;
        pnlRodapeCR.height     := 222;
        PnlInfCob.width        := 193;

        grdHistDupsTableView1.Columns[1].Visible := False;
        grdHistDupsTableView1.Columns[3].Visible := False;
        mdbHisDup.width := 0;

  End;

  stlListSelecao := TStringlist.Create;
  stlListSelecao.Clear;

  listaImpressa := TStringList.Create;
  listaImpressa.Clear;

  listaNaoImpressa := TStringList.Create;
  listaNaoImpressa.Clear;

  cdsHistDups := TUniClientDataSet.Create(Self);
  dtsHistDups := fCriaDataSource(cdsHistDups);
  grdHistDupsTableView1.DataController.DataSource := dtsHistDups;
  mdbHisDup.DataSource := dtsHistDups;

  cdsTemporaria2.AfterScroll := pAtualizaDados;
  blnSelDocumentosDeb        := False;
  blnQryVaziaCadRec          := False;
  blnQryVaziaCadChq          := False;
  blnVencidos                := False;
  bChkDtaVen                 := False;
  blnDtaVen                  := True;

  FOrdemRelatorio := -1;

  FMostraDebCtrChq2Obj := TMostraDebCtrChq2.Create;
end;

procedure TfrmMostraDebCtrChq2.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(stlListSelecao) Then
     FreeAndNil(stlListSelecao);

  If Assigned(FMostraDebCtrChq2Obj) Then
    FreeAndNil(FMostraDebCtrChq2Obj);
end;

{*******************************************}
{* PROCEDURE QUE GERA INFORMAÇÕES PARA O   *}
{* RELATÓRIO E EXPORTA O PDF               *}
{****************************************AC*}
procedure TfrmMostraDebCtrChq2.pGeraEmail(blnAbrirEmVideo: Boolean; AGerarArquivoWpp: Boolean = False);
  Var
    LRegistroAtual: Integer;
begin
  LRegistroAtual := cdsTemporaria2.RecNo;

  cdsTemporaria2.AfterScroll := Nil;
  cdsTemporaria2.DisableControls;

  FMostraDebCtrChq2Obj.GerarRelatorio(blnAbrirEmVideo,
                                      fRetDupSel,
                                      Self.Name,
                                      Self.Caption,
                                      AGerarArquivoWpp);

  cdsTemporaria2.Filtered := False;
  cdsTemporaria2.Filter   := '';

  cdsTemporaria2.RecNo := LRegistroAtual;

  cdsTemporaria2.EnableControls;
  cdsTemporaria2.AfterScroll := pAtualizaDados;
  cdsTemporaria2.AfterScroll(cdsTemporaria2);
end;


function TfrmMostraDebCtrChq2.fGetSqlValDup(strTabela: String = ''): String;
begin
  If blnDescFinanSomenteAteVenc Then
    Result := ' IF((' + strDtaVen + ' < CURDATE()), ' + #13 +
              ' (TABELA.CTR_VALDUP + IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0) + IFNULL(TABELA.CTR_JURSUJ, 0) + IFNULL(TABELA.CTR_DESCOB, 0) - 0), ' + #13 +
              ' (TABELA.CTR_VALDUP + IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0) + IFNULL(TABELA.CTR_JURSUJ, 0) + IFNULL(TABELA.CTR_DESCOB, 0) - IFNULL(TABELA.CTR_DESSUJ, 0))) ' + #13
  else
    Result := '  (TABELA.CTR_VALDUP + IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0) + IFNULL(TABELA.CTR_JURSUJ, 0) + IFNULL(TABELA.CTR_DESCOB, 0) - IFNULL(TABELA.CTR_DESSUJ, 0)) ' + #13;

  Result := StringReplace(Result, 'TABELA.', IIF(fEmptyStr(strTabela), '', strTabela + '.'), [rfReplaceAll]);
end;

function TfrmMostraDebCtrChq2.fGetSqlValOri(blnSomAgr: Boolean = False): String;
begin
  If blnSomAgr Then
    Result := ' IFNULL(IF(AGR.CTR_SEQBAI = 0, AGR.CTR_VALDUP, AGR.CTR_VALORI), 0) + ' +
              '        IFNULL(AGR.CTR_JURSUJ, 0) + IFNULL(AGR.CTR_DESCOB, 0) - IFNULL(AGR.CTR_DESSUJ, 0) '
  Else
    Result := ' IFNULL(IF(CTR_SEQBAI = 0,IF(CTR_VALREC <> 0, CTR_VALREC + IFNULL(CTR_VALDES, 0) - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0), CTR_VALDUP), CTR_VALORI), 0) + ' +
              '         IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), 0) ';
end;

function TfrmMostraDebCtrChq2.fGetSqlVenctoOriginal_QtProrrogados : String;
begin

   If ((fCfgSis('CVOREF') = 'S')) Then
   Begin

     //-- "VEN. ORIG.":
     Result := ',IFNULL('+
                      ' (SELECT CTR_DTAVEN FROM LOGCTR L WHERE L.CTR_NUMDUP = CADREC.CTR_NUMDUP AND '+  //L.CTR_DESCRI = ''INCLUSÃO'' AND
                                                      ' L.CTR_ESPDOC = CADREC.CTR_ESPDOC AND '+
                                                      ' L.CTR_PARCEL = CADREC.CTR_PARCEL AND '+
                                                      ' L.CTR_CODEMP = CADREC.CTR_CODEMP AND '+
                                                      ' L.CTR_CODCLI = CADREC.CTR_CODCLI AND '+
                                                      ' L.CTR_SEQBAI = 0 '+
                                                ' GROUP BY CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL, CTR_CODEMP, CTR_CODCLI '+
                                                ' ORDER BY CTR_DTALOG, CTR_HORLOG), CTR_DTAVEN) AS VENORI,  ';

     //-- QTDE. DIAS DA PRIMEIRA PRORROGAÇÃO
     Result := Result + '(SELECT( '+
                              ' IFNULL( '+
                                    ' DATEDIFF( '+
                                    ' (SELECT CTR_DTAVEN FROM CADREC C WHERE C.CTR_NUMDUP = CADREC.CTR_NUMDUP AND '+
                                                                           ' C.CTR_ESPDOC = CADREC.CTR_ESPDOC AND '+
                                                                           ' C.CTR_PARCEL = CADREC.CTR_PARCEL AND '+
                                                                           ' C.CTR_CODEMP = CADREC.CTR_CODEMP AND '+
                                                                           ' C.CTR_CODCLI = CADREC.CTR_CODCLI AND '+
                                                                           ' C.CTR_SEQBAI = 0 ) , '+

                                    ' (SELECT CTR_DTAVEN FROM LOGCTR L WHERE L.CTR_NUMDUP = CADREC.CTR_NUMDUP AND '+  //L.CTR_DESCRI = ''INCLUSÃO''
                                                                           ' L.CTR_ESPDOC = CADREC.CTR_ESPDOC AND '+
                                                                           ' L.CTR_PARCEL = CADREC.CTR_PARCEL AND '+
                                                                           ' L.CTR_CODEMP = CADREC.CTR_CODEMP AND '+
                                                                           ' L.CTR_CODCLI = CADREC.CTR_CODCLI AND '+
                                                                           ' L.CTR_SEQBAI = 0 '+
                                                                     ' GROUP BY CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL, CTR_CODEMP, CTR_CODCLI '+
                                                                     ' ORDER BY CTR_DTALOG, CTR_HORLOG) ) ,0) '+
                             ' )) AS DIAS_PRO, ';

     //-- QTDE DE PRORROGAÇOES DA DUPLICATA
     Result := Result + ' IF( '+
                             'IFNULL( '+
                                   ' (SELECT COUNT(DISTINCT CTR_DTAVEN) - 1 FROM LOGCTR R '+
                                   '  WHERE R.CTR_NUMDUP = CADREC.CTR_NUMDUP AND '+
                                          ' R.CTR_ESPDOC = CADREC.CTR_ESPDOC AND '+
                                          ' R.CTR_PARCEL = CADREC.CTR_PARCEL AND '+
                                          ' R.CTR_CODEMP = CADREC.CTR_CODEMP AND '+
                                          ' R.CTR_CODCLI = CADREC.CTR_CODCLI '+
                                   ' GROUP BY R.CTR_NUMDUP, R.CTR_ESPDOC, R.CTR_PARCEL, R.CTR_CODEMP, R.CTR_CODCLI), 0) = -1, '+
                           ' 0,'+
                           ' IFNULL( '+
                           '         (SELECT  COUNT(DISTINCT CTR_DTAVEN) - 1 FROM LOGCTR R '+
                           '      WHERE '+
                           '        R.CTR_NUMDUP = CADREC.CTR_NUMDUP AND '+
                           '        R.CTR_ESPDOC = CADREC.CTR_ESPDOC AND '+
                           '        R.CTR_PARCEL = CADREC.CTR_PARCEL AND '+
                           '        R.CTR_CODEMP = CADREC.CTR_CODEMP AND '+
                           '        R.CTR_CODCLI = CADREC.CTR_CODCLI '+
                           '  GROUP BY R.CTR_NUMDUP, R.CTR_ESPDOC, R.CTR_PARCEL, R.CTR_CODEMP, R.CTR_CODCLI), 0)) AS QTDE_PRO ';

   End;

end;

function TfrmMostraDebCtrChq2.fCriaClientDataSet: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  end;


  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NUMDUP';
    DataType := ftString;
    Size     := 12
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_PARCEL';
    DataType := ftString;
    Size     := 3
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ESPDOC';
    DataType := ftString;
    Size     := 2
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CODEMP';
    DataType := ftString;
    Size     := 3
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALORI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALJUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALCAL';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;
end;

function TfrmMostraDebCtrChq2.fGetSqlDtaVen(blnAjuVen: Boolean): String;
begin
  Result := IIF(Not blnAjuVen, ' TABELA.CTR_DTAVEN ',
                ' IF(fRetProxDiaUtil(TABELA.CTR_DTAVEN) >= CURRENT_DATE, ' +
                '    fRetProxDiaUtil(TABELA.CTR_DTAVEN),                 ' +
                '    TABELA.CTR_DTAVEN)                                  ');
end;

function TfrmMostraDebCtrChq2.fGetSqlTaxaJuros: String;
begin
  Result := '( ( ( ( ' + AnsiReplaceStr(FloatToStr(fCfgSis('JURATR', varDouble)),',','.') + ' / 30 ) * DATEDIFF(CURRENT_DATE, ' + strDtaVen + ') ) )' +
                 ' + ' + AnsiReplaceStr(FloatToStr(fCfgSis('MULATR', varDouble)),',','.') + ' )' + #13 ;
end;

function TfrmMostraDebCtrChq2.fGetSqlTolerancia: String;
begin
  Result := 'IF(DATEDIFF(CURRENT_DATE, ' + strDtaVen + ') > ' + fCfgSis('TOLATR') + ', TRUE, FALSE)' + #13;
end;

function TfrmMostraDebCtrChq2.fGetSqlValorJuros(strValDup: String): String;
begin
  Result := 'IF((' + strValDup + ' > 0.00) AND ' + fGetSqlTolerancia + ' AND (' + strDtaVen + ' < CURRENT_DATE), ' +
            '   CONVERT((' + strValDup + ' * ( ' + fGetSqlTaxaJuros + ' / 100 ) ), DECIMAL(15,2)) , ' +
                    ' IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0.00))' + #13;
end;

function TfrmMostraDebCtrChq2.fRetDupSel: String;
var
  LResultado : String;
begin
  Result := '';

  cdsTemporaria2.Filtered := False;
  cdsTemporaria2.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
  cdsTemporaria2.Filtered := True;

  cdsTemporaria2.First;

  While (Not cdsTemporaria2.Eof) Do
  Begin
    LResultado := cdsTemporaria2.FieldByName('DUPLICATAS_CARREGADAS').AsString;

    Result := Result + LResultado;

    If cdsTemporaria2.RecNo < cdsTemporaria2.RecordCount Then
      Result := Result + ', ';

    cdsTemporaria2.Next;
  End;

  If fEmptyStr(Result) Then
    Result := QuotedStr('%');
end;

function TfrmMostraDebCtrChq2.fRetAutoincremDuplicatas: String;
Begin

  Result := '';
  cdsTemporaria2.First;

  While (Not cdsTemporaria2.Eof) Do
  Begin

    Application.ProcessMessages;

    Result := Result + '"' + cdsTemporaria2.FieldByName('AUTOINCREM_CADREC').AsString + '"';

    If cdsTemporaria2.RecNo < cdsTemporaria2.RecordCount Then
      Result := Result + ', ';

    cdsTemporaria2.Next;
  End;

  cdsTemporaria2.First;
End;

procedure TfrmMostraDebCtrChq2.dbgDuplicatasDadosColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  cdsTemporaria2.AfterScroll := Nil;
  inherited;
  If Not cdsTemporaria2.IsEmpty Then
    cdsTemporaria2.IndexFieldNames := TcxGridDBColumn(AColumn).DataBinding.FieldName;

  cdsTemporaria2.AfterScroll := pAtualizaDados;
end;

procedure TfrmMostraDebCtrChq2.dbgDuplicatasDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  function fGetValue(strField: String): Variant;
  begin
    Result := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDados.GetColumnByFieldName(strField).Index];
  end;
begin
  inherited;

  If (Not cdsTemporaria2.Active) Then
    Exit;

  If VarToStr(fGetValue('CTR_MARDES')) = 'M' Then
  Begin
    ACanvas.Font.Color := clBlue;
    ACanvas.FillRect(AViewInfo.Bounds);
  End;

  If (not fEmptyStr(cdsTemporaria2.IndexFieldNames)) and
     (Pos(';',cdsTemporaria2.IndexFieldNames) <= 0) Then
  Begin
    If AViewInfo.Item.Index = dbgDuplicatasDados.GetColumnByFieldName(cdsTemporaria2.IndexFieldNames).Index Then
    Begin
      ACanvas.Brush.Color := clInfoBk;
      ACanvas.Font.Color  := clWindowText;
      ACanvas.FillRect(AViewInfo.Bounds);
    End;
  End;

  If ACanvas.Brush.Color = clHighLight Then
    ACanvas.Brush.Color := clLtGray;

  If (AViewInfo.Item.Caption = 'Dt. Ven.') And
     (VarToDateTime(fGetValue('CTR_DTAVEN')) < VS_Date) And
     (VarIsNull(fGetValue('CTR_DTAREC'))) Then
  Begin
    ACanvas.Font.Color  := clRed;
    ACanvas.Font.Style  := [fsBold];
    ACanvas.FillRect(AViewInfo.Bounds);
  End;

  If (AViewInfo.Item.Caption = 'Situação') And
     (VarToStr(fGetValue('SITUACAO')) = 'A') Then
  Begin
    ACanvas.Font.Color  := clRed;
    ACanvas.Font.Style  := [fsBold];
    ACanvas.FillRect(AViewInfo.Bounds);
  End;

  If (AViewInfo.Item.Caption = 'Situação') And
     (VarToStr(fGetValue('SITUACAO')) = 'B') Then
  Begin
    ACanvas.Font.Color  := clGreen;
    ACanvas.Font.Style  := [fsBold];
    ACanvas.FillRect(AViewInfo.Bounds);
  End;
end;

procedure TfrmMostraDebCtrChq2.dtsTemporaria2DataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btnAcompEntrega.Enabled := not dtsTemporaria2.DataSet.IsEmpty;
end;

procedure TfrmMostraDebCtrChq2.dbgChequesTitleClick(Column: TColumn);
begin
  inherited;

  If Not cdsTemporaria3.IsEmpty Then
    cdsTemporaria3.IndexFieldNames := Column.FieldName;

  pSetFocus(dbgCheques);

end;

procedure TfrmMostraDebCtrChq2.dbgChequesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If Column.FieldName = cdsTemporaria3.IndexFieldNames Then
  Begin
    dbgCheques.Canvas.Brush.Color := clInfoBk;
    dbgCheques.Canvas.Font.Color  := clWindowText;
    dbgCheques.Canvas.FillRect(Rect);
    dbgCheques.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmMostraDebCtrChq2.btnObsDocClick(Sender: TObject);
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  inherited;

  Try
    qryGenGer := fCriaQuery;

    {*****************************}
    {* CARREGA OBS DO MOVGER/X   *}
    {**************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_MEN001, ';
    strSQL := strSQL + '  GER_MEN002, ';
    strSQL := strSQL + '  GER_MEN003, ';
    strSQL := strSQL + '  GER_MEN004, ';
    strSQL := strSQL + '  GER_MEN005 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := cdsTemporaria2.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('ESPDOC').AsString := cdsTemporaria2.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsTemporaria2.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := cdsTemporaria2.FieldByName('CTR_CODCLI').AsString;
      Open;

      If Not IsEmpty Then
      Begin

        Try
          pCriarFormularios(TfrmObservacao, frmObservacao);
          frmObservacao.lblMensagem.Caption := 'Observação da Duplicata: ' + cdsTemporaria2.FieldByName('NUMDUP').AsString;
          frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN001').asString);
          frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN002').asString);
          frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN003').asString);
          frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN004').asString);
          frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN005').asString);
          frmObservacao.ShowModal;
        Except
         On E: Exception Do
           pMensagensErro(E.Message, '[btnObsDocClick]');
        End;
        pFreeAndNil(frmObservacao);

      End
      Else
        fMensagem('ATENÇÃO!', 'Este documento não possui observação!', ['&Ok']);

    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmMostraDebCtrChq2.btnRelatorioClick(Sender: TObject);
var
  frmRelCtrDebitosCliente: TfrmRelCtrDebitosCliente;

  LCheckBoxSelecionados: TCheckBoxMostraDebCtrChq2;

  LVariaveisFiltro: TVariaveisMostraDebCtrChq2;
begin
  inherited;

  Try
    pCriarFormularios(TfrmRelCtrDebitosCliente, frmRelCtrDebitosCliente);

    frmRelCtrDebitosCliente.chkDtaVen.Checked := blnDtaVen;
    frmRelCtrDebitosCliente.chkAjuDta.Checked := blnAjuDta;

    frmRelCtrDebitosCliente.Height             := 252;
    frmRelCtrDebitosCliente.rdgOrdem.Enabled   := True;
    frmRelCtrDebitosCliente.rdgOrdem.ItemIndex := 0;

    LVariaveisFiltro.Ordem := FOrdemRelatorio;
    If frmRelCtrDebitosCliente.ShowModal = mrOk Then
    Begin
      bChkContaCorrente    := frmRelCtrDebitosCliente.chkContaCorrente.Checked;
      bChkProduto          := frmRelCtrDebitosCliente.chkProduto.Checked;
      bChkCheque           := frmRelCtrDebitosCliente.chkCheque.Checked;
      bChkObservacao       := frmRelCtrDebitosCliente.chkObservacao.Checked;
      bChkJuros            := frmRelCtrDebitosCliente.chkJuros.Checked;
      bDocAgrup            := frmRelCtrDebitosCliente.chkDocAg.Checked;
      blnDtaVen            := frmRelCtrDebitosCliente.chkDtaVen.Checked;
      blnAjuDta            := frmRelCtrDebitosCliente.chkAjuDta.Checked;
      blnkEndEre           := frmRelCtrDebitosCliente.chkEndEre.Checked;
      bChkBancoDoBoleto    := frmRelCtrDebitosCliente.chkBancoDoBoleto.Checked;
      bChkNumPedFF         := frmRelCtrDebitosCliente.chkNumPedFF.Checked;
      FExibirCredito       := frmRelCtrDebitosCliente.chkCredito.Checked;
      FOrdemRelatorio      := frmRelCtrDebitosCliente.rdgOrdem.ItemIndex;

      LCheckBoxSelecionados.ContaCorrente := bChkContaCorrente;
      LCheckBoxSelecionados.Produto := bChkProduto;
      LCheckBoxSelecionados.Cheque := bChkCheque;
      LCheckBoxSelecionados.Observacao := bChkObservacao;
      LCheckBoxSelecionados.Juros := bChkJuros;
      LCheckBoxSelecionados.DocAg := bDocAgrup;
      LCheckBoxSelecionados.DtaVen := blnDtaVen;
      LCheckBoxSelecionados.AjuDta := blnAjuDta;
      LCheckBoxSelecionados.EndEre := blnkEndEre;
      LCheckBoxSelecionados.BancoDoBoleto := bChkBancoDoBoleto;
      LCheckBoxSelecionados.NumPedFF := bChkNumPedFF;
      LCheckBoxSelecionados.Credito := FExibirCredito;

      FMostraDebCtrChq2Obj.SetCheckBoxSelecionados(LCheckBoxSelecionados);

      LVariaveisFiltro.RedeLoja := strRedLoj;
      LVariaveisFiltro.TipoFiltro := strTipFil;
      LVariaveisFiltro.CodigoCliente := strCodCli;
      LVariaveisFiltro.CodigoPortador := strCodPor;
      LVariaveisFiltro.ArrPortador := arrPort;
      LVariaveisFiltro.MensagemRelatorio := strMensagemRel;
      LVariaveisFiltro.cdsTemporaria2 := cdsTemporaria2;
      LVariaveisFiltro.cdsTemporaria3 := cdsTemporaria3;
      LVariaveisFiltro.Ordem          := FOrdemRelatorio;
      LVariaveisFiltro.ConsideraRepassados := fCfgSis('CHQNVT', varBoolean);
      LVariaveisFiltro.Vencidos := blnVencidos;

      FMostraDebCtrChq2Obj.CarregaOutrasVariaveis(LVariaveisFiltro);

      pGeraEmail(True);
    End;

  Finally
    pFreeAndNil(frmRelCtrDebitosCliente);

    pSetFocus(dbgDuplicatas);
  End;

end;

procedure TfrmMostraDebCtrChq2.btnMarcarTudoClick(Sender: TObject);
begin
  pMarcarDesmarcarTudo(True);
end;

procedure TfrmMostraDebCtrChq2.pMarcarDesmarcarTudo(blnMarcar: Boolean);
  Var
    bkmRegistro: TBookmark;
begin
  inherited;
  Screen.Cursor := crHourGlass;

  If cdsTemporaria2.IsEmpty Then
    Exit;

  stlListSelecao.clear;

  cdsTemporaria2.AfterScroll := Nil;
  bkmRegistro := cdsTemporaria2.GetBookmark;

  cdsTemporaria2.DisableControls;


  cdsTemporaria2.First;
  While (Not cdsTemporaria2.Eof) Do
  Begin
    cdsTemporaria2.Edit;
    cdsTemporaria2.FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');

    If blnMarcar = True Then
       AdicionaListaSelecao( cdsTemporaria2.FieldByName('AUTOINCREM_CADREC').AsString );

    cdsTemporaria2.Post;
    cdsTemporaria2.Next;
  End;

  cdsTemporaria2.GotoBookmark(bkmRegistro);

  cdsTemporaria2.EnableControls;

  cdsTemporaria2.AfterScroll := pAtualizaDados;

  Screen.Cursor := crDefault;
end;

procedure TfrmMostraDebCtrChq2.btnDesmarcarTudoClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTudo(False);
end;

procedure TfrmMostraDebCtrChq2.pMarcarDuplicata;
begin
  cdsTemporaria2.AfterScroll := Nil;

  cdsTemporaria2.Edit;

  If cdsTemporaria2.FieldByName('CTR_MARDES').AsString = 'M' Then
  Begin
    cdsTemporaria2.FieldByName('CTR_MARDES').AsString := 'D';
    RemoveDaListaSelecao( cdsTemporaria2.FieldByName('AUTOINCREM_CADREC').AsString );
  End
  Else
  Begin
    cdsTemporaria2.FieldByName('CTR_MARDES').AsString := 'M';
    AdicionaListaSelecao( cdsTemporaria2.FieldByName('AUTOINCREM_CADREC').AsString );
  End;

  cdsTemporaria2.Post;

  cdsTemporaria2.AfterScroll := pAtualizaDados;
  cdsTemporaria2.AfterScroll(cdsTemporaria2);
end;

procedure TfrmMostraDebCtrChq2.pConsultaBoleto;
begin
  inherited;

  If Assigned(objDocumento) Then
  Begin
    if (not fTemPermissaoAcessarDocumento) then
      Exit;

    If objDocumento.fImprimeBoleto(cdsTemporaria2.FieldByName('SEQDUP').AsString) Then
    Begin
      cdsTemporaria2.Edit;
      cdsTemporaria2.FieldByName('CTR_BOLETO').AsString   := 'Sim';

      If objDocumento.fGetVencimentoAlterado Then
      Begin
        cdsTemporaria2.FieldByName('JUROS').AsFloat         := 0;
        cdsTemporaria2.FieldByName('DIASATRASO').AsInteger  := 0;
        cdsTemporaria2.FieldByName('CTR_DTAVEN').AsDateTime := objDocumento.fGetVencimento;
        cdsTemporaria2.FieldByName('VALORI').AsFloat        := objDocumento.fGetValorCorrigido;
        cdsTemporaria2.FieldByName('CTR_VALCAL').AsFloat    := objDocumento.fGetValorCorrigido;
      End;

      cdsTemporaria2.Post;

    End;
  End;

end;

procedure TfrmMostraDebCtrChq2.pConsultaNotaFiscal;
begin
  inherited;

  If Assigned(objDocumento) Then
  begin
    if (not fTemPermissaoAcessarDocumento) then
      Exit;

    objDocumento.pImprimeNotaFiscal(cdsTemporaria2.FieldByName('SEQDUP').AsString, False);
  end;
end;

procedure TfrmMostraDebCtrChq2.PreencherTotalizadores;
begin
  If Not cdsTemporaria2.IsEmpty Then
  Begin
    If strTipFil = 'A' Then
    Begin

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_VALORI')).Value <> Null Then
        edtDupOri.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_VALORI')).Value, ffNumber, 12, 2);

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_VALJUR')).Value <> Null Then
        edtJurRec.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_VALJUR')).Value, ffNumber, 12, 2);

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_VALCAL')).Value <> Null Then
        edtCorDif.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_VALCAL')).Value, ffNumber, 12, 2);

    End
    Else
    Begin

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_VALCAL')).Value <> Null Then
        edtDupOri.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_VALCAL')).Value, ffNumber, 12, 2);

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_VALREC')).Value <> Null Then
        edtJurRec.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_VALREC')).Value, ffNumber, 12, 2);

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_DIFERE')).Value <> Null Then
        edtCorDif.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_DIFERE')).Value, ffNumber, 12, 2);

      If TAggregateField(cdsTemporaria2.FieldByName('TOT_VALORI')).Value <> Null Then
        edtDupCor.Text := FloatToStrF(TAggregateField(cdsTemporaria2.FieldByName('TOT_VALORI')).Value, ffNumber, 12, 2);

    End;

  End
  Else
  Begin
    edtDupOri.Text := '0,00';
    edtJurRec.Text := '0,00';
    edtCorDif.Text := '0,00';
  End;
end;

procedure TfrmMostraDebCtrChq2.PropertiesButtonBoletoClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pConsultaBoleto;
end;

procedure TfrmMostraDebCtrChq2.PropertiesButtonNFClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pConsultaNotaFiscal;
end;

procedure TfrmMostraDebCtrChq2.PropertiesButtonAnexosClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pChamaAnexos;
end;

procedure TfrmMostraDebCtrChq2.pChamaAnexos;
Begin
  inherited;

  If fEmptyStr(cdsTemporaria2.FieldByName('SEQDUP').AsString) Then
     Exit;

  If Assigned(objDocumento) Then
  Begin
    if (not fTemPermissaoAcessarDocumento) then
      Exit;

     objDocumento.pChamaAnexos( cdsTemporaria2.FieldByName('SEQDUP').AsString,
                                cdsTemporaria2.FieldByName('CTR_CODCLI').AsString,
                                cdsTemporaria2.FieldByName('CTR_CODEMP').AsString );
  End;

End;

function TfrmMostraDebCtrChq2.fTemRegistrosMarcados : Boolean;
Var
  cdsMarc : TUniClientDataSet;
Begin
  cdsMarc := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsMarc, cdsTemporaria2);

  cdsMarc.Filtered := False;
  cdsMarc.Filter := ' CTR_MARDES = ' + QuotedStr('M');
  cdsMarc.Filtered := True;

  Result := cdsMarc.RecordCount > 0;

  FreeAndNil(cdsMarc);
End;

end.
