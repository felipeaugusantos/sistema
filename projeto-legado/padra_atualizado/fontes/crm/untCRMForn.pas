unit untCRMForn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, Uni, cxStyles, cxGraphics, cxEdit,
  cxButtonEdit, cxDropDownEdit, cxVGrid, cxDBVGrid, cxControls, Datasnap.DBClient,
  cxInplaceContainer, DB, UniClientDataSet, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxImage,
  DateUtils, UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxGridCitel, cxDataControllerConditionalFormattingRulesManagerDialog,untFuncoesRel,
  Vcl.Samples.Spin;

type
  TfrmCRMForn = class(TfrmPaiSimples)
    pnlDados: TPanel;
    pnlConsulta: TPanel;
    pnlRodape: TPanel;
    pnlEsquerda: TPanel;
    pnlDireita: TPanel;
    pnlCliente: TPanel;
    grbCliente: TGroupBox;
    splMeio: TSplitter;
    pnlContato: TPanel;
    splCliCon: TSplitter;
    grbContatos: TGroupBox;
    pnlGrupoOcor: TPanel;
    splGruOcor: TSplitter;
    pnlOcorrencias: TPanel;
    grbGrupoOcor: TGroupBox;
    grbOcorrencias: TGroupBox;
    pnlGridCliente: TPanel;
    pnfInfCliente: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    dbgFornecedores: TcxDBVerticalGrid;
    dtsFornecedores: TDataSource;
    cdsFornecedores: TUniClientDataSet;
    dbgFornecedoresFOR_C_G_C_: TcxDBEditorRow;
    dbgFornecedoresFOR_CAIPOS: TcxDBEditorRow;
    dbgFornecedoresFOR_I_E_S_: TcxDBEditorRow;
    dbgFornecedoresFOR_CONCON: TcxDBEditorRow;
    dbgFornecedoresFOR_SIMPAU: TcxDBEditorRow;
    dbgFornecedoresFOR_PERFCX: TcxDBEditorRow;
    dbgFornecedoresFOR_MATREV: TcxDBEditorRow;
    dbgFornecedoresFOR_CENTCD: TcxDBEditorRow;
    dbgFornecedoresFOR_CNDPAG: TcxDBEditorRow;
    dbgFornecedoresFOR_EMAPED: TcxDBEditorRow;
    dbgFornecedoresFOR_CENTCC: TcxDBEditorRow;
    dbgFornecedoresFOR_VLRED2: TcxDBEditorRow;
    dbgFornecedoresFOR_CARPAG: TcxDBEditorRow;
    dbgFornecedoresFOR_DESVIS: TcxDBEditorRow;
    dbgFornecedoresFOR_NOMFOR: TcxDBEditorRow;
    dbgFornecedoresFOR_NOMFAN: TcxDBEditorRow;
    dbgFornecedoresFOR_NOMCID: TcxDBEditorRow;
    dbgFornecedoresFOR_DESATI: TcxDBEditorRow;
    dbgFornecedoresFOR_NOMTRA: TcxDBEditorRow;
    dbgFornecedoresFOR_NOMOPE: TcxDBEditorRow;
    dbgFornecedoresFOR_FONE01: TcxDBEditorRow;
    dbgFornecedoresFOR_FONE02: TcxDBEditorRow;
    dbgFornecedoresFOR_F_A_X_: TcxDBEditorRow;
    dbgFornecedoresFOR_0800__: TcxDBEditorRow;
    dbgFornecedoresFOR_ENDERE: TcxDBEditorRow;
    dbgFornecedoresFOR_ENDCOM: TcxDBEditorRow;
    dbgFornecedoresFOR_C_E_P_: TcxDBEditorRow;
    dbgFornecedoresFOR_BAIRRO: TcxDBEditorRow;
    dbgFornecedoresFOR_ENDNUM: TcxDBEditorRow;
    dbgFornecedoresFOR_NUMCEL: TcxDBEditorRow;
    dbgFornecedoresFOR_CONTAT: TcxDBEditorRow;
    dbgFornecedoresFOR_EMAIL_: TcxDBEditorRow;
    dbgFornecedoresFOR_EMAIL2: TcxDBEditorRow;
    dbgFornecedoresFOR_HOMEPA: TcxDBEditorRow;
    dbgFornecedoresFOR_NUMRG_: TcxDBEditorRow;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus6: TDBEditFocus;
    dtsContatos: TDataSource;
    cdsContatos: TUniClientDataSet;
    dbgContatosDBTableView1: TcxGridDBTableViewCitel;
    dbgContatosLevel1: TcxGridLevel;
    dbgContatos: TcxGridCitel;
    dbgContatosDBTableView1FOR_NOMCTT: TcxGridDBColumn;
    dbgContatosDBTableView1FOR_TELCTT: TcxGridDBColumn;
    dbgContatosDBTableView1FOR_CELCTT: TcxGridDBColumn;
    dbgContatosDBTableView1FOR_FAXCTT: TcxGridDBColumn;
    dbgContatosDBTableView1FOR_DEPCTT: TcxGridDBColumn;
    dbgGrupoOcorrDBTableView1: TcxGridDBTableViewCitel;
    dbgGrupoOcorrLevel1: TcxGridLevel;
    dbgGrupoOcorr: TcxGridCitel;
    dtsGrupoOcorr: TDataSource;
    cdsGrupoOcorr: TUniClientDataSet;
    cdsGrupoOcorrGOC_CODGOC: TStringField;
    cdsGrupoOcorrGOC_DESGOC: TStringField;
    cdsGrupoOcorrGOC_CODEMP: TStringField;
    cdsGrupoOcorrAUTOINCREM: TStringField;
    dbgGrupoOcorrDBTableView1GOC_DESGOC: TcxGridDBColumn;
    dbgGrupoOcorrDBTableView1IMAGEM: TcxGridDBColumn;
    cdsGrupoOcorrIMAGEM: TBlobField;
    dtsMovOcorr: TDataSource;
    cdsMovOcorr: TUniClientDataSet;
    dbgMovOcorrDBTableView1: TcxGridDBTableViewCitel;
    dbgMovOcorrLevel1: TcxGridLevel;
    dbgMovOcorr: TcxGridCitel;
    cdsMovOcorrOCO_CODOCO: TStringField;
    cdsMovOcorrOCO_CODTOC: TStringField;
    cdsMovOcorrOCO_CODCLI: TStringField;
    cdsMovOcorrOCO_DTAINC: TDateField;
    cdsMovOcorrOCO_HORINC: TTimeField;
    cdsMovOcorrOCO_DTACON: TDateField;
    cdsMovOcorrOCO_HORCON: TTimeField;
    cdsMovOcorrOCO_CODOPE: TStringField;
    cdsMovOcorrOCO_DESCRI: TMemoField;
    cdsMovOcorrOCO_CODEMP: TStringField;
    cdsMovOcorrAUTOINCREM: TStringField;
    cdsMovOcorrCLI_NOMCLI: TStringField;
    cdsMovOcorrTOC_DESTOC: TStringField;
    cdsMovOcorrOPE_NOMOPE: TStringField;
    cdsMovOcorrIMAGEM1: TBlobField;
    dbgMovOcorrDBTableView1OCO_DTAINC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_DTACON: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_HORCON: TcxGridDBColumn;
    dbgMovOcorrDBTableView1TOC_DESTOC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OPE_NOMOPE: TcxGridDBColumn;
    dbgContatosDBTableView1FOR_BAICTT: TcxGridDBColumn;
    dbgContatosDBTableView1FOR_ENDCTT: TcxGridDBColumn;
    dbgMovOcorrDBTableView1IMAGEM1: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_DTALIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_TMPLIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_METLIM: TcxGridDBColumn;
    cdsMovOcorrOCO_DTALIM: TDateTimeField;
    cdsMovOcorrOCO_TMPLIM: TFloatField;
    cdsMovOcorrOCO_METLIM: TFloatField;
    popOrcamento: TPopupMenu;
    popPedido: TPopupMenu;
    mnuFatOrcamento: TMenuItem;
    mnuFatPedido: TMenuItem;
    cdsMovOcorrHOREXC: TIntegerField;
    dbgMovOcorrDBTableView1HOREXC: TcxGridDBColumn;
    pnlBotoesCadCli: TPanel;
    cdsMovOcorrOCO_EMERGE: TStringField;
    dbgMovOcorrDBTableView1OCO_EMERGE: TcxGridDBColumn;
    Label9: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape1: TShape;
    Label8: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cdsFornecedoresFOR_STATUS: TStringField;
    cdsFornecedoresFOR_NOMFOR: TStringField;
    cdsFornecedoresFOR_NOMFAN: TStringField;
    cdsFornecedoresFOR_C_E_P_: TStringField;
    cdsFornecedoresFOR_ENDERE: TStringField;
    cdsFornecedoresFOR_ENDNUM: TStringField;
    cdsFornecedoresFOR_ENDCOM: TStringField;
    cdsFornecedoresFOR_BAIRRO: TStringField;
    cdsFornecedoresFOR_CGCCPF: TStringField;
    cdsFornecedoresFOR_C_G_C_: TStringField;
    cdsFornecedoresFOR_CAIPOS: TStringField;
    cdsFornecedoresFOR_I_E_S_: TStringField;
    cdsFornecedoresFOR_NUMRG_: TStringField;
    cdsFornecedoresFOR_FONE01: TStringField;
    cdsFornecedoresFOR_FONE02: TStringField;
    cdsFornecedoresFOR_F_A_X_: TStringField;
    cdsFornecedoresFOR_NUMCEL: TStringField;
    cdsFornecedoresFOR_0800__: TStringField;
    cdsFornecedoresFOR_CONTAT: TStringField;
    cdsFornecedoresFOR_PERCOM: TFloatField;
    cdsFornecedoresFOR_HOMEPA: TStringField;
    cdsFornecedoresFOR_EMAIL_: TStringField;
    cdsFornecedoresFOR_EMAIL2: TStringField;
    cdsFornecedoresFOR_CONCON: TStringField;
    cdsFornecedoresFOR_CODATI: TStringField;
    cdsFornecedoresFOR_SIMPAU: TStringField;
    cdsFornecedoresFOR_PERFCX: TFloatField;
    cdsFornecedoresFOR_MATREV: TStringField;
    cdsFornecedoresFOR_CODOPE: TStringField;
    cdsFornecedoresFOR_CODCID: TStringField;
    cdsFornecedoresFOR_CTATRA: TStringField;
    cdsFornecedoresFOR_CNDPAG: TStringField;
    cdsFornecedoresFOR_CODTRA: TStringField;
    cdsFornecedoresFOR_EMAPED: TStringField;
    cdsFornecedoresFOR_CODCTA: TStringField;
    cdsFornecedoresFOR_VLRED2: TStringField;
    cdsFornecedoresFOR_CARPAG: TIntegerField;
    cdsFornecedoresFOR_DESVIS: TFloatField;
    cdsFornecedoresFOR_NOMCID: TStringField;
    cdsFornecedoresFOR_NOMOPE: TStringField;
    cdsFornecedoresFOR_DESATI: TStringField;
    cdsFornecedoresFOR_CENTCD: TStringField;
    cdsFornecedoresFOR_CENTCC: TStringField;
    cdsFornecedoresFOR_NOMTRA: TStringField;
    cdsFornecedoresFOR_CODFOR: TStringField;
    cdsContatosFOR_CODFOR: TStringField;
    cdsContatosFOR_NOMCTT: TStringField;
    cdsContatosFOR_ENDCTT: TStringField;
    cdsContatosFOR_BAICTT: TStringField;
    cdsContatosFOR_CIDCTT: TStringField;
    cdsContatosFOR_TELCTT: TStringField;
    cdsContatosFOR_EMACTT: TStringField;
    cdsContatosFOR_CODEMP: TStringField;
    cdsContatosFOR_CELCTT: TStringField;
    cdsContatosFOR_FAXCTT: TStringField;
    cdsContatosFOR_DEPCTT: TStringField;
    cdsContatosFOR_CMPCTT: TStringField;
    cdsContatosFOR_NOMCID: TStringField;
    dbgContatosDBTableView1FOR_NOMCID: TcxGridDBColumn;
    cdsMovOcorrOCO_TIP_FC: TStringField;
    BitBtn1: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxZebra: TcxStyle;
    GroupBox1: TGroupBox;
    edtDesCodFor: TEditFocus;
    edtCodFor: TEditFocus;
    pnlBotoesAcesso: TPanel;
    btnNovaOcorrencia: TBitBtnLocked;
    btnLocalizarOcorr: TBitBtnLocked;
    btnRelOcorrenciasCRM: TBitBtnLocked;
    mnuCadMsg: TBitBtnLocked;
    cdsMovOcorrOCO_PROTOC: TStringField;
    btnPesquisarMenus: TBitBtnLocked;
    dbgGrupoOcorrDBTableView1GOC_NUMTOT: TcxGridDBColumn;
    cdsGrupoOcorrGOC_NUMTOT: TIntegerField;
    pnlDias: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    spnFiltroDias: TSpinEdit;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxDBVerticalGrid1CLI_FANSOBEditPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMCIDEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_C_E_P_EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_ENDEREEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_ENDNUMEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_BAIRROEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_C_G_C_EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NUMR_GEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_I_E_S_EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_I_M_P_EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NASCIMEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_CAIPOSEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_FONE01EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_RAMAL1EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_FONE02EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_RAMAL2EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_F_A_X_EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_RAMAL3EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_CELULAEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NEXTELEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_EMAIL_EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_CONTATEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_EMAIL2EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_EMAIL3EditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_CONSUMEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_HOMEPAEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMVENEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMREPEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMSGEEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMSREEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_DESATIEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_TABPREEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_LIMCREEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_DESFPGEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_DESTCLEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_DESPOREditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_DESCONEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_PERCOMEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_PEREMPEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_DESREGEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMDIVEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMREDEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMCACEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_ATRMAXEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_PERMFFEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMFXAEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgClientesCLI_NOMERCEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_NOMCTTPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_TELCTTPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_CELCTTPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_FAXCTTPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_DESDPTPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure cxGridDBTableView1ETC_ENDENTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1ETC_CEPENTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1ETC_BAIENTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1CID_NOMCIDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1ETC_TELENTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1ETC_CONENTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1ETC_REFENTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBTableView1TRA_NOMTRAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnNovaOcorrenciaClick(Sender: TObject);
    procedure dbgContatosDBTableView1CLI_DESCGOPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_DESTFUPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_DESHOBPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_DESECIPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_DESGMUPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgContatosDBTableView1CLI_DESESCPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cdsGrupoOcorrAfterScroll(DataSet: TDataSet);
    procedure dbgMovOcorrDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgMovOcorrDBTableView1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsFornecedoresAfterScroll(DataSet: TDataSet);
    procedure btnLocalizarOcorrClick(Sender: TObject);
    procedure dbgMovOcorrDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgContatosDBTableView1FOR_NOMCIDPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure btnRelOcorrenciasCRMClick(Sender: TObject);
    procedure mnuCadMsgClick(Sender: TObject);
    procedure btnPesquisarMenusClick(Sender: TObject);
    procedure spnFiltroDiasChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryCadFor: TUniQuery;
    strCodOco: String;
    FCodGoc: String;
    //usado para consulta emergencia
    blnEmergencial: Boolean;

    procedure pCarregaCadFor;
    procedure pCarregaInformacoesFornecedor;
    procedure pSetaParametrosBotaoCliente(strNomCampo, strModulo: String; strDesCampo: String = '');
    procedure pCarregaInformacoesContatos;
    procedure EnabledPanels;
    procedure DisablePanels;
    procedure pAdicionaMascarasCliente;
    procedure pCarregaInformacoesGrupoOcorrencias;
    procedure pIncluirNovaOcorrencia;
    procedure pFiltraOcorrencias(strCodGoc, strCodCli: String);
    procedure pFecharDataSets;
    procedure pCriarDataSets;
    procedure pClientVazio;
    procedure pCarregaOcorrenciaAlteracao;
    procedure pIncluirNovoHistoricoOcorrencia;
    procedure pLocalizaOcorrenciaSolicitada;
    procedure pLocalizaGruposOcorrenciaSolicitada;
    procedure pLimparDataSets;
    procedure pHabilitaBotoesPanelSuperiorCrm;
    procedure pDesabilitaBotoesPanelSuperiorCrm;
    procedure pChamaConsultaOcorrenciaCRM;
    procedure pCarregaOcorrenciaEmergencial(strCodCli, strCodOpe, strCodEmp: String);
    procedure pVerificaCamposVisiveisFornecedores;
    procedure pCamposVisiveisFornecedores(qrySel: TUniQuery);
    procedure pAbreCadastroFornecedor(Key: Word);

    function fConsultaFornecedor: Boolean;

  protected
    function getCodGoc: String;

    procedure setCodGoc(const Value: String);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property strCodGoc: String Read getCodGoc Write setCodGoc;
  end;

