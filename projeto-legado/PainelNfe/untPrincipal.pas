unit untPrincipal;

interface
{$WARN SYMBOL_DEPRECATED OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, ImgList, DB, Math, ActiveX, DateUtils,
  untInterfaces, Buttons, madExceptVcl, StrUtils,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxRibbon, dxBar,
  dxBarExtItems, cxImage, cxSpinEdit, cxContainer, cxTextEdit,
  cxMemo, cxProgressBar, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxEditRepositoryItems, cxLabel, cxMaskEdit,

  {$IF Defined(UNIDAC)}
  Uni, UniSQLMonitor, DBAccess, System.Generics.Collections,
  {$ELSE}
  ZDataset,
  {$IFEND}

  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList, System.ImageList,
  {$ENDIF}

  untTestabilidade, untLogAut;

Type
  TImprimirPDFBrowser = class(TInterfacedObject, IVirtualUIPrintPDF)
    public
      procedure PrintPDF(strFileName: String);
  end;

type
  TfrmPrincipal = class(TForm)
    pnlCentral: TPanel;
    dbgDocumentosView: TcxGridDBTableView;
    dbgDocumentosLevel1: TcxGridLevel;
    dbgDocumentos: TcxGrid;
    NFE_STATUS: TcxGridDBColumn;
    NFE_NUMDOC: TcxGridDBColumn;
    NFE_ESPDOC: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarGroup1: TdxBarGroup;
    mnuBarraPrincipal: TdxBar;
    btnReenviar: TdxBarLargeButton;
    btnSair: TdxBarLargeButton;
    btnAtualizar: TdxBarLargeButton;
    mnuBarraConfig: TdxBar;
    edtQtdUltNot: TdxBarSpinEdit;
    edtRefresh: TdxBarSpinEdit;
    dxBarStatic1: TdxBarStatic;
    NFE_SERIE_: TcxGridDBColumn;
    NFE_HORINI: TcxGridDBColumn;
    NFE_ENTSAI: TcxGridDBColumn;
    NFE_DESTIN: TcxGridDBColumn;
    NFE_NOMCLI: TcxGridDBColumn;    
    NFE_DTAAUT: TcxGridDBColumn;
    dtsDocumentos: TDataSource;
    cxEditRepository1: TcxEditRepository;
    NFE_STATUS_DESC: TcxGridDBColumn;
    imgImagens: TcxImageList;
    cmbStatusDesc: TcxEditRepositoryImageComboBoxItem;
    tmrAtualizar: TTimer;
    tmrStatus: TTimer;
    mnuStatus: TdxBar;
    btnConfigurar: TdxBarLargeButton;
    btnAjustarMotivo: TdxBarLargeButton;
    cmbStatusImg: TcxEditRepositoryImageComboBoxItem;
    tmrFechaSistema: TTimer;
    btnAjustarConsumidor: TdxBarLargeButton;
    btnAlterarNCM: TdxBarLargeButton;
    btnStatusSefaz: TdxBarLargeButton;
    FIS_ACESSO: TcxGridDBColumn;
    NFE_PONIMP: TcxGridDBColumn;
    tmrStatusSefaz: TTimer;
    pnlRodape: TPanel;
    pnlStatusSefaz: TPanel;
    lblStatus: TLabel;
    dxBarSubItem1: TdxBarSubItem;
    mnuReimpressao: TdxBarButton;
    edtQtdDiasNfAut: TdxBarSpinEdit;
    dxBarStatic2: TdxBarStatic;
    tmrPendenciaDPEC: TTimer;
    btnAlterarEReenviar: TdxBarButton;
    edtTamLote: TdxBarSpinEdit;
    edtApgTmp: TdxBarSpinEdit;
    dxBarStatic3: TdxBarStatic;
    pnlCorrigirDevolucao: TPanel;
    btnCorrigirDevolucao: TBitBtn;
    pnlDadosExp: TPanel;
    btnDadosExp: TBitBtn;
    NFE_CODEMP: TcxGridDBColumn;
    NFE_CODCLI: TcxGridDBColumn;
    NFE_TIP_FC: TcxGridDBColumn;
    btnReenviarTodas: TdxBarButton;
    cxLabel1: TcxLabel;
    btnReimpressao: TdxBarLargeButton;
    btnAlterarEReenviarTodas: TdxBarButton;
    Panel1: TPanel;
    memMsg: TcxMemo;
    memTarefas: TcxMemo;
    pnlRetISS: TPanel;
    btnRetISS: TBitBtn;
    tmrConhecimentoTe: TTimer;
    tmrPainelCitel: TTimer;
    btnNCMItemEsp: TBitBtn;
    tmrPainelCitelCorrecao: TTimer;
    pnlAFIgnorarImpressao: TPanel;
    btnAFIgnorarImpressao: TBitBtn;
    pnlAFImprimir: TPanel;
    btnAFImprimir: TBitBtn;
    edtTextoEntSai: TcxEditRepositoryTextItem;
    tmrConsultaCadastro: TTimer;
    tmrDFeTerceiros: TTimer;
    tmrLiberaSeqDoc: TTimer;
    tmrECONF: TTimer;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAtualizarClick(Sender: TObject);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure edtRefreshChange(Sender: TObject);
    procedure tmrStatusTimer(Sender: TObject);
    procedure qryDocumentosAfterScroll(DataSet: TDataSet);
    procedure btnReenviarClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnAjustarMotivoClick(Sender: TObject);
    procedure edtQtdUltNotChange(Sender: TObject);
    procedure tmrFechaSistemaTimer(Sender: TObject);
    procedure btnAjustarConsumidorClick(Sender: TObject);
    procedure btnAlterarNCMClick(Sender: TObject);
    procedure btnStatusSefazClick(Sender: TObject);
    procedure lblSefazOperacionalClick(Sender: TObject);
    procedure lblSefazForaClick(Sender: TObject);
    procedure tmrStatusSefazTimer(Sender: TObject);
    procedure edtQtdDiasNfAutChange(Sender: TObject);
    procedure tmrPendenciaDPECTimer(Sender: TObject);
    procedure btnAlterarEReenviarClick(Sender: TObject);
    procedure edtTamLoteChange(Sender: TObject);
    procedure edtApgTmpChange(Sender: TObject);
    procedure btnCorrigirDevolucaoClick(Sender: TObject);
    procedure btnDadosExpClick(Sender: TObject);
    procedure edtQtdUltNotExit(Sender: TObject);
    procedure btnReenviarTodasClick(Sender: TObject);
    procedure btnReimpressaoClick(Sender: TObject);
    procedure btnAlterarEReenviarTodasClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure btnRetISSClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConhecimentoTeTimer(Sender: TObject);
    procedure tmrPainelCitelTimer(Sender: TObject);
    procedure dbgDocumentosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnNCMItemEspClick(Sender: TObject);
    procedure tmrPainelCitelCorrecaoTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAFImprimirClick(Sender: TObject);
    procedure btnAFIgnorarImpressaoClick(Sender: TObject);
    procedure tmrConsultaCadastroTimer(Sender: TObject);
    procedure tmrDFeTerceirosTimer(Sender: TObject);
    procedure tmrLiberaSeqDocTimer(Sender: TObject);
    procedure tmrECONFTimer(Sender: TObject);
  private
    { Private declarations }
    {$IF Defined(UNIDAC)}
    dicExisteIteEsp: TDictionary<string, string>;
    {$IFEND}
    strExisteCampoDET_NCMITE: String;
    FPonImp: String;
    blnMsgParalisadoSemPrevisao: boolean;
    intLockAtualizar: Integer;
    intLockReenviar: Integer;
    qryDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strUltimoSQL: String;
    strIdConexao: String;
    blnEmlCon: Boolean;
    strSenhaReimpres: String;
    strSenhaReterISS: String;
    blnInicializandoPainel: Boolean;
    blnPainelAtivo: Boolean;
    blnForcandoCorrecaoPainelWebCitel: Boolean;
    blnEmiteCTe: Boolean;
    objLogAut : TLogAut;
    blnAtualizaPOSNABDeFormaAutomatica : Boolean;
    blnModoClassico: Boolean;
    dtaUltimoProcessTarefa: TDateTime;
    dtaUltimaAtualizTarefa: TDateTime;
    dtaUltimaVeriNfeStatus: TDateTime;
    dtaUltimaLimpezaDicSis: TDateTime;
    dtaUltimaUltComplemDoc: TDateTime;
    dtaUltimaUltAuditarDoc: TDateTime;
    intTotPen: Integer;
    intTotErr: Integer;
    blnXMLTerceiros: Boolean;
    blnXMLTerceirosSomenteBucket: Boolean;

    function fEstaEmModoAtualizacaoPainelWebCitel: Boolean;
    function fEstaEmModoEmissaoNotaServicoCitel: Boolean;

    procedure pAtualizarDocumentos;
    procedure pHabilitarBotoes;
    procedure pReenviarDocumento;
    procedure pAlterarNCMDosItens;

    procedure pParalisadoMomentaneamente;
    procedure pParalisadoSemPrevisao;
    procedure pCorrigeAbfItens(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
    procedure pCorrigeHoraSaida(strTabela, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
    procedure pCorrigePisCofins(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
    procedure pAtualizaPontoImpressao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strPonImp: String);
    function fRetornaDataDeCorte: TDateTime;
    procedure pAlterarStatusEReenviar;

    function fTemNotasPendentesParaCoordenacao: Boolean;
    function fTemCoordenadorStatusNFeAtivo: Boolean;

    procedure pAtualizarTarefasSendoExecutadas;
    procedure pVerificaCondicaoCoordenadorStatusNFe;

    function fInicializaPainel(pgbSts: TcxProgressBar): Boolean;

    procedure pTarefasBasicas;
    procedure pTarefasPainelCitel(const strStatus: String);
    procedure pTarefasCoordenador;

    procedure OnClickSefazDPEC(Sender: TObject);

    procedure pAtualizarDocumentoReferenciadoDigitado(strChave, strNumCoo, strNumSer,
      strNumUsu, strNumero, strSerie_, strModelo, strCPFCNP,
      strEstado, strMesAno: String);
    procedure pAtualizarDocumentoReferenciadoAutcom(strNumDoc, strEspDoc, strCodEmp: String);

    procedure pInsereDadosExportacao(strAutoincremCadFis, strUFEmba, strLoEmba, strLocDes: String);
    function fNaoPossuiDocumentoReferenciado: Boolean;
    function fDocumentoReferenciadoNaoPossuiSerie: Boolean;
    function fNFeComplementarNaoPossuiDocumentoReferenciado: Boolean;
    procedure pAcertaSerieDocumentoReferenciado;
    function fSefazParalizado: Boolean;
    procedure pAtualizaGrid(blnFocar: Boolean);
    function fDentroDoEstado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String) : Boolean;
    function fRetornaTabelaNota(strAutIncMOVGER, strAutIncNOTGER: string; var strTblNota: string): string;
    function fDocumentoRetemISS(strAutIncMOVGER, strAutIncNOTGER: string): Boolean;
    function fAjustaRetISS(strAutIncMOVGER, strAutIncNOTGER, strCodCli, strRetISS: string): Boolean;
    procedure pEmitirCTe;
    function fValidaIEDestNaoInformada(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String) : Boolean;
    function fValidaContribuinteIsentoDeInscrEstadual(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String) : Boolean;
    function fInstalarMicrosoftVisualC: Boolean;
    procedure pInstaladorMicrosoftVisualC;
    function fInstaladorMicrosoftVisualC(pgbSts: TcxProgressBar): Boolean;
    procedure pCorrigirNCMItemEspecial;
    procedure pBuscaItemEspecialDoc(var qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    function fExisteItemEspecial: Boolean;
    procedure pForcarCorrecaoPainelWebCitel;
    procedure pImprimirAF(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strAcesso: String);
    procedure pCorrigeAF(AImprimir: Boolean);
    function fExisteLicencaFIT: Boolean;
    function fUsaNotaDeServicoEnotas: Boolean;
    function fUsaApenasNotaDeServicoEnotas: Boolean;
    function fDocumentoEmProcessamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String): Boolean;
    function fPainelVazio: Boolean;
    procedure pAtualizarTituloDoPainel;
    procedure pAtualizarPOSNAB;
    function fUsaDocumentoFiscalEletronico : Boolean;
    procedure pComplementarMensagemDeErro(const strErro, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_FC, strSerie : String);
    function fUltimoRetornoDoDocumento(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_FC, strSerie : String) : String;
    procedure pAjustaHints;

    procedure pVerificaPrecisaLimparDicSis;
    function fExecutaServicoLimparDanfes: Boolean;
    function fExecutaServicoImportaXMLTerceiros: Boolean;
    function fExecutaServicoEnviarXMLSat(const strCodEmp: String): Boolean;
    function fExecutaServicoConfirmarXMLGravacao(const strCodEmp: String): Boolean;
    function fExecutaServicoPendenciasDPEC(const strCodEmp: String): Boolean;
    function fExecutaServicoConsultaCadastroDestinatario(const strCodEmp: String): Boolean;
    function fExecutaServicoConsultaCadastroEmitente(const strCodEmp: String): Boolean;
    function fExecutaServicoComplementarDocumento: Boolean;
    function fExecutaServicoAuditarDocumento: Boolean;
    function fExecutaServicoEventoConciliacaoFinanceira: Boolean;
    function fIntervaloDaConsultaCadastral : Integer;
    procedure pAtualizarStatusConsultaCadastro(const strCodEmp : String);
    procedure pDesligaTodosOsTimers;
    procedure pEncerrarForcado;
    procedure pDefineEmpresa;
    function fConfigurou(resultInicial: Boolean=True; blnReinciar: Boolean=True): Boolean;
    function fPodeExecutarFuncaoDoTimer: Boolean;

    function fExistefReprocessaMOVREF: Boolean;
    function fExistefReprocessaNOTREF: Boolean;
    function fReprocessaDadosReformaTributaria: Boolean;
    function fRetornaAutoincremMOVGER(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC: String): String;
    function fRetornaAutoincremNOTGER(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC: String): String;
    procedure pReprocessaMOVREF(strAutoInc: String);
    procedure pReprocessaNOTREF(strAutoInc: String);
    procedure pReprocessaDadosReformaTributaria(strNumDoc, strEspDoc, strCodEmp, strSerie, strForCli, strTip_FC: String);
    procedure pCorrigeNCMItens(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
    function fTemSeqDocParaLiberar : Boolean;
    procedure pLiberarSeqDoc;
  public
    { Public declarations }
  published
    objTestabilidade: TTestabilidade;
  end;

var
  frmPrincipal: TfrmPrincipal;
  VS_blnUsaFin: Boolean;
  VS_dtaHraFin: TTime;
  FEmissaoNotaServicoCitel: String;

implementation

uses
  {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}
  System.UITypes,
  {$IFEND}
  untUtil, untModulo, untLibNfe, untConfiguracoes, untDigDadConsumidor,
  untAlterarNCMTintas, untSefazParalisado, untGravando, untFatDigChaveDev,
  untConfigNFE, untSelDocumentosReferenciar, untDadosExportacao, untConectando,
  VirtualUI_SDK, untDigNCMItemEspecial, untDicSis, untLogDanfe, untSelEmp;

{$R *.dfm}

function fExecutaComandoNFeStatus(const strCmd: String): Boolean;
begin
  Result := True;

  If (VS_ExecutarApenasTarefasPainelWebCitel = 'S') Then
    If (Pos('NFE_PAINEL_CITEL', strCmd) = 0) Then
      Result := False;
end;

procedure pNFeStatus(strCmd: String);
  Var
    strExe: String;
    strTagCodEmp: String;
begin
  If (fExecutaComandoNFeStatus(strCmd)) Then
  Begin
    strExe := ExtractFilePath(Application.ExeName) + 'NFeStatus.exe';

    //COMPLEMENTA COM PARÂMETRO DE EMPRESA. NÃO PRECISA PASSAR POR FORA...
    strTagCodEmp := fTagComValorToParam(VS_strCodEmp, consTagParamsEmp);

    If (Pos(strTagCodEmp, strCmd) = 0) Then
      strCmd := strCmd + strTagCodEmp;
    //...COMPLEMENTA COM PARÂMETRO DE EMPRESA. NÃO PRECISA PASSAR POR FORA

    strCmd := strCmd + fTagComValorToParam(VS_PidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

    StartProcess(strExe, strCmd, False, False);
  End;
end;

procedure TfrmPrincipal.btnConfigurarClick(Sender: TObject);
begin
  fConfigurou;
end;

procedure TfrmPrincipal.btnCorrigirDevolucaoClick(Sender: TObject);
  Var
    blnOpcaoDocOuDigitado: Boolean;
    blnChaveDigitada: Boolean;
    blnCooDigitado: Boolean;
    blnNumDigitado: Boolean;
begin
  Try
    tmrAtualizar.Enabled := False;

    If fDocumentoReferenciadoNaoPossuiSerie Then
    Begin
      pAcertaSerieDocumentoReferenciado;
    End
    Else
    Begin
      blnOpcaoDocOuDigitado := False;
      blnChaveDigitada := False;
      blnCooDigitado := False;
      blnNumDigitado := False;

      If fTabelaExiste('AUXMOV') Then
      Begin
        If fCampoExiste('AUXMOV', 'AUX_CHVNFE') Then
        Begin
          blnChaveDigitada := True;
        End;

        If fCampoExiste('AUXMOV', 'AUX_NUMCOO') Then
        Begin
          blnCooDigitado := True;
        End;

        If fCampoExiste('AUXMOV', 'AUX_NUMERO') Then
        Begin
          blnNumDigitado := True;
        End;

        blnOpcaoDocOuDigitado := blnChaveDigitada Or blnCooDigitado Or blnNumDigitado;
      End;

      If blnOpcaoDocOuDigitado Then
      Begin
        blnOpcaoDocOuDigitado := MessageDlgCaptions('O documento referenciado está cadastrado no Autcom?', mtConfirmation, [mbYes, mbNo], ['Sim', 'Não'], 'Confirmação') = mrNo;
      End;

      If blnOpcaoDocOuDigitado Then
      Begin
        Application.CreateForm(TfrmFatDigChaveDev, frmFatDigChaveDev);
        Try
          frmFatDigChaveDev.blnChaveDigitada := blnChaveDigitada;
          frmFatDigChaveDev.blnCooDigitado := blnCooDigitado;
          frmFatDigChaveDev.blnNumDigitado := blnNumDigitado;
          If frmFatDigChaveDev.ShowModal = mrOk Then
          Begin
            pAtualizarDocumentoReferenciadoDigitado(frmFatDigChaveDev.edtChave.Text,
              frmFatDigChaveDev.edtNumCOO.Text,
              frmFatDigChaveDev.edtNumSer.Text,
              frmFatDigChaveDev.edtCodNSU.Text,
              frmFatDigChaveDev.edtNumA1.Text,
              frmFatDigChaveDev.edtSerA1.Text,
              frmFatDigChaveDev.edtModA1.Text,
              fTiraCaracEspeciaisPonto(frmFatDigChaveDev.edtCPFA1.Text),
              frmFatDigChaveDev.cbbEstA1.Text,
              FormatDateTime('YYMM', StrToDateDef('01/' + frmFatDigChaveDev.mskDatA1.Text, 0)));

            pMensagemOk('Atualização concluída. A nota será reenviada.');

            pSetFocus(dbgDocumentos);
            btnReenviar.Click;
          End;
        Finally
          FreeAndNil(frmFatDigChaveDev);
        End;
      End
      Else
      Begin
        Application.CreateForm(TfrmSelDocumentosReferenciar, frmSelDocumentosReferenciar);

        Try
          frmSelDocumentosReferenciar.strCliFor := qryDocumentos.FieldByName('NFE_CODCLI').AsString;
          frmSelDocumentosReferenciar.strNomCliFor := qryDocumentos.FieldByName('NFE_NOMCLI').AsString;
          frmSelDocumentosReferenciar.strTipFc := qryDocumentos.FieldByName('NFE_TIP_FC').AsString;
          frmSelDocumentosReferenciar.strAutIncMovGer := qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString;
          frmSelDocumentosReferenciar.strAutIncNotGer := qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString;
          If frmSelDocumentosReferenciar.ShowModal = mrOk Then
          Begin
            pAtualizarDocumentoReferenciadoAutcom(frmSelDocumentosReferenciar.strNumDoc,
                                                  frmSelDocumentosReferenciar.strEspDoc,
                                                  frmSelDocumentosReferenciar.strCodEmp);

            pMensagemOk('Atualização concluída. A nota será reenviada.');

            pSetFocus(dbgDocumentos);
            btnReenviar.Click;
          End;
        Finally
          FreeAndNil(frmSelDocumentosReferenciar);
        End;
      End;
    End;
  Finally
    tmrAtualizar.Enabled := True;
  End;
end;

procedure TfrmPrincipal.btnDadosExpClick(Sender: TObject);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If Not fTabelaExiste('DOCEXP') Then
  Begin
    pMensagemOk('Tabela DOCEXP não existe. Entre em contato com a Citel.');
    Exit;
  End;

  If pos(qryDocumentos.FieldByName('NFE_STATUS').AsString,'EE_DE_') > 0 Then
    Exit;

  If Copy(qryDocumentos.FieldByName('GER_CLAFIS').AsString, 1, 1) <> '7' Then
  Begin
    pMensagemOk('Esta não é uma nota de exportação!');
    Exit;
  End;

  tmrAtualizar.Enabled := False;
  Try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM DOCEXP WHERE EXP_SEQFIS = :EXP_SEQFIS');
    qryAux.ParamByName('EXP_SEQFIS').AsString := qryDocumentos.FieldByName('AUTOINCREM_CADFIS').AsString;
    qryAux.Open;

    Application.CreateForm(TfrmDadosExportacao, frmDadosExportacao);
    Try
      If qryAux.RecordCount > 0 Then
      Begin
        frmDadosExportacao.cbbUFEmba.ItemIndex := frmDadosExportacao.cbbUFEmba.Items.IndexOf(qryAux.FieldByName('EXP_UFEMBA').AsString);
        frmDadosExportacao.edtLoEmba.Text := qryAux.FieldByName('EXP_LOEMBA').AsString;
        frmDadosExportacao.edtLocDes.Text := qryAux.FieldByName('EXP_LOCDES').AsString;
      End;

      If frmDadosExportacao.ShowModal = mrOk Then
      Begin
        pInsereDadosExportacao(qryDocumentos.FieldByName('AUTOINCREM_CADFIS').AsString,
          frmDadosExportacao.cbbUFEmba.Text,
          frmDadosExportacao.edtLoEmba.Text,
          frmDadosExportacao.edtLocDes.Text);

        pMensagemOk('Atualização concluída. A nota será reenviada.');

        pSetFocus(dbgDocumentos);
        btnReenviar.Click;
      End;
    Finally
      FreeAndNil(frmDadosExportacao);
    End;
  Finally
    tmrAtualizar.Enabled := True;
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPrincipal.btnNCMItemEspClick(Sender: TObject);
begin
  pCorrigirNCMItemEspecial;
end;

procedure TfrmPrincipal.pCorrigirNCMItemEspecial;
var
  qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  frmDigNCMItemEspecial: TfrmDigNCMItemEspecial;
begin
  tmrAtualizar.Enabled := False;
  Application.CreateForm(TfrmDigNCMItemEspecial, frmDigNCMItemEspecial);
  qryItens := fCriaQuery(Self);
  try
    pBuscaItemEspecialDoc(qryItens);

    if qryItens.IsEmpty then
    begin
      pMensagemOk('Não existem itens especiais neste documento.');
      Exit;
    end;

    frmDigNCMItemEspecial.cdsItens.SetProvider(qryItens);
    frmDigNCMItemEspecial.cdsItens.Open;
    frmDigNCMItemEspecial.cdsItens.SetProvider(nil);

    if (frmDigNCMItemEspecial.ShowModal = mrOk) then
    begin
      pMensagemOk('Atualização concluída. A nota será reenviada.');
      pSetFocus(dbgDocumentos);
      btnReenviar.Click;
    end;

  finally
    FreeAndNil(frmDigNCMItemEspecial);
    FreeAndNil(qryItens);
    tmrAtualizar.Enabled := True
  end;
end;

procedure TfrmPrincipal.pBuscaItemEspecialDoc(var qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
  Var
    strTblSel: String;
    strSeqGer: String;
begin
  strTblSel := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString), 'MOVDET', 'NOTDET');
  strSeqGer := IfEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString,
                          qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString);

  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Text :=
       'SELECT                                         '+
       '  MOVTRI.DET_NCMITE,                           '+
       '  MOVDET.AUTOINCREM,                           '+
       '  MOVDET.DET_CODITE,                           '+
       '  MOVDET.DET_DESCRI                            '+
       'FROM                                           '+
       '  MOVTRI                                       '+
       '  JOIN MOVDET                                  '+
       '    ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM   '+
       '  JOIN CADITE                                  '+
       '    ON CADITE.ITE_CODITE = MOVDET.DET_CODITE   '+
       'WHERE CADITE.ITE_DESITE LIKE "%ITEM ESPECIAL%" '+
       '  AND MOVDET.DET_SEQGER = :SEQGER              ';

  If (strTblSel = 'NOTDET') Then
  Begin
    qryItens.SQL.Text := AnsiReplaceStr(qryItens.SQL.Text, 'MOVDET', 'NOTDET');
    qryItens.SQL.Text := AnsiReplaceStr(qryItens.SQL.Text, 'MOVTRI', 'NOTTRI');
  End;

  qryItens.ParamByName('SEQGER').AsString := strSeqGer;
  qryItens.Open;
end;

function TfrmPrincipal.fExecutaServicoLimparDanfes: Boolean;
  Var
    dtaDtaSis : TDateTime;
    dtaHraSis : TDateTime;
begin
  Result := False;

  pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);
  //PARA FAZER DEPOIS DO PICO DE ABERTURA
  If (dtaHraSis < StrToTime('08:45:00')) Then
    Exit;

