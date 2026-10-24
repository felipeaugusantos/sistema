unit untCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, untZClient, Vcl.Printers,
  Uni, cxStyles, cxGraphics, cxEdit, strUtils, untTypesSistema,
  cxButtonEdit, cxDropDownEdit, cxVGrid, cxDBVGrid, cxControls,
  cxInplaceContainer, DB, UniClientDataSet, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxImage,
  DateUtils, UniDataSetProvider, cxGridCitel,
  BitBtnLockedIncrem, MaskUtils, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, Vcl.Samples.Spin,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesRel, untFuncoesRel2, untLiberacao, dxColorEdit,
  MaskEditFocus, untMskC_G_C_, untLabelCgcCpf, untILeads, untLeads, untFatBaixarPedOrcNaoEntregue, untTypesCrm, untMostraDebCtrChq2,
  cxTextEdit;

type
  TfrmCRM = class(TfrmPaiSimples)
    pnlDados: TPanel;
    pnlConsulta: TPanel;
    GroupBox1: TGroupBox;
    edtDesCodCli: TEditFocus;
    edtCodCli: TEditFocus;
    pnlRodape: TPanel;
    pnlEsquerda: TPanel;
    pnlDireita: TPanel;
    pnlCliente: TPanel;
    grbCliente: TGroupBox;
    splMeio: TSplitter;
    pnlContato: TPanel;
    splCliCon: TSplitter;
    splConEnd: TSplitter;
    pnlEndereco: TPanel;
    grbContatos: TGroupBox;
    grbEnderecos: TGroupBox;
    splGruOcor: TSplitter;
    pnlOcorrencias: TPanel;
    grbOcorrencias: TGroupBox;
    pnlGridCliente: TPanel;
    pnfInfCliente: TPanel;
    pnlFazendas: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    dbgClientes: TcxDBVerticalGrid;
    dtsCliente: TDataSource;
    cdsCliente: TUniClientDataSet;
    cdsClienteCLI_CODCLI: TStringField;
    cdsClienteCLI_NOMCLI: TStringField;
    cdsClienteCLI_FANSOB: TStringField;
    cdsClienteCLI_CODCID: TStringField;
    cdsClienteCLI_C_E_P_: TStringField;
    cdsClienteCLI_ENDERE: TStringField;
    cdsClienteCLI_ENDNUM: TStringField;
    cdsClienteCLI_ENDCOM: TStringField;
    cdsClienteCLI_BAIRRO: TStringField;
    cdsClienteCLI_CGCCPF: TIntegerField;
    cdsClienteCLI_C_G_C_: TStringField;
    cdsClienteCLI_NUMR_G: TStringField;
    cdsClienteCLI_I_E_S_: TStringField;
    cdsClienteCLI_I_M_P_: TStringField;
    cdsClienteCLI_NASCIM: TDateField;
    cdsClienteCLI_CAIPOS: TStringField;
    cdsClienteCLI_FONE01: TStringField;
    cdsClienteCLI_RAMAL1: TStringField;
    cdsClienteCLI_FONE02: TStringField;
    cdsClienteCLI_RAMAL2: TStringField;
    cdsClienteCLI_F_A_X_: TStringField;
    cdsClienteCLI_RAMAL3: TStringField;
    cdsClienteCLI_CELULA: TStringField;
    cdsClienteCLI_NEXTEL: TStringField;
    cdsClienteCLI_EMAIL_: TStringField;
    cdsClienteCLI_CONTAT: TStringField;
    cdsClienteCLI_EMAIL2: TStringField;
    cdsClienteCLI_EMAIL3: TStringField;
    cdsClienteCLI_CONSUM: TStringField;
    cdsClienteCLI_HOMEPA: TStringField;
    cdsClienteCLI_CODVEN: TStringField;
    cdsClienteCLI_CODREP: TStringField;
    cdsClienteCLI_SUPGER: TStringField;
    cdsClienteCLI_SUPREG: TStringField;
    cdsClienteCLI_CODATI: TStringField;
    cdsClienteCLI_TABPRE: TStringField;
    cdsClienteCLI_LIMCRE: TFloatField;
    cdsClienteCLI_CODFPG: TStringField;
    cdsClienteCLI_TIPCLI: TStringField;
    cdsClienteCLI_CODPOR: TStringField;
    cdsClienteCLI_DESCON: TFloatField;
    cdsClienteCLI_PERCOM: TFloatField;
    cdsClienteCLI_PEREMP: TStringField;
    cdsClienteCLI_CODREG: TStringField;
    cdsClienteCLI_CODDIV: TStringField;
    cdsClienteCLI_CODRED: TStringField;
    cdsClienteCLI_CODCAC: TStringField;
    cdsClienteCLI_ATRMAX: TIntegerField;
    cdsClienteCLI_PERMFF: TStringField;
    cdsClienteCLI_PERMFV: TStringField;
    cdsClienteCLI_EMPRCF: TStringField;
    dbgClientesCLI_FANSOB: TcxDBEditorRow;
    dbgClientesCLI_NOMCID: TcxDBEditorRow;
    dbgClientesCLI_C_E_P_: TcxDBEditorRow;
    dbgClientesCLI_ENDERE: TcxDBEditorRow;
    dbgClientesCLI_ENDNUM: TcxDBEditorRow;
    dbgClientesCLI_ENDCOM: TcxDBEditorRow;
    dbgClientesCLI_BAIRRO: TcxDBEditorRow;
    dbgClientesCLI_C_G_C_: TcxDBEditorRow;
    dbgClientesCLI_NUMR_G: TcxDBEditorRow;
    dbgClientesCLI_I_E_S_: TcxDBEditorRow;
    dbgClientesCLI_I_M_P_: TcxDBEditorRow;
    dbgClientesCLI_NASCIM: TcxDBEditorRow;
    dbgClientesCLI_CAIPOS: TcxDBEditorRow;
    dbgClientesCLI_FONE01: TcxDBEditorRow;
    dbgClientesCLI_RAMAL1: TcxDBEditorRow;
    dbgClientesCLI_FONE02: TcxDBEditorRow;
    dbgClientesCLI_RAMAL2: TcxDBEditorRow;
    dbgClientesCLI_F_A_X_: TcxDBEditorRow;
    dbgClientesCLI_RAMAL3: TcxDBEditorRow;
    dbgClientesCLI_CELULA: TcxDBEditorRow;
    dbgClientesCLI_NEXTEL: TcxDBEditorRow;
    dbgClientesCLI_EMAIL_: TcxDBEditorRow;
    dbgClientesCLI_CONTAT: TcxDBEditorRow;
    dbgClientesCLI_EMAIL2: TcxDBEditorRow;
    dbgClientesCLI_EMAIL3: TcxDBEditorRow;
    dbgClientesCLI_CONSUM: TcxDBEditorRow;
    dbgClientesCLI_HOMEPA: TcxDBEditorRow;
    dbgClientesCLI_NOMVEN: TcxDBEditorRow;
    dbgClientesCLI_NOMREP: TcxDBEditorRow;
    dbgClientesCLI_NOMSGE: TcxDBEditorRow;
    dbgClientesCLI_NOMSRE: TcxDBEditorRow;
    dbgClientesCLI_DESATI: TcxDBEditorRow;
    dbgClientesCLI_TABPRE: TcxDBEditorRow;
    dbgClientesCLI_LIMCRE: TcxDBEditorRow;
    dbgClientesCLI_DESFPG: TcxDBEditorRow;
    dbgClientesCLI_DESTCL: TcxDBEditorRow;
    dbgClientesCLI_DESPOR: TcxDBEditorRow;
    dbgClientesCLI_DESCON: TcxDBEditorRow;
    dbgClientesCLI_PERCOM: TcxDBEditorRow;
    dbgClientesCLI_PEREMP: TcxDBEditorRow;
    dbgClientesCLI_DESREG: TcxDBEditorRow;
    dbgClientesCLI_NOMDIV: TcxDBEditorRow;
    dbgClientesCLI_NOMRED: TcxDBEditorRow;
    dbgClientesCLI_NOMCAC: TcxDBEditorRow;
    dbgClientesCLI_ATRMAX: TcxDBEditorRow;
    dbgClientesCLI_PERMFF: TcxDBEditorRow;
    dbgClientesCLI_NOMERC: TcxDBEditorRow;
    cdsClienteCLI_NOMCID: TStringField;
    cdsClienteCLI_NOMVEN: TStringField;
    cdsClienteCLI_NOMREP: TStringField;
    cdsClienteCLI_NOMSRE: TStringField;
    cdsClienteCLI_DESATI: TStringField;
    cdsClienteCLI_DESFPG: TStringField;
    cdsClienteCLI_DESTCL: TStringField;
    cdsClienteCLI_DESPOR: TStringField;
    cdsClienteCLI_DESREG: TStringField;
    cdsClienteCLI_NOMDIV: TStringField;
    cdsClienteCLI_NOMRED: TStringField;
    cdsClienteCLI_NOMCAC: TStringField;
    cdsClienteCLI_NOMFXA: TStringField;
    cdsClienteCLI_NOMERC: TStringField;
    cdsClienteCLI_NOMSGE: TStringField;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus5: TDBEditFocus;
    DBEditFocus6: TDBEditFocus;
    dtsContatos: TDataSource;
    cdsContatos: TUniClientDataSet;
    cdsContatosCLI_CODCLI: TStringField;
    cdsContatosCLI_NOMCTT: TStringField;
    cdsContatosCLI_TELCTT: TStringField;
    cdsContatosCLI_CELCTT: TStringField;
    cdsContatosCLI_FAXCTT: TStringField;
    cdsContatosCLI_DESDPT: TStringField;
    dbgEnderecos: TcxGridCitel;
    dbgEnderecosDBTableView1: TcxGridDBTableViewCitel;
    dbgEnderecosLevel1: TcxGridLevel;
    dtsEnderecos: TDataSource;
    cdsEnderecos: TUniClientDataSet;
    cdsEnderecosETC_CODCLI: TStringField;
    cdsEnderecosETC_CIDENT: TStringField;
    cdsEnderecosCID_NOMCID: TStringField;
    cdsEnderecosETC_ENDENT: TStringField;
    cdsEnderecosETC_BAIENT: TStringField;
    cdsEnderecosETC_CEPENT: TStringField;
    cdsEnderecosETC_TELENT: TStringField;
    cdsEnderecosETC_CONENT: TStringField;
    cdsEnderecosETC_REFENT: TStringField;
    cdsEnderecosETC_CODTRA: TStringField;
    cdsEnderecosTRA_NOMTRA: TStringField;
    cdsEnderecosETC_ENDFAT: TStringField;
    dbgEnderecosDBTableView1CID_NOMCID: TcxGridDBColumn;
    dbgEnderecosDBTableView1ETC_ENDENT: TcxGridDBColumn;
    dbgEnderecosDBTableView1ETC_BAIENT: TcxGridDBColumn;
    dbgEnderecosDBTableView1ETC_CEPENT: TcxGridDBColumn;
    dbgEnderecosDBTableView1ETC_TELENT: TcxGridDBColumn;
    dbgEnderecosDBTableView1ETC_CONENT: TcxGridDBColumn;
    dbgEnderecosDBTableView1ETC_REFENT: TcxGridDBColumn;
    dbgEnderecosDBTableView1TRA_NOMTRA: TcxGridDBColumn;
    dbgContatosDBTableView1: TcxGridDBTableViewCitel;
    dbgContatosLevel1: TcxGridLevel;
    dbgContatos: TcxGridCitel;
    dbgContatosDBTableView1CLI_NOMCTT: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_TELCTT: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_CELCTT: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_FAXCTT: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_DESDPT: TcxGridDBColumn;
    dtsGrupoOcorr: TDataSource;
    cdsGrupoOcorr: TUniClientDataSet;
    cdsGrupoOcorrGOC_CODGOC: TStringField;
    cdsGrupoOcorrGOC_DESGOC: TStringField;
    cdsGrupoOcorrGOC_CODEMP: TStringField;
    cdsGrupoOcorrAUTOINCREM: TStringField;
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
    cdsContatosCLI_DESCGO: TStringField;
    cdsContatosCLI_DESTFU: TStringField;
    cdsContatosCLI_DESHOB: TStringField;
    cdsContatosCLI_DESECI: TStringField;
    cdsContatosCLI_DESGMU: TStringField;
    cdsContatosCLI_DESESC: TStringField;
    dbgContatosDBTableView1CLI_DESCGO: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_DESTFU: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_DESHOB: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_DESECI: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_DESGMU: TcxGridDBColumn;
    dbgContatosDBTableView1CLI_DESESC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1IMAGEM1: TcxGridDBColumn;
    popOrcamento: TPopupMenu;
    popPedido: TPopupMenu;
    mnuFatOrcamento: TMenuItem;
    mnuFatPedido: TMenuItem;
    cdsMovOcorrHOREXC: TFloatField;
    dbgMovOcorrDBTableView1HOREXC: TcxGridDBColumn;
    pnlBotoesCadCli: TPanel;
    cdsMovOcorrOCO_EMERGE: TStringField;
    dbgMovOcorrDBTableView1OCO_EMERGE: TcxGridDBColumn;
    pnlCompromissos: TPanel;
    tmrCompromissos: TTimer;
    Label9: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape1: TShape;
    Label8: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cdsClienteCLI_REGTRI: TStringField;
    dbgClientesCLI_REGTRI: TcxDBEditorRow;
    btnNovaOcorrencia: TBitBtnLocked;
    btnOrcamento: TBitBtnLocked;
    btnPedido: TBitBtnLocked;
    btnLocalizarOcorr: TBitBtnLocked;
    btnEmailDevDac: TBitBtnLocked;
    btnArquivosCobranca: TBitBtnLocked;
    btnArquivosCadastro: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    btnRelAD: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxZebra: TcxStyle;
    btnRelOcorrenciasCRM: TBitBtnLocked;
    cdsMovOcorrOCO_DTALIM: TDateTimeField;
    dbgMovOcorrDBTableView1OCO_DTALIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_TMPLIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_METLIM: TcxGridDBColumn;
    cdsMovOcorrOCO_TMPLIM: TFloatField;
    cdsMovOcorrOCO_METLIM: TFloatField;
    btnGeracaoOcorrencias: TBitBtnLocked;
    pnlOperador: TPanel;
    pnlHora: TPanel;
    pnlData: TPanel;
    tmrHora: TTimer;
    dbgMovOcorrDBTableView1NumDoc: TcxGridDBColumn;
    cdsMovOcorrNUMDOC: TStringField;
    btnRelSituacaoVendasCRM: TBitBtnLocked;
    cdsMovOcorrOCO_CODSIT: TStringField;
    pnlDias: TPanel;
    spnFiltroDias: TSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    popOcorrencias: TPopupMenu;
    mnuAbrirOcorrencia: TMenuItem;
    mnuAlterarDocumento: TMenuItem;
    mnuEnviarEmail: TMenuItem;
    mnuGerarPDF: TMenuItem;
    mnuCadMsg: TBitBtnLocked;
    cdsMovOcorrOCO_PROTOC: TStringField;
    pnlIntVen: TPanel;
    grbIntVen: TGroupBox;
    cxgIntVen: TcxGridCitel;
    cxgIntVenDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgIntVenLevel: TcxGridLevel;
    cxgIntVenCOLUNA: TcxGridDBColumn;
    cxgIntVenVALOR: TcxGridDBColumn;
    Splitter1: TSplitter;
    mnuReimprimir: TMenuItem;
    btnFichaCadastral: TBitBtnLocked;
    mnuEfetivarOrcamento: TMenuItem;
    btnConsumiveis: TBitBtnLocked;
    btnVendasClientes: TBitBtnLocked;
    mnuGerarVendaPerdida: TMenuItem;
    cdsMovOcorrFGO_VLRCON: TFloatField;
    dbgMovOcorrDBTableView1FGO_VLRCON: TcxGridDBColumn;
    cdsMovOcorrSTATUS: TStringField;
    dbgMovOcorrDBTableView1STATUS: TcxGridDBColumn;
    dbgClientesCLI_PERMFV: TcxDBEditorRow;
    cdsMovOcorrNUMCMP: TStringField;
    dbgMovOcorrDBTableView1NUMCMP: TcxGridDBColumn;
    cdsMovOcorrENTRET: TStringField;
    cdsMovOcorrCLILOJ: TStringField;
    dbgMovOcorrDBTableView1ENTRET: TcxGridDBColumn;
    dbgMovOcorrDBTableView1CLILOJ: TcxGridDBColumn;
    btnPesquisarMenus: TBitBtnLocked;
    mnuDesmembrar: TMenuItem;
    mnuBaixar: TMenuItem;
    mnuRetirarVinculoReq_Transf: TMenuItem;
    cdsMovOcorrFGO_STATUS: TIntegerField;
    cdsMovOcorrDOCCON: TStringField;
    dbgMovOcorrDBTableView1DOCCON: TcxGridDBColumn;
    mnuDocumentosConfirmacao: TMenuItem;
    ScrollBox1: TScrollBox;
    btnCadLeads: TBitBtnLocked;
    BtnVendaNormal: TBitBtnLocked;
    PopVendaNormal: TPopupMenu;
    mnuFatVendaNormal: TMenuItem;
    btnPesqLeads: TBitBtnLocked;
    btnRelLeads: TBitBtnLocked;
    btnPromocoes: TBitBtnLocked;
    mnuAnaliseCreditoDEPS: TMenuItem;
    cdsMovOcorrUSADEPS: TStringField;
    cdsMovOcorrSTATUSDEPS: TStringField;
    dbgMovOcorrDBTableView1STATUSDEPS: TcxGridDBColumn;
    cdsMovOcorrAUTOINCREMFATGOR: TStringField;
    tmrSistemaDEPS: TTimer;
    cdsMovOcorrMOTBAI: TStringField;
    cdsMovOcorrCAT_DESCRI: TStringField;
    dbgMovOcorrDBTableView1CAT_DESCRI: TcxGridDBColumn;
    btnQuaCli: TBitBtnLocked;
    mnuLimparSeparacao: TMenuItem;
    cdsMovOcorrCAT_CORCAT: TStringField;
    dbgMovOcorrDBTableView1CAT_CORCAT: TcxGridDBColumn;
    mnuModificarCategoria: TMenuItem;
    cdsMovOcorrESPDOC: TStringField;
    lblCgcCpf: TLabelCgcCpf;
    edtCgcCpf: TEditFocus;
    mskNumCgc: TMaskEditC_G_C_;
    cdsMovOcorrOCO_C_P_F_: TStringField;
    dbgMovOcorrDBTableView1OCO_C_P_F_: TcxGridDBColumn;
    btnMediasCliente: TBitBtnLocked;
    cdsGrupoOcorrGOC_NUMTOT: TIntegerField;
    mnuFaturarEmVendaNormal: TMenuItem;
    btnVenSisAnt: TBitBtnLocked;

    dbgMovOcorrDBTableView1OCO_NUMDOC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_ESPDOC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_CODEMP: TcxGridDBColumn;
    cdsMovOcorrOCO_NUMDOC: TStringField;
    cdsMovOcorrOCO_ESPDOC: TStringField;
    cdsMovOcorrOCO_EMPDOC: TStringField;
    btnHisDeb: TBitBtnLocked;
    btnResFin: TBitBtnLocked;
    mnuAbrirLead: TMenuItem;
    cdsMovOcorrOCO_SEQLAG: TStringField;
    cdsLeadsCateg: TUniClientDataSet;
    cdsLeadsCategCAT_DESCRI: TStringField;
    cdsLeadsCategQTD: TIntegerField;
    cdsLeadsCategQTDTOTAL: TAggregateField;
    dtsLeadsCateg: TDataSource;
    cdsGrupoOcorrQTDTOTAL: TAggregateField;
    pnlgrupos: TPanel;
    splGrpOcorrenciaCatego: TSplitter;
    pnlGrupoOcor: TPanel;
    grbGrupoOcor: TGroupBox;
    dbgGrupoOcorr: TcxGridCitel;
    dbgGrupoOcorrDBTableView1: TcxGridDBTableViewCitel;
    dbgGrupoOcorrDBTableView1IMAGEM: TcxGridDBColumn;
    dbgGrupoOcorrDBTableView1GOC_DESGOC: TcxGridDBColumn;
    dbgGrupoOcorrDBTableView1GOC_NUMTOT: TcxGridDBColumn;
    dbgGrupoOcorrLevel1: TcxGridLevel;
    pnlTotOcorr: TPanel;
    lblTotalOcorrencias: TLabel;
    dbeTotQtdOco: TDBEditFocus;
    pnlLeadsCateg: TPanel;
    grbLeadsCateg: TGroupBox;
    pnlTotLeadsCat: TPanel;
    lblTotalCategoriaLeads: TLabel;
    dbeTotCateg: TDBEditFocus;
    Panel2: TPanel;
    cxGridLeadsCateg: TcxGridCitel;
    cxGridLeadsCategView: TcxGridDBTableViewCitel;
    cxGridLeadsCategViewCAT_DESCRI: TcxGridDBColumn;
    cxGridLeadsCategViewQTD: TcxGridDBColumn;
    cxGridLeadsCategLevel1: TcxGridLevel;
    cdsMovOcorrCODCOC: TStringField;
    dbgMovOcorrDBTableViewNOMCON: TcxGridDBColumn;
    cdsMovOcorrNOMCON: TStringField;
    btnConsertoEquip: TBitBtnLocked;
    cdsMovOcorrFGO_NUMPOK: TStringField;
    dbgMovOcorrDBTableView1FGO_NUMPOK: TcxGridDBColumn;
    cdsMovOcorrCLIDOC: TStringField;
    cdsMovOcorrHIS_SITOCO: TStringField;
    dbgMovOcorrDBTableView1HIS_SITOCO: TcxGridDBColumn;
    btnCliOutroVendedor: TBitBtnLocked;
    btnCadCliente: TBitBtnLocked;
    cdsMovOcorrTELCON: TStringField;
    dbgMovOcorrDBTableViewTELCON: TcxGridDBColumn;
    pnlBtnContato: TPanel;
    btnAddContato: TBitBtnLocked;
    btnCadProspecto: TBitBtnLocked;
    btnBxEntFut: TBitBtnLocked;
    splFazendas: TSplitter;
    grbFazendas: TGroupBox;
    cxgFazendas: TcxGridCitel;
    cxgFazendasDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgFazendasLevel: TcxGridLevel;
    cxgFazendasDBTableViewCODFAZ: TcxGridDBColumn;
    cxgFazendasDBTableViewNOMFAZ: TcxGridDBColumn;
    cxgFazendasDBTableViewNOMCID: TcxGridDBColumn;
    cxgFazendasDBTableViewESTADO: TcxGridDBColumn;
    cxgFazendasDBTableViewC_E_P_: TcxGridDBColumn;
    dtsFazendas: TDataSource;
    cdsFazendas: TUniClientDataSet;
    cdsFazendasCODFAZ: TStringField;
    cdsFazendasNOMFAZ: TStringField;
    cdsFazendasNOMCID: TStringField;
    cdsFazendasESTADO: TStringField;
    cdsFazendasC_E_P_: TStringField;
    dbgMovOcorrDBTableViewCODCND: TcxGridDBColumn;
    dbgMovOcorrDBTableViewCND_DESCRI: TcxGridDBColumn;
    cdsMovOcorrCODCND: TStringField;
    cdsMovOcorrCND_DESCRI: TStringField;
    mnuGerarDANFEemPDF: TMenuItem;
    cdsMovOcorrFGO_JAFATU: TIntegerField;

    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
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
    procedure dbgClientesCLI_ENDCOMEditPropertiesButtonClick(Sender: TObject;
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
    procedure btnOrcamentoClick(Sender: TObject);
    procedure pOrcamentoClick(Sender: TObject; ACodCli, ANumLead: string);
    procedure btnPedidoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsClienteAfterScroll(DataSet: TDataSet);
    procedure btnLocalizarOcorrClick(Sender: TObject);
    procedure dbgMovOcorrDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnArquivosCadastroClick(Sender: TObject);
    procedure btnArquivosCobrancaClick(Sender: TObject);
    procedure tmrCompromissosTimer(Sender: TObject);
    procedure pnlCompromissosClick(Sender: TObject);
    procedure btnEmailDevDacClick(Sender: TObject);
    procedure dbgClientesCLI_REGTRIEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnRelADClick(Sender: TObject);
    procedure btnRelOcorrenciasCRMClick(Sender: TObject);
    procedure btnGeracaoOcorrenciasClick(Sender: TObject);
    procedure tmrHoraTimer(Sender: TObject);
    procedure btnRelSituacaoVendasCRMClick(Sender: TObject);
    procedure spnFiltroDiasChange(Sender: TObject);
    procedure dbgMovOcorrDBTableView1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mnuAbrirOcorrenciaClick(Sender: TObject);
    procedure mnuAlterarDocumentoClick(Sender: TObject);
    procedure mnuEnviarEmailClick(Sender: TObject);
    procedure mnuGerarPDFClick(Sender: TObject);
    procedure mnuCadMsgClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnuReimprimirClick(Sender: TObject);
    procedure btnFichaCadastralClick(Sender: TObject);
    procedure mnuEfetivarOrcamentoClick(Sender: TObject);
    procedure btnConsumiveisClick(Sender: TObject);
    procedure btnVendasClientesClick(Sender: TObject);
    procedure mnuGerarVendaPerdidaClick(Sender: TObject);
    procedure dbgClientesCLI_PERMFVEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnPesquisarMenusClick(Sender: TObject);
    procedure mnuDesmembrarClick(Sender: TObject);
    procedure mnuBaixarClick(Sender: TObject);
    procedure mnuRetirarVinculoReq_TransfClick(Sender: TObject);
    procedure dbgMovOcorrDBTableView1DOCCONGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure mnuDocumentosConfirmacaoClick(Sender: TObject);
    procedure btnCadLeadsClick(Sender: TObject);
    procedure BtnVendaNormalClick(Sender: TObject);
    procedure btnPesqLeadsClick(Sender: TObject);
    procedure btnRelLeadsClick(Sender: TObject);
    procedure btnPromocoesClick(Sender: TObject);
    procedure mnuAnaliseCreditoDEPSClick(Sender: TObject);
    procedure tmrSistemaDEPSTimer(Sender: TObject);
    procedure btnQuaCliClick(Sender: TObject);
    procedure mnuLimparSeparacaoClick(Sender: TObject);
    procedure mnuModificarCategoriaClick(Sender: TObject);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure dbgMovOcorrDBTableView1OCO_C_P_F_GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnMediasClienteClick(Sender: TObject);
    procedure mnuFaturarEmVendaNormalClick(Sender: TObject);
    procedure popOcorrenciasPopup(Sender: TObject);
    procedure btnVenSisAntClick(Sender: TObject);
    procedure btnHisDebClick(Sender: TObject);
    procedure btnResFinClick(Sender: TObject);
    procedure mnuAbrirLeadClick(Sender: TObject);
    procedure btnConsertoEquipClick(Sender: TObject);
    procedure btnCliOutroVendedorClick(Sender: TObject);
    procedure btnCadClienteClick(Sender: TObject);
    procedure btnAddContatoClick(Sender: TObject);
    procedure cdsContatosBeforeDelete(DataSet: TDataSet);
    procedure btnCadProspectoClick(Sender: TObject);
    procedure btnBxEntFutClick(Sender: TObject);
    procedure mnuGerarDANFEemPDFClick(Sender: TObject);
  private
    { Private declarations }
    strNLeads: String;
    strCodOco: String;
    FCodGoc: String;
    //usado para consulta emergencia
    blnEmergencial: Boolean;
    FNumLeadAutoInc: String;

    intConfirmando: Integer;
    cdsIntVen : TZClient;
    objLiberacao : TLiberacao;

    blnCadFazenda : Boolean;
    blnUtilizaSistemaDEPS: Boolean;
    blnBloquCpfCnpj: Boolean;

    procedure pAguarde(AProc: TGenericProcedure);

    procedure pPedido;
    procedure pOrcamento;
    procedure pVendaNormal;
    procedure pReimprimir;
    procedure pAlteraDocumento;

    procedure pCarregaCadCli;
    procedure pCarregaInformacoesCliente;
    procedure pSetaParametrosBotaoCliente(strNomCampo,strModulo: String; strDesCampo: string = ''; blnArqCli: Boolean = False);
    procedure pSetaParametrosBotaoProspecto(strNomCampo, strModulo: String; strDesCampo: string = ''; blnArqCli: Boolean = False);
    procedure pCarregaInformacoesContatos;
    procedure EnabledPanels;
    procedure DisablePanels;
    procedure pAdicionaMascarasCliente;
    procedure pCarregaInformacoesEnderecos;
    procedure pCarregaInformacoesGrupoOcorrencias;
    procedure pCarregaInformacoesFazendas;
    procedure pIncluirNovaOcorrencia;
    procedure pFiltraOcorrencias(strCodGoc, strCodCli: String);
    procedure pFecharDataSets;
    procedure pCriarDataSets;
    procedure pClientVazio;
    procedure pCarregaOcorrenciaAlteracao;
    procedure pIncluirNovoHistoricoOcorrenciaInternal;
    procedure pLocalizaOcorrenciaSolicitada;
    procedure pLocalizaGruposOcorrenciaSolicitada;
    procedure pLimparDataSets;
    procedure pHabilitaBotoesPanelSuperiorCrm;
    procedure pDesabilitaBotoesPanelSuperiorCrm;
    procedure pChamaConsultaOcorrenciaCRM;
    procedure pCarregaOcorrenciaEmergencial(strCodCli, strCodOpe, strCodEmp: String);
    procedure pChamaEmailDac;
    procedure pVerificaCamposVisiveisClientes;
    procedure pCamposVisiveisClientes(qrySel: TUniQuery);

    function fConsultaCliente: Boolean;
    procedure pCarregaInteligenciaDeVendas;
    procedure pExibirEfetivarOrcamento;
    procedure pExibirGerarVendaPerdida;
    procedure pExibirDesmembrar;
    procedure pExibirModificarCategoria;
    procedure pDesmembrar;
    procedure pExibirRetirarVinculoReq_Transf;
    procedure pExibirBaixar;
    procedure pExibeLimparSeparacao;
    procedure pExibirAlterar;
    procedure pConfiguraIcones(cxView: TcxGridDBTableViewCitel);
    procedure pConfiguraIconeStatus;
    procedure pTrataExibicaoMenus;
    procedure pExibirDocumentosConfirmacao;
    procedure pSetNumLead(strNumLead: String);
    procedure pExibirFaturarEmVendaNormal;
    procedure pExibirCadastroLeads;
    procedure pExibirAbrirOcorrencia;
    procedure pExibirEnviarOcoEmail;
    procedure pExibirGerarPDF;
    procedure pExibirGerarDANFEEmPDF;
    procedure pExibirReimprimir;

    procedure pExibirValidacaoSistemaDEPS;
    procedure pAtualizarStatusDEPSOrcamentos(cdsOcorrencias: TUniClientDataSet);
    function VerificarAcessoClienteOrdemDeProducaoInd: Boolean;
    procedure pCarregaDadosDoCliente;
    procedure pCarregaLeadsPorCategoria;
    procedure pAbreCadastroProspecto(Key: Word);
    procedure pAbreCadastroCliente(Key: Word);
    procedure pCarregaInformacoesOcorrencias(strCodGoc: String = '');
    procedure pSetarFocoBotao;
    procedure pGerarVendaPerdidaPadrao;
    procedure pGerarVendaPerdidaSelItens;
    procedure pGerarPDFDanfe;
    procedure pReimprimirNFCe(blnGerarPDF: Boolean = False);

    function fValidaDireitoAcessoGerarDanfe: boolean;
    function fEhEmissaoDeNotaDeServicoPeloNfeImpressao: boolean;
    function fEhEmissaoDeNotaDeProdutoPeloNfeImpressao: boolean;
    function fEhEmissaoDeCupomFiscalPeloNfeImpressao: boolean;
    procedure pLimparCliente;
    function fLiberouTravaProdutoVinculadoLoteSeparacao(arrPedidos: TStringArray): Boolean;
    function fPedidoPossuiItensEmSemparacao: Boolean;

  protected
    function getCodGoc: String;

    procedure setCodGoc(const Value: String);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pDesabilitaMenusBotoesLiberaPedido;
    procedure pDesabilitaMenusLiberaPedido;
    procedure pDesabilitaBotoesLiberaPedido;
  public
    blnProspecto : Boolean;
    blnLiberaPedido: Boolean;
    property strCodGoc: String Read getCodGoc Write setCodGoc;
  end;

implementation

uses untCadClientes, untCadMovOcorrencias, untPrincipal, untConsultaOcorrenciasCRM,
     untConsultaOcorrenciasCRMEmergenciais, untCompromissos, untEnviarEmailDac,
     untGravaArquivoPasta, untConstantes, untFuncoesCRM,untFuncoesGenerica,
     untFuncoesSimples, untConsultas, untPesqAux,
     untRelOcorrenciasCRM, untCRMGeracaoGlobal, untPesquisarMenu,
     untRelSituacaoVendasCRM, untDigEmailPedOrc, untFuncoesEditorFast,
     untDigEmailPedOrcEditor, untFatGorEmail, untGeraPDFPedOrc, untTEnvioEmail,
     untCadMsg, untFuncFat, untCRMGeracaoGlobalProspecto, untMovGer,
     untCadProspectos, untFatEfetivarItensOrcamentoEmPedido, untCadRcxx,
     untFuncoes, untImpulsionadorVendasCRM, untInterfaceRelatorio,
     untConsultaPedidos, untFuncoesOcorrenciasCRM, untTSituacaoPedidoVenda,
     cxImageComboBox, untMensagemExplicativa, untGravando,
     untCadLeads, untMsgLiberacao, untFatMenuPrecoQtde,
     untValidacoesSistemaDEPS, untFatSelItensCatalogoPromocoes, untFatGor,
     untCRMMedias, untFatConsVendasAntigas, untConsultaLeadsCRM, untResFinanceiro,
     untIDocumento, untDocumento, untFuncoesAuxiliares, untCategoriaCadLead,
     untFuncIns, untFatManConsertoEquip, untFatManConsertoFluxoProcesso, untFatDigCnpj,
     untFatBaixaEntregaFutura, untFatImpressao, untLibNfe, untQckFatImpNFCe,
     VirtualUI_SDK, untCfgRel, untRomLge;

{$R *.dfm}

type
  TcxTableControllerAccess = class(TcxGridTableController);

function TfrmCRM.fConsultaCliente: Boolean;
Var
  strCodVen   : String;
  FTipoConsCli : TTipoConsCli;
  FTipoConsPro : TTipoConsPro;
  blnTrava: Boolean;
  blnBloqu: Boolean;
  blnLiberarTrava : Boolean;
  blnConsumidor: Boolean;
begin
  Result := True;

  Try
    FTipoConsCli := fStrToTipoConsCli( fCfgSis('CRMCVI', varString) );
    FTipoConsPro := fStrToTipoConsPro( fCfgSis('CRMPVI', varString) );

    pCarregaCadCli;
    If fEmptyStr(edtDesCodCli.Text) Then
    Begin
      If blnProspecto then
        fMensagem('ATENÇÃO!', 'Esse prospecto não está cadastrado ou já foi ativado para o cadastro de clientes!', ['&Ok'])
      Else
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);

      pLimparDataSets;
      edtCodCli.SelectAll;
      pSetFocus(edtCodCli);
      Result := False;
    End
    Else
    Begin
      blnConsumidor := fClienteConsumidor(fRetNomCliente(edtCodCli.Text));
      blnLiberarTrava := blnConsumidor or (FTipoConsCli = tpTodosCli);
      blnTrava := (Not blnConsumidor) And (FTipoConsCli = tpCliVenCad);
      blnBloqu := (Not blnConsumidor) And (FTipoConsCli in [tpCliVenLog, tpCliVenLogVenEsp]);

      If blnProspecto And (Not blnLiberarTrava) Then
      Begin
        Case FTipoConsPro Of
          tpProVenCad   : Begin
                            strCodVen := fCampoTabela('PRO_CODVEN', 'PROSPE', ['PRO_CODPRO'], [edtCodCli.Text]);
                            Result := (Not fEmptyStr(strCodVen)) And (strCodVen = strLoginUsuarioLogado);
                            blnTrava := Not (Result);
                          End;
          tpProVenLog   : Begin
                            strCodVen := fCampoTabela('PRO_CODVEN', 'PROSPE', ['PRO_CODPRO'], [edtCodCli.Text]);
                            Result := (Not fEmptyStr(strCodVen)) And (strCodVen = strLoginUsuarioLogado);
                            blnBloqu := Not (Result);
                          End;
          tpLibProVenLog :Begin
                            If Not blnBloquCpfCnpj Then
                              Result := True
                            Else
                            Begin
                              strCodVen := fCampoTabela('PRO_CODVEN', 'PROSPE', ['PRO_CODPRO'], [edtCodCli.Text]);
                              Result := (Not fEmptyStr(strCodVen)) And (strCodVen = strLoginUsuarioLogado);
                              blnBloquCpfCnpj := (Not Result);
                              blnTrava := Not (Result);
                            End;
                          End;
        End;
      End
      Else
      Begin
        If (Not blnLiberarTrava) Then
          Case FTipoConsCli Of
            tpCliVenCad       : Begin
                                  strCodVen := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);
                                  Result := (Not fEmptyStr(strCodVen)) And ((strCodVen = strLoginUsuarioLogado) Or (Pos(strCodVen, fGetVendedoresGerentesOrSUBGerentes()) > 0));;
                                  blnTrava := Not (Result);
                                End;
            tpCliVenLog       : Begin
                                  strCodVen := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);
                                  Result := (Not fEmptyStr(strCodVen)) And ((strCodVen = strLoginUsuarioLogado) Or (Pos(strCodVen, fGetVendedoresGerentesOrSUBGerentes()) > 0));
                                  blnBloqu := Not (Result);
                                End;
            tpLibCliVenLog    : Begin
                                  If Not blnBloquCpfCnpj Then
                                    Result := True
                                  Else
                                  Begin
                                    strCodVen := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);
                                    Result := (Not fEmptyStr(strCodVen)) And ((strCodVen = strLoginUsuarioLogado) Or (Pos(strCodVen, fGetVendedoresGerentesOrSUBGerentes()) > 0));
                                    blnBloquCpfCnpj := (Not Result);
                                    blnBloqu        := False;
                                  End;
                                End;
            tpCliVenLogVenEsp : Begin
                                  strCodVen := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);
                                  Result := (Not fEmptyStr(strCodVen)) And (((strCodVen = strLoginUsuarioLogado) Or (Pos(strCodVen, fGetVendedoresGerentesOrSUBGerentes()) > 0)) Or (strCodven = fCfgSis('VENESP', varString)));
                                  blnBloqu := Not (Result);
                                End;
          End;
      End;

      If blnTrava Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Acessar CRM do ' + IfThen(not blnProspecto,'Cliente','Prospecto') + ' de outro vendedor ');
        objLiberacao.objMsgLibera.pAddTextoCaption(IfThen(not blnProspecto,'Cliente','Prospecto'), edtCodCli.Text + ' - ' + edtDesCodCli.Text);
        objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor cadastrado'                         , strCodVen + '  - ' + fRetNomVendRep(strCodVen));
        objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor Atual'                              , strLoginUsuarioLogado + '  - ' + fRetNomVendRep(strLoginUsuarioLogado));

        objLiberacao.strDirAce := IfThen(not blnProspecto,'CRMVCL','CRMVPR');
        objLiberacao.strMsgSen := 'Acessar CRM do ' + IfThen(not blnProspecto,'Cliente','Prospecto') + ' de outro vendedor';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      End;

      If blnBloqu Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', IIF(blnProspecto,
                                  'Não é permitido utilizar prospectos de outros vendedores (CFG_CRMPVI).',
                                  'Não é permitido utilizar clientes de outros vendedores (CFG_CRMCVI).'
                                  ), ['&Ok']);
        Exit;
      End;

      If blnBloquCpfCnpj And (Not blnLiberarTrava) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', IIF(blnProspecto,
                                  'Não é permitido utilizar prospectos de outros vendedores (CFG_CRMPVI). Informe o CPF/CNPJ através do botão "Prospecto outro vendedor" para prosseguir.',
                                  'Não é permitido utilizar clientes de outros vendedores (CFG_CRMCVI). Informe o CPF/CNPJ através do botão "Cliente de outro vendedor" para prosseguir.'
                                  ), ['&Ok']);
        Exit;
      End;

    End;

    If Result then
    begin
      TfrmGravando.fExecutarModalA(pCarregaDadosDoCliente, 'Aguarde, carregando informações ...', '');
      EnabledPanels;
    end;

  Except
    On E : Exception Do
    Begin
      pClientVazio;
      pMensagensErro(E.Message + #13#10 + 'Não foi possível carregar as informações do Cliente!', 'TfrmCRM.fConsultaCliente');
      Result := False;
    End;
  End;

end;

function TfrmCRM.fEhEmissaoDeNotaDeProdutoPeloNfeImpressao: boolean;
begin
  Result := fCfgSis('CITINF', varBoolean) and (cdsMovOcorrESPDOC.AsString = 'NF');
end;

function TfrmCRM.fEhEmissaoDeNotaDeServicoPeloNfeImpressao: boolean;
begin
  If (fCfgSis('NFSENO', varBoolean)) And (Not fPrefeituraComLayoutNfse(fCfgSis('CIDNFS'))) Then
    Result := fCfgSis('IMPNFS', varBoolean) and (cdsMovOcorrESPDOC.AsString = 'NS')
  Else
    Result := (fCfgSis('IMPNFS', varBoolean)) and (fPrefeituraComLayoutNfse(fCfgSis('CIDNFS'))) and (cdsMovOcorrESPDOC.AsString = 'NS');
end;

function TfrmCRM.fEhEmissaoDeCupomFiscalPeloNfeImpressao: boolean;
begin
  Result := fCfgSis('PRNFCE', varBoolean) and (cdsMovOcorrESPDOC.AsString = 'IF');
end;

procedure TfrmCRM.pCarregaDadosDoCliente;
begin
  dbgMovOcorrDBTableView1.DataController.DataSource   := nil;
  dbgGrupoOcorrDBTableView1.DataController.DataSource := nil;

  Try
    pCarregaInformacoesCliente;

    If not blnProspecto Then
    Begin
      pCarregaInformacoesContatos;
      pCarregaInformacoesEnderecos;
    End;

    If blnCadFazenda Then
      pCarregaInformacoesFazendas;

    pCarregaInformacoesGrupoOcorrencias;
    cdsGrupoOcorrAfterScroll(cdsGrupoOcorr);

    if not blnEmergencial then
      pCarregaOcorrenciaEmergencial(cdsClienteCLI_CODCLI.AsString, strLoginUsuarioLogado,VS_strCodEmp);

    pCarregaInteligenciaDeVendas;
    pCarregaLeadsPorCategoria;
  Finally
    dbgMovOcorrDBTableView1.DataController.DataSource   := dtsMovOcorr;
    dbgGrupoOcorrDBTableView1.DataController.DataSource := dtsGrupoOcorr;
  End;
end;

procedure TfrmCRM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fGetFuncoesCxGrid.pSalvarView(dbgGrupoOcorrDBTableView1, self.Name + '_dbgGrupoOcorrDBTableView1_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgGrupoOcorrDBTableView1.DataController.DataSet, False);
  fGetFuncoesCxGrid.pSalvarView(cxGridLeadsCategView, self.Name + '_cxGridLeadsCategView_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, cxGridLeadsCategView.DataController.DataSet, False);
  Try
    dbgMovOcorrDBTableView1NumDoc.Visible := True;
    fGetFuncoesCxGrid.pSalvarView(dbgMovOcorrDBTableView1,   self.Name + '_dbgMovOcorrDBTableView1_'   + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgMovOcorrDBTableView1.DataController.DataSet,   False);
  Finally
    dbgMovOcorrDBTableView1NumDoc.Visible := False;
  End;

  fGetFuncoesCxGrid.pSalvarView(cxgIntVenDBTableViewCitel, self.Name + '_cxgIntVenDBTableViewCitel_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, cxgIntVenDBTableViewCitel.DataController.DataSet, False);
  fGetFuncoesCxGrid.pSalvarView(dbgEnderecosDBTableView1,  self.Name + '_dbgEnderecosDBTableView1_'  + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgEnderecosDBTableView1.DataController.DataSet,  False);
  fGetFuncoesCxGrid.pSalvarView(dbgContatosDBTableView1,   self.Name + '_dbgContatosDBTableView1_'   + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgContatosDBTableView1.DataController.DataSet,   False);

  pFecharDataSets;
//  fAtuCfgSis('DIAOCO', spnFiltroDias.Value.ToString);
end;

procedure TfrmCRM.FormCreate(Sender: TObject);
  Var
    intRecNo : Integer;
begin
  inherited;
  strNLeads := '';
  objLiberacao := TLiberacao.Create;

  spnFiltroDias.Value := fCfgSis('DIAOCO', varInteger);

  blnProspecto := False;
  blnLiberaPedido := False;

  blnEmergencial := False;
  intConfirmando := -1;
  pCriarDataSets;
  cxZebra.Color := fCfgSis('CORZEB', varInteger);

  pnlOperador.Caption := strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;
  cdsIntVen := TZClient.Create(Self);

  pConfiguraIconeStatus;

  dbgMovOcorrDBTableView1STATUS.Visible := False;
  dbgMovOcorrDBTableView1DOCCON.Visible := False;

  btnQuaCli.Visible := fCfgSis('USAQUA', varBoolean);

  pConfiguraPopup(btnRelAd);
  pConfiguraPopup(btnRelOcorrenciasCRM);
  pConfiguraPopup(btnRelSituacaoVendasCRM);
  pConfiguraPopup(btnVendasClientes);

  intRecNo := dbgGrupoOcorrDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgGrupoOcorrDBTableView1, self.Name + '_dbgGrupoOcorrDBTableView1_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgGrupoOcorrDBTableView1.DataController.DataSet, intRecNo, False);

  intRecNo := dbgMovOcorrDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgMovOcorrDBTableView1, self.Name + '_dbgMovOcorrDBTableView1_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgMovOcorrDBTableView1.DataController.DataSet, intRecNo, False);
  dbgMovOcorrDBTableView1NumDoc.Visible := False;

  intRecNo := cxgIntVenDBTableViewCitel.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(cxgIntVenDBTableViewCitel, self.Name + '_cxgIntVenDBTableViewCitel_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, cxgIntVenDBTableViewCitel.DataController.DataSet, intRecNo, False);

  intRecNo := dbgEnderecosDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgEnderecosDBTableView1, self.Name + '_dbgEnderecosDBTableView1_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgEnderecosDBTableView1.DataController.DataSet, intRecNo, False);

  intRecNo := dbgContatosDBTableView1.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(dbgContatosDBTableView1, self.Name + '_dbgContatosDBTableView1_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, dbgContatosDBTableView1.DataController.DataSet, intRecNo, False);

  intRecNo := cxGridLeadsCategView.DataController.DataSet.RecNo;
  fGetFuncoesCxGrid.fCarregarView(cxGridLeadsCategView, self.Name + '_cxGridLeadsCategView_' + IfThen(blnProspecto,'_P_','') + strLoginUsuarioLogado, cxGridLeadsCategView.DataController.DataSet, intRecNo, False);


end;

procedure TfrmCRM.FormDestroy(Sender: TObject);
begin
  If Assigned(dbgMovOcorrDBTableView1) Then
    TcxTableControllerAccess(dbgMovOcorrDBTableView1.Controller).StopPullFocusing;

  FreeAndNil(cdsIntVen);
  if assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Shift = ([ssAlt])) Then
  Begin
    If (Key = VK_F12) And (btnRelLeads.Visible) and (not blnLiberaPedido) Then
      btnRelLeads.Click;

    If ((Key = Ord('P')) Or (Key = Ord('p'))) and (not blnLiberaPedido) Then
      btnPromocoes.Click;

    If ((Key =  Ord('C')) Or (Key = Ord('c'))) and (btnCadCliente.Visible) Then
      btnCadCliente.Click;

    If ((Key =  Ord('T')) Or (Key = Ord('t'))) and (btnCadProspecto.Visible) Then
      btnCadProspecto.Click;

    If ((Key = Ord('B')) Or (Key = Ord('b'))) and (Not blnProspecto) Then
      btnBxEntFut.Click;

  End;

  If (Shift = ([ssCtrl])) Then
  Begin
    case Key of
      VK_F6 : Begin
                If btnHisDeb.Enabled Then
                  btnHisDeb.Click;
              End;
      VK_F7 : Begin
               If btnResFin.Enabled Then
                btnResFin.Click;
              End;
      VK_F12: Begin
                If (btnCadLeads.Visible) and (not blnLiberaPedido) Then
                  btnCadLeads.Click;
              End;
      VK_F11: Begin
                If (btnPesqLeads.Visible) and (not blnLiberaPedido) Then
                  btnPesqLeads.Click;
              End;
      86  :   Begin
                If ((BtnVendaNormal.Visible) and (not blnLiberaPedido)) Then
                   BtnVendaNormal.Click;
              End;
      VK_F9 : Begin
                If (btnConsertoEquip.Visible) and (not blnLiberaPedido) Then
                  btnConsertoEquip.Click;
              End;
      76    : Begin
                btnPesquisarMenus.Click;
              End;

    end;
  End;

  If Shift = [] Then
  Begin
    Case Key Of
      VK_F1: btnNovaOcorrencia.Click;
      VK_F2: if not blnLiberaPedido then
             begin
               btnOrcamento.Click;
             end;
      VK_F3: if not blnLiberaPedido then
             begin
               btnPedido.Click;
             end;
      VK_F4: btnLocalizarOcorr.Click;
      VK_F5: btnEmailDevDac.Click;
      VK_F7: btnRelAD.Click;
      VK_F8: btnRelOcorrenciasCRM.Click;
      VK_F9: if not blnLiberaPedido then
             begin
               btnGeracaoOcorrencias.Click;
             end;
      VK_F10: btnRelSituacaoVendasCRM.Click;
      VK_F11: mnuCadMsg.Click;
      VK_F12: if not blnLiberaPedido then
              begin
                btnConsumiveis.Click;
              end;
    End;
  End;

  If (Key = VK_Insert) Then
  Begin
    If Not edtCodCli.Focused Then
      Exit;

    If (edtCodCli.ReadOnly) Then
      Exit;

    If blnProspecto Then
      pAbreCadastroProspecto(Key)
    Else
      pAbreCadastroCliente(Key);
  End;
end;

procedure TfrmCRM.pAbreCadastroProspecto(Key: Word);
var
  strCodTmp: String;
Begin
  strCodTmp := EmptyStr;
  edtCodCli.ReadOnly := True;
  Try
    If Not fVerificaAcessoSistema('frmCadProspectos') Then
      Exit;

    If Not fEmptyStr(edtCodCli.Text) Then
      strCodTmp := fCampoTabela('PRO_CODPRO', 'PROSPE', ['PRO_CODPRO'], [fStrZero(edtCodCli.Text, 8)]);

    If fEmptyStr(strCodTmp) Then
      strCodTmp := untFuncIns.fChamaCadProspecto(Key)
    Else
      strCodTmp := TfrmCadProspectos.fAlteraCadProspecto(strCodTmp);

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodCli.Text := strCodTmp;
      edtDesCodCli.Text := fRetNomProspecto(edtCodCli.Text);
    End;
  Finally
    edtCodCli.ReadOnly := False;
  End;
End;

procedure TfrmCRM.pAbreCadastroCliente(Key: Word);
var
  strCodTmp: String;
Begin
  strCodTmp := EmptyStr;
  edtCodCli.ReadOnly := True;
  Try
    If Not fVerificaAcessoSistema('frmCadClientes', strLoginUsuarioLogado) Then
      Exit;

    If Not fEmptyStr(edtCodCli.Text) Then
      strCodTmp := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI'], [fStrZero(edtCodCli.Text, 8)]);

    If fEmptyStr(strCodTmp) Then
      strCodTmp := fChamaCadCli(Key)
    Else
      strCodTmp := TfrmCadClientes.fAlteraCadCli(fStrZero(edtCodCli.Text, 8));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodCli.Text := strCodTmp;
      edtDesCodCli.Text := fRetNomCliente(edtCodCli.Text);
    End;

  Finally
    edtCodCli.ReadOnly := False;
  End;
End;

procedure TfrmCRM.FormShow(Sender: TObject);
var
  objCategoriaCadLead: TCategoriaCadLead;
begin
  inherited;

  btnCliOutroVendedor.Visible :=  ((fCfgSis('CRMCVI', varString) = 'L') And (Not blnProspecto)) Or
                                  ((fCfgSis('CRMPVI', varString) = 'L') And blnProspecto);

  If Not btnCliOutroVendedor.Visible Then
  Begin
    btnVendasClientes.Left := btnVendasClientes.Left - btnCliOutroVendedor.Width;
    btnVenSisAnt.Left := btnVenSisAnt.Left - btnCliOutroVendedor.Width;
    btnQuaCli.Left := btnQuaCli.Left - btnCliOutroVendedor.Width;
    btnMediasCliente.Left := btnMediasCliente.Left - btnCliOutroVendedor.Width;
    lblCgcCpf.Left := lblCgcCpf.Left - btnCliOutroVendedor.Width;
    edtCgcCpf.Left := edtCgcCpf.Left - btnCliOutroVendedor.Width;
    mskNumCgc.Left := mskNumCgc.Left - btnCliOutroVendedor.Width;
  End;
  blnBloquCpfCnpj := btnCliOutroVendedor.Visible;

  BtnVendaNormal.Visible := (fVerificaAcessoSistema('CRMVDN')) and (not blnProspecto);
  btnPromocoes.Visible   := (fVerificaAcessoSistema('CRMPRM')) and (not blnProspecto);
  btnRelAD.Visible              := not blnProspecto And fVerificaAcessoSistema('CRMRAD');
  btnEmailDevDac.Visible        := not blnProspecto And fVerificaAcessoSistema('CRMEMA');
  btnPedido.Visible             := not blnProspecto And fVerificaAcessoSistema('CRMPED');
  pnlBotoesCadCli.Visible       := not blnProspecto;
  btnVendasClientes.Visible     := not blnProspecto;
  btnOrcamento.Visible          := fVerificaAcessoSistema('CRMBOR');
  btnRelOcorrenciasCRM.Visible  := fVerificaAcessoSistema('CRMROC');
  btnRelSituacaoVendasCRM.Visible := fVerificaAcessoSistema('CRMRSV');
  mnuCadMsg.Visible             := fVerificaAcessoSistema('CRMMEN');
  btnNovaOcorrencia.Visible     := fVerificaAcessoSistema('CRMBOC');
  btnLocalizarOcorr.Visible     := fVerificaAcessoSistema('CRMLOC');
  btnGeracaoOcorrencias.Visible := fVerificaAcessoSistema('CRMGGO');

  If (Not btnVendasClientes.Visible) Then
  Begin
    btnMediasCliente.Left := btnQuaCli.Left;
    btnQuaCli.Left := btnVenSisAnt.Left;
    btnVenSisAnt.Left := btnVendasClientes.Left;
  End;

  btnVenSisAnt.Visible := (not blnProspecto) and (fCfgSis('SISANT', varBoolean));
  If (Not btnVenSisAnt.Visible) Then
  Begin
    btnMediasCliente.Left := btnQuaCli.Left;
    btnQuaCli.Left := btnVenSisAnt.Left;
  End;

  If Not btnQuaCli.Visible Then
    btnMediasCliente.Left := btnQuaCli.Left;

  btnCliOutroVendedor.Caption := IIF(blnProspecto, 'Prospecto outro vendedor', 'Cliente de outro vendedor');

  dbgClientesCLI_I_M_P_.Visible := not blnProspecto;
  dbgClientesCLI_RAMAL1.Visible := not blnProspecto;
  dbgClientesCLI_RAMAL2.Visible := not blnProspecto;
  dbgClientesCLI_RAMAL3.Visible := not blnProspecto;
  dbgClientesCLI_CONSUM.Visible := not blnProspecto;
  dbgClientesCLI_NOMREP.Visible := not blnProspecto;
  dbgClientesCLI_NOMSGE.Visible := not blnProspecto;
  dbgClientesCLI_NOMSRE.Visible := not blnProspecto;
  dbgClientesCLI_DESATI.Visible := not blnProspecto;
  dbgClientesCLI_TABPRE.Visible := not blnProspecto;
  dbgClientesCLI_LIMCRE.Visible := not blnProspecto;
  dbgClientesCLI_DESFPG.Visible := not blnProspecto;
  dbgClientesCLI_DESTCL.Visible := not blnProspecto;
  dbgClientesCLI_DESPOR.Visible := not blnProspecto;
  dbgClientesCLI_DESCON.Visible := not blnProspecto;
  dbgClientesCLI_PERCOM.Visible := not blnProspecto;
  dbgClientesCLI_PEREMP.Visible := not blnProspecto;
  dbgClientesCLI_NOMDIV.Visible := not blnProspecto;
  dbgClientesCLI_NOMRED.Visible := not blnProspecto;
  dbgClientesCLI_ATRMAX.Visible := not blnProspecto;
  dbgClientesCLI_PERMFF.Visible := not blnProspecto;
  dbgClientesCLI_PERMFV.Visible := not blnProspecto;
  dbgClientesCLI_NOMERC.Visible := not blnProspecto;
  dbgClientesCLI_REGTRI.Visible := not blnProspecto;
  splCliCon.Visible             := not blnProspecto;
  pnlContato.Visible            := not blnProspecto;

  If blnProspecto Then
  Begin
    Self.Caption := 'CRM - Prospecto';
    GroupBox1.Caption := 'Consulta Prospecto';
    grbCliente.Caption:= 'Prospecto';
    If fStrToFloat(fCadEmp('CRMPRO')) > 0 Then
      Self.Color := StrToIntDef(fCadEmp('CRMPRO'), $00FFE4D5);
  End
  Else
  Begin
    Self.Caption := 'CRM - Cliente';
    If fStrToFloat(fCadEmp('CRMCLI')) > 0 Then
      Self.Color := StrToIntDef(fCadEmp('CRMCLI'), $00FFE4D5);
  End;

  blnUtilizaSistemaDEPS := fCfgSis('USADEP') = 'S';

  dbgMovOcorrDBTableView1STATUSDEPS.Visible := blnUtilizaSistemaDEPS;

  btnConsumiveis.Visible := (Not blnProspecto) And fVerificaAcessoSistema('CRMOCN');
  btnCadLeads.Visible    := fCfgSis('ULEADS', varBoolean) And (not blnProspecto) And VerificarAcessoClienteOrdemDeProducaoInd;
  btnPesqLeads.Visible   := btnCadLeads.Visible;
  btnRelLeads.Visible    := btnCadLeads.Visible;

  DisablePanels;
  pSetFocus(edtCodCli);

  if blnLiberaPedido then
  begin
    fValidaCampos(edtCodCli, True);
    edtCodCli.Enabled := False;
    pDesabilitaMenusBotoesLiberaPedido;
  end;

  dbgMovOcorrDBTableView1CAT_DESCRI.Visible := fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);
  dbgMovOcorrDBTableView1CAT_CORCAT.Visible := fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);

  pnlLeadsCateg.Visible := False;
  splGrpOcorrenciaCatego.Visible := False;

  If Not blnProspecto Then
  Begin
    objCategoriaCadLead:= TCategoriaCadLead.Create;
    Try
      objCategoriaCadLead.blnUtiCat:= fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);
      pnlLeadsCateg.Visible := objCategoriaCadLead.fExibeCategoriaNaTelaLead;
      splGrpOcorrenciaCatego.Visible := objCategoriaCadLead.fExibeCategoriaNaTelaLead;
    Finally
      FreeAndNil(objCategoriaCadLead);
    End;
  End;

  btnConsertoEquip.Visible := fCfgSis('CONEQU', varBoolean);
  btnCadCliente.Visible := Not blnProspecto;
  btnCadProspecto.Visible := blnProspecto;
  btnCadCliente.Enabled := fVerificaAcessoSistema('frmCadClientes');
  btnCadProspecto.Enabled :=  fVerificaAcessoSistema('frmCadProspectos');

  btnBxEntFut.Visible := fCfgSis('ENTFUT', varBoolean) And (Not blnProspecto);
  If btnBxEntFut.Visible Then
  Begin
    If btnMediasCliente.Visible Then
      btnBxEntFut.Left := btnMediasCliente.Left + btnMediasCliente.Width + 2;
  End;

  blnCadFazenda := fCfgSis('CADFAZ', varBoolean);
  If blnCadFazenda Then
  Begin
    pnlFazendas.Visible := True;
    splFazendas.Visible := True;
  End;
end;

function TfrmCRM.fPedidoPossuiItensEmSemparacao: Boolean;
var
  LQry: TUniQuery;
begin
  if (cdsMovOcorrOCO_ESPDOC.AsString = 'OR') then
    Exit(False);

  LQry := fCriaQuery();

  try
    LQry.SQL.Add(TGetSQLStatus.New(statusPedido).sqlEmSeparacao);
    LQry.ParamByName('NUMDOC').AsString := cdsMovOcorrOCO_NUMDOC.AsString;
    LQry.ParamByName('ESPDOC').AsString := cdsMovOcorrOCO_ESPDOC.AsString;
    LQry.ParamByName('CODEMP').AsString := cdsMovOcorrOCO_EMPDOC.AsString;
    LQry.Open();

    Result := (LQry.FieldByName('QTDE').AsInteger > 0);
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtCodCli) Then
      Begin
        If (fEmptyStr(edtCodCli.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do '+ IfThen(blnProspecto, 'Prospecto', 'Cliente') +' deve ser preenchido!', ['&Ok']);
          pLimparDataSets;
          Result := False;
        End
        Else
        Begin

          If blnBuscaPorChave Then
            blnEmergencial := False;
          Result := fConsultaCliente;
        End;

        If Result Then
        Begin
          pSetarFocoBotao;
        End
        Else
          mskNumCgc.Clear;
      End

      Else If (Sender = mskNumCgc) Then
      Begin
        If mskNumCgc.Visible And Not fEmptyStr(mskNumCgc.Text) Then
        Begin
          Result := fValidaCnpjCpf(edtCgcCpf.Text, mskNumCgc.Text);

          cdsMovOcorr.Filtered := False;
          cdsMovOcorr.Filter   := 'OCO_C_P_F_ = ' + QuotedStr(mskNumCgc.Text);
          cdsMovOcorr.Filtered := Result;
        End
        Else
          cdsMovOcorr.Filtered := False;
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
			pMensagensErro(E.Message,'[TfrmCadClientes.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmCRM.fValidaDireitoAcessoGerarDanfe: boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'GEDANFRD';
  objLiberacao.strMsgSen    := 'Permitir Gerar Danfe em PDF na Reimpressão de Documentos.';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  {objLiberacao.objMsgLibera.pAddTexto('Permitir Gerar Danfe em PDF nas ocorrências do CRM.' + sLineBreak +
                                      cdsGenDoc.FieldByName('ESPDOC').AsString + ': ' +
                                      cdsGenDoc.FieldByName('NUMDOC').AsString + '-' +
                                      cdsGenDoc.FieldByName('ESPDOC').AsString + '-' +
                                      cdsGenDoc.FieldByName('CODEMP').AsString);

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    cdsGenDoc.FieldByName('NUMDOC').AsString,
                    cdsGenDoc.FieldByName('ESPDOC').AsString,
                    cdsGenDoc.FieldByName('CODEMP').AsString);}

  Result := objLiberacao.fLibera;
end;

procedure TfrmCRM.mnuGerarDANFEemPDFClick(Sender: TObject);
begin
  inherited;
  pGerarPDFDanfe;
end;

procedure TfrmCRM.pReimprimirNFCe(blnGerarPDF: Boolean = False);
  Var
    strAcesso: String;
    strSerie: String;
    strImpressora: String;
    strPathDllDaruma: String;
begin
  Try
    strSerie := fCampoTabela('GER_SERIE_', 'MOVGER',
                              ['GER_NUMDOC',
                                'GER_ESPDOC',
                                'GER_CODEMP',
                                'GER_CODCLI'],
                              [cdsMovOcorrOCO_NUMDOC.AsString,
                                cdsMovOcorrOCO_ESPDOC.AsString,
                                cdsMovOcorrOCO_CODEMP.AsString,
                                cdsMovOcorrOCO_CODCLI.AsString]);

    strAcesso := fRetornaChaveAcesso(cdsMovOcorrOCO_NUMDOC.AsString,
                                     cdsMovOcorrOCO_ESPDOC.AsString,
                                     cdsMovOcorrOCO_CODEMP.AsString,
                                     cdsMovOcorrOCO_CODCLI.AsString,
                                     strSerie,
                                     'C');

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
      pImprimirNFCe(cdsMovOcorrOCO_NUMDOC.AsString,
                    cdsMovOcorrOCO_ESPDOC.AsString,
                    cdsMovOcorrOCO_CODEMP.AsString,
                    cdsMovOcorrOCO_CODCLI.AsString,
                    strSerie,
                    'C',
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

procedure TfrmCRM.pGerarPDFDanfe();
  Var
    strAcesso: String;
    strSerie: String;
    libNfe: TLibNfe;
    strDirCompleto : String;
    srtNfeImpressaoExe: String;
    strEmpresa: String;
    strDiretorioDanfe: String;
begin
  inherited;

  If (Not fVerificaAcessoSistema('GEDANFRD')) Then
    If Not fValidaDireitoAcessoGerarDanfe Then
      Exit;

  strSerie := fCampoTabela('GER_SERIE_', 'MOVGER',
                            ['GER_NUMDOC',
                              'GER_ESPDOC',
                              'GER_CODEMP',
                              'GER_CODCLI'],
                            [cdsMovOcorrOCO_NUMDOC.AsString,
                              cdsMovOcorrOCO_ESPDOC.AsString,
                              cdsMovOcorrOCO_CODEMP.AsString,
                              cdsMovOcorrOCO_CODCLI.AsString]);

  strAcesso := fRetornaChaveAcesso(cdsMovOcorrOCO_NUMDOC.AsString,
                                   cdsMovOcorrOCO_ESPDOC.AsString,
                                   cdsMovOcorrOCO_CODEMP.AsString,
                                   cdsMovOcorrOCO_CODCLI.AsString,
                                   strSerie,
                                   'C');

  If fEmptyStr(strAcesso) Then
  Begin
    pMensagemOk('Esta nota não é uma NFe ou ainda não foi autorizada.');
    Exit;
  End;

  strAcesso := fRetornaChaveAcesso(cdsMovOcorrOCO_NUMDOC.AsString,
                                   cdsMovOcorrOCO_ESPDOC.AsString,
                                   cdsMovOcorrOCO_CODEMP.AsString,
                                   cdsMovOcorrOCO_CODCLI.AsString,
                                   strSerie,
                                   'C');

  If fEmptyStr(strAcesso) Then
  Begin
    pMensagemOk('Esta nota não é uma NFe ou ainda não foi autorizada.');
    Exit;
  End;

  strDiretorioDanfe := fRetornaDiretorioDanfe;

  strEmpresa := cdsMovOcorrOCO_CODEMP.AsString;
  If fEmptyStr(strEmpresa) Then
    strEmpresa := VS_strCodEmp;

  Try
    If Not DirectoryExists(strDiretorioDanfe) Then
      CreateDir(strDiretorioDanfe);

    strDirCompleto := strDiretorioDanfe + 'Tela' + strAcesso + '.pdf';

    If (cdsMovOcorrOCO_ESPDOC.AsString = 'IF') And (Not fCfgSis('PRNFCE', varBoolean)) Then
    Begin
      pReimprimirNFCe(True);
      Exit;
    End;

    If fCfgSis('CITINF', varBoolean) Then
    Begin
      srtNfeImpressaoExe := TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel;
      If Not FileExists(srtNfeImpressaoExe) Then
      Begin
        fMensagem('', 'Não foi encontrado o arquivo NFeImpressao.exe para a impressão.' + #13#10 +
                      'Arquivo informado:' + srtNfeImpressaoExe, ['&O k']);
        Exit;
      End;
    End;

    If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao or fEhEmissaoDeNotaDeProdutoPeloNfeImpressao or fEhEmissaoDeCupomFiscalPeloNfeImpressao) Then
    Begin

      If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao) Then
        TImpressaoDiretaCitel.pImprimirPDF(strEmpresa,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFS',
                                           True,
                                           strDirCompleto,
                                           True)

      Else

      If (fEhEmissaoDeCupomFiscalPeloNfeImpressao) Then
        TImpressaoDiretaCitel.pImprimirPDF(strEmpresa,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFCE',
                                           True,
                                           strDirCompleto,
                                           True)
      Else

        TImpressaoDiretaCitel.pImprimirPDF(strEmpresa,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFE',
                                           True,
                                           strDirCompleto,
                                           True)
    End
    Else
    Begin

      libNfe := TLibNfe.Create(strEmpresa);
      Try
        Try
          libNfe.pReimprimirDanfe(strAcesso, '', strSerie, 'TelaPDF');
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmCRM.pGerarPDFDanfe]');
          End;
        End;
      Finally
        FreeAndNil(libNfe);
      End;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCRM.pGerarPDFDanfe]');
    End;
  End;
