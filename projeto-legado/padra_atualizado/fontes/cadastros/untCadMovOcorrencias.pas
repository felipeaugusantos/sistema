unit untCadMovOcorrencias;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, EditFocus, Mask, DBCtrls, DBEditFocus,
  DBMemoFocus, DB, Uni, untAtualizaOcorrenciasCRM, UniClientDataSet, cxDBLabel,
  cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, strUtils,
  cxProgressBar, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, Graphics, cxLabel, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, cxGridCitel, System.ImageList, Vcl.ImgList,
  untZClient, System.Variants, dxScreenTip, dxCustomHint, cxHint,
  untTypesSistema, dxGDIPlusClasses,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, ClipBrd, cxButtons, cxCheckBox, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckComboBox, System.Contnrs, Vcl.CheckLst,
  untTRecorrenciaOcorrencia, untOcorrenciaCRM, untLiberacao;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TfrmCadMovOcorrencias = class(TfrmPaiCad)
    pnlGeral: TPanel;
    pnlCliente: TPanel;
    grbCliente: TGroupBox;
    dbeCodCli: TDBEditFocus;
    edtDesCodCli: TEditFocus;
    pnlGrupoOcorr: TPanel;
    grbOcorrencias: TGroupBox;
    edtDesCodGoc: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsMovOco: TDataSource;
    dbeCodGoc: TEditFocus;
    imgButton: TImageList;
    cxHint: TcxHintStyleController;
    Panel1: TPanel;
    BitBtnLocked2: TBitBtnLocked;
    BitBtnLocked6: TBitBtnLocked;
    BitBtnLocked7: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnHistorico: TBitBtnLocked;
    btnFinalizar: TBitBtnLocked;
    btnEnvMsg: TBitBtnLocked;
    btnArquivos: TBitBtnLocked;
    btnAltSituacao: TBitBtnLocked;
    btnConsultaAD: TBitBtnLocked;
    popOcorrencias: TPopupMenu;
    mnuEfetivarOrcamento: TMenuItem;
    mnuAlterarDocumento: TMenuItem;
    mnuEnviarEmail: TMenuItem;
    mnuGerarPDF: TMenuItem;
    mnuReimprimir: TMenuItem;
    mnuGerarVendaPerdida: TMenuItem;
    popPedido: TPopupMenu;
    mnuFatPedido: TMenuItem;
    popOrcamento: TPopupMenu;
    mnuFatOrcamento: TMenuItem;
    pgcGeral: TPageControl;
    tbsInfGerais: TTabSheet;
    pnlInfGerais: TPanel;
    pnlCabInf: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    lblProtocolo: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    lblEmail: TLabel;
    lblEmailDestino: TLabel;
    dbeTipOco: TDBEditFocus;
    edtDesTipOco: TEditFocus;
    edtDesOpeOco: TEditFocus;
    dbeOpeOco: TDBEditFocus;
    dblProtocolo: TcxDBLabel;
    dbeComple: TDBEditFocus;
    dbeDesComple: TEditFocus;
    ChkEmerge: TDBCheckBox;
    chkEnvEmail: TCheckBox;
    dbeCodSit: TDBEditFocus;
    edtDesSit: TEditFocus;
    edtEmail: TEditFocus;
    btnCopiarProtocolo: TcxButton;
    pnlProtocoloCancelamento: TPanel;
    Label12: TLabel;
    btnCopiarProtocoloCancelamento: TcxButton;
    lblProtocoloCancelamento: TcxLabel;
    chkEnvEmailDestino: TCheckBox;
    edtEmailDestino: TEditFocus;
    dbmDescri: TDBMemoFocus;
    tbsHistorico: TTabSheet;
    Label8: TLabel;
    cxGridCitel: TcxGridCitel;
    cxTableViewHisOco: TcxGridDBTableViewCitel;
    HisOcoColumnDESCRI: TcxGridDBColumn;
    HisOcoColumnDTAINC: TcxGridDBColumn;
    HisOcoColumnHORINC: TcxGridDBColumn;
    HisOcoColumnOPEORI: TcxGridDBColumn;
    HisOcoColumnOPEDES: TcxGridDBColumn;
    HisOcoColumnNUMDOC: TcxGridDBColumn;
    HisOcoColumnTIPOCO: TcxGridDBColumn;
    HisOcoColumnCODSIT: TcxGridDBColumn;
    HisOcoColumnOBSERV: TcxGridDBColumn;
    cxGridCitelLevel1: TcxGridLevel;
    tbsParticipa: TTabSheet;
    dbgOcoPar: TDBGridCitel;
    Panel2: TPanel;
    HisOcoColumnCODCOC: TcxGridDBColumn;
    pnlSituacao: TPanel;
    grbSit: TGroupBox;
    edtDesSitOco: TEditFocus;
    edtCodSit: TEditFocus;
    pnlComplemento: TPanel;
    gpComplemento: TGroupBox;
    edtCodCpl: TEditFocus;
    edtDesCpl: TEditFocus;
    pnlDatas: TPanel;
    grbDatas: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    shpData: TShape;
    shpHora: TShape;
    lblTxtLim: TLabel;
    lblHraLim: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    dbeDtaInc: TDBEditFocus;
    dbeHorInc: TDBEditFocus;
    dbeDtaCon: TDBEditFocus;
    dbeHorCon: TDBEditFocus;
    dbeDtaAge: TDBEditFocus;
    dbeHorAge: TDBEditFocus;
    dbeDataAgendamentoOriginal: TDBEditFocus;
    dbeHoraAgendamentoOriginal: TDBEditFocus;
    chkEmailEnvio: TcxCheckComboBox;
    chkTornarRecorrente: TCheckBox;
    btnGravarEfinalizar: TBitBtnLocked;
    btnEnviarEmail: TBitBtnLocked;
    chkGerCom: TCheckBox;
    btnAlterarCli: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTipOcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeOpeOcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnArquivosClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    procedure dbeCompleKeyPress(Sender: TObject; var Key: Char);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnConsultaADClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxTableViewHisOcoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cxTableViewHisOcoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxTableViewHisOcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnEnvMsgClick(Sender: TObject);
    procedure dtsMovOcoStateChange(Sender: TObject);
    procedure dbeCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure btnAltSituacaoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkEnvEmailClick(Sender: TObject);
    procedure cxTableViewHisOcoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbeDtaConExit(Sender: TObject);
    procedure dbeHorConExit(Sender: TObject);
    procedure mnuEfetivarOrcamentoClick(Sender: TObject);
    procedure mnuAlterarDocumentoClick(Sender: TObject);
    procedure mnuEnviarEmailClick(Sender: TObject);
    procedure mnuGerarPDFClick(Sender: TObject);
    procedure mnuReimprimirClick(Sender: TObject);
    procedure mnuGerarVendaPerdidaClick(Sender: TObject);
    procedure dbeCompleExit(Sender: TObject);
    procedure dbgOcoParKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgOcoParKeyPress(Sender: TObject; var Key: Char);
    procedure btnCopiarProtocoloClick(Sender: TObject);
    procedure btnCopiarProtocoloCancelamentoClick(Sender: TObject);
    procedure chkEnvEmailDestinoClick(Sender: TObject);
    procedure chkEmailEnvioPropertiesChange(Sender: TObject);
    procedure chkTornarRecorrenteClick(Sender: TObject);
    procedure btnGravarEfinalizarClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnAlterarCliClick(Sender: TObject);
  private
    { Private declarations }
    qryCadGoc: TUniQuery;
    qryCadCli: TUniQuery;
    qryCadToc: TUniQuery;
    qryCadOpe: TUniQuery;
    qryCadCoc: TUniQuery;
    cdsHisOco: TZClient;
    cdsOcoPar: TZClient;
    FCodCli: String;
    FCodOco: String;
    FOperac: String;
    FConDev: Boolean;
    FConEme: Boolean;
    FOcoFin: Boolean;
    FCdsDev: TUniClientDataSet;
    FGerCol: String;
    FNumDev: String;
    FArqDev: String;
    FInfDev: String;
    FInfCol: String;
    FCodTra: String;
    FSeqGer: String;
    FCodEmp: String;
    FTip_Fc: String;
    FCodLad: String;
    FCpfCli: String;
    //parametros usados pela agenda de compromissos
    FOpeOco: String;
    //parametro usado pela impressao de etiquetas do cliente.
    FCliVen: String;
    objAtuOcoCrm: TAtuOcoCrm;
    arrOpeEmer: TStringArray;

    tbsFocus: TTabSheet;
    intLastRec : Integer;

    strNumDocCanc       : String;
    strSerieCanc        : String;
    strCliForCanc       : String;
    blnInutilizacaoCanc : Boolean;
    intOpcaoCanc        : Integer;
    strEspSelCanc       : String;
    strMotDelCanc       : String;
    strHisComCanc       : String;
    blnEnvEmailDefault  : Boolean;

    objLiberacao: TLiberacao;

    objRecorrencia: TRecorrenciaOcorrencia;
    FBlnPermiteDataRetroativa: Boolean;

    procedure pCarregaGrupoOcorrencia;
    procedure pCarregaCliente;
    procedure pCarregaCliConsumidor;
    procedure pCarregaTipoOcorrencia;
    procedure pCarregaComplementoOcorrencia;
    procedure pCarregaUsuarioOcorrencia;
    procedure pInserirNovaOcorrencia;
    procedure pInserirHistoricoNovaOcorrencia;
    procedure pEscondeBotoesAgregados;
    procedure pHabilitaBotoesAgregados;
    procedure pDesejaEnviarPorEmail;
    procedure pGerarEspelhoDevolucaoAD;
    function fChamaHistoricoOcorrenciasInternal: Boolean;
    procedure pConsultaNovoHistoricoOcorrecia;
    procedure pDesabilitaFormulario;
    procedure pAlterarOcorrencia;
    procedure pAdicionaMascaras;
    procedure pPerguntaAnteDeEnviar;
    procedure pEnviarSemPerguntar;
    procedure pInserirHistorico(DataSet: TDataSet);
    procedure pInserirNumeroProtocolo;
    procedure pInserirCamposAuditoria;
    procedure pGeraOcorrenciasImpressaoEtiquetasClientes;

    function fChamaFormularioCancelamentoDocumentos:Boolean;
    function fGravaDadosDocumentoACancelar: Boolean;
    function fProcessosOcorrenciasDiferentes: Boolean;
    procedure pCarregaHistorioOcorrencia;
    function GetqryTabela: TUniQuery;
    function fGetEmailPadrao: String;
    procedure pHabilitarEnvioEmail;
    procedure pHabilitarGerarCompromisso;
    procedure pMensagemPadraoOcorrenciaCRM(strCodOco: string);
    function fGetSQLOcoPar: String;
    procedure pOnNewRecordOcoPar(DataSet: TDataSet);
    procedure pCarregaOcoPar;
    procedure pCarregarEmailEnvio;
    procedure pCarregarEmailEnvioCliente;
    procedure pCarregarEmailEnvioFornecedor;
    procedure pCarregarDadosCliente;
    function fValidaDataConclusao: Boolean;
    function fInformarAssuntoOcorrencia: Boolean;
    function fValidaDataAgendamento: Boolean;
    function fProcessarCadastroRecorrenciaOcorrencia: Boolean;
    procedure pProcessarRecorrencias;
    procedure pGerarCompromisso;
    function fVerificaPodeAlterarOcorrencia: Boolean;
    procedure pProcessaLogAlteracaoClienteOcorrencia;
  protected
    function getCodCli: String;
    function getCodOco: String;
    function getOperac: String;
    function getOpeOco: String;
    function getCodEmp: String;
    function getCliVen: String;
    function getTip_Fc: String;
    function getCodLad: String;
    function getCpfCli: String;