  Result := (Not fDirectoryIsEmpty(fRetornaCaminhoLimparDiretorioDanfe));
end;

function TfrmPrincipal.fExecutaServicoImportaXMLTerceiros: Boolean;
begin
  Result := (blnXMLTerceiros Or blnXMLTerceirosSomenteBucket) And (fTabelaExiste('DFETER'));
end;

function TfrmPrincipal.fExecutaServicoEventoConciliacaoFinanceira: Boolean;
begin
  Result := (fTabelaExiste('ECONFE'));
end;

function TfrmPrincipal.fExecutaServicoEnviarXMLSat(const strCodEmp: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If (fCfgSisPainel('USASAT') <> 'S') Then
    Exit;

  If fCampoExiste('XMLSAT', 'XML_ENVIAD') And
     fCampoExiste('XMLSAT', 'XML_DTAENV') And
     fCampoExiste('XMLSAT', 'XML_HORENV') And
     fCampoExiste('XMLSAT', 'XML_MSGRET') Then
  Begin
    qryAux := fCriaQuery();
    Try
      qryAux.SQL.Add('SELECT COUNT(0) AS PENDEN ');
      qryAux.SQL.Add('  FROM XMLSAT  ');
      qryAux.SQL.Add(' INNER JOIN CADFIS ON AUTOINCREM = XML_SEQFIS  ');
      qryAux.SQL.Add(' WHERE XML_ENVIAD = 0       ');
      qryAux.SQL.Add('   AND FIS_CODEMP = :CODEMP ');

      qryAux.ParamByName('CODEMP').AsString := strCodEmp;

      qryAux.Open;
      Result := (qryAux.FieldByName('PENDEN').AsInteger > 0);
      qryAux.Close;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

function TfrmPrincipal.fExecutaServicoConfirmarXMLGravacao(const strCodEmp: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If (Not fTabelaExiste('XMLCNF')) Then
    Exit;

  qryAux := fCriaQuery();
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT 1 AS PENDEN ');
    qryAux.SQL.Add('  FROM XMLCNF ');
    qryAux.SQL.Add(' INNER JOIN CADFIS ON XMLCNF.CNF_SEQFIS = CADFIS.AUTOINCREM ');
    qryAux.SQL.Add(' INNER JOIN XMLNFE ON XMLNFE.NFE_ACESSO = CADFIS.FIS_ACESSO ');
    qryAux.SQL.Add(' WHERE XMLCNF.CNF_CODEMP = :CODEMP ');
    qryAux.SQL.Add('   AND XMLCNF.CNF_STATUS = "GE" ');
    qryAux.SQL.Add('LIMIT 1 ');

    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;
    If (Not qryAux.IsEmpty) Then
      Result := (qryAux.FieldByName('PENDEN').AsInteger > 0);
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fExecutaServicoPendenciasDPEC(const strCodEmp: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery();
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(0) AS PENDEN ');
    qryAux.SQL.Add('  FROM LOGNFE ');
    qryAux.SQL.Add('  INNER JOIN CADFIS ON FIS_NUMDOC  = NFE_NUMDOC AND ');
    qryAux.SQL.Add('                       FIS_ESPDOC  = NFE_ESPDOC AND ');
    qryAux.SQL.Add('                       FIS_CODEMP  = NFE_CODEMP AND ');
    qryAux.SQL.Add('                       FIS_FORCLI  = NFE_CODCLI AND ');
    qryAux.SQL.Add('                       IFNULL(FIS_SERIE_, "") = IFNULL(NFE_SERIE_, "") ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_DTAENT >= ' + fCurrentDate(Date - 60) + ' AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  FIS_ESPDOC <> "ME" AND ');
    If fCfgSisPainel('USASAT') = 'S' Then
      qryAux.SQL.Add('FIS_ESPDOC <> "IF" AND ');
    qryAux.SQL.Add('  NFE_STATUS NOT IN ("CN", "IN") AND ');
    qryAux.SQL.Add('  NFE_PNDPEC = 1 ');

    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;
    Result := (qryAux.FieldByName('PENDEN').AsInteger > 0);
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fExecutaServicoComplementarDocumento: Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaDtaSis : TDateTime;
    dtaHraSis : TDateTime;
begin
  Result := False;

  pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);
  //PARA NÃO FAZER SÓ DE VIRAR O DIA
  If (dtaHraSis < StrToTime('07:00:00')) Then
    Exit;

  //PARA FAZER DEPOIS DO PICO DE ABERTURA
  If (dtaHraSis >= StrToTime('07:50:00')) And (dtaHraSis <= StrToTime('08:15:00')) Then
    Exit;

  If (dtaUltimaUltComplemDoc > 0) Then
  Begin
    If (DaysBetween(Date+Time, dtaUltimaUltComplemDoc) > 0) Then
      dtaUltimaUltComplemDoc := 0
    Else
      Exit;
  End;
  If (Not fTabelaExiste('XMLNFE')) Then
    Exit;
  If (Not fTabelaExiste('EMPRESAS_NESTE_SERVIDOR')) Then
    Exit;
  If (Not fTabelaExiste('NFEIMP')) Then
    Exit;

  If fCampoExiste('NFE_LOCAL', 'NFE_ULTCPL') And
     fCampoExiste('NFE_LOCAL', 'NFE_HORULT') Then
  Begin
    qryAux := fCriaQuery;
    Try
      qryAux.SQL.Text := 'SELECT CAST(MAX(COALESCE(NFE_ULTCPL, 0)) AS DATETIME) FROM NFE_LOCAL WHERE NFE_CODEMP = "'+VS_strCodEmp+'" AND DATE(NFE_HORULT) = CURRENT_DATE;';
      qryAux.Open;
      If (Not qryAux.IsEmpty) Then
        dtaUltimaUltComplemDoc := qryAux.Fields[0].AsDateTime;
    Finally
      FreeAndNil(qryAux);
    End;

    If (dtaUltimaUltComplemDoc > 0) Then
      Exit;
  End;

  Result := True;

  dtaUltimaUltComplemDoc := Date+Time;
end;

function TfrmPrincipal.fExecutaServicoAuditarDocumento: Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaDtaSis : TDateTime;
    dtaHraSis : TDateTime;
begin
  Result := False;

  pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);
  //PARA NÃO ENCHER O SACO ANTES DAS 7:00
  If (dtaHraSis < StrToTime('07:00:00')) Then
    Exit;

  //PARA FAZER DEPOIS DO PICO DE ABERTURA
  If (dtaHraSis >= StrToTime('07:50:00')) And (dtaHraSis <= StrToTime('08:10:00')) Then
    Exit;

  If (dtaUltimaUltAuditarDoc > 0) Then
  Begin
    If (DaysBetween(Date+Time, dtaUltimaUltAuditarDoc) > 0) Then
      dtaUltimaUltAuditarDoc := 0
    Else
      Exit;
  End;
  If (Not fTabelaExiste('EMPRESAS_NESTE_SERVIDOR')) Then
    Exit;
  If (Not fTabelaExiste('NFEIMP')) Then
    Exit;

  If fCampoExiste('NFE_LOCAL', 'NFE_ULTAUD') And
     fCampoExiste('NFE_LOCAL', 'NFE_HORULT') Then
  Begin
    qryAux := fCriaQuery;
    Try
      qryAux.SQL.Text := 'SELECT CAST(MAX(COALESCE(NFE_ULTAUD, 0)) AS DATETIME) FROM NFE_LOCAL WHERE NFE_CODEMP = "'+VS_strCodEmp+'" AND DATE(NFE_HORULT) = CURRENT_DATE;';
      qryAux.Open;
      If (Not qryAux.IsEmpty) Then
        dtaUltimaUltAuditarDoc := qryAux.Fields[0].AsDateTime;
    Finally
      FreeAndNil(qryAux);
    End;

    If (dtaUltimaUltAuditarDoc > 0) Then
      Exit;
  End;

  Result := True;

  dtaUltimaUltAuditarDoc := Date+Time;
end;

function TfrmPrincipal.fExecutaServicoConsultaCadastroDestinatario(const strCodEmp: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If (Not fCampoExiste('NFE_LOCAL', 'NFE_CONCAD')) Then
    Exit;

  If (Not fTabelaExiste('BLODEN')) Then
    Exit;

  qryAux := fCriaQuery();
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(0) AS PENDEN, ');
    qryAux.SQL.Add('       (SELECT IF(COUNT(0) = 0, "N", "S") FROM NFE_LOCAL WHERE NFE_CODEMP = DEN_CODEMP AND NFE_CONCAD = "S") AS CONCAD ');
    qryAux.SQL.Add('  FROM BLODEN ');
    qryAux.SQL.Add(' WHERE DEN_CODEMP = :CODEMP ');
    qryAux.SQL.Add('   AND DEN_DTACON IS NULL   ');

    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;
    Result := (qryAux.FieldByName('PENDEN').AsInteger > 0) And
              (qryAux.FieldByName('CONCAD').AsString = 'S');
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fExecutaServicoConsultaCadastroEmitente(const strCodEmp: String): Boolean;
  Var
    qryCnsCad : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;
  If (Not fTabelaExiste('CNSCAD')) Then
    Exit;
  If (Not fExisteConfiguracao('CNSCAD')) Then
    Exit;
  If (fCfgSisPainel('CNSCAD') <> 'S') Then
    Exit;
  qryCnsCad := fCriaQuery;
  Try
    qryCnsCad.Close;
    qryCnsCad.SQL.Text := 'SELECT 1 FROM CNSCAD WHERE CAD_CODEMP = :CODEMP AND CAD_DTACON = CURRENT_DATE';
    qryCnsCad.ParamByName('CODEMP').AsString := strCodEmp;
    qryCnsCad.Open;
    Result := (qryCnsCad.IsEmpty);
  Finally
    FreeAndNil(qryCnsCad);
  End;
end;

function TfrmPrincipal.fExisteItemEspecial: Boolean;
var
  qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSeqGer: String;
  {$IF Defined(UNIDAC)}
  strValDic: String;
  {$IFEND}
begin
  Result := False;

  If (strExisteCampoDET_NCMITE = '') Then
  Begin
    strExisteCampoDET_NCMITE := 'N';
    If (fCampoExiste('MOVTRI', 'DET_NCMITE')) Then
      strExisteCampoDET_NCMITE := 'S'
  End;

  If (strExisteCampoDET_NCMITE = 'S') Then
  Begin
    strSeqGer := IfEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString,
                            qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString);

    {$IF Defined(UNIDAC)}
    Try
      If dicExisteIteEsp.TryGetValue(strSeqGer, strValDic) Then
      Begin
        Result := (strValDic = 'S');
        Exit;
      End;
    Except
      //
    End;
    {$IFEND}

    If (fEmptyStr(strSeqGer)) Then
    Begin
      {$IF Defined(UNIDAC)}
      dicExisteIteEsp.AddOrSetValue(strSeqGer, 'N');
      {$IFEND}

      Exit;
    End;

    qryItens := fCriaQuery(Nil);
    Try
      pBuscaItemEspecialDoc(qryItens);
      Result := Not qryItens.IsEmpty;

      {$IF Defined(UNIDAC)}
      dicExisteIteEsp.AddOrSetValue(strSeqGer, IIF(Result,'S','N'));
      {$IFEND}
    Finally
      FreeAndNil(qryItens);
    End;
  End;
end;

procedure TfrmPrincipal.btnReenviarClick(Sender: TObject);
begin
  If (Not btnReenviar.Enabled) Then
    Exit;

  If InterlockedIncrement(intLockReenviar) = 0 Then
  Begin
    Try
      if not fSefazParalizado then
      begin
        Try
          tmrAtualizar.Enabled      := False;
          tmrFechaSistema.Enabled   := False;
          tmrConhecimentoTe.Enabled := False;

          pReenviarDocumento;
        Finally
          pAtualizaGrid(True);

          tmrAtualizar.Enabled      := True;
          tmrFechaSistema.Enabled   := True;
          tmrConhecimentoTe.Enabled := blnEmiteCTe;
        end;
      end;
    Finally
      InterlockedDecrement(intLockReenviar);
    End;
  End
  Else
    InterlockedDecrement(intLockReenviar);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.btnStatusSefazClick(Sender: TObject);
  const
    MSG_TENTE_NOVAMENTE = 'Tente enviar o documento novamente.';
  Var
    strCnpj: String;
    strIes: String;
    strUF: String;
    strError: string;
    blnOperacional: Boolean;
    blnMensagem: Boolean;
    retorno: TRetornoStatusNFE;
begin
  retorno := rsOperacional;

  If Not fExisteLicencaFIT Then
  Begin
    Exit;
  End;

  If fEstaEmModoAtualizacaoPainelWebCitel Then
  Begin
    Exit;
  End;

  If fEstaEmModoEmissaoNotaServicoCitel Then
  Begin
    Exit;
  End;

  If Not btnStatusSefaz.Enabled Then
  Begin
    Exit;
  End;

  btnStatusSefaz.Enabled := False;
  Try

    If fDadosEmitenteStatusServico(strCnpj, strIes, strUF, nil) Then
    Begin
      blnMensagem := (Sender = btnStatusSefaz);

      If (strUF <> '') then
        retorno := fVerificarStatusServicoPelaUF(strUF, strError)
      Else
        retorno := fVerificarStatusServico(strCnpj, strIes, strError);

      strError := ReplaceStr(strError, MSG_TENTE_NOVAMENTE, '');

      blnOperacional := (retorno = rsOperacional);

      lblStatus.OnClick := Nil;

      lblStatus.Font.Size := 14;
      If (blnOperacional) Then
      Begin
        lblStatus.Caption := 'SEFAZ OPERACIONAL';
        lblStatus.Font.Color := clBlue;
      End
      Else If (retorno = rsDPEC) Then
      Begin
        lblStatus.Font.Size := 12;
        lblStatus.Caption := 'SEFAZ OPERACIONAL (OPERANDO EM DPEC) CLIQUE PARA SABER MAIS';
        lblStatus.Font.Color := clBlue;
        lblStatus.OnClick := OnClickSefazDPEC;
      End
      Else
      Begin
        If retorno = rsTimeoutIntegrador Then
          lblStatus.Caption := 'TIME-OUT NO INTEGRADOR'
        Else
          lblStatus.Caption := 'SEFAZ PARALISADO';

        lblStatus.Font.Color := clRed;
      End;

      Self.Repaint;
      Application.ProcessMessages;

      If blnMensagem Then
      Begin
        Case retorno Of
          rsOperacional:MessageDlg('Serviço Operacional!', mtInformation, [mbOk], 0);
          rsParalisadoMomentaneamente: pParalisadoMomentaneamente;
          rsParalisadoSemPrevisao: pParalisadoSemPrevisao;
          rsErroGeral: MessageDlg('ERRO GERAL: ' + strError, mtInformation, [mbOk], 0);
          rsTimeoutIntegrador: MessageDlg('TIME OUT NO INTEGRADOR: ' + strError, mtError, [MBoK], 0);
        eND;
      End;
    End;

  Finally
    btnStatusSefaz.Enabled := True;

    if (Self.windowState = wsMinimized) and (blnMsgParalisadoSemPrevisao) and (retorno = rsParalisadoSemPrevisao) then
    begin
      blnMsgParalisadoSemPrevisao := false;
      Self.WindowState := wsMaximized;
      SetForegroundWindow(Self.Handle);
      pParalisadoSemPrevisao;
    end;
  End;

end;

procedure TfrmPrincipal.dbgDocumentosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

//  If not qryDocumentos.ControlsDisabled Then
//  Begin
//    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, NFE_STATUS.Index]) = 'AF' Then
//    Begin
//      ACanvas.Brush.Color := $000080FF;
//      ACanvas.Font.Color  := clWhite;
//    End;
//  End;
end;

procedure TfrmPrincipal.btnAlterarEReenviarTodasClick(Sender: TObject);
begin
  If fSefazParalizado Then
    Exit;

  Try
    tmrAtualizar.Enabled      := False;
    tmrFechaSistema.Enabled   := False;
    tmrConhecimentoTe.Enabled := False;

    dbgDocumentosView.Controller.SelectAll;

    pAlterarStatusEReenviar;
  Finally
    dbgDocumentosView.Controller.ClearSelection;

    pAtualizaGrid(True);

    tmrAtualizar.Enabled      := True;
    tmrFechaSistema.Enabled   := True;
    tmrConhecimentoTe.Enabled := blnEmiteCTe;
  End;
end;

procedure TfrmPrincipal.btnReenviarTodasClick(Sender: TObject);
begin
  If fSefazParalizado Then
    Exit;

  Try
    tmrAtualizar.Enabled      := False;
    tmrFechaSistema.Enabled   := False;
    tmrConhecimentoTe.Enabled := False;

    dbgDocumentosView.Controller.SelectAll;

    pReenviarDocumento;
  Finally
    pAtualizaGrid(True);

    tmrAtualizar.Enabled      := True;
    tmrFechaSistema.Enabled   := True;
    tmrConhecimentoTe.Enabled := blnEmiteCTe;
  End;
end;

procedure TfrmPrincipal.btnReimpressaoClick(Sender: TObject);
  Var
    strSenha : String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strSerie : String;
    strCodCli: String;
    strTip_FC: String;
    strAcesso: String;
    strPonImp: String;
begin
  If fEmptyStr(strSenhaReimpres) Then
  Begin
    MessageDlg('Atenção: A senha de reimpressão de Danfe não foi definida.' + #13#10 +
      'Favor verificar nas configurações de Nota Fiscal Eletrônica Citel', mtInformation, [mbOk], 0);
    Exit;
  End;

  strNumDoc := qryDocumentos.FieldByName('NFE_NUMDOC').AsString;
  strEspDoc := qryDocumentos.FieldByName('NFE_ESPDOC').AsString;
  strCodEmp := qryDocumentos.FieldByName('NFE_CODEMP').AsString;
  strSerie  := qryDocumentos.FieldByName('NFE_SERIE_').AsString;
  strCodCli := qryDocumentos.FieldByName('NFE_CODCLI').AsString;
  strTip_FC := qryDocumentos.FieldByName('NFE_TIP_FC').AsString;
  strAcesso := qryDocumentos.FieldByName('FIS_ACESSO').AsString;

  If (strEspDoc = 'NF') And
     (fEmptyStr(strAcesso)) Then
  Begin
    MessageDlg('Atenção: Esse documento não possui chave de acesso, autorize o documento antes de fazer sua impressão!', mtInformation, [mbOk], 0);
    Exit;
  End;

  if Not ffrmSenha(strSenha) then
  Begin
    Exit;
  End;

  If strSenha = strSenhaReimpres Then
  Begin
    If NFE_PONIMP.Visible Then
    Begin
      If fEmptyStr(TLibNfe.fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC)) Then
      Begin
        If fEmptyStr(strPonImp) Then
          strPonImp := TLibNfe.fRetPontoImpressao;
        pAtualizaPontoImpressao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strPonImp);
      End;
    End;
    pReimprimirDanfe(strAcesso,
                     strNumDoc,
                     strEspDoc,
                     strCodEmp,
                     strSerie,
                     strCodCli,
                     strTip_FC);
  End
  Else
  Begin
    MessageDlg('Senha incorreta.', mtWarning, [mbOk], 0);
  End;
end;

procedure TfrmPrincipal.btnRetISSClick(Sender: TObject);
  Var
    strSenha: String;
    strNovoStatus: String;