end;

function TfrmCRM.getCodGoc: String;
begin
  Result := FCodGoc;
end;

procedure TfrmCRM.mnuAbrirLeadClick(Sender: TObject);
begin
  inherited;

  If cdsMovOcorr.IsEmpty Then
    Exit;

  If Not fEmptyStr(FNumLeadAutoInc) Then
  Begin
    TfrmCadLeads.fCadLeads(edtCodCli.Text, pOrcamentoClick, pSetNumLead, FNumLeadAutoInc);
  End;
end;

procedure TfrmCRM.mnuAbrirOcorrenciaClick(Sender: TObject);
begin
  inherited;
  If pnlOcorrencias.Enabled And (Not cdsMovOcorr.IsEmpty) Then
    pCarregaOcorrenciaAlteracao;
end;

procedure TfrmCRM.mnuAlterarDocumentoClick(Sender: TObject);
begin
  pAguarde(pAlteraDocumento);
end;

procedure TfrmCRM.pAlteraDocumento;
  Var
    popMenu: TPopupMenu;

  function getLeadDocumento: string;
  begin
    result :=
      fCampoTabela('FGO_NLEADS',
                   'EXTGOR',
                   ['FGO_SEQFGO'],
                   [cdsMovOcorrAUTOINCREMFATGOR.AsString]);
  end;