implementation

uses untCadFornecedores, untCadMovOcorrencias, untConsultaOcorrenciasCRM,
  untConsultaOcorrenciasCRMEmergenciais,untFuncoesGenerica, untFuncoesSimples,
  untConstantes, untPesqAux,untFuncoesCRM, untConsultas, untTypesSistema,
  untRelOcorrenciasCRM, untCadMsg, untPrincipal, untLiberacao, untLiberacaoFactory,
  untPesquisarMenu, Contabilidade.Funcoes, Contabilidade.Consultas,
  untCadClientes, untCadTransportadoras, untFuncIns;

{$R *.dfm}

type
  TcxTableControllerAccess = class(TcxGridTableController);

function TfrmCRMForn.fConsultaFornecedor: Boolean;
begin
  Result := True;
  Try
    Try
      qryCadFor := fCriaQuery(Self);

      pCarregaCadFor;
      If (qryCadFor.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
        pLimparDataSets;
        edtCodFor.SelectAll;
        pSetFocus(edtCodFor);
        Result := False;
      End;

      if Result then
      begin
        EnabledPanels;
        pCarregaInformacoesFornecedor;
        pCarregaInformacoesContatos;
        pCarregaInformacoesGrupoOcorrencias;
        cdsGrupoOcorrAfterScroll(cdsGrupoOcorr);
        if not blnEmergencial then
          pCarregaOcorrenciaEmergencial(cdsFornecedoresFOR_CODFOR.AsString, strLoginUsuarioLogado,VS_strCodEmp);
      end;
    Except
      On E : Exception Do
      Begin
        pClientVazio;
        pMensagensErro(E.Message + #13#10 + 'Não foi possível carregar as informações do Fornecedor!', 'TfrmCRMForn.fConsultaFornecedor');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryCadFor);
  End;
end;

procedure TfrmCRMForn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fGetFuncoesCxGrid.pSalvarView(dbgGrupoOcorrDBTableView1, self.Name + '_dbgGrupoOcorrDBTableView1_' + strLoginUsuarioLogado, dbgGrupoOcorrDBTableView1.DataController.DataSet, False);
  fGetFuncoesCxGrid.pSalvarView(dbgMovOcorrDBTableView1, self.Name   + '_dbgMovOcorrDBTableView1_' + strLoginUsuarioLogado, dbgMovOcorrDBTableView1.DataController.DataSet, False);
  fGetFuncoesCxGrid.pSalvarView(dbgContatosDBTableView1, self.Name   + '_dbgContatosDBTableView1_' + strLoginUsuarioLogado, dbgContatosDBTableView1.DataController.DataSet, False);
  pFecharDataSets;
end;

procedure TfrmCRMForn.FormCreate(Sender: TObject);
  Var
    intRecNo : Integer;
begin
  inherited;
  blnEmergencial := False;
  pCriarDataSets;
  cxZebra.Color := fCfgSis('CORZEB', varInteger);
  spnFiltroDias.Value := fCfgSis('DIAOCO', varInteger);

  intRecNo := dbgGrupoOcorrDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgGrupoOcorrDBTableView1, self.Name + '_dbgGrupoOcorrDBTableView1_' + strLoginUsuarioLogado, dbgGrupoOcorrDBTableView1.DataController.DataSet, intRecNo, False);

  intRecNo := dbgMovOcorrDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgMovOcorrDBTableView1, self.Name + '_dbgMovOcorrDBTableView1_' + strLoginUsuarioLogado, dbgMovOcorrDBTableView1.DataController.DataSet, intRecNo, False);

  intRecNo := dbgContatosDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgContatosDBTableView1, self.Name + '_dbgContatosDBTableView1_' + strLoginUsuarioLogado, dbgContatosDBTableView1.DataController.DataSet, intRecNo, False);