begin

  If not fEmptyStr(strSenhaReterISS) Then
  Begin
    if Not ffrmSenha(strSenha) then
    Begin
      Exit;
    End;

    If not (strSenha = strSenhaReterISS) Then
    Begin
      MessageDlg('Senha inválida!', mtInformation, [mbOk], 0);
      Exit;
    End;
  End;

  If (fDocumentoRetemISS(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString, qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString)) Then
    strNovoStatus := 'N'
  Else
    strNovoStatus := 'S';
    
  if MessageDlgCaptions('Deseja marcar o cliente para '+IIF(strNovoStatus='N', 'NÃO RETER', 'RETER')+' ISS?', mtConfirmation, [mbYes, mbNo], ['Sim', 'Não'], 'Confirmação', mbNo) = mrYes then
  begin
    if fAjustaRetISS(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString, qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString, qryDocumentos.FieldByName('NFE_CODCLI').AsString, strNovoStatus) then
    begin
      pMensagemOk('Documento '+
                  qryDocumentos.FieldByName('NFE_NUMDOC').AsString+'-'+
                  qryDocumentos.FieldByName('NFE_ESPDOC').AsString+'-'+
                  qryDocumentos.FieldByName('NFE_CODEMP').AsString+' '+
                  'e cadastro deste cliente ajustados para '+IIF(strNovoStatus='N', 'NÃO RETER', 'RETER')+' ISS.' + #13#10 +
                  'Por favor tente reenviar a nota de serviço novamente!');

      btnRetISS.Caption := 'Corrigir opção do cliente para'+IIF(strNovoStatus='S', ' não ', ' ')+ 'reter ISS';
    end
    else
    begin
      pMensagemOk('Erro ao ajustar o documento!');
    end;
  end;
end;

procedure TfrmPrincipal.pParalisadoMomentaneamente;
begin
  Application.CreateForm(TfrmSefazParalisado, frmSefazParalisado);
  frmSefazParalisado.ShowModal;
  FreeAndNil(frmSefazParalisado);
end;

procedure TfrmPrincipal.pParalisadoSemPrevisao;
begin
  Application.CreateForm(TfrmSefazParalisado, frmSefazParalisado);
  frmSefazParalisado.blnMomentaneamente := False;
  frmSefazParalisado.ShowModal;
  FreeAndNil(frmSefazParalisado);
end;

procedure TfrmPrincipal.ApplicationEvents1Activate(Sender: TObject);
begin 
  tmrAtualizarTimer(Sender);
end;

procedure TfrmPrincipal.btnAjustarConsumidorClick(Sender: TObject);
begin

  If Not btnAjustarConsumidor.Enabled Then
    Exit;

  Try
    Application.CreateForm(TfrmDigDadConsumidor,frmDigDadConsumidor);
    frmDigDadConsumidor.strCodCli := qryDocumentos.FieldByName('NFE_CODCLI').AsString;
    frmDigDadConsumidor.strCodCid := qryDocumentos.FieldByName('GER_CIDCON').AsString;

    frmDigDadConsumidor.edtNomCli.Text      := qryDocumentos.FieldByName('GER_NOMCON').AsString;
    frmDigDadConsumidor.edtEndere.Text      := qryDocumentos.FieldByName('GER_ENDCON').AsString;
    frmDigDadConsumidor.edtBairro.Text      := qryDocumentos.FieldByName('GER_BAICON').AsString;
    frmDigDadConsumidor.mskNumCep.Text      := qryDocumentos.FieldByName('GER_CEPCON').AsString;
    frmDigDadConsumidor.mskTelCon.Text      := qryDocumentos.FieldByName('GER_TELCON').AsString;
    frmDigDadConsumidor.edtCgcCpf.Text      := qryDocumentos.FieldByName('GER_CGCCPF').AsString;
    frmDigDadConsumidor.mskNumCgc.Text      := qryDocumentos.FieldByName('GER_CGCCON').AsString;
    frmDigDadConsumidor.edtInsEst.Text      := qryDocumentos.FieldByName('GER_IESCON').AsString;
    frmDigDadConsumidor.edtRgCli.Text       := qryDocumentos.FieldByName('GER_R_GCON').AsString;
    {***************************************************}
    {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
    {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
    {************************************************RV*}
    If blnEmlCon Then
      frmDigDadConsumidor.edtEmail.Text       := qryDocumentos.FieldByName('GER_EMLCON').AsString;

    frmDigDadConsumidor.ShowModal;

    If frmDigDadConsumidor.blnConfirma Then
    Begin

      pAtualizaDadosConsumidor(qryDocumentos.FieldByName('NFE_NUMDOC').AsString,
                               qryDocumentos.FieldByName('NFE_ESPDOC').AsString,
                               qryDocumentos.FieldByName('NFE_CODEMP').AsString,
                               qryDocumentos.FieldByName('NFE_SERIE_').AsString,
                               qryDocumentos.FieldByName('NFE_CODCLI').AsString,
                               frmDigDadConsumidor.edtNomCli.Text,
                               frmDigDadConsumidor.edtEndere.Text,
                               frmDigDadConsumidor.edtBairro.Text,
                               frmDigDadConsumidor.mskNumCep.Text,
                               frmDigDadConsumidor.dbeCidade.EditValue,
                               frmDigDadConsumidor.mskTelCon.Text,
                               frmDigDadConsumidor.edtCgcCpf.Text,
                               frmDigDadConsumidor.mskNumCgc.Text,
                               frmDigDadConsumidor.edtInsEst.Text,
                               frmDigDadConsumidor.edtRgCli.Text,
                               frmDigDadConsumidor.edtEmail.Text);

      btnAtualizar.Click;
    End;

  Finally
    FreeAndNil(frmDigDadConsumidor);
  End;

end;

procedure TfrmPrincipal.btnAjustarMotivoClick(Sender: TObject);
  Var
    strMotivo: String;
begin
  If Not btnAjustarMotivo.Enabled Then
    Exit;

  If (InputQuery('Novo motivo de cancelamento', 'Digite o novo motivo de cancelamento: ',
    strMotivo)) Then
  Begin
    pAtualizaMotivoCancelamento(qryDocumentos.FieldByName('NFE_NUMDOC').AsString,
                                qryDocumentos.FieldByName('NFE_ESPDOC').AsString,
                                qryDocumentos.FieldByName('NFE_CODEMP').AsString,
                                qryDocumentos.FieldByName('NFE_SERIE_').AsString,
                                strMotivo);

    MessageDlg('Motivo de cancelamento atualizado com sucesso!', mtInformation, [mbOk], 0);
  End;

end;

procedure TfrmPrincipal.btnAlterarEReenviarClick(Sender: TObject);
begin
  If fSefazParalizado Then
    Exit;

  Try
    tmrAtualizar.Enabled      := False;
    tmrFechaSistema.Enabled   := False;
    tmrConhecimentoTe.Enabled := False;

    pAlterarStatusEReenviar;
  Finally
    pAtualizaGrid(True);

    tmrAtualizar.Enabled      := True;
    tmrFechaSistema.Enabled   := True;
    tmrConhecimentoTe.Enabled := blnEmiteCTe;
  End;
end;

procedure TfrmPrincipal.pAlterarStatusEReenviar;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intRow: integer;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strSerie: String;
    strCodCli: String;
    strTip_FC: String;
    strStatus: String;
begin
  if dbgDocumentosView.Controller.SelectedRowCount = 0 then
  begin
    MessageDlg('Atenção'+#13+
               'Selecione a nota fiscal fiscal e tente novamente', mtInformation, [mbOk], 0);
    exit;
  end;

  qryAux := fCriaQuery(Self);

  For intRow := 0 to dbgDocumentosView.ViewData.RowCount - 1 do
  Begin
    if dbgDocumentosView.ViewData.Rows[intRow].Selected then
    Begin
      strNumDoc := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_NUMDOC.Index] );
      strEspDoc := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_ESPDOC.Index] );
      strCodEmp := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_CODEMP.Index] );
      strSerie  := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_SERIE_.Index] );
      strCodCli := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_CODCLI.Index] );
      strTip_FC := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_TIP_FC.Index] );
      strStatus := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_STATUS.Index] );

      If (strEspDoc <> 'NS') And fUsaApenasNotaDeServicoEnotas Then
      Begin
        continue;
      End;

      If strStatus = 'GE' Then
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE LOGNFE SET NFE_STATUS = "AE" WHERE');
        qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
        qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
        qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_ AND ');
        qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
        qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC AND ');
        qryAux.SQL.Add('  NFE_STATUS NOT IN ("CN","IN") ');

        qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
        qryAux.ParamByName('CODEMP').AsString := strCodEmp;
        qryAux.ParamByName('SERIE_').AsString := strSerie ;
        qryAux.ParamByName('CODCLI').AsString := strCodCli;
        qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
        qryAux.ExecSQL;

      end;
    end;
  end;
  FreeAndNil(qryAux);
end;

procedure TfrmPrincipal.btnAlterarNCMClick(Sender: TObject);
begin
  If (Not btnAlterarNCM.Enabled) And (btnAlterarNCM.Visible <> ivNever) Then
  Begin
    Exit;
  End;

  pAlterarNCMDosItens;
end;

procedure TfrmPrincipal.pAcertaSerieDocumentoReferenciado;
  Var
    strSerie: String;
    qryUpd: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strTabelaNota: String;
    qryDocsRef: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    function fTabelaNota: String;
    begin
      Result := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString), 'MOVGER', 'NOTGER');
    end;

    procedure pCarregarDadosDocReferenciado;
    begin
      qryDocsRef.SQL.Add('SELECT ');
      qryDocsRef.SQL.Add('  DET_DOCDEV, ');
      qryDocsRef.SQL.Add('  DET_ESPDEV, ');
      qryDocsRef.SQL.Add('  DET_EMPDEV ');
      qryDocsRef.SQL.Add('FROM ' + IIF(fTabelaNota='MOVGER', 'MOVDET', 'NOTDET'));
      qryDocsRef.SQL.Add('WHERE ');
      qryDocsRef.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      qryDocsRef.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      qryDocsRef.SQL.Add('  DET_CODEMP = :CODEMP AND ');
      qryDocsRef.SQL.Add('  IF(:TIP_FC="C", DET_CODCLI, DET_CODFOR) = :FORCLI AND ');
      qryDocsRef.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
      qryDocsRef.SQL.Add('  DET_TIP_FC = :TIP_FC ');
      qryDocsRef.SQL.Add('GROUP BY ');
      qryDocsRef.SQL.Add('  DET_DOCDEV, DET_ESPDEV, DET_EMPDEV ');

      qryDocsRef.ParamByName('NUMDOC').AsString := qryDocumentos.FieldByName('NFE_NUMDOC').AsString;
      qryDocsRef.ParamByName('ESPDOC').AsString := qryDocumentos.FieldByName('NFE_ESPDOC').AsString;
      qryDocsRef.ParamByName('CODEMP').AsString := qryDocumentos.FieldByName('NFE_CODEMP').AsString;
      qryDocsRef.ParamByName('FORCLI').AsString := qryDocumentos.FieldByName('NFE_CODCLI').AsString;
      qryDocsRef.ParamByName('TIP_FC').AsString := qryDocumentos.FieldByName('NFE_TIP_FC').AsString;
      qryDocsRef.ParamByName('SERIE_').AsString := qryDocumentos.FieldByName('NFE_SERIE_').AsString;
      qryDocsRef.Open;
    end;

    procedure pExecutar;
    begin
      qryUpd.ParamByName('SERIE_').AsString := strSerie;

      qryUpd.ParamByName('NUMDOC').AsString := qryDocsRef.FieldByName('DET_DOCDEV').AsString;
      If Assigned(qryUpd.Params.FindParam('ESPDOC')) Then
      Begin
        qryUpd.ParamByName('ESPDOC').AsString := qryDocsRef.FieldByName('DET_ESPDEV').AsString;
      End;

      qryUpd.ParamByName('CODEMP').AsString := qryDocsRef.FieldByName('DET_EMPDEV').AsString;
      qryUpd.ParamByName('FORCLI').AsString := qryDocumentos.FieldByName('NFE_CODCLI').AsString;

      If Assigned(qryUpd.Params.FindParam('ESPDOC')) Then
      Begin
        qryUpd.ParamByName('TIP_FC').AsString := qryDocumentos.FieldByName('NFE_TIP_FC').AsString;
      End;
      qryUpd.ExecSQL;
    end;
begin

  //ATUALIZAR CADFIS, MOVGER, MOVDET, CADPAG, CTPDET

  If InputQuery('Série da NF referenciada', 'Informe a série da NF referenciada: ', strSerie) Then
  Begin
    If (StrToIntDef(strSerie, -1) < 0) Or
       (Length(strSerie) > 3) Then
    Begin
      pMensagemOk('A série do documento deve um número de até 3 digitos.');
      Exit;
    End;

    qryDocsRef := fCriaQuery;
    qryUpd := fCriaQuery;

    frmModulo.Database.StartTransaction;
    Try
      Try
        pCarregarDadosDocReferenciado;
        strTabelaNota := fTabelaNota;

        While (Not qryDocsRef.Eof) Do
        Begin
          qryUpd.SQL.Clear;
          qryUpd.SQL.Add('UPDATE CADFIS SET FIS_SERIE_ = :SERIE_ WHERE ');
          qryUpd.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
          qryUpd.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
          qryUpd.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
          qryUpd.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
          qryUpd.SQL.Add('  IFNULL(FIS_SERIE_, "") = "" AND ');
          qryUpd.SQL.Add('  FIS_TIP_FC = :TIP_FC ');
          pExecutar;

          qryUpd.SQL.Clear;
          qryUpd.SQL.Add('UPDATE ' + strTabelaNota + ' SET GER_SERIE_ = :SERIE_ WHERE ');
          qryUpd.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
          qryUpd.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
          qryUpd.SQL.Add('  GER_CODEMP = :CODEMP AND ');
          qryUpd.SQL.Add('  IF(:TIP_FC="C", GER_CODCLI, GER_CODFOR) = :FORCLI AND ');
          qryUpd.SQL.Add('  IFNULL(GER_SERIE_, "") = "" AND ');
          qryUpd.SQL.Add('  GER_TIP_FC = :TIP_FC ');
          pExecutar;

          qryUpd.SQL.Clear;
          qryUpd.SQL.Add('UPDATE ' + IIF(strTabelaNota='MOVGER', 'MOVDET', 'NOTDET') + ' SET DET_SERIE_ = :SERIE_ WHERE ');
          qryUpd.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
          qryUpd.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
          qryUpd.SQL.Add('  DET_CODEMP = :CODEMP AND ');
          qryUpd.SQL.Add('  IF(:TIP_FC="C", DET_CODCLI, DET_CODFOR) = :FORCLI AND ');
          qryUpd.SQL.Add('  IFNULL(DET_SERIE_, "") = "" AND ');
          qryUpd.SQL.Add('  DET_TIP_FC = :TIP_FC ');
          pExecutar;

          qryUpd.SQL.Clear;
          qryUpd.SQL.Add('UPDATE CADPAG SET CTP_SERIE_ = :SERIE_ WHERE ');
          qryUpd.SQL.Add('  CAST(CTP_NUMDUP AS UNSIGNED) = :NUMDOC AND ');
          qryUpd.SQL.Add('  CTP_CODEMP = :CODEMP AND ');
          qryUpd.SQL.Add('  CTP_CODFOR = :FORCLI AND ');
          qryUpd.SQL.Add('  IFNULL(CTP_SERIE_, "") = "" ');
          pExecutar;

          qryUpd.SQL.Clear;
          qryUpd.SQL.Add('UPDATE CTPDET SET CTP_SERIE_ = :SERIE_ WHERE ');
          qryUpd.SQL.Add('  CAST(CTP_NUMDUP AS UNSIGNED) = :NUMDOC AND ');
          qryUpd.SQL.Add('  CTP_CODEMP = :CODEMP AND ');
          qryUpd.SQL.Add('  CTP_CODFOR = :FORCLI AND ');
          qryUpd.SQL.Add('  IFNULL(CTP_SERIE_, "") = "" ');
          pExecutar;

          qryDocsRef.Next;
        End;

        frmModulo.Database.Commit;
      Except
        On E: Exception Do
        Begin
          frmModulo.Database.Rollback;
          Raise;
        End;
      End;
    Finally
      FreeAndNil(qryUpd);
      FreeAndNil(qryDocsRef);
    End;
  End;

end;

procedure TfrmPrincipal.pAjustaHints;
begin
  If blnInicializandoPainel Then
    Exit;

  edtRefresh.Hint   := 'Atualiza automaticamente a lista de documentos a cada '+FloatToStr(edtRefresh.Value)+' segundos';

  edtQtdUltNot.Hint := IIF(edtQtdUltNot.Value>1, 'Mostra as últimas '+FloatToStr(edtQtdUltNot.Value)+' NFe(s), NFCe(s), etc autorizadas',
                                                 'Mostra a última NFe, NFCe, etc autorizada');
  edtQtdUltNot.Hint := edtQtdUltNot.Hint +
                       IIF(edtQtdDiasNfAut.Value>1,  ' nos últimos '+FloatToStr(edtQtdDiasNfAut.Value)+' dias',
                                                     ' hoje');

  edtQtdDiasNfAut.Hint := edtQtdUltNot.Hint;
  edtTamLote.Hint      := 'Lote de envios simultâneos';
  edtApgTmp.Hint       := 'Apaga os arquivos temporários em '+fRetornaCaminhoLimparDiretorioDanfe+' criados a mais de '+IIF(edtApgTmp.Value>=1440, 'um dia', FloatToStr(edtApgTmp.Value)+' minutos');
end;

procedure TfrmPrincipal.pAlterarNCMDosItens;
  Var
    qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strTblSel: String;
    strTabela: String;
    strSeqGer: String;
begin
  strTblSel := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString), 'MOVDET', 'NOTDET');
  strSeqGer := IfEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString,
                          qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString);

  qryItens := fCriaQuery(Self);
  Try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Text :=
         'SELECT '+
         '  MOVDET.AUTOINCREM, '+
         '  MOVDET.DET_CODITE, '+
         '  MOVDET.DET_DESCRI, '+
         '  MOVTRI.TRI_NCMTIN  '+
         'FROM '+
         '  MOVDET '+
         '  JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM '+
         'WHERE '+
         '  MOVDET.DET_IDEPRO <> "NOR" AND '+
         '  MOVDET.DET_PROEMB <> "S" AND   '+
         '  MOVDET.DET_SEQGER = :SEQGER    ';

    strTabela := 'MOVTRI';
    If (strTblSel = 'NOTDET') Then
    Begin
      strTabela := 'NOTTRI';
      qryItens.SQL.Text := AnsiReplaceStr(qryItens.SQL.Text, 'MOVDET', 'NOTDET');
      qryItens.SQL.Text := AnsiReplaceStr(qryItens.SQL.Text, 'MOVTRI', 'NOTTRI');
    End;

    qryItens.ParamByName('SEQGER').AsString := strSeqGer;
    qryItens.Open;

    If qryItens.IsEmpty Then
    Begin
      MessageDlg('Não foram encontrados registros de tinta de máquina neste documento.', mtInformation, [mbOk], 0);
      Exit;
    End;

    Application.CreateForm(TfrmAlterarNCMTintas, frmAlterarNCMTintas);
    Try
      frmAlterarNCMTintas.strTabela := strTabela;
      frmAlterarNCMTintas.dtsItens.DataSet := qryItens;
      frmAlterarNCMTintas.ShowModal;
      frmAlterarNCMTintas.Close;
    Finally
      FreeAndNil(frmAlterarNCMTintas);
    End;
  Finally
    FreeAndNil(qryItens);
  End;
end;

procedure TfrmPrincipal.btnAtualizarClick(Sender: TObject);
begin
  pAtualizaGrid(False);
end;

procedure TfrmPrincipal.edtQtdDiasNfAutChange(Sender: TObject);
begin
  pAtuCfgSisPainel('ULTDIP', '', FloatToStr(edtQtdDiasNfAut.Value));
  pAjustaHints;
end;

procedure TfrmPrincipal.edtQtdUltNotChange(Sender: TObject);
begin
  pAtuCfgSisPainel('ULTNOT', '', FloatToStr(edtQtdUltNot.Value));
  pAjustaHints;
end;

procedure TfrmPrincipal.edtQtdUltNotExit(Sender: TObject);
begin
  pAtualizaGrid(False);
end;

procedure TfrmPrincipal.edtRefreshChange(Sender: TObject);
begin
  If (blnPainelAtivo) Then
  Begin
    tmrAtualizar.Enabled  := False;
    tmrAtualizar.Interval := fSegundosToInterval(edtRefresh.Value);
    tmrAtualizar.Enabled  := True;
  End;

  pAtuCfgSisPainel('TMPREF', '', FloatToStr(edtRefresh.Value));
  pAjustaHints;
end;

procedure TfrmPrincipal.edtTamLoteChange(Sender: TObject);
begin
  If (blnPainelAtivo) Then
    If (StrToFloatDef(fCfgSisPainel('TAMLOT'), 3) <> edtTamLote.Value) Then
      pSinalizarAoCoordenadorStatusParaSeAutoBloquear;

  pAtuCfgSisPainel('TAMLOT', '', FloatToStr(edtTamLote.Value));
  pAjustaHints;
end;