begin
  inherited;
  popMenu := nil;
  pExibirAlterar();

  If (Not mnuAlterarDocumento.Visible) Then
    Exit;

  If (Pos('PD', cdsMovOcorrNumDoc.AsString) > 0) Then
    popMenu := popPedido
  Else If (Pos('OR', cdsMovOcorrNumDoc.AsString) > 0) Then
    popMenu := popOrcamento;

  If (pnlOcorrencias.Enabled) And
     (Not cdsMovOcorr.IsEmpty) And
     Assigned(popMenu) Then
  Begin
    pAlterarDocumento(cdsMovOcorrNumDoc.AsString,
                      cdsCliente.FieldByName('CLI_CODCLI').AsString,
                      popMenu,
                      blnProspecto,
                      getLeadDocumento);

    If Not fEmptyStr(frmPrincipal.strCodCliGravado) And
       Not SameText(frmPrincipal.strCodCliGravado, edtCodCli.Text) Then
    Begin
      edtCodCli.Text := frmPrincipal.strCodCliGravado;
      fValidaCampos(edtCodCli, True);
    End;

    if not fEmptyStr(cdsGrupoOcorrGOC_CODGOC.AsString) then
      pFiltraOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString, edtCodCli.Text);
  End;
end;

procedure TfrmCRM.mnuAnaliseCreditoDEPSClick(Sender: TObject);
begin
  inherited;
  If (Not mnuAnaliseCreditoDEPS.Visible) Or
     (Not mnuAnaliseCreditoDEPS.Enabled) Then
    Exit;

  If Not fEmptyStr(cdsMovOcorrDOCCON.AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível realizar o envio da análise, pois o documento já foi transformado em Pedido de Venda.', ['&OK']);
    Exit;
  End;

  If Not fEmptyStr(cdsMovOcorrMOTBAI.AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível realizar o envio da análise, pois o documento foi baixado.', ['&OK']);
    Exit;
  End;

  If Pos(cdsMovOcorrSTATUSDEPS.AsString, 'APROVADO_DISPENSA ANÁLISE_') > 0 Then
  Begin
    If cdsMovOcorrSTATUSDEPS.AsString = 'APROVADO' Then
      fMensagem('ATENÇÃO', 'Orçamento já aprovado.', ['&OK'])
    Else
      fMensagem('ATENÇÃO', 'Não será necessário a aprovação de crédito. Orçamento já está liberado para faturamento.', ['&OK']);

    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Tem certeza que deseja enviar o documento para a análise de crédito do Sistema DEPS?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    fStartTransaction;
    If TValidacoesSistemaDEPS.fAtualizaStatusSistemaDEPS(cdsMovOcorrAUTOINCREMFATGOR.AsString,
                                                         'AGUARDANDO ANÁLISE') Then
    Begin
      cdsMovOcorr.Edit;
      cdsMovOcorrSTATUSDEPS.AsString := 'AGUARDANDO ANÁLISE';
      cdsMovOcorr.Post;
    End;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCRM.mnuAnaliseCreditoDEPSClick]');
    End;

  End;
end;

procedure TfrmCRM.mnuBaixarClick(Sender: TObject);
  Var
    strNumDoc : String;
    strEspDoc : String;
    strCodEmp : String;
    strAutInc : String;
    LEmpExp   : String;
    arrPedidoComLoteSeparacaoRomaneio: TStringArray;
begin
  pExibirBaixar();

  If Not mnuBaixar.Visible Then
    Exit;

  strNumDoc := LeftStr(cdsMovOcorrNUMDOC.AsString, 12);
  strEspDoc := Copy(cdsMovOcorrNUMDOC.AsString, 14, 2);
  strCodEmp := RightStr(cdsMovOcorrNUMDOC.AsString, 3);

  SetLength(arrPedidoComLoteSeparacaoRomaneio, 0);

  If (strEspDoc = 'PD') Then
  Begin
    strAutInc := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'], [strNumDoc, strCodEmp, strEspDoc]);
    LEmpExp := fCampoTabela('FGO_EMPEXP', 'EXTGOR', ['FGO_SEQFGO'], [strAutInc]);

    If ((Not fVerificaAcessoSistema('CANPDA')) or fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO(LEmpExp)) And (fPedidoExpedido(strAutInc)) Then
    Begin
      fMensagem('Atenção!', 'Pedido expedido, para efetuar a baixa é necessário cancelar a expedição.', ['&Ok']);
      Exit;
    End;

    if fUsaOndaSeparacaoAgrupamento and
       fFoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada(strAutInc) then
    begin
      fMensagem('ATENÇÃO!', 'Pedido pertencente a Remessa de Pedido/Separação. Para efetuar a baixa é necessário guardar os itens através da rotina de expedição!', ['&Ok']);
      Exit;
    end;

    If (fExisteLoteSeparacaoRomaneioParaPedido(strAutInc)) Then
    begin
      If Not fVerificaAcessoSistema('BPVLSR') Then
      Begin
        SetLength(arrPedidoComLoteSeparacaoRomaneio, Length(arrPedidoComLoteSeparacaoRomaneio)+1);
        arrPedidoComLoteSeparacaoRomaneio[Length(arrPedidoComLoteSeparacaoRomaneio)-1] := strAutInc;

        If Not fLiberouTravaProdutoVinculadoLoteSeparacao(arrPedidoComLoteSeparacaoRomaneio) Then
          Exit;
      End;
    end;
  End;

  If fBaixarPedOrcNaoEntregue(strNumDoc,
                              strEspDoc,
                              strCodEmp,
                              True,
                              Self.Name) Then
  Begin
    cdsGrupoOcorrAfterScroll(nil);
    pCarregaInformacoesOcorrencias;
  End;
end;

function TfrmCRM.fLiberouTravaProdutoVinculadoLoteSeparacao(
  arrPedidos: TStringArray): Boolean;
var
  objLiberacao: TLiberacao;
  intIndice: integer;
  strAutInc: String;
  qryPedidos: TUniQuery;
begin
  Result := True;

  if Length(arrPedidos) <= 0 then
    Exit;

  objLiberacao := TLiberacao.Create;
  qryPedidos := fCriaQuery;

  try
    strAutInc := EmptyStr;

    for intIndice := 0 to Length(arrPedidos) - 1 do
    begin
      pIncrementaListaStr(arrPedidos[intIndice], strAutInc, True);
    end;

    if fEmptyStr(strAutInc) then
      Exit;

    qryPedidos.Close;
    qryPedidos.SQL.Clear;
    qryPedidos.SQL.Add('SELECT F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP, F.FGO_CODCLI, C.CLI_NOMCLI, G.RLG_DESLOT');
    qryPedidos.SQL.Add('FROM FATGOR F');
    qryPedidos.SQL.Add('INNER JOIN CADCLI C');
    qryPedidos.SQL.Add('ON(F.FGO_CODCLI = C.CLI_CODCLI)');
    qryPedidos.SQL.Add('INNER JOIN ROMLDE D');
    qryPedidos.SQL.Add('ON(F.FGO_NUMDOC = D.RLD_NUMDOC AND F.FGO_ESPDOC = D.RLD_ESPDOC AND F.FGO_CODEMP = D.RLD_CODEMP)');
    qryPedidos.SQL.Add('INNER JOIN ROMLGE G');
    qryPedidos.SQL.Add('ON(D.RLD_SEQRLG = G.AUTOINCREM)');
    qryPedidos.SQL.Add('WHERE F.AUTOINCREM IN('+strAutInc+')');
    qryPedidos.Open;

    if qryPedidos.IsEmpty then
      Exit;
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE PEDIDO DE VENDA VINCLUADO A UM LOTE DE SEPARAÇÃO DE ROMANEIO');
    objLiberacao.objMsgLibera.pAddSeparador(100);

    if qryPedidos.RecordCount = 1 then
      objLiberacao.objMsgLibera.pAddTexto('Este pedido de venda está vinculado a um lote de separação para romaneio.')
    else
      objLiberacao.objMsgLibera.pAddTexto('Estes pedidos de venda estão vinculados a um lote de separação para romaneio.');

    objLiberacao.objMsgLibera.pAddQuebra;

    while not qryPedidos.Eof do
    begin
      objLiberacao.objMsgLibera.pAddTexto('PEDIDO  : ' + qryPedidos.FieldByName('FGO_NUMDOC').AsString + '-' + qryPedidos.FieldByName('FGO_ESPDOC').AsString + '-' + qryPedidos.FieldByName('FGO_CODEMP').AsString);
      objLiberacao.objMsgLibera.pAddTexto('CLIENTE : ' + qryPedidos.FieldByName('FGO_CODCLI').AsString + ' - ' + qryPedidos.FieldByName('CLI_NOMCLI').AsString);
      objLiberacao.objMsgLibera.pAddTexto('LOTE    : ' + qryPedidos.FieldByName('RLG_DESLOT').AsString);
      objLiberacao.objMsgLibera.pAddSeparador(100);
      qryPedidos.Next;
    end;

    objLiberacao.strDirAce := 'BPVLSR';
    objLiberacao.strMsgSen := 'Senha liberar baixar pedidos vinculados a um lote de separação para romaneio';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
    FreeAndNil(qryPedidos);
  end;
end;

procedure TfrmCRM.mnuEfetivarOrcamentoClick(Sender: TObject);
begin
  pExibirEfetivarOrcamento;

  If Not mnuEfetivarOrcamento.Visible Then
    Exit;

  If (blnUtilizaSistemaDEPS) And
     (Pos(cdsMovOcorrSTATUSDEPS.AsString, 'APROVADO_DISPENSA ANÁLISE_') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Necessária a aprovação de crédito do sistema DEPS para a efetivação.' + #13 +
                         'Status DEPS: ' + cdsMovOcorrSTATUSDEPS.AsString, ['&OK']);
    Exit;
  End;

  If fEfetivarOrcamentoEmPedido(cdsMovOcorrNUMDOC.AsString,
                                IIF(blnProspecto, cdsMovOcorrCLIDOC.AsString, edtCodCli.Text)) Then
  Begin
    cdsGrupoOcorrAfterScroll(nil);
  End;
end;

procedure TfrmCRM.pExibeLimparSeparacao;
begin
  mnuLimparSeparacao.Visible := False;

  If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  mnuLimparSeparacao.Visible := fVerificaAcessoSistema('CRMLIMSEP');
end;

procedure TfrmCRM.pExibirAlterar;
begin
  mnuAlterarDocumento.Visible := False;

  If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  If cdsMovOcorrOCO_DTACON.AsDateTime > 0 Then
    Exit;

  mnuAlterarDocumento.Visible := True;
end;

procedure TfrmCRM.pExibirBaixar;
begin
  mnuBaixar.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit
  Else If (Not btnOrcamento.Enabled) And (Not btnPedido.Enabled) Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  If cdsMovOcorrOCO_DTACON.AsDateTime > 0 Then
    Exit;

  mnuBaixar.Visible := ((Pos('OR', cdsMovOcorrNumDoc.AsString) > 0) And fVerificaAcessoSistema('BAIPDV')) Or
    ((Pos('PD', cdsMovOcorrNumDoc.AsString) > 0) And fVerificaAcessoSistema('BXPNFT'));
end;

procedure TfrmCRM.pExibirCadastroLeads;
begin
  mnuAbrirLead.Visible := False;
  FNumLeadAutoInc := EmptyStr;

  If cdsMovOcorr.IsEmpty Then
    Exit;

  If Not fEmptyStr(cdsMovOcorrOCO_SEQLAG.AsString) then
    FNumLeadAutoInc := cdsMovOcorrOCO_SEQLAG.AsString;

  If fEmptyStr(FNumLeadAutoInc) Then
    If (Pos('OR', cdsMovOcorrNumDoc.AsString) >= 1) Then
      FNumLeadAutoInc := TLeads.fObterNumLead(RightStr(cdsMovOcorrNumDoc.AsString, 3),
                                              Copy(cdsMovOcorrNumDoc.AsString, 14, 2),
                                              LeftStr(cdsMovOcorrNumDoc.AsString, 12));
  If fEmptyStr(FNumLeadAutoInc) Then
    Exit;

  mnuAbrirLead.Visible := Not fEmptyStr(FNumLeadAutoInc);
end;

procedure TfrmCRM.pExibirDesmembrar;
begin
  mnuDesmembrar.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit
  Else If (Not btnOrcamento.Enabled) And (Not btnPedido.Enabled) Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (cdsMovOcorrFGO_STATUS.AsInteger In [pvPedidoEmAberto.fGetId(),
                                               pvSeparando.fGetId(),
                                               pvAgFaturamento.fGetId()]) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  If cdsMovOcorrOCO_DTACON.AsDateTime > 0 Then
    Exit;

  mnuDesmembrar.Visible := fVerificaAcessoSistema('frmFatDesmembrarPedido');
end;

procedure TfrmCRM.pExibirEfetivarOrcamento;
begin
  mnuEfetivarOrcamento.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit;

  If Not btnOrcamento.Enabled Then
    Exit;

  If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If Not fCfgSis('CRMCOP', varBoolean) Then
    If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
      Exit;

  If Not fCfgSis('USAFPG', varBoolean) Then
    Exit;

  If Not fCfgSis('USAPDV', varBoolean) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  If cdsMovOcorrOCO_DTACON.AsDateTime > 0 Then
    Exit;

  mnuEfetivarOrcamento.Visible := True;
end;

procedure TfrmCRM.pExibirFaturarEmVendaNormal;
begin

  mnuFaturarEmVendaNormal.Visible := False;

  If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  If cdsMovOcorrOCO_DTACON.AsDateTime > 0 Then
    Exit;

  mnuFaturarEmVendaNormal.Visible := fVerificaAcessoSistema('CRMVDN');

end;

procedure TfrmCRM.pExibirGerarVendaPerdida;
begin
   mnuGerarVendaPerdida.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit;

  If fCfgSis('VNPEIT', varBoolean) Then
  Begin
    If (Pos(cdsMovOcorrNumDoc.AsString, 'OR_PD_') > 0) Then
      Exit;
  End
  Else
  Begin
    If Not btnOrcamento.Enabled Then
      Exit;

    If (Pos(cdsMovOcorrNumDoc.AsString, 'OR_PD_') > 0) Then
      Exit;
  End;

  If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  If cdsMovOcorrOCO_DTACON.AsDateTime > 0 Then
    Exit;

  mnuGerarVendaPerdida.Visible := True;
end;

procedure TfrmCRM.pExibirModificarCategoria;
begin
  mnuModificarCategoria.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit
  Else If (Not btnOrcamento.Enabled) And (Not btnPedido.Enabled) Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos('OR', cdsMovOcorrNumDoc.AsString) > 0) And (Not fCfgSis('UTICAO', varBoolean)) Then
    Exit
  Else If (Pos('PD', cdsMovOcorrNumDoc.AsString) > 0) And (Not fCfgSis('UTICAP', varBoolean)) Then
    Exit
  Else If (cdsMovOcorrFGO_STATUS.AsInteger In [pvPedidoEmAberto.fGetId(),
                                               pvSeparando.fGetId(),
                                               pvAgFaturamento.fGetId()]) Then
    Exit;

  mnuModificarCategoria.Visible := fVerificaAcessoSistema('MODCAT');