end;

procedure TfrmCRMForn.FormDestroy(Sender: TObject);
begin
  If Assigned(dbgMovOcorrDBTableView1) Then
    TcxTableControllerAccess(dbgMovOcorrDBTableView1.Controller).StopPullFocusing;
  inherited;
end;

procedure TfrmCRMForn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    btnPesquisarMenus.Click;
  End;

  Case Key Of
    VK_F1: btnNovaOcorrencia.Click;
    VK_F2: btnLocalizarOcorr.Click;
    VK_F11: mnuCadMsg.Click;
    VK_F8: btnRelOcorrenciasCRM.Click;
  End;

  If (Key = VK_Insert) Then
  Begin
    If Not edtCodFor.Focused Then
      Exit;

    If edtCodFor.ReadOnly Then
      Exit;

    pAbreCadastroFornecedor(Key);
  End;
end;

procedure TfrmCRMForn.pAbreCadastroFornecedor(Key: Word);
var
  strCodTmp: String;
Begin
  strCodTmp := EmptyStr;
  edtCodFor.ReadOnly := True;
  Try
    If Not fVerificaAcessoSistema('frmCadFornecedores') Then
      Exit;

    If Not fEmptyStr(edtCodFor.Text) Then
      strCodTmp := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_CODFOR'], [fStrZero(edtCodFor.Text, 8)]);

    If fEmptyStr(strCodTmp) Then
      strCodTmp := untFuncIns.fChamaCadFor(Key)
    Else
      strCodTmp := TfrmCadFornecedores.fAlteraCadFor(fStrZero(edtCodFor.Text, 8));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodFor.Text := strCodTmp;
      edtDesCodFor.Text := fRetNomFornecedor(edtCodFor.Text);
    End;

  Finally
    edtCodFor.ReadOnly := False;
  End;