procedure TfrmPrincipal.edtApgTmpChange(Sender: TObject);
begin
  pAtuCfgSisPainel('TMPDAN', '', FloatToStr(edtApgTmp.Value));
  pAjustaHints;
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  inherited;

  If Application.Terminated Then
    Exit;

  pAtualizaGrid(False);

  If fPainelVazio Then
    pHabilitarBotoes;

  blnPainelAtivo := True;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  blnPainelAtivo := False;
  pDesligaTodosOsTimers;

  If Assigned(frmModulo) Then
  Begin
    If (frmModulo.Database.Connected) Then
    Begin
      objLogAut.pLogout;

      {$IF Defined(UNIDAC)}
      pDeletaDicSisPorPidMd5(frmModulo.Database);
      FreeAndNil(dicExisteIteEsp);
      {$IFEND}

      pSinalizarAoCoordenadorStatusParaTerminarAposUltimaTarefa; //Para ficar um NfeStatus.exe parado atoa

      Sleep(2000);

      pGeraRegistroParaLogGeneral(frmModulo.Database, 'TfrmPrincipal.FormClose > frmModulo.Database.Disconnect');

      frmModulo.Database.Disconnect;
    End;

    FreeAndNil(frmModulo);
  End;

  If Assigned(objLogAut) Then
    FreeAndNil(objLogAut);

  If Assigned(VS_stlTabNre) Then
    FreeAndNil(VS_stlTabNre);

  objTestabilidade := Nil;

  If (Not fEmptyStr(strIdConexao)) Then
    DeleteFile(fPnlDir(strIdConexao + '.CONEXAO'));

  inherited;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);

  function fCfgSisLoc(const strCodCfg: String): String;
  begin
    Result := (fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_'+strCodCfg, VS_strCodEmp], frmModulo.Database));
  end;

  function fAtualizarNFePrinter: Boolean;
  begin
    Result := True;

    //Não usa NFe pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('CITINF'), 'N') = 'N') Then
      Exit;

    //Não usa NFCe pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('PRNFCE'), 'N') = 'N') Then
      Exit;

    //Não usa NFSe pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('USASER'), 'N') = 'S') And (IfEmptyStr(fCfgSisLoc('IMPNFS'), 'N') = 'N') Then
      Exit;

    {
    //Não usa Carta Correção pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('NFICCE'), 'N') = 'N') Then
      Exit;

    //Não usa CTe pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('NFICTE'), 'N') = 'N') Then
      Exit;

    //Não usa MFDe pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('NFIMDF'), 'N') = 'N') Then
      Exit;

    //Não usa SAT pelo NFeImpressão
    If (IfEmptyStr(fCfgSisLoc('USASAT'), 'N') = 'S') And (IfEmptyStr(fCfgSisLoc('NFISAT'), 'N') = 'N') Then
      Exit;
    }

    Result := False;
  end;

begin
  inherited;

  pDesligaTodosOsTimers;
  memTarefas.Lines.Clear;
  blnInicializandoPainel := False;
  blnPainelAtivo := False;
  blnForcandoCorrecaoPainelWebCitel := False;
  blnModoClassico := False;

  {$IFDEF VER300}
  dbgDocumentos.LookAndFeel.ScrollbarMode := sbmClassic;
  {$ENDIF};

  {$IF Defined(UNIDAC)}
  dicExisteIteEsp := TDictionary<string, string>.Create;
  {$IFEND}

  If (Not FileExists('NFeStatus.exe')) Then
  Begin
    Application.MessageBox(PChar('Não foi encontrado o arquivo "NFeStatus.exe". ' + #13#10 +
                                 'Favor entrar em contato com a Citel!'), 'Atenção', MB_OK+MB_ICONWARNING);
    Application.Terminate;
  End;

  strIdConexao := '';

  FPonImp := fArqIni(0, 'GERAL', 'PONIMP', '', 'opcoespainel.ini');

  pCarregarConfiguracoes;
  pAbrirBanco(frmModulo);

  {$IF Defined(UNIDAC)}
  pSetaPidMD5DicSis(frmModulo.Database, GetCurrentProcessId, GetMacAddress);
  pSetaPidMD5DicSisLibNfe(VS_PidMD5DicSis);
  pDeletaDicSisComMaisQueUmDia(frmModulo.Database);
  {$IFEND}

  pDefineEmpresa;

  Application.ProcessMessages;
  If Application.Terminated Then
  Begin
    Exit;
  End;

  TLibNfe.pCarregaConfigNFE(frmModulo.Database);
  pSetaConfiguracoesPainel(VS_confignfe);

  blnEmiteCTe      := (fCfgSisLoc('EMICTE') = 'S');
  blnXMLTerceiros  := (fCfgAtiva(fCfgSisLoc('DFETER')) Or fCfgAtiva(fCfgSisLoc('CTETER')));
  strSenhaReimpres := (fCfgSisLoc('CITSDA'));
  strSenhaReterISS := (fCfgSisLoc('SRTISS'));

  If fEstaEmModoAtualizacaoPainelWebCitel Then
    dxBarSubItem1.Enabled := False;

  If (fEstaEmModoEmissaoNotaServicoCitel) Or (fEstaEmModoAtualizacaoPainelWebCitel) Then
  Begin
    blnEmiteCTe     := False;
    blnXMLTerceiros := False;
  End;

  blnXMLTerceirosSomenteBucket := False;
  If (Not blnXMLTerceiros) Then
  Begin
    If (fCfgSisLoc('BKTDFE') = 'S') Then
      blnXMLTerceirosSomenteBucket := True;
  End;

  NFE_PONIMP.Visible := fCampoExiste('LOGNFE', 'NFE_PONIMP');
  blnEmlCon := fCampoExiste('MOVGER', 'GER_EMLCON');

  objLogAut := TLogAut.Create(frmModulo.Database, VS_strCodEmp);
  objLogAut.pLogin;

  qryDocumentos := fCriaQuery(Self);
  qryDocumentos.AfterScroll := qryDocumentosAfterScroll;
  dtsDocumentos.DataSet := qryDocumentos;
  objTestabilidade := TTestabilidade.fGetTestabilidade;

  intLockAtualizar := -1;
  intLockReenviar  := -1;
  dtaUltimoProcessTarefa := Date+Time;
  dtaUltimaAtualizTarefa := Date;
  dtaUltimaVeriNfeStatus := Date;
  dtaUltimaLimpezaDicSis := Date+Time;
  intTotPen := 0;
  intTotErr := 0;

  blnAtualizaPOSNABDeFormaAutomatica := (fCfgSisLoc('HPNAUT') = 'S');

  If fInstalarMicrosoftVisualC Then
    pInstaladorMicrosoftVisualC;

  If fAtualizarNFePrinter Then
  Begin
    pCopiarNFePrinterLocalExe;
    pCopiarNFePrinterLocalJar;
  End;

  pCopiarPDFToPrinter;

  blnInicializandoPainel := True;
  Try
    Application.CreateForm(TfrmGravando, frmGravando);
    frmGravando.strChave := 'PAINELNFE';

    frmGravando.lblGravando.Caption := 'Aguarde... Inicializando PainelNFe ('+VS_strCodEmp+')';

    frmGravando.fExecutarAcaoMetodo := fInicializaPainel;
    frmGravando.strArqPnl := '';
    frmGravando.strArqLoc := '';
    frmGravando.ShowModal;

    If Not frmGravando.blnConfirma Then
    Begin
      Application.Terminate;
    End;
  Finally
    blnInicializandoPainel := False;
    FreeAndNil(frmGravando);
  End;

  pAjustaHints;
  blnMsgParalisadoSemPrevisao := true;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
Var
  strMsgInicial: String;
begin
  inherited;

  strMsgInicial := fArqIni(0, 'GERAL', 'MENINI', '', 'opcoespainel.ini');
  If Not fEmptyStr(strMsgInicial) Then
    MessageDlg(strMsgInicial + '!', mtInformation, [mbOK], 0);
end;

function TfrmPrincipal.fAjustaRetISS(strAutIncMOVGER,
  strAutIncNOTGER, strCodCli, strRetISS: string): Boolean;
var
  qryAjuRetIss: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strTblNota, strAutInc: string;
begin
  Result := False;

  if (fCampoExiste('AUXMOV', 'AUX_RETISS')) and (fCampoExiste('CADCLI', 'CLI_RETISS')) then
  begin
    strAutInc := fRetornaTabelaNota(strAutIncMOVGER, strAutIncNOTGER, strTblNota);

    qryAjuRetIss := fCriaQuery(Nil);
    try
      qryAjuRetIss.Close;
      qryAjuRetIss.SQL.Clear;
      qryAjuRetIss.SQL.Add('UPDATE '+strTblNota+'');
      qryAjuRetIss.SQL.Add('SET AUX_RETISS = "'+strRetISS+'"');
      qryAjuRetIss.SQL.Add('WHERE AUX_SEQGER = :AUTINC');

      qryAjuRetIss.ParamByName('AUTINC').AsString := strAutInc;

      qryAjuRetIss.ExecSQL;

      qryAjuRetIss.Close;
      qryAjuRetIss.SQL.Clear;
      qryAjuRetIss.SQL.Add('UPDATE CADCLI');
      qryAjuRetIss.SQL.Add('SET CLI_RETISS = "'+strRetISS+'"');
      qryAjuRetIss.SQL.Add('WHERE CLI_CODCLI = :CODCLI');

      qryAjuRetIss.ParamByName('CODCLI').AsString := strCodCli;

      qryAjuRetIss.ExecSQL;

      Result := True;
    finally
      FreeAndNil(qryAjuRetIss);
    end;
  end;
end;

function TfrmPrincipal.fConfigurou(resultInicial: Boolean=True; blnReinciar: Boolean=True): Boolean;
  Var
    strPthOld: String;
    strEmpOld: String;
    strEmpNew: String;
begin
  Result := resultInicial;
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  Try
    strPthOld := fPathOpcoesIni;
    strEmpOld := fArqIni(0, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');

    frmConfiguracoes.ShowModal;

    If (frmConfiguracoes.ModalResult = mrOk) Then
    Begin
      strEmpNew := fArqIni(0, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');

      If (strPthOld <> fPathOpcoesIni) Or
         (strEmpOld <> strEmpNew) Then
      Begin
        Result := True;
        If blnReinciar Then
        Begin
          Application.MessageBox('O PainelNFe será encerrado. Reabra na sequência!', 'Atenção', MB_OK+MB_ICONWARNING);
          pEncerrarForcado;
        End;
      End;
    End;
  Finally
    FreeAndNil(frmConfiguracoes);
  End;
end;

function TfrmPrincipal.fDocumentoReferenciadoNaoPossuiSerie: Boolean;
begin
  //Erro: NFE-REF: Linha: 5 Coluna 07 ( Série ): Campo obrigatório! /
  Result := (Pos('nferef', fTiraCaracEspeciais(AnsiLowerCase(qryDocumentos.FieldByName('NFE_OBSERV').AsString))) > 0) And
            (Pos('serie', fTiraCaracEspeciais(AnsiLowerCase(qryDocumentos.FieldByName('NFE_OBSERV').AsString))) > 0);
end;

function TfrmPrincipal.fDocumentoRetemISS(strAutIncMOVGER,
  strAutIncNOTGER: string): Boolean;
var
  qryDocRetIss: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strTblNota, strAutInc: string;
begin
  Result := False;
  if fCampoExiste('AUXMOV', 'AUX_RETISS') then
  begin
    strAutInc := fRetornaTabelaNota(strAutIncMOVGER, strAutIncNOTGER, strTblNota);

    qryDocRetIss := fCriaQuery(Nil);
    try
      qryDocRetIss.Close;
      qryDocRetIss.SQL.Clear;
      qryDocRetIss.SQL.Add('SELECT AUX_RETISS');
      qryDocRetIss.SQL.Add('FROM '+strTblNota+'');
      qryDocRetIss.SQL.Add('WHERE AUX_SEQGER = :AUTINC');

      qryDocRetIss.ParamByName('AUTINC').AsString := strAutInc;

      qryDocRetIss.Open;

      Result := (not qryDocRetIss.IsEmpty) and (qryDocRetIss.FieldByName('AUX_RETISS').AsString = 'S');
    finally
      FreeAndNil(qryDocRetIss);
    end;
  end;
end;

function TfrmPrincipal.fInicializaPainel(pgbSts: TcxProgressBar): Boolean;

  procedure pIncrementaProgresso;
  begin
    If Assigned(pgbSts) Then
    Begin
      pgbSts.Position := pgbSts.Position + 1;
      Application.ProcessMessages;
    End;
  End;

begin
  If Assigned(pgbSts) Then
  Begin
    pgbSts.Properties.Max := 6;
    pgbSts.Position := 0;
  End;

  pAtualizarStatusConsultaCadastro(VS_strCodEmp);

  If Not fCfgExiste('TMPREF') Then
    pAtuCfgSisPainel('TMPREF', 'Atualizar a cada (segundos)', '30');

  If Not fCfgExiste('ULTNOT') Then
    pAtuCfgSisPainel('ULTNOT', 'Quantidade de notas autorizadas para exibir', '50');

  If Not fCfgExiste('ULTDIP') Then
    pAtuCfgSisPainel('ULTDIP', 'Quantidade de dias para filtro de notas autorizadas', '5');

  If Not fCfgExiste('TAMLOT') Then
    pAtuCfgSisPainel('TAMLOT', 'Tamanho do lote para processar notas fiscais', '3');

  If Not fCfgExiste('TMPDAN') Then
    pAtuCfgSisPainel('TMPDAN', 'Tempo (em minutos) para apagar arquivos temporários', '480');

  edtRefresh.Value      := Max(StrToFloatDef(fCfgSisPainel('TMPREF'), 30), 5);
  edtQtdUltNot.Value    := StrToFloatDef(fCfgSisPainel('ULTNOT'), 50);
  edtQtdDiasNfAut.Value := StrToFloatDef(fCfgSisPainel('ULTDIP'), 5);
  edtTamLote.Value      := StrToFloatDef(fCfgSisPainel('TAMLOT'), 3);
  edtApgTmp.Value       := StrToFloatDef(fCfgSisPainel('TMPDAN'), 1440);

  pIncrementaProgresso;

  If fCfgExiste('FINAUT') Then
  Begin
    VS_blnUsaFin := fCfgSis('FINAUT', varBoolean);
    VS_dtaHraFin := StrToDateTime(fCfgSis('FINHRA'));
  End;

  If fCfgSisPainel('REILOT') <> 'N' Then
  Begin
    edtTamLote.Value := 3;
    pAtuCfgSisPainel('REILOT', 'Reiniciar tamanho do lote padrão (3)?', 'N');
  End;

  btnStatusSefaz.Visible := IIF(fExisteLicencaFIT, ivAlways, ivNever);

  pCriarArquivoAbertura;

  fAjustaDataSistema;

  fGetLock(VS_strCodEmp);

  tmrFechaSistema.Enabled := True;

  pIncrementaProgresso;
  pAtualizaGrid(False);

  tmrFechaSistema.Interval := fSegundosToInterval(5);

  tmrAtualizar.Interval := fSegundosToInterval(edtRefresh.Value);
  tmrAtualizar.Enabled  := True;

  tmrStatus.Interval    := fSegundosToInterval(1);
  tmrStatus.Enabled     := True;

  tmrECONF.Interval            := fMinutosToInterval(15);
  tmrECONF.Enabled             := True;

  tmrLiberaSeqDoc.Interval     := fSegundosToInterval(20);
  tmrLiberaSeqDoc.Enabled      := True;

  tmrStatusSefaz.Interval      := fMinutosToInterval(5);
  tmrStatusSefaz.Enabled       := True;

  tmrConsultaCadastro.Interval := fIntervaloDaConsultaCadastral;
  tmrConsultaCadastro.Enabled  := True;

  tmrPendenciaDPEC.Interval    := fMinutosToInterval(15);
  tmrPendenciaDPEC.Enabled     := True;

  tmrDFeTerceiros.Interval     := fMinutosToInterval(15);
  tmrDFeTerceiros.Enabled      := True;

  tmrConhecimentoTe.Interval   := fSegundosToInterval(10);
  tmrConhecimentoTe.Enabled    := blnEmiteCTe;

  tmrPainelCitel.Interval      := fMinutosToInterval(1);
  tmrPainelCitel.Enabled       := True;

  tmrPainelCitelCorrecao.Interval := fMinutosToInterval(5);
  tmrPainelCitelCorrecao.Enabled  := True;

  If (fEstaEmModoEmissaoNotaServicoCitel) Or (fEstaEmModoAtualizacaoPainelWebCitel) Then
  Begin
    tmrLiberaSeqDoc.Enabled        := False;
    tmrECONF.Enabled               := False;
    tmrStatusSefaz.Enabled         := False;
    tmrConsultaCadastro.Enabled    := False;
    tmrPendenciaDPEC.Enabled       := False;
    tmrDFeTerceiros.Enabled        := False;
    tmrConhecimentoTe.Enabled      := False;

    If (fEstaEmModoEmissaoNotaServicoCitel) Then
    Begin
      tmrPainelCitel.Enabled         := False;
      tmrPainelCitelCorrecao.Enabled := False;
    End;
  End;

  If (fCfgSisPainel('NCMTIN') <> 'S') Then
    btnAlterarNCM.Visible := ivNever;

  pAtualizarTituloDoPainel;

  pAtualizarVersaoInfSis;
  pGravarNFeLocal;

  pIncrementaProgresso;
  pRemoverTarefasInativas(True);

  pTarefasBasicas;
  pIncrementaProgresso;

  If fTemNotasPendentesParaCoordenacao Then
    pTarefasCoordenador;

  pIncrementaProgresso;

  If fExecutaServicoConsultaCadastroEmitente(VS_strCodEmp) Then
    pNFeStatus(fTagComValorToParam('NFE_EMITENTE_CONSULTA_CADASTRO', consTagParamsTrf));

  pIncrementaProgresso;

  Result := True;
end;

function TfrmPrincipal.fNaoPossuiDocumentoReferenciado: Boolean;
begin
  Result := (Pos('nao possui documento fiscal referenciado', fTiraCaracEspeciais(AnsiLowerCase(qryDocumentos.FieldByName('NFE_OBSERV').AsString))) > 0);
end;

function TfrmPrincipal.fNFeComplementarNaoPossuiDocumentoReferenciado: Boolean;
begin
  Result := (Pos('nfe complementar nao possui nf referenciada', fTiraCaracEspeciais(AnsiLowerCase(qryDocumentos.FieldByName('NFE_OBSERV').AsString))) > 0);
end;

procedure TfrmPrincipal.lblSefazForaClick(Sender: TObject);
begin
  btnStatusSefazClick(Sender);
end;

procedure TfrmPrincipal.lblSefazOperacionalClick(Sender: TObject);
begin
  btnStatusSefazClick(Sender);
end;

procedure TfrmPrincipal.OnClickSefazDPEC(Sender: TObject);
begin
  Application.CreateForm(TfrmSefazParalisado, frmSefazParalisado);
  frmSefazParalisado.blnDPec := True;
  frmSefazParalisado.ShowModal;
  FreeAndNil(frmSefazParalisado);
end;

procedure TfrmPrincipal.pAtualizarDocumentoReferenciadoAutcom(strNumDoc,
  strEspDoc, strCodEmp: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strTblUpd: String;
    strSeqGer: String;
begin
  strTblUpd := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString), 'MOVDET', 'NOTDET');
  strSeqGer := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString),
                   qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString,
                   qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString);


  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE ' + strTblUpd + ' SET ');
  qryAux.SQL.Add('  DET_DOCDEV = :DOCDEV, ');
  qryAux.SQL.Add('  DET_ESPDEV = :ESPDEV, ');
  qryAux.SQL.Add('  DET_EMPDEV = :EMPDEV ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  DET_SEQGER = :AUTINC ');

  qryAux.ParamByName('DOCDEV').AsString := strNumDoc;
  qryAux.ParamByName('ESPDEV').AsString := strEspDoc;
  qryAux.ParamByName('EMPDEV').AsString := strCodEmp;
  qryAux.ParamByName('AUTINC').AsString := strSeqGer;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

end;

procedure TfrmPrincipal.pAtualizarDocumentoReferenciadoDigitado(strChave,
  strNumCoo, strNumSer, strNumUsu, strNumero, strSerie_, strModelo, strCPFCNP,
  strEstado, strMesAno: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strTblUpd: String;
    strSeqGer: String;
begin
  strTblUpd := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString), 'AUXMOV', 'AUXNOT');
  strSeqGer := IIF(Not fEmptyStr(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString),
                   qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString,
                   qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString);

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE ' + strTblUpd + ' SET ');

  If Not fEmptyStr(strChave) Then
  Begin
    qryAux.SQL.Add('  AUX_CHVNFE = :CHANFE ');
    qryAux.ParamByName('CHANFE').AsString := strChave;
  End;

  If Not fEmptyStr(strNumCoo) Then
  Begin
    qryAux.SQL.Add('  AUX_NUMCOO = :NUMCOO, ');
    qryAux.SQL.Add('  AUX_NUMSER = :NUMSER, ');
    qryAux.SQL.Add('  AUX_NUMUSU = :NUMUSU ');

    qryAux.ParamByName('NUMCOO').AsString := strNumCoo;
    qryAux.ParamByName('NUMSER').AsString := strNumSer;
    qryAux.ParamByName('NUMUSU').AsString := strNumUsu;
  End;

  If Not fEmptyStr(strNumero) Then
  Begin
    qryAux.SQL.Add('  AUX_NUMERO = :NUMERO, ');
    qryAux.SQL.Add('  AUX_SERIE_ = :SERIE_, ');
    qryAux.SQL.Add('  AUX_MODELO = :MODELO, ');
    qryAux.SQL.Add('  AUX_CPFCNP = :CPFCNP, ');
    qryAux.SQL.Add('  AUX_ESTADO = :ESTADO, ');
    qryAux.SQL.Add('  AUX_MESANO = :MESANO  ');

    qryAux.ParamByName('NUMERO').AsString := strNumero;
    qryAux.ParamByName('SERIE_').AsString := strSerie_;
    qryAux.ParamByName('MODELO').AsString := strModelo;
    qryAux.ParamByName('CPFCNP').AsString := strCPFCNP;
    qryAux.ParamByName('ESTADO').AsString := strEstado;
    qryAux.ParamByName('MESANO').AsString := strMesAno;
  End;

  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  AUX_SEQGER = :SEQGER ');

  qryAux.ParamByName('SEQGER').AsString := strSeqGer;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

end;

procedure TfrmPrincipal.pAtualizarDocumentos;
  Var
    strSQL: String;
    strSQLBase: String;
    strNumDocAtu: String;
    strEspDocAtu: String;
    strCodEmpAtu: String;
    strSerieAtu: String;

    function fSQLCampo(strCampo: String): String;
    begin
      Result :=          'IFNULL(G.' + strCampo + ', IFNULL(DG.' + strCampo + ', ';
      Result := Result + 'IFNULL(N.' + strCampo + ', DN.' + strCampo + '))) ';
    end;
    function fSQLCampoFis(strCampo: String): String;
    begin
      Result :=          'IFNULL(G.' + strCampo + ', IFNULL(DG.' + strCampo + ', ';
      Result := Result + 'IFNULL(N.' + strCampo + ', IFNULL(DN.' + strCampo + ', F.FIS_CLFSC1)))) ';
    end;
    function fMontaMensagemErro(strBloco, strClass: String): String;
    begin
      Result := 'Programa......: '+ExtractFileName(Application.ExeName)+#13#10+
                'Bloco.........: '+strBloco+#13#10+
                'Classe Erro...: '+strClass;
    end;