end;

procedure TfrmCRM.pExibirRetirarVinculoReq_Transf;
begin
  mnuRetirarVinculoReq_Transf.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit
  Else If (Not btnPedido.Enabled) Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else if not fCfgSis('SLTFRC', varBoolean) then
    Exit;

  If cdsMovOcorrFGO_JAFATU.AsInteger = 1 Then
    Exit;

  mnuRetirarVinculoReq_Transf.Visible := True;
end;

procedure TfrmCRM.pExibirValidacaoSistemaDEPS;
begin
  mnuAnaliseCreditoDEPS.Visible := blnUtilizaSistemaDEPS;

  If (Not blnUtilizaSistemaDEPS) Then
    Exit;

  mnuAnaliseCreditoDEPS.Enabled := (Not cdsMovOcorr.IsEmpty) And
                                   (Pos('OR', cdsMovOcorr.FieldByName('NUMDOC').AsString) > 0);
end;

procedure TfrmCRM.pExibirDocumentosConfirmacao;
begin
  mnuDocumentosConfirmacao.Visible := False;

  If cdsCliente.IsEmpty Then
    Exit
  Else If (Not btnOrcamento.Enabled) And (Not btnPedido.Enabled) Then
    Exit
  Else If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit
  Else If (Pos(',', cdsMovOcorrDOCCON.AsString) <= 0) Then
    Exit;

  mnuDocumentosConfirmacao.Visible := True;
end;

procedure TfrmCRM.mnuEnviarEmailClick(Sender: TObject);
begin
  inherited;

  If (Not pnlOcorrencias.Enabled) Or (cdsMovOcorr.IsEmpty) Then
    Exit;

  pEnviarEmail(Self,
               cdsMovOcorrNumDoc.AsString,
               IIF(Not fEmptyStr(cdsMovOcorrCliDoc.AsString), cdsMovOcorrCliDoc.AsString, cdsCliente.FieldByName('CLI_CODCLI').AsString),
               cdsCliente.FieldByName('CLI_NOMCLI').AsString,
               cdsCliente.FieldByName('CLI_EMAIL_').AsString);
end;

procedure TfrmCRM.mnuFaturarEmVendaNormalClick(Sender: TObject);
var
  strNumDoc,
  strEspDoc : String;
begin

  inherited;

  pExibirFaturarEmVendaNormal;

  If Not mnuFaturarEmVendaNormal.Visible Then
    Exit;

  strNumDoc := LeftStr(cdsMovOcorrNUMDOC.AsString, 12);
  strEspDoc := Copy(cdsMovOcorrNUMDOC.AsString, 14, 2);

  If fEmptyStr(strNumDoc) Then
    Exit;

  If fEmptyStr(strEspDoc) Then
    Exit;

  If fVerificaAcessoSistema('CRMVDN') Then
  Begin

    If (mnuFaturarEmVendaNormal.Enabled) And (not cdsCliente.IsEmpty) then
    Begin

      pChamaFaturamento_PD_OR_Em_VendaNormal(PopVendaNormal,
                                             edtCodCli.Text,
                                             mskNumCgc.Text,
                                             strNumDoc,
                                             strEspDoc);

      If Not fEmptyStr(frmPrincipal.strCodCliGravado) And
         Not SameText(frmPrincipal.strCodCliGravado, edtCodCli.Text) Then
      Begin
        edtCodCli.Text := frmPrincipal.strCodCliGravado;
        fValidaCampos(edtCodCli, True);
      End;

      If (Copy(PopVendaNormal.Items[0].Hint,4,8) <> edtCodCli.Text) Then
      Begin
        edtCodCli.Text := Copy(PopVendaNormal.Items[0].Hint,4,8);
        fValidaCampos(edtCodCli, True);
      End
      Else If (Not fEmptyStr(cdsGrupoOcorrGOC_CODGOC.AsString)) Then
        pFiltraOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString, edtCodCli.Text);

    End;

  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);

end;

procedure TfrmCRM.mnuGerarPDFClick(Sender: TObject);
  Var
    blnPedidoBaixadoTotalmente: Boolean;
begin
  inherited;

  If (Not pnlOcorrencias.Enabled) Or (cdsMovOcorr.IsEmpty) Then
    Exit;

  If (Pos(cdsMovOcorrOCO_ESPDOC.asString, 'PD_OR_') > 0) Then
  Begin
    blnPedidoBaixadoTotalmente := fPedidoBaixadoTotalmente(LeftStr(cdsMovOcorrNUMDOC.asString, 12),
                                                           cdsMovOcorrESPDOC.asString,
                                                           RightStr(cdsMovOcorrNUMDOC.asString, 3));

    pGerarPDF(cdsMovOcorrNumDoc.AsString, blnPedidoBaixadoTotalmente);
  End
  Else If (Pos(cdsMovOcorrOCO_ESPDOC.asString, 'NF_IF_NS_FF_DV_') > 0) Then
    pGerarPDFVN(cdsMovOcorrOCO_NUMDOC.AsString,
                cdsMovOcorrOCO_ESPDOC.AsString,
                cdsMovOcorrOCO_CODEMP.AsString,
                cdsMovOcorrOCO_CODCLI.AsString);
end;

procedure TfrmCRM.mnuGerarVendaPerdidaClick(Sender: TObject);
var
  LEmpExp: String;
begin
  inherited;
  pExibirGerarVendaPerdida;

  If Not mnuGerarVendaPerdida.Visible Then
    Exit;

  LEmpExp := fCampoTabela('FGO_EMPEXP', 'EXTGOR', ['FGO_SEQFGO'], [cdsMovOcorrAUTOINCREMFATGOR.AsString]);

  if fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO(LEmpExp) And
     fPedidoPossuiItensEmSemparacao And
     (SameText(cdsMovOcorrOCO_ESPDOC.AsString, 'PD')) Then
  begin
    fMensagem('ATENÇÃO!', 'Pedido está em separação, para efetuar a baixa é necessário solicitar para o separador "Limpar a Separação".', ['&OK']);
    Exit;
  end;

  if fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO(LEmpExp) And
     fPedidoExpedido(cdsMovOcorrAUTOINCREMFATGOR.AsString) And
     (SameText(cdsMovOcorrOCO_ESPDOC.AsString, 'PD')) Then
  begin
    fMensagem('Atenção!', 'Pedido expedido, para efetuar a baixa é necessário cancelar a expedição.', ['&Ok']);
    Exit;
  end;

  If fCfgSis('VNPEIT', varBoolean) Then
    pGerarVendaPerdidaSelItens
  Else
    pGerarVendaPerdidaPadrao;
end;

procedure TfrmCRM.pGerarVendaPerdidaPadrao;
var
  strCodOcoCfg: String;
begin
  strCodOcoCfg := fCfgSis('OCOPER', varString);

  pGerarVendaPerdida(cdsMovOcorrNUMDOC.AsString, strCodOcoCfg);
  cdsGrupoOcorrAfterScroll(nil);
end;

procedure TfrmCRM.pGerarVendaPerdidaSelItens;
var
  objGerarVendaPerdida: TGerarVendaPerdida;
begin
  inherited;

  objGerarVendaPerdida := TGerarVendaPerdida.Create(cdsMovOcorrOCO_ESPDOC.AsString);
  Try
    Try
      objGerarVendaPerdida.pGerarVendaPerdida(cdsMovOcorrOCO_EMPDOC.AsString,
                                              cdsMovOcorrOCO_ESPDOC.AsString,
                                              cdsMovOcorrOCO_NUMDOC.AsString);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.message, 'TfrmCRM.pGerarVendaPerdidaSelItens');
      End;
    End;
  Finally
    FreeAndNil(objGerarVendaPerdida);
  End;
end;

procedure TfrmCRM.mnuLimparSeparacaoClick(Sender: TObject);
begin
  Try
    If Not mnuLimparSeparacao.Visible Then
      Exit;

    If fUsaOndaSeparacaoAgrupamento And
       fFoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada(cdsMovOcorrAUTOINCREMFATGOR.AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível limpar a separação de um pedido pertencente a Remessa de Pedido/Separação!', ['&Ok']);
      Exit;
    End;

    If (fUsaOndaSeparacaoExpedicao) And
       (fPedidoEmOndaSeparacao(cdsMovOcorrAUTOINCREMFATGOR.AsString)) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Permitir limpar o pedido que pertence a uma onda de separação.');

      objLiberacao.strDirAce := 'LSEPON';
      objLiberacao.strMsgSen := 'CRM - Limpar Separação de Pedido';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
        Exit;
    End;

    If fLimpaExpedicaoPedido(cdsMovOcorrAUTOINCREMFATGOR.AsString) Then
      pMensagemOk('Operação realizada com sucesso.');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.message, 'TfrmCRM.mnuLimparSeparacaoClick');
    End;
  End;
end;

procedure TfrmCRM.mnuModificarCategoriaClick(Sender: TObject);
var
  chrKey        : Char;
  arrCategorias : TConsultasArray;
  qryAtuCat     : TUniQuery;
begin
  pExibirModificarCategoria();

  If (Not mnuModificarCategoria.Visible) Then
    Exit;

  chrKey := '/';
  if fPesqCategoriaOrPd(Self, Nil, Nil, Nil, chrKey, arrCategorias, True, cdsMovOcorr.FieldByName('ESPDOC').asString) then
  begin

    qryAtuCat := fCriaQuery;
    Try
      qryAtuCat.Close;
      qryAtuCat.SQL.Text := 'UPDATE EXTGOR SET FGO_CODCAT = ' + QuotedStr(fStrZero(arrCategorias[0].strCodigo,6)) + ' WHERE FGO_SEQFGO = '+ cdsMovOcorr.FieldByName('AUTOINCREMFATGOR').asString;
      qryAtuCat.ExecSQL;
    Finally
      FreeAndNil(qryAtuCat);
      pFiltraOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString, edtCodCli.Text);
    End;

  end;

end;

procedure TfrmCRM.pAdicionaMascarasCliente;
begin
  if cdsClienteCLI_CGCCPF.AsString = '1' then
    cdsClienteCLI_C_G_C_.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  else if cdsClienteCLI_CGCCPF.AsString = '2' then
    cdsClienteCLI_C_G_C_.EditMask := '999.999.999-99;0;';

  cdsClienteCLI_FONE01.EditMask   := fRetMascaraFonePais;
  cdsClienteCLI_FONE02.EditMask   := fRetMascaraFonePais;
  cdsClienteCLI_F_A_X_.EditMask   := fRetMascaraFonePais;
  cdsClienteCLI_CELULA.EditMask   := fRetMascaraFonePais;
  cdsContatosCLI_TELCTT.EditMask  := fRetMascaraFonePais;
  cdsContatosCLI_CELCTT.EditMask  := fRetMascaraFonePais;
  cdsContatosCLI_FAXCTT.EditMask  := fRetMascaraFonePais;
  cdsEnderecosETC_TELENT.EditMask := fRetMascaraFonePais;

  cdsClienteCLI_LIMCRE.EditFormat := '###,#0.00';