End;

procedure TfrmCRMForn.FormShow(Sender: TObject);
begin
  inherited;
  If fStrToFloat(fCadEmp('CRMFOR')) > 0 Then
    Self.Color := StrToIntDef(fCadEmp('CRMFOR'), $00FFE4D5);

  DisablePanels;
  pSetFocus(edtCodFor);
end;

function TfrmCRMForn.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtCodFor) Then
      Begin
        If (fEmptyStr(edtCodFor.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
          pLimparDataSets;
          Result := False;
        End
        Else
        Begin
          Result := fConsultaFornecedor;
        End;
      End
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
			fMensagem('', E.Message, ['&Ok']);
      Result := False;
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCRMForn.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmCRMForn.getCodGoc: String;
begin
  Result := FCodGoc;
end;

procedure TfrmCRMForn.mnuCadMsgClick(Sender: TObject);
  Var
    frmMsg: TfrmCadMsg;
begin
  If fVerificaAcessoSistema('CRFMEN') Then
  Begin
    inherited;
    Try
      pCriarFormularios(TfrmCadMsg, frmMsg);
      frmMsg.tmrTemMsg   := frmPrincipal.tmrTemMsg;
      frmMsg.Tag         := 0;
      frmMsg.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[Criar Formulário de Mensagens]');
        Exit;
      End;
    End;

    pFreeAndNil(frmMsg);
    Windows.setFocus(0);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRMForn.pAdicionaMascarasCliente;
begin
  if cdsFornecedoresFOR_CGCCPF.AsString = '1' then
    cdsFornecedoresFOR_C_G_C_.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  else if cdsFornecedoresFOR_CGCCPF.AsString = '2' then
    cdsFornecedoresFOR_C_G_C_.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

   cdsFornecedoresFOR_C_G_C_.EditMask := Copy(cdsFornecedoresFOR_C_G_C_.EditMask, 1, Length(cdsFornecedoresFOR_C_G_C_.EditMask)-1);

   cdsFornecedoresFOR_C_E_P_.EditMask := '99999-999;0;_';
   cdsFornecedoresFOR_FONE01.EditMask := fRetMascaraFonePais;
   cdsFornecedoresFOR_FONE02.EditMask := fRetMascaraFonePais;
   cdsFornecedoresFOR_F_A_X_.EditMask := fRetMascaraFonePais;
   cdsFornecedoresFOR_NUMCEL.EditMask := fRetMascaraFonePais;
   cdsContatosFOR_TELCTT.EditMask     := fRetMascaraFonePais;
   cdsContatosFOR_CELCTT.EditMask     := fRetMascaraFonePais;
   cdsContatosFOR_FAXCTT.EditMask     := fRetMascaraFonePais;
   cdsFornecedoresFOR_CNDPAG.EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
   cdsFornecedoresFOR_PERCOM.DisplayFormat := '#,##0.00';
   cdsFornecedoresFOR_0800__.EditMask := '9999-9999-9999;0;_';
   cdsFornecedoresFOR_PERFCX.DisplayFormat := '#,##0.00';
   cdsFornecedoresFOR_DESVIS.DisplayFormat := '#,##0.00';
end;

procedure TfrmCRMForn.pCamposVisiveisFornecedores(qrySel: TUniQuery);
begin
  With qrySel Do
  Begin
    First;
    While Not Eof do
    Begin
      If dbgFornecedores.DataController.DataSource.DataSet.FindField(FieldByName('CRM_NOMCAM').AsString) <> NIL Then
        TcxDBEditorRow(dbgFornecedores.RowByName('dbgFornecedores'+FieldByName('CRM_NOMCAM').AsString)).Visible := IIF(FieldByName('CRM_EXIBIR').AsString = 'S', True, False);
      Next;
    End;
  End;
end;

procedure TfrmCRMForn.pCarregaCadFor;
begin
  pPesquisaCadFor(qryTabela, qryCadFor, edtCodFor.Text);
  edtDesCodFor.Text := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmCRMForn.pCarregaInformacoesFornecedor;
var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesFornecedores);
      Params.ParamByName('CODFOR').AsString := Trim(edtCodFor.Text);
      Open;
      First;

      cdsFornecedores.EmptyDataSet;
      cdsFornecedores.Append;
      cdsFornecedoresFOR_STATUS.AsString := FieldByName('FOR_STATUS').AsString;
      cdsFornecedoresFOR_NOMFOR.AsString := FieldByName('FOR_NOMFOR').AsString;
      cdsFornecedoresFOR_NOMFAN.AsString := FieldByName('FOR_NOMFAN').AsString;
      cdsFornecedoresFOR_C_E_P_.AsString := FieldByName('FOR_C_E_P_').AsString;
      cdsFornecedoresFOR_ENDERE.AsString := FieldByName('FOR_ENDERE').AsString;
      cdsFornecedoresFOR_ENDNUM.AsString := FieldByName('FOR_ENDNUM').AsString;
      cdsFornecedoresFOR_ENDCOM.AsString := FieldByName('FOR_ENDCOM').AsString;
      cdsFornecedoresFOR_BAIRRO.AsString := FieldByName('FOR_BAIRRO').AsString;
      cdsFornecedoresFOR_CGCCPF.AsString := FieldByName('FOR_CGCCPF').AsString;
      cdsFornecedoresFOR_C_G_C_.AsString := FieldByName('FOR_C_G_C_').AsString;
      cdsFornecedoresFOR_CAIPOS.AsString := FieldByName('FOR_CAIPOS').AsString;
      cdsFornecedoresFOR_I_E_S_.AsString := FieldByName('FOR_I_E_S_').AsString;
      cdsFornecedoresFOR_NUMRG_.AsString := FieldByName('FOR_NUMRG_').AsString;
      cdsFornecedoresFOR_FONE01.AsString := FieldByName('FOR_FONE01').AsString;
      cdsFornecedoresFOR_FONE02.AsString := FieldByName('FOR_FONE02').AsString;
      cdsFornecedoresFOR_F_A_X_.AsString := FieldByName('FOR_F_A_X_').AsString;
      cdsFornecedoresFOR_NUMCEL.AsString := FieldByName('FOR_NUMCEL').AsString;
      cdsFornecedoresFOR_0800__.AsString := FieldByName('FOR_0800__').AsString;
      cdsFornecedoresFOR_CONTAT.AsString := FieldByName('FOR_CONTAT').AsString;
      cdsFornecedoresFOR_PERCOM.AsFloat  := FieldByName('FOR_PERCOM').AsFloat;
      cdsFornecedoresFOR_HOMEPA.AsString := FieldByName('FOR_HOMEPA').AsString;
      cdsFornecedoresFOR_EMAIL_.AsString := FieldByName('FOR_EMAIL_').AsString;
      cdsFornecedoresFOR_EMAIL2.AsString := FieldByName('FOR_EMAIL2').AsString;
      cdsFornecedoresFOR_CONCON.AsString := FieldByName('FOR_CONCON').AsString;
      cdsFornecedoresFOR_CODATI.AsString := FieldByName('FOR_CODATI').AsString;
      cdsFornecedoresFOR_SIMPAU.AsString := FieldByName('FOR_SIMPAU').AsString;
      cdsFornecedoresFOR_PERFCX.AsFloat  := FieldByName('FOR_PERFCX').AsFloat;
      cdsFornecedoresFOR_MATREV.AsString := FieldByName('FOR_MATREV').AsString;
      cdsFornecedoresFOR_CODOPE.AsString := FieldByName('FOR_CODOPE').AsString;
      cdsFornecedoresFOR_CODCID.AsString := FieldByName('FOR_CODCID').AsString;
      cdsFornecedoresFOR_CTATRA.AsString := FieldByName('FOR_CTATRA').AsString;
      cdsFornecedoresFOR_CNDPAG.AsString := FieldByName('FOR_CNDPAG').AsString;
      cdsFornecedoresFOR_CODTRA.AsString := FieldByName('FOR_CODTRA').AsString;
      cdsFornecedoresFOR_EMAPED.AsString := FieldByName('FOR_EMAPED').AsString;
      cdsFornecedoresFOR_CODCTA.AsString := FieldByName('FOR_CODCTA').AsString;
      cdsFornecedoresFOR_VLRED2.AsString := FieldByName('FOR_VLRED2').AsString;
      cdsFornecedoresFOR_CARPAG.AsInteger := FieldByName('FOR_CARPAG').AsInteger;
      cdsFornecedoresFOR_DESVIS.AsFloat   := FieldByName('FOR_DESVIS').AsFloat;
      cdsFornecedoresFOR_NOMCID.AsString := FieldByName('FOR_NOMCID').AsString;
      cdsFornecedoresFOR_NOMOPE.AsString := FieldByName('FOR_NOMOPE').AsString;
      cdsFornecedoresFOR_DESATI.AsString := FieldByName('FOR_DESATI').AsString;
      cdsFornecedoresFOR_CENTCD.AsString := FieldByName('FOR_CENTCD').AsString;
      cdsFornecedoresFOR_CENTCC.AsString := FieldByName('FOR_CENTCC').AsString;
      cdsFornecedoresFOR_NOMTRA.AsString := FieldByName('FOR_NOMTRA').AsString;
      cdsFornecedoresFOR_CODFOR.AsString := FieldByName('FOR_CODFOR').AsString;
      cdsFornecedores.Post;

      pAdicionaMascarasCliente;

      pVerificaCamposVisiveisFornecedores;
    end;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCRMForn.pCarregaInformacoesContatos;
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesContatosFornecedores);
      Params.ParamByName('CODFOR').AsString := Trim(edtCodFor.Text);
      Open;
      First;
      cdsContatos.DisableControls;
      cdsContatos.EmptyDataSet;
      while not Eof do
      begin
        cdsContatos.Append;
        cdsContatosFOR_CODFOR.AsString := FieldByName('FOR_CODFOR').AsString;
        cdsContatosFOR_NOMCTT.AsString := FieldByName('FOR_NOMCTT').AsString;
        cdsContatosFOR_ENDCTT.AsString := FieldByName('FOR_ENDCTT').AsString;
        cdsContatosFOR_BAICTT.AsString := FieldByName('FOR_BAICTT').AsString;
        cdsContatosFOR_CIDCTT.AsString := FieldByName('FOR_CIDCTT').AsString;
        cdsContatosFOR_TELCTT.AsString := FieldByName('FOR_TELCTT').AsString;
        cdsContatosFOR_EMACTT.AsString := FieldByName('FOR_EMACTT').AsString;
        cdsContatosFOR_CODEMP.AsString := FieldByName('FOR_CODEMP').AsString;
        cdsContatosFOR_CELCTT.AsString := FieldByName('FOR_CELCTT').AsString;
        cdsContatosFOR_FAXCTT.AsString := FieldByName('FOR_FAXCTT').AsString;
        cdsContatosFOR_DEPCTT.AsString := FieldByName('FOR_DEPCTT').AsString;
        cdsContatosFOR_CMPCTT.AsString := FieldByName('FOR_CMPCTT').AsString;
        cdsContatosFOR_NOMCID.AsString := FieldByName('FOR_NOMCID').AsString;
        cdsContatos.Post;

        qryConsulta.Next;
      end;
      cdsContatos.First;
      Application.ProcessMessages;
    end;
  finally
    cdsContatos.EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCRMForn.pCarregaInformacoesGrupoOcorrencias;
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesGrupoOcorrencias('F', fCfgSis('VGOCOP', varBoolean)));
      Params.ParamByName('CODCLI').AsString := Trim(edtCodFor.Text);
      If fCfgSis('VGOCOP', varBoolean) Then
        ParamByName('OPEGOC').AsString := strLoginUsuarioLogado;
      Open;
      First;
      cdsGrupoOcorr.DisableControls;
      cdsGrupoOcorr.EmptyDataSet;
      while not qryConsulta.Eof do
      begin
        cdsGrupoOcorr.Append;
        cdsGrupoOcorr.FieldByName('GOC_CODGOC').AsString := FieldByName('GOC_CODGOC').AsString;
        cdsGrupoOcorr.FieldByName('GOC_DESGOC').AsString := FieldByName('GOC_DESGOC').AsString;
        cdsGrupoOcorr.FieldByName('GOC_CODEMP').AsString := FieldByName('GOC_CODEMP').AsString;
        cdsGrupoOcorr.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
        cdsGrupoOcorr.FieldByName('GOC_NUMTOT').AsFloat  := FieldByName('GOC_NUMTOT').AsFloat;
        if FileExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + cdsGrupoOcorr.FieldByName('GOC_CODGOC').AsString + '.jpg') then
          TBlobField(cdsGrupoOcorr.FieldByName('IMAGEM')).LoadFromFile(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + cdsGrupoOcorr.FieldByName('GOC_CODGOC').AsString + '.jpg');
        cdsGrupoOcorr.Post;

        qryConsulta.Next;
      end;
      cdsGrupoOcorr.First;
      Application.ProcessMessages;
    end;
  finally
    cdsGrupoOcorr.EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCRMForn.pCarregaOcorrenciaAlteracao;