begin
  If (InterlockedIncrement(intLockAtualizar) = 0) Then
  Begin
    Try

      strNumDocAtu := '';
      strEspDocAtu := '';
      strCodEmpAtu := '';
      strSerieAtu  := '';

      If (qryDocumentos.Active) And (Not qryDocumentos.IsEmpty) Then
      Begin
        strNumDocAtu := qryDocumentos.FieldByName('NFE_NUMDOC').AsString;
        strEspDocAtu := qryDocumentos.FieldByName('NFE_ESPDOC').AsString;
        strCodEmpAtu := qryDocumentos.FieldByName('NFE_CODEMP').AsString;
        strSerieAtu  := qryDocumentos.FieldByName('NFE_SERIE_').AsString;
      End;

      strSQLBase := '';
      strSQLBase := strSQLBase + '(SELECT ';
      strSQLBase := strSQLBase + '  ORDEM_DOC AS ORDEM, ';
      strSQLBase := strSQLBase + '  NFE_STATUS, ';
      strSQLBase := strSQLBase + '  NFE_PNDPEC, ';
      strSQLBase := strSQLBase + '  CASE ';
      strSQLBase := strSQLBase + '    WHEN NFE_PNDPEC = 1 AND NFE_STATUS  = "EE" THEN "DE" ';
      strSQLBase := strSQLBase + '    WHEN NFE_PNDPEC = 1 AND NFE_STATUS <> "EE" THEN "DP" ';
      strSQLBase := strSQLBase + '    ELSE NFE_STATUS ';
      strSQLBase := strSQLBase + '  END AS NFE_STATUS_IMG, ';
      strSQLBase := strSQLBase + '  NFE_NUMDOC, ';
      strSQLBase := strSQLBase + '  NFE_ESPDOC, ';
      strSQLBase := strSQLBase + '  NFE_SERIE_, ';
      strSQLBase := strSQLBase + '  NFE_TIP_FC, ';
      strSQLBase := strSQLBase + '  NFE_CODCLI, ';
      strSQLBase := strSQLBase + '  NFE_CODEMP, ';
      strSQLBase := strSQLBase + '  NFE_HORINI, ';
      strSQLBase := strSQLBase + '  IF(' + fSQLCampoFis('GER_CLAFIS') + ' > 5000 OR ' + fSQLCampoFis('GER_CLAFIS') + ' IS NULL, "S", "E") AS NFE_ENTSAI, ';
      strSQLBase := strSQLBase + '  IF(NFE_TIP_FC="C", IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", ' + fSQLCampo('GER_CGCCON') + ' , CLI_C_G_C_), FOR_C_G_C_) AS NFE_DESTIN, ';
      strSQLBase := strSQLBase + '  CONCAT(NFE_CODCLI, "-", IF(NFE_TIP_FC="C", IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", IFNULL(G.GER_NOMCON, N.GER_NOMCON), CLI_NOMCLI), FOR_NOMFOR)) AS NFE_NOMCLI, ';
      strSQLBase := strSQLBase + '  NFE_DTAAUT, ';
      strSQLBase := strSQLBase + '  NFE_OBSERV, ';
      strSQLBase := strSQLBase + '  IF(IFNULL(NFE_ACESSO,"")="" AND TIMEDIFF(NOW(), NFE_HORINI) > "00:01:00", FIS_ACESSO, NFE_ACESSO) FIS_ACESSO, ';

      If NFE_PONIMP.Visible Then
        strSQLBase := strSQLBase + '  NFE_PONIMP, '
      Else
        strSQLBase := strSQLBase + '  LPAD("", 20, " ") AS NFE_PONIMP, ';

      strSQLBase := strSQLBase + '  IFNULL(G.GER_NOMCON, N.GER_NOMCON) AS GER_NOMCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_ENDCON, N.GER_ENDCON) AS GER_ENDCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_BAICON, N.GER_BAICON) AS GER_BAICON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_CEPCON, N.GER_CEPCON) AS GER_CEPCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_CIDCON, N.GER_CIDCON) AS GER_CIDCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_TELCON, N.GER_TELCON) AS GER_TELCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_CGCCPF, N.GER_CGCCPF) AS GER_CGCCPF, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_CGCCON, N.GER_CGCCON) AS GER_CGCCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_IESCON, N.GER_IESCON) AS GER_IESCON, ';
      strSQLBase := strSQLBase + '  IFNULL(G.GER_R_GCON, N.GER_R_GCON) AS GER_R_GCON, ';

      strSQLBase := strSQLBase + '  G.AUTOINCREM AS AUTOINCREM_MOVGER, ';
      strSQLBase := strSQLBase + '  N.AUTOINCREM AS AUTOINCREM_NOTGER, ';
      strSQLBase := strSQLBase + '  F.AUTOINCREM AS AUTOINCREM_CADFIS, ';
      strSQLBase := strSQLBase +    fSQLCampoFis('GER_CLAFIS') + ' AS GER_CLAFIS,     ';

      {***************************************************}
      {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
      {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
      {************************************************RV*}
      If blnEmlCon Then
        strSQLBase := strSQLBase + '  IFNULL(G.GER_EMLCON, N.GER_EMLCON) AS GER_EMLCON, ';

      strSQLBase := strSQLBase + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", "SIM" , "NAO") AS NFE_CONSUM ';

      strSQLBase := strSQLBase + 'FROM ';
      strSQLBase := strSQLBase + '  LOGNFE ';

      strSQLBase := strSQLBase + 'LEFT JOIN MOVGER G ON G.GER_NUMDOC = NFE_NUMDOC AND ';
      strSQLBase := strSQLBase + '                      G.GER_ESPDOC = NFE_ESPDOC AND ';
      strSQLBase := strSQLBase + '                      G.GER_CODEMP = NFE_CODEMP AND ';
      strSQLBase := strSQLBase + '                      IF(NFE_TIP_FC="C", G.GER_CODCLI, G.GER_CODFOR) = NFE_CODCLI AND ';
      strSQLBase := strSQLBase + '                      IFNULL(G.GER_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';

      strSQLBase := strSQLBase + 'LEFT JOIN DEL_MOVGER DG ON DG.GER_NUMDOC = NFE_NUMDOC AND ';
      strSQLBase := strSQLBase + '                           DG.GER_ESPDOC = NFE_ESPDOC AND ';
      strSQLBase := strSQLBase + '                           DG.GER_CODEMP = NFE_CODEMP AND ';
      strSQLBase := strSQLBase + '                           IF(NFE_TIP_FC="C", DG.GER_CODCLI, DG.GER_CODFOR) = NFE_CODCLI AND ';
      strSQLBase := strSQLBase + '                           IFNULL(DG.GER_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';

      strSQLBase := strSQLBase + 'LEFT JOIN NOTGER N ON N.GER_NUMDOC = NFE_NUMDOC AND ';
      strSQLBase := strSQLBase + '                      N.GER_ESPDOC = NFE_ESPDOC AND ';
      strSQLBase := strSQLBase + '                      N.GER_CODEMP = NFE_CODEMP AND ';
      strSQLBase := strSQLBase + '                      IF(NFE_TIP_FC="C", N.GER_CODCLI, N.GER_CODFOR) = NFE_CODCLI AND ';
      strSQLBase := strSQLBase + '                      IFNULL(N.GER_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';

      strSQLBase := strSQLBase + 'LEFT JOIN DEL_NOTGER DN ON DN.GER_NUMDOC = NFE_NUMDOC AND ';
      strSQLBase := strSQLBase + '                           DN.GER_ESPDOC = NFE_ESPDOC AND ';
      strSQLBase := strSQLBase + '                           DN.GER_CODEMP = NFE_CODEMP AND ';
      strSQLBase := strSQLBase + '                           IF(NFE_TIP_FC="C", DN.GER_CODCLI, DN.GER_CODFOR) = NFE_CODCLI AND ';
      strSQLBase := strSQLBase + '                           IFNULL(N.GER_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';

      strSQLBase := strSQLBase + 'LEFT JOIN CADFIS F      ON F.FIS_NUMDOC  = NFE_NUMDOC ';
      strSQLBase := strSQLBase + '                       AND F.FIS_ESPDOC  = NFE_ESPDOC ';
      strSQLBase := strSQLBase + '                       AND F.FIS_CODEMP  = NFE_CODEMP ';
      strSQLBase := strSQLBase + '                       AND F.FIS_FORCLI  = NFE_CODCLI ';
      strSQLBase := strSQLBase + '                       AND IFNULL(F.FIS_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';
      strSQLBase := strSQLBase + '                       AND F.FIS_TIP_FC = NFE_TIP_FC ';

      strSQLBase := strSQLBase + 'LEFT JOIN CADCLI ON CLI_CODCLI = NFE_CODCLI ';
      strSQLBase := strSQLBase + 'LEFT JOIN CADFOR ON FOR_CODFOR = NFE_CODCLI ';

      {************************************}
      {* ÚLTIMAS X NOTAS AUTORIZADAS.     *}
      {*********************************MV*}
      strSQL := AnsiReplaceStr(strSQLBase, 'ORDEM_DOC', '1');
      strSQL := strSQL + 'WHERE ';

      If (Not fEstaEmModoEmissaoNotaServicoCitel) Then
        If (fCfgSisPainel('USASAT') = 'S') Then
          strSQL := strSQL + '  NFE_ESPDOC <> "IF" AND ';

      strSQL := strSQL + '  ( (NFE_STATUS = "AT" AND NFE_ESPDOC <> "IF") OR NFE_STATUS = "CN" OR NFE_STATUS = "DC" OR NFE_STATUS = "IN" OR NFE_STATUS = "AM" ';
      strSQL := strSQL + '    OR NFE_STATUS = "AC") AND ';
      strSQL := strSQL + '   NFE_HORINI >= ' + QuotedStr(FormatDateTime('yyyy-MM-dd', fRetornaDataDeCorte)) + ' AND ';
      strSQL := strSQL + '   NFE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
      strSQL := strSQL + 'ORDER BY  ';
      strSQL := strSQL + '  IF(NFE_PDSTDP=1, NFE_HORINI, NFE_DTAAUT) DESC ';
      strSQL := strSQL + 'LIMIT ' + FloatToStr(edtQtdUltNot.Value) + ') ';

      strSQL := strSQL + 'UNION ALL ';

      {************************************}
      {* TODAS NOTAS NÃO AUTORIZADAS.     *}
      {*********************************MV*}
      strSQL := strSQL + AnsiReplaceStr(strSQLBase, 'ORDEM_DOC', '0');
      strSQL := strSQL + 'WHERE ';

      If (Not fEstaEmModoEmissaoNotaServicoCitel) Then
        If (fCfgSisPainel('USASAT') = 'S') Then
          strSQL := strSQL + '  NFE_ESPDOC <> "IF" AND ';

      strSQL := strSQL + '  NFE_STATUS IN ("AE", "EE", "GE", "DN", "GM", "EM", "GC", "EC", "CG", "CE", "CC", "AF") AND ';
      strSQL := strSQL + '  NFE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  NFE_HORINI) ';

      strSQL := 'SELECT * FROM (' + strSQL + ') AS DOCS ORDER BY ORDEM ASC, NFE_NUMDOC DESC, NFE_HORINI ASC, NFE_DTAAUT ASC ';

      If (Not SameText(strUltimoSQL, strSQL)) Or (Not qryDocumentos.Active) Then
      Begin
        qryDocumentos.Close;
        qryDocumentos.SQL.Clear;
        qryDocumentos.SQL.Add(strSQL);
        Try
          qryDocumentos.Open;
        Except
          {$IF Defined(UNIDAC)}
          On E: EUniError Do
            frmModulo.fGravarRelErro(E.Message, fMontaMensagemErro('qryDocumentos.Open', E.ClassName));
          {$IFEND}

          On E: Exception Do
            frmModulo.fGravarRelErro(E.Message, fMontaMensagemErro('qryDocumentos.Open', E.ClassName));
        End;
        strUltimoSQL := strSQL;
      End
      Else
      Begin
        Try
          If (qryDocumentos.Active) Then
            qryDocumentos.Refresh;
        Except
          {$IF Defined(UNIDAC)}
          On E: EUniError Do
            frmModulo.fGravarRelErro(E.Message, fMontaMensagemErro('qryDocumentos.Refresh', E.ClassName));
          {$IFEND}

          On E: Exception Do
            frmModulo.fGravarRelErro(E.Message, fMontaMensagemErro('qryDocumentos.Refresh', E.ClassName));
        End;
      End;

      If Not fEmptyStr(strNumDocAtu) Then
      Begin
        qryDocumentos.Locate('NFE_NUMDOC;NFE_ESPDOC;NFE_CODEMP;NFE_SERIE_',
          VarArrayOf([strNumDocAtu, strEspDocAtu, strCodEmpAtu, strSerieAtu]),
          []);
      End;
    Finally
      InterlockedDecrement(intLockAtualizar);
    End;
  End
  Else
    InterlockedDecrement(intLockAtualizar);
end;

procedure TfrmPrincipal.pAtualizarTituloDoPainel;
begin
  Self.Caption := 'PainelNFe - ' + IIF(blnModoClassico,'Modo Clássico', 'Multi Empresas') + ' - Emp: ' + VS_strCodEmp + '-' + fRetNomeEmpresa(VS_strCodEmp) + ' - Licença: ' + fCfgSisPainel('CITLIC');
end;

procedure TfrmPrincipal.pHabilitarBotoes;
begin
  btnAjustarMotivo.Enabled      := False;
  btnReenviar.Enabled           := False;
  btnAjustarConsumidor.Enabled  := False;
  btnAlterarNCM.Enabled         := False;
  btnReimpressao.Enabled        := False;
  btnNCMItemEsp.Visible         := False;
  pnlAFIgnorarImpressao.Visible := False;
  pnlAFImprimir.Visible         := False;

  If (fPainelVazio) Then
  Begin
    lblStatus.Align             := alBottom;
    Exit;
  End;

  If (qryDocumentos.FieldByName('NFE_STATUS').AsString = 'AF') Then
  Begin
    pnlAFImprimir.Visible         := True;
    pnlAFIgnorarImpressao.Visible := True;
  End;

  If (Pos(qryDocumentos.FieldByName('NFE_STATUS').AsString, 'EE_EC_EM_CE_CG_') > 0) Or (Pos(qryDocumentos.FieldByName('NFE_STATUS_IMG').AsString, 'DP_DE_') > 0) Then
  Begin
    btnReenviar.Enabled   := Not fEstaEmModoAtualizacaoPainelWebCitel;
    btnAlterarNCM.Enabled := Not fEstaEmModoAtualizacaoPainelWebCitel;
    If qryDocumentos.FieldByName('NFE_STATUS').AsString = 'EC' Then
    Begin
      btnAjustarMotivo.Enabled := True;
    End;
  End;

  If (btnReenviar.Enabled) And (Not btnAjustarMotivo.Enabled) And (qryDocumentos.FieldByName('NFE_CONSUM').AsString = 'SIM') Then
    btnAjustarConsumidor.Enabled := True;

  pnlCorrigirDevolucao.Visible := fNaoPossuiDocumentoReferenciado Or fDocumentoReferenciadoNaoPossuiSerie Or fNFeComplementarNaoPossuiDocumentoReferenciado;

  pnlDadosExp.Visible :=  (Pos(qryDocumentos.FieldByName('NFE_STATUS').AsString, 'EE_DE_') > 0) And (Copy(qryDocumentos.FieldByName('GER_CLAFIS').AsString, 1, 1) = '7');

  pnlRetISS.Visible := (qryDocumentos.FieldByName('NFE_ESPDOC').AsString = 'NS') And (Pos(qryDocumentos.FieldByName('NFE_STATUS').AsString, 'EE_GE_') > 0) And
                       (fCampoExiste('AUXMOV', 'AUX_RETISS')) And (fCampoExiste('CADCLI', 'CLI_RETISS'));

  If (pnlRetISS.Visible) Then
  Begin 
    If (fDocumentoRetemISS(qryDocumentos.FieldByName('AUTOINCREM_MOVGER').AsString, qryDocumentos.FieldByName('AUTOINCREM_NOTGER').AsString)) Then
      btnRetISS.Caption := 'Corrigir opção do cliente para não reter ISS'
    Else  
      btnRetISS.Caption := 'Corrigir opção do cliente para reter ISS';
  End;

  If (qryDocumentos.FieldByName('NFE_STATUS').AsString = 'AT') Then
    btnReimpressao.Enabled := True;

  btnNCMItemEsp.Visible := fExisteItemEspecial;
end;

procedure TfrmPrincipal.pInsereDadosExportacao(strAutoincremCadFis, strUFEmba,
  strLoEmba, strLocDes: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Self);
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM DOCEXP WHERE EXP_SEQFIS = :EXP_SEQFIS');
    qryAux.ParamByName('EXP_SEQFIS').AsString := strAutoincremCadFis;
    qryAux.Open;

    If qryAux.RecordCount > 0 Then
      qryAux.Edit
    Else
      qryAux.Append;

    qryAux.FieldByName('EXP_SEQFIS').AsString := strAutoincremCadFis;
    qryAux.FieldByName('EXP_UFEMBA').AsString := strUFEmba;
    qryAux.FieldByName('EXP_LOEMBA').AsString := strLoEmba;
    qryAux.FieldByName('EXP_LOCDES').AsString := strLocDes;

    qryAux.Post
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPrincipal.tmrAtualizarTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  Try
    If (Self.WindowState <> wsMinimized) Then
      pAtualizaGrid(False);

    fGetLock(VS_strCodEmp);
  Except
    If (Not tmrAtualizar.Enabled) Then
      tmrAtualizar.Enabled := True;
  End;
end;

procedure TfrmPrincipal.tmrConhecimentoTeTimer(Sender: TObject);
begin
  If blnInicializandoPainel Then
    Exit;

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit;

  tmrConhecimentoTe.Enabled := False;
  Try
    pEmitirCTe;
  Finally
    tmrConhecimentoTe.Enabled := True;
  End;
end;

procedure TfrmPrincipal.tmrConsultaCadastroTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If (fExecutaServicoConsultaCadastroDestinatario(VS_strCodEmp)) Then
    pNFeStatus(fTagComValorToParam('NFE_CONSULTA_CADASTRO', consTagParamsTrf));
end;

procedure TfrmPrincipal.tmrFechaSistemaTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  tmrFechaSistema.Enabled := False;
  Try
    Try
      If fEmptyStr(strIdConexao) Then
        strIdConexao := fConnectionID;

      If (Not FileExists(fPnlDir(strIdConexao + '.CONEXAO'))) Then
      Begin
        pEncerrarForcado;
      End;
    Except

    End;

    If VS_blnUsaFin Then
    Begin
      If (HoursBetween(VS_dtaHraFin, Time) = 0) And
         ((MinutesBetween(VS_dtaHraFin, Time) = 0) Or
         (MinutesBetween(VS_dtaHraFin, Time) <= 20)) Then
      Begin
        pEncerrarForcado;
      End;
    End;
  Finally
    tmrFechaSistema.Enabled := True;
  End;
end;

procedure TfrmPrincipal.tmrLiberaSeqDocTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;
  tmrLiberaSeqDoc.Enabled := False;
  Try
    If (Not fTemSeqDocParaLiberar) Then
      Exit;
    pLiberarSeqDoc;
  Finally
    tmrLiberaSeqDoc.Enabled := True;
  End;
end;

procedure TfrmPrincipal.tmrPendenciaDPECTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  pTarefasBasicas;
  pAtualizarPOSNAB;
end;

procedure TfrmPrincipal.tmrStatusSefazTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  btnStatusSefazClick(Sender);
end;

procedure TfrmPrincipal.tmrDFeTerceirosTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If (Not fExecutaServicoImportaXMLTerceiros) Then
    Exit;

  pNFeStatus(fTagComValorToParam('NFE_IMPORTAR_XML_TERCEIROS', consTagParamsTrf));
end;

procedure TfrmPrincipal.tmrECONFTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If (Not fExecutaServicoEventoConciliacaoFinanceira) Then
    Exit;

  pNFeStatus(fTagComValorToParam('NFE_EVENTO_CONCILIACAO_FINANCEIRA', consTagParamsTrf));
end;

function TfrmPrincipal.fTemNotasPendentesParaCoordenacao: Boolean;
  Const
    strSQLNSPendente = ' ((NFE_STATUS = "EE") AND (LOCATE("Utilize F1", NFE_OBSERV) > 0)) ';
  Var
    qryNotasPendentes: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL: String;
begin
  intTotPen := 0;
  intTotErr := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(IF((NFE_STATUS <> "EE") OR ('+strSQLNSPendente+'), 1, 0)) AS PEN, ';
  strSQL := strSQL + '  SUM(IF((NFE_STATUS = "EE") AND (NOT '+strSQLNSPendente+'), 1, 0)) AS ERR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LOGNFE ';
  strSQL := strSQL + 'WHERE NFE_STATUS IN ("EE", "AE", "GE", "GC", "GM", "CG") ';
  strSQL := strSQL + '  AND NFE_CODEMP = :CODEMP';

  If FPonImp <> '' Then
    strSQL := strSQL + '  AND ((NFE_PONIMP = "") OR (NFE_PONIMP = "' + FPonImp + '")) ';

  qryNotasPendentes := fCriaQuery(Nil);
  Try
    qryNotasPendentes.SQL.Add(strSQL);
    qryNotasPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNotasPendentes.Open;

    intTotPen := qryNotasPendentes.FieldByName('PEN').AsInteger;
    intTotErr := qryNotasPendentes.FieldByName('ERR').AsInteger;

    Result := ((intTotPen + intTotErr) > 0);

    qryNotasPendentes.Close;
  Finally
    FreeAndNil(qryNotasPendentes);
  End;
end;

function TfrmPrincipal.fDocumentoEmProcessamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String): Boolean;
  Var
    strObserv : String;
begin
  Result := False;

  If (Not Assigned(qryDocumentos)) Then
    Exit;

  If (Not qryDocumentos.Active) Then
    Exit;

  If (qryDocumentos.IsEmpty) Then
    Exit;

  If (Not Assigned(qryDocumentos.FindField('NFE_OBSERV'))) Then
    Exit;

  If (Not qryDocumentos.Locate('NFE_NUMDOC;NFE_ESPDOC;NFE_CODEMP;NFE_SERIE_;NFE_CODCLI;NFE_TIP_FC',
          VarArrayOf([strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC]),
          [])) Then
    Exit;

  strObserv := qryDocumentos.FieldByName('NFE_OBSERV').AsString;

  Result := (Pos('processando/transmitindo', AnsiLowerCase(strObserv)) > 0);
end;

function TfrmPrincipal.fTemCoordenadorStatusNFeAtivo: Boolean;
  Var
    qryTarefas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryRemover: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL : String;
begin
  Result := False;

  qryTarefas := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  NFE_TAREFA, ';
    strSQL := strSQL + '  IFNULL(NFE_PROCID, 0) AS NFE_PROCID, ';
    strSQL := strSQL + '  IF((LOCATE("'+consTagSinalParaBloquear+'", NFE_DESCRI) > 0) OR (TIMEDIFF(nOw(), NFE_ULTSTA) > "00:00:15"), "S", "N") AS NFE_SEMATU ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  NFE_TAREFAS ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  NFE_TAREFA LIKE "NFE_COORDENADOR_STATUS%" AND ';
    strSQL := strSQL + '  NFE_CODEMP = "' + VS_strCodEmp + '" ';
    qryTarefas.SQL.Add(strSQL);
    qryTarefas.Open;

    If (Not qryTarefas.IsEmpty) Then
    Begin
      Result := (Not fEmptyStr(qryTarefas.FieldByName('NFE_TAREFA').AsString));

      If Result Then
      Begin
        //NFE_SEMATU = S INDICA UM  NFE_COORDENADOR_STATUS XXX COM MAIS DE 15 SEGUNDOS
        //SEM ATUALIZAÇÃO O QUE É SUSPEITO, MAS SÓ SERÁ DADO COMO MORTO, CASO NÃO ENCONTRE
        //O EXE COM O PID
        If (qryTarefas.FieldByName('NFE_SEMATU').AsString = 'S') And (fFindProcessOK) Then
        Begin
          Try
            Result := FindProcess(qryTarefas.FieldByName('NFE_PROCID').AsInteger);

            If (Not Result) Then
            Begin
              qryRemover := fCriaQuery;
              Try
                {**************************************************************************************************}
                {* CASO NÃO ENCONTRE ABERTO O NFESTATUS.EXE COM A TAREFA NFE_COORDENADOR_STATUS XXX É PORQUE ESSE *}
                {* PODE TER SIDO MORTO POR ALGUM OUTRO PROCESSO OU MESMO MANUALMENTE PELO GERENCIADOR DE TAREFAS, *}
                {* ENTÃO, REMOVE-SE A REFERÊNCIA PARA QUE UM NOVO NFESTATUS.EXE NFE_COORDENADOR_STATUS XXX,       *}
                {* SEJA INSTANCIADO                                                                               *}
                {***********************************************************************************************VA*}
                qryRemover.SQL.Text := 'DELETE FROM NFE_TAREFAS WHERE NFE_TAREFA = :TAREFA AND NFE_PROCID = :PROCID';
                qryRemover.ParamByName('TAREFA').AsString := qryTarefas.FieldByName('NFE_TAREFA').AsString;
                qryRemover.ParamByName('PROCID').AsString := qryTarefas.FieldByName('NFE_PROCID').AsString;
                qryRemover.ExecSQL;

                SetLogDanfe;

                pLogImp('NfeStatus.exe '+qryTarefas.FieldByName('NFE_TAREFA').AsString+' de PID: '+
                        qryTarefas.FieldByName('NFE_PROCID').AsString+', não mais foi encontrado entre os processos. '+
                        'PainelNFe.exe criará um novo NfeStatus.exe '+qryTarefas.FieldByName('NFE_TAREFA').AsString);
              Finally
                FreeAndNil(qryRemover);
              End;
            End;
          Except
            On E: Exception Do
            Begin
              SetLogDanfe;

              pLogImp('TfrmPrincipal.fTemCoordenadorStatusNFeAtivo > '+E.Message);
            End;
          End;
        End;
      End;
    End;
  Finally
    If Assigned(objLogDanfe) Then
      objLogDanfe.strNumDoc := '';

    FreeAndNil(qryTarefas);
  End;
end;

procedure TfrmPrincipal.pAtualizarTarefasSendoExecutadas;
  Const
    cnstTxtSep = '------------------------------------------------------------------------------------------------------------------';
    cnstMsgAgu = '(Aguardando por novas tarefas)';
    cnstMsgErr = '(ATENÇÃO: HÁ DOCUMENTOS COM ERRO. VERIFIQUE)';
    cnstMsgExc = '(Processando)';
    cnstBasTit = 'Tarefas sendo executadas pelo NFeStatus: ';
    cnstTagTit = '<<TIT>>';
    cnstTagCpl = '<<CPL>>';

  Var
    qryTarefas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL: String;
    strMsgAux: String;
    intTempoUltimaAtualiz: Cardinal;
    intTempoUltimoProcess: Cardinal;
    intErrOuAguAposSegund: Cardinal;
    blnSomenteTarefaCoordenacao: Boolean;
    strUltimoTituloTarefa: String;
    strTituloTarefa: String;
    strCompleTitulo: String;

  procedure pRegistraTarefa(const strCpl: String='');
    Var
      strDescri: String;
  begin
    strDescri := qryTarefas.FieldByName('NFE_DESCRI').AsString;
    If (Trim(AnsiUpperCase(strDescri)) = consTagSinalParaBloquear) Then
      strDescri := 'Tarefa Interrompida (aguarde uma nova instância)';

    memTarefas.Lines.Add(FormatDateTime('hh:mm:ss', qryTarefas.FieldByName('NFE_ULTSTA').AsDateTime) + ' - ' +
       strDescri + ' (' + qryTarefas.FieldByName('NFE_TAREFA').AsString + ')' + IIF(strCpl='','',' '+strCpl));
  end;

  function fTarefaDeCoordenacao: Boolean;
  begin
    Result := (Pos('NFE_COORDENADOR_STATUS', qryTarefas.FieldByName('NFE_TAREFA').AsString) > 0);
  end;

begin
  If (Self.WindowState = wsMinimized) Then
    Exit;

  If (Not blnPainelAtivo) Then
    Exit;

  intTempoUltimaAtualiz := fSegundosToInterval(SecondsBetween(Date+Time, dtaUltimaAtualizTarefa));

  If (intTempoUltimaAtualiz < tmrStatus.Interval) Then
    Exit;

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  NFE_TAREFAS ';
  strSQL := strSQL + 'WHERE NFE_CODEMP = "' + VS_strCodEmp + '" ';
  strSQL := strSQL +  ' AND IFNULL(NFE_DESCRI, "") <> "" ';
  If blnXMLTerceirosSomenteBucket Then
   strSQL := strSQL + ' AND LOCATE("NFE_IMPORTAR_XML_TERCEIROS", NFE_TAREFA) = 0 ';
  strSQL := strSQL + 'ORDER BY NFE_INICIO, NFE_ULTSTA';

  strUltimoTituloTarefa := '';
  If memTarefas.Lines.Count > 0 Then
    strUltimoTituloTarefa := memTarefas.Lines[0];

  memTarefas.Lines.BeginUpdate;
  memTarefas.Lines.Clear;
  Try
    qryTarefas := fCriaQuery(Nil);
    blnSomenteTarefaCoordenacao := False;
    Try
      qryTarefas.SQL.Text := strSQL;
      qryTarefas.Open;

      If (Not qryTarefas.IsEmpty) Then
      Begin
        memTarefas.Lines.Add(cnstTagTit);
        memTarefas.Lines.Add(cnstTxtSep);

        //REGISTRA TAREFA COORDENAÇÃO
        qryTarefas.First;
        While Not qryTarefas.Eof Do
        Begin
          If (fTarefaDeCoordenacao) Then
          Begin
            blnSomenteTarefaCoordenacao := True;

            pRegistraTarefa('(PID ' + qryTarefas.FieldByName('NFE_PROCID').AsString + ')' + cnstTagCpl);

            If (qryTarefas.RecordCount > 1) Then
              memTarefas.Lines.Add(cnstTxtSep);

            Break;
          End;

          qryTarefas.Next;
        End;
      End;

      //REGISTRA DEMAIS TAREFAS
      qryTarefas.First;
      While Not qryTarefas.Eof Do
      Begin
        If (Not fTarefaDeCoordenacao) Then
        Begin
          blnSomenteTarefaCoordenacao := False;

          pRegistraTarefa;
        End;

        qryTarefas.Next;
      End;

      If (Not qryTarefas.IsEmpty) Then
        memTarefas.Lines.Add(cnstTxtSep);
    Finally
      //SESSÃO FINAL ONDE É FEITO OS BLINKS
      dtaUltimaAtualizTarefa := Date+Time;

      strCompleTitulo := '';

      intTempoUltimoProcess := SecondsBetween(Date+Time, dtaUltimoProcessTarefa);

      intErrOuAguAposSegund := 5;
      If (intTotErr > 0) And (fEstaEmModoEmissaoNotaServicoCitel) Then
        intErrOuAguAposSegund := 30;

      If (memTarefas.Lines.Count = 0) Then
      Begin
        strTituloTarefa := IIF(Pos(cnstMsgAgu, strUltimoTituloTarefa) > 0, '', cnstMsgAgu);

        memTarefas.Lines.Text := strTituloTarefa;
      End
      Else If blnSomenteTarefaCoordenacao And (intTempoUltimoProcess > intErrOuAguAposSegund) Then
      Begin
        strMsgAux := IIF((intTotErr > 0), cnstMsgErr, cnstMsgAgu);

        strTituloTarefa := IIF(Pos(strMsgAux, strUltimoTituloTarefa) > 0, '', strMsgAux);

        memTarefas.Lines.Text := AnsiReplaceStr(memTarefas.Lines.Text, cnstTagTit, cnstBasTit + strTituloTarefa);
      End
      Else
      Begin
        strTituloTarefa := IIF(Pos(cnstMsgExc, strUltimoTituloTarefa) > 0, '', cnstMsgExc);

        memTarefas.Lines.Text := AnsiReplaceStr(memTarefas.Lines.Text, cnstTagTit, cnstBasTit + strTituloTarefa);

        If (Not blnSomenteTarefaCoordenacao) Then
          dtaUltimoProcessTarefa := Date+Time;

        If (intTotPen > 0) Then
          strCompleTitulo := ' [' + IntToStr(intTotPen) + IIF(intTotPen=1, ' item restante', ' itens restantes') + ']';
      End;

      memTarefas.Lines.Text := AnsiReplaceStr(memTarefas.Lines.Text, cnstTagCpl, strCompleTitulo);

      memTarefas.Lines.EndUpdate;

      FreeAndNil(qryTarefas);
    End;
  Except
    //
  End;
end;

procedure TfrmPrincipal.pVerificaCondicaoCoordenadorStatusNFe;
begin
  Try
    If (MinutesBetween(Time, VS_horUltimoRemoverTarefasInativas) >= 1) Then
      pRemoverTarefasInativas;
  Except
    //
  End;

  If (SecondsBetween(Date+Time, dtaUltimaVeriNfeStatus) >= 3) Then
  Begin
    Try
      If (fTemNotasPendentesParaCoordenacao) Then
        If (Not fTemCoordenadorStatusNFeAtivo) Then
          pTarefasCoordenador;
    Finally
      dtaUltimaVeriNfeStatus := Date+Time;
    End;
  End;

  {$IF Defined(UNIDAC)}
  If (MinutesBetween(Date+Time, dtaUltimaLimpezaDicSis) >= 15) Then
  Begin
    Try
      pVerificaPrecisaLimparDicSis;
    Finally
      dtaUltimaLimpezaDicSis := Date+Time;
    End;
  End;
  {$IFEND}
end;

procedure TfrmPrincipal.pVerificaPrecisaLimparDicSis;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  {$IF Defined(UNIDAC)}
  If fTabelaExiste('DICSIS') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Text := 'SELECT COUNT(*) FROM DICSIS WHERE DIC_PIDMD5 <> "'+VS_PidGenerico_+'"';
      qryAux.Open;

      If (Not qryAux.IsEmpty) Then
        If (qryAux.Fields[0].AsInteger >= 50000) Then
          pDeletaDicSisComTempoVida(frmModulo.Database);

      qryAux.Close;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
  {$IFEND}
end;

procedure TfrmPrincipal.tmrStatusTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  tmrStatus.Enabled := False;
  Try
    pAtualizarTarefasSendoExecutadas;

    pVerificaCondicaoCoordenadorStatusNFe;
  Finally
    tmrStatus.Enabled := True;
  End;
end;

function TfrmPrincipal.fExistefReprocessaMOVREF: Boolean;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT * FROM information_schema.routines WHERE ROUTINE_NAME = "fReprocessaMOVREF" AND ROUTINE_SCHEMA = DATABASE()';
    qryAux.Open;

    Result := (qryAux.RecordCount > 0);

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fExistefReprocessaNOTREF: Boolean;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT * FROM information_schema.routines WHERE ROUTINE_NAME = "fReprocessaNOTREF" AND ROUTINE_SCHEMA = DATABASE()';
    qryAux.Open;

    Result := (qryAux.RecordCount > 0);

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fReprocessaDadosReformaTributaria: Boolean;
begin
  Result := False;

  If not fTabelaExiste('MOVREF') Then
    Exit;

  If not fTabelaExiste('NOTREF') Then
    Exit;

  If not fCampoExiste('information_schema.routines', 'ROUTINE_NAME') Then
    Exit;

  If not fExistefReprocessaMOVREF Then
    Exit;

  If not fExistefReprocessaNOTREF Then
    Exit;

  Result := True;
end;

function TfrmPrincipal.fRetornaAutoincremMOVGER(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC: String): String;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT AUTOINCREM FROM MOVGER ');
    qryAux.SQL.Add('WHERE GER_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND GER_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND GER_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND GER_TIP_FC = :TIP_FC ');

    If (strTip_FC = 'C') Then
      qryAux.SQL.Add('  AND GER_CODCLI = :FORCLI ')
    Else
      qryAux.SQL.Add('  AND GER_CODFOR = :FORCLI ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('FORCLI').AsString := strForCli;
    qryAux.Open;

    Result := qryAux.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fRetornaAutoincremNOTGER(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC: String): String;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT AUTOINCREM FROM NOTGER ');
    qryAux.SQL.Add('WHERE GER_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND GER_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND GER_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND GER_TIP_FC = :TIP_FC ');

    If (strTip_FC = 'C') Then
      qryAux.SQL.Add('  AND GER_CODCLI = :FORCLI ')
    Else
      qryAux.SQL.Add('  AND GER_CODFOR = :FORCLI ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('FORCLI').AsString := strForCli;
    qryAux.Open;

    Result := qryAux.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPrincipal.pReprocessaMOVREF(strAutoInc: String);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT fReprocessaMOVREF("'+strAutoInc+'")';
    qryAux.Open;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPrincipal.pReprocessaNOTREF(strAutoInc: String);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery();

  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT fReprocessaNOTREF("'+strAutoInc+'")';
    qryAux.Open;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPrincipal.pReprocessaDadosReformaTributaria(strNumDoc, strEspDoc, strCodEmp, strSerie, strForCli, strTip_FC: String);
var
  strAutoincrem: String;
begin
  If not fReprocessaDadosReformaTributaria Then
    Exit;

  Try
    strAutoincrem := fRetornaAutoincremMOVGER(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC);

    If not fEmptyStr(strAutoincrem) Then
    Begin
      pReprocessaMOVREF(strAutoincrem);
      Exit;
    End;

    strAutoincrem := fRetornaAutoincremNOTGER(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC);

    If not fEmptyStr(strAutoincrem) Then
      pReprocessaNOTREF(strAutoincrem);

  Except
    {$IF Defined(UNIDAC)}
    On E: Exception Do
      pGravaLogErr('PainelNFE', '[TfrmPrincipal.pReprocessaDadosReformaTributaria]'+#13+E.Message);
    {$IFEND}
  End;
end;

procedure TfrmPrincipal.pCorrigeNCMItens(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
Var
  qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL  : String;

  procedure pSetaParametros;
  begin
    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('FORCLI').AsString := strCodCli;
    qryItens.ParamByName('TIP_FC').AsString := strTip_FC;
    qryItens.ParamByName('SERIE_').AsString := strSerie;
  end;

  function fEhNcmInexistente: Boolean;
  begin
    Result := (Pos('ncm inexistente', AnsiLowerCase(qryDocumentos.FieldByName('NFE_OBSERV').AsString)) > 0);
  end;

begin
  If fDocumentoEmProcessamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) Then
    Exit;

  If not fEhNcmInexistente Then
    Exit;

  If not fCampoExiste('MOVTRI', 'DET_NCMITE') Then
    Exit;

  qryItens := fCriaQuery(Self);
  frmModulo.Database.StartTransaction;

  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' UPDATE MOVDET, MOVTRI ';
      strSQL := strSQL + '   SET MOVTRI.DET_NCMITE = (SELECT ITE_CLAIPI FROM CADITE WHERE ITE_CODITE = MOVDET.DET_CODITE LIMIT 1) ';
      strSQL := strSQL + ' WHERE MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
      strSQL := strSQL + '   AND IFNULL(MOVTRI.DET_NCMITE, "") <> "" ';
      strSQL := strSQL + '   AND MOVDET.DET_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '   AND MOVDET.DET_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '   AND MOVDET.DET_CODEMP = :CODEMP ';

      If (strTip_FC = 'C') Then
        strSQL := strSQL + '  AND MOVDET.DET_CODCLI = :FORCLI '
      Else
        strSQL := strSQL + '  AND MOVDET.DET_CODFOR = :FORCLI ';

      strSQL := strSQL + '   AND MOVDET.DET_TIP_FC = :TIP_FC ';
      strSQL := strSQL + '   AND IFNULL(MOVDET.DET_SERIE_, "") = :SERIE_ ';

      qryItens.SQL.Clear;
      qryItens.SQL.Add(strSQL);
      pSetaParametros;
      qryItens.ExecSQL;

      qryItens.Close;
      qryItens.SQL.Clear;
      qryItens.SQL.Add(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET','NOTDET'), 'MOVTRI','NOTTRI'));
      pSetaParametros;
      qryItens.ExecSQL;

      frmModulo.Database.Commit;
    Except
      On E: Exception Do
      Begin
        frmModulo.Database.Rollback;
        Raise Exception.Create('Erro ao tentar corrigir NCM dos itens: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
End;

procedure TfrmPrincipal.pReenviarDocumento;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intRow: Integer;
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strSerie:  String;
  strCodCli: String;
  strTip_FC: String;
  strStatus: String;
  strPonImp: String;
  strUltNot: String;
begin

  if dbgDocumentosView.Controller.SelectedRowCount = 0 then
  begin
    MessageDlg('Atenção'+#13+
               'Selecione a nota fiscal fiscal a ser reenviada', mtInformation, [mbOk], 0);
    exit;
  end;

  strPonImp := '';

  For intRow := 0 to dbgDocumentosView.ViewData.RowCount - 1 do
  Begin
    if dbgDocumentosView.ViewData.Rows[intRow].Selected then
    Begin
      strNumDoc := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_NUMDOC.Index] );
      strEspDoc := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_ESPDOC.Index] );
      strCodEmp := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_CODEMP.Index] );
      strSerie  := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_SERIE_.Index] );
      strCodCli := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_CODCLI.Index] );
      strTip_FC := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_TIP_FC.Index] );
      strStatus := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_STATUS.Index] );

      If (strEspDoc <> 'NS') And fUsaApenasNotaDeServicoEnotas Then
      Begin
        pMensagemOk('Essa empresa está configurada para emitir apenas NFS-e do eNotas.');
        continue;
      End;

      If pos(strStatus,'EE_DE_') > 0 Then
      Begin
        pCorrigeHoraSaida('MOVGER',strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
        pCorrigeHoraSaida('NOTGER',strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

        pCorrigeAbfItens(strNumDoc,  strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
        pCorrigePisCofins(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
        pCorrigeNCMItens(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

        If NFE_PONIMP.Visible Then
        Begin
          If fEmptyStr(TLibNfe.fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC)) Then
          Begin
            If fEmptyStr(strPonImp) Then
              strPonImp := TLibNfe.fRetPontoImpressao;
            pAtualizaPontoImpressao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strPonImp);
          End;
        End;

        If (strEspDoc = 'NS') And
           (fTemNotaServicoAnteriorPendente(strNumDoc,
                                            strCodEmp,
                                            strUltNot)) Then
        Begin
          pMensagemOk('Atenção:' + #13#10 + Format(MSG_NOTAS_SERVICO_ANTERIOR_NAO_AUTORIZADA, [strUltNot]));
          continue;
        End;

        if fValidaIEDestNaoInformada(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) then
        begin
          If (Not fDentroDoEstado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC)) Then
          begin
            pMensagemOk('Atenção:' + #13#10 +
                        'Documento: " '+strNumDoc+' " '+ #13#10 +
                        'Não é permitido reenviar pelo painel notas onde a rejeição do sefaz é ' +
                        '"IE do destinatario nao informada" pois, ao preencher a Inscrição Estadual no cadastro do cliente '+ #13#10 +
                        'o perfil da abreviação e impostos podem ter sido alterados. '+
                        'Sendo assim, é preciso cancelar a nota e emitir uma nova.');
            continue;
          end;
        end;

        if fValidaContribuinteIsentoDeInscrEstadual(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) then
        begin
          pMensagemOk('Atenção:' + #13#10 +
                      'Documento: " '+strNumDoc+' " '+ #13#10 +
                      'Não é permitido reenviar pelo painel de notas onde a rejeição do sefaz é ' +
                      '"A SEFAZ do destinatário não permite Contribuinte Isento de Inscrição Estadual", pois '+
                      'ao alterar a opção de contribuinte para não contribuinte no cadastro do cliente os impostos podem ter sido alterados. '+
                      'Sendo assim, é preciso cancelar a nota e emitir uma nova.');
          continue;
        end;

        pReprocessaDadosReformaTributaria(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

        frmModulo.Database.StartTransaction;

        Try
          qryAux := fCriaQuery(Self);

          qryAux.SQL.Add('UPDATE LOGNFE SET NFE_STATUS = "AE" WHERE');
          qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
          qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
          qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
          qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_ AND ');
          qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
          qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC AND ');
          qryAux.SQL.Add('  NFE_STATUS NOT IN ("CN","IN") ');

          qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
          qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
          qryAux.ParamByName('CODEMP').AsString := strCodEmp;
          qryAux.ParamByName('SERIE_').AsString := strSerie;
          qryAux.ParamByName('CODCLI').AsString := strCodCli;
          qryAux.ParamByName('TIP_FC').AsString := strTip_FC;

          qryAux.ExecSQL;

          FreeAndNil(qryAux);

          frmModulo.Database.Commit;
        Except
          On E: Exception Do
          Begin
            frmModulo.Database.Rollback;
            pMensagemOk(E.Message);
            Raise;
          End;
        End;

      End
      Else If (strStatus = 'EC') Then
      Begin
        fEnviarCancelamentoLibNfe(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strSerie,
                                  strCodCli,
                                  strTip_FC);
      End
      Else If (strStatus = 'EM') Then
      Begin
        fEnviarManifestoEletronico(strNumDoc, strCodEmp);
      End
      Else If (strStatus = 'CE') Or (strStatus = 'CG') Then
      Begin
        If not fProcessarRetornoConhecimentoEletronico(strNumDoc, strSerie) Then
        Begin
          fEnviarConhecimentoEletronico(strNumDoc, strSerie);
        End;
      End;

    End;

  End;

  dbgDocumentosView.Controller.ClearSelection;

end;

procedure TfrmPrincipal.pTarefasBasicas;
begin
  {$IF Defined(UNIDAC)}
  If (VS_PidMD5DicSis <> '') then
    If (Not fExisteTabelaDicSis(frmModulo.Database)) Then
      VS_PidMD5DicSis := '';
  {$IFEND}

  If fEstaEmModoEmissaoNotaServicoCitel Then
    Exit;

  {******************************************************************************}
  {* A EMPRESA DA TAREFA NÃO PRECISA/DEVE COMPOR O NOME DA TAREFA POIS A FUNÇÃO *}
  {* pNFeStatus INCORPORA INVARIAVELMENTE A EMPRESA COMO UM DOS PARÂMETROS      *}
  {* FORMANDO O NOME DA TAREFA NÃO DUPLICANDO NA TABELA NFE_TAREFAS OBSERVE AS  *}
  {* CHAMADAS ABAIXO:                                                           *}
  {***************************************************************************VA*}

  If (fExecutaServicoPendenciasDPEC(VS_strCodEmp)) Then
    pNFeStatus(fTagComValorToParam('NFE_PENDENCIAS_DPEC', consTagParamsTrf));

  If (fExecutaServicoConfirmarXMLGravacao(VS_strCodEmp)) Then
    pNFeStatus(fTagComValorToParam('NFE_CONFIRMAR_GRAVACAO_XML', consTagParamsTrf));

  If fExecutaServicoLimparDanfes Then
    pNFeStatus(fTagComValorToParam('NFE_LIMPAR_DANFES', consTagParamsTrf) +
               fTagComValorToParam(FloatToStr(edtApgTmp.Value), consTagParamsMin));

  If (fExecutaServicoEnviarXMLSat(VS_strCodEmp)) Then
    pNFeStatus(fTagComValorToParam('NFE_ENVIAR_XML_SAT', consTagParamsTrf));

  If (fExecutaServicoConsultaCadastroDestinatario(VS_strCodEmp)) Then
    pNFeStatus(fTagComValorToParam('NFE_CONSULTA_CADASTRO', consTagParamsTrf));

  If (fExecutaServicoImportaXMLTerceiros) Then
    pNFeStatus(fTagComValorToParam('NFE_IMPORTAR_XML_TERCEIROS', consTagParamsTrf));

  If (fExecutaServicoComplementarDocumento) Then
    pNFeStatus(fTagComValorToParam('NFE_COMPLEMENTAR_DOCUMENTO', consTagParamsTrf));

  If (fExecutaServicoAuditarDocumento) Then
    pNFeStatus(fTagComValorToParam('NFE_AUDITAR_DOCUMENTO', consTagParamsTrf));

  If (fExecutaServicoEventoConciliacaoFinanceira) Then
    pNFeStatus(fTagComValorToParam('NFE_EVENTO_CONCILIACAO_FINANCEIRA', consTagParamsTrf));
end;

procedure TfrmPrincipal.pTarefasCoordenador;
begin
  pNFeStatus(fTagComValorToParam('NFE_COORDENADOR_STATUS', consTagParamsTrf));
end;

procedure TfrmPrincipal.pTarefasPainelCitel(const strStatus: String);

  function fChamaTarefaPainelCitel: Boolean;
  begin
    Result := False;

    If fIntegracaoPainelCitelConfigurada(VS_strCodEmp, frmModulo.Database) Then
    Begin
      If fExistemRegistrosPendentesIntegracaoPainelCitel(strStatus, VS_strCodEmp, frmModulo.Database) Then
      Begin
        Result := True;
        Exit;
      End;

      If (Not fExecutaServicoImportaXMLTerceiros) Then
      Begin
        If fIntegracaoPainelCitelDownloadNotasDeTerceirosConfigurada(VS_strCodEmp, frmModulo.Database) Then
        Begin
          Result := True;
          Exit;
        End;

        If fIntegracaoPainelCitelDownloadConhecimentosDeTerceirosConfigurada(VS_strCodEmp, frmModulo.Database) Then
        Begin
          Result := True;
          Exit;
        End;
      End;
    End;
  end;

begin
  If fChamaTarefaPainelCitel Then
  Begin
    pNFeStatus(fTagComValorToParam('NFE_PAINEL_CITEL', consTagParamsTrf) +
               fTagComValorToParam(strStatus,          consTagParamsSta));
  End;
end;

procedure TfrmPrincipal.qryDocumentosAfterScroll(DataSet: TDataSet);
begin
  If (Not DataSet.Active) Or (DataSet.IsEmpty) Or (DataSet.ControlsDisabled) Or (DataSet.FindField('NFE_STATUS_IMG') = Nil) Then
  Begin
    Exit;
  End;

  memMsg.Lines.Clear;

  If DataSet.FieldByName('NFE_STATUS_IMG').AsString = 'DP' Then
  Begin
    memMsg.Lines.Add('Essa nota será retransmitida automaticamente para a SEFAZ ' +
    'em um prazo de até 1 dia útil após a normalização do SEFAZ.');
  End;

  memMsg.Lines.Add(DataSet.FieldByName('NFE_OBSERV').AsString);

  If (DataSet.FieldByName('NFE_STATUS').AsString = 'EE') Then
  Begin
    pComplementarMensagemDeErro(DataSet.FieldByName('NFE_OBSERV').AsString,
                                DataSet.FieldByName('NFE_NUMDOC').AsString,
                                DataSet.FieldByName('NFE_ESPDOC').AsString,
                                DataSet.FieldByName('NFE_CODEMP').AsString,
                                DataSet.FieldByName('NFE_CODCLI').AsString,
                                DataSet.FieldByName('NFE_TIP_FC').AsString,
                                DataSet.FieldByName('NFE_SERIE_').AsString);
  End;

  pHabilitarBotoes;
end;

procedure TfrmPrincipal.pCorrigeAbfItens(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
  Var
    qryItens: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL  : String;

  procedure pSetaParametros;
  begin
    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('FORCLI').AsString := strCodCli;
    qryItens.ParamByName('TIP_FC').AsString := strTip_FC;
    qryItens.ParamByName('SERIE_').AsString := strSerie;
  end;
begin
  If fDocumentoEmProcessamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) Then
    Exit;
  qryItens := fCriaQuery(Self);
  frmModulo.Database.StartTransaction;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' UPDATE MOVDET ';
      strSQL := strSQL + '    SET DET_CODFIS = "010" ';
      strSQL := strSQL + '  WHERE DET_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '    AND DET_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '    AND DET_CODEMP = :CODEMP ';

      If (strTip_FC = 'C') Then
        strSQL := strSQL + '  AND DET_CODCLI = :FORCLI '
      Else
        strSQL := strSQL + '  AND DET_CODFOR = :FORCLI ';

      strSQL := strSQL + '    AND DET_TIP_FC = :TIP_FC ';
      strSQL := strSQL + '    AND IFNULL(DET_SERIE_, "") = :SERIE_ ';
      strSQL := strSQL + '    AND DET_CODFIS = "060" ';
      strSQL := strSQL + '    AND (IFNULL(DET_VALRET,0) + IFNULL(DET_VALIPI,0)) > 0 ';

      qryItens.SQL.Clear;
      qryItens.SQL.Add(strSQL);
      pSetaParametros;
      qryItens.ExecSQL;

      qryItens.Close;
      qryItens.SQL.Clear;
      qryItens.SQL.Add(AnsiReplaceStr(strSQL, 'MOVDET','NOTDET'));
      pSetaParametros;
      qryItens.ExecSQL;

      frmModulo.Database.Commit;
    Except
      On E: Exception Do
      Begin
        frmModulo.Database.Rollback;
        Raise Exception.Create('Erro ao tentar corrigir Abf dos itens: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
End;

procedure TfrmPrincipal.pAtualizaPontoImpressao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strPonImp: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL: String;
begin
  Try
    qryAux   := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   LOGNFE ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   NFE_PONIMP = :PONIMP ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   NFE_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   NFE_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   NFE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   NFE_CODCLI = :FORCLI AND ';
    strSQL := strSQL + '   NFE_TIP_FC = :TIP_FC AND ';
    strSQL := strSQL + '   IFNULL(NFE_SERIE_, "") = :SERIE_ ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('PONIMP').AsString := strPonImp;

    qryAux.ExecSQL;

    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryAux);
      Raise Exception.Create('Erro ao tentar atualizar o ponto de impressão: ' + E.Message);
    End;
  End;
end;

procedure TfrmPrincipal.pCorrigeHoraSaida(strTabela, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
  Var
    qryObs: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL,
    strObs : String;

  procedure pSetaParametros;
  begin
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
  end;
begin
  strObs := Iif(strTabela = 'MOVGER', 'MOVOBS', 'NOTOBS');

  If Not fTabelaExiste(strObs) Then
    Exit;

  If Not fCampoExiste(strObs, 'MOV_DTESNF') Then
    Exit;

  If Not fCampoExiste(strObs, 'MOV_HRESNF') Then
    Exit;

  Try
    qryObs := fCriaQuery(Self);
    qryAux   := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  MOV_DTESNF, ';
    strSQL := strSQL + '  MOV_HRESNF, ';
    strSQL := strSQL + '  GER_DTAENT, ';
    strSQL := strSQL + '  GER_HORENT, ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL +    strTabela    ;
    strSQL := strSQL + '  INNER JOIN ' + strObs + ' ON MOV_SEQGER = AUTOINCREM ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :FORCLI AND ';
    strSQL := strSQL + '  GER_TIP_FC = :TIP_FC AND ';
    strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    pSetaParametros;
    qryAux.Open;

    If (qryAux.RecordCount > 0) And
       ((qryAux.FieldByName('MOV_DTESNF').AsDateTime + qryAux.FieldByName('MOV_HRESNF').AsDateTime) <
       (qryAux.FieldByName('GER_DTAENT').AsDateTime + qryAux.FieldByName('GER_HORENT').AsDateTime)) Then
    Begin

      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL +     strObs;
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   MOV_DTESNF = :DTESNF, ';
      strSQL := strSQL + '   MOV_HRESNF = :HRESNF ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   MOV_SEQGER = :SEQGER ';

      qryObs.SQL.Clear;
      qryObs.SQL.Add(strSQL);
      qryObs.ParamByName('DTESNF').AsDateTime := qryAux.FieldByName('GER_DTAENT').AsDateTime;
      qryObs.ParamByName('HRESNF').AsDateTime := qryAux.FieldByName('GER_HORENT').AsDateTime;
      qryObs.ParamByName('SEQGER').AsString   := qryAux.FieldByName('AUTOINCREM').AsString;
      qryObs.ExecSQL;

    End;

    FreeAndNil(qryObs);
    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryObs);
      FreeAndNil(qryAux);
      Raise Exception.Create('Erro ao tentar corrigir Hora de Saída: ' + E.Message);
    End;
  End;
end;

procedure TfrmPrincipal.pCorrigePisCofins(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
  Var
    qryFis: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryDet: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    qryUpd: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  procedure pSetaParam(qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
  begin
    qry.ParamByName('NUMDOC').AsString := strNumDoc;
    qry.ParamByName('ESPDOC').AsString := strEspDoc;
    qry.ParamByName('CODEMP').AsString := strCodEmp;
    qry.ParamByName('FORCLI').AsString := strCodCli;
    qry.ParamByName('TIP_FC').AsString := strTip_FC;
    qry.ParamByName('SERIE_').AsString := strSerie;
  end;
begin

  If Not fCampoExiste('MOVTRI', 'DET_BASPIS') Then
    Exit;

  qryFis := fCriaQuery;
  qryFis.SQL.Add('SELECT FIS_BASPIS, FIS_TOTPIS, FIS_BASCOF, FIS_TOTCOF FROM CADFIS ');
  qryFis.SQL.Add('WHERE ');
  qryFis.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryFis.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryFis.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryFis.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
  qryFis.SQL.Add('  FIS_SERIE_ = :SERIE_ AND ');
  qryFis.SQL.Add('  FIS_TIP_FC = :TIP_FC ');
  pSetaParam(qryFis);
  qryFis.Open;

  qryDet := fCriaQuery;
  qryDet.SQL.Add('SELECT ');
  qryDet.SQL.Add('  COUNT(1) AS QTD,');
  qryDet.SQL.Add('  SUM(MOVTRI.DET_BASPIS) AS BASPIS,');
  qryDet.SQL.Add('  SUM(MOVTRI.DET_VALPIS) AS VALPIS,');
  qryDet.SQL.Add('  SUM(MOVTRI.DET_BASCOF) AS BASCOF,');
  qryDet.SQL.Add('  SUM(MOVTRI.DET_VALCOF) AS VALCOF ');
  qryDet.SQL.Add('FROM ');
  qryDet.SQL.Add('  MOVDET');
  qryDet.SQL.Add('  JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ');
  qryDet.SQL.Add('WHERE ');
  qryDet.SQL.Add('  IFNULL(DET_PROEMB, "N") <> "S" AND ');
  qryDet.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryDet.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryDet.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryDet.SQL.Add('  IF(DET_TIP_FC="C", DET_CODCLI, DET_CODFOR) = :FORCLI AND ');
  qryDet.SQL.Add('  DET_SERIE_ = :SERIE_ AND ');
  qryDet.SQL.Add('  DET_TIP_FC = :TIP_FC ');
  pSetaParam(qryDet);
  qryDet.Open;

  If qryDet.FieldByName('QTD').AsInteger <= 0 Then
  Begin
    qryDet.Close;
    qryDet.SQL.Text := AnsiReplaceText(AnsiReplaceText(qryDet.SQL.Text, 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI');
    pSetaParam(qryDet);
    qryDet.Open;
  End;

  If (fFormataFloat(qryFis.FieldByName('FIS_BASPIS').AsFloat, 2) <> fFormataFloat(qryDet.FieldByName('BASPIS').AsFloat, 2)) Or
     (fFormataFloat(qryFis.FieldByName('FIS_TOTPIS').AsFloat, 2) <> fFormataFloat(qryDet.FieldByName('VALPIS').AsFloat, 2)) Or
     (fFormataFloat(qryFis.FieldByName('FIS_BASCOF').AsFloat, 2) <> fFormataFloat(qryDet.FieldByName('BASCOF').AsFloat, 2)) Or
     (fFormataFloat(qryFis.FieldByName('FIS_TOTCOF').AsFloat, 2) <> fFormataFloat(qryDet.FieldByName('VALCOF').AsFloat, 2)) Then
  Begin

    If qryDet.FieldByName('QTD').AsInteger > 0 Then
    Begin
      qryUpd := fCriaQuery;
      qryUpd.SQL.Add('UPDATE CADFIS SET ');
      qryUpd.SQL.Add('  FIS_BASPIS = :BASPIS, ');
      qryUpd.SQL.Add('  FIS_TOTPIS = :TOTPIS, ');
      qryUpd.SQL.Add('  FIS_BASCOF = :BASCOF, ');
      qryUpd.SQL.Add('  FIS_TOTCOF = :TOTCOF ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      qryUpd.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
      qryUpd.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
      qryUpd.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
      qryUpd.SQL.Add('  FIS_SERIE_ = :SERIE_ AND ');
      qryUpd.SQL.Add('  FIS_TIP_FC = :TIP_FC ');

      qryUpd.ParamByName('BASPIS').AsFloat := qryDet.FieldByName('BASPIS').AsFloat;
      qryUpd.ParamByName('TOTPIS').AsFloat := qryDet.FieldByName('VALPIS').AsFloat;
      qryUpd.ParamByName('BASCOF').AsFloat := qryDet.FieldByName('BASCOF').AsFloat;
      qryUpd.ParamByName('TOTCOF').AsFloat := qryDet.FieldByName('VALCOF').AsFloat;

      pSetaParam(qryUpd);
      qryUpd.ExecSQL;

      FreeAndNil(qryUpd);
    End;
  End;

  FreeAndNil(qryDet);
  FreeAndNil(qryFis);

end;

procedure TfrmPrincipal.pEmitirCTe;
var
  qryCte:  {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: string;
begin
  qryCte := fCriaQuery();
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTE_NUMCTE, ';
    strSQL := strSQL + '  CTE_SERIE_  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCTE ';
    strSQL := strSQL + '  LEFT JOIN LOGNFE CT ON CT.NFE_NUMDOC = CTE_NUMCTE ';
    strSQL := strSQL + '                     AND CT.NFE_ESPDOC = "CT" ';
    strSQL := strSQL + '                     AND CT.NFE_CODEMP = CTE_CODEMP ';
    strSQL := strSQL + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  JOIN CADFIS ON GER_NUMDOC = FIS_NUMDOC ';
    strSQL := strSQL + '             AND GER_ESPDOC = FIS_ESPDOC ';
    strSQL := strSQL + '             AND GER_SERIE_ = FIS_SERIE_ ';
    strSQL := strSQL + '             AND GER_CODEMP = FIS_CODEMP ';
    strSQL := strSQL + '             AND GER_TIP_FC = FIS_TIP_FC ';
    strSQL := strSQL + '             AND IFNULL(GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';
    strSQL := strSQL + '  JOIN LOGNFE AS DF ON DF.NFE_NUMDOC = FIS_NUMDOC ';
    strSQL := strSQL + '                   AND DF.NFE_ESPDOC = FIS_ESPDOC ';
    strSQL := strSQL + '                   AND DF.NFE_CODEMP = FIS_CODEMP ';
    strSQL := strSQL + '                   AND DF.NFE_CODCLI = FIS_FORCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTE_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND DF.NFE_STATUS = "AT" ';
    strSQL := strSQL + '  AND IFNULL(CT.NFE_NUMDOC, "") = "" ';
    strSQL := strSQL + '  AND IFNULL(CTE_ACESSO, "") = "" ';
    strSQL := strSQL + '  AND IFNULL(FIS_ACESSO, "") <> "" ';
    qryCte.SQL.Add(strSQL);
    strSQL := AnsiReplaceStr(strSQL, 'MOVCTE', 'NOTCTE');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
    qryCte.SQL.Add('UNION ALL ');
    qryCte.SQL.Add(strSQL);

    qryCte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCte.Open;

    while not qryCte.Eof do
    begin
      fEnviarConhecimentoEletronico(qryCte.FieldByName('CTE_NUMCTE').AsString,
                                    qryCte.FieldByName('CTE_SERIE_').AsString);
      Sleep(5000);

      qryCte.Next;
    end;
  finally
    FreeAndNil(qryCte);
  end;
end;

function TfrmPrincipal.fPainelVazio: Boolean;
begin
  Result := False;

  If (Not Assigned(qryDocumentos)) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not qryDocumentos.Active) Then
  Begin
    Result := True;
    Exit;
  End;

  If (qryDocumentos.IsEmpty) Then
  Begin
    Result := True;
    Exit;
  End;
end;

function TfrmPrincipal.fPodeExecutarFuncaoDoTimer: Boolean;
begin
  Result := False;

  If blnInicializandoPainel Then
    Exit;

  If (Not Assigned(frmModulo)) Then
    Exit;

  If (TfrmConectando.fTentandoReconectarModulo) Then
    Exit;

  If (Not frmModulo.Database.Connected) Then
    Exit;

  Result := True;
end;

function TfrmPrincipal.fRetornaDataDeCorte: TDateTime;
begin
  Result := Date - edtQtdDiasNfAut.Value;
end;

function TfrmPrincipal.fRetornaTabelaNota(strAutIncMOVGER,
  strAutIncNOTGER: string; var strTblNota: string): string;
begin
  strTblNota := IIF(Not fEmptyStr(strAutIncMOVGER), 'AUXMOV', 'AUXNOT');
  Result     := IIF(Not fEmptyStr(strAutIncMOVGER), strAutIncMOVGER, strAutIncNOTGER);
end;

function TfrmPrincipal.fSefazParalizado: Boolean;
begin
  Result := (lblStatus.Caption = 'SEFAZ PARALISADO');

  If Result Then
    btnStatusSefaz.Click;
end;

procedure TfrmPrincipal.pAtualizaGrid(blnFocar: Boolean);
  Var
    prcScroll: TprcScroll;
begin
  tmrAtualizar.Enabled := False;

  pDisableControls(qryDocumentos, prcScroll);
  Try
    Try
      pAtualizarDocumentos;
    Except
      Sleep(3000);
      pAtualizarDocumentos;
    End;
  Finally
    pAtualizarTarefasSendoExecutadas;

    pEnableControls(qryDocumentos, prcScroll);
    qryDocumentosAfterScroll(qryDocumentos);

    If blnFocar Then
      pSetFocus(dbgDocumentos);

    tmrAtualizar.Enabled := True;
  End;
end;

function TfrmPrincipal.fEstaEmModoAtualizacaoPainelWebCitel: Boolean;
begin
  Result := False;

  If (VS_ExecutarApenasTarefasPainelWebCitel = 'S') Then
  Begin
    Result := True;

    lblStatus.Caption := 'OPERANDO EM MODO ATUALIZAÇÃO PAINEL CITEL';
    lblStatus.Font.Color := clOlive;
  End;
end;

function TfrmPrincipal.fEstaEmModoEmissaoNotaServicoCitel: Boolean;
  const
    cnsLabelStatus = 'OPERANDO EM MODO EMISSÃO DE NOTAS DE SERVIÇO CITEL';
begin
  If (FEmissaoNotaServicoCitel = '') Then
  Begin
    Try
      FEmissaoNotaServicoCitel := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_AXCFNS', VS_strCodEmp], frmModulo.Database);
    Finally
      If (FEmissaoNotaServicoCitel <> 'S') Then
        FEmissaoNotaServicoCitel := 'N';
    End;
  End;

  Result := (FEmissaoNotaServicoCitel = 'S');

  If Result Then
  Begin
    If (lblStatus.Caption <> cnsLabelStatus) Then
    Begin
      lblStatus.Caption := cnsLabelStatus;
      lblStatus.Font.Color := clOlive;
    End;
  End;
end;

function TfrmPrincipal.fDentroDoEstado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String) : Boolean;
Var
  strSQL: String;
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT GER_ESTADO, AUX_VENPRE, CID_ESTADO  ';
      strSQL := strSQL + '  FROM MOVGER  ';
      strSQL := strSQL + '  JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
      strSQL := strSQL + '  JOIN CADEMP ON EMP_CODEMP = GER_CODEMP ';
      strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
      strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '   AND GER_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '   AND GER_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND GER_SERIE_ = :SERIE  ';
      strSQL := strSQL + '   AND GER_CODCLI = :CODCLI ';
      strSQL := strSQL + '   AND GER_TIP_FC = :TIP_FC ';

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('SERIE').AsString  := strSerie;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
      qryAux.Open;

      If (qryAux.IsEmpty) Then
      Begin
        strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT');
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strSQL);
        qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
        qryAux.ParamByName('CODEMP').AsString := strCodEmp;
        qryAux.ParamByName('SERIE').AsString  := strSerie;
        qryAux.ParamByName('CODCLI').AsString := strCodCli;
        qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
        qryAux.Open;
      End;

      Result := True;

      If (Not qryAux.IsEmpty) Then
      Begin
        Result := (qryAux.FieldByName('AUX_VENPRE').AsString = 'S') or
                  (qryAux.FieldByName('GER_ESTADO').AsString = qryAux.FieldByName('CID_ESTADO').AsString);
      End;
    Except
      On E: Exception Do
      Begin
        Result := True;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmPrincipal.fValidaIEDestNaoInformada(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String) : Boolean;
Var
  strSQL: String;
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  Try
    qryAux := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT    ';
    strSQL := strSQL + '  NFE_NUMDOC  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  LOGNFE  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  NFE_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  NFE_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  NFE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  NFE_SERIE_ = :SERIE  AND ';
    strSQL := strSQL + '  NFE_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  NFE_TIP_FC = :TIP_FC AND ';
    strSQL := strSQL + '  NFE_OBSERV LIKE("%IE do destinatario nao informada%")';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('SERIE').AsString  := strSerie;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.Open;

    Result := (Not qryAux.IsEmpty);

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmPrincipal.fValidaContribuinteIsentoDeInscrEstadual(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC : String) : Boolean;
Var
  strSQL: String;
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  Try
    qryAux := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT    ';
    strSQL := strSQL + '  NFE_NUMDOC  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  LOGNFE  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  NFE_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  NFE_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  NFE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  NFE_SERIE_ = :SERIE  AND ';
    strSQL := strSQL + '  NFE_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  NFE_TIP_FC = :TIP_FC AND ';
    strSQL := strSQL + '  NFE_OBSERV LIKE("%A SEFAZ do destinatário não permite Contribuinte Isento%")';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('SERIE').AsString  := strSerie;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.Open;

    Result := (Not qryAux.IsEmpty);

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmPrincipal.fInstalarMicrosoftVisualC: Boolean;
var
  strAplicativo: String;
begin
  Result := False;

  strAplicativo := ExtractFilePath(Application.ExeName) + 'VC_redist.x64.exe';

  If not FileExists(strAplicativo) Then
    Exit;

  If not fUsuarioWindowsComDireitoDeAcesso Then
    Exit;

  If fAplicativoInstalado('Microsoft Visual C++') Then
    Exit;

  Result := True;
end;

procedure TfrmPrincipal.pInstaladorMicrosoftVisualC;
begin
  Try
    Application.CreateForm(TfrmGravando, frmGravando);
    frmGravando.strChave := 'PAINELNFE';
    frmGravando.lblGravando.Caption := 'Aguarde... Instalando Microsoft Visual C++.';
    frmGravando.fExecutarAcaoMetodo := fInstaladorMicrosoftVisualC;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmPrincipal.fInstaladorMicrosoftVisualC(pgbSts: TcxProgressBar): Boolean;
var
  strComando: String;
begin
  Result := False;

  Try
    strComando := 'VC_redist.x64.exe /install /quiet';
    ShellExecuteAndWait('', 'cmd.exe', PWideChar( '/C ' + strComando), '', SW_HIDE, True);
    Result := True;
  Except
    On E: Exception Do
    Begin
      MessageDlg('Ocorreu um erro na instalação do Microsoft Visual C++ 2015'+#13+
                 E.Message, mtInformation, [mbOk], 0);
    End;
  End;
end;

procedure TfrmPrincipal.tmrPainelCitelTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  pTarefasPainelCitel('GE');
  pTarefasPainelCitel('EE');
end;

procedure TfrmPrincipal.tmrPainelCitelCorrecaoTimer(Sender: TObject);
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If (blnForcandoCorrecaoPainelWebCitel) Then
    Exit;

  pTarefasPainelCitel('GR');
end;

procedure TfrmPrincipal.pForcarCorrecaoPainelWebCitel;
begin
  If blnInicializandoPainel Then
    Exit;

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit;

  pTarefasPainelCitel('GR');
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    blnAux: Boolean;
begin
  If (Shift = ([ssCtrl, ssAlt, ssShift])) And (Key = VK_F12) Then
  Begin
    blnForcandoCorrecaoPainelWebCitel := True;
    Try
      pForcarCorrecaoPainelWebCitel;
    Finally
      blnForcandoCorrecaoPainelWebCitel := False;
    End;
  End;

  //Antecipar atualização do VS_dicDicSis, Ctrl+D+Delete
  {$IF Defined(UNIDAC)}
  If (GetAsyncKeyState(VK_CONTROL) < 0) And
     (GetAsyncKeyState(Ord('D')) < 0) And
     (GetAsyncKeyState(VK_DELETE) < 0) Then
  Begin
    pSinalizarAoCoordenadorStatusParaSeAutoBloquear;
    pAtrasaDataHoraDicSis(frmModulo.Database);
    pSetaPidMD5DicSisLibNfe(VS_PidMD5DicSis);
    VS_dicDicSis.Clear;
    VS_dicDicSis.TrimExcess;

    Application.MessageBox('Dicionário de configurações reiniciado com sucesso!', 'Atenção', MB_OK+MB_ICONINFORMATION);

    blnAux := tmrPendenciaDPEC.Enabled;
    Try
      tmrPendenciaDPEC.Enabled := False;
      pTarefasBasicas;
    Finally
      tmrPendenciaDPEC.Enabled := blnAux;
    End;
  End;
  {$IFEND}
end;

procedure TfrmPrincipal.btnAFImprimirClick(Sender: TObject);
begin
  pCorrigeAF(True);
end;

procedure TfrmPrincipal.btnAFIgnorarImpressaoClick(Sender: TObject);
begin
  pCorrigeAF(False);
end;

procedure TfrmPrincipal.pImprimirAF(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strAcesso: String);
var
  strPonImp: String;
begin

  If NFE_PONIMP.Visible Then
  Begin
    If fEmptyStr(TLibNfe.fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC)) Then
    Begin
      If fEmptyStr(strPonImp) Then
        strPonImp := TLibNfe.fRetPontoImpressao;
      pAtualizaPontoImpressao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strPonImp);
    End;
  End;

  pReimprimirDanfe(strAcesso,
                   strNumDoc,
                   strEspDoc,
                   strCodEmp,
                   strSerie,
                   strCodCli,
                   strTip_FC);
end;

procedure TfrmPrincipal.pCorrigeAF(AImprimir: Boolean);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intRow: integer;
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strSerie: String;
  strCodCli: String;
  strTip_FC: String;
  strStatus: String;
  strAcesso: String;
begin
  if dbgDocumentosView.Controller.SelectedRowCount = 0 then
  begin
    MessageDlg('Atenção'+#13+
               'Selecione a nota fiscal fiscal e tente novamente', mtInformation, [mbOk], 0);
    exit;
  end;

  qryAux := fCriaQuery(Self);

  Try
    For intRow := 0 to dbgDocumentosView.ViewData.RowCount - 1 do
    Begin
      if dbgDocumentosView.ViewData.Rows[intRow].Selected then
      Begin
        strNumDoc := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_NUMDOC.Index] );
        strEspDoc := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_ESPDOC.Index] );
        strCodEmp := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_CODEMP.Index] );
        strSerie  := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_SERIE_.Index] );
        strCodCli := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_CODCLI.Index] );
        strTip_FC := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_TIP_FC.Index] );
        strStatus := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[NFE_STATUS.Index] );
        strAcesso := varToStr( dbgDocumentosView.ViewData.Rows[intRow].Values[FIS_ACESSO.Index] );

        If strStatus = 'AF' Then
        Begin
          qryAux.SQL.Clear;
          qryAux.SQL.Add('UPDATE LOGNFE SET NFE_STATUS = "AT" WHERE');
          qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
          qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
          qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
          qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_ AND ');
          qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
          qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC AND ');
          qryAux.SQL.Add('  NFE_STATUS = "AF" ');

          qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
          qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
          qryAux.ParamByName('CODEMP').AsString := strCodEmp;
          qryAux.ParamByName('SERIE_').AsString := strSerie ;
          qryAux.ParamByName('CODCLI').AsString := strCodCli;
          qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
          qryAux.ExecSQL;
        end;

        If AImprimir Then
          pImprimirAF(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strAcesso);
      end;
    end;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fExisteLicencaFIT: Boolean;