end;

procedure TfrmCRM.pCamposVisiveisClientes(qrySel: TUniQuery);
begin
  With qrySel Do
  Begin
    First;
    While Not Eof do
    Begin
      If Assigned(dbgClientes.RowByName('dbgClientes'+qrySel.FieldByName('CRM_NOMCAM').AsString)) Then
        TcxDBEditorRow(dbgClientes.RowByName('dbgClientes'+qrySel.FieldByName('CRM_NOMCAM').AsString)).Visible := IIF(FieldByName('CRM_EXIBIR').AsString = 'S',True,False);

      Next;
    End;
  End;
end;

procedure TfrmCRM.pCarregaCadCli;
begin
  If blnProspecto Then
    edtDesCodCli.Text := fRetNomProspectoATIVO(edtCodCli.Text)
  Else
  Begin
    edtDesCodCli.Text := fRetNomCliente(edtCodCli.Text);
    
    mskNumCgc.Visible := fClienteConsumidor(edtDesCodCli.Text);
    edtCgcCpf.Visible := mskNumCgc.Visible;
    lblCgcCpf.Visible := mskNumCgc.Visible;
    dbgMovOcorrDBTableView1OCO_C_P_F_.Visible := mskNumCgc.Visible;
    dbgMovOcorrDBTableViewNOMCON.Visible := True;

    dbgMovOcorrDBTableViewTELCON.Visible := mskNumCgc.Visible;

    If Not mskNumCgc.Visible Then
    Begin
      dbgMovOcorrDBTableViewNOMCON.Visible := False;
      mskNumCgc.Clear;
      cdsMovOcorr.Filtered := False;
    End;
  End;
end;

procedure TfrmCRM.pCarregaInformacoesCliente;
var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      If blnProspecto Then
        SQL.Add(fRetornaSQLInformacoesProspecto)
      Else
        SQL.Add(fRetornaSQLInformacoesCliente);

      Params.ParamByName('CODCLI').AsString := Trim(edtCodCli.Text);
      Open;
      First;

      cdsCliente.EmptyDataSet;
      cdsCliente.Append;
      cdsClienteCLI_CODCLI.AsString := FieldByName('CLI_CODCLI').AsString;
      cdsClienteCLI_NOMCLI.AsString := FieldByName('CLI_NOMCLI').AsString;
      cdsClienteCLI_FANSOB.AsString := FieldByName('CLI_FANSOB').AsString;
      cdsClienteCLI_CODCID.AsString := FieldByName('CLI_CODCID').AsString;
      cdsClienteCLI_C_E_P_.AsString := FieldByName('CLI_C_E_P_').AsString;
      cdsClienteCLI_ENDERE.AsString := FieldByName('CLI_ENDERE').AsString;
      cdsClienteCLI_ENDNUM.AsString := FieldByName('CLI_ENDNUM').AsString;
      cdsClienteCLI_ENDCOM.AsString := FieldByName('CLI_ENDCOM').AsString;
      cdsClienteCLI_BAIRRO.AsString := FieldByName('CLI_BAIRRO').AsString;
      cdsClienteCLI_CGCCPF.AsString := FieldByName('CLI_CGCCPF').AsString;
      cdsClienteCLI_C_G_C_.AsString := FieldByName('CLI_C_G_C_').AsString;
      cdsClienteCLI_NUMR_G.AsString := FieldByName('CLI_NUMR_G').AsString;
      cdsClienteCLI_I_M_P_.AsString := FieldByName('CLI_I_M_P_').AsString;
      cdsClienteCLI_NASCIM.AsString := FieldByName('CLI_NASCIM').AsString;
      cdsClienteCLI_CAIPOS.AsString := FieldByName('CLI_CAIPOS').AsString;
      cdsClienteCLI_FONE01.AsString := FieldByName('CLI_FONE01').AsString;
      cdsClienteCLI_RAMAL1.AsString := FieldByName('CLI_RAMAL1').AsString;
      cdsClienteCLI_FONE02.AsString := FieldByName('CLI_FONE02').AsString;
      cdsClienteCLI_RAMAL2.AsString := FieldByName('CLI_RAMAL2').AsString;
      cdsClienteCLI_F_A_X_.AsString := FieldByName('CLI_F_A_X_').AsString;
      cdsClienteCLI_RAMAL3.AsString := FieldByName('CLI_RAMAL3').AsString;
      cdsClienteCLI_CELULA.AsString := FieldByName('CLI_CELULA').AsString;
      cdsClienteCLI_NEXTEL.AsString := FieldByName('CLI_NEXTEL').AsString;
      cdsClienteCLI_EMAIL_.AsString := FieldByName('CLI_EMAIL_').AsString;
      cdsClienteCLI_CONTAT.AsString := FieldByName('CLI_CONTAT').AsString;
      cdsClienteCLI_EMAIL2.AsString := FieldByName('CLI_EMAIL2').AsString;
      cdsClienteCLI_EMAIL3.AsString := FieldByName('CLI_EMAIL3').AsString;
      cdsClienteCLI_CONSUM.AsString := FieldByName('CLI_CONSUM').AsString;
      cdsClienteCLI_HOMEPA.AsString := FieldByName('CLI_HOMEPA').AsString;
      cdsClienteCLI_CODVEN.AsString := FieldByName('CLI_CODVEN').AsString;
      cdsClienteCLI_SUPGER.AsString := FieldByName('CLI_SUPGER').AsString;
      cdsClienteCLI_SUPREG.AsString := FieldByName('CLI_SUPREG').AsString;
      cdsClienteCLI_CODATI.AsString := FieldByName('CLI_CODATI').AsString;
      cdsClienteCLI_TABPRE.AsString := FieldByName('CLI_TABPRE').AsString;
      cdsClienteCLI_LIMCRE.AsFloat  := FieldByName('CLI_LIMCRE').AsFloat;
      cdsClienteCLI_CODFPG.AsString := FieldByName('CLI_CODFPG').AsString;
      cdsClienteCLI_TIPCLI.AsString := FieldByName('CLI_TIPCLI').AsString;
      cdsClienteCLI_CODPOR.AsString := FieldByName('CLI_CODPOR').AsString;
      cdsClienteCLI_DESCON.AsString := FieldByName('CLI_DESCON').AsString;
      cdsClienteCLI_PERCOM.AsString := FieldByName('CLI_PERCOM').AsString;
      cdsClienteCLI_PEREMP.AsString := FieldByName('CLI_PEREMP').AsString;
      cdsClienteCLI_CODREG.AsString := FieldByName('CLI_CODREG').AsString;
      cdsClienteCLI_CODDIV.AsString := FieldByName('CLI_CODDIV').AsString;
      cdsClienteCLI_CODRED.AsString := FieldByName('CLI_CODRED').AsString;
      cdsClienteCLI_CODCAC.AsString := FieldByName('CLI_CODCAC').AsString;
      cdsClienteCLI_ATRMAX.AsString := FieldByName('CLI_ATRMAX').AsString;
      cdsClienteCLI_PERMFF.AsString := FieldByName('CLI_PERMFF').AsString;
      cdsClienteCLI_PERMFV.AsString := FieldByName('CLI_PERMFV').AsString;
      cdsClienteCLI_EMPRCF.AsString := FieldByName('CLI_EMPRCF').AsString;
      cdsClienteCLI_NOMCID.AsString := FieldByName('CID_NOMCID').AsString;
      cdsClienteCLI_NOMVEN.AsString := FieldByName('NOMVEN').AsString;
      cdsClienteCLI_NOMREP.AsString := FieldByName('NOMREP').AsString;
      cdsClienteCLI_NOMSRE.AsString := FieldByName('NOMSRE').AsString;
      cdsClienteCLI_DESATI.AsString := FieldByName('ATI_DESATI').AsString;
      cdsClienteCLI_DESFPG.AsString := FieldByName('FPG_DESCRI').AsString;
      cdsClienteCLI_DESTCL.AsString := FieldByName('TIP_DESTIP').AsString;
      cdsClienteCLI_DESPOR.AsString := FieldByName('POR_NOMPOR').AsString;
      cdsClienteCLI_DESREG.AsString := FieldByName('REG_DESREG').AsString;
      cdsClienteCLI_NOMDIV.AsString := FieldByName('DIV_NOMDIV').AsString;
      cdsClienteCLI_NOMRED.AsString := FieldByName('RED_DESRED').AsString;
      cdsClienteCLI_NOMCAC.AsString := FieldByName('CAC_NOMCAC').AsString;
      cdsClienteCLI_NOMERC.AsString := FieldByName('EMP_NOMEMP').AsString;
      cdsClienteCLI_NOMSGE.AsString := FieldByName('NOMSGE').AsString;
      cdsClienteCLI_I_E_S_.AsString := FieldByName('CLI_I_E_S_').AsString;
      cdsClienteCLI_REGTRI.AsString := fRetornaRegimeTributario(FieldByName('CLI_REGTRI').AsString);            
      cdsCliente.Post;

      pAdicionaMascarasCliente;

      If not blnProspecto Then
        pVerificaCamposVisiveisClientes;

      dbgClientes.FirstRow;
    end;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCRM.pCarregaInformacoesContatos;
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesContatos);
      Params.ParamByName('CODCLI').AsString := Trim(edtCodCli.Text);
      UniDirectional := True;
      Open;

      First;
      cdsContatos.DisableControls;
      cdsContatos.EmptyDataSet;
      while not Eof do
      begin
        cdsContatos.Append;
        cdsContatosCLI_CODCLI.AsString := FieldByName('CLI_CODCLI').AsString;
        cdsContatosCLI_NOMCTT.AsString := FieldByName('CLI_NOMCTT').AsString;
        cdsContatosCLI_TELCTT.AsString := FieldByName('CLI_TELCTT').AsString;
        cdsContatosCLI_CELCTT.AsString := FieldByName('CLI_CELCTT').AsString;
        cdsContatosCLI_FAXCTT.AsString := FieldByName('CLI_FAXCTT').AsString;
        cdsContatosCLI_DESDPT.AsString := FieldByName('DPT_DESDPT').AsString;
        cdsContatosCLI_DESCGO.AsString := FieldByName('CGO_DESCGO').AsString;
        cdsContatosCLI_DESTFU.AsString := FieldByName('TFU_DESTFU').AsString;
        cdsContatosCLI_DESHOB.AsString := FieldByName('HOB_DESHOB').AsString;
        cdsContatosCLI_DESECI.AsString := FieldByName('ECI_DESECI').AsString;
        cdsContatosCLI_DESGMU.AsString := FieldByName('GMU_DESGMU').AsString;
        cdsContatosCLI_DESESC.AsString := FieldByName('ESC_DESESC').AsString;
        cdsContatos.Post;

        pAdicionaMascarasCliente;

        qryConsulta.Next;
      end;
      cdsContatos.First;
    end;
  finally
    cdsContatos.EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCRM.pCarregaInformacoesEnderecos;
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesEnderecos);
      Params.ParamByName('CODCLI').AsString := Trim(edtCodCli.Text);
      UniDirectional := True;
      Open;

      First;
      cdsEnderecos.DisableControls;
      cdsEnderecos.EmptyDataSet;
      while not Eof do
      begin
        cdsEnderecos.Append;
        cdsEnderecosETC_CODCLI.AsString := FieldByName('ETC_CODCLI').AsString;
        cdsEnderecosETC_CIDENT.AsString := FieldByName('ETC_CIDENT').AsString;
        cdsEnderecosCID_NOMCID.AsString := FieldByName('CID_NOMCID').AsString;
        cdsEnderecosETC_ENDENT.AsString := FieldByName('ETC_ENDENT').AsString;
        cdsEnderecosETC_BAIENT.AsString := FieldByName('ETC_BAIENT').AsString;
        cdsEnderecosETC_CEPENT.AsString := FieldByName('ETC_CEPENT').AsString;
        cdsEnderecosETC_TELENT.AsString := FieldByName('ETC_TELENT').AsString;
        cdsEnderecosETC_CONENT.AsString := FieldByName('ETC_CONENT').AsString;
        cdsEnderecosETC_REFENT.AsString := FieldByName('ETC_REFENT').AsString;
        cdsEnderecosETC_CODTRA.AsString := FieldByName('ETC_CODTRA').AsString;
        cdsEnderecosTRA_NOMTRA.AsString := FieldByName('TRA_NOMTRA').AsString;
        cdsEnderecosETC_ENDFAT.AsString := FieldByName('ETC_ENDFAT').AsString;
        cdsEnderecos.Post;

        pAdicionaMascarasCliente;

        qryConsulta.Next;
      end;
      cdsEnderecos.First;
    end;
  finally
    cdsEnderecos.EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCRM.pCarregaInformacoesFazendas;
  Var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery(nil);
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(fRetornaSQLInformacoesFazendas);
    qryConsulta.Params.ParamByName('CODCLI').AsString := Trim(edtCodCli.Text);
    qryConsulta.Open;

    cdsFazendas.DisableControls;
    cdsFazendas.Open;
    cdsFazendas.EmptyDataSet;

    qryConsulta.First;
    While Not qryConsulta.Eof do
    Begin
      cdsFazendas.Append;
      cdsFazendasCODFAZ.AsString := qryConsulta.FieldByName('CODFAZ').AsString;
      cdsFazendasNOMFAZ.AsString := qryConsulta.FieldByName('NOMFAZ').AsString;
      cdsFazendasNOMCID.AsString := qryConsulta.FieldByName('NOMCID').AsString;
      cdsFazendasESTADO.AsString := qryConsulta.FieldByName('ESTADO').AsString;
      cdsFazendasC_E_P_.AsString := qryConsulta.FieldByName('C_E_P_').AsString;
      cdsFazendas.Post;

      qryConsulta.Next;
    End;

    cdsFazendas.First;
  Finally
    cdsFazendas.EnableControls;
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCRM.pCarregaInformacoesGrupoOcorrencias;
var
  qryConsulta: TUniQuery;
  blnExibeImagem: Boolean;
begin
  try
    qryConsulta := fCriaQuery(nil);
    blnExibeImagem := False;
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesGrupoOcorrencias(IfThen(blnProspecto, 'P', 'C'),
                                                     fCfgSis('VGOCOP', varBoolean)));
      Params.ParamByName('CODCLI').AsString := Trim(edtCodCli.Text);
      If Params.FindParam('CODOPE') <> Nil Then
        Params.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      If fCfgSis('VGOCOP', varBoolean) Then
        ParamByName('OPEGOC').AsString := strLoginUsuarioLogado;
      UniDirectional := True;
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
        cdsGrupoOcorr.FieldByName('GOC_NUMTOT').AsFloat  := FieldByName('GOC_NUMTOT').AsFloat;
        cdsGrupoOcorr.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

        If DirectoryExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm') Then
        Begin
          if FileExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + cdsGrupoOcorr.FieldByName('GOC_CODGOC').AsString + '.jpg') then
          begin
            Try
              TBlobField(cdsGrupoOcorr.FieldByName('IMAGEM')).LoadFromFile(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + cdsGrupoOcorr.FieldByName('GOC_CODGOC').AsString + '.jpg');
              blnExibeImagem := True;
            Except
              blnExibeImagem := False;
            End;
          end;
        End;

        cdsGrupoOcorr.Post;

        qryConsulta.Next;
      end;
      cdsGrupoOcorr.First;

      dbgGrupoOcorrDBTableView1IMAGEM.Visible := blnExibeImagem;
    end;
  finally
    FreeAndNil(qryConsulta);
    try
      cdsGrupoOcorr.EnableControls;
    except
      pMensagemOk('Ocorreu um erro ao atualizar o grupo de ocorrências.' + #13#10 +
        'Pressione ENTER para continuar e tente novamente.');
    end;
  end;
end;

procedure TfrmCRM.pCarregaInformacoesOcorrencias(strCodGoc: String = '');
begin
  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  pCarregaInformacoesGrupoOcorrencias;

  If Not fEmptyStr(strCodGoc) Then
  Begin
    cdsGrupoOcorr.Locate('GOC_CODGOC', strCodGoc, []);
  End;

  cdsGrupoOcorrAfterScroll(cdsGrupoOcorr);

  If not blnEmergencial Then
    pCarregaOcorrenciaEmergencial(edtCodCli.Text, strLoginUsuarioLogado,VS_strCodEmp);

  pFiltraOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString, edtCodCli.Text);
end;

procedure TfrmCRM.pCarregaOcorrenciaAlteracao;
begin
  if (not cdsCliente.IsEmpty) and (not cdsMovOcorr.IsEmpty) then
  begin
    pIncluirNovoHistoricoOcorrenciaInternal;
    pCarregaInformacoesOcorrencias(FCodGoc);
    pLocalizaOcorrenciaSolicitada;
  end;
end;

procedure TfrmCRM.pCarregaOcorrenciaEmergencial(strCodCli, strCodOpe,
  strCodEmp: String);
begin
  try
    blnEmergencial := True;
    pCriarFormularios(TfrmConsultaOcorrenciasCRMEmergenciais,frmConsultaOcorrenciasCRMEmergenciais);
    frmConsultaOcorrenciasCRMEmergenciais.strCodCli := strCodCli;
    frmConsultaOcorrenciasCRMEmergenciais.strCodEmp := strCodEmp;
    frmConsultaOcorrenciasCRMEmergenciais.strCodOpe := strCodOpe;

    If blnProspecto Then
      frmConsultaOcorrenciasCRMEmergenciais.strTip_Fc := 'P';

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

procedure TfrmCRM.pChamaConsultaOcorrenciaCRM;
begin
  pCriarFormularios(TfrmConsultaOcorrenciasCRM,frmConsultaOcorrenciasCRM);
  Try
    If Not cdsCliente.IsEmpty Then
      frmConsultaOcorrenciasCRM.edtCodCli.Text := cdsCliente.FieldByName('CLI_CODCLI').AsString;
    if blnProspecto Then
      frmConsultaOcorrenciasCRM.strTip_Fc := 'P';
    frmConsultaOcorrenciasCRM.pChamaOrcamento := pOrcamentoClick;
    frmConsultaOcorrenciasCRM.ShowModal;
    If frmConsultaOcorrenciasCRM.blnConfirma Then
    Begin
      strCodGoc := frmConsultaOcorrenciasCRM.strCodGoc;
      strCodOco := frmConsultaOcorrenciasCRM.strCodOco;
      edtCodCli.Text := frmConsultaOcorrenciasCRM.strCodCli;
      fValidaCampos(edtCodCli,False);
      pLocalizaGruposOcorrenciaSolicitada;
      pLocalizaOcorrenciaSolicitada;
      pSetFocus(dbgMovOcorr);
    End
    Else
      pCarregaInformacoesOcorrencias;
  Finally
    FreeAndNil(frmConsultaOcorrenciasCRM);
  End;
end;

procedure TfrmCRM.pChamaEmailDac;
  Var
    frmEnviarEmailDac: TfrmEnviarEmailDac;
begin
  Try
    pCriarFormularios(TfrmEnviarEmailDac,frmEnviarEmailDac);
    frmEnviarEmailDac.strCodCli := cdsCliente.FieldByName('CLI_CODCLI').AsString;
    frmEnviarEmailDac.strNomCli := cdsCliente.FieldByName('CLI_NOMCLI').AsString;
    frmEnviarEmailDac.strEmaCli := cdsCliente.FieldByName('CLI_EMAIL_').AsString;    
    frmEnviarEmailDac.ShowModal;
  Finally
    FreeAndNil(frmEnviarEmailDac);
  End;
end;

procedure TfrmCRM.pClientVazio;
begin
  cdsCliente.EmptyDataSet;
  cdsContatos.EmptyDataSet;
  cdsEnderecos.EmptyDataSet;
  cdsGrupoOcorr.EmptyDataSet;
  cdsMovOcorr.EmptyDataSet;
end;

procedure TfrmCRM.pConfiguraIcones(cxView: TcxGridDBTableViewCitel);
  Var
    item: TcxImageComboBoxItem;
    coluna: TcxGridDBColumn;
    strKey: String;
begin
  coluna := cxView.GetColumnByFieldName('STATUS');

  If Assigned(coluna) Then
  Begin
    With coluna Do
    begin
      Visible         := True;
      Index           := 0;
      SortIndex       := -1;
      Options.Editing := False;

      PropertiesClass := TcxImageComboBoxProperties;

      With TcxImageComboBoxProperties(Properties) Do
      Begin
        If Images = Nil Then
        Begin
          Images := frmModuloLegenda.imglLegenda;
          For strKey In TSituacaoPedidoVenda.fRetornaLegendaCompleta.Keys Do
          Begin
            item := Items.Add;
            item.ImageIndex := TSituacaoPedidoVenda.fRetornaLegendaCompleta.Items[strKey];
            item.Value      := strKey;
            item.Description:= item.Value;
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmCRM.pConfiguraIconeStatus;
begin
  If (fCfgSis('EXISTA', VarBoolean)) Then
  Begin
    pCriarModuloLegenda;

    pConfiguraIcones(dbgMovOcorrDBTableView1);
  End;
end;

procedure TfrmCRM.pCriarDataSets;
begin
  cdsCliente.CreateDataSet;
  cdsContatos.CreateDataSet;
  cdsEnderecos.CreateDataSet;
  cdsGrupoOcorr.CreateDataSet;
  cdsMovOcorr.CreateDataSet;
  cdsFazendas.CreateDataSet;
end;

procedure TfrmCRM.pDesabilitaBotoesLiberaPedido;
begin
  btnOrcamento.Visible := False;
  btnPedido.Visible := False;
  BtnVendaNormal.Visible := False;
  btnGeracaoOcorrencias.Visible := False;
  btnConsumiveis.Visible := False;
  btnPromocoes.Visible := False;
  btnCadLeads.Visible := False;
  btnPesqLeads.Visible := False;
  btnRelLeads.Visible := False;
end;

procedure TfrmCRM.pDesabilitaBotoesPanelSuperiorCrm;
begin
  btnNovaOcorrencia.Enabled   := False;
  btnOrcamento.Enabled        := False;
  btnPedido.Enabled           := False;
//  btnLocalizarOcorr.Enabled   := False;
  btnEmailDevDac.Enabled      := False;
  btnArquivosCadastro.Enabled := False;
  btnArquivosCobranca.Enabled := False;
  btnRelAD.Enabled            := False;
  btnFichaCadastral.Enabled   := False;
  btnVendasClientes.Enabled   := False;
  btnQuaCli.Enabled           := False;
  btnMediasCliente.Enabled    := False;
  BtnVendaNormal.Enabled      := False;
  btnPromocoes.Enabled        := False;
  btnVenSisAnt.Enabled        := False;
  btnHisDeb.Enabled           := False;
  btnResFin.Enabled           := False;
  btnAddContato.Enabled       := False;
  btnBxEntFut.Enabled         := False;
end;

procedure TfrmCRM.pDesabilitaMenusBotoesLiberaPedido;
begin
  pDesabilitaMenusLiberaPedido;
  pDesabilitaBotoesLiberaPedido;
end;

procedure TfrmCRM.pDesabilitaMenusLiberaPedido;
begin
  mnuEfetivarOrcamento.Visible := False;
  mnuGerarVendaPerdida.Visible := False;
  mnuDesmembrar.Visible := False;
  mnuModificarCategoria.Visible := False;
  mnuBaixar.Visible := False;
  mnuDocumentosConfirmacao.Visible := False;
  mnuLimparSeparacao.Visible := False;
  mnuRetirarVinculoReq_Transf.Visible := False;
end;

procedure TfrmCRM.pFecharDataSets;
begin
  cdsCliente.Close;
  cdsContatos.Close;
  cdsEnderecos.Close;
  cdsGrupoOcorr.Close;
  cdsMovOcorr.Close;
  cdsLeadsCateg.Close;
end;