begin
  if (not cdsFornecedores.IsEmpty) and (not cdsMovOcorr.IsEmpty) then
  begin
    pIncluirNovoHistoricoOcorrencia;
    pFiltraOcorrencias(FCodGoc, edtCodFor.Text); //ponto a ser melhorado
    pLocalizaOcorrenciaSolicitada;
  end;
end;

procedure TfrmCRMForn.pCarregaOcorrenciaEmergencial(strCodCli, strCodOpe,
  strCodEmp: String);
begin
  try
    blnEmergencial := True;
    pCriarFormularios(TfrmConsultaOcorrenciasCRMEmergenciais,frmConsultaOcorrenciasCRMEmergenciais);
    frmConsultaOcorrenciasCRMEmergenciais.strCodCli := strCodCli;
    frmConsultaOcorrenciasCRMEmergenciais.strCodEmp := strCodEmp;
    frmConsultaOcorrenciasCRMEmergenciais.strCodOpe := strCodOpe;
    frmConsultaOcorrenciasCRMEmergenciais.strTip_Fc := 'F';
    frmConsultaOcorrenciasCRMEmergenciais.pConsultaEmergenciais;
    if not frmConsultaOcorrenciasCRMEmergenciais.cdsOcorrencias.IsEmpty then
    begin
      frmConsultaOcorrenciasCRMEmergenciais.ShowModal;
      if not fEmptyStr(frmConsultaOcorrenciasCRMEmergenciais.strCodOco) then
      begin
        strCodOco := frmConsultaOcorrenciasCRMEmergenciais.strCodOco;
        strCodGoc := frmConsultaOcorrenciasCRMEmergenciais.strCodGoc;
        pLocalizaGruposOcorrenciaSolicitada;
        pLocalizaOcorrenciaSolicitada;
        pCarregaOcorrenciaAlteracao;
      end;
    end;
  finally
    FreeAndNil(frmConsultaOcorrenciasCRMEmergenciais);
  end;