Begin
  Result := False;

  If fEmptyStr(fCfgSisPainel('CITLIC')) Then
    Exit;

  Result := True;
End;

function TfrmPrincipal.fUsaNotaDeServicoEnotas: Boolean;
Begin
  Result := (fCfgSisPainel('NFSENO') = 'S');
End;

function TfrmPrincipal.fUsaApenasNotaDeServicoEnotas: Boolean;
Begin
  Result := False;

  If fExisteLicencaFIT Then
    Exit;

  If not fUsaNotaDeServicoEnotas Then
    Exit;

  Result := True;
End;

function TfrmPrincipal.fUsaDocumentoFiscalEletronico : Boolean;
begin
  Result := True;
  If (fCfgSisPainel('NFEUSA') = 'S') Then
    Exit;
  If (fCfgSisPainel('USNFCE') = 'S') Then
    Exit;
  If (fCfgSisPainel('USASAT') = 'S') Then
    Exit;
  Result := False;
end;

procedure TfrmPrincipal.pAtualizarPOSNAB;
  Const
    AVISA : String = 'A';
    TRAVA : String = 'T';
begin
  If (Not blnAtualizaPOSNABDeFormaAutomatica) Then
    Exit;
  If (Not fUsaDocumentoFiscalEletronico) Then
    Exit;
  If (fCfgSisPainel('NFEUSA') = 'S') Then
  Begin
    If fExisteDocumentosEmContingenciaComPendenciaDeAutorizacao('') Then
      pUpdateCfgSis('POSNAB', VS_strCodEmp, AVISA)
    Else
      pUpdateCfgSis('POSNAB', VS_strCodEmp, TRAVA);
    Exit;
  End;
  If fExisteDocumentosEmContingenciaComPendenciaDeAutorizacao('IF') Then
    pUpdateCfgSis('POSNAB', VS_strCodEmp, AVISA)
  Else
    pUpdateCfgSis('POSNAB', VS_strCodEmp, TRAVA);