procedure TfrmCRM.pFiltraOcorrencias(strCodGoc, strCodCli: String);
var
  qryConsulta: TUniQuery;
  lstAux: TStrings;
  blnExibeImagem: Boolean;
  blnOcorrenciaPD: Boolean;
  blnOcorrenciaOR: Boolean;
  blnOcorrenciaAppTaEnt: Boolean;
  dtaTmp: TDateTime;
begin
  pConfiguraIconeStatus;

  lstAux := TStringList.Create();
  blnExibeImagem := False;
  try
    qryConsulta := fCriaQuery(nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLInformacoesOcorrencias(IfThen(blnProspecto, 'P', 'C')));
      SQL.Add(' AND (OCO_DTACON >= :OCODIA OR OCO_DTACON IS NULL)');
      dtaTmp := VS_Date;
      dtaTmp := dtaTmp - spnFiltroDias.Value;
      ParamByName('OCODIA').AsDateTime := dtaTmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('CODGOC').AsString  := strCodGoc;
      UniDirectional := True;
      ObjectView := True;
      FetchRows := 200;
      Open;

      First;
      cdsMovOcorr.DisableControls;
      cdsMovOcorr.EmptyDataSet;
      cdsMovOcorr.LogChanges := False;

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
        cdsMovOcorrOCO_EMERGE.AsString   := FieldByName('OCO_EMERGE').AsString;
        cdsMovOcorrOCO_C_P_F_.AsString   := FieldByName('OCO_C_P_F_').AsString;

        If DirectoryExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm') Then
        Begin
          If FileExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + cdsMovOcorr.FieldByName('OCO_CODTOC').AsString + '.jpg') Then
          Begin
            Try
              TBlobField(cdsMovOcorr.FieldByName('IMAGEM1')).LoadFromFile(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + cdsMovOcorr.FieldByName('OCO_CODTOC').AsString + '.jpg');
              blnExibeImagem := True;
            Except
              blnExibeImagem := False;
            End;
          End;
        End;

        cdsMovOcorrOCO_DTALIM.AsDateTime := FieldByName('OCO_DTALIM').AsDateTime;
        cdsMovOcorrNumDoc.AsString       := FieldByName('NUMDOC').AsString;

        cdsMovOcorrOCO_NUMDOC.AsString   := FieldByName('OCO_NUMDOC').AsString;
        cdsMovOcorrOCO_ESPDOC.AsString   := FieldByName('OCO_ESPDOC').AsString;
        cdsMovOcorrOCO_EMPDOC.AsString   := FieldByName('OCO_CODEMP').AsString;

        cdsMovOcorrUSADEPS.AsString      := FieldByName('USADEPS').AsString;
        cdsMovOcorrSTATUSDEPS.AsString   := FieldByName('STATUSDEPS').AsString;
        cdsMovOcorrMOTBAI.AsString       := FieldByName('FGO_MOTBAI').AsString;

        cdsMovOcorrAUTOINCREMFATGOR.AsString := FieldByName('AUTOINCREMFATGOR').AsString;

        cdsMovOcorrCAT_DESCRI.AsString := FieldByName('CAT_DESCRI').AsString;
        cdsMovOcorrCAT_CORCAT.AsString := FieldByName('CAT_CORCAT').AsString;
        cdsMovOcorrCODCND.AsString     := FieldByName('CODCND').AsString;
        cdsMovOcorrCND_DESCRI.AsString := FieldByName('CND_DESCRI').AsString;

        //Controle dos atrasos
        cdsMovOcorrHOREXC.AsFloat       := FieldByName('OCO_HOREXC').AsFloat;
        cdsMovOcorrOCO_TMPLIM.AsFloat   := FieldByName('OCO_TMPLIM').AsFloat;
        cdsMovOcorrOCO_METLIM.AsFloat   := FieldByName('OCO_METLIM').AsFloat;
        cdsMovOcorrOCO_CODSIT.AsString  := FieldByName('OCO_CODSIT').AsString;
        cdsMovOcorrFGO_VLRCON.AsFloat   := FieldByName('FGO_VLRCON').AsFloat;
        cdsMovOcorrNUMCMP.AsString      := FieldByName('NUMCMP').AsString;
        cdsMovOcorrENTRET.AsString      := FieldByName('ENTRET').AsString;
        cdsMovOcorrCLILOJ.AsString      := FieldByName('CLILOJ').AsString;
        cdsMovOcorrSTATUS.AsString      := FieldByName('STATUS').AsString;
        cdsMovOcorrFGO_STATUS.AsInteger := FieldByName('FGO_STATUS').AsInteger;
        cdsMovOcorrDOCCON.AsString      := FieldByName('DOCCON').AsString;
        cdsMovOcorrESPDOC.AsString      := FieldByName('ESPDOC').AsString;
        cdsMovOcorrOCO_SEQLAG.AsString  := FieldByName('OCO_SEQLAG').AsString;
        cdsMovOcorrCODCOC.AsString      := FieldByName('CODCOC').AsString;
        cdsMovOcorrNOMCON.AsString      := FieldByName('NOMCON').AsString;
        cdsMovOcorrFGO_NUMPOK.AsString  := FieldByName('FGO_NUMPOK').AsString;
        cdsMovOcorrCLIDOC.AsString      := IIF(Not fEmptyStr(FieldByName('GERCLI').AsString), FieldByName('GERCLI').AsString, FieldByName('FGOCLI').AsString);
        cdsMovOcorrHIS_SITOCO.AsString  := FieldByName('HIS_SITOCO').AsString;
        cdsMovOcorrTELCON.AsString      := FieldByName('TELCON').AsString;
        cdsMovOcorrTELCON.EditMask      := fRetMascaraFonePais;

        cdsMovOcorrFGO_JAFATU.AsInteger := FieldByName('FGO_JAFATU').AsInteger;

        cdsMovOcorr.Post;

        qryConsulta.Next;
      end;

      blnOcorrenciaPD := (strCodGoc = fCampoTabela('TOC_CODGOC', 'CADTOC', ['TOC_CODTOC'], [fCfgSis('VENPED', varString)]));
      blnOcorrenciaOR := (strCodGoc = fCampoTabela('TOC_CODGOC', 'CADTOC', ['TOC_CODTOC'], [fCfgSis('VENORC', varString)]));
      blnOcorrenciaAppTaEnt := (strCodGoc = fCampoTabela('GOC_CODGOC', 'CADGOC', ['GOC_DESGOC'], ['APP ENTREGA ROMANEIO']));

      dbgMovOcorrDBTableView1IMAGEM1.Visible := blnExibeImagem;
      dbgMovOcorrDBTableView1STATUS.Visible := (fCfgSis('EXISTA', VarBoolean) And (blnOcorrenciaPD Or blnOcorrenciaAppTaEnt));
      If dbgMovOcorrDBTableView1STATUS.Visible Then
        dbgMovOcorrDBTableView1STATUS.Index := IIF(dbgMovOcorrDBTableView1IMAGEM1.Visible, 1, 0);

      dbgMovOcorrDBTableView1NUMCMP.Visible := blnOcorrenciaPD Or blnOcorrenciaOR;
      dbgMovOcorrDBTableView1ENTRET.Visible := blnOcorrenciaPD Or blnOcorrenciaOR Or blnOcorrenciaAppTaEnt;
      dbgMovOcorrDBTableView1CLILOJ.Visible := (blnOcorrenciaPD Or blnOcorrenciaOR)
                                               And fCfgSis('CLILOJ', varBoolean);

      dbgMovOcorrDBTableView1DOCCON.Visible := (blnOcorrenciaPD Or blnOcorrenciaOR Or blnOcorrenciaAppTaEnt);
      If dbgMovOcorrDBTableView1DOCCON.Visible Then
        dbgMovOcorrDBTableView1DOCCON.Width   := dbgMovOcorrDBTableView1NumDoc.Width;

      tmrSistemaDEPS.Enabled := fCfgSis('USADEP') = 'S';

      dbgMovOcorrDBTableView1FGO_NUMPOK.Visible := blnOcorrenciaPD Or blnOcorrenciaAppTaEnt;
      dbgMovOcorrDBTableView1FGO_NUMPOK.Index   := dbgMovOcorrDBTableView1OCO_NUMDOC.Index + 1;



    end;

    cdsMovOcorr.Filtered := False;

    If mskNumCgc.Visible And Not fEmptyStr(mskNumCgc.Text) Then
    Begin
      cdsMovOcorr.Filter   := 'OCO_C_P_F_ = ' + QuotedStr(mskNumCgc.Text);
      cdsMovOcorr.Filtered := True;
    End;

    If strCodGoc <> cdsGrupoOcorrGOC_CODGOC.AsString Then
      cdsGrupoOcorr.Locate('GOC_CODGOC', strCodGoc, []);

  finally
    cdsMovOcorr.EnableControls;
    FreeAndNil(qryConsulta);
    lstAux.Free;
  end;
end;

procedure TfrmCRM.pHabilitaBotoesPanelSuperiorCrm;
begin
  btnNovaOcorrencia.Enabled   := True;
  btnOrcamento.Enabled        := True;
  btnPedido.Enabled           := True;
//  btnLocalizarOcorr.Enabled   := True;
  btnEmailDevDac.Enabled      := True;
  btnArquivosCadastro.Enabled := True;
  btnArquivosCobranca.Enabled := True;
  btnRelAD.Enabled            := True;
  btnFichaCadastral.Enabled   := True;
  btnVendasClientes.Enabled   := True;
  btnQuaCli.Enabled           := True;
  btnMediasCliente.Enabled    := True;
  BtnVendaNormal.Enabled      := True;
  btnPromocoes.Enabled        := True;
  btnVenSisAnt.Enabled        := True;
  btnHisDeb.Enabled := fVerificaAcessoSistema('ACEF6_', strLoginUsuarioLogado);
  btnResFin.Enabled := fVerificaAcessoSistema('ACEF7_', strLoginUsuarioLogado);
  btnAddContato.Enabled       := True;
  btnBxEntFut.Enabled         := fVerificaAcessoSistema('CRMBEF', strLoginUsuarioLogado);
end;

procedure TfrmCRM.pIncluirNovaOcorrencia;
var
  frmCadMovOcorrencias : TfrmCadMovOcorrencias;
begin
  Try
    pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);
    frmCadMovOcorrencias.strTip_FC := IfThen(blnProspecto,'P', 'C');
    frmCadMovOcorrencias.strCodCli := cdsCliente.FieldByName('CLI_CODCLI').AsString;
    frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;    
    frmCadMovOcorrencias.strOperac := 'Inserir';
    frmCadMovOcorrencias.strCpfCli := mskNumCgc.Text;
    frmCadMovOcorrencias.ShowModal;
    strCodGoc := frmCadMovOcorrencias.strCodGoc;
  Finally
    FreeAndNil(frmCadMovOcorrencias);
    pSetFocus(dbgGrupoOcorr);
  End;
end;

procedure TfrmCRM.pIncluirNovoHistoricoOcorrenciaInternal;
  Var
    LCodGoc: String;
begin
  try
    pTrataExibicaoMenus();
    strCodOco := cdsMovOcorr.FieldByName('OCO_CODOCO').AsString;
    pIncluirNovoHistoricoOcorrencia(cdsMovOcorr.FieldByName('OCO_CODOCO').AsString,
                                    cdsMovOcorr.FieldByName('OCO_PROTOC').AsString,
                                    IfThen(blnProspecto,'P', 'C'),
                                    cdsMovOcorr.FieldByName('OCO_CODCLI').AsString,
                                    cdsMovOcorr.FieldByName('OCO_CODEMP').AsString,
                                    cdsMovOcorr.FieldByName('OCO_CODSIT').AsString,
                                    cdsMovOcorr.FieldByName('OCO_DTALIM').AsDateTime,
                                    mnuEfetivarOrcamento.Visible,
                                    mnuGerarVendaPerdida.Visible,
                                    LCodGoc,
                                    cdsMovOcorr.FieldByName('OCO_C_P_F_').AsString,
                                    cdsMovOcorr.FieldByName('CODCOC').AsString,
                                    mnuAlterarDocumento.Visible);
    strCodGoc := LCodGoc;
  finally
    pSetFocus(dbgMovOcorr);
  end;
end;

procedure TfrmCRM.pLimparCliente;
begin
  If blnProspecto Then
    Exit;

  If (fCfgSis('LCLCRM', varBoolean)) Then
  Begin
    edtCodCli.Clear;
    edtDesCodCli.Clear;
    cdsCliente.EmptyDataSet;
    cdsContatos.EmptyDataSet;
    cdsEnderecos.EmptyDataSet;
    cdsFazendas.EmptyDataSet;
    cdsGrupoOcorr.EmptyDataSet;
    cdsMovOcorr.EmptyDataSet;
    cdsLeadsCateg.EmptyDataSet;
  End;
end;

procedure TfrmCRM.pLimparDataSets;
begin
  cdsCliente.EmptyDataSet;
  cdsContatos.EmptyDataSet;
  cdsEnderecos.EmptyDataSet;
  cdsGrupoOcorr.EmptyDataSet;
  cdsMovOcorr.EmptyDataSet;
end;

procedure TfrmCRM.pLocalizaGruposOcorrenciaSolicitada;
begin
  cdsGrupoOcorr.Locate('GOC_CODGOC',FCodGoc,[]);
end;

procedure TfrmCRM.pLocalizaOcorrenciaSolicitada;
begin
  cdsMovOcorr.Locate('OCO_CODOCO',strCodOco,[]);
end;

procedure TfrmCRM.pnlCompromissosClick(Sender: TObject);
Var
  Key: Char;
  frmCompromissos: TfrmCompromissos;
begin
  Try
    Key := #13;
    Try
      pCriarFormularios(TfrmCompromissos, frmCompromissos);
      frmCompromissos.edtCodOpe.Text := strLoginUsuarioLogado;
      frmCompromissos.edtCodOpeKeyPress(frmCompromissos.edtCodOpe, Key);
      frmCompromissos.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        Exit;
      End;
    End;
  Finally
    pFreeAndNil(frmCompromissos);
  End;
end;

procedure TfrmCRM.popOcorrenciasPopup(Sender: TObject);
begin
  if Not VerificarAcessoClienteOrdemDeProducaoInd Then
    Abort;

  inherited;
end;

procedure TfrmCRM.pAguarde(AProc: TGenericProcedure);
begin
  Application.ProcessMessages;
  Try
    If InterlockedIncrement(intConfirmando) = 0 Then
      fExecutarModal(AProc, 'Aguarde ...', '');
  Finally
    InterlockedDecrement(intConfirmando);
  End;
end;