end;

procedure TfrmCRMForn.pChamaConsultaOcorrenciaCRM;
begin
  Try
    pCriarFormularios(TfrmConsultaOcorrenciasCRM,frmConsultaOcorrenciasCRM);
    If Not cdsFornecedores.IsEmpty Then
      frmConsultaOcorrenciasCRM.edtCodCli.Text := cdsFornecedores.FieldByName('FOR_CODFOR').AsString;
    frmConsultaOcorrenciasCRM.strTip_Fc := 'F';
    frmConsultaOcorrenciasCRM.ShowModal;
    If frmConsultaOcorrenciasCRM.blnConfirma Then
    Begin
      strCodGoc := frmConsultaOcorrenciasCRM.strCodGoc;
      strCodOco := frmConsultaOcorrenciasCRM.strCodOco;
      edtCodFor.Text := frmConsultaOcorrenciasCRM.strCodCli;
      fValidaCampos(edtCodFor,True);
      pLocalizaGruposOcorrenciaSolicitada;
      pLocalizaOcorrenciaSolicitada;
      pSetFocus(dbgMovOcorr);
    End;
  Finally
    FreeAndNil(frmConsultaOcorrenciasCRM);
  End;
end;

procedure TfrmCRMForn.pClientVazio;
begin
  cdsFornecedores.EmptyDataSet;
  cdsContatos.EmptyDataSet;
  cdsGrupoOcorr.EmptyDataSet;
  cdsMovOcorr.EmptyDataSet;
end;

procedure TfrmCRMForn.pCriarDataSets;
begin
  cdsFornecedores.CreateDataSet;
  cdsContatos.CreateDataSet;
  cdsGrupoOcorr.CreateDataSet;
  cdsMovOcorr.CreateDataSet;
end;

procedure TfrmCRMForn.pDesabilitaBotoesPanelSuperiorCrm;
begin
  btnNovaOcorrencia.Enabled   := False;
end;

procedure TfrmCRMForn.pFecharDataSets;
begin
  cdsFornecedores.Close;
  cdsContatos.Close;
  cdsGrupoOcorr.Close;
  cdsMovOcorr.Close;
end;

procedure TfrmCRMForn.pFiltraOcorrencias(strCodGoc, strCodCli: String);
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesOcorrencias('F')); //parametro Tip_Fc
      SQL.Add(' AND (DATEDIFF(CURDATE(),OCO_DTACON) <= :OCODIA OR OCO_DTACON IS NULL) ');
      ParamByName('CODGOC').AsString := strCodGoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('OCODIA').AsInteger := spnFiltroDias.Value;
      Open;
      First;
      cdsMovOcorr.DisableControls;
      cdsMovOcorr.EmptyDataSet;
      while not Eof do
      begin
        cdsMovOcorr.Append;
        cdsMovOcorrOCO_PROTOC.AsString   := FieldByName('OCO_PROTOC').AsString;
        cdsMovOcorrOCO_CODOCO.AsString   := FieldByName('OCO_CODOCO').AsString;
        cdsMovOcorrOCO_CODTOC.AsString   := FieldByName('OCO_CODTOC').AsString;
        cdsMovOcorrOCO_CODCLI.AsString   := FieldByName('OCO_CODCLI').AsString;
        if FieldByName('OCO_DTAINC').AsDateTime > 0 then
          cdsMovOcorrOCO_DTAINC.AsDateTime := FieldByName('OCO_DTAINC').AsDateTime
        else
          cdsMovOcorrOCO_DTAINC.IsNull;
        if FieldByName('OCO_HORINC').AsDateTime > 0 then
          cdsMovOcorrOCO_HORINC.AsDateTime := FieldByName('OCO_HORINC').AsDateTime
        else
          cdsMovOcorrOCO_HORINC.IsNull;
        if FieldByName('OCO_DTACON').AsDateTime > 0 then
          cdsMovOcorrOCO_DTACON.AsDateTime := FieldByName('OCO_DTACON').AsDateTime
        else
          cdsMovOcorrOCO_DTACON.IsNull;
        if FieldByName('OCO_HORCON').AsDateTime > 0 then
          cdsMovOcorrOCO_HORCON.AsDateTime := FieldByName('OCO_HORCON').AsDateTime
        else
          cdsMovOcorrOCO_HORCON.IsNull;
        cdsMovOcorrOCO_CODOPE.AsString   := FieldByName('OCO_CODOPE').AsString;
        cdsMovOcorrOCO_DESCRI.AsString   := FieldByName('OCO_DESCRI').AsString;
        cdsMovOcorrOCO_CODEMP.AsString   := FieldByName('OCO_CODEMP').AsString;
        cdsMovOcorrAUTOINCREM.AsString   := FieldByName('AUTOINCREM').AsString;

        cdsMovOcorrCLI_NOMCLI.AsString   := FieldByName('CLI_NOMCLI').AsString;
        cdsMovOcorrTOC_DESTOC.AsString   := FieldByName('TOC_DESTOC').AsString;
        cdsMovOcorrOPE_NOMOPE.AsString   := FieldByName('OPE_NOMOPE').AsString;
        cdsMovOcorrHOREXC.AsInteger      := FieldByName('OCO_HOREXC').AsInteger;

        cdsMovOcorrOCO_DTALIM.AsDateTime := FieldByName('OCO_DTALIM').AsDateTime;
        cdsMovOcorrOCO_TMPLIM.AsFloat   := FieldByName('OCO_TMPLIM').AsFloat;
        cdsMovOcorrOCO_METLIM.AsFloat   := FieldByName('OCO_METLIM').AsFloat;

        cdsMovOcorrOCO_EMERGE.AsString   := FieldByName('OCO_EMERGE').AsString;
        cdsMovOcorrOCO_TIP_FC.AsString   := FieldByName('OCO_TIP_FC').AsString;                  
        if FileExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + cdsMovOcorr.FieldByName('OCO_CODTOC').AsString + '.jpg') then
          TBlobField(cdsMovOcorr.FieldByName('IMAGEM1')).LoadFromFile(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + cdsMovOcorr.FieldByName('OCO_CODTOC').AsString + '.jpg');
        cdsMovOcorr.Post;

        qryConsulta.Next;
      end;