end;

procedure TfrmPrincipal.pComplementarMensagemDeErro(const strErro, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_FC, strSerie : String);
  Var
    strUltimoRetorno : String;
    strMsgErro : String;
begin
  If (Not fTabelaExiste('LOGFIT')) Then
    Exit;
  strMsgErro := Copy(strErro, 1, 30);
  If (Pos('HASH DO ARQUIVO TXT', UpperCase(strMsgErro)) <= 0) Then
    Exit;
  strUltimoRetorno := fUltimoRetornoDoDocumento(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_FC, strSerie);
  If fEmptyStr(strUltimoRetorno) Then
    Exit;
  memMsg.Lines.Add(strUltimoRetorno);
end;

function TfrmPrincipal.fUltimoRetornoDoDocumento(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_FC, strSerie : String) : String;
  Var
    qryAux : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Self);
  Try
    Result := '';
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT NFE_ARQUIV ');
    qryAux.SQL.Add('   FROM LOGFIT ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_FORCLI = :FORCLI ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('    AND NFE_TIPARQ = :TIPARQ ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('TIPARQ').AsString := 'RETORNO';
    qryAux.Open;
    If (qryAux.IsEmpty) Then
      Exit;
    Result := qryAux.FieldByName('NFE_ARQUIV').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPrincipal.fIntervaloDaConsultaCadastral : Integer;
  Var
    strTMPCNC : String;
begin
  strTMPCNC := fCfgSisPainel('TMPCNC');
  If (fEmptyStr(strTMPCNC)) Or (strTMPCNC = '0') Then
    strTMPCNC := '30';
  Result := fSegundosToInterval(StrToIntDef(strTMPCNC, 30));
end;

procedure TfrmPrincipal.pAtualizarStatusConsultaCadastro(const strCodEmp : String);
  Var
    qryNfeLocal: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If (Not fTabelaExiste('NFE_LOCAL')) Then
    Exit;

  If (Not fCampoExiste('NFE_LOCAL', 'NFE_CONCAD')) Then
    Exit;

  qryNfeLocal := fCriaQuery(Nil);
  Try
    qryNfeLocal.Close;
    qryNfeLocal.SQL.Clear;
    qryNfeLocal.SQL.Add('SELECT COUNT(0) AS CNT FROM NFE_LOCAL WHERE NFE_CONCAD IS NOT NULL AND NFE_CODEMP = :CODEMP');
    qryNfeLocal.ParamByName('CODEMP').AsString := strCodEmp;
    qryNfeLocal.Open;
    If (qryNfeLocal.FieldByName('CNT').AsInteger > 0) Then
      Exit;
    qryNfeLocal.Close;
    qryNfeLocal.SQL.Clear;
    qryNfeLocal.SQL.Add('UPDATE NFE_LOCAL SET NFE_CONCAD = "S" WHERE NFE_CONCAD IS NULL AND NFE_CODEMP = :CODEMP');
    qryNfeLocal.ParamByName('CODEMP').AsString := strCodEmp;
    qryNfeLocal.ExecSQL;
  Finally
    FreeAndNil(qryNfeLocal);
  End;
end;

procedure TfrmPrincipal.pDesligaTodosOsTimers;
  Var
    intIdx : Integer;
begin
  memTarefas.Lines.Text := 'Finalizando PainelNFe...';

  For intIdx := 0 to Self.ComponentCount - 1 do
  Begin
    If Self.Components[intIdx].ClassNameIs('TTimer') Then
    begin
      If (TTimer(Self.Components[intIdx]).Name <> tmrFechaSistema.Name) Then
        TTimer(Self.Components[intIdx]).Enabled := False;
    end;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPrincipal.pEncerrarForcado;
begin
  tmrFechaSistema.Interval := fSegundosToInterval(10);

  pDesligaTodosOsTimers;

  If Assigned(frmModulo) Then
  Begin
    If (frmModulo.Database.Connected) Then
    Begin
      pRemoverTarefasInativas(True);

      If (VS_strCodEmp = '') Then //ENTROU SEM LOGAR
      Begin
        pGeraRegistroParaLogGeneral(frmModulo.Database, 'TfrmPrincipal.pEncerrarForcado > frmModulo.Database.Disconnect');
        frmModulo.Database.Disconnect;
      End;
    End;
  End;

  Application.Terminate;
  SendMessage(Application.Handle, WM_CLOSE, 0, 0);
  Application.ProcessMessages;
end;

procedure TfrmPrincipal.pDefineEmpresa;
  Var
    strMensagem_,
    strCodEmpPar: String;
    intQtdPastasPainelNFe: Integer;
begin
  pRetornaParamSeExistir(consTagParamsEmp, strCodEmpPar, True); //...\Painel.exe EMP:007

  intQtdPastasPainelNFe := fGetPastasPainel;

  If fEstaNoPainelNFeGeral Then
  Begin
    If (Length(VS_strCodEmp) = 3) Then
    Begin
      VS_strCodEmp := '';
      fArqIni(1, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');
    End;
  End;

  blnModoClassico := False;
  If (Length(VS_strCodEmp) = 3) Then
  Begin
    blnModoClassico := True;

    //MODO TRADICIONAL (ANTIGO)
    If (fGetPastasPainel('PainelNFeGeral') = 1) And (Not fEstaNoPainelNFeGeral) Then
    Begin
      //ANARQUIA NO DIRETÓRIO DO AUTCOM (MAIS DE UMA PASTA DE PAINEL, EXISTE PainelNFeGeral, MAS ESTÁ USANDO OUTRA PASTA)
      Application.MessageBox(PChar('Esse servidor já conta com o diretório do PainelNFe unificado ".\PainelNFeGeral\"'+#13#13+
                                   'Neste cenário, só pode ser mantido o diretório PainelNFeGeral e todos atalhos deverão apontar para ele. '+
                                   'Manter acesso a .\PainelNFeGeral\ e .\'+ExtractFileName(ExtractFileDir(Application.ExeName))+'\ simultaneamente, '+
                                   'pode causar instabilidade na autorização de notas. Entre em contato com a Citel para adequação do atalho da empresa '+
                                   VS_strCodEmp+' para que aponte para o diretório PainelNFeGeral.'), 'Atenção', MB_OK+MB_ICONWARNING);
      pEncerrarForcado;
    End
    Else If (strCodEmpPar <> '') And (strCodEmpPar <> VS_strCodEmp) Then
    Begin
      Application.MessageBox(PChar('Você está acessando o PainelNFe com a empresa ('+strCodEmpPar+'), definida neste atalho!'+#13+
                                   'Contudo, o PainelNFe está configurado para o "Modo Clássico" (onde cada empresa possui sua própria pasta PainelNFe).'+#13+
                                   'Para definir a empresa como parâmetro de atalho, acesse as "[F8] Configurações" e selecione "Multi Empresas" (pasta única atendendo todas as empresas).'+#13+
                                   'Outra opção é remover o parâmetro deste atalho para que o PainelNFe opere no "Modo Clássico".'+#13+
                                   'A empresa deste atalho será ignorada, e o programa abrirá como ('+VS_strCodEmp+') que é a empresa configurada no opcoespainel.ini'+#13+
                                   'Em caso de dúvida, entre em contato com a Citel!'), 'Atenção', MB_OK+MB_ICONWARNING);
    End;

    If (Not fPodeAbrirPainel(VS_strCodEmp)) Then
    Begin
      If (fEmpresaNesteServidor(VS_strCodEmp, False)) Then
        pEncerrarForcado
      Else If (Not fConfigurou(False)) Then
        pEncerrarForcado;
    End;
  End
  Else If (intQtdPastasPainelNFe > 1) Then
  Begin
    strMensagem_ := IIF(fEstaNoPainelNFeGeral, '.', ', ou use o "Modo Clássico".');

    //ANARQUIA NO DIRETÓRIO DO AUTCOM (MAIS DE UMA PASTA DE PAINEL, NO ENTANTO, TENTADO ABRIR COM O MODO MULTI EMPRESAS)
    Application.MessageBox(PChar('PainelNFe, configurado para operar no "Multi Empresas", no entanto, existem '+IntToStr(intQtdPastasPainelNFe)+' '+
                                 'PainelNFe''s no diretório do Autcom.'+#13#13+
                                 'Adeque os diretórios'+strMensagem_), 'Atenção', MB_OK+MB_ICONWARNING);

    If fEstaNoPainelNFeGeral Then
    Begin
      pEncerrarForcado;
    End
    Else
    Begin
      If (Not fConfigurou(False)) Then
        pEncerrarForcado;
    End;
  End
  Else If (strCodEmpPar <> '') Then
  Begin
    //MODO MULTI EMPRESAS COM PARÂMENTRO DEFINIDO NO ATALHO (NOVO)
    VS_strCodEmp := strCodEmpPar;

    If (Not fPodeAbrirPainel(VS_strCodEmp)) Then
      pEncerrarForcado;
  End
  Else
  Begin
    //MODO MULTI EMPRESAS SEM PARÂMENTRO OU CLICADO DIRETO NO EXECUTÁVEL (NOVO)
    Application.CreateForm(TfrmSelEmp, frmSelEmp);
    Try
      If (frmSelEmp.cdsEmpresas.RecordCount = 1) And
         (fPodeAbrirPainel(frmSelEmp.cdsEmpresas.FieldByName('CODEMP').AsString)) Then
      Begin
        VS_strCodEmp := frmSelEmp.cdsEmpresas.FieldByName('CODEMP').AsString;
      End
      Else
      Begin
        frmSelEmp.ShowModal;
        VS_strCodEmp := frmSelEmp.strEmpLog;
      End;
    Finally
      FreeAndNil(frmSelEmp);

      If (VS_strCodEmp <> '') Then
      Begin
        //PAINEL RODANDO NO MESMO DIRETÓRIO DO AUTCOM (NÃO RECOMENDÁVEL POR CONTA DE libeay32.dll E ssleay32.dll NÃO SEREM COMPATÍVEIS)
        If (Not FileExists('opcoespainel.ini')) Then
          If (ExtractFilePath(fPathOpcoesIni) = ExtractFilePath(Application.ExeName)) Then
            fArqIni(1, 'GERAL', 'PATATC', '.\', 'opcoespainel.ini');

        //REGISTRA ÚLTIMA EMPRESA COMO SUGESTÃO DE ABERTURA
        fArqIni(1, 'GERAL', 'ULTPNL', VS_strCodEmp, 'opcoespainel.ini');
      End
      Else
      Begin
        pEncerrarForcado;
      End;
    End;
  End;

  VS_strCodPnlDir := VS_strCodEmp;
end;

function TfrmPrincipal.fTemSeqDocParaLiberar : Boolean;
  Var
    qrySeqDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;
  If fEmptyStr(VS_strCodEmp) Then
    Exit;
  If (Not fTabelaExiste('SEQDOC')) Then
    Exit;
  If (Not fExisteConfiguracao('UTSNFI')) Then
    Exit;
  If (fCfgSisPainel('UTSNFI') <> 'S') Then
    Exit;
  qrySeqDoc := fCriaQuery(Nil);
  Try
    qrySeqDoc.Close;
    qrySeqDoc.SQL.Clear;
    qrySeqDoc.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qrySeqDoc.SQL.Add('   FROM SEQDOC ');
    qrySeqDoc.SQL.Add('  WHERE DOC_CODEMP = :CODEMP ');
    qrySeqDoc.SQL.Add('    AND DOC_LIBERA = "N" ');
    qrySeqDoc.SQL.Add('    AND TIMESTAMP(DOC_DTAOCO, DOC_HRAOCO) < DATE_SUB(NOW(), INTERVAL 600 SECOND) ');
    qrySeqDoc.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qrySeqDoc.Open;
    Result := (qrySeqDoc.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(qrySeqDoc);
  End;
end;

procedure TfrmPrincipal.pLiberarSeqDoc;
  Var
    qrySeqDoc: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fEmptyStr(VS_strCodEmp) Then
    Exit;
  If frmModulo.Database.InTransaction Then
    Exit;
  frmModulo.Database.StartTransaction;
  Try
    qrySeqDoc := fCriaQuery(Nil);
    Try
      qrySeqDoc.Close;
      qrySeqDoc.SQL.Clear;
      qrySeqDoc.SQL.Add(' UPDATE SEQDOC ');
      qrySeqDoc.SQL.Add('    SET DOC_LIBERA = "S" ');
      qrySeqDoc.SQL.Add('  WHERE DOC_LIBERA = "N" ');
      qrySeqDoc.SQL.Add('    AND DOC_CODEMP = :CODEMP ');
      qrySeqDoc.SQL.Add('    AND TIMESTAMP(DOC_DTAOCO, DOC_HRAOCO) < DATE_SUB(NOW(), INTERVAL 180 SECOND) ');
      qrySeqDoc.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qrySeqDoc.ExecSQL;
      frmModulo.Database.Commit;
    Finally
      FreeAndNil(qrySeqDoc);
    End;
  Except
    On E: Exception Do
    Begin
      frmModulo.Database.Rollback;
      Raise;
    End;
  End;
end;

{ TImprimirPDFBrowser }

procedure TImprimirPDFBrowser.PrintPDF(strFileName: String);
begin
  inherited;
  If VirtualUI.Active Then
    VirtualUI.PrintPdf(strFileName);
end;

initialization
  {$IF Defined(UNIDAC)}
    EnableUniSQL := False;
    dxInitializeLibNfe;
  {$IFEND}
  CoInitialize(Nil);

  VS_blnUsaFin := False;
  VS_dtaHraFin := StrToTime('05:00:00');
  FEmissaoNotaServicoCitel := '';

finalization
  {$IF Defined(UNIDAC)}
    dxFinalizeLibNfe;
  {$IFEND}
  CoUninitialize;

end.