procedure TfrmCRM.pSetaParametrosBotaoCliente(strNomCampo, strModulo: String; strDesCampo: string = ''; blnArqCli: Boolean = False);
begin

  If Not fVerificaAcessoSistema('frmCadClientes') Then
  Begin
    fMensagem('ATENÇÃO!', 'Você não tem permissão de acesso ao cadastro de clientes!', ['&Ok']);
    Exit;
  End;

  If (strModulo = 'Contatos') And (Not fVerificaAcessoSistema('CLICON', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você não tem permissão de acesso a aba Contatos!', ['&Ok']);
    Exit;
  End;

  If (strModulo = 'Contatos') And (Not fVerificaAcessoSistema('ALTCNT', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso para alterar contatos de Clientes!', ['&Ok']);
    Exit;
  End;

  If blnProspecto Then
  Begin
    pSetaParametrosBotaoProspecto('PRO' + RightStr(strNomCampo, 7), strModulo, strDesCampo, blnArqCli);
    Exit;
  End;

  If InterlockedIncrement(intConfirmando) = 0 Then
  Begin
    try
      pCriarFormularios(TfrmCadClientes,frmCadClientes);
      frmCadClientes.pSetaParametrosCRM(strNomCampo, Self.edtCodCli.Text, strModulo, strDesCampo, blnArqCli);
      frmCadClientes.ShowModal;
      InterlockedDecrement(intConfirmando);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intConfirmando);
        pMensagensErro(E.Message, '');
      End;
    end;
    pFreeAndNil(frmCadClientes);
  End
  Else
    InterlockedDecrement(intConfirmando);

  If (Not blnProspecto) Then
    fValidaCampos(Self.edtCodCli,True);

end;

procedure TfrmCRM.pSetaParametrosBotaoProspecto(strNomCampo, strModulo: String; strDesCampo: string = ''; blnArqCli: Boolean = False);
  Var
    frmCadProspectos: TfrmCadProspectos;
begin
  If InterlockedIncrement(intConfirmando) = 0 Then
  Begin
    try
      pCriarFormularios(TfrmCadProspectos,frmCadProspectos);
      frmCadProspectos.pSetaParametrosCRM(strNomCampo, Self.edtCodCli.Text, strModulo, strDesCampo);
      frmCadProspectos.ShowModal;
      InterlockedDecrement(intConfirmando);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intConfirmando);
        pMensagensErro(E.Message, '');
      End;
    end;
    pFreeAndNil(frmCadProspectos);
  End
  Else
    InterlockedDecrement(intConfirmando);
end;

procedure TfrmCRM.pSetarFocoBotao;
var
  intFocBtn: Integer;
begin
  blnMudarFoco := False;
  intFocBtn := fCfgSis('FOCBTN', varInteger);

  If fCfgSis('CRMMED', varBoolean) Then
  Begin
    btnMediasCliente.Click;
    Exit;
  End;

  If (intFocBtn = 4) and (not BtnVendaNormal.CanFocus) Then
    intFocBtn := 2;

  If edtCgcCpf.Visible Then
    pSetFocus(edtCgcCpf)
  Else
  Begin
    Case intFocBtn of
      1: pSetFocus(btnNovaOcorrencia);
      2: pSetFocus(btnOrcamento);
      3: pSetFocus(btnPedido);
      4: pSetFocus(BtnVendaNormal);
    Else
        pSetFocus(btnOrcamento);
    End;
  End;
end;

procedure TfrmCRM.pTrataExibicaoMenus;
begin
  pExibirAbrirOcorrencia;
  pExibirEnviarOcoEmail;
  pExibirGerarPDF;
  pExibirGerarDANFEEmPDF;
  pExibirReimprimir;
  pExibirBaixar();
  pExibirAlterar();
  pExibirDesmembrar();
  pExibirModificarCategoria();
  pExibirEfetivarOrcamento();
  pExibirGerarVendaPerdida();
  pExibirDocumentosConfirmacao();
  pExibirRetirarVinculoReq_Transf();
  pExibirValidacaoSistemaDEPS();
  pExibeLimparSeparacao();
  pExibirFaturarEmVendaNormal();
  pExibirCadastroLeads;
end;

procedure TfrmCRM.pVerificaCamposVisiveisClientes;
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
      SQL.Add('   FROM CLICRM      ');
      SQL.Add('  WHERE CRM_CODEMP = :CODEMP ');
      SQL.Add('    AND CRM_TIP_FC = "C" ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
        pCamposVisiveisClientes(qryCons);

    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCRM.mnuReimprimirClick(Sender: TObject);
begin
  pAguarde(pReimprimir);
end;

procedure TfrmCRM.pReimprimir;
  Var
    strNomeArquivo: String;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    blnQtdOri : Boolean;
    strNumPed,
    strEspDoc,
    strCodEmp : String;
    frmFatMenuPrecoQtde: TfrmFatMenuPrecoQtde;
    blnPedidoBaixadoTotalmente: Boolean;

begin
  inherited;

  blnQtdOri := True;

  blnPedidoBaixadoTotalmente := fPedidoBaixadoTotalmente(LeftStr(cdsMovOcorrNUMDOC.asString, 12),
                                                         cdsMovOcorrESPDOC.asString,
                                                         RightStr(cdsMovOcorrNUMDOC.asString, 3));

  If (pnlOcorrencias.Enabled) And (Not cdsMovOcorr.IsEmpty) And
     (Not fEmptyStr(cdsMovOcorrNumDoc.AsString)) Then
  Begin

    strNumPed := LeftStr(cdsMovOcorrNumDoc.AsString, 12);
    strCodEmp := RightStr(cdsMovOcorrNumDoc.AsString, 3);

    If (Pos('OR', cdsMovOcorrNumDoc.AsString) > 0) Then
      strEspDoc := 'OR'

    Else If (Pos('PD', cdsMovOcorrNumDoc.AsString) > 0) Then
      strEspDoc := 'PD';

    opcComSemPreco := impComPrecoGeral;

    If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And Not fCfgSis('ORSPSM', varBoolean, VS_strCodEmp) Then // Sim e Não
    Begin

      Try
        pCriarFormularios(TfrmFatMenuPrecoQtde, frmFatMenuPrecoQtde);

        If (blnPedidoBaixadoTotalmente) then
        begin
          blnQtdOri := True;
          frmFatMenuPrecoQtde.rdgQtde.ItemIndex := 0;
          frmFatMenuPrecoQtde.rdgQtde.Enabled := False;
        end
        Else
          blnQtdOri := False;

        frmFatMenuPrecoQtde.showModal;
        opcComSemPreco := IIF((frmFatMenuPrecoQtde.rdgPreco.ItemIndex = 0), impComPrecoGeral, impSemPrecoGeral);
        blnQtdOri := (frmFatMenuPrecoQtde.rdgQtde.ItemIndex  = 0);
        If (Not fEmptyStr(fCfgSis('SENPRE'))) And (frmFatMenuPrecoQtde.rdgPreco.ItemIndex = 0) Then
          opcComSemPreco := IIF(fMSG_SenhaImprimirComPrecoCRM(strNumPed, strEspDoc, strCodEmp), opcComSemPreco, impSemPrecoGeral);
      Finally
        pFreeAndNil(frmFatMenuPrecoQtde);
      End;

    End
    Else If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And fCfgSis('ORSPSM', varBoolean, VS_strCodEmp) Then //Sim e Sim
    Begin

      Case fGetMenu('Opção:',['Com Preço e Com Marca', 'Com Preço e Sem Marca', 'Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
        1:opcComSemPreco := impComPrecoComMarca;
        2:opcComSemPreco := impComPrecoSemMarca;
        3:opcComSemPreco := impSemPrecoComMarca;
        4:opcComSemPreco := impSemPrecoSemMarca;
      End;

      If (Not fEmptyStr(fCfgSis('SENPRE'))) And (opcComSemPreco in [impComPrecoComMarca, impComPrecoGeral, impComPrecoSemMarca]) Then
      Begin
        opcComSemPreco := IIF(fMSG_SenhaImprimirComPrecoCRM(strNumPed, strEspDoc, strCodEmp), opcComSemPreco, impSemPrecoGeral);
        If (opcComSemPreco = impSemPrecoGeral) Then
        Begin
          Case fGetMenu('Opção para geração do PDF ("Sem Preço" pois não houve liberação!)',['Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
            1:opcComSemPreco := impSemPrecoComMarca;
            2:opcComSemPreco := impSemPrecoSemMarca;
          End;
        End;
      End;

    End;

    If fEmptyStr(IIf(strEspDoc='OR', fCfgSis('PDFOSP', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)), fCfgSis('PDFPSP', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)))) Or
       fEmptyStr(IIf(strEspDoc='OR', fCfgSis('PDFSPO', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)), fCfgSis('PDFSPP', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)))) Then
      pMensagemOk('Não foi encontrado o layout para a geração de PDF!' + #13#10 +
                  'Será utilizado o layout padrão para essa ação.' + #13#10 +
                  'Verifique as configurações: PDFOSP, PDFSPO, PDFPSP e PDFSPP');

    If Not fVerificaAcessoSistema('IMPDCP', strLoginUsuarioLogado) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!' + #13#10 +
                            'IMPDCP: permitir impressão de documento com preço', ['&Ok']);
      Exit;
    End;

    TFatVenda.pAtualizacaoCotacaoDolar(LeftStr(cdsMovOcorrNUMDOC.AsString, 12),
                                       Copy(cdsMovOcorrNUMDOC.AsString, 14, 02),
                                       Copy(cdsMovOcorrNUMDOC.AsString, 17, 03));

    pImprimeFatImp('FATGOR',
                   LeftStr(cdsMovOcorrNUMDOC.AsString, 12),
                   Copy(cdsMovOcorrNUMDOC.AsString, 14, 02),
                   Copy(cdsMovOcorrNUMDOC.AsString, 17, 03),
                   edtCodCli.Text,
                   'C',
                   '',
                   True,
                   strNomeArquivo,
                   False,
                   'I',
                   1,
                   opcComSemPreco,
                   0,
                   False,
                   False,
                   True,
                   blnQtdOri);
  End;

end;

procedure TfrmCRM.mnuRetirarVinculoReq_TransfClick(Sender: TObject);
begin
  inherited;
  pExibirRetirarVinculoReq_Transf();

  If (Not mnuRetirarVinculoReq_Transf.Visible) Then
    Exit;

  pRetirarVinculoReq_Transf(cdsMovOcorrNUMDOC.AsString);

  cdsGrupoOcorrAfterScroll(nil);
end;

procedure TfrmCRM.mnuDocumentosConfirmacaoClick(Sender: TObject);
var
  strAux: TStringList;
begin
  inherited;

  pExibirDocumentosConfirmacao();

  If (Not mnuDocumentosConfirmacao.Visible) Then
    Exit;

  strAux := TStringList.Create();
  pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

  Try
    strAux.Text := AnsiReplaceStr(cdsMovOcorrDOCCON.AsString, ',', #13#10);
    strAux.Sort();

    frmMensagemExplicativa.Caption := 'Documento(s) de Confirmação';
    frmMensagemExplicativa.Width   := 350;
    frmMensagemExplicativa.Height  := 200;
    frmMensagemExplicativa.mmoInstru.Text := strAux.Text;
    frmMensagemExplicativa.ShowModal;
    Exit;
  Finally
    FreeAndNil(frmMensagemExplicativa);
  End;
end;

procedure TfrmCRM.setCodGoc(const Value: String);
begin
  If (FCodGoc <> Value) Then
    FCodGoc := Value;
end;

procedure TfrmCRM.spnFiltroDiasChange(Sender: TObject);
begin
  inherited;
  If spnFiltroDias.Focused Then
    cdsGrupoOcorrAfterScroll(cdsGrupoOcorr);
end;

procedure TfrmCRM.tmrCompromissosTimer(Sender: TObject);
begin
  inherited;
  tmrCompromissos.Enabled := False;
  Try
    If fInTransaction Then
      Exit;
    If fExitemCompromissos Then
    Begin
      pnlCompromissos.Caption := 'Exitem Compromissos Vencidos';
      pnlCompromissos.Visible := True;
      pnlCompromissos.Refresh;
    End
    Else
      pnlCompromissos.Visible := False;
  Finally
    tmrCompromissos.Enabled := True;
  End;
end;

procedure TfrmCRM.tmrHoraTimer(Sender: TObject);
begin
  inherited;
  pnlHora.Caption := FormatDateTime('hh:mm:ss', fTime());
  pnlData.Caption := FormatDateTime('dd/mm/yyyy', VS_Date);
end;

procedure TfrmCRM.tmrSistemaDEPSTimer(Sender: TObject);
begin
  inherited;
  tmrSistemaDEPS.Enabled := False;
  pAtualizarStatusDEPSOrcamentos(cdsMovOcorr);
  tmrSistemaDEPS.Enabled := True;
end;

function TfrmCRM.VerificarAcessoClienteOrdemDeProducaoInd: Boolean;
begin
  result := VerificarAcessoClienteOrdemDeProducaoIndustrial(edtCodCli.text);
end;

procedure TfrmCRM.btnArquivosCobrancaClick(Sender: TObject);
    function fPastaConsultaCreditos: String;
    begin
      Result := ExtractFilePath(Application.ExeName)+ 'CONSULTA_CREDITO\' + edtCodCli.Text;
    end;
begin
  If fVerificaAcessoSistema('CRMVCC') Then
  Begin
    inherited;
    //pSetaParametrosBotaoCliente('','Clientes','btnAbrirPastaCredito',True);
    If (edtCodCli.Text = '') Then
      Exit;

    if Not VerificarAcessoClienteOrdemDeProducaoInd Then
      exit;

    Try
      pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
      frmGravaArquivoPasta.strCaminhoPasta := fPastaConsultaCreditos;
      frmGravaArquivoPasta.Caption         := 'Pasta ( Consulta de Créditos )';
      frmGravaArquivoPasta.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmGravaArquivoPasta);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnBxEntFutClick(Sender: TObject);
var
  frmFatBaixaEntregaFutura: TfrmFatBaixaEntregaFutura;
begin
  inherited;

  If Not fVerificaAcessoSistema('CRMBEF') Then
  Begin
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
    Exit;
  End;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Cliente não informado!', ['&OK']);
    Exit;
  End;

  pCriarFormularios(TfrmFatBaixaEntregaFutura, frmFatBaixaEntregaFutura);
  Try
    frmFatBaixaEntregaFutura.edtCodCliente.Text := edtCodCli.Text;
    frmFatBaixaEntregaFutura.blnModoCrm := True;

    frmFatBaixaEntregaFutura.ShowModal();
  Finally
    pFreeAndNil(frmFatBaixaEntregaFutura);
  End;

end;

procedure TfrmCRM.btnCadClienteClick(Sender: TObject);
begin
  inherited;

  pAbreCadastroCliente(VK_Insert);
end;

procedure TfrmCRM.btnCadLeadsClick(Sender: TObject);
begin
  inherited;

  If not VerificarAcessoClienteOrdemDeProducaoInd Then
    Exit;

  TfrmCadLeads.fCadLeads(edtCodCli.Text, pOrcamentoClick, pSetNumLead, '', IfThen(blnProspecto,'P', 'C'));
end;

procedure TfrmCRM.btnCadProspectoClick(Sender: TObject);
begin
  inherited;

  pAbreCadastroProspecto(VK_Insert);
end;

procedure TfrmCRM.btnCliOutroVendedorClick(Sender: TObject);
var
  frmFatDigCnpj: TfrmFatDigCnpj;
  strCodVen: String;
  blnTrava: Boolean;
  strCodCliTmp: String;
  blnLiberado: Boolean;
  blnConsumidor: Boolean;
begin
  inherited;

  blnBloquCpfCnpj := btnCliOutroVendedor.Visible;

  pCriarFormularios(TfrmFatDigCnpj, frmFatDigCnpj);
  Try
    frmFatDigCnpj.blnCRM       := True;
    frmFatDigCnpj.blnProspecto := blnProspecto;
    frmFatDigCnpj.blnListarClientes := True;
    frmFatDigCnpj.ShowModal();
    If ((frmFatDigCnpj.ModalResult = MrOk) And (Not fEmptyStr(frmFatDigCnpj.strCodCli))) Then
    Begin
      strCodCliTmp := frmFatDigCnpj.strCodCli;

      If blnProspecto Then
      Begin
        strCodVen := fCampoTabela('PRO_CODVEN', 'PROSPE', ['PRO_CODPRO'], [strCodCliTmp]);
        blnTrava := (fEmptyStr(strCodVen)) Or (strCodVen <> strLoginUsuarioLogado);
      End
      Else
      Begin
        strCodVen := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [strCodCliTmp]);
        blnTrava := (fEmptyStr(strCodVen)) Or (strCodVen <> strLoginUsuarioLogado);
      End;

      blnConsumidor := fClienteConsumidor(fRetNomCliente(strCodCliTmp));

      If blnTrava And (Not blnConsumidor) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Acessar CRM do ' + IIF(not blnProspecto,'Cliente','Prospecto') + ' de outro vendedor ');
        objLiberacao.objMsgLibera.pAddTextoCaption(IIF(not blnProspecto,'Cliente','Prospecto'), strCodCliTmp + ' - ' + IIF(not blnProspecto, fRetNomCliente(strCodCliTmp), fRetNomProspecto(strCodCliTmp)));
        objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor cadastrado'                      , strCodVen + '  - ' + fRetNomVendRep(strCodVen));
        objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor Atual'                           , strLoginUsuarioLogado + '  - ' + fRetNomVendRep(strLoginUsuarioLogado));

        objLiberacao.strDirAce := IIF(not blnProspecto,'CRMVCL','CRMVPR');
        objLiberacao.strMsgSen := 'Acessar CRM do ' + IIF(not blnProspecto,'Cliente','Prospecto') + ' de outro vendedor';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        blnLiberado :=  objLiberacao.fLibera;
      End
      Else
        blnLiberado := True;

      If blnLiberado Then
      Begin
        blnBloquCpfCnpj := False;
        edtCodCli.Text := strCodCliTmp;
        fValidaCampos(edtCodCli, True);
      End
      Else
        edtCodCli.Text := EmptyStr;
    End;
  Finally
    pFreeAndNil(frmFatDigCnpj);
  End;
end;

procedure TfrmCRM.pSetNumLead(strNumLead : String);
Begin
  Self.strNLeads := strNumLead;
End;

procedure TfrmCRM.btnConsertoEquipClick(Sender: TObject);
var
  frmConEqu: TfrmFatManConsertoEquip;
  frmFluxo: TfrmFatManConsertoFluxoProcesso;
begin
  If (Not btnConsertoEquip.Visible) Then
    Exit;

  if fCfgSis('EQFLXP', varBoolean) then
  begin
    if not fVerificaAcessoSistema('frmFatManConsertoFluxoProcesso') then
    begin
      fMensagem('Atenção', 'Usuário logado não tem direito de acesso a esta rotina!', ['&OK']);
      pSetFocus(edtCodCli);
      Exit;
    end;

    inherited;

    try
      pCriarFormularios(TfrmFatManConsertoFluxoProcesso, frmFluxo);

      try
        frmFluxo.ShowModal();
      except
        On E: Exception do
          pMensagensErro(E.Message,'btnConsertoEquipClick');
      end;
    finally
      pFreeAndNil(frmFluxo);
    end;
  end
  else
  begin
    if not fVerificaAcessoSistema('frmFatManConsertoEquip') then
    begin
      fMensagem('Atenção', 'Usuário logado não tem direito de acesso a esta rotina!', ['&OK']);
      pSetFocus(edtCodCli);
      Exit;
    end;

    inherited;

    try
      pCriarFormularios(TfrmFatManConsertoEquip, frmConEqu);

      try
        frmConEqu.ShowModal();
      except
        On E: Exception do
          pMensagensErro(E.Message,'btnConsertoEquipClick');
      end;
    finally
      pFreeAndNil(frmConEqu);
    end;
  end;
end;

procedure TfrmCRM.btnConsumiveisClick(Sender: TObject);
begin
  If (Not btnConsumiveis.Visible) Then
    Exit;

  If fVerificaAcessoSistema('CRMOCN') Then
  Begin
    inherited;

    If (fEmptyStr(edtCodCli.Text)) Then
    Begin
      fMensagem('ALERTA', 'Não há um cliente informado para acionar a rotina de Oferta de Consumíveis. Operação cancelada!', ['&OK']);
      pSetFocus(edtCodCli);
      Exit;
    End;

    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;

    Try
      pCriarFormularios(TfrmImpulsionadorVendasCRM, frmImpulsionadorVendasCRM);

      Try
        frmImpulsionadorVendasCRM.strCodCli := edtCodCli.Text;
        frmImpulsionadorVendasCRM.ShowModal();
      Except
        On E: Exception Do
          pMensagensErro(E.Message,'btnFichaCadastralClick');
      End;
    Finally
      pFreeAndNil(frmImpulsionadorVendasCRM);
    End;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnEmailDevDacClick(Sender: TObject);
begin
  If Not btnEmailDevDac.Enabled Then
    Exit;
  If fVerificaAcessoSistema('CRMEMA') Then
  Begin
    inherited;
    if (btnEmailDevDac.Enabled) and (not cdsCliente.IsEmpty) then
    begin
      If not VerificarAcessoClienteOrdemDeProducaoInd Then
        Exit;

      pChamaEmailDac;
    end;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnFichaCadastralClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMFCA') Then
  Begin
    inherited;
    Try
      if Not VerificarAcessoClienteOrdemDeProducaoInd Then
        exit;

      pCriarFormularios(TfrmCadClientes,frmCadClientes);
      frmCadClientes.strCliCRM := edtCodCli.Text;
      frmCadClientes.pPesquisaClienteCRM;
      frmCadClientes.btnFichaCliClick(Sender);
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'btnFichaCadastralClick');
    End;
    pFreeAndNil(frmCadClientes);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnGeracaoOcorrenciasClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMGGO') Then
  Begin
    inherited;
    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;

    If Not btnGeracaoOcorrencias.Visible Then Exit;

    If blnProspecto Then
      pCriarForm(TfrmCRMGeracaoGlobalProspecto, frmCRMGeracaoGlobalProspecto)
    Else
    Begin
      pCriarFormularios(TfrmCRMGeracaoGlobal, frmCRMGeracaoGlobal);
      Try
        frmCRMGeracaoGlobal.strCodCli := edtCodCli.Text;
        frmCRMGeracaoGlobal.ShowModal();
      Finally
        pFreeAndNil(frmCRMGeracaoGlobal);
      End;
    End;

    pCarregaInformacoesOcorrencias;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;


procedure TfrmCRM.btnRelOcorrenciasCRMClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMROC') Then
  Begin

    inherited;

    STR_CRM_TIP_PC := IfThen(blnProspecto, 'PROSPECTO','CLIENTE');

    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(8, 1237, [1237,1241],
                          ['CODCLI'],
                          [edtCodCli.Text],
                          Sender);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnRelSituacaoVendasCRMClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMRSV') Then
  Begin
    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;


    inherited;
    STR_CRM_TIP_PC := IfThen(blnProspecto, 'PROSPECTO','CLIENTE');

    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(10, 1253, [1253,1255],
                          ['CODCLI'],
                          [edtCodCli.Text],
                          Sender);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnResFinClick(Sender: TObject);
Var
  frmResFinanceiro: TfrmResFinanceiro;
begin

  inherited;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
  Try
    Try
      frmResFinanceiro.strCodCli := edtCodCli.Text;
      frmResFinanceiro.pSetaAjusteData( fMensagem('Ajuste de Datas',
                                                  'Ajusta vencimentos considerando Sábado/Domingo/Feriados?',
                                                  ['&Sim','&Não'],2) = 1 );
      frmResFinanceiro.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCRM.btnResFinClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmResFinanceiro);
  End;
end;

procedure TfrmCRM.BtnVendaNormalClick(Sender: TObject);
begin
  pAguarde(pVendaNormal);
end;

procedure TfrmCRM.pVendaNormal;
begin
  If Not BtnVendaNormal.Enabled Then
    Exit;

  If fVerificaAcessoSistema('CRMVDN') Then
  Begin

  inherited;

    if (BtnVendaNormal.Enabled) And (not cdsCliente.IsEmpty) then
    Begin
      If not VerificarAcessoClienteOrdemDeProducaoInd Then
        Exit;

      pChamaFaturamentoVendaNormal(PopVendaNormal, edtCodCli.Text, '', mskNumCgc.Text);

      If Not fEmptyStr(frmPrincipal.strCodCliGravado) And
         Not SameText(frmPrincipal.strCodCliGravado, edtCodCli.Text) Then
      Begin
        edtCodCli.Text := frmPrincipal.strCodCliGravado;
        fValidaCampos(edtCodCli, True);
      End;

      If (Copy(PopVendaNormal.Items[0].Hint,4,8) <> edtCodCli.Text) Then
      Begin
        edtCodCli.Text := Copy(PopVendaNormal.Items[0].Hint,4,8);
        fValidaCampos(edtCodCli, True);
      End
      Else If (Not fEmptyStr(cdsGrupoOcorrGOC_CODGOC.AsString)) Then
      Begin
        pCarregaInformacoesOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString);
      End;

    End;

    pLimparCliente;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnVendasClientesClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMVEC') Then
  Begin
    inherited;

    STR_CRM_TIP_PC := IfThen(blnProspecto, 'PROSPECTO','CLIENTE');

    if Not VerificarAcessoClienteOrdemDeProducaoInd Then
      exit;

    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(443, 4296, [4296,4297],
                          ['CODCLI'],
                          [edtCodCli.Text],
                          Sender,
                          ['CODCLI']);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnVenSisAntClick(Sender: TObject);
var
  frmFatConsVendasAntigas: TfrmFatConsVendasAntigas;
  Key: Char;
begin
  inherited;
  If Not fVerificaAcessoSistema('VDSIAN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso em Vendas do Sistema Anterior!', ['&O k']);
    Exit;
  End;

  try
    pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
    frmFatConsVendasAntigas.edtCodCliente.Enabled := False;
    frmFatConsVendasAntigas.edtCodCliente.Text := edtCodCli.Text;
    frmFatConsVendasAntigas.edtCodClienteKeyPress(frmFatConsVendasAntigas.edtCodCliente, Key);
    frmFatConsVendasAntigas.ShowModal;
  finally
    pFreeAndNil(frmFatConsVendasAntigas);
  end;
end;

procedure TfrmCRM.mnuCadMsgClick(Sender: TObject);
  Var
    frmMsg: TfrmCadMsg;
begin
  If fVerificaAcessoSistema('CRMMEN') Then
  Begin

    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;

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

procedure TfrmCRM.mnuDesmembrarClick(Sender: TObject);
begin
  inherited;
  pExibirDesmembrar();

  If (Not mnuDesmembrar.Visible) Then
    Exit;

  TfrmGravando.fExecutarModalA(pDesmembrar, 'Aguarde, Realizando ' +
    'desmembramento ...', '');
end;

procedure TfrmCRM.pDesmembrar;
begin
  If fDesmembrarPedOrc(cdsMovOcorrNUMDOC.AsString) Then
    cdsGrupoOcorrAfterScroll(nil);
end;

procedure TfrmCRM.btnPesqLeadsClick(Sender: TObject);
var
  frmConsultaLeadsCRM: TfrmConsultaLeadsCRM;
begin
  inherited;

  pCriarFormularios(TfrmConsultaLeadsCRM, frmConsultaLeadsCRM);

  Try

    If Not cdsCliente.IsEmpty Then
      frmConsultaLeadsCRM.strCodCli := cdsCliente.FieldByName('CLI_CODCLI').AsString;
      frmConsultaLeadsCRM.pChamaOrcamento := pOrcamentoClick;

    frmConsultaLeadsCRM.ShowModal;
    If frmConsultaLeadsCRM.blnConfirma Then
    Begin
      edtCodCli.Text := frmConsultaLeadsCRM.strCodCli;

      If not VerificarAcessoClienteOrdemDeProducaoInd Then
        Exit;

      If fValidaCampos(edtCodCli, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
        {O Método abaixo carrega os dados do cliente direto para a tela de cadastro de Leads}
        TfrmCadLeads.fCadLeads(edtCodCli.Text, pOrcamentoClick, pSetNumLead, frmConsultaLeadsCRM.strNumDoc, IfThen(blnProspecto,'P', 'C'));
      End;


    End;
  Finally
    pFreeAndNil(frmConsultaLeadsCRM);
  End;

end;

procedure TfrmCRM.btnPesquisarMenusClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMPMN') Then
  Begin
    inherited;
    TfrmPesquisarMenu.pPesquisarMenus;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnPromocoesClick(Sender: TObject);
var frmFatSelItensCatalogoPromocoes : TfrmFatSelItensCatalogoPromocoes;
begin
  If (Not btnPromocoes.Visible) Then
    Exit;

  If fVerificaAcessoSistema('CRMPRM') Then
  Begin
    inherited;

    If (fEmptyStr(edtCodCli.Text)) Then
    Begin
      fMensagem('ALERTA', 'Não há um cliente informado para acionar a rotina de Promoções. Operação cancelada!', ['&OK']);
      pSetFocus(edtCodCli);
      Exit;
    End;

    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;


    Try
      pCriarFormularios(TfrmFatSelItensCatalogoPromocoes, frmFatSelItensCatalogoPromocoes);
      Try
        frmFatSelItensCatalogoPromocoes.strCodCli := edtCodCli.Text;
        frmFatSelItensCatalogoPromocoes.ShowModal();
      Except
        On E: Exception Do
          pMensagensErro(E.Message,'btnPromocoesClick');
      End;
    Finally
      pFreeAndNil(frmFatSelItensCatalogoPromocoes);
    End;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnQuaCliClick(Sender: TObject);
begin

  inherited;

  If (edtCodCli.Text = '') Then
    Exit;

  if Not VerificarAcessoClienteOrdemDeProducaoInd Then
    exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(214, 7667, [],
                        ['CODCLI'],
                        [edtCodCli.Text],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCRM.btnAddContatoClick(Sender: TObject);
var
  strCodTmp: String;
  frmCadClientes: TfrmCadClientes;
Begin
  inherited;

  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  strCodTmp := EmptyStr;
  edtCodCli.ReadOnly := True;
  Try
    If Not fVerificaAcessoSistema('frmCadClientes', strLoginUsuarioLogado) Then
    Begin
      fMensagem('ATENÇÃO!','Você não tem permissão de acesso ao cadastro de clientes!', ['&OK']);
      Exit;
    End;

    If Not fEmptyStr(edtCodCli.Text) Then
      strCodTmp := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI'], [fStrZero(edtCodCli.Text, 8)]);

    If fEmptyStr(strCodTmp) Then
    Begin
      fMensagem('ATENÇÃO!','Cliente inválido para inclusão/alteração de contatos!', ['&OK']);
      Exit;
    End;

    If (Not fVerificaAcessoSistema('CLICON', strLoginUsuarioLogado)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Você não tem permissão de acesso a aba Contatos!', ['&Ok']);
      Exit;
    End;

    If (Not fVerificaAcessoSistema('ALTCNT', strLoginUsuarioLogado)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso para alterar contatos de Clientes!', ['&Ok']);
      Exit;
    End;

    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    Try
      Try
        frmCadClientes.strCodClienteIniciarCadastro := strCodTmp;
        frmCadClientes.blnCadContato := True;
        frmCadClientes.ShowModal;
        If Not fEmptyStr(frmCadClientes.strUltimoCodigo) Then
        Begin
          edtCodCli.Text := frmCadClientes.strUltimoCodigo;
          fValidaCampos(Self.edtCodCli,True);
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    Finally
      pFreeAndNil(frmCadClientes);
    End;

  Finally
    edtCodCli.ReadOnly := False;
  End;
End;

procedure TfrmCRM.btnArquivosCadastroClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMVAC') Then
  Begin
    inherited;
    //pSetaParametrosBotaoCliente('','Clientes','btnAbrirPastaCliente',True);
    If (edtCodCli.Text = '') Then
      Exit;

    if Not VerificarAcessoClienteOrdemDeProducaoInd Then
      exit;

    Try
      pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
      frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName) + 'ANEXOS\' + edtCodCli.Text;
      frmGravaArquivoPasta.Caption         := 'Pasta ( Anexos do Cliente )';
      frmGravaArquivoPasta.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmGravaArquivoPasta);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnLocalizarOcorrClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('CRMLOC') Then
  Begin
  inherited;
    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;

//  if (btnLocalizarOcorr.Enabled) And (not cdsCliente.IsEmpty) and (not cdsGrupoOcorr.IsEmpty) then
    pChamaConsultaOcorrenciaCRM;
    pLimparCliente;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnMediasClienteClick(Sender: TObject);
var
  frmCrmMedias: TfrmCrmMedias;
begin
  inherited;

  if Not VerificarAcessoClienteOrdemDeProducaoInd Then
    exit;

  frmCrmMedias := TfrmCrmMedias.Create(Self);
  try
    frmCrmMedias.CodCliente := edtCodCli.Text;
    frmCrmMedias.CliConsumidor := fClienteConsumidor(edtDesCodCli.Text);
    frmCrmMedias.ShowModal;
  finally
    pFreeAndNil(frmCrmMedias);
  end;
end;

procedure TfrmCRM.btnNovaOcorrenciaClick(Sender: TObject);
begin
  If Not btnNovaOcorrencia.Enabled Then
    Exit;
  If fVerificaAcessoSistema('CRMBOC') Then
  Begin
    inherited;
    if (btnNovaOcorrencia.Enabled) and  (not cdsCliente.IsEmpty) and (not cdsGrupoOcorr.IsEmpty) then
    begin
      pIncluirNovaOcorrencia;
      If not fEmptyStr(FCodGoc) Then
      Begin
        pCarregaInformacoesOcorrencias(FCodGoc);
      End;
    end;

    pLimparCliente;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnOrcamentoClick(Sender: TObject);
begin
  pAguarde(pOrcamento);
end;

procedure TfrmCRM.pOrcamento;
Begin
  pOrcamentoClick(btnOrcamento, edtCodCli.Text, strNLeads);
End;

procedure TfrmCRM.pOrcamentoClick(Sender: TObject; ACodCli, ANumLead: string);
var
  strCodCli: String;
begin
  If fEmptyStr(ACodCli) Then
    Exit;

  If fVerificaAcessoSistema('CRMBOR') Then
  Begin
    inherited;
    If blnProspecto And fEmptyStr(fCfgSis('CONCRM', varString)) Then
    Begin
      fMensagem('', 'Para criar um Orçamento para Prospecto é necessário indicar qual o '+
                    'código do Cliente Consumidor para Orçamentos de Prospecto. ("CFG_CONCRM")', ['&OK']);
      Exit;
    End;

    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;

    pChamaFaturamentoOrcamento(popOrcamento, ACodCli, '', blnProspecto, ANumLead, mskNumCgc.Text);

    If blnProspecto Then
      strCodCli := LeftStr(RightStr(popOrcamento.Items[0].Hint, 10),8)
    Else
      strCodCli := Copy(popOrcamento.Items[0].Hint,4,8);

    If Not fEmptyStr(frmPrincipal.strCodCliGravado) And
       Not SameText(frmPrincipal.strCodCliGravado, ACodCli) Then
    Begin
      edtCodCli.Text := frmPrincipal.strCodCliGravado;
      fValidaCampos(edtCodCli, True);
    End;

    If (strCodCli <> ACodCli) Then
    Begin
      edtCodCli.Text := strCodCli;
      fValidaCampos(edtCodCli, True);
    End
    Else If (not fEmptyStr(cdsGrupoOcorrGOC_CODGOC.AsString)) Then
    Begin
      pCarregaInformacoesOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString);
    End;

    pLimparCliente;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnPedidoClick(Sender: TObject);
begin
  pAguarde(pPedido);
end;

procedure TfrmCRM.pPedido;
begin
  If Not btnPedido.Enabled Then
    Exit;
  If fVerificaAcessoSistema('CRMPED') Then
  Begin
    inherited;
    if (btnPedido.Enabled) And (not cdsCliente.IsEmpty) then
    Begin
      If not VerificarAcessoClienteOrdemDeProducaoInd Then
        Exit;

      pChamaFaturamentoPedido(popPedido, edtCodCli.Text, '', mskNumCgc.Text);

      If Not fEmptyStr(frmPrincipal.strCodCliGravado) And
         Not SameText(frmPrincipal.strCodCliGravado, edtCodCli.Text) Then
      Begin
        edtCodCli.Text := frmPrincipal.strCodCliGravado;
        fValidaCampos(edtCodCli, True);
      End;

      If (Copy(popPedido.Items[0].Hint,4,8) <> edtCodCli.Text) Then
      Begin
        edtCodCli.Text := Copy(popPedido.Items[0].Hint,4,8);
        fValidaCampos(edtCodCli, True);
      End
      Else If (Not fEmptyStr(cdsGrupoOcorrGOC_CODGOC.AsString)) Then
      Begin
        pCarregaInformacoesOcorrencias(cdsGrupoOcorrGOC_CODGOC.AsString);
      End;
    End;

    pLimparCliente;
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnRelADClick(Sender: TObject);
begin
  If Not btnRelAD.Enabled Then
    Exit;
  If fVerificaAcessoSistema('CRMRAD') Then
  Begin
    inherited;

    If not VerificarAcessoClienteOrdemDeProducaoInd Then
      Exit;

    STR_CRM_TIP_PC := IfThen(blnProspecto, 'PROSPECTO','CLIENTE');

    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(7, 1233, [1233,1234,1235,1236],
                          ['CODCLI'],
                          [edtCodCli.Text],
                          Sender);
  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);