//    function getConDev: Boolean;

    procedure setCodCli(const Value: String);
    procedure setCodOco(const Value: String);
    procedure setOperac(const Value: String);
    procedure setOpeOco(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setCliVen(const Value: String);
    procedure setTip_Fc(const Value: String);
    procedure setCodLad(const Value: String);
    procedure setCpfCli(const Value: String);
//    procedure setConDev(const Value: Boolean);

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pGravarMsg(strAutIncMsg: String);
    function fEnviaEmergencial(strAssunt: String; StrMsg: WideString; arrOpeEmer: TStringArray ): String;
    function fGravaOcoPes(var cdsCons: TUniClientDataSet): Boolean;
    function fPesquisaMercado: Boolean;
    procedure pAbrirTelaRecorrencia;
    function fRetCorpoEmailPadrao(blnDevolucao: Boolean) : TStringArray;
    procedure pPreencheInfosEmaSai(var arrCorpo: TStringArray; var strAssunto: String);
    function fValidaPathEspelhoAd : Boolean;
    function fRetPathEspelhoAd : String;
  public
    { Public declarations }
    strCodGoc: String;
    strCodSit: String;
    strCodCpl: String;
    blnOpeCadCli : Boolean;
    strDtaAge: String;
    blnGeracaoGlobalOcorrencias: Boolean;
    strNumLead: String;
    blnClienteConsumidor: Boolean;

    property strCodCli: String Read getCodCli Write setCodCli;
    property strCodOco: String Read getCodOco Write setCodOco;
    property strOperac: String Read getOperac Write setOperac;
    property strOpeOco: String Read getOpeOco Write setOpeOco;
    property strCodEmp: String Read getCodEmp Write setCodEmp;
    property strCliVen: String Read getCliVen Write setCliVen;
    property strTip_Fc: String Read getTip_Fc Write setTip_Fc;
    property strCodLad: String Read getCodLad Write setCodLad;
    property strCpfCli: String Read getCpfCli Write setCpfCli;
//    property blnConDev: Boolean Read getConDev Write setConDev;

    property qryTabelaProp : TUniQuery Read GetqryTabela;
  end;

implementation

uses SysUtils, untFuncoesSimples, untConsultas, untPesqAux, untFuncoesCRM,
  untFuncoesGenerica, untObservacaoCRM, untObservacao, untCadMsg, UntMsgInterna,
  untEspelhoImpressao, untGerarEspelhoDevolucaoAD, untPreenchePesquisa,
  untTEnvioEmail, untCancelamentoDocumentos, untFuncoesRel, untFuncoesRel2,
  untFuncoesOcorrenciasCRM, untMovGer, untTypesCRM, untFatDadosCliConsumidor,
  untCliCtt, untForCtt, untLeads, untCadRecorrenciaOcorrencia, untInputDialog,
  DateUtils, untFatImpressao, untFuncoes, untDisparaEmailAut;

{$R *.dfm}

{ TfrmCadMovOcorrencias }

procedure TfrmCadMovOcorrencias.btnArquivosClick(Sender: TObject);
begin
  inherited;
  pVincularArquivos(qryTabela.FieldByName('OCO_CODOCO').AsString,
                    strTip_Fc,
                    qryTabela.FieldByName('OCO_CODCLI').AsString,
                    False);
end;

procedure TfrmCadMovOcorrencias.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeCodGOc.Clear;
  pCarregaGrupoOcorrencia;
  pCarregaTipoOcorrencia;
  pCarregaComplementoOcorrencia;
  pCarregaUsuarioOcorrencia;
  pCarregaCliente;
  pEscondeBotoesAgregados;
  pCarregaOcoPar;
end;

procedure TfrmCadMovOcorrencias.btnConsultaADClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(188, 7463, [],
                        ['CODOCO','CODEMP'],
                        [qryTabela.FieldByName('OCO_CODOCO').AsString,
                        qryTabela.FieldByName('OCO_CODEMP').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadMovOcorrencias.btnEnviarEmailClick(Sender: TObject);
begin
  inherited;
  pDesejaEnviarPorEmail;
end;

procedure TfrmCadMovOcorrencias.btnEnvMsgClick(Sender: TObject);
  Var
    strAutIncMsg : String;
begin
  inherited;
  strAutIncMsg := TfrmCadMsg.fEnvia(dbeCodCli.Text + ' - ' + edtDesCodCli.Text + ' ' +
                                    'Protocolo: ' + dtsMovOco.DataSet.FieldByName('OCO_PROTOC').AsString, True);
  If fEmptyStr(strAutIncMsg) Then
    Exit;

  pGravarMsg(strAutIncMsg);

end;

procedure TfrmCadMovOcorrencias.btnExcluirClick(Sender: TObject);
begin
  fMensagem('Atenção', 'As ocorrências não podem ser excluídas. Caso neccessário, finalize a ocorrência.', ['&OK']);

 {

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMovOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  if qryTabela.IsEmpty then
  begin
    dbeCodGOc.Clear;
    pCarregaGrupoOcorrencia;
    pCarregaTipoOcorrencia;
    pCarregaComplementoOcorrencia;
    pCarregaUsuarioOcorrencia;
    pCarregaCliente;
    pEscondeBotoesAgregados;
  end;

  }
end;

procedure TfrmCadMovOcorrencias.btnFinalizarClick(Sender: TObject);
Var
  qryMsgOco         : TUniQuery;
  blnEmergencial    : Boolean;
  blnEmergencialMSG : Boolean;
begin
  inherited;

  If fCfgSis('FINOCO', varBoolean) Then
  Begin
    If fOcorrenciaDevolucao(qryCadToc.FieldByName('TOC_CODTOC').AsString, FTip_Fc) Then
    Begin
      If btnFinalizar.Tag = 0 Then
      Begin
        If fMensagem('', 'A Ocorrência Atual é Referente a AD, ao finalizar manualmente a AD será cancelada e a ocorrência não poderá ser reaberta. ' +
                         'Deseja Continuar?', ['&Sim', '&Não'], 2) = 2 Then
          Exit;
      End
      Else
      Begin
        fMensagem('', 'Ocorrência Referente a AD já finalizada, não é possível reabrir!' + #13 + 'Efetue uma nova ocorrência!', ['&OK']);
        Exit;
      End;
    End;
  End;

  If Not qryTabela.IsEmpty Then
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('OCO_NOMFRM').AsString := Self.Name;
    qryTabela.Post;

    If fFinalizaReabreOcorrencia(qryTabela, btnFinalizar.Tag = 0, FTip_Fc) Then
    Begin
      pConsultaNovoHistoricoOcorrecia();
      If fEnviarOcorrenciaPorEmail(dbeTipOco.Text) Then
        pEnviarSemPerguntar();

      blnEmergencial := IIF(qryTabela.FieldByName('OCO_EMERGE').AsString = 'S',True,False);
      blnEmergencialMSG := fCfgSis('OCOMSG', varBoolean);

      If blnEmergencial and blnEmergencialMSG Then
      Begin
        qryMsgOco := fCriaQuery;
        Try
          qryMsgOco.Close;
          qryMsgOco.SQL.Clear;
          qryMsgOco.SQL.Add(' SELECT GROUP_CONCAT(MSO_SEQMSG SEPARATOR ", ")  AS MSO_SEQMSG ');
          qryMsgOco.SQL.Add(' FROM MSGOCO                                                   ');
          qryMsgOco.SQL.Add(' WHERE MSO_CODEMP = :CODEMP                                    ');
          qryMsgOco.SQL.Add('   AND MSO_CODCLI = :CODCLI                                    ');
          qryMsgOco.SQL.Add('   AND MSO_CODOCO = :CODOCO                                    ');

          qryMsgOco.ParamByName('CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;
          qryMsgOco.ParamByName('CODCLI').AsString := qryTabela.FieldByName('OCO_CODCLI').AsString;
          qryMsgOco.ParamByName('CODOCO').AsString := qryTabela.FieldByName('OCO_CODOCO').AsString;

          qryMsgOco.Open;

          If not qryMsgOco.IsEmpty Then
          Begin
            pAtualizaMsgLida(qryMsgOco.FieldByName('MSO_SEQMSG').AsString,
                             qryTabela.FieldByName('OCO_DTACON').AsDateTime,
                             qryTabela.FieldByName('OCO_HORCON').AsDateTime);
          End;
        Finally
          FreeAndNil(qryMsgOco);
        End;
      End;
      btnSair.Click;
    End;
  End;
end;


procedure TfrmCadMovOcorrencias.btnGravarClick(Sender: TObject);
var
  blnCancel: Boolean;
  blnDevolu: Boolean;
  blnImpEti: Boolean;
  blnEmergencial: Boolean;
  blnEmergencialMSG: Boolean;
  strCodTea: String;
  blnInfCodTea: Boolean;
begin
  If fEmptyStr(edtDesOpeOco.Text) Then
    if not fValidaCampos(dbeOpeOco, True) Then
      Exit;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnInfCodTea := False;
  objAtuOcoCrm := TAtuOcoCrm.Create(Self);
  Try
    objAtuOcoCrm.strNomFrm := Self.Name;
    If chkTornarRecorrente.Checked Then
    Begin
      objRecorrencia.Ocorrencia := objAtuOcoCrm;

      If Not objRecorrencia.fValidarRecorrenciaPreenchida Then
      Begin
        fMensagem('Atenção', objRecorrencia.MensagemRetorno, ['&OK']);
        pAbrirTelaRecorrencia;
        Exit;
      End;
    End;

    //Indica que a ocorrencia foi chamada pelo processo de impressao de etiquetas do cliente.
    blnImpEti := not fEmptyStr(FCliVen);
    //Chama o processo de devolucao de produtos
    blnDevolu := fOcorrenciaDevolucao(qryCadToc.FieldByName('TOC_CODTOC').AsString, FTip_Fc);
    //Chama o processo de ocorrencia emergencial
    blnEmergencial := IIF(qryTabela.FieldByName('OCO_EMERGE').AsString = 'S',True,False);

    objAtuOcoCrm.blnEmerge := blnEmergencial;

    If qryTabela.FieldByName('OCO_ESPDOC').AsString = 'PD' Then
      blnCancel := fOcorrenciaCancelamentoPedidoVenda(qryCadToc.FieldByName('TOC_CODTOC').AsString)
    Else
      blnCancel := fOcorrenciaCancelamentoDocumentoVenda(qryCadToc.FieldByName('TOC_CODTOC').AsString);

    If FOperac = 'Coleta' then
    Begin

      If blnDevolu Then
      Begin
        fMensagem('ATENÇÃO', 'Não é permitido efetuar devolução através da geração global!', ['&OK']);
        Exit;
      End;

      If blnCancel Then
      Begin
        fMensagem('ATENÇÃO', 'Não é permitido efetuar cancelamento através da geração global!', ['&OK']);
        Exit;
      End;

      ModalResult := mrOK;
      Exit;

    End;

    If Not fInformarAssuntoOcorrencia Then
      Exit;

    //Se o tipo de ocorrencia for de devolucao
    //Chama o processo de devolucao
    if blnDevolu then
    begin
      pChamaFormularioDevolucaoProdutos(True,
                                        qryTabela.FieldByName('OCO_CODOCO').AsString,
                                        qryTabela.FieldByName('OCO_CODEMP').AsString,
                                        qryTabela.FieldByName('OCO_CODCLI').AsString,
                                        qryCadCli.FieldByName('CLI_NOMCLI').AsString,
                                        FCdsDev,
                                        FConDev,
                                        FGerCol,
                                        FNumDev,
                                        FSeqGer);
      If Not FConDev Then
      Begin
        pSetFocus(dbeTipOco);
        Exit;
      End;
    end;
    //Se o tipo de ocorrencia for emergencial
    //Chama o processo emergencial
    if blnEmergencial then
    begin
      SetLength(arrOpeEmer,0);
      pChamaFormularioSelecaoOpeEmergencial(True,
                                            qryTabela.FieldByName('OCO_CODOCO').AsString,
                                            qryTabela.FieldByName('OCO_CODEMP').AsString,
                                            qryTabela.FieldByName('OCO_CODOPE').AsString,
                                            arrOpeEmer,
                                            FConEme);
      if not FConEme then
        exit;
      blnGravou := True;
    end
    else
      blnGravou := True;

    If blnCancel And (strTip_FC <> 'P') Then
      blnGravou := fChamaFormularioCancelamentoDocumentos;

    blnEmergencialMSG := fCfgSis('OCOMSG', varBoolean);

    if fCfgSis('PESQME',varBoolean) And (fCfgSis('OCOPSQ', varString) = dbeTipOco.Text) then
    begin
      if fMensagem('ATENÇÃO', 'Deseja realizar a pesquisa de mercado?', ['&Sim','&Não'], 1) = 1 then
      begin
        if fPesquisaMercado Then
        begin
          qryTabela.FieldByName('OCO_DESCRI').AsString := qryTabela.FieldByName('OCO_DESCRI').AsString + #13 +  'Pesquisa Finalizada.';

          qryTabela.FieldByName('OCO_DTACON').AsString := FormatDateTime('DD/MM/YYY', VS_Date);
          qryTabela.FieldByName('OCO_HORCON').AsString := FormatDateTime('HH:MM:SS', fRetHoraServidor);
        end;
      end;
    end;

    Try
      if blnGravou then
      begin
        blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

        If FOperac = 'Inserir' then
        Begin
          qryTabela.FieldByName('OCO_DTAAGO').AsDateTime := qryTabela.FieldByName('OCO_DTAAGE').AsDateTime;
          qryTabela.FieldByName('OCO_HORAGO').AsDateTime := qryTabela.FieldByName('OCO_HORAGE').AsDateTime;
        End;

        qryTabela.FieldByName('OCO_NOMFRM').AsString := Self.Name;

        If (FTip_Fc = 'C') And fTipOcoInformaTemperaturaAtendimento(qryCadGoc.FieldByName('GOC_CODGOC').AsString,
                                                qryTabela.FieldByName('OCO_CODTOC').AsString) Then
        Begin
          strCodTea := fInformarTemperaturaAtendimento(qryTabela.FieldByName('OCO_CODTEA').AsString);

          blnInfCodTea := (strCodTea <> qryTabela.FieldByName('OCO_CODTEA').AsString);

          If fEmptyStr(strCodTea) Then
          Begin
            fMensagem('ATENÇÃO!', 'É necessário informar a Temperatura do Atendimento para prosseguir  !',['&Ok']);
            Exit;
          End;
        End;

        //Se for devolucao e o usuario lancou ao menos um produto ou
        //Se nao for devolucao grava uma nova ocorrencia.
        if (blnDevolu And FConDev) Or
           (blnEmergencial And FConEme) Or
           ((not blnDevolu) And (not blnEmergencial)) then
          inherited;

        strCodOco := qryTabela.FieldByName('OCO_CODOCO').AsString;

        pGravaHistoricoOcorrencia(qryTabela, False);

        objAtuOcoCrm.strNomFrm := Self.Name;

        cdsOcoPar.DisableControls;
        cdsOcoPar.First;
        While not cdsOcoPar.Eof Do
        Begin
          cdsOcoPar.Edit;
          if fEmptyStr(cdsOcoPar.FieldByName('PAR_CODOCO').AsString) Then
            cdsOcoPar.FieldByName('PAR_CODOCO').AsString := qryTabela.FieldByName('OCO_CODOCO').AsString;

          if fEmptyStr(cdsOcoPar.FieldByName('PAR_CODTOC').AsString) Then
            cdsOcoPar.FieldByName('PAR_CODTOC').AsString := qryTabela.FieldByName('OCO_CODTOC').AsString;

          If fEmptyStr(cdsOcoPar.FieldByName('PAR_CODEMP').AsString) Then
            cdsOcoPar.FieldByName('PAR_CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;

          If fEmptyStr(cdsOcoPar.FieldByName('PAR_CODCLI').AsString) Then
            cdsOcoPar.FieldByName('PAR_CODCLI').AsString := qryTabela.FieldByName('OCO_CODCLI').AsString;

          cdsOcoPar.Post;

          cdsOcoPar.Next;

        End;
        cdsOcoPar.First;
        cdsOcoPar.EnableControls;
        cdsOcoPar.ApplyUpdates(-1);
        dbgOcoPar.ReadOnly := True;

        //esse parametro vem da impressao de etiquetas de clientes.
        //não são permitadas ocorrencias de devolucao, emergencial e compromissos,
        //quando a ocorrencia é proveniente do processo de impressao de etiquetas.
        if not blnImpEti then
        begin
          If blnCancel And (strTip_FC <> 'P') Then
          Begin
            blnGravou := fGravaDadosDocumentoACancelar;
          End
          Else
          if (blnDevolu) then  //devolucao
          begin
            pGravaDevolucaoProdutos(True,
                                    FCdsDev,
                                    FCodOco,
                                    qryTabela.FieldByName('OCO_CODCLI').AsString,
                                    FGerCol,
                                    FNumDev,
                                    FInfDev,
                                    FInfCol,
                                    FCodTra);
            pConsultaNovoHistoricoOcorrecia;

          end
          else if (blnEmergencial) then  //emergencial
            pGravaOcorrenciaEmergencial(FCodOco,
                                        qryTabela.FieldByName('OCO_CODEMP').AsString,
                                        arrOpeEmer,
                                        Self.Name);

          If chkTornarRecorrente.Checked Then
          Begin
            blnGravou := fProcessarCadastroRecorrenciaOcorrencia;
          End;

          If blnGravou Then
          Begin
            fCommit;

            If blnDevolu And fCfgSis('ESP_AD', VarBoolean) Then
              fExecutarModal(pGerarEspelhoDevolucaoAD, 'Aguarde, gerando espelho devolução (AD) ...', '');

            pDesejaEnviarPorEmail;

            If (blnDevolu) then
            begin
              fMensagem('INFORMAÇÃO!', 'Autorização de devolução nº : ' + FNumDev + ' gravada com sucesso !',['&Ok']);
              if (FGerCol = 'S') Then
                pEnviarEmailColeta(Self, FNumDev, FCodTra, FInfCol);
            end;

            objAtuOcoCrm.pGravarMensagemOperadorOcorrencia(IIF(FOperac = 'Inserir', tpInclusao, tpAlteracao),
                                                           qryTabela.FieldByName('OCO_CODOCO').AsString,
                                                           qryTabela.FieldByName('OCO_CODEMP').AsString,
                                                           strTip_Fc);

            If blnEmergencial and blnEmergencialMSG Then
              pEnviaMensagemEmergencial(blnDevolu, dbmDescri.Text, objAtuOcoCrm, arrOpeEmer);

            If blnInfCodTea Then
            Begin
              pAlterarTemperaturaAtendimento(FTip_Fc,
                                             qryTabela.FieldByName('OCO_CODOCO').AsString,
                                             qryTabela.FieldByName('OCO_CODEMP').AsString,
                                             strCodTea)
            End;

            pProcessarRecorrencias;

            pGerarCompromisso;

            pProcessaLogAlteracaoClienteOcorrencia;

            pHabilitaBotoesAgregados;
            pgcGeral.ActivePage := tbsFocus;
          End
          Else
          Begin
            if (not qryTabela.IsEmpty) then
              qryTabela.Delete;
            fRollBack;
            btnSair.Click;
          End;
        end
        else
        begin
          pGeraOcorrenciasImpressaoEtiquetasClientes;
          fCommit;
          btnSair.Click;
        end;

  //      if blnPesqMesrc And fCfgSis('PESQME',varBoolean) And (fCfgSis('OCOPSQ', varString) = dbeTipOco.Text) then
  //        btnFinalizar.Click;

      end
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadMovOcorrencias.btnGravarClick]');
      End;
    End;
  Finally
    FreeAndNil(objAtuOcoCrm);
  End;
end;

procedure TfrmCadMovOcorrencias.btnGravarEfinalizarClick(Sender: TObject);
begin
  inherited;

  If ((qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENORC', varString)) Or
      (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENPED', varString))) Then
  Begin
    fMensagem('', strCRMOcoFinFat, ['&Ok']);
    Exit;
  End;

  qryTabela.FieldByName('OCO_DTACON').AsDateTime := Today;
  qryTabela.FieldByName('OCO_HORCON').AsDateTime := fNow;

  BtnGravar.Click;

  If blnGravou Then
  Begin
    btnGravarEfinalizar.Enabled := False;

    If fOcorrenciaDevolucao(qryTabela.FieldByName('OCO_CODTOC').AsString, FTip_Fc) Then
    Begin
      Self.Close;
    End;
  End;

End;

function TfrmCadMovOcorrencias.fPesquisaMercado: Boolean;
  var
    cdsResp : TUniClientDataSet;
begin
  Result := True;

  Try
    pCriarFormularios(TfrmPreenchePesquisa, frmPreenchePesquisa);
    cdsResp := TUniClientDataSet.Create(Nil);
    Try
      frmPreenchePesquisa.ShowModal;

      if frmPreenchePesquisa.cdsResp <> nil then
        cdsResp.Data := frmPreenchePesquisa.cdsResp.Data;

      if cdsResp.IsEmpty then
        Result := False
      Else
        Result := fGravaOcoPes(cdsResp);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmCadMovOcorrencias.fPesquisaMercado]');
    End;
  Finally
    pFreeAndNil(frmPreenchePesquisa);
    pFreeAndNil(cdsResp);
  End;
end;

function TfrmCadMovOcorrencias.fGravaOcoPes(var cdsCons: TUniClientDataSet): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := True;

  Try
    qryAux := fCriaQuery(Self);

    cdsCons.First;
    while not cdsCons.Eof Do
    Begin
      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add('INSERT INTO     ');
        SQL.Add('  OCOPES (      ');
        SQL.Add('    AUTOINCREM, ');
        SQL.Add('    OCO_CODEMP, ');
        SQL.Add('    OCO_DTAENT, ');
        SQL.Add('    OCO_HORENT, ');
        SQL.Add('    OCO_CODPES, ');
        SQL.Add('    OCO_CODPER, ');
        SQL.Add('    OCO_CODRES, ');
        SQL.Add('    OCO_CODOCO, ');
        SQL.Add('    OCO_CODCLI, ');
        SQL.Add('    OCO_CODTOC) ');
        SQL.Add('  VALUES (      ');
        SQL.Add('    :AUTINC,    ');
        SQL.Add('    :CODEMP,    ');
        SQL.Add('    :DTAENT,    ');
        SQL.Add('    :HORENT,    ');
        SQL.Add('    :CODPES,    ');
        SQL.Add('    :CODPER,    ');
        SQL.Add('    :CODRES,    ');
        SQL.Add('    :CODOCO,    ');
        SQL.Add('    :CODCLI,    ');
        SQL.Add('    :CODTOC)    ');

        ParamByName('AUTINC').AsString   := fRetAutoIncrem('OCOPES', VS_strCodEmp);
        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        ParamByName('DTAENT').AsDateTime := VS_Date;
        ParamByName('HORENT').AsDateTime := fTime();
        ParamByName('CODPES').AsString   := cdsCons.FieldByName('CODPES').AsString;
        ParamByName('CODPER').AsString   := cdsCons.FieldByName('CODPER').AsString;
        ParamByName('CODRES').AsString   := cdsCons.FieldByName('RESPOS').AsString;
        ParamByName('CODOCO').AsString   := qryTabela.FieldByName('OCO_CODOCO').AsString;
        ParamByName('CODCLI').AsString   := qryTabela.FieldByName('OCO_CODCLI').AsString;
        ParamByName('CODTOC').AsString   := qryTabela.FieldByName('OCO_CODTOC').AsString;

        ExecSQL;
      End;

      cdsCons.Next;
    End;

    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      Result := False;
      FreeAndNil(qryAux);
      pMensagensErro(E.Message, '[frmCadMovOcorrencias.fGravaOcoPes]');
    End;
  End;

end;

function TfrmCadMovOcorrencias.fInformarAssuntoOcorrencia: Boolean;
var
  strAssuntoOco: String;
begin
  If Not fCfgSis('OCOAST',varBoolean) Then
  Begin
    Result := True;
    Exit;
  End;

  repeat
    strAssuntoOco := fInputDialog('Assunto Ocorrência', 'Informe o assunto da ocorrência.');

    Result := Not fEmptyStr(strAssuntoOco);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O assunto da ocorrência deve ser preenchido!', ['&Ok']);
    End;

  until Result ;

  qryTabela.FieldByName('OCO_ASSUNT').AsString := strAssuntoOco;
end;

procedure TfrmCadMovOcorrencias.btnHistoricoClick(Sender: TObject);
begin
  inherited;

  If Not fChamaHistoricoOcorrenciasInternal Then
    Exit;

  pAlterarOcorrencia;

  If  (strTip_FC = 'P') Then
    TAtuOcoCrmProspecto.fNew
                       .CodOco(qryTabela.FieldByName('OCO_CODOCO').AsString)
                       .CodCli(qryTabela.FieldByName('OCO_CODCLI').AsString)
                       .CodEmp(qryTabela.FieldByName('OCO_CODEMP').AsString)
                       .NomFrm(Self.Name)
                       .CodCoc(qryTabela.FieldByName('OCO_CODCOC').AsString)
                       .pExecutarAposProcessamentoOco
                       ;
end;

procedure TfrmCadMovOcorrencias.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if not qryTabela.IsEmpty then
    pImprimirOcorrencias(qryTabela.FieldByName('OCO_CODOCO').AsString,
      qryTabela.FieldByName('OCO_CODEMP').AsString,
      qryTabela.FieldByName('OCO_TIP_FC').AsString);
end;

procedure TfrmCadMovOcorrencias.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, TDBEdit(dbmDescri), False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pAdicionaMascaras;
end;



procedure TfrmCadMovOcorrencias.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************AC*}
  If FTip_Fc = 'P' Then
  Begin
    If fPesqProspecto(Self, dbeCodCli, edtDesCodCli, Nil, Key, arrClientes, True, True) Then
    Begin
      If fValidaCampos(dbeCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End

  Else
  If FTip_Fc = 'C' Then
  Begin
    If fPesqCliente(conCliSimples, Self, dbeCodCli, edtDesCodCli, Nil, Key, arrClientes) Then
    Begin
      If fValidaCampos(dbeCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    {*********************************}
    {* NOVA CONSULTA DE FORNECEDORES *}
    {******************************AC*}
    If fPesqFornecedor(conForSimples, Self, dbeCodCli, edtDesCodCli, Nil, Key, arrClientes) Then
    Begin
      If fValidaCampos(dbeCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadMovOcorrencias.dbeCompleExit(Sender: TObject);
begin
  inherited;
  If Not (btnGravar.Focused) then
    pMensagemPadraoOcorrenciaCRM(dbeComple.Text);
end;

procedure TfrmCadMovOcorrencias.dbeCompleKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCOcorr: TConsultasArray;
begin
  {*********************************************}
  {* NOVA CONSULTA COMPLEMENTOS DE OCORRENCIAS *}
  {******************************************AC*}
  If fPesqComplementosOcorrencias(Self, dbeComple, dbeDesComple, nil, Key, arrCOcorr, True, dbeTipOco.Text) Then
  Begin
    If fValidaCampos(dbeComple, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovOcorrencias.dbeDtaConExit(Sender: TObject);
begin
  inherited;

  pHabilitarEnvioEmail();
  pHabilitarGerarCompromisso;
end;

procedure TfrmCadMovOcorrencias.dbeHorConExit(Sender: TObject);
begin
  inherited;

  pHabilitarEnvioEmail();
  pHabilitarGerarCompromisso;
end;

procedure TfrmCadMovOcorrencias.dbeCodGocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  {***************************************}
  {* NOVA CONSULTA GRUPOS DE OCORRENCIAS *}
  {************************************AC*}
  If fPesqGruposOcorrencias(Self, dbeCodGoc, edtDesCodGoc, nil, Key, arrTOcorr, True, strTip_FC) Then
  Begin
    If fValidaCampos(dbeCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovOcorrencias.dbeCodSitKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqSitOcorrencias(Self, dbeCodSit, edtDesSit, Nil, Key, arrSel, True, True, dbeTipOco.Text ) Then
  Begin
    If fValidaCampos(dbeCodSit, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMovOcorrencias.dbeOpeOcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrOpe: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeOpeOco, edtDesOpeOco, nil, Key, arrOpe) then
  Begin
    If fValidaCampos(dbeOpeOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovOcorrencias.dbeTipOcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  If fPesqTiposOcorrencias(Self, dbeTipOco, edtDesTipOco, nil, Key, arrTOcorr, True, dbeCodGOc.Text) Then
  Begin
    If fValidaCampos(dbeTipOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovOcorrencias.dbgOcoParKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Shift = [ssCtrl]) And (Key = VK_DELETE) Then
  Begin
    if fMensagem('', 'Deseja excluir o participante?', ['&Sim', '&Não'], 2) = 2 Then
      Abort;
  End;
end;

procedure TfrmCadMovOcorrencias.dbgOcoParKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := Ansiuppercase(String(Key))[1];
end;

procedure TfrmCadMovOcorrencias.dtsMovOcoStateChange(Sender: TObject);
begin
  inherited;
  btnImprimir.Enabled := (dtsMovOco.DataSet.State = dsBrowse) And (not dtsMovOco.DataSet.IsEmpty);
  chkEnvEmail.Enabled := dtsMovOco.DataSet.State in dsEditModes;
  chkEnvEmailDestino.Enabled := dtsMovOco.DataSet.State in dsEditModes;
  chkGerCom.Enabled := dtsMovOco.DataSet.State in dsEditModes;
  btnEnvMsg.Visible := (Not fEmptyStr(qryTabela.FieldByName('OCO_CODCLI').AsString)) And
                       (Not fEmptyStr(qryTabela.FieldByName('OCO_PROTOC').AsString)) And
                       (qryTabela.State = dsBrowse);

end;

procedure TfrmCadMovOcorrencias.FormActivate(Sender: TObject);
begin
  inherited;
  If tbsHistorico.TabVisible Then
  Begin
    WindowState := wsMaximized;
    BorderIcons := BorderIcons + [biMaximize];
  End;

end;

procedure TfrmCadMovOcorrencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (FOperac <> 'Coleta') Then
    inherited;

  If (Action <> CaNone) Then
  begin
    strCodGoc := qryCadGoc.FieldByName('GOC_CODGOC').AsString;

    FreeAndNil(objLiberacao);
  end;
end;

procedure TfrmCadMovOcorrencias.FormCreate(Sender: TObject);
begin
  If fVerificaAcessoSistema('DTACRM') Then
  Begin
    shpData.Brush.Color := clGreen;
    shpHora.Brush.Color := clGreen;
  End
  Else
  Begin
    shpData.Brush.Color := clRed;
    shpHora.Brush.Color := clRed;
    dbeDtaCon.Enabled   := False;
    dbeHorCon.Enabled   := False;
    dbeDtaCon.ReadOnly  := True;
    dbeHorCon.ReadOnly  := True;
    dbeDtaCon.Tag       := 50;
    dbeHorCon.Tag       := 50;
  End;

  inherited;
  blnOpeCadCli      := False;
  FConDev           := False;
  FConEme           := False;
  FOcoFin           := False;
  //Vem sempre como default cliente.Somente será trocado pelo frmCRMForn
  strTip_Fc         := 'C';
  strCodGoc         := '';
  strCliVen         := '';
  strNomeTabela     := 'MOVOCO';
  strNomeCampo      := 'OCO_CODOCO';
  qryTabela         := fCriarQuery('SELECT * FROM MOVOCO WHERE FALSE', Self);
  dtsMovOco.DataSet := qryTabela;

  objLiberacao := TLiberacao.Create;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryTabela.BeforePost := pInserirHistorico;

  cdsOcoPar := TZClient.Create(Self, fGetSQLOcoPar);
  cdsOcoPar.OnNewRecord := pOnNewRecordOcoPar;
  tbsParticipa.TabVisible := fCfgSis('OCOPAR', varBoolean);
  dbgOcoPar.DataSource := cdsOcoPar.dtsSource;

  cdsHisOco := TZClient.Create(Self, fRetornaSQLHistoricoOcorrencias);
  btnEnvMsg.Visible := fVerificaAcessoSistema('CRMMSG');
  If not btnEnvMsg.Visible Then
    btnAltSituacao.Left := btnEnvMsg.Left;

  strNumDocCanc       := '';
  strSerieCanc        := '';
  strCliForCanc       := '';
  blnInutilizacaoCanc := False;
  intOpcaoCanc        := -1;
  strMotDelCanc       := '';
  strHisComCanc       := '';

  pnlProtocoloCancelamento.Visible := False;
  pnlCabInf.Height := pnlCabInf.Height - pnlProtocoloCancelamento.Height;

  blnGeracaoGlobalOcorrencias := False;
  objRecorrencia := TRecorrenciaOcorrencia.Create(Nil);
  blnClienteConsumidor := False;
end;

procedure TfrmCadMovOcorrencias.pOnNewRecordOcoPar(DataSet : TDataSet);
Begin
  cdsOcoPar.FieldByName('PAR_CODOCO').AsString := qryTabela.FieldByName('OCO_CODOCO').AsString;
  cdsOcoPar.FieldByName('PAR_CODTOC').AsString := qryTabela.FieldByName('OCO_CODTOC').AsString;
  cdsOcoPar.FieldByName('PAR_CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;
  cdsOcoPar.FieldByName('PAR_CODCLI').AsString := qryTabela.FieldByName('OCO_CODCLI').AsString;
  cdsOcoPar.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('OCOPAR', VS_strCodEmp);
End;

procedure TfrmCadMovOcorrencias.pCarregaOcoPar;
Begin
  if cdsOcoPar.Active Then
    cdsOcoPar.EmptyDataSet();

  cdsOcoPar.qryQuery.ParamByName('CODOCO').AsString := qryTabela.FieldByName('OCO_CODOCO').AsString;
  cdsOcoPar.qryQuery.ParamByName('CODTOC').AsString := qryTabela.FieldByName('OCO_CODTOC').AsString;
  cdsOcoPar.qryQuery.ParamByName('CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;
  cdsOcoPar.qryQuery.ParamByName('CODCLI').AsString := qryTabela.FieldByName('OCO_CODCLI').AsString;

  cdsOcoPar.fAbreClient(True, '');

End;

procedure TfrmCadMovOcorrencias.pCarregarEmailEnvio;
Begin
  If FTip_Fc = 'F' Then
    pCarregarEmailEnvioFornecedor
  Else
    pCarregarEmailEnvioCliente;
End;

procedure TfrmCadMovOcorrencias.pCarregarEmailEnvioFornecedor;
var
  intCnt: Integer;
  lstContatos: TObjectList;
  objForCtt: TForCtt;
  strEmailPadrao,
  strEmailPadraoSemDelimitador: String;
begin
  chkEmailEnvio.Properties.Items.Clear;
  strEmailPadrao := fGetEmailPadrao;

  If Pos(';', strEmailPadrao) > 0 Then
    strEmailPadraoSemDelimitador := Copy(strEmailPadrao, 0, Pos(';', strEmailPadrao)-1)
  Else
    strEmailPadraoSemDelimitador := strEmailPadrao;

  lstContatos := TForCtt.fRetContatos(strCodCli);
  Try
    If lstContatos.Count > 0 Then
    Begin
      If Not fEmptyStr(strEmailPadraoSemDelimitador) Then
        chkEmailEnvio.Properties.Items.AddCheckItem(strEmailPadraoSemDelimitador);
      For intCnt := 0 To lstContatos.Count -1 Do
      Begin
        objForCtt := TForCtt(lstContatos[intCnt]);
        chkEmailEnvio.Properties.Items.AddCheckItem(objForCtt.strEmaCtt);
      End;
      chkEmailEnvio.Enabled := True;
      edtEmail.Text := strEmailPadrao;
    End
    Else
    Begin
      chkEmailEnvio.Enabled := False;
      edtEmail.Text := strEmailPadrao;
    End;
  Finally
    FreeAndNil(lstContatos);
  End;
end;

procedure TfrmCadMovOcorrencias.pCarregarEmailEnvioCliente;
var
  intCnt: Integer;
  lstContatos: TObjectList;
  objCliCtt: TCliCtt;
  strEmailPadrao,
  strEmailPadraoSemDelimitador: String;
begin
  chkEmailEnvio.Properties.Items.Clear;
  strEmailPadrao := fGetEmailPadrao;

  If Pos(';', strEmailPadrao) > 0 Then
    strEmailPadraoSemDelimitador := Copy(strEmailPadrao, 0, Pos(';', strEmailPadrao)-1)
  Else
    strEmailPadraoSemDelimitador := strEmailPadrao;

  lstContatos := TCliCtt.fRetContatos(strCodCli, False);
  Try
    If lstContatos.Count > 0 Then
    Begin
      If Not fEmptyStr(strEmailPadraoSemDelimitador) Then
        chkEmailEnvio.Properties.Items.AddCheckItem(strEmailPadraoSemDelimitador);
      For intCnt := 0 To lstContatos.Count -1 Do
      Begin
        objCliCtt := TCliCtt(lstContatos[intCnt]);
        chkEmailEnvio.Properties.Items.AddCheckItem(objCliCtt.strEmaCtt);
      End;
      chkEmailEnvio.Enabled := True;
      edtEmail.Text := strEmailPadrao;
    End
    Else
    Begin
      chkEmailEnvio.Enabled := False;
      edtEmail.Text := strEmailPadrao;
    End;
  Finally
    FreeAndNil(lstContatos);
  End;
end;

function TfrmCadMovOcorrencias.fGetSQLOcoPar : String;
Begin
  Result := '';
  Result := Result + ' SELECT * FROM OCOPAR       ';
  Result := Result + ' WHERE PAR_CODOCO = :CODOCO ';
  Result := Result + '   AND PAR_CODTOC = :CODTOC ';
  Result := Result + '   AND PAR_CODEMP = :CODEMP ';
  Result := Result + '   AND PAR_CODCLI = :CODCLI ';
End;

procedure TfrmCadMovOcorrencias.FormDestroy(Sender: TObject);
begin
  if Assigned(FCdsDev)  then
    FreeAndNil(FCdsDev);
  FreeAndNil(qryCadGoc);
  FreeAndNil(qryCadCli);
  FreeAndNil(qryCadToc);
  FreeAndNil(qryCadCoc);
  FreeAndNil(qryCadOpe);
  FreeAndNil(qryTabela);
  FreeAndNil(cdsHisOco);
  FreeAndNil(cdsOcoPar);

  If Assigned(objRecorrencia) Then
    FreeAndNil(objRecorrencia);

  Inherited;
end;

procedure TfrmCadMovOcorrencias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ((Shift = [ssAlt]) And (Pos(FTip_Fc, 'C_P_') > 0)) Then
  Begin
    Case Key Of
      VK_F2 : mnuEfetivarOrcamento.Click;
      VK_F3 : mnuAlterarDocumento.Click;
      VK_F4 : Begin
                mnuEnviarEmail.Click;
                Key := 0;
              End;
      VK_F5 : mnuGerarPDF.Click;
      VK_F6 : mnuReimprimir.Click;
      VK_F7 : mnuGerarVendaPerdida.Click;
    End;
  End

  Else
  if Key = VK_ESCAPE then
    btnSair.Click
  Else
  If Key = VK_INSERT Then
  Begin
    if pgcGeral.ActivePage = tbsParticipa Then
    Begin
      pSetFocus(dbgOcoPar);
      cdsOcoPar.Append;
    End;
  End;
end;

procedure TfrmCadMovOcorrencias.FormShow(Sender: TObject);
begin
  If FTip_Fc = 'F' Then
  Begin
    qryCadCli := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
    grbCliente.Caption := 'Fornecedor';
    btnAlterarCli.Caption := 'A&lterar Fornecedor ';
  End

  Else
  If FTip_Fc = 'C' Then
  Begin
    qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
    btnAlterarCli.Caption := 'A&lterar Cliente ';
  End
  Else
  If FTip_Fc = 'P' Then
  Begin
    qryCadCli := fCriarQuery('SELECT * FROM PROSPE WHERE PRO_CODPRO = :CODPRO ', Self);
    grbCliente.Caption := 'Prospecto';
    btnAlterarCli.Caption := 'A&lterar Prospecto ';
  End;

  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  dbgOcoPar.ReadOnly := True;
  If FOperac = 'Inserir' Then
  Begin
    dbgOcoPar.ReadOnly := False;
    pInserirNovaOcorrencia;
    pCarregaOcoPar();
    pEscondeBotoesAgregados;
  End

  Else
  If FOperac = 'Alterar' Then
  Begin
    pAlterarOcorrencia;
  End

  Else
  If FOperac = 'Coleta' Then
  Begin

    btnArquivos.Visible   := False;
    btnEnviarEmail.Visible:= False;
    btnImprimir.Visible   := False;
    btnHistorico.Visible  := False;
    btnFinalizar.Visible  := False;
    btnConsultaAD.Visible := False;
    btnExcluir.Visible    := False;
    btnCancela.Visible    := False;

    btnGravar.Left        := 4;

    chkEnvEmail.Visible   := False;
    pnlCliente.Visible    := False;

    lblEmail.Visible      := False;
    edtEmail.Visible      := False;
    lblProtocolo.Visible  := False;
    dblProtocolo.Visible  := False;

    chkEnvEmailDestino.Visible   := False;
    lblEmailDestino.Visible := False;
    edtEmailDestino.Visible := False;

    pnlCabInf.Height := 120;

    qryTabela.Open;
    pInserirNovaOcorrencia;
    chkTornarRecorrente.Enabled := False;

    pAdicionaMascaras;

  End;

  tbsInfGerais.TabVisible := (Pos('Alterar',FOperac) <= 0);
  tbsHistorico.TabVisible := (Pos('Alterar',FOperac) >  0);
  If tbsHistorico.TabVisible Then
  Begin
    pnlComplemento.Visible := True;
    pnlSituacao.Visible := True;
    edtCodSit.Text := strCodSit;
    edtDesSitOco.Text := fRetDesSitOco(strCodSit);
    edtCodCpl.Text := strCodCpl;
    edtDesCpl.Text := fRetDescricao(strCodCpl, 'CADCOC', 'COC_CODCOC', 'COC_DESCOC');
    btnAltSituacao.Visible := fVerificaAcessoSistema('ALTSIT') Or (qryTabela.FieldByName('OCO_CODOPE').AsString = strLoginUsuarioLogado);
  End;

  pnlDatas.Visible := True;

  If tbsHistorico.TabVisible Then
    tbsFocus := tbsHistorico
  Else
    tbsFocus := tbsInfGerais;

  pgcGeral.ActivePage := tbsFocus;

  If strTip_Fc = 'P' Then
    btnArquivos.Visible   := False;

  dbeDataAgendamentoOriginal.enabled := False;
  dbeHoraAgendamentoOriginal.enabled := False;

  If Not fEmptyStr(dbeCodCli.Text) Then
    pCarregaCliente;

  If fEmptyStr(dbeCodCli.Text) Then
    pSetFocus(dbeCodCli)
  Else
    pSetFocus(dbeCodGOc);

  strNumLead := IIF(fEmptyStr(strNumLead), TLeads.fObterNumLead(FCodOco), strNumLead);

  chkTornarRecorrente.Visible := (strTip_Fc = 'C')  and fCfgSis('OCOREC', varBoolean);

  lblEmail.Caption := IIF(FTip_Fc = 'F', 'E-mail Fornecedor:', 'E-mail Cliente:');
  chkEnvEmail.Caption := IIF(FTip_Fc = 'F', 'Enviar ocorrência por e-mail - Fornecedor', 'Enviar ocorrência por e-mail - Cliente');

  blnEnvEmailDefault := chkEnvEmail.Checked;

  chkGerCom.Visible := fCfgSis('CGCODO', varBoolean);
end;

function TfrmCadMovOcorrencias.fProcessarCadastroRecorrenciaOcorrencia: Boolean;
begin
  If Not Assigned(objAtuOcoCrm) Then
    Exit(False);

  If Not Assigned(objRecorrencia) Then
    Exit(False);

  objAtuOcoCrm.pCarregaOcorrencia(FTip_Fc, qryTabela.FieldByName('OCO_CODOCO').AsString, qryTabela.FieldByName('OCO_CODEMP').AsString);
  objRecorrencia.blnEnviarEmailCliente := chkEnvEmail.Checked;
  objRecorrencia.blnEnviarEmailUsuario := chkEnvEmailDestino.Checked;
  objRecorrencia.EmailCli := edtEmail.Text;
  objRecorrencia.EmailUsu := edtEmailDestino.Text;

  Result := objRecorrencia.fInserirRecorrencia;
end;

function TfrmCadMovOcorrencias.fProcessosOcorrenciasDiferentes: Boolean;
begin
  Result := fOcorrenciaDevolucao(dbeTipOco.Text,FTip_Fc) Or
            ChkEmerge.Checked;
end;

function TfrmCadMovOcorrencias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbmDescri) Then
    Begin
      If fEmptyStr(dbmDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Ocorrência deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeCodGoc) Then
    Begin
      If fEmptyStr(dbeCodGoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do Grupo da Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaGrupoOcorrencia;
        If qryCadGoc.FieldByName('GOC_CODGOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Grupo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        If not fVerificaDireitoAcessoGrupoOcorrencia(qryCadGoc.FieldByName('GOC_CODGOC').AsString) Then
        Begin
          Result := False;
          fMensagem('', 'Usuário sem permissão para utilizar este grupo de ocorrência!', ['&Ok']);
        End;

      End;

      If Result And blnBuscaPorChave And (not fEmptyStr(dbeTipOco.Text)) Then
      Begin
        Result := fValidaCampos( dbeTipOco, True );
        If Not Result Then
          Sender := dbeTipOco;
      End;

    End

    Else
    If (Sender = dbeCodCli) And (FOperac <> 'Coleta') Then
    Begin
      If fEmptyStr(dbeCodCli.Text) Then
      Begin
        If FTip_Fc = 'P' Then
          fMensagem('ATENÇÃO!', 'O código do cliente prospecto da ocorrência deve ser preenchido!', ['&Ok'])
        Else
        If FTip_Fc = 'C' Then
          fMensagem('ATENÇÃO!', 'O código do cliente da ocorrência deve ser preenchido!', ['&Ok'])
        Else
          fMensagem('ATENÇÃO!', 'O código do fornecedor da ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If FTip_Fc = 'P' Then
        Begin
          If fEmptyStr(edtDesCodCli.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse código de cliente prospecto não está cadastrado ou já foi ativado para o cadastro de clientes!', ['&Ok']);
            Result := False;
          End;
        End

        Else
        If FTip_Fc = 'C' Then
        Begin
          If qryCadCli.FieldByName('CLI_CODCLI').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Código de Cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End;


        End
        Else
        Begin
          If qryCadCli.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Código de Fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else
    If (Sender = dbeTipOco) Then
    Begin
      If fEmptyStr(dbeTipOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaTipoOcorrencia;
        If qryCadToc.FieldByName('TOC_CODTOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If (Not fEmptyStr(FCliVen)) And (fProcessosOcorrenciasDiferentes) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Tipo de Ocorrência não poderá ser selecionada nesse processo!' + #13#10 +
                                'Essa Ocorrência não pode ser : ' + #13#10 +
                                'De devolução nem emergencial e nem Agenda de compromissos .' + #13#10 +
                                'Obrigado.', ['&Ok']);
          Result := False;
        End
        else If ((FOperac = 'Inserir') or (FOperac = 'Coleta')) and
            ((qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENORC', varString)) Or
             (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENPED', varString)) Or
             (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENVN_', varString))
            ) Then
        Begin
          If (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENVN_', varString)) Then
            fMensagem('', 'Ocorrência Referente à Venda não pode ser incluída manualmente!', ['&Ok'])
          Else
            fMensagem('', 'Ocorrência Referente a Pedido/Orçamento não pode ser incluída manualmente!', ['&Ok']);
          Result := False;
        End;

        If Result Then
        Begin
          If (strTip_Fc = 'C') Then
          Begin
            If qryCadToc.FieldByName('TOC_USACLI').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Clientes!');
            End;
          End

          Else
          If (strTip_Fc = 'P') Then
          Begin
            If qryCadToc.FieldByName('TOC_USAPRO').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Prospectos!');
            End;
          End

          Else
          If (strTip_Fc = 'F') Then
          Begin
            If qryCadToc.FieldByName('TOC_USAFOR').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Fornecedores!');
            End;
          End;

          If Result And (FOperac = 'Coleta') Then
          Begin
            If qryCadToc.FieldByName('TOC_USAGLO').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Geração Global de Ocorrências!');
            End;
          End;
        End;
      End;

      If Result And blnBuscaPorChave Then
        pHabilitarEnvioEmail();

      If Result And blnBuscaPorChave Then
        pCarregarEmailEnvio;

      If Result And blnBuscaPorChave Then
        pHabilitarGerarCompromisso;
    End

    Else
    If (Sender = dbeOpeOco) Then
    Begin
      If fEmptyStr(dbeOpeOco.Text) And (FTip_Fc = 'C') Then
      Begin
        if (Not blnOpeCadCli) And blnBuscaPorChave Then
        Begin
          blnOpeCadCli := fMensagem('ATENÇÃO!', 'Deseja preencher o usuário com o mesmo vendedor do Cadastro de Clientes?', ['&Sim', '&Não'],1) = 1;
          Result := blnOpeCadCli;
          
          If Result Then
          Begin
            If blnGeracaoGlobalOcorrencias Then
            Begin
              edtDesOpeOco.Text := 'Vendedor do cliente';
            End
            Else
            Begin
              If (fEmptyStr(fRetNomeOperador(fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [dbeCodCli.Text])))) Then
              Begin
                fMensagem('ATENÇÃO','Vendedor no cadastro do cliente não preenchido ou inexistente!',['&OK']);
                blnOpeCadCli := False;
                Result := blnOpeCadCli;
              End
              Else
              Begin
                edtDesOpeOco.Text := 'Vendedor do cliente';
                edtEmailDestino.Text := fRetEmailOperador(qryCadCli.FieldByName('CLI_CODVEN').AsString);
              End
            End;
          End
          Else
            fMensagem('ATENÇÃO','É obrigatório o preenchimento do cógido do operador!',['&OK'])

        End;
      End
      Else
      Begin
        blnOpeCadCli := False;
        pCarregaUsuarioOcorrencia;
        If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código do Usuário da Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;

        If (qryCadOpe.FieldByName('OPE_STATUS').AsString = 'I') Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador '+ qryCadOpe.FieldByName('OPE_CODOPE').AsString + '-' +
                                qryCadOpe.FieldByName('OPE_NOMOPE').AsString +' está inativo e não pode ser utilizado para geração de ocorrências.', ['&Ok']);
          Result := False;
        End;

      End;
    End

    Else
    If (Sender = dbeDtaInc) Then
    Begin
      If fEmptyStr(dbeDtaInc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inclusão deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeHorInc) Then
    Begin
      If fEmptyStr(dbeHorInc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Hora Inclusão deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

      If Not dbeHorCon.Enabled Then
      Begin
        pgcGeral.ActivePage := tbsFocus;
        pSetFocus(tbsFocus);
      End;

    End
    Else
    If (Sender = dbeDtaAge) Then
    Begin
      If fEmptyDate(dbeDtaAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Agendada deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaDataAgendamento;
      End;
    End

    Else
    If (Sender = dbeHorAge) Then
    Begin
      If fEmptyTime(dbeHorAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Hora Agendada deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaDataAgendamento;
      End;
    End
    Else
    If (Sender = dbeHorCon) Then
    Begin
      If (Not fEmptyStr(dbeHorCon.Text)) And (dbeHorCon.Text <> '  :  :  ') Then
      Begin
        If (fEmptyStr(dbeDtaCon.Text)) Or (dbeDtaCon.Text = '  /  /    ') Then
        begin
          fMensagem('ATENÇÃO!', 'A Data de Conclusão da Ocorrência deve ser preenchida!', ['&Ok']);
          Sender := dbeDtaCon;
          Result := False;
        end
        Else
          Result := fValidaDataConclusao;

      End
      Else If (Not fEmptyStr(dbeDtaCon.Text)) And (dbeDtaCon.Text <> '  /  /    ') Then
      Begin
        If (fEmptyStr(dbeHorCon.Text)) Or (dbeHorCon.Text = '  :  :  ') Then
        begin
          fMensagem('ATENÇÃO!', 'A Hora de Conclusão da Ocorrência deve ser preenchida!', ['&Ok']);
          Result := False;
        end
        Else
          Result := fValidaDataConclusao;
      End;

      If fEmptyTime(dbeHorCon.Text) Then
        dbeHorCon.Field.Clear;
      //pgcGeral.ActivePage := tbsFocus;
      //pSetFocus(tbsFocus);
    End

    Else
    If (Sender = dbeComple) Then
    Begin
      if not fEmptyStr(dbeComple.Text) then
      begin
        pCarregaComplementoOcorrencia;
        If qryCadCoc.FieldByName('COC_CODCOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Complemento da Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
      end
      Else
      Begin
        If (qryTabela.State in DsEditModes) And fEmptyStr(qryTabela.FieldByName('OCO_CODCOC').AsString) Then
          qryTabela.FieldByName('OCO_CODCOC').Clear;
      End;
    End

    Else
    If (Sender = dbeCodSit) Then
    Begin
      If not fEmptyStr(dbeCodSit.Text) Then
      Begin

        edtDesSit.Text := fRetDesSitOco(dbeCodSit.Text, dbeTipOco.Text);
        If fEmptyStr(edtDesSit.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O código da situação informado é inválido!', ['&Ok']);
          Result := False;
        End
        Else
        If Pos(dbeTipOco.Text, fRetTocSitOco(dbeCodSit.Text)) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A situação escolhida não pertence ao tipo selecionado!', ['&Ok']);
          Result := False;
        End;


      End;

    End

    Else
    If (Sender = edtEmail) And edtEmail.Visible And edtEmail.Enabled And tbsInfGerais.TabVisible Then
    Begin
      Result := fEmailValido(edtEmail.Text, False);
      If not Result Then
        fMensagem('', 'Informe um e-mail válido!', ['&Ok']);
    End
    Else
    If (Sender = edtEmailDestino) And edtEmailDestino.Visible And edtEmailDestino.Enabled And tbsInfGerais.TabVisible Then
    Begin
      Result := fEmailValido(edtEmailDestino.Text, False);
      If not Result Then
        fMensagem('', 'Informe um e-mail válido para o usuário de destino!', ['&Ok']);

    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadMovOcorrencias.fValidaDataAgendamento: Boolean;
var
  dtaInclusao: TDateTime;
  dtaAgendamento: TDateTime;
  dtaConclusao: TDateTime;
  intQtdDiaTol: Integer;
  fltDiasCalc: Double;
begin
  Result := True;
  dtaInclusao := StrToDateTimeDef(dbeDtaInc.Text + ' ' + dbeHorInc.Text, 0 );
  dtaAgendamento:= StrToDateTimeDef(dbeDtaAge.Text + ' ' + dbeHorAge.Text, 0 );
  dtaConclusao := StrToDateTimeDef(dbeDtaCon.Text + ' ' + dbeHorCon.Text, 0 );

  intQtdDiaTol := fCfgSis('DIATOL', varInteger);

  If dtaInclusao > dtaAgendamento Then
  Begin
    fltDiasCalc := DaysBetween(dtaInclusao, dtaAgendamento);

    Result := (intQtdDiaTol > 0) and (intQtdDiaTol >= fltDiasCalc);
  End;

  If Not Result Then
  Begin
    If (intQtdDiaTol = 0) Then
      fMensagem('ATENÇÃO!', 'A Data Agendada não permite lançamento de data retroativa. Verifique !', ['&Ok'])
    Else
      fMensagem('ATENÇÃO!', 'A Data Agendada deve ser maior que a data de inclusão!', ['&Ok']);

    Exit;
  End;

  Result := (dtaAgendamento >= dtaInclusao);
  If Not Result Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data Agendada deve ser maior que a data de inclusão!', ['&Ok']);
    Exit;
  End;

  If (dtaConclusao > 0) Then
  Begin
    Result := (dtaAgendamento >= dtaInclusao);
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data Agendada deve ser menor que a data de conclusão!', ['&Ok']);
      Exit;
    End;
  End;

end;

function TfrmCadMovOcorrencias.fValidaDataConclusao: Boolean;
var
  dtaInclusao: TDateTime;
  dtaConclusao: TDateTime;
  intQtdDiaTol: Integer;
  fltDiasCalc: Double;
begin
  Result := True;

  dtaInclusao := StrToDateTimeDef(dbeDtaInc.Text + ' ' + dbeHorInc.Text, 0);

  If dtaInclusao <= 0 Then
    dtaInclusao := VS_Date + fRetHoraServidor();

  dtaConclusao := StrToDateTimeDef(dbeDtaCon.Text + ' ' + dbeHorCon.Text, 0);

  intQtdDiaTol := fCfgSis('DIATOL', varInteger);

  If dtaInclusao > dtaConclusao Then
  Begin
    fltDiasCalc := DaysBetween(dtaInclusao, dtaConclusao);

    FBlnPermiteDataRetroativa := (intQtdDiaTol > 0) and (intQtdDiaTol >= fltDiasCalc);

    If FBlnPermiteDataRetroativa Then
    Begin
      dbeDtaInc.Text := dbeDtaCon.Text;
      dbeHorInc.Text := dbeHorCon.Text;

      If Not fValidaDataAgendamento Then
      Begin
        dbeDtaAge.Text := dbeDtaCon.Text;
        dbeHorAge.Text := dbeHorCon.Text;
      End;
    End;

    Result := FBlnPermiteDataRetroativa;
  End;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data/Hora de Conclusão deve ser maior que a data/hora de inclusão!', ['&Ok']);
  End;
end;

function TfrmCadMovOcorrencias.getCliVen: String;
begin
  Result := FCliVen;
end;

function TfrmCadMovOcorrencias.getCodCli: String;
begin
  Result := FCodCli;
end;

function TfrmCadMovOcorrencias.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TfrmCadMovOcorrencias.getCodOco: String;
begin
  Result := FCodOco;
end;

function TfrmCadMovOcorrencias.getCpfCli: String;
begin
  Result := FCpfCli;
end;

{
function TfrmCadMovOcorrencias.getConDev: Boolean;
begin
  Result := FConDev;
end;
}

function TfrmCadMovOcorrencias.getOpeOco: String;
begin
  Result := FOpeOco;
end;

function TfrmCadMovOcorrencias.getOperac: String;
begin
  Result := FOperac;
end;

function TfrmCadMovOcorrencias.GetqryTabela: TUniQuery;
begin
  Result := qryTabela;
end;

function TfrmCadMovOcorrencias.getTip_Fc: String;
begin
  Result := FTip_Fc;
end;

function TfrmCadMovOcorrencias.getCodLad: String;
begin
  Result := FCodLad;
end;


procedure TfrmCadMovOcorrencias.mnuAlterarDocumentoClick(Sender: TObject);
  Var
    popMenu: TPopupMenu;
begin
  If Not (Pos(FTip_Fc, 'C_P_') > 0) Then
    Exit;

  inherited;
  popMenu := nil;

  If (qryTabela.FieldByName('OCO_ESPDOC').AsString = 'PD') Then
    popMenu := popPedido
  Else If (qryTabela.FieldByName('OCO_ESPDOC').AsString = 'OR') Then
    popMenu := popOrcamento;

  If Assigned(popMenu) Then
  Begin
    pAlterarDocumento(Concat(qryTabela.FieldByName('OCO_NUMDOC').AsString, '-',
                             qryTabela.FieldByName('OCO_ESPDOC').AsString, '-',
                             qryTabela.FieldByName('OCO_CODEMP').AsString),
                      strCodCli,
                      popMenu,
                      (FTip_Fc = 'P'));

    pConsultaNovoHistoricoOcorrecia();
    pCarregaHistorioOcorrencia();
    pCarregaOcoPar();
  End;
end;

procedure TfrmCadMovOcorrencias.mnuEfetivarOrcamentoClick(Sender: TObject);
begin
  inherited;

  If (Not mnuEfetivarOrcamento.Visible) Or
    (Not (Pos(FTip_Fc, 'C_P_') > 0)) Then
    Exit;

  If fEfetivarOrcamentoEmPedido(Concat(qryTabela.FieldByName('OCO_NUMDOC').AsString, '-',
                                       qryTabela.FieldByName('OCO_ESPDOC').AsString, '-',
                                       qryTabela.FieldByName('OCO_CODEMP').AsString), strCodCli) Then
  Begin
    pConsultaNovoHistoricoOcorrecia();
    pCarregaHistorioOcorrencia();
    pCarregaOcoPar();
  End;
end;

procedure TfrmCadMovOcorrencias.mnuEnviarEmailClick(Sender: TObject);
begin
  inherited;

  If Not (Pos(FTip_Fc, 'C_P_') > 0) Then
    Exit;

  pEnviarEmail(Self,
               Concat(qryTabela.FieldByName('OCO_NUMDOC').AsString, '-',
                      qryTabela.FieldByName('OCO_ESPDOC').AsString, '-',
                      qryTabela.FieldByName('OCO_CODEMP').AsString),
               strCodCli,
               qryCadCli.FieldByName(Concat(IIF(FTip_Fc = 'C', 'CLI', 'PRO'), '_NOMCLI')).AsString,
               qryCadCli.FieldByName(Concat(IIF(FTip_Fc = 'C', 'CLI', 'PRO'), '_EMAIL_')).AsString);
end;

procedure TfrmCadMovOcorrencias.mnuGerarPDFClick(Sender: TObject);
begin
  inherited;
  pGerarPDF(Concat(qryTabela.FieldByName('OCO_NUMDOC').AsString, '-',
                   qryTabela.FieldByName('OCO_ESPDOC').AsString, '-',
                   qryTabela.FieldByName('OCO_CODEMP').AsString));
end;

procedure TfrmCadMovOcorrencias.mnuGerarVendaPerdidaClick(Sender: TObject);
begin
  inherited;
  If (Not mnuGerarVendaPerdida.Visible) Or
     (Not (Pos(FTip_Fc, 'C_P_') > 0)) Then
    Exit;

  pGerarVendaPerdida(Concat(qryTabela.FieldByName('OCO_NUMDOC').AsString, '-',
                            qryTabela.FieldByName('OCO_ESPDOC').AsString, '-',
                            qryTabela.FieldByName('OCO_CODEMP').AsString));
  pConsultaNovoHistoricoOcorrecia();
  pCarregaHistorioOcorrencia();
  pCarregaOcoPar();
end;

procedure TfrmCadMovOcorrencias.mnuReimprimirClick(Sender: TObject);
  Var
    strNomeArquivo: String;
begin
  inherited;
  If (Not fEmptyStr(qryTabela.FieldByName('OCO_NUMDOC').AsString)) Then
  Begin
    pImprimeFatImp('FATGOR',
                   qryTabela.FieldByName('OCO_NUMDOC').AsString,
                   qryTabela.FieldByName('OCO_ESPDOC').AsString,
                   qryTabela.FieldByName('OCO_CODEMP').AsString,
                   strCodCli,
                   'C',
                   '',
                   True,
                   strNomeArquivo,
                   False);
  End;
end;

procedure TfrmCadMovOcorrencias.pAbrirTelaRecorrencia;
var
  frmCadRecorrenciaOcorrencia: TfrmCadRecorrenciaOcorrencia;
begin
  pCriarFormularios(TfrmCadRecorrenciaOcorrencia, frmCadRecorrenciaOcorrencia);
  Try
    objRecorrencia.pSugerirDataInicial(qryTabela.FieldByName('OCO_DTAINC').AsDateTime,
                                       qryTabela.FieldByName('OCO_HORINC').AsDateTime);
    frmCadRecorrenciaOcorrencia.ObjRecorrencia := objRecorrencia;
    frmCadRecorrenciaOcorrencia.ShowModal;
  Finally
    pFreeAndNil(frmCadRecorrenciaOcorrencia);
  End;
end;

procedure TfrmCadMovOcorrencias.pAdicionaMascaras;
begin
  with qryTabela do
  begin
    TDateField(FieldByName('OCO_DTAAGE')).EditMask := '99/99/9999';
    TDateField(FieldByName('OCO_HORAGE')).EditMask := '99:99:99';
    TDateField(FieldByName('OCO_DTACON')).EditMask := '99/99/9999';
    TDateField(FieldByName('OCO_HORCON')).EditMask := '99:99:99';
    TDateField(FieldByName('OCO_DTAAGO')).EditMask := '99/99/9999';
    TDateField(FieldByName('OCO_HORAGO')).EditMask := '99:99:99';
  end;
end;

procedure TfrmCadMovOcorrencias.pAlterarOcorrencia;
begin
  pConsultaNovoHistoricoOcorrecia;
  pCarregaTipoOcorrencia;
  pCarregaComplementoOcorrencia;
  dbeCodGOc.Text := qryCadToc.FieldByName('TOC_CODGOC').AsString;
  pCarregaGrupoOcorrencia;
  pCarregaUsuarioOcorrencia;
  pCarregaCliente;
  pHabilitaBotoesAgregados;
  pDesabilitaFormulario;

  pCarregaHistorioOcorrencia;
  pCarregaOcoPar();

  btnAlterarCli.Visible := fVerificaPodeAlterarOcorrencia;
  btnAlterarCli.Enabled := btnAlterarCli.Visible;
end;

procedure TfrmCadMovOcorrencias.pCarregaCliente;
begin
  If FTip_Fc = 'P' Then
  Begin
    qryCadCli.Close;
    qryCadCli.ParamByName('CODPRO').AsString := dbeCodCli.Text;
    qryCadCli.Open;
    edtDesCodCli.Text := qryCadCli.FieldByName('PRO_NOMCLI').AsString;
  End

  Else If FTip_Fc = 'C' Then
  Begin
    If qryCadCli.Active Then
      If dbeCodCli.Text <> qryCadCli.FieldByName('CLI_CODCLI').AsString Then
        FCpfCli := EmptyStr;

    If not(fEmptyStr(dbeCodCli.Text)) Then
      pPesquisaCadCli(qryTabela, qryCadCli, dbeCodCli.Text);

    pCarregarDadosCliente;
  End

  Else
  Begin
    pPesquisaCadFor(qryTabela, qryCadCli, dbeCodCli.Text);
    edtDesCodCli.Text := qryCadCli.FieldByName('FOR_NOMFOR').AsString;
  End;

  edtEmail.Text := fGetEmailPadrao;
end;

procedure TfrmCadMovOcorrencias.pCarregarDadosCliente;
begin
  edtDesCodCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
  blnClienteConsumidor := fClienteConsumidor(edtDesCodCli.Text);

  If blnClienteConsumidor Then
  Begin
    If (FOperac = 'Inserir') And fEmptyStr(FCpfCli) Then
    Begin
      pCarregaCliConsumidor;
    End
    Else
      edtDesCodCli.Text := fCampoTabela('CON_NOMCON', 'CLICON', ['CON_C_P_F_'], [FCpfCli], False);
  End;
end;

procedure TfrmCadMovOcorrencias.pCarregaCliConsumidor;
begin
  pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);

  frmFatDadosCliConsumidor.strCodCli      := qryCadCli.FieldByName('CLI_CODCLI').AsString;
  frmFatDadosCliConsumidor.edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
  frmFatDadosCliConsumidor.edtEndere.Text := qryCadCli.FieldByName('CLI_ENDERE').AsString;
  frmFatDadosCliConsumidor.edtBairro.Text := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
  frmFatDadosCliConsumidor.mskNumCep.Text := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
  frmFatDadosCliConsumidor.edtCodCid.Text := qryCadCli.FieldByName('CLI_CODCID').AsString;
  frmFatDadosCliConsumidor.edtNomCid.Text := fRetNomCidade(qryCadCli.FieldByName('CLI_CODCID').AsString, 0);
  frmFatDadosCliConsumidor.edtEstado.Text := fRetNomCidade(qryCadCli.FieldByName('CLI_CODCID').AsString, 1);
  frmFatDadosCliConsumidor.mskTelCon.Text := qryCadCli.FieldByName('CLI_FONE01').AsString;
  frmFatDadosCliConsumidor.edtCgcCpf.Text := qryCadCli.FieldByName('CLI_CGCCPF').AsString;
  frmFatDadosCliConsumidor.mskNumCgc.Text := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
  frmFatDadosCliConsumidor.edtInsEst.Text := qryCadCli.FieldByName('CLI_I_E_S_').AsString;
  frmFatDadosCliConsumidor.edtRgCli.Text  := qryCadCli.FieldByName('CLI_NUMR_G').AsString;
  frmFatDadosCliConsumidor.edtEmail_.Text := qryCadCli.FieldByName('CLI_EMAIL3').AsString;
  frmFatDadosCliConsumidor.strEstado      := frmFatDadosCliConsumidor.edtEstado.Text;
  frmFatDadosCliConsumidor.ShowModal;

  If frmFatDadosCliConsumidor.blnConfirma Then
  Begin
    FCpfCli := frmFatDadosCliConsumidor.mskNumCgc.Text;
    edtDesCodCli.Text := frmFatDadosCliConsumidor.edtNomCli.Text;
  End;

  FreeAndNil(frmFatDadosCliConsumidor);
end;

procedure TfrmCadMovOcorrencias.pCarregaComplementoOcorrencia;
begin
  if (fEmptyStr(dbeTipOco.Text)) And (dtsMovOco.State in [dsInsert, dsEdit]) then
  begin
    fMensagem('Informação!','Favor Informar o Tipo da Ocorrência!',['OK']);
    dbeComple.Text := '';
    Exit;
  end;

  pPesquisaCadCoc(qryTabela, qryCadCoc, dbeComple.Text, dbeTipOco.Text);
  With qryCadCoc Do
  Begin
    dbeDesComple.Text := FieldByName('COC_DESCOC').AsString;
  End;
end;

procedure TfrmCadMovOcorrencias.pCarregaGrupoOcorrencia;
begin
  pPesquisaCadGOc(nil, qryCadGoc, dbeCodGoc.Text);
  With qryCadGoc Do
  Begin
    edtDesCodGoc.Text := FieldByName('GOC_DESGOC').AsString;
  End;
end;

procedure TfrmCadMovOcorrencias.pCarregaTipoOcorrencia;
begin
  if (fEmptyStr(dbeCodGoc.Text)) And (dtsMovOco.State in [dsInsert, dsEdit]) then
  begin
    fMensagem('Informação!','Favor Informar o Grupo da Ocorrência!',['OK']);
    dbeTipOco.Text := '';
    Exit;
  end;

  pPesquisaCadToc(qryTabela, qryCadToc, dbeTipOco.Text, dbeCodGoc.Text);
  With qryCadToc Do
  Begin
    edtDesTipOco.Text := FieldByName('TOC_DESTOC').AsString;
  End;

  If (FOperac = 'Alterar') And ((qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENORC', varString)) Or
                                (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENPED', varString))) Then
  Begin
    dbeDtaCon.Enabled := False;
    dbeHorCon.Enabled := False;

    dbeDtaCon.ReadOnly := True;
    dbeHorCon.ReadOnly := True;
  End;

  If fOcorrenciaDevolucao(qryCadToc.FieldByName('TOC_CODTOC').AsString, FTip_Fc) Then
    btnGravarEfinalizar.Enabled := False
  Else
    btnGravarEfinalizar.Enabled := btnGravar.Enabled;

end;

procedure TfrmCadMovOcorrencias.pCarregaUsuarioOcorrencia;
begin
  pPesquisaCadOpe(qryTabela, qryCadOpe, dbeOpeOco.Text);
  With qryCadOpe Do
  Begin
    If edtDesOpeOco.Text <> FieldByName('OPE_NOMOPE').AsString Then
      edtEmailDestino.Text := FieldByName('OPE_E_MAIL').AsString;

    edtDesOpeOco.Text := FieldByName('OPE_NOMOPE').AsString;

    If fEmptyStr( edtEmailDestino.Text ) Then
    Begin
      edtEmailDestino.Text := FieldByName('OPE_E_MAIL').AsString;
    End;
  End;
end;

function TfrmCadMovOcorrencias.fChamaFormularioCancelamentoDocumentos : Boolean;
  Var
    frmCancelamentoDocumentos : TfrmCancelamentoDocumentos;
Begin
  Result := False;
  Try
    pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
    frmCancelamentoDocumentos.blnPegaDados   := True;
    frmCancelamentoDocumentos.strTipPes      := strTip_Fc;
    frmCancelamentoDocumentos.edtCliFor.Text := dbeCodCli.Text;
    frmCancelamentoDocumentos.edtDescri.Text := IfThen(strTip_Fc = 'F', fRetNomFornecedor(dbeCodCli.Text),
                                                                        fRetNomCliente(dbeCodCli.Text));

    If frmCancelamentoDocumentos.ShowModal = MrOK Then
    Begin
      strNumDocCanc       := frmCancelamentoDocumentos.edtNumDoc.Text;
      strSerieCanc        := frmCancelamentoDocumentos.edtSerie.Text;
      strCliForCanc       := frmCancelamentoDocumentos.edtCliFor.Text;
      blnInutilizacaoCanc := frmCancelamentoDocumentos.chkInutilizacao.Checked;
      intOpcaoCanc        := frmCancelamentoDocumentos.intOpcao;
      strMotDelCanc       := frmCancelamentoDocumentos.strMotDel;
      strHisComCanc       := frmCancelamentoDocumentos.strHisCom;
      strEspSelCanc       := frmCancelamentoDocumentos.fGetEspSel;
      Result := True;
    End;

  Finally
    pFreeAndNil(frmCancelamentoDocumentos);
  End;
End;

function TfrmCadMovOcorrencias.fEnviaEmergencial(strAssunt: String;
  StrMsg: WideString; arrOpeEmer: TStringArray): String;
var
  strAutIncMsg: String;
  MsgInterna: TMsgInterna;
  intCount: Integer;
begin
  strAutIncMsg := '';

  MsgInterna := TMsgInterna.Create(Self);

  for intCount := Low(arrOpeEmer) to High(arrOpeEmer) do
  begin
    MsgInterna.fEnviaMensagemAutInc(strAssunt, StrMsg, strLoginUsuarioLogado, LeftStr(arrOpeEmer[intCount],3), 'N', '', strAutIncMsg);
  end;

  pAtualizaMsgLida(strAutIncMsg,
                   qryTabela.FieldByName('OCO_DTACON').AsDateTime,
                   qryTabela.FieldByName('OCO_HORCON').AsDateTime);

  FreeAndNil(MsgInterna);
  Result := strAutIncMsg;
end;

function TfrmCadMovOcorrencias.fChamaHistoricoOcorrenciasInternal: Boolean;
  Var
    strCodCli,
    strNomCli,
    strCliEma: String;
begin
  If qryTabela.FieldByName('OCO_TIP_FC').AsString = 'P' Then
  Begin
    strCodCli := qryCadCli.FieldByName('PRO_CODPRO').AsString;
    strNomCli := qryCadCli.FieldByName('PRO_NOMCLI').AsString;
    strCliEma := qryCadCli.FieldByName('PRO_EMAIL_').AsString;
  End
  Else
  If qryTabela.FieldByName('OCO_TIP_FC').AsString = 'C' Then
  Begin
    strCodCli := qryCadCli.FieldByName('CLI_CODCLI').AsString;
    strNomCli := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
    strCliEma := qryCadCli.FieldByName('CLI_EMAIL_').AsString;
  End
  Else
  Begin
    strCodCli := qryCadCli.FieldByName('FOR_CODFOR').AsString;
    strNomCli := qryCadCli.FieldByName('FOR_NOMFOR').AsString;
    strCliEma := qryCadCli.FieldByName('FOR_EMAIL_').AsString;
  End;

  Result := fChamaHistoricoOcorrencias(qryTabela.FieldByName('OCO_CODOCO').AsString,
                                       qryTabela.FieldByName('OCO_CODEMP').AsString,
                                       strCodCli, strNomCli, strCliEma,
                                       qryCadGoc.FieldByName('GOC_CODGOC').AsString,
                                       qryCadGoc.FieldByName('GOC_DESGOC').AsString,
                                       qryCadToc.FieldByName('TOC_CODTOC').AsString,
                                       qryCadToc.FieldByName('TOC_DESTOC').AsString,
                                       qryCadCoc.FieldByName('COC_CODCOC').AsString,
                                       qryCadCoc.FieldByName('COC_DESCOC').AsString,
                                       qryTabela.FieldByName('OCO_TIP_FC').AsString,
                                       qryTabela.FieldByName('OCO_PROTOC').AsString,
                                       qryTabela.FieldByName('OCO_NUMDOC').AsString,
                                       qryTabela.FieldByName('OCO_ESPDOC').AsString,
                                       qryTabela.FieldByName('OCO_CODSIT').AsString,
                                       FOcoFin,
                                       IIF(fEmptyStr(dbeComple.Text) ,'', fBuscaMensagemPadraoOcorrenciaCRM(dbeComple.Text)));
end;

procedure TfrmCadMovOcorrencias.pDesabilitaFormulario;
begin
  dbmDescri.Enabled  := True;
  dbmDescri.ReadOnly := True;
  btnGravar.Enabled  := False;
  btnExcluir.Enabled := False;
  btnCancela.Enabled := False;
  btnGravarEfinalizar.Enabled := False;
end;

procedure TfrmCadMovOcorrencias.pDesejaEnviarPorEmail;
begin
  If ((chkEnvEmail.Checked) or (chkEnvEmailDestino.Checked)) Then
  Begin
    If (Not fOcorrenciaConcluida(qryTabela.FieldByName('OCO_DTACON').AsDateTime,qryTabela.FieldByName('OCO_HORCON').AsDateTime)) Then
      pPerguntaAnteDeEnviar
    Else
      pEnviarSemPerguntar;
  End;
end;

procedure TfrmCadMovOcorrencias.pEnviarSemPerguntar;
Var
  blnDevolucao : Boolean;
  Anexos: TStringArray;
begin
  blnDevolucao := fOcorrenciaDevolucao(qryTabela.FieldByName('OCO_CODTOC').AsString, FTip_Fc);

  If blnDevolucao And FileExists(FArqDev) Then
    pAddDados(Anexos, FArqDev);

  pEnviarEmailSemPerguntar(Self,
                           IfThen(chkEnvEmail.Checked, edtEmail.Text,''),
                           IfThen(chkEnvEmailDestino.Checked, edtEmailDestino.Text,''),
                           dbeCodCli.Text,
                           edtDesCodCli.Text,
                           dbeCodGOc.Text,
                           edtDesCodGoc.Text,
                           dbeDtaInc.Text,
                           dbeHorInc.Text,
                           dbeTipOco.Text,
                           edtDesTipOco.Text,
                           dbeOpeOco.Text,
                           edtDesOpeOco.Text,
                           dbmDescri.Text + FInfDev,
                           dbeComple.Text,
                           dbeDesComple.Text,
                           FTip_Fc,
                           dblProtocolo.Caption,
                           Anexos,
                           False,
                           strNumLead,
                           qryTabela.FieldByName('OCO_CODOCO').AsString);
end;

procedure TfrmCadMovOcorrencias.pEscondeBotoesAgregados;
begin
  btnArquivos.Enabled := False;
  btnEnviarEmail.Enabled := False;
  btnHistorico.Enabled := False;
//  btnImprimir.Enabled  := False;
  btnFinalizar.Enabled := False;
  btnConsultaAD.Enabled := False;  
end;

procedure TfrmCadMovOcorrencias.pGeraOcorrenciasImpressaoEtiquetasClientes;
begin
  Try
    objAtuOcoCrm := TAtuOcoCrm.Create(Self);
    objAtuOcoCrm.strNomFrm    := Self.Name;
    objAtuOcoCrm.strCliVen    := FCliVen;
    //Primeiro cliente da etiqueta que ja gerou a primeira ocorrencia.Entao nao pode ser repitido o cliente.
    objAtuOcoCrm.strCliPriVen := qryTabela.FieldByName('OCO_CODCLI').AsString;
    objAtuOcoCrm.strCodOpe    := qryTabela.FieldByName('OCO_CODOPE').AsString;
    objAtuOcoCrm.strCodEmp    := qryTabela.FieldByName('OCO_CODEMP').AsString;
    objAtuOcoCrm.strDescri    := qryTabela.FieldByName('OCO_DESCRI').AsString;
    objAtuOcoCrm.strCodToc    := qryTabela.FieldByName('OCO_CODTOC').AsString;
    objAtuOcoCrm.strCodCoc    := qryTabela.FieldByName('OCO_CODCOC').AsString;
    objAtuOcoCrm.pInsereClientesImpressaoEtiquetas;
  Finally
    objAtuOcoCrm.Free;
  End;
end;

procedure TfrmCadMovOcorrencias.pGerarCompromisso;
  Var
    qryAgenda: TUniQuery;

  function fRetornaSQLGeraCompromisso: string;
    Var
      strSQL: String;
  begin
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  AGENDA (AUTOINCREM, AGE_CODEMP, AGE_CODOPE, AGE_DTACOM, AGE_HORCOM, AGE_TITULO, AGE_DESCRI, AGE_BAIXAD) ';
    strSQL := strSQL + 'VALUES ';
    strSQL := strSQL + '         (:AUTOIN,   :CODEMP,     :CODOPE,    :DTACOM,    :HORCOM,    :TITULO,    :DESCRI,    ''N'')        ';
    Result := strSQL;
  end;
begin
  If Not fCfgSis('CGCODO', varBoolean) Then
    Exit;

  If Not chkGerCom.Checked Then
    Exit;

  if Not SameText(FOperac, 'Inserir') Then
    Exit;

  qryAgenda := fCriaQuery(Self);

  Try
    qryAgenda.SQL.Text := fRetornaSQLGeraCompromisso;
    qryAgenda.ParamByName('AUTOIN').AsString := fRetAutoIncrem('AGENDA', qryTabela.FieldByName('OCO_CODEMP').AsString);
    qryAgenda.ParamByName('CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;
    qryAgenda.ParamByName('CODOPE').AsString := qryTabela.FieldByName('OCO_CODOPE').AsString;
    qryAgenda.ParamByName('DTACOM').AsDate   := qryTabela.FieldByName('OCO_DTAAGE').AsDateTime;
    qryAgenda.ParamByName('HORCOM').AsTime   := qryTabela.FieldByName('OCO_HORAGE').AsDateTime;
    qryAgenda.ParamByName('TITULO').AsString := qryTabela.FieldByName('OCO_CODCLI').AsString + '-' +
                                                edtDesCodCli.Text;
    qryAgenda.ParamByName('DESCRI').AsString := qryTabela.FieldByName('OCO_DESCRI').AsString + '. Protocolo:' +
                                                qryTabela.FieldByName('OCO_PROTOC').AsString;
    qryAgenda.ExecSQL;
  Finally
    FreeAndNil(qryAgenda);
  End;
end;

procedure TfrmCadMovOcorrencias.pGerarEspelhoDevolucaoAD;
Var
  objGerarEspelho: TGerarEspelhoDevolucaoAD;
  strPath: String;
  strArqPDF: String;
  strMensagem: String;
begin
  FArqDev := '';
  objGerarEspelho := TGerarEspelhoDevolucaoAD.Create;
  Try
    Try
      If objGerarEspelho.fGerarEspelho(dbeCodCli.Text, FNumDev, VS_strCodEmp) Then
      Begin
        strPath := ExtractFilePath(Application.ExeName)+ 'Arquivos_crm\' + qryTabela.FieldByName('OCO_CODOCO').AsString;
        strArqPDF := 'Espelho_AD_' + FNumDev + '.pdf';

        If Not( DirectoryExists(strPath) ) Then
          If Not( fCriaDiretorio(strPath) ) Then
          Begin
            strMensagem :=  'Não é possível criar/carregar a pasta do cliente!!!'            +#13+
                            'Talvez você não tenha permissão de leitura/gravação na pasta!!!'+#13+
                            'Procure o Administrador do Sistema e informe este erro: '       +#13+
                            'Não conseguiu criar a pasta ' + strPath;

            objGerarEspelho.pGravarLog(tpErroGrav, strMensagem);
            fMensagem('ATENÇÃO!', strMensagem, ['&Ok']);
            Exit;
          End;

        TfrmEspelhoImpressao.pImprimeEspelho('', VS_strCodEmp, objGerarEspelho.strNumeroEspelho, strPath + '\' + strArqPDF);

        FArqDev := strPath + '\' + strArqPDF;
      End;
    Except
      On E: Exception Do
      Begin
        objGerarEspelho.pGravarLog(tpErroGenerico, E.Message);
        pMensagensErro(E.Message,'[TfrmCadMovOcorrencias.pGerarEspelhoDevolucaoAD]');
      End;
    End;
  Finally
    FreeAndNil(objGerarEspelho);
  End;
end;

procedure TfrmCadMovOcorrencias.pGravarMsg(strAutIncMsg: String);
var
  qryMsgOco : TUniQuery;
  objOcoCrm : TAtuOcoCrm;
begin
  qryMsgOco := fCriaQuery;
  Try
    qryMsgOco.Close;
    qryMsgOco.SQL.Clear;
    qryMsgOco.SQL.Add(' SELECT DISTINCT                                ');
    qryMsgOco.SQL.Add('        GROUP_CONCAT(MSG_OPEREC SEPARATOR ", ") AS OPERAD, ');
    qryMsgOco.SQL.Add('        MSG_MENSAG                              ');
    qryMsgOco.SQL.Add(' FROM CADMSG                                    ');
    qryMsgOco.SQL.Add(' WHERE AUTOINCREM IN ( ' + strAutIncMsg + ')    ');
    qryMsgOco.Open;

    If Not qryMsgOco.IsEmpty Then
    Begin
      objOcoCrm := fAtualizaInformacoesCRM('',
                                           '',
                                           VS_strCodEmp,
                                           dbeCodCli.Text,
                                           '',
                                           '',
                                           qryTabela.FieldByName('OCO_CODOPE').AsString,
                                           afcNenhum);

      objOcoCrm.strTip_Fc := strTip_Fc;
      objOcoCrm.strCodToc := qryTabela.FieldByName('OCO_CODTOC').AsString;
      objOcoCrm.strCodOco := qryTabela.FieldByName('OCO_CODOCO').AsString;
      objOcoCrm.strNomFrm := Self.Name;
      If FBlnPermiteDataRetroativa Then
      Begin
        objOcoCrm.strDtaInc := qryTabela.FieldByName('OCO_DTACON').AsDateTime;
        objOcoCrm.strHorInc := qryTabela.FieldByName('OCO_HORCON').AsDateTime;
      End
      Else
      Begin
        objOcoCrm.strDtaInc := VS_Date;
        objOcoCrm.strHorInc := fRetHoraServidor();
      End;
      objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
      objOcoCrm.strHorAge := objOcoCrm.strHorInc;
      objOcoCrm.strOpeHis := qryTabela.FieldByName('OCO_OPEOCO').AsString;
      objOcoCrm.strDtaCon := qryTabela.FieldByName('OCO_DTACON').AsDateTime;
      objOcoCrm.strHorCon := qryTabela.FieldByName('OCO_HORCON').AsDateTime;;
      objOcoCrm.strDescri := 'Mensagem Enviada<<csq>>' +
                             qryMsgOco.FieldByName('MSG_MENSAG').AsString + '<<csq>>' +
                             'Destinatário(s): ' + qryMsgOco.FieldByName('OPERAD').AsString +
                             '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                              DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

      objOcoCrm.strOperadoresDestino := qryMsgOco.FieldByName('OPERAD').AsString;
      objOcoCrm.BlnMsgMultiplosDestinatarios := True;
      objOcoCrm.pInsereHistoricoOcorrencia;
      objOcoCrm.pAtualizaOcorrencia;

      qryMsgOco.Close;
      qryMsgOco.SQL.Clear;
      qryMsgOco.SQL.Add(' INSERT INTO MSGOCO ( MSO_SEQMSG,            ');
      qryMsgOco.SQL.Add('                      MSO_CODOCO,            ');
      qryMsgOco.SQL.Add('                      MSO_CODEMP,            ');
      qryMsgOco.SQL.Add('                      MSO_CODTOC,            ');
      qryMsgOco.SQL.Add('                      MSO_CODCLI)            ');
      qryMsgOco.SQL.Add(' SELECT AUTOINCREM,                          ');
      qryMsgOco.SQL.Add('        :CODOCO,                             ');
      qryMsgOco.SQL.Add('        :CODEMP,                             ');
      qryMsgOco.SQL.Add('        :CODTOC,                             ');
      qryMsgOco.SQL.Add('        :CODCLI                              ');
      qryMsgOco.SQL.Add(' FROM CADMSG                                 ');
      qryMsgOco.SQL.Add(' WHERE AUTOINCREM IN ( ' + strAutIncMsg + ') ');

      qryMsgOco.ParamByName('CODOCO').AsString := qryTabela.FieldByName('OCO_CODOCO').AsString;
      qryMsgOco.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryMsgOco.ParamByName('CODTOC').AsString := qryTabela.FieldByName('OCO_CODTOC').AsString;
      qryMsgOco.ParamByName('CODCLI').AsString := dbeCodCli.Text;

      qryMsgOco.ExecSQL;
    End;

  Finally
    FreeAndNil(qryMsgOco);
    If Assigned(objOcoCrm) Then
      FreeAndNil(objOcoCrm);

    pCarregaHistorioOcorrencia;
    pCarregaOcoPar();
  End;
end;

Function TfrmCadMovOcorrencias.fGravaDadosDocumentoACancelar:Boolean;
  Var
    qryInsert : TUniQuery;
    objOcoCrm : TAtuOcoCrm;
    strNumPro : String;
Begin
  Try
    Result := True;
    qryInsert := fCriaQuery;
    With qryInsert, SQL Do
    Begin
      Close;
      Clear;
      Add( ' INSERT INTO PROCRM ( AUTOINCREM, ');
      Add( '                      PRO_NUMPRO, ');
      Add( '                      PRO_NUMDOC, ');
      Add( '                      PRO_SERIE_, ');
      Add( '                      PRO_CLIFOR, ');
      Add( '                      PRO_TIP_FC, ');
      Add( '                      PRO_INUTIL, ');
      Add( '                      PRO_OPCCAN, ');
      Add( '                      PRO_ESPSEL, ');
      Add( '                      PRO_CODMOT, ');
      Add( '                      PRO_HISTOR, ');
      Add( '                      PRO_OPECAD, ');
      Add( '                      PRO_DTACAD, ');
      Add( '                      PRO_CODOCO, ');
      Add( '                      PRO_CODEMP, ');
      Add( '                      PRO_CODTOC) ');
      Add( '               VALUES(:AUTINC,    ');
      Add( '                      :NUMPRO,    ');
      Add( '                      :NUMDOC,    ');
      Add( '                      :SERIE_,    ');
      Add( '                      :CLIFOR,    ');
      Add( '                      :TIP_FC,    ');
      Add( '                      :INUTIL,    ');
      Add( '                      :OPCCAN,    ');
      Add( '                      :ESPSEL,    ');
      Add( '                      :CODMOT,    ');
      Add( '                      :HISTOR,    ');
      Add( '                      :OPECAD,    ');
      Add( '                      :DTACAD,    ');
      Add( '                      :CODOCO,    ');
      Add( '                      :CODEMP,    ');
      Add( '                      :CODTOC)    ');

      strNumPro := fAtualizaProCod('PROCRM', 'PRO_NUMPRO');

      ParamByName('AUTINC').AsString   := fRetAutoIncrem('PROCRM', VS_strCodEmp);
      ParamByName('NUMPRO').AsString   := strNumPro;
      ParamByName('NUMDOC').AsString   := strNumDocCanc;
      ParamByName('SERIE_').AsString   := strSerieCanc;
      ParamByName('CLIFOR').AsString   := strCliForCanc;
      ParamByName('TIP_FC').AsString   := strTip_Fc;
      ParamByName('INUTIL').AsString   := IfThen(blnInutilizacaoCanc, 'S', 'N');
      ParamByName('OPCCAN').AsInteger  := intOpcaoCanc;
      ParamByName('ESPSEL').AsString   := strEspSelCanc;
      ParamByName('CODMOT').AsString   := strMotDelCanc;
      ParamByName('HISTOR').AsString   := strHisComCanc;
      ParamByName('OPECAD').AsString   := strLoginUsuarioLogado;
      ParamByName('DTACAD').AsDateTime := fNow;
      ParamByName('CODOCO').AsString   := qryTabela.FieldByName('OCO_CODOCO').AsString;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODTOC').AsString   := qryTabela.FieldByName('OCO_CODTOC').AsString;

      Try
        ExecSQL;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'TfrmCadMovOcorrencias.pGravaDadosDocumentoACancelar');
        End;
      End;

      objOcoCrm := fAtualizaInformacoesCRM('',
                                           '',
                                           VS_strCodEmp,
                                           dbeCodCli.Text,
                                           '',
                                           '',
                                           strLoginUsuarioLogado,
                                           afcNenhum);

      objOcoCrm.strCodToc := qryTabela.FieldByName('OCO_CODTOC').AsString;
      objOcoCrm.strCodOco := qryTabela.FieldByName('OCO_CODOCO').AsString;
      objOcoCrm.strNomFrm := Self.Name;
      If FBlnPermiteDataRetroativa Then
      Begin
        objOcoCrm.strDtaInc := qryTabela.FieldByName('OCO_DTACON').AsDateTime;
        objOcoCrm.strHorInc := qryTabela.FieldByName('OCO_HORCON').AsDateTime;
      End
      Else
      Begin
        objOcoCrm.strDtaInc := VS_Date;
        objOcoCrm.strHorInc := fRetHoraServidor();
      End;
      objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
      objOcoCrm.strHorAge := objOcoCrm.strHorInc;
      objOcoCrm.strOpeHis := strLoginUsuarioLogado;
      objOcoCrm.strDtaCon := 0;
      objOcoCrm.strHorCon := 0;
      If (strEspSelCanc = 'PD') Then
        objOcoCrm.strCodToc := fCfgSis('PEDCAN', varString)
      Else
        objOcoCrm.strCodToc := fCfgSis('VENCAN', varString);
      objOcoCrm.strDescri := 'Protocolo de cancelamento Nº: '+ strNumPro +  '<<csq>>' +
                             'Documento: ' + strNumDocCanc + ' - ' + strEspSelCanc + '<<csq>>' +
                             IfThen(not fEmptyStr(strSerieCanc), 'Serie: ' + strSerieCanc + '<<csq>>', '') +
                             IfThen(strTip_Fc='C','Cliente: ', 'Fornecedor: ') + strCliForCanc + ' - ' + IfThen(strTip_Fc='C', fRetNomCliente(strCliForCanc),
                                                                                                                               fRetNomFornecedor(strCliForCanc)) + '<<csq>>' +
                             'Inutilizar Documento: ' + IfThen(blnInutilizacaoCanc, 'Sim', 'Não') + '<<csq>>' +
                             'Ocorrência: ' + strMotDelCanc + ' - ' + fRetDescOcorrencia(strMotDelCanc) + '<<csq>>' +
                             'Histórico: ' + strHisComCanc +
                             '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                              DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

      objOcoCrm.pInsereHistoricoOcorrencia;
      objOcoCrm.pAtualizaOcorrencia;
      FreeAndNil(objOcoCrm);

      lblProtocoloCancelamento.Caption := strNumPro;
      pnlProtocoloCancelamento.Visible := True;
      pnlCabInf.Height := pnlCabInf.Height + pnlProtocoloCancelamento.Height;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
End;

procedure TfrmCadMovOcorrencias.pHabilitaBotoesAgregados;
begin
  If (qryTabela.FieldByName('OCO_DTACON').AsDateTime = 0) And
    (qryTabela.FieldByName('OCO_HORCON').AsDateTime = 0) Then
  Begin
    btnArquivos.Enabled   := True;
    btnEnviarEmail.Enabled := True;
    btnHistorico.Enabled  := fVerificaAcessoSistema('FLUCRM') Or (qryTabela.FieldByName('OCO_CODOPE').AsString = strLoginUsuarioLogado);
    btnConsultaAD.Visible := False;

    btnFinalizar.Glyph.Assign(nil);
    btnFinalizar.Enabled := fVerificaAcessoSistema('BAICRM') Or (qryTabela.FieldByName('OCO_CODOPE').AsString = strLoginUsuarioLogado);
    btnFinalizar.Hint    := 'Finalizar essa ocorrência.';
    btnFinalizar.Tag     := 0;
    btnFinalizar.Caption := 'Finalizar';
    imgButton.GetBitmap(0, btnFinalizar.Glyph);
  End
  Else
  Begin
    // significa que a ocorrencia ja foi finalizada
    btnArquivos.Enabled  := True;
    btnEnviarEmail.Enabled := True;
    btnHistorico.Enabled := False;
    btnFinalizar.Glyph.Assign(nil);
    btnFinalizar.Enabled := fVerificaAcessoSistema('OPNCRM');
    btnFinalizar.Hint := 'Reabrir essa ocorrência.';
    btnFinalizar.Tag := 1;
    btnFinalizar.Caption := 'Reabrir';
    imgButton.GetBitmap(1, btnFinalizar.Glyph);
  End;

  If fOcorrenciaDevolucao(qryCadToc.FieldByName('TOC_CODTOC').AsString, FTip_Fc) Then
  Begin
    btnConsultaAD.Visible:= True;
    btnGravarEfinalizar.Enabled := False;
  End
  Else
  Begin
    btnConsultaAD.Visible:= False;
    btnGravarEfinalizar.Enabled := btnGravar.Enabled;
  End;

end;

procedure TfrmCadMovOcorrencias.pHabilitarEnvioEmail;
begin
  blnEnvEmailDefault := qryCadToc.FieldByName('TOC_ENVEMA').AsString = 'S';

  chkEnvEmail.Checked        := blnEnvEmailDefault;
  chkEnvEmailDestino.Checked := qryCadToc.FieldByName('TOC_EMADES').AsString = 'S';
end;

procedure TfrmCadMovOcorrencias.pHabilitarGerarCompromisso;
begin
  chkGerCom.Checked := qryCadToc.FieldByName('TOC_GERCOM').AsString = 'S';
end;

procedure TfrmCadMovOcorrencias.pConsultaNovoHistoricoOcorrecia;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add(' SELECT SQL_NO_CACHE * ');
  qryTabela.SQL.Add(' FROM MOVOCO ');
  qryTabela.SQL.Add(' WHERE OCO_CODOCO = :CODOCO ');
  qryTabela.SQL.Add('   AND OCO_CODEMP = :CODEMP ');
  If Not fEmptyStr(FCodCli) Then
    qryTabela.SQL.Add(' AND OCO_CODCLI = :CODCLI ');

  qryTabela.ParamByName('CODOCO').AsString := FCodOco;
  qryTabela.ParamByName('CODEMP').AsString := IIF(fEmptyStr(FCodEmp),VS_strCodEmp,FCodEmp);
  If Not fEmptyStr(FCodCli) Then
    qryTabela.ParamByName('CODCLI').AsString := FCodCli;

  qryTabela.Open;

end;

procedure TfrmCadMovOcorrencias.pInicializaIndices;
begin
  inherited;
  qryCadGoc := fCriarQuery('SELECT * FROM CADGOC WHERE FALSE', Self);
  qryCadOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryCadToc := fCriarQuery('SELECT * FROM CADTOC WHERE FALSE', Self);
  qryCadCoc := fCriarQuery('SELECT * FROM CADCOC WHERE FALSE', Self);
end;

procedure TfrmCadMovOcorrencias.pInserirCamposAuditoria;
begin
  qryTabela.FieldByName('OCO_USUINA').AsString   := strLoginUsuarioLogado;
  qryTabela.FieldByName('OCO_DTAINA').AsDateTime := VS_Date;
  qryTabela.FieldByName('OCO_HORINA').AsDateTime := fTime();
end;

procedure TfrmCadMovOcorrencias.pInserirHistorico(DataSet: TDataSet);
begin
  pInserirHistoricoNovaOcorrencia;
  pInserirNumeroProtocolo;
  pInserirCamposAuditoria;
end;

procedure TfrmCadMovOcorrencias.pInserirHistoricoNovaOcorrencia;
begin
  If blnOpeCadCli Then
  Begin
    qryTabela.FieldByName('OCO_OPEOCO').AsString := IIF(fEmptyStr(FOpeOco), strLoginUsuarioLogado, FOpeOco);
    qryTabela.FieldByName('OCO_CODOPE').AsString := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [qryTabela.FieldByName('OCO_CODCLI').AsString]);
    qryTabela.FieldByName('OCO_DESCRI').AsString := fGeraTextoHistorico(qryTabela.FieldByName('OCO_DTAINC').AsDateTime,
                                                                        qryTabela.FieldByName('OCO_HORINC').AsDateTime,
                                                                        fRetNomeOperador(qryTabela.FieldByName('OCO_CODOPE').AsString),
                                                                        qryTabela.FieldByName('OCO_DESCRI').AsString);
  End
  Else
  Begin
    qryTabela.FieldByName('OCO_DESCRI').AsString := fGeraTextoHistorico(qryTabela.FieldByName('OCO_DTAINC').AsDateTime,
                                                                        qryTabela.FieldByName('OCO_HORINC').AsDateTime,
                                                                        edtDesOpeOco.Text,
                                                                        qryTabela.FieldByName('OCO_DESCRI').AsString);

    qryTabela.FieldByName('OCO_OPEOCO').AsString := IIF(fEmptyStr(FOpeOco), strLoginUsuarioLogado, FOpeOco);
  End;
//  qryTabela.FieldByName('OCO_EMERGE').AsString := IIF(blnEmergencial,'S','N');

  If Not fEmptyStr(FCpfCli) Then
    qryTabela.FieldByName('OCO_C_P_F_').AsString := FCpfCli;

end;

procedure TfrmCadMovOcorrencias.pInserirNovaOcorrencia;
begin
  btnIncluirClick(Self);
  qryTabela.FieldByName('OCO_CODCLI').AsString := FCodCli;
  {O Campo abaixo é alimentado com a chave que vem do cadastro de LEAD}
  If strCodLad <> '' Then
  Begin
    qryTabela.FieldByName('OCO_SEQLAG').AsString:= strCodLad;
  End
  Else
  Begin
    qryTabela.FieldByName('OCO_SEQLAG').Value:= Null;
  End;

  //fValidaCampos(dbeCodCli,True);
  If Not fEmptyStr(FCliVen) Then //esse paramento vem da impressao de etiquetas do cliente.
  Begin
    dbeCodCli.Enabled := False;
  End;
  qryTabela.FieldByName('OCO_CODOPE').Clear;

  If FBlnPermiteDataRetroativa Then
  Begin
    qryTabela.FieldByName('OCO_DTAINC').AsDateTime := qryTabela.FieldByName('OCO_DTACON').AsDateTime;
    qryTabela.FieldByName('OCO_HORINC').AsDateTime := qryTabela.FieldByName('OCO_HORCON').AsDateTime;
  End
  Else
  Begin
    qryTabela.FieldByName('OCO_DTAINC').AsDateTime := VS_Date;
    qryTabela.FieldByName('OCO_HORINC').AsDateTime := fTime();
  End;

  If fEmptyStr(strDtaAge) Then
    qryTabela.FieldByName('OCO_DTAAGE').AsDateTime := qryTabela.FieldByName('OCO_DTAINC').AsDateTime
  Else
    qryTabela.FieldByName('OCO_DTAAGE').AsDateTime := StrToDateTime(strDtaAge);

  qryTabela.FieldByName('OCO_HORAGE').AsDateTime := qryTabela.FieldByName('OCO_HORINC').AsDateTime;
  qryTabela.FieldByName('OCO_EMERGE').AsString   := 'N'; //Default Nao
  qryTabela.FieldByName('OCO_TIP_FC').AsString   := FTip_Fc;

  pCarregaCliente;

  If Not fEmptyStr(FCliVen) Then
    pSetFocus(dbeCodGOc)
  Else
    pSetFocus(dbeCodCli);
end;

procedure TfrmCadMovOcorrencias.pInserirNumeroProtocolo;
begin
  If Not(dtsMovOco.State in [dsInsert]) Then
    Exit;

  qryTabela.FieldByName('OCO_PROTOC').AsString := FormatDateTime('yyyymmdd',qryTabela.FieldByName('OCO_DTAINC').AsDateTime) +
                                                  FormatDateTime('hhmmss',qryTabela.FieldByName('OCO_HORINC').AsDateTime)   +
                                                  qryTabela.FieldByName('OCO_CODOCO').AsString;
end;

procedure TfrmCadMovOcorrencias.pMensagemPadraoOcorrenciaCRM(strCodOco: string);
var
  strMensagemPadrao: string;
begin
  strMensagemPadrao := fBuscaMensagemPadraoOcorrenciaCRM(strCodOco);

  if (not fEmptyStr(dbmDescri.Text)) and (not fEmptyStr(strMensagemPadrao)) and (Trim(dbmDescri.Text) <> strMensagemPadrao) then
  begin
    if fMensagem('', 'Deseja sobrescrever a descrição da ocorrência?', ['&Sim', '&Não']) = 1 then
    begin
      dbmDescri.Text := strMensagemPadrao;
    end;
  end
  else if (fEmptyStr(dbmDescri.Text)) and (not fEmptyStr(strMensagemPadrao)) then
  begin
    dbmDescri.Text := strMensagemPadrao;
  end;
end;


function TfrmCadMovOcorrencias.fGetEmailPadrao : String;
Begin
  If FTip_Fc = 'P' Then
    Result := qryCadCli.FieldByName('PRO_EMAIL_').AsString
  Else
  If FTip_Fc = 'C' Then
    Result := IfThen(fOcorrenciaDevolucao(qryTabela.FieldByName('OCO_CODTOC').AsString, FTip_Fc),
                     qryCadCli.FieldByName('CLI_EMAIL3').AsString,
                     qryCadCli.FieldByName('CLI_EMAIL_').AsString)
  Else
    Result := qryCadCli.FieldByName('FOR_EMAIL_').AsString;

End;

function TfrmCadMovOcorrencias.fRetPathEspelhoAd : String;
begin
  FNumDev := fCampoTabela('GER_CODADE', 'ADEGER', ['GER_CODOCO', 'GER_CODEMP'],
                                                  [qryTabela.FieldByName('OCO_CODOCO').AsString,
                                                   qryTabela.FieldByName('OCO_CODEMP').AsString]);

  Result  := ExtractFilePath(Application.ExeName)+ 'Arquivos_crm\' + qryTabela.FieldByName('OCO_CODOCO').AsString;
  Result  := Result + '\Espelho_AD_' + FNumDev + '.pdf';
end;

function TfrmCadMovOcorrencias.fValidaPathEspelhoAd : Boolean;
begin
  Result := FileExists(fRetPathEspelhoAd);

  If Result Then
    FArqDev := fRetPathEspelhoAd;
end;

function TfrmCadMovOcorrencias.fVerificaPodeAlterarOcorrencia: Boolean;
begin
  If Not fVerificaAcessoSistema('OCOALT') Then
    Exit(False) ;

  If qryTabela.FieldByName('OCO_DTACON').AsDateTime > 0 Then
    Exit(False);

  If (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENCAN', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('PEDCAN', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('TOCCNF', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('OCODMP', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('OCOFIN', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('OCOSEP', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('TOCLCR', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('TOC_TR', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENDEV', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENORC', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENPED', varString)) Or
     (qryTabela.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENVN_', varString)) Then
  Begin
    Exit(False);
  End;

  Result := True;
end;

procedure TfrmCadMovOcorrencias.pPreencheInfosEmaSai(var arrCorpo: TStringArray; var strAssunto: String);
var
  objEmaSai: TEmaAut;
begin
  objEmaSai := TEmaAut.Create(Nil);

  Try
    objEmaSai.FCodigo := '001';
    objEmaSai.FCodGru := '028';
    objEmaSai.FNumeOS := '';
    objEmaSai.FNomCli := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
    objEmaSai.FPriCli := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
    objEmaSai.FCidCli := fRetNomCidade(qryCadCli.FieldByName('CLI_CODCID').AsString, 0);
    objEmaSai.FGruOco := edtDesCodGoc.Text;
    objEmaSai.FDtaOco := dbeDtaInc.Text +' - '+ dbeHorInc.Text;
    objEmaSai.FDtaCoc := dbeDtaCon.Text +' - '+ dbeHorCon.Text;;
    objEmaSai.FTipOco := dbeTipOco.Text;
    objEmaSai.FComOco := dbeComple.Text;
    objEmaSai.FOpeori := fRetNomeOperador(strLoginUsuarioLogado);
    objEmaSai.FComDes := dbeDesComple.Text;
    objEmaSai.FLeadDoc:= strNumLead;
    objEmaSai.FHisOco := dbmDescri.Text + FInfDev;
    objEmaSai.FProOco := qryTabela.FieldByName('OCO_PROTOC').AsString;
    objEmaSai.FCodCli := strCodCli;
    objEmaSai.FUsuDes := dbeOpeOco.Text +' - '+ fRetNomeOperador(dbeOpeOco.Text);

    arrCorpo := objEmaSai.fGetCorpoMensagem;
    strAssunto := objEmaSai.FAssunt;
  Finally
    FreeAndNil(objEmaSai);
  End;
end;


function TfrmCadMovOcorrencias.fRetCorpoEmailPadrao(blnDevolucao: Boolean) : TStringArray;
begin
  Result := TEnvioEmail.ContruirArrayMensagem(fFormataTextoMovOcorrencias(dbeCodCli.Text,
                                                          edtDesCodCli.Text,
                                                          dbeCodGOc.Text,
                                                          edtDesCodGoc.Text,
                                                          dbeDtaInc.Text,
                                                          dbeHorInc.Text,
                                                          '',
                                                          '',
                                                          dbeTipOco.Text,
                                                          edtDesTipOco.Text,
                                                          dbeOpeOco.Text,
                                                          edtDesOpeOco.Text,
                                                          dbmDescri.Text + FInfDev,
                                                          dbeComple.Text,
                                                          dbeDesComple.Text,
                                                          FTip_Fc,
                                                          qryTabela.FieldByName('OCO_PROTOC').AsString,
                                                          blnDevolucao,
                                                          '',
                                                          '',
                                                          '',
                                                          strNumLead));
end;

procedure TfrmCadMovOcorrencias.pPerguntaAnteDeEnviar;
Var
  blnDevolucao : Boolean;
  Anexos: TStringArray;
  arrCorpoEmail: TStringArray;
  strAssuntoEmail: String;
begin
  arrCorpoEmail := [];
  blnDevolucao := fOcorrenciaDevolucao(qryTabela.FieldByName('OCO_CODTOC').AsString, FTip_Fc);
  If blnDevolucao Then
  Begin
    If fValidaPathEspelhoAd Then
      pAddDados(Anexos, FArqDev);

    pPreencheInfosEmaSai(arrCorpoEmail, strAssuntoEmail);
  End;

  If (Length(arrCorpoEmail) = 0)
  Or (fEmptyStr(arrCorpoEmail[0]))
  Or (arrCorpoEmail[0].Trim = '<P>&nbsp;</P>') Then
  Begin
    strAssuntoEmail := IIF(blnDevolucao, 'RETORNO OCORRÊNCIA DAC', 'Nova ocorrência CRM '+ ', Tipo da ocorrência: '+dbeTipOco.Text+' - '+edtDesTipOco.Text+
                           IIF(FTip_Fc='C',', Cliente: ',IIF(FTip_Fc='P',', Cliente Prospecto: ', ', Fornecedor: '))+ dbeCodCli.Text+' - '+edtDesCodCli.Text);

    arrCorpoEmail := fRetCorpoEmailPadrao(blnDevolucao);
  End;

  TEnvioEmail.EnviarEmail(Self,
                          strLoginUsuarioLogado,
                          strAssuntoEmail,
                          fRetornaParaMovOcorrencias(IfThen(chkEnvEmail.Checked, edtEmail.Text,''),
                                                     IfThen(chkEnvEmailDestino.Checked, edtEmailDestino.Text,'')),
                          [],
                          [],
                          arrCorpoEmail,
                          Anexos,
                          true,False, '','', 0,False,
                          '','','','',0,0,0,'',
                          '',0,False,'',Nil,'',
                          '',False,False,'S','N', '','',
                          False, True, True, Nil, False, False, qryTabela.FieldByName('OCO_CODOCO').AsString);
end;

procedure TfrmCadMovOcorrencias.pProcessaLogAlteracaoClienteOcorrencia;
  var
    LDescricao: string;
begin
  If FOperac <> 'Alterar' Then
    Exit;

  If FCodCli =  qryTabela.FieldByName('OCO_CODCLI').AsString Then
    Exit;

  If FTip_Fc = 'F' Then
    LDescricao := 'Fornecedor'
  Else If FTip_Fc = 'C' Then
    LDescricao := 'Cliente' Else
  If FTip_Fc = 'P' Then
    LDescricao := 'Prospecto';

  TLogAltMovOco.fNew()
               .strCodOco(qryTabela.FieldByName('OCO_CODOCO').AsString)
               .strCliAnt(FCodCli)
               .strCodCli(qryTabela.FieldByName('OCO_CODCLI').AsString)
               .strDescri('Alteração de ' + LDescricao + ' pela operação: botão "Alterar" em tela')
               .strNomFrm('frmCadMovOcorrencias')
               .pGravarLogAlteracaoCliente;
end;

procedure TfrmCadMovOcorrencias.pProcessarRecorrencias;
var
  objProcessar: TProcessarRecorrencia;
begin
  If Not Assigned(objAtuOcoCrm) Then
    Exit;

  If Not Assigned(objRecorrencia) Then
    Exit;

  objProcessar := TProcessarRecorrencia.Create;
  Try
    If objRecorrencia.Status = tpTodas Then
    Begin
      objProcessar.pProcessarRecorrencias(tpTotal, objRecorrencia.AutInc);
    End;

    If Not fEmptyStr(objProcessar.strMensagemRetorno) Then
    Begin
      fMensagem('ATENÇÃO!', objProcessar.strMensagemRetorno, ['&Ok']);
    End;

  Finally
    FreeAndNil(objProcessar);
  End;
end;

procedure TfrmCadMovOcorrencias.setCliVen(const Value: String);
begin
  If (FCliVen <> Value) Then
    FCliVen := Value;
end;

procedure TfrmCadMovOcorrencias.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
  Begin
    FCodCli := Value;
  End;
end;

procedure TfrmCadMovOcorrencias.setCodEmp(const Value: String);
begin
  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TfrmCadMovOcorrencias.setCodOco(const Value: String);
begin
  If (FCodOco <> Value) Then
    FCodOco := Value;
end;

procedure TfrmCadMovOcorrencias.setCpfCli(const Value: String);
begin
  If (FCpfCli <> Value) Then
    FCpfCli := Value;
end;

{
procedure TfrmCadMovOcorrencias.setConDev(const Value: Boolean);
begin
  If (FConDev <> Value) Then
    FConDev := Value;
end;
}
procedure TfrmCadMovOcorrencias.setOpeOco(const Value: String);
begin
  If (FOpeOco <> Value) Then
    FOpeOco := Value;
end;

procedure TfrmCadMovOcorrencias.setOperac(const Value: String);
begin
  If (FOperac <> Value) Then
    FOperac := Value;
end;

procedure TfrmCadMovOcorrencias.setTip_Fc(const Value: String);
begin
  If (FTip_Fc <> Value) Then
    FTip_Fc := Value;
end;

procedure TfrmCadMovOcorrencias.setCodLad(const Value: String);
begin
  If (FCodLad <> Value) Then
    FCodLad := Value;
end;


procedure TfrmCadMovOcorrencias.pCarregaHistorioOcorrencia;
Begin
  cdsHisOco.qryQuery.SQL.Clear;
  cdsHisOco.qryQuery.SQL.Add(fRetornaSQLHistoricoOcorrencias);
  cdsHisOco.qryQuery.ParamByName('CODOCO').AsString := strCodOco;
  cdsHisOco.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
  cdsHisOco.qryQuery.ParamByName('CODCLI').AsString := strCodCli;
  cdsHisOco.fAbreClient(True, 'TfrmCadMovOcorrencias.pCarregaHistorioOcorrencia');
  cxTableViewHisOco.DataController.DataSource := cdsHisOco.dtsSource;

  cxTableViewHisOco.BeginUpdate;
  HisOcoColumnDESCRI.Visible := False;
  Try
    cxTableViewHisOco.ApplyBestFit();
  Finally
    HisOcoColumnDESCRI.Width := 32;
    HisOcoColumnDESCRI.Visible := True;
    cxTableViewHisOco.EndUpdate;
  End;
End;

procedure TfrmCadMovOcorrencias.chkEmailEnvioPropertiesChange(Sender: TObject);
begin
  inherited;

  If chkEmailEnvio.Text <> chkEmailEnvio.Properties.EmptySelectionText Then
    edtEmail.Text := chkEmailEnvio.Text
  Else
    edtEmail.Text := fGetEmailPadrao;
end;

procedure TfrmCadMovOcorrencias.chkEnvEmailClick(Sender: TObject);
begin
  inherited;
  If chkEnvEmail.Checked <> blnEnvEmailDefault Then
  Begin
    If Not fVerificaAcessoSistema('CRMALTOCOEMA') Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce := 'CRMALTOCOEMA';
      objLiberacao.strMsgSen := 'CRM: Permitir alterar o checkbox "'+ chkEnvEmail.Caption +'"';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('CRM: '+ IIF(Not chkEnvEmail.Checked, 'Não ', '') + chkEnvEmail.Caption);

      If Not objLiberacao.fLibera Then
      Begin
        chkEnvEmail.Checked := blnEnvEmailDefault;
        Exit;
      End;
    End;
  End;

  edtEmail.Enabled := chkEnvEmail.Checked;
  blnEnvEmailDefault := chkEnvEmail.Checked;
end;

procedure TfrmCadMovOcorrencias.btnCopiarProtocoloCancelamentoClick(
  Sender: TObject);
begin
  inherited;
  if not fEmptyStr(lblProtocoloCancelamento.Caption) then
  begin
    Clipboard.AsText := lblProtocoloCancelamento.Caption;
    pnlInfo.Caption := 'Protocolo de cancelamento copiado com sucesso !'
  end;
end;

procedure TfrmCadMovOcorrencias.btnCopiarProtocoloClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(dblProtocolo.Caption) then
  begin
    Clipboard.AsText := dblProtocolo.Caption;
    pnlInfo.Caption := 'Protocolo copiado com sucesso !'
  end;
end;

procedure TfrmCadMovOcorrencias.cxTableViewHisOcoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    APainter: TcxPainterAccess;
begin
  inherited;
  If AViewInfo.Item.Index <> HisOcoColumnDESCRI.Index Then
    Exit;

  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
  With APainter Do
  Begin
    Try
      DrawBorders;
      With AViewInfo.ClientBounds Do
      Begin
        imgButton.Draw(ACanvas.Canvas, Left + ((Width - 16) div 2), Top + ((Height - 16) div 2), 1 );
      End;
    Finally
      Free;
    End;

  End;

  ADone := True;
end;

procedure TfrmCadMovOcorrencias.cxTableViewHisOcoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
  Begin
    Try
      cxHint.HideHint;
      intLastRec := -1;
      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.lblMensagem.caption := 'Histórico:';
      frmObservacao.Width := 1024;
      frmObservacao.Height:= 600;
      frmObservacao.BorderIcons := [biSystemMenu, biMinimize, biMaximize];
      frmObservacao.memObs.Font.Name := 'Courier New';
      frmObservacao.memObs.Texto := cdsHisOco.FieldByName('DESCRI').AsString;
      frmObservacao.ShowModal;
    Finally
      FreeAndNil(frmObservacao);
    End;
  End;
end;

procedure TfrmCadMovOcorrencias.cxTableViewHisOcoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
//  Item: TcxCustomGridTableItem;
  Rec: TcxCustomGridRecord;
  strDoc: String;
begin
  inherited;

  If not Assigned(popOcorrencias) Then
    Exit;

  If Button = mbRight Then
  Begin
    Site    := Sender as TcxGridSite;
    HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

    If HitTest Is TcxGridRecordCellHitTest Then
    Begin
//      Item := TcxGridRecordCellHitTest(HitTest).Item;
      Rec  := TcxGridRecordCellHitTest(HitTest).GridRecord;

      strDoc := VarToStr(rec.Values[HisOcoColumnNUMDOC.Index]);

      If (Pos('PD', strDoc) > 0) Or (Pos('OR', strDoc) > 0) Then
      Begin
        cxHint.HideHint;
        intLastRec := -1;
        popOcorrencias.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      End;
    End;
  End;
end;

procedure TfrmCadMovOcorrencias.cxTableViewHisOcoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Inherited;
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

  if HitTest is TcxGridRecordCellHitTest then
  begin

    If (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex >= 0) And
       (HisOcoColumnDESCRI.Index = TcxGridRecordCellHitTest(HitTest).Item.Index) And
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intLastRec) Then
    Begin
      intLastRec := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
      cxHint.ShowHint(Mouse.CursorPos.X + 3, Mouse.CursorPos.Y + 3,'',
                      ReplaceStr(VarToStr(Site.GridView.DataController.Values[intLastRec, HisOcoColumnDESCRI.Index]), '<<csq>>', #13 ));
    End;

    If (HisOcoColumnDESCRI.Index <> TcxGridRecordCellHitTest(HitTest).Item.Index) Or
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intLastRec) Then
    Begin
      cxHint.HideHint;
      intLastRec := -1;
    End;
  end
  Else
  Begin
    cxHint.HideHint;
    intLastRec := -1;
  End;
end;

procedure TfrmCadMovOcorrencias.chkEnvEmailDestinoClick(Sender: TObject);
begin
  inherited;

  edtEmailDestino.Enabled := chkEnvEmailDestino.Checked;

end;

procedure TfrmCadMovOcorrencias.chkTornarRecorrenteClick(Sender: TObject);
begin
  If chkTornarRecorrente.Checked Then
  Begin
    If Not fVerificaAcessoSistema('OCOREC') Then
    Begin
      fMensagem('Atenção', 'Operador não possui acesso liberado para tornar a ocorrência recorrente!', ['&OK']);
      chkTornarRecorrente.Checked := False;
      Exit;
    End;

    If ChkEmerge.Checked Then
    Begin
      fMensagem('Atenção', 'Funcionalidade não está disponível ao "Gerar Ocorrência Emergencial"!', ['&OK']);
      chkTornarRecorrente.Checked := False;
      Exit;
    End;
  End;

  inherited;

  If chkTornarRecorrente.Checked Then
  Begin
    pAbrirTelaRecorrencia;
  End
  Else
    ObjRecorrencia.pLimpar;

end;

procedure TfrmCadMovOcorrencias.btnAlterarClick(Sender: TObject);
begin
  inherited;

  dbeCodCli.Enabled := fVerificaPodeAlterarOcorrencia;
end;

procedure TfrmCadMovOcorrencias.btnAlterarCliClick(Sender: TObject);
begin
  inherited;

  dbeCodCli.Enabled := fVerificaPodeAlterarOcorrencia;
  btnGravar.Enabled := dbeCodCli.Enabled;

  If dbeCodCli.Enabled Then
  Begin
    dtsMovOco.DataSet.Edit;
    dbeCodCli.SetFocus;
  End;
end;

procedure TfrmCadMovOcorrencias.btnAltSituacaoClick(Sender: TObject);
begin
  inherited;
  If fAlteraSituacaoOcorrencia(Self,
                               qryTabela.FieldByName('OCO_CODTOC').AsString,
                               qryTabela.FieldByName('OCO_CODOCO').AsString,
                               qryTabela.FieldByName('OCO_CODCLI').AsString,
                               qryTabela.FieldByName('OCO_CODOPE').AsString,
                               qryTabela.FieldByName('OCO_CODEMP').AsString,
                               qryTabela.FieldByName('OCO_CODCOC').AsString,
                               qryTabela.FieldByName('OCO_DTAAGE').AsString,
                               qryTabela.FieldByName('OCO_HORAGE').AsString) Then
    pCarregaHistorioOcorrencia;
end;


end.