//      cdsMovOcorr.First;
      Application.ProcessMessages;
    end;

  finally
    cdsMovOcorr.EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCRMForn.pHabilitaBotoesPanelSuperiorCrm;
begin
  btnNovaOcorrencia.Enabled   := True;
end;

procedure TfrmCRMForn.pIncluirNovaOcorrencia;
var
  frmCadMovOcorrencias : TfrmCadMovOcorrencias;
begin
  Try
    pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);
    frmCadMovOcorrencias.strCodCli := cdsFornecedores.FieldByName('FOR_CODFOR').AsString;
    frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;
    frmCadMovOcorrencias.strOperac := 'Inserir';
    frmCadMovOcorrencias.strTip_Fc := 'F'; 
    frmCadMovOcorrencias.ShowModal;
    strCodGoc := frmCadMovOcorrencias.strCodGoc;
  Finally
    FreeAndNil(frmCadMovOcorrencias);
    pSetFocus(dbgGrupoOcorr);
  End;
end;

procedure TfrmCRMForn.pIncluirNovoHistoricoOcorrencia;
var
  frmCadMovOcorrencias : TfrmCadMovOcorrencias;
begin
  try
    strCodOco := cdsMovOcorr.FieldByName('OCO_CODOCO').AsString;
    pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);

    frmCadMovOcorrencias.Caption   := 'Ocorrência - Protocolo ' + cdsMovOcorr.FieldByName('OCO_PROTOC').AsString;
    frmCadMovOcorrencias.strCodOco := cdsMovOcorr.FieldByName('OCO_CODOCO').AsString;
    frmCadMovOcorrencias.strCodCli := cdsMovOcorr.FieldByName('OCO_CODCLI').AsString;
    frmCadMovOcorrencias.strCodEmp := cdsMovOcorr.FieldByName('OCO_CODEMP').AsString;    
    frmCadMovOcorrencias.strOperac := 'Alterar';
    frmCadMovOcorrencias.strTip_Fc := cdsMovOcorr.FieldByName('OCO_TIP_FC').AsString;
    frmCadMovOcorrencias.ShowModal;
    strCodGoc := frmCadMovOcorrencias.strCodGoc;
  finally
    FreeAndNil(frmCadMovOcorrencias);
    pSetFocus(dbgMovOcorr);
  end;
end;

procedure TfrmCRMForn.pLimparDataSets;
begin
  cdsFornecedores.EmptyDataSet;
  cdsContatos.EmptyDataSet;
  cdsGrupoOcorr.EmptyDataSet;
  cdsMovOcorr.EmptyDataSet;
end;

procedure TfrmCRMForn.pLocalizaGruposOcorrenciaSolicitada;
begin
  cdsGrupoOcorr.Locate('GOC_CODGOC',FCodGoc,[]);
end;

procedure TfrmCRMForn.pLocalizaOcorrenciaSolicitada;
begin
  cdsMovOcorr.Locate('OCO_CODOCO',strCodOco,[]);
end;

procedure TfrmCRMForn.pSetaParametrosBotaoCliente(strNomCampo, strModulo: String;  strDesCampo: String = '');
begin

  try
    TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
    pCriarFormularios(TfrmCadFornecedores,frmCadFornecedores);
    frmCadFornecedores.pSetaParametrosCRM(strNomCampo, Self.edtCodFor.Text, strModulo, strDesCampo);
    frmCadFornecedores.fMskCon := fMskCon;
    frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
    frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
    frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
    frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
    frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
    frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
    frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
    frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
    frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
    frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
    frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
    frmCadFornecedores.ShowModal;
  finally
    frmCadFornecedores.fMskCon := Nil;
    frmCadFornecedores.fSemMascaraPlaNco := Nil;
    frmCadFornecedores.fPesqPlanoContabil := Nil;
    frmCadFornecedores.fCadastroRapidoCliente := Nil;
    frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
    frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
    frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
    frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
    pFreeAndNil(frmCadFornecedores);
  end;

end;

procedure TfrmCRMForn.pVerificaCamposVisiveisFornecedores;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CRM_TIP_FC, ');
      SQL.Add('        CRM_NOMCAM, ');
      SQL.Add('        CRM_EXIBIR, ');
      SQL.Add('        CRM_DESCAM, ');
      SQL.Add('        CRM_CODEMP  ');
      SQL.Add('  FROM CLICRM       ');
      SQL.Add(' WHERE CRM_CODEMP = :CODEMP ');
      SQL.Add('   AND CRM_TIP_FC = "F" ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
        pCamposVisiveisFornecedores(qryCons);

    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCRMForn.setCodGoc(const Value: String);
begin
  If (FCodGoc <> Value) Then
    FCodGoc := Value;
end;

procedure TfrmCRMForn.spnFiltroDiasChange(Sender: TObject);
begin
  inherited;

  If spnFiltroDias.Focused Then
    cdsGrupoOcorrAfterScroll(cdsGrupoOcorr);
end;

procedure TfrmCRMForn.btnLocalizarOcorrClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRFLOC') Then
  Begin
    inherited;
//  if (btnLocalizarOcorr.Enabled) And (not cdsFornecedores.IsEmpty) and (not cdsGrupoOcorr.IsEmpty) then
    pChamaConsultaOcorrenciaCRM;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRMForn.btnNovaOcorrenciaClick(Sender: TObject);
begin
  If Not btnNovaOcorrencia.Enabled Then
    Exit;
  If fVerificaAcessoSistema('CRFBOC') Then
  Begin
    inherited;
    if (btnNovaOcorrencia.Enabled) and  (not cdsFornecedores.IsEmpty) and (not cdsGrupoOcorr.IsEmpty) then
    begin
      pIncluirNovaOcorrencia;
      if not fEmptyStr(FCodGoc) then
        pFiltraOcorrencias(FCodGoc, edtCodFor.Text);
    end;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRMForn.btnPesquisarMenusClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRFPME') Then
  Begin
    inherited;
    TfrmPesquisarMenu.pPesquisarMenus;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRMForn.btnRelOcorrenciasCRMClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRFROC') Then
  Begin
    inherited;

    If Assigned(prcExecutaRelatorio) Then
         prcExecutaRelatorio(9, 1239, [1239,1243],
                             ['CODFOR'],
                             [edtCodFor.Text],
                             Sender);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);