end;

procedure TfrmCRM.btnRelLeadsClick(Sender: TObject);
begin
  inherited;
  If not VerificarAcessoClienteOrdemDeProducaoInd Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(42, 3750, [3750,3751],
                        ['CODCLI'],
                        [edtCodCli.Text],
                        Sender);
end;

procedure TfrmCRM.cdsClienteAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not DataSet.IsEmpty then
    pHabilitaBotoesPanelSuperiorCrm
  else
    pDesabilitaBotoesPanelSuperiorCrm;
end;

procedure TfrmCRM.cdsContatosBeforeDelete(DataSet: TDataSet);
begin

  If (Not fVerificaAcessoSistema('EXCCNT', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso para excluir contatos de Clientes!', ['&Ok']);
    Exit;
  End;

  inherited;
end;

procedure TfrmCRM.cdsGrupoOcorrAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dtsGrupoOcorr.DataSet.IsEmpty and not dtsGrupoOcorr.DataSet.ControlsDisabled then
  Begin
    pFiltraOcorrencias(dtsGrupoOcorr.DataSet.FieldByName('GOC_CODGOC').AsString,
                       edtCodCli.Text);
  End;
end;

procedure TfrmCRM.cxDBVerticalGrid1CLI_FANSOBEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_FANSOB','Clientes');

end;

procedure TfrmCRM.cxGridDBTableView1CID_NOMCIDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.cxGridDBTableView1ETC_BAIENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');
  fValidaCampos(Self.edtCodCli,True);
end;

procedure TfrmCRM.cxGridDBTableView1ETC_CEPENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.cxGridDBTableView1ETC_CONENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.cxGridDBTableView1ETC_ENDENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.cxGridDBTableView1ETC_REFENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.cxGridDBTableView1ETC_TELENTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.cxGridDBTableView1TRA_NOMTRAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('','Enderecos');

end;

procedure TfrmCRM.dbgClientesCLI_ATRMAXEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_ATRMAX','Clientes');
  fValidaCampos(Self.edtCodCli,True);
end;

procedure TfrmCRM.dbgClientesCLI_BAIRROEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_BAIRRO','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_CAIPOSEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CAIPOS','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_CELULAEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CELULA','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_CONSUMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CONSUM','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_CONTATEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CONTAT','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_C_E_P_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_C_E_P_','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_C_G_C_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_C_G_C_','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_DESATIEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODATI','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_DESCONEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_DESCON','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_DESFPGEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODFPG','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_DESPOREditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODPOR','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_DESREGEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODREG','Clientes');
  fValidaCampos(Self.edtCodCli,True);
end;

procedure TfrmCRM.dbgClientesCLI_DESTCLEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_TIPCLI','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_EMAIL2EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMAIL2','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_EMAIL3EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMAIL3','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_EMAIL_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMAIL_','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_ENDCOMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_ENDCOM','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_ENDEREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_ENDERE','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_ENDNUMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_ENDNUM','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_FONE01EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_FONE01','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_FONE02EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_FONE02','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_F_A_X_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_F_A_X_','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_HOMEPAEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_HOMEPA','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_I_E_S_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_I_E_S_','Clientes');
  fValidaCampos(Self.edtCodCli,True);
end;

procedure TfrmCRM.dbgClientesCLI_I_M_P_EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_I_M_P_','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_LIMCREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_LIMCRE','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NASCIMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_NASCIM','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NEXTELEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_NEXTEL','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMCACEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODCAC','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMCIDEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODCID','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMDIVEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODDIV','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMERCEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_EMPRCF','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMREDEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODRED','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMREPEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODREP','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMSGEEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_SUPGER','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMSREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_SUPREG','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NOMVENEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_CODVEN','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_NUMR_GEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_NUMR_G','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_PERCOMEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_PERCOM','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_PEREMPEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_PEREMP','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_PERMFFEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_PERMFF','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_PERMFVEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_PERMFV','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_RAMAL1EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_RAMAL1','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_RAMAL2EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_RAMAL2','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_RAMAL3EditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_RAMAL3','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_REGTRIEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_REGTRI','Clientes');

end;

procedure TfrmCRM.dbgClientesCLI_TABPREEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_TABPRE','Clientes');

end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_CELCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESCGOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESDPTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESECIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESESCPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESGMUPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESHOBPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_DESTFUPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_FAXCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_NOMCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgContatosDBTableView1CLI_TELCTTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pSetaParametrosBotaoCliente('CLI_NOMCTT','Contatos',dtsContatos.DataSet.FieldByName('CLI_NOMCTT').AsString);
end;

procedure TfrmCRM.dbgMovOcorrDBTableView1CustomDrawCell(
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

  If AViewInfo.GridRecord.Index < 0 Then
    Exit;

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
  End;
end;

procedure TfrmCRM.dbgMovOcorrDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  If (Not cdsMovOcorr.IsEmpty) Then
    pCarregaOcorrenciaAlteracao;
end;

procedure TfrmCRM.dbgMovOcorrDBTableView1DOCCONGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If (Pos(',', AText) > 0) Then
    AText := Concat(LeftStr(AText, 19), ' ...');
end;

procedure TfrmCRM.dbgMovOcorrDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If Not pnlOcorrencias.Enabled Then
    Exit;

  If (Not cdsMovOcorr.IsEmpty) Then
  Begin

    If Shift = [ssCtrl] Then
    Begin
      If (Key = VK_F10) Then
        If Not blnLiberaPedido Then
          mnuFaturarEmVendaNormal.Click;
    End
    Else
    If Shift = [ssAlt] Then
    Begin

      Case Key Of
        VK_F2: if not blnLiberaPedido then
               begin
                 mnuEfetivarOrcamento.Click;
               end;
        VK_F3: if not blnLiberaPedido then
               begin
                 mnuAlterarDocumento.Click;
               end;
        VK_F4: mnuEnviarEmail.Click;
        VK_F5: mnuGerarPDF.Click;
        VK_F6: mnuReimprimir.Click;
        VK_F7: if not blnLiberaPedido then
               begin
                 mnuGerarVendaPerdida.Click;
               end;
        VK_F8: if not blnLiberaPedido then
               begin
                 mnuDesmembrar.Click;
               end;
        VK_F9: if not blnLiberaPedido then
               begin
                 mnuBaixar.Click;
               end;
        VK_F10: if not blnLiberaPedido then
                begin
                  mnuDocumentosConfirmacao.Click;
                end;
        VK_F11: if not blnLiberaPedido then
                begin
                  mnuRetirarVinculoReq_Transf.Click;
                end;
        VK_F12: mnuLimparSeparacao.Click;
      End;

    End
    Else
    Begin
      Case Key Of
        VK_RETURN: pCarregaOcorrenciaAlteracao;
      End;
    End;

  End;

end;

procedure TfrmCRM.dbgMovOcorrDBTableView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
//  Item: TcxCustomGridTableItem;
  Rec: TcxCustomGridRecord;
  strDoc: String;
begin
  inherited;
  If Button = mbRight Then
  Begin
    Site    := Sender as TcxGridSite;
    HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

    If HitTest Is TcxGridRecordCellHitTest Then
    Begin
//      Item := TcxGridRecordCellHitTest(HitTest).Item;
      Rec  := TcxGridRecordCellHitTest(HitTest).GridRecord;

      strDoc := VarToStr(rec.Values[dbgMovOcorrDBTableView1NumDoc.Index]);
      
      If (Pos('PD', strDoc) > 0) Or (Pos('OR', strDoc) > 0) Or (Not fEmptyStr(cdsMovOcorrOCO_SEQLAG.AsString)) Or (cdsMovOcorrOCO_CODTOC.asString = fCfgSis('OCOFIN')) Then
      Begin
        pTrataExibicaoMenus();
        if blnLiberaPedido then
        begin
          pDesabilitaMenusLiberaPedido;
        end;
        popOcorrencias.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      End;
    End;
  End;
end;

procedure TfrmCRM.dbgMovOcorrDBTableView1OCO_C_P_F_GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Length(VarToStr(ARecord.Values[dbgMovOcorrDBTableView1OCO_C_P_F_.Index])) = 14 Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

procedure TfrmCRM.DisablePanels;
begin
  pnlCliente.Enabled     := False;
  pnlContato.Enabled     := False;
  pnlEndereco.Enabled    := False;
  pnlGrupoOcor.Enabled   := False;
  pnlOcorrencias.Enabled := False;
end;

procedure TfrmCRM.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If edtCgcCpf.Text <> mskNumCgc.strCgcCpf Then
    mskNumCgc.Clear;
  mskNumCgc.strCgcCpf := edtCgcCpf.Text;
end;

procedure TfrmCRM.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    blnFilEmpIde: Boolean;
    arrClientes: TConsultasArray;
begin
  blnBloquCpfCnpj := btnCliOutroVendedor.Visible;
  If blnProspecto Then
  Begin
    If fPesqProspecto(Self, edtCodCli, edtDesCodCli, Nil, Key, arrClientes, True, True) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    blnFilEmpIde := True;

    If fCfgSis('IDEEMP', VarBoolean) And fCfgSis('EMPFAT', VarBoolean) Then
      blnFilEmpIde := False;

    If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCodCli, Nil, Key,
                    arrClientes, True, nil, False, '', '', blnFilEmpIde, '', '', tfvCRM) Then
    Begin
      fValidaCampos(edtCodCli, True);
    End;
  End;
end;

procedure TfrmCRM.EnabledPanels;
begin
  pnlCliente.Enabled     := True;
  pnlContato.Enabled     := True;
  pnlEndereco.Enabled    := True;
  pnlGrupoOcor.Enabled   := True;
  pnlOcorrencias.Enabled := True;
end;

procedure TfrmCRM.pCarregaInteligenciaDeVendas;
Begin
  With cdsIntVen.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    If not blnProspecto Then
    Begin
      Add(' SELECT "Frequência" AS COLUNA,                                                    ');
      Add('        IF(CLI_CRMFRE IS NULL, "", CONCAT(CLI_CRMFRE, " - ", CRF_DESCRI)) AS VALOR ');
      Add(' FROM CADCLI                                                                       ');
      Add(' LEFT JOIN CRMFRE ON CRF_CODIGO = CLI_CRMFRE                                       ');
      Add(' WHERE CLI_CODCLI = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Porte",                                                                   ');
      Add('        IF(CLI_CRMPOR IS NULL, "", CONCAT(CLI_CRMPOR, " - ", CRP_DESCRI))          ');
      Add(' FROM CADCLI                                                                       ');
      Add(' LEFT JOIN CRMPOR ON CRP_CODIGO = CLI_CRMPOR                                       ');
      Add(' WHERE CLI_CODCLI = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Faixa de Faturamento Estimado",                                           ');
      Add('        IF(CLI_CRMFAI IS NULL, "", CONCAT(CLI_CRMFAI, " - ", CRF_DESCRI))          ');
      Add(' FROM CADCLI                                                                       ');
      Add(' LEFT JOIN CRMFAI ON CRF_CODIGO = CLI_CRMFAI                                       ');
      Add(' WHERE CLI_CODCLI = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Fornecedor Atual",                                                        ');
      Add('        CONCAT(CLF_CRMFOR, " - ", CRF_NOMFOR)                                      ');
      Add(' FROM CLIFOR                                                                       ');
      Add(' LEFT JOIN CRMFOR ON CRF_CODIGO = CLF_CRMFOR                                       ');
      Add(' WHERE CLF_CODCLI = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Categoria",                                                               ');
      Add('      IF(IFNULL(CLI_CRMCAT, "") <> "", CONCAT(CLI_CRMCAT, " - ", CAT_DESCRI), "")  ');
      Add(' FROM CADCLI                                                                       ');
      Add(' LEFT JOIN CRMCAT ON CAT_CODIGO = CLI_CRMCAT                                       ');
      Add(' WHERE CLI_CODCLI = :CODIGO                                                        ');
    End
    Else
    Begin
      Add(' SELECT "Frequência" AS COLUNA,                                                    ');
      Add('        IF(PRO_CRMFRE IS NULL, "", CONCAT(PRO_CRMFRE, " - ", CRF_DESCRI)) AS VALOR ');
      Add(' FROM PROSPE                                                                       ');
      Add(' LEFT JOIN CRMFRE ON CRF_CODIGO = PRO_CRMFRE                                       ');
      Add(' WHERE PRO_CODPRO = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Porte",                                                                   ');
      Add('        IF(PRO_CRMPOR IS NULL, "", CONCAT(PRO_CRMPOR, " - ", CRP_DESCRI))          ');
      Add(' FROM PROSPE                                                                       ');
      Add(' LEFT JOIN CRMPOR ON CRP_CODIGO = PRO_CRMPOR                                       ');
      Add(' WHERE PRO_CODPRO = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Faixa de Faturamento Estimado",                                           ');
      Add('        IF(PRO_CRMFAI IS NULL, "", CONCAT(PRO_CRMFAI, " - ", CRF_DESCRI))          ');
      Add(' FROM PROSPE                                                                       ');
      Add(' LEFT JOIN CRMFAI ON CRF_CODIGO = PRO_CRMFAI                                       ');
      Add(' WHERE PRO_CODPRO = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Fornecedor Atual",                                                        ');
      Add('        CONCAT(PRF_CRMFOR, " - ", CRF_NOMFOR)                                      ');
      Add(' FROM PROFOR                                                                       ');
      Add(' LEFT JOIN CRMFOR ON CRF_CODIGO = PRF_CRMFOR                                       ');
      Add(' WHERE PRF_CODPRO = :CODIGO                                                        ');

      Add(' UNION ALL                                                                         ');

      Add(' SELECT "Categoria",                                                               ');
      Add('      IF(IFNULL(PRO_CRMCAT, "") <> "", CONCAT(PRO_CRMCAT, " - ", CAT_DESCRI), "")  ');
      Add(' FROM PROSPE                                                                       ');
      Add(' LEFT JOIN CRMCAT ON CAT_CODIGO = PRO_CRMCAT                                       ');
      Add(' WHERE PRO_CODPRO = :CODIGO                                                        ');
    End;

    ParamByName('CODIGO').AsString := edtCodCli.Text;

    cdsIntVen.fAbreClient(True, 'TfrmCRM.pCarregaInteligenciaDeVendas');

    cxgIntVenDBTableViewCitel.DataController.DataSource := cdsIntVen.dtsSource;
    cxgIntVenDBTableViewCitel.ApplyBestFit();
  End;

End;

procedure TfrmCRM.pAtualizarStatusDEPSOrcamentos(cdsOcorrencias: TUniClientDataSet);
  Var
    cdsDEPS      : TUniCLientDataSet;
    strStatusDEPS: String;
    intRegistro  : Integer;
Begin
  cdsDEPS := TUniCLientDataSet.Create(Nil);

  cdsDEPS.Data     := cdsOcorrencias.Data;
  cdsDEPS.Filter   := 'USADEPS=''S'' ';
  cdsDEPS.Filtered := True;

  While Not cdsDEPS.Eof Do
  Begin
    strStatusDEPS := TValidacoesSistemaDEPS.fRetornaStatusDoOrcamentoNoSistemaDEPS(cdsDEPS.FieldByName('AUTOINCREMFATGOR').AsString);

    If strStatusDEPS <> cdsDEPS.FieldByName('STATUSDEPS').AsString Then
    Begin
      cdsOcorrencias.DisableControls;
      intRegistro := cdsOcorrencias.RecNo;
      cdsOcorrencias.Locate('AUTOINCREMFATGOR', cdsDEPS.FieldByName('AUTOINCREMFATGOR').AsString, []);
      cdsOcorrencias.Edit;
      cdsOcorrencias.FieldByName('STATUSDEPS').AsString := strStatusDEPS;
      cdsOcorrencias.Post;
      cdsOcorrencias.RecNo := intRegistro;
      cdsOcorrencias.EnableControls;
    End;

    cdsDEPS.Next;
  End;

  Application.ProcessMessages;

  FreeAndNil(cdsDEPS);
End;

procedure TfrmCRM.btnHisDebClick(Sender: TObject);
var
  documento: IDocumento;
begin
  inherited;

  documento := TDocumento.Create;

  TfrmMostraDebCtrChq2.pMostraContaCorrente( edtCodCli.Text,
                                             '',
                                             False,
                                             False,
                                             False,
                                             '',
                                             documento,
                                             True);
end;

procedure TfrmCRM.pCarregaLeadsPorCategoria;
const
  SQLSelect = 'SELECT CAT_DESCRI, COUNT(LADGER.AUTOINCREM) AS QTD  ' +
              'FROM LADGER ' +
              'INNER JOIN CATEGO ON( LDG_CODCAT = CAT_CODIGO) ' +
              'WHERE CAT_LEDPER = "S"' +
              '  AND LDG_CODCLI =  :CODCLI ' +
              'GROUP BY CAT_DESCRI ' +
              'ORDER BY CAT_DESCRI ';
var
  qryLeadsCateg: TUniQuery;
begin
  cdsLeadsCateg.DisableControls;
  cdsLeadsCateg.EmptyDataSet;
  cdsLeadsCateg.Close;
  qryLeadsCateg := fCriaQuery;
  try
    qryLeadsCateg.Close;
    qryLeadsCateg.SQL.Add(SQLSelect);
    qryLeadsCateg.ParamByName('CODCLI').AsString := Trim(edtCodCli.Text);
    qryLeadsCateg.Open;
    cdsLeadsCateg.Open;

    While not qryLeadsCateg.Eof Do
    Begin
      cdsLeadsCateg.Insert;
      cdsLeadsCateg.FieldByName('CAT_DESCRI').AsString := qryLeadsCateg.FieldByName('CAT_DESCRI').AsString;
      cdsLeadsCateg.FieldByName('QTD').AsInteger := qryLeadsCateg.FieldByName('QTD').AsInteger;

      cdsLeadsCateg.Post;
      qryLeadsCateg.Next;
    end;
  finally
    cdsLeadsCateg.First;
    cdsLeadsCateg.EnableControls;
  end;
end;

procedure TfrmCRM.pExibirAbrirOcorrencia;
Begin
  mnuAbrirOcorrencia.Visible := False;

  If cdsMovOcorr.IsEmpty Then
    Exit;

  If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  mnuAbrirOcorrencia.Visible := True;
End;

procedure TfrmCRM.pExibirEnviarOcoEmail;
begin
  mnuEnviarEmail.Visible := False;

  If cdsMovOcorr.IsEmpty Then
    Exit;

  If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  mnuEnviarEmail.Visible := True;
end;

procedure TfrmCRM.pExibirGerarDANFEEmPDF;
begin
  mnuGerarDANFEemPDF.Visible := False;

  If cdsMovOcorr.IsEmpty Then
    Exit;

  If (Pos(cdsMovOcorrOCO_ESPDOC.AsString, 'NF_IF_NS') <= 0) Then
    Exit;

  mnuGerarDANFEemPDF.Visible := (cdsMovOcorrOCO_CODTOC.asString = fCfgSis('OCOFIN'));
end;

procedure TfrmCRM.pExibirGerarPDF;
begin
  mnuGerarPDF.Visible := False;

  If cdsMovOcorr.IsEmpty Then
    Exit;
  
  If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) And (cdsMovOcorrOCO_CODTOC.asString <> fCfgSis('OCOFIN')) Then
    Exit;

  If (cdsMovOcorrOCO_CODTOC.asString = fCfgSis('OCOFIN')) And (Pos(cdsMovOcorrOCO_ESPDOC.AsString, 'NF_IF_NS_FF_DV_') <= 0) Then
    Exit;

  If (Pos(cdsMovOcorrOCO_ESPDOC.AsString, 'FF_DV_') > 0) And (Not fVerificaAcessoSistema('PERMGERARPDFFF')) Then
    Exit;

  mnuGerarPDF.Visible := True;
end;

procedure TfrmCRM.pExibirReimprimir;
begin
  mnuReimprimir.Visible := False;

  If cdsMovOcorr.IsEmpty Then
    Exit;

  If (Pos('OR', cdsMovOcorrNumDoc.AsString) <= 0) And (Pos('PD', cdsMovOcorrNumDoc.AsString) <= 0) Then
    Exit;

  mnuReimprimir.Visible := True;
end;


end.