end;

procedure TfrmCRMForn.cdsFornecedoresAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not DataSet.IsEmpty then
    pHabilitaBotoesPanelSuperiorCrm
  else
    pDesabilitaBotoesPanelSuperiorCrm;
end;

procedure TfrmCRMForn.cdsGrupoOcorrAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dtsGrupoOcorr.DataSet.IsEmpty and not dtsGrupoOcorr.DataSet.ControlsDisabled then
    pFiltraOcorrencias(dtsGrupoOcorr.DataSet.FieldByName('GOC_CODGOC').AsString,
                       edtCodFor.Text);
end;

procedure TfrmCRMForn.cxDBVerticalGrid1CLI_FANSOBEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_C_G_C_','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1CID_NOMCIDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1ETC_BAIENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1ETC_CEPENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1ETC_CONENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1ETC_ENDENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1ETC_REFENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1ETC_TELENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.cxGridDBTableView1TRA_NOMTRAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_ATRMAXEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CONTAT','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_BAIRROEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_PERFCX','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_CAIPOSEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_VLRED2','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_CELULAEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CELULA','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_CONSUMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CONSUM','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_CONTATEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CONTAT','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_C_E_P_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_I_E_S_','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_C_G_C_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_MATREV','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_DESATIEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CODATI','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_DESCONEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_0800__','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_DESFPGEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_FONE01','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_DESPOREditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_F_A_X_','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_DESREGEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_C_E_P_','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_DESTCLEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_FONE02','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_EMAIL2EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMAIL2','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_EMAIL3EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMAIL3','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_EMAIL_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMAIL_','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_ENDEREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CONCON','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_ENDNUMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_SIMPAU','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_FONE01EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CARPAG','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_FONE02EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_FONE02','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_F_A_X_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_F_A_X_','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_HOMEPAEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_HOMEPA','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_I_E_S_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CNDPAG','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_I_M_P_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_EMAPED','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_LIMCREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CODOPE','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NASCIMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CODCTA','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NEXTELEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_NEXTEL','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMCACEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_NUMCEL','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMCIDEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CAIPOS','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMDIVEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_BAIRRO','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMERCEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_NUMRG_','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMFXAEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_HOMEPA','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMREDEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_ENDNUM','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMREPEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_NOMFOR','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMSGEEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_NOMFAN','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMSREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CODCID','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NOMVENEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODVEN','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_NUMR_GEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CENTCD','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_PERCOMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_ENDERE','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_PEREMPEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_ENDCOM','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_PERMFFEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_EMAIL2','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_RAMAL1EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_DESVIS','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_RAMAL2EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_RAMAL2','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_RAMAL3EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_RAMAL3','Clientes');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgClientesCLI_TABPREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('FOR_CODTRA','Fornecedores');
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_CELCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESCGOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESDPTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESECIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESESCPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESGMUPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESHOBPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_DESTFUPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_FAXCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_NOMCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1CLI_TELCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgContatosDBTableView1FOR_NOMCIDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('FOR_NOMCTT').AsString);
  fValidaCampos(Self.edtCodFor,True);
end;

procedure TfrmCRMForn.dbgMovOcorrDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  fltHorExc,
  fltTmpLim,
  fltMetLim: Double;

  dDtaCon,
  dHorCon: TDateTime;
  strEmerge: String;
begin
  inherited;

  fltTmpLim := VarAsType( IIF(dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_TMPLIM.Index] = null,0,dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_TMPLIM.Index]), varDouble );
  fltMetLim := VarAsType( IIF(dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_METLIM.Index] = null,0,dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_METLIM.Index]), varDouble );
  fltHorExc := VarAsType( IIF(dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1HOREXC.Index]     = null,0,dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1HOREXC.Index]), varDouble );

  dDtaCon   := VarAsType( IIF(dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_DTACON.Index] = null,0,dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_DTACON.Index]), varDate );
  dHorCon   := VarAsType( IIF(dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_HORCON.Index] = null,0,dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_HORCON.Index]), varDate );
  strEmerge := VarAsType( IIF(dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_EMERGE.Index] = null,0,dbgMovOcorrDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgMovOcorrDBTableView1OCO_EMERGE.Index]), varString );

  If ((dDtaCon = 0) And (fltHorExc > fltTmpLim)) Then // ultrapassou o tempo limite resolucao ocorrencia( configuracao cfg_Resoco )
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clWhite;
  End
  Else If (dDtaCon > 0) And (dHorCon > 0) Then  //ocorrencia concluida
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clGreen
    Else
      ACanvas.Font.Color := clWhite;
  End
  Else If ((dDtaCon = 0) And (fltHorExc > fltMetLim)) Then  //50% do tempo da configuracao( configuracao cfg_Resoco )
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := $000080FF //laranja
    Else
      ACanvas.Font.Color := clWhite;
  End
  Else If ((dDtaCon = 0) And (strEmerge = 'S')) Then //Emergencail
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clPurple
    Else
      ACanvas.Font.Color := clWhite;
  End

end;

procedure TfrmCRMForn.dbgMovOcorrDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  If (Not cdsMovOcorr.IsEmpty) Then
    pCarregaOcorrenciaAlteracao;
end;

procedure TfrmCRMForn.dbgMovOcorrDBTableView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (pnlOcorrencias.Enabled) Then
  Begin
    If (Not cdsMovOcorr.IsEmpty) Then
      pCarregaOcorrenciaAlteracao;
  End
end;

procedure TfrmCRMForn.DisablePanels;
begin
  pnlCliente.Enabled     := False;
  pnlContato.Enabled     := False;
  pnlGrupoOcor.Enabled   := False;
  pnlOcorrencias.Enabled := False;
end;

procedure TfrmCRMForn.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrForn: TConsultasArray;
begin
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************AC*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesCodFor, Nil, Key, arrForn) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCRMForn.EnabledPanels;
begin
  pnlCliente.Enabled     := True;
  pnlContato.Enabled     := True;
  pnlGrupoOcor.Enabled   := True;
  pnlOcorrencias.Enabled := True;
end;

end.

