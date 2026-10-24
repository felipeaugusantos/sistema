unit Contabilidade.View.AuditoriaLancamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Contabilidade.Interfaces,
  Contabilidade.Interfaces.TAuditoriaLancamentos, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  Data.DB, MemDS, DBAccess, Uni, Datasnap.DBClient, UniClientDataSet, Vcl.Grids,
  Vcl.DBGrids, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, Vcl.Mask,
  MaskEditFocus, EditFocus, DBGridCitel, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, cxBlobEdit, cxCalc,
  cxPropertiesStore, dxBarBuiltInMenu, cxPC, cxRadioGroup, cxCheckBox,
  cxImageComboBox, System.Generics.Collections, cxButtonEdit, cxProgressBar;

type
  TfrmAuditoriaLancamentos = class(TfrmPaiConfirmaContabilidade)
    gbFiltroAvancado: TcxGroupBox;
    gbDadosLancon: TcxGroupBox;
    gbInfoParametrizacao: TcxGroupBox;
    dsLancon: TDataSource;
    dsLanconLog: TDataSource;
    dsParcon: TDataSource;
    dsParconLog: TDataSource;
    dsParNco: TDataSource;
    dsParNcoLog: TDataSource;
    dsCmpPar: TDataSource;
    dsCmpParLog: TDataSource;
    Label15: TLabel;
    edtEmpLan: TEditFocus;
    edtNomEmp: TEditFocus;
    Label12: TLabel;
    mskContaDebito: TMaskEditFocus;
    edtConDebRed: TEditFocus;
    edtDesContaDebito: TEditFocus;
    lbContaCredito: TLabel;
    mskContaCredito: TMaskEditFocus;
    edtConCreRed: TEditFocus;
    edtDesContaCRedito: TEditFocus;
    lbValor: TLabel;
    edtValor: TCurrencyEditFocus;
    dbgBuscaConta: TDBGridCitel;
    dtsBusca: TDataSource;
    Label1: TLabel;
    edtDataInicial: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    Label2: TLabel;
    edtComplemento: TEditFocus;
    btnAbrirFiltro: TBitBtn;
    GridLanconLevel: TcxGridLevel;
    GridLancon: TcxGridCitel;
    GridTableViewLancon: TcxGridDBBandedTableView;
    GridTableViewLanconAUTOINCREM: TcxGridDBBandedColumn;
    GridTableViewLanconCON_EMPLAN: TcxGridDBBandedColumn;
    GridTableViewLanconCON_DTALAN: TcxGridDBBandedColumn;
    GridTableViewLanconCON_TIPLAN: TcxGridDBBandedColumn;
    GridTableViewLanconCON_NATOPE: TcxGridDBBandedColumn;
    GridTableViewLanconCON_DESVAL: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CONCRE: TcxGridDBBandedColumn;
    GridTableViewLanconDES_CONCRE: TcxGridDBBandedColumn;
    GridTableViewLanconRED_CONCRE: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CONDEB: TcxGridDBBandedColumn;
    GridTableViewLanconDES_CONDEB: TcxGridDBBandedColumn;
    GridTableViewLanconRED_CONDEB: TcxGridDBBandedColumn;
    GridTableViewLanconCON_HISPAD: TcxGridDBBandedColumn;
    GridTableViewLanconCON_HISTOR: TcxGridDBBandedColumn;
    GridTableViewLanconCON_VALLAN: TcxGridDBBandedColumn;
    GridTableViewLanconCON_AUTOMA: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CCUSTO: TcxGridDBBandedColumn;
    GridTableViewLanconDES_CCUSTO: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CODOPE: TcxGridDBBandedColumn;
    GridTableViewLanconCON_INCDOC: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CCUSCR: TcxGridDBBandedColumn;
    GridTableViewLanconDES_CCUSCR: TcxGridDBBandedColumn;
    GridTableViewLanconCON_TABELA: TcxGridDBBandedColumn;
    GridTableViewLanconCON_PAGAME: TcxGridDBBandedColumn;
    GridTableViewLanconCON_TT_ULT: TcxGridDBBandedColumn;
    GridTableViewLanconCON_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewLanconCON_INVNCO: TcxGridDBBandedColumn;
    GridTableViewLanconLAN_NUMLOT: TcxGridDBBandedColumn;
    gbDadosLanconLog: TcxGroupBox;
    GridLanconLogLevel: TcxGridLevel;
    GridLanconLog: TcxGridCitel;
    GridTableLanconLog: TcxGridDBBandedTableView;
    GridTableLanconLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableLanconLogLOG_INCDOC: TcxGridDBBandedColumn;
    GridTableLanconLogAUTOINCREM: TcxGridDBBandedColumn;
    GridTableLanconLogCON_EMPLAN: TcxGridDBBandedColumn;
    GridTableLanconLogCON_DTALAN: TcxGridDBBandedColumn;
    GridTableLanconLogCON_TIPLAN: TcxGridDBBandedColumn;
    GridTableLanconLogCON_NATOPE: TcxGridDBBandedColumn;
    GridTableLanconLogCON_DESVAL: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CONCRE: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CONDEB: TcxGridDBBandedColumn;
    GridTableLanconLogCON_HISPAD: TcxGridDBBandedColumn;
    GridTableLanconLogCON_HISTOR: TcxGridDBBandedColumn;
    GridTableLanconLogCON_VALLAN: TcxGridDBBandedColumn;
    GridTableLanconLogCON_AUTOMA: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CCUSTO: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CODOPE: TcxGridDBBandedColumn;
    GridTableLanconLogCON_INCDOC: TcxGridDBBandedColumn;
    GridTableLanconLogCON_TABELA: TcxGridDBBandedColumn;
    GridTableLanconLogCON_PAGAME: TcxGridDBBandedColumn;
    GridTableLanconLogCON_VERSIS: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CLIFOR: TcxGridDBBandedColumn;
    GridTableLanconLogCON_TIP_FC: TcxGridDBBandedColumn;
    GridTableLanconLogCON_TT_ULT: TcxGridDBBandedColumn;
    GridTableLanconLogCON_EMPLOG: TcxGridDBBandedColumn;
    GridTableLanconLogCON_FORPGO: TcxGridDBBandedColumn;
    GridTableLanconLogCON_AUTMOD: TcxGridDBBandedColumn;
    GridTableLanconLogCON_SEQPAR: TcxGridDBBandedColumn;
    GridTableLanconLogCON_INVNCO: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CCUSCR: TcxGridDBBandedColumn;
    pgParcon: TcxPageControl;
    tsParcon: TcxTabSheet;
    tsComplemento: TcxTabSheet;
    gbParconAtual: TcxGroupBox;
    GridParconLevel: TcxGridLevel;
    GridParcon: TcxGridCitel;
    GridTableViewParcon: TcxGridDBBandedTableView;
    gbParconLog: TcxGroupBox;
    GridParconLogLevel: TcxGridLevel;
    GridParconLog: TcxGridCitel;
    GridTableViewParconLog: TcxGridDBBandedTableView;
    GridTableViewParconCON_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewParconCON_TIPLAN: TcxGridDBBandedColumn;
    GridTableViewParconCON_FORPGO: TcxGridDBBandedColumn;
    GridTableViewParconCON_DESVAL: TcxGridDBBandedColumn;
    GridTableViewParconCON_CLAFIS: TcxGridDBBandedColumn;
    GridTableViewParconCON_PAGAME: TcxGridDBBandedColumn;
    GridTableViewParconCON_NATOPE: TcxGridDBBandedColumn;
    GridTableViewParconCON_CONCRE: TcxGridDBBandedColumn;
    GridTableViewParconCON_CFCRED: TcxGridDBBandedColumn;
    GridTableViewParconCON_PORCRE: TcxGridDBBandedColumn;
    GridTableViewParconCON_PCCRED: TcxGridDBBandedColumn;
    GridTableViewParconCON_BANCRE: TcxGridDBBandedColumn;
    GridTableViewParconCON_ABFCRE: TcxGridDBBandedColumn;
    GridTableViewParconCON_TIPPCC: TcxGridDBBandedColumn;
    GridTableViewParconCON_CONDEB: TcxGridDBBandedColumn;
    GridTableViewParconCON_CFDEBI: TcxGridDBBandedColumn;
    GridTableViewParconCON_PORDEB: TcxGridDBBandedColumn;
    GridTableViewParconCON_PCDEBI: TcxGridDBBandedColumn;
    GridTableViewParconCON_BANDEB: TcxGridDBBandedColumn;
    GridTableViewParconCON_ABFDEB: TcxGridDBBandedColumn;
    GridTableViewParconCON_TIPPCD: TcxGridDBBandedColumn;
    GridTableViewParconCON_ORIGEM: TcxGridDBBandedColumn;
    GridTableViewParconCON_PAGANT: TcxGridDBBandedColumn;
    GridTableViewParconCON_TITPDD: TcxGridDBBandedColumn;
    GridTableViewParconCON_CODEMP: TcxGridDBBandedColumn;
    GridTableViewParconCON_VIGINI: TcxGridDBBandedColumn;
    GridTableViewParconCON_VIGFIN: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CLAFIS: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CLAFIS: TcxGridDBBandedColumn;
    GridTableViewLanconCON_AUTMOD: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewParconLogLOG_INCDOC: TcxGridDBBandedColumn;
    GridTableViewParconCON_NATCFO: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_TIPLAN: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_FORPGO: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_DESVAL: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_CLAFIS: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_NATCFO: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_PAGAME: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_NATOPE: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_CONCRE: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_CFCRED: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_PORCRE: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_PCCRED: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_BANCRE: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_ABFCRE: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_TIPPCC: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_CONDEB: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_CFDEBI: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_PORDEB: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_PCDEBI: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_BANDEB: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_ABFDEB: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_TIPPCD: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_ORIGEM: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_PAGANT: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_TITPDD: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_CODEMP: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_VIGINI: TcxGridDBBandedColumn;
    GridTableViewParconLogCON_VIGFIN: TcxGridDBBandedColumn;
    gbCmpPar: TcxGroupBox;
    gbCmpParLog: TcxGroupBox;
    GridCmpParLevel: TcxGridLevel;
    GridCmpPar: TcxGridCitel;
    GridCmpParLogLevel: TcxGridLevel;
    GridCmpParLog: TcxGridCitel;
    GridTableViewCmpPar: TcxGridDBBandedTableView;
    GridTableViewCmpParLog: TcxGridDBBandedTableView;
    GridTableViewCmpParAUTOINCREM: TcxGridDBBandedColumn;
    GridTableViewCmpParPAR_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewCmpParPAR_MD5KEY: TcxGridDBBandedColumn;
    GridTableViewCmpParPAR_COMPLE: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewCmpParLogLOG_INCDOC: TcxGridDBBandedColumn;
    GridTableViewCmpParLogAUTOINCREM: TcxGridDBBandedColumn;
    GridTableViewCmpParLogPAR_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewCmpParLogPAR_MD5KEY: TcxGridDBBandedColumn;
    GridTableViewCmpParLogPAR_COMPLE: TcxGridDBBandedColumn;
    tsContasPorEmpresa: TcxTabSheet;
    gbParNco: TcxGroupBox;
    gbParNcoLog: TcxGroupBox;
    GridParNcoLevel: TcxGridLevel;
    GridParNco: TcxGridCitel;
    GridParNcoLogLevel: TcxGridLevel;
    GridParNcoLog: TcxGridCitel;
    GridTableViewParNco: TcxGridDBBandedTableView;
    GridTableViewParNcoLog: TcxGridDBBandedTableView;
    GridTableViewParNcoNCO_MD5KEY: TcxGridDBBandedColumn;
    GridTableViewParNcoNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewParNcoNCO_CREDEB: TcxGridDBBandedColumn;
    GridTableViewParNcoNCO_CODCON: TcxGridDBBandedColumn;
    GridTableViewParNcoCON_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewParNcoLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewParNcoLogNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewParNcoLogNCO_CREDEB: TcxGridDBBandedColumn;
    GridTableViewParNcoLogNCO_CODCON: TcxGridDBBandedColumn;
    GridTableViewParNcoLogCON_SEQPAR: TcxGridDBBandedColumn;
    GridTableViewLanconCON_TPORIC: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CDORIC: TcxGridDBBandedColumn;
    GridTableViewLanconCON_OPBCCR: TcxGridDBBandedColumn;
    GridTableViewLanconCON_TPORID: TcxGridDBBandedColumn;
    GridTableViewLanconCON_CDORID: TcxGridDBBandedColumn;
    GridTableViewLanconCON_OPBCDB: TcxGridDBBandedColumn;
    GridTableLanconLogCON_TPORIC: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CDORIC: TcxGridDBBandedColumn;
    GridTableLanconLogCON_OPBCCR: TcxGridDBBandedColumn;
    GridTableLanconLogCON_TPORID: TcxGridDBBandedColumn;
    GridTableLanconLogCON_CDORID: TcxGridDBBandedColumn;
    GridTableLanconLogCON_OPBCDB: TcxGridDBBandedColumn;
    GridTableViewLanconCON_TIP_FC: TcxGridDBBandedColumn;
    dsPorNco: TDataSource;
    dsPorNcoLog: TDataSource;
    tsPortador: TcxTabSheet;
    dsBanNco: TDataSource;
    dsBanNcoLog: TDataSource;
    dsCliNco: TDataSource;
    dsCliNcoLog: TDataSource;
    dsCtaNco: TDataSource;
    dsCtaNcoLog: TDataSource;
    dsForNco: TDataSource;
    dsForNcoLog: TDataSource;
    tsPlanoContas: TcxTabSheet;
    tsCliente: TcxTabSheet;
    tsFornecedor: TcxTabSheet;
    tsBandeira: TcxTabSheet;
    gbPorNco: TcxGroupBox;
    gbPorNcoLog: TcxGroupBox;
    GridPorNcoLevel: TcxGridLevel;
    GridPorNco: TcxGridCitel;
    GridPorNcoLogLevel: TcxGridLevel;
    GridPorNcoLog: TcxGridCitel;
    GridTableViewPorNco: TcxGridDBBandedTableView;
    GridTableViewPorNcoLog: TcxGridDBBandedTableView;
    GridTableViewPorNcoNCO_CODPOR: TcxGridDBBandedColumn;
    GridTableViewPorNcoNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewPorNcoNCO_CODCON: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogNCO_CODPOR: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewPorNcoLogNCO_CODCON: TcxGridDBBandedColumn;
    gbCtaNco: TcxGroupBox;
    GridCtaNco: TcxGridCitel;
    GridTableViewCtaNco: TcxGridDBBandedTableView;
    GridTableViewCtaNcoNCO_CODCTA: TcxGridDBBandedColumn;
    GridTableViewCtaNcoNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCtaNcoNCO_CODCON: TcxGridDBBandedColumn;
    GridCtaNcoLevel: TcxGridLevel;
    gbCtaNcoLog: TcxGroupBox;
    GridCtaNcoLog: TcxGridCitel;
    GridTableViewCtaNcoLog: TcxGridDBBandedTableView;
    GridTableViewCtaNcoLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogNCO_CODCTA: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCtaNcoLogNCO_CODCON: TcxGridDBBandedColumn;
    GridCtaNcoLogLevel: TcxGridLevel;
    gbCliNco: TcxGroupBox;
    GridCliNco: TcxGridCitel;
    GridTableViewCliNco: TcxGridDBBandedTableView;
    GridTableViewCliNcoNCO_CODCLI: TcxGridDBBandedColumn;
    GridTableViewCliNcoNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCliNcoNCO_CODCON: TcxGridDBBandedColumn;
    GridCliNcoLevel: TcxGridLevel;
    gbCliNcoLog: TcxGroupBox;
    GridCliNcoLog: TcxGridCitel;
    GridTableViewCliNcoLog: TcxGridDBBandedTableView;
    GridTableViewCliNcoLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogNCO_CODCLI: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewCliNcoLogNCO_CODCON: TcxGridDBBandedColumn;
    GridCliNcoLogLevel: TcxGridLevel;
    gbForNco: TcxGroupBox;
    GridForNco: TcxGridCitel;
    GridTableViewForNco: TcxGridDBBandedTableView;
    GridTableViewForNcoNCO_CODFOR: TcxGridDBBandedColumn;
    GridTableViewForNcoNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewForNcoNCO_CODCON: TcxGridDBBandedColumn;
    GridForNcoLevel: TcxGridLevel;
    gbForNcoLog: TcxGroupBox;
    GridForNcoLog: TcxGridCitel;
    GridTableViewForNcoLog: TcxGridDBBandedTableView;
    GridTableViewForNcoLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewForNcoLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewForNcoLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewForNcoLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewForNcoLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewForNcoLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewForNcoLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewForNcoLogNCO_CODFOR: TcxGridDBBandedColumn;
    GridTableViewForNcoLogNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewForNcoLogNCO_CODCON: TcxGridDBBandedColumn;
    GridForNcoLogLevel: TcxGridLevel;
    gbBanNco: TcxGroupBox;
    GridBanNco: TcxGridCitel;
    GridTableViewBanNco: TcxGridDBBandedTableView;
    GridTableViewBanNcoNCO_CODBAN: TcxGridDBBandedColumn;
    GridTableViewBanNcoNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewBanNcoNCO_CODCON: TcxGridDBBandedColumn;
    GridBanNcoLevel: TcxGridLevel;
    gbBanNcoLog: TcxGroupBox;
    GridBanNcoLog: TcxGridCitel;
    GridTableViewBanNcoLog: TcxGridDBBandedTableView;
    GridTableViewBanNcoLogLOG_CODEMP: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogLOG_DTAALT: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogLOG_HRAALT: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogLOG_CODOPE: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogLOG_TIPAJU: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogLOG_NOMFRM: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogLOG_SEQAJU: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogNCO_CODBAN: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogNCO_CODEMP: TcxGridDBBandedColumn;
    GridTableViewBanNcoLogNCO_CODCON: TcxGridDBBandedColumn;
    GridBanNcoLogLevel: TcxGridLevel;
    gbOpcoesLanconLog: TcxGroupBox;
    cbMostrarLogIncDoc: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgBuscaContaDblClick(Sender: TObject);
    procedure mskContaDebitoClick(Sender: TObject);
    procedure mskContaCreditoClick(Sender: TObject);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaDebitoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskContaCreditoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConDebRedClick(Sender: TObject);
    procedure edtConCreRedClick(Sender: TObject);
    procedure edtConDebRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConCreRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirFiltroClick(Sender: TObject);
    procedure GridTableViewLanconFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableLanconLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewParconFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewParconLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewCmpParFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewCmpParLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewParNcoFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewParNcoLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewLanconCON_CDORICPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridTableViewLanconCON_CDORIDPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridTableViewLanconCON_SEQPARPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridTableViewPorNcoFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewPorNcoLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewCtaNcoFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewCtaNcoLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewCliNcoFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewCliNcoLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewForNcoFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewForNcoLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewBanNcoFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridTableViewBanNcoLogFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure cbMostrarLogIncDocClick(Sender: TObject);
  private
    { Private declarations }
    FblnSincronizandoFoco: Boolean;
    FdctZebraPorView: TObjectDictionary<TcxGridDBBandedTableView,
                                      TDictionary<Integer, Boolean>>;
    FdctColunaTipAju: TDictionary<TcxGridDBBandedTableView,
                                TcxGridDBBandedColumn>;
    FAutoIncremLancon: String;
    FTipoPesquisa: TPesquisaLancamentoContabil;
    FAuditoriaService: IAuditoriaLancamentosService;
    FConsultaLancon: TUniQuery;
    FConsultaLanconLogs: TUniClientDataSet;
    FConsultaParcon: TUniQuery;
    FConsultaParconLogs: TUniClientDataSet;
    FConsultaParNco: TUniQuery;
    FConsultaParNcoLogs: TUniClientDataSet;
    FConsultaPorNco: TUniQuery;
    FConsultaPorNcoLogs: TUniClientDataSet;
    FConsultaBanNco: TUniQuery;
    FConsultaBanNcoLogs: TUniClientDataSet;
    FConsultaCliNco: TUniQuery;
    FConsultaCliNcoLogs: TUniClientDataSet;
    FConsultaCtaNco: TUniQuery;
    FConsultaCtaNcoLogs: TUniClientDataSet;
    FConsultaForNco: TUniQuery;
    FConsultaForNcoLogs: TUniClientDataSet;
    FConsultaCmpPar: TUniQuery;
    FConsultaCmpParLogs: TUniClientDataSet;
    FBuscaPlanoContas : TUniQuery;
    FExisteCampoNCO_NATURE: boolean ;
    procedure pShowInterno;
    procedure pFiltroAvancadoInterno;
    function fValidarFiltroAvancado: Boolean;
    procedure pCarregarLancon(const AFiltros: TArrayFiltrosLog);
    procedure pCarregarLanconAlteracoes(const AAutoInc, AIncDoc: string;
      const AMostrarTodoLogIncDoc: Boolean);
    procedure pFiltrarLanconAlteracoes(const AMostrarTodoLogIncDoc: Boolean);
    procedure pCarregarParcon(const ASeqPar: string);
    procedure pCarregarParconAlteracoes(const ASeqPar: string);
    procedure pCarregarParNco(const ASeqPar: string);
    procedure pCarregarParNcoAlteracoes(const ASeqPar: string);
    procedure pCarregarPorNco(const ACodigo: string);
    procedure pCarregarPorNcoAlteracoes(const ACodigo: string);
    procedure pCarregarBanNco(const ACodigo: string);
    procedure pCarregarBanNcoAlteracoes(const ACodigo: string);
    procedure pCarregarCliNco(const ACodigo: string);
    procedure pCarregarCliNcoAlteracoes(const ACodigo: string);
    procedure pCarregarCtaNco(const ACodigo: string);
    procedure pCarregarCtaNcoAlteracoes(const ACodigo: string);
    procedure pCarregarForNco(const ACodigo: string);
    procedure pCarregarForNcoAlteracoes(const ACodigo: string);
    procedure pCarregarCmpPar(const ASeqPar: string);
    procedure pCarregarCmpParAlteracoes(const ASeqPar: string);
    procedure pCarregaPlanoContabilCredito(const ABuscaPorChave: Boolean=False; const ACampoContaReduzida: Boolean=False);
    procedure pCarregaPlanoContabilDebito(const ABuscaPorChave: Boolean=False; const ACampoContaReduzida: Boolean=False);
    procedure pBuscarConta(const ADbeTexto: TCustomEdit;
      const AContaReduzida: Boolean; const ATag: Integer);
    function fMovimentaLinha(const Key: Word; Sender: TObject): boolean;
    procedure pLanconAfterScroll(DataSet: TDataSet);
    procedure pCarregaInformacoesAuditoria(
      const AIncDocLancon, AAutoIncLancon, ASeqParParcon,
      ACodigoPortador, ACodigoBandeira, ACodigoCliente, ACodigoPlanoConta,
      ACodigoFornecedor: string; const AMostrarTodoLogIncDoc: Boolean);
    procedure pSincronizarColunaGrid(
      const AOrigem, ADestino: TcxGridDBBandedTableView;
      const AFocusedItem: TcxCustomGridTableItem);
    procedure pRegistrarZebraLog(
      const AView: TcxGridDBBandedTableView;
      const AColunaTipAju: TcxGridDBBandedColumn;
      const ADataSource: TDataSource);
    procedure pRecalcularZebra(const AView: TcxGridDBBandedTableView);
    procedure dsLogDataChange(Sender: TObject; Field: TField);
    procedure GridLogCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    class function MontaFiltroIgualdade(const ACampo, AValor: String): String; static;
    function fTelaCadastroCredito(pgbProgresso: TcxProgressBar): Boolean;
    function fTelaCadastroDebito(pgbProgresso: TcxProgressBar): Boolean;
    function fTelaCadastroParcon(pgbProgresso: TcxProgressBar): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property AutoIncremLancon: String read FAutoIncremLancon write FAutoIncremLancon;
    property TipoPesquisa: TPesquisaLancamentoContabil read FTipoPesquisa write FTipoPesquisa;
  end;

implementation

uses
  Contabilidade.Classes.TAuditoriaLancamentos, untFuncoesSimples,
  Contabilidade.Consultas, untTypesSistema, untConsultas, Contabilidade.Funcoes,
  Contabilidade.Classes.TAuditoriaCadastros, System.UITypes, StrUtils;

{$R *.dfm}

procedure TfrmAuditoriaLancamentos.btnAbrirFiltroClick(Sender: TObject);
begin
  inherited;
  if not fValidarFiltroAvancado then
    Exit;

  pFiltroAvancadoInterno;

  if dsLancon.DataSet.IsEmpty then
    fMensagem('ATENÇÃO!', 'Nenhuma informação retornada no filtro aplicado!', ['&Ok']);

end;

procedure TfrmAuditoriaLancamentos.cbMostrarLogIncDocClick(Sender: TObject);
begin
  inherited;
  pFiltrarLanconAlteracoes(TcxCheckBox(Sender).Checked);
end;

procedure TfrmAuditoriaLancamentos.dbgBuscaContaDblClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
  If (dbgBuscaConta.Tag = 1) or (dbgBuscaConta.Tag = 11) Then
  Begin
    mskContaDebito.Text := FBuscaPlanoContas.FieldByName('CODCON').AsString;
    edtConDebRed.Text := FBuscaPlanoContas.FieldByName('CONRED').AsString;
    edtDesContaDebito.Text := FBuscaPlanoContas.FieldByName('DESCON').AsString;
    if dbgBuscaConta.Tag = 1 then
      pSetFocus(mskContaDebito)
    else
      pSetFocus(edtConDebRed) ;
  End
  Else If (dbgBuscaConta.Tag = 2) or (dbgBuscaConta.Tag = 12) Then
  Begin
    mskContaCredito.Text := FBuscaPlanoContas.FieldByName('CODCON').AsString;
    edtConCreRed.Text := FBuscaPlanoContas.FieldByName('CONRED').AsString;
    edtDesContaCredito.Text := FBuscaPlanoContas.FieldByName('DESCON').AsString;
    if dbgBuscaConta.Tag = 2 then
      pSetFocus(mskContaCredito)
    else
      pSetFocus(edtConCreRed) ;
  End;
end;

procedure TfrmAuditoriaLancamentos.edtConCreRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmAuditoriaLancamentos.edtConCreRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConCreRed, True, 2);
  end;
end;

procedure TfrmAuditoriaLancamentos.edtConDebRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmAuditoriaLancamentos.edtConDebRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConDebRed, True, 1);
  end;
end;

procedure TfrmAuditoriaLancamentos.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
var
  LEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, LEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAuditoriaLancamentos.fMovimentaLinha(const Key: Word;
  Sender: TObject): boolean;
begin
  Result := False ;
  if not dbgBuscaConta.Visible then
  begin
    exit ;
  end;
  if key = VK_DOWN then
  begin
    if not FBuscaPlanoContas.Active then
    begin
      exit ;
    end ;
    FBuscaPlanoContas.Next ;
    Result := True ;
  end
  else if key = VK_UP then
  begin
    if not FBuscaPlanoContas.Active then
    begin
      exit ;
    end ;
    FBuscaPlanoContas.Prior ;
    Result := True ;
  end ;
  if Result then
  begin
    if Sender is TMaskEditFocus then
    begin
      TMaskEditFocus(Sender).Text := FBuscaPlanoContas.FieldByName('CODCON').AsString;
    end
    else if Sender is TEditFocus then
    begin
      TEditFocus(Sender).Text := FBuscaPlanoContas.FieldByName('CONRED').AsString;
    end;
  end;
end;

procedure TfrmAuditoriaLancamentos.FormCreate(Sender: TObject);
var
  LMascara: String;
begin
  inherited;
  FExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');

  FAuditoriaService := TAuditoriaLancamentosService.New;
  FConsultaLancon := Nil;
  FConsultaLanconLogs := Nil;
  FConsultaParcon := Nil;
  FConsultaParconLogs := Nil;
  FConsultaParNco := Nil;
  FConsultaParNcoLogs := Nil;
  FConsultaPorNco := Nil;
  FConsultaPorNcoLogs := Nil;
  FConsultaBanNco := Nil;
  FConsultaBanNcoLogs := Nil;
  FConsultaCliNco := Nil;
  FConsultaCliNcoLogs := Nil;
  FConsultaCtaNco := Nil;
  FConsultaCtaNcoLogs := Nil;
  FConsultaForNco := Nil;
  FConsultaForNcoLogs := Nil;
  FConsultaCmpPar := Nil;
  FConsultaCmpParLogs := Nil;

  FBuscaPlanoContas := fCriaQuery(Self);
  dtsBusca.DataSet := FBuscaPlanoContas;

  LMascara := fMskCon;
  mskContaDebito.EditMask := LMascara;
  mskContaCredito.EditMask := LMascara;
  FdctZebraPorView := TObjectDictionary<TcxGridDBBandedTableView,
                        TDictionary<Integer, Boolean>>.Create([doOwnsValues]);
  FdctColunaTipAju := TDictionary<TcxGridDBBandedTableView,
                                  TcxGridDBBandedColumn>.Create;

  pRegistrarZebraLog(GridTableLanconLog,
                     GridTableLanconLogLOG_TIPAJU,
                     dsLanconLog);

  pRegistrarZebraLog(GridTableViewParconLog,
                     GridTableViewParconLogLOG_TIPAJU,
                     dsParconLog);

  pRegistrarZebraLog(GridTableViewCmpParLog,
                     GridTableViewCmpParLogLOG_TIPAJU,
                     dsCmpParLog);

  pRegistrarZebraLog(GridTableViewParNcoLog,
                     GridTableViewParNcoLogLOG_TIPAJU,
                     dsParNcoLog);

  pRegistrarZebraLog(GridTableViewPorNcoLog,
                     GridTableViewPorNcoLogLOG_TIPAJU,
                     dsPorNcoLog);

  pRegistrarZebraLog(GridTableViewCtaNcoLog,
                     GridTableViewCtaNcoLogLOG_TIPAJU,
                     dsCtaNcoLog);

  pRegistrarZebraLog(GridTableViewCliNcoLog,
                     GridTableViewCliNcoLogLOG_TIPAJU,
                     dsCliNcoLog);

  pRegistrarZebraLog(GridTableViewForNcoLog,
                     GridTableViewForNcoLogLOG_TIPAJU,
                     dsForNcoLog);

  pRegistrarZebraLog(GridTableViewBanNcoLog,
                     GridTableViewBanNcoLogLOG_TIPAJU,
                     dsBanNcoLog);
end;

procedure TfrmAuditoriaLancamentos.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FConsultaLancon) then
  begin
    FreeAndNil(FConsultaLancon);
  end;
  if Assigned(FConsultaLanconLogs) then
  begin
    FreeAndNil(FConsultaLanconLogs);
  end;
  if Assigned(FConsultaParcon) then
  begin
    FreeAndNil(FConsultaParcon);
  end;
  if Assigned(FConsultaParconLogs) then
  begin
    FreeAndNil(FConsultaParconLogs);
  end;
  if Assigned(FConsultaParNco) then
  begin
    FreeAndNil(FConsultaParNco);
  end;
  if Assigned(FConsultaParNcoLogs) then
  begin
    FreeAndNil(FConsultaParNcoLogs);
  end;
  if Assigned(FConsultaPorNco) then
  begin
    FreeAndNil(FConsultaPorNco);
  end;
  if Assigned(FConsultaPorNcoLogs) then
  begin
    FreeAndNil(FConsultaPorNcoLogs);
  end;
  if Assigned(FConsultaBanNco) then
  begin
    FreeAndNil(FConsultaBanNco);
  end;
  if Assigned(FConsultaBanNcoLogs) then
  begin
    FreeAndNil(FConsultaBanNcoLogs);
  end;
  if Assigned(FConsultaCliNco) then
  begin
    FreeAndNil(FConsultaCliNco);
  end;
  if Assigned(FConsultaCliNcoLogs) then
  begin
    FreeAndNil(FConsultaCliNcoLogs);
  end;
  if Assigned(FConsultaCtaNco) then
  begin
    FreeAndNil(FConsultaCtaNco);
  end;
  if Assigned(FConsultaCtaNcoLogs) then
  begin
    FreeAndNil(FConsultaCtaNcoLogs);
  end;
  if Assigned(FConsultaForNco) then
  begin
    FreeAndNil(FConsultaForNco);
  end;
  if Assigned(FConsultaForNcoLogs) then
  begin
    FreeAndNil(FConsultaForNcoLogs);
  end;
  if Assigned(FConsultaCmpPar) then
  begin
    FreeAndNil(FConsultaCmpPar);
  end;
  if Assigned(FConsultaCmpParLogs) then
  begin
    FreeAndNil(FConsultaCmpParLogs);
  end;
  FreeAndNil(FBuscaPlanoContas);
  FreeAndNil(FdctZebraPorView);
  FreeAndNil(FdctColunaTipAju);
end;

procedure TfrmAuditoriaLancamentos.pRegistrarZebraLog(
  const AView: TcxGridDBBandedTableView;
  const AColunaTipAju: TcxGridDBBandedColumn;
  const ADataSource: TDataSource);
begin
  // cria o cache desta view
  FdctZebraPorView.Add(AView, TDictionary<Integer, Boolean>.Create);

  // memoriza qual e a coluna LOG_TIPAJU desta view
  FdctColunaTipAju.Add(AView, AColunaTipAju);

  // liga os eventos compartilhados
  AView.OnCustomDrawCell  := GridLogCustomDrawCell;
  ADataSource.OnDataChange := dsLogDataChange;

  // marca o DataSource com a view correspondente para o handler descobrir
  ADataSource.Tag := NativeInt(AView);
end;

procedure TfrmAuditoriaLancamentos.pRecalcularZebra(
  const AView: TcxGridDBBandedTableView);
var
  LCnt: Integer;
  LstrValorAtual, LstrValorAnterior: string;
  LblnCorAtual, LblnMesmoGrupo: Boolean;
  LvarValor: Variant;
  LdctCache: TDictionary<Integer, Boolean>;
  LcolTipAju: TcxGridDBBandedColumn;
begin
  if not FdctZebraPorView.TryGetValue(AView, LdctCache) then
    Exit;
  if not FdctColunaTipAju.TryGetValue(AView, LcolTipAju) then
    Exit;

  LdctCache.Clear;

  if AView.DataController.RecordCount = 0 then
    Exit;

  LblnCorAtual := False;
  LstrValorAnterior := EmptyStr;

  for LCnt := 0 to AView.DataController.RecordCount - 1 do
  begin
    LvarValor := AView.DataController.Values[LCnt, LcolTipAju.Index];
    LstrValorAtual := VarToStr(LvarValor);

    // Mesmo grupo somente quando ALT-ATU vem logo apos ALT-ANT
    LblnMesmoGrupo := (LstrValorAtual    = 'ALT-ATU') and
                     (LstrValorAnterior = 'ALT-ANT');

    if (LCnt > 0) and (not LblnMesmoGrupo) then
      LblnCorAtual := not LblnCorAtual;

    LdctCache.Add(LCnt, LblnCorAtual);
    LstrValorAnterior := LstrValorAtual;
  end;
end;

procedure TfrmAuditoriaLancamentos.dsLogDataChange(Sender: TObject;
  Field: TField);
var
  LView: TcxGridDBBandedTableView;
  LDs: TDataSource;
begin
  if Field <> nil then
    Exit;

  LDs := TDataSource(Sender);
  LView := TcxGridDBBandedTableView(Pointer(NativeInt(LDs.Tag)));

  if LView = nil then
    Exit;

  pRecalcularZebra(LView);
  if LView.Site <> nil then
    LView.Site.Invalidate;
end;

procedure TfrmAuditoriaLancamentos.GridLogCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
const
  CorCelulaFocada     : TColor = $00E39B5A;   // Azul-âmbar suave (fundo)
  CorFonteCelulaFocada: TColor = clWhite;     // Fonte na célula focada
  CorZebraAlternativa : TColor = $00DDDDDD;   // Cinza claro (linha zebrada)
var
  LblnCorAlternativa: Boolean;
  LintRecordIndex   : Integer;
  LdctCache         : TDictionary<Integer, Boolean>;
begin
  if AViewInfo.GridRecord = nil then
    Exit;

  // 1) Aplica a zebra normal
  if FdctZebraPorView.TryGetValue(
       TcxGridDBBandedTableView(Sender), LdctCache) then
  begin
    LintRecordIndex := AViewInfo.GridRecord.Index;

    if LdctCache.TryGetValue(LintRecordIndex, LblnCorAlternativa) then
    begin
      if LblnCorAlternativa then
        ACanvas.Brush.Color := CorZebraAlternativa
      else
        ACanvas.Brush.Color := clWindow;

      ACanvas.Font.Color := clWindowText;
    end;
  end;

  // 2) Destaca a célula focada (sobrescreve as cores da zebra apenas nessa célula).
  //    AViewInfo.Focused é True somente na célula com foco -
  //    não confundir com AViewInfo.GridRecord.Focused (linha inteira).
  If AViewInfo.Focused Then
  Begin
    ACanvas.Brush.Color := CorCelulaFocada;
    ACanvas.Font.Color  := CorFonteCelulaFocada;
    ACanvas.Font.Style  := ACanvas.Font.Style + [fsBold];
  End;
end;

procedure TfrmAuditoriaLancamentos.FormShow(Sender: TObject);
begin
  inherited;
  pShowInterno;
  pgParcon.ActivePage := tsParcon;
end;

function TfrmAuditoriaLancamentos.fTelaCadastroCredito(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  TAuditoriaCadastros.pAbrirDoDataset(dsLancon.DataSet, tolCredito);
  Result := True;
end;

function TfrmAuditoriaLancamentos.fTelaCadastroDebito(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  TAuditoriaCadastros.pAbrirDoDataset(dsLancon.DataSet, tolDebito);
  Result := True;
end;

function TfrmAuditoriaLancamentos.fTelaCadastroParcon(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  TAuditoriaCadastros.pAbrirDoDataset(dsLancon.DataSet, tolParcon);
  Result := True;
end;

function TfrmAuditoriaLancamentos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtEmpLan) Then
    Begin
      if fEmptyStr(edtEmpLan.Text) then
      begin
        edtNomEmp.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End

    Else If (Sender = mskContaCredito) Then
    Begin
      pCarregaPlanoContabilCredito(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) And (fEmptyStr(edtDesContaCredito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Crédito Inválida!',['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtConCreRed) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilCredito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = mskContaDebito) Then
    Begin
      pCarregaPlanoContabilDebito(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtConDebRed) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilDebito(blnBuscaPorChave, True) ;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmAuditoriaLancamentos.fValidarFiltroAvancado: Boolean;
var
  LPeloMenosUmFiltroSelecionado: Boolean;
begin
  Result := False;
  LPeloMenosUmFiltroSelecionado := False;

  if (edtDataInicial.Date > 0) or (edtDataFinal.Date > 0) then
  begin
    if edtDataInicial.Date <= 0 then
    begin
      fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&Ok']);
      pSetFocus(edtDataInicial);
      Exit;
    end;

    if edtDataFinal.Date <= 0 then
    begin
      fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&Ok']);
      pSetFocus(edtDataFinal);
      Exit;
    end;

    if edtDataFinal.Date < edtDataInicial.Date then
    begin
      fMensagem('ATENÇÃO!', 'Periodo inválido!', ['&Ok']);
      pSetFocus(edtDataInicial);
      Exit;
    end;
    LPeloMenosUmFiltroSelecionado := True;
  end;

  if not fEmptyStr(edtEmpLan.Text) then
  begin
    LPeloMenosUmFiltroSelecionado := True;
  end;

  if not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
  begin
    LPeloMenosUmFiltroSelecionado := True;
  end;

  if not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    LPeloMenosUmFiltroSelecionado := True;
  end;

  if not VarIsNull(edtValor.EditValue) then
  begin
    LPeloMenosUmFiltroSelecionado := True;
  end;

  if not fEmptyStr(edtComplemento.Text) then
  begin
    LPeloMenosUmFiltroSelecionado := True;
  end;

  if not LPeloMenosUmFiltroSelecionado then
  begin
    fMensagem('ATENÇÃO!', 'Pelo menos um filtro deve ser informado!', ['&Ok']);
    pSetFocus(edtDataInicial);
    Exit;
  end;

  Result := True;
end;

procedure TfrmAuditoriaLancamentos.GridTableLanconLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableLanconLog, GridTableViewLancon, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewBanNcoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewBanNco, GridTableViewBanNcoLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewBanNcoLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewBanNcoLog, GridTableViewBanNco, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewCliNcoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewCliNco, GridTableViewCliNcoLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewCliNcoLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewCliNcoLog, GridTableViewCliNco, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewCmpParFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewCmpPar, GridTableViewCmpParLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewCmpParLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewCmpParLog, GridTableViewCmpPar, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewCtaNcoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewCtaNco, GridTableViewCtaNcoLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewCtaNcoLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewCtaNcoLog, GridTableViewCtaNco, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewForNcoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewForNco, GridTableViewForNcoLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewForNcoLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewForNcoLog, GridTableViewForNco, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewLanconCON_CDORICPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fChamaTelaGravando(fTelaCadastroCredito);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewLanconCON_CDORIDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fChamaTelaGravando(fTelaCadastroDebito);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewLanconCON_SEQPARPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fChamaTelaGravando(fTelaCadastroParcon);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewLanconFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewLancon, GridTableLanconLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewParconFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewParcon, GridTableViewParconLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewParconLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewParconLog, GridTableViewParcon, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewParNcoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewParNco, GridTableViewParNcoLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewParNcoLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewParNcoLog, GridTableViewParNco, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewPorNcoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewPorNco, GridTableViewPorNcoLog, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.GridTableViewPorNcoLogFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  pSincronizarColunaGrid(GridTableViewPorNcoLog, GridTableViewPorNco, AFocusedItem);
end;

procedure TfrmAuditoriaLancamentos.pLanconAfterScroll(DataSet: TDataSet);
var
  LIncDoc: String;
  LAutoInc: String;
  LSeqPar: string;
  LCodigoPortador: string;
  LCodigoBandeira: string;
  LCodigoCliente: string;
  LCodigoPlanoConta: string;
  LCodigoFornecedor: string;
begin
  LIncDoc  := DataSet.FieldByName('CON_INCDOC').AsString;
  LAutoInc := DataSet.FieldByName('AUTOINCREM').AsString;
  LSeqPar  := DataSet.FieldByName('CON_SEQPAR').AsString;
  LCodigoPortador := EmptyStr;
  LCodigoBandeira := EmptyStr;
  LCodigoCliente := EmptyStr;
  LCodigoPlanoConta := EmptyStr;
  LCodigoFornecedor := EmptyStr;
  if DataSet.FieldByName('CON_TPORID').AsString = 'PT' then
    LCodigoPortador := DataSet.FieldByName('CON_CDORID').AsString;
  if DataSet.FieldByName('CON_TPORIC').AsString = 'PT' then
    LCodigoPortador := DataSet.FieldByName('CON_CDORIC').AsString;

  if DataSet.FieldByName('CON_TPORID').AsString = 'BN' then
    LCodigoBandeira := DataSet.FieldByName('CON_CDORID').AsString;
  if DataSet.FieldByName('CON_TPORIC').AsString = 'BN' then
    LCodigoBandeira := DataSet.FieldByName('CON_CDORIC').AsString;

  if (DataSet.FieldByName('CON_TPORID').AsString = 'CF') and
    (DataSet.FieldByName('CON_TIP_FC').AsString = 'C') then
    LCodigoCliente := DataSet.FieldByName('CON_CDORID').AsString;
  if (DataSet.FieldByName('CON_TPORIC').AsString = 'CF') and
    (DataSet.FieldByName('CON_TIP_FC').AsString = 'C')  then
    LCodigoCliente := DataSet.FieldByName('CON_CDORIC').AsString;

  if (DataSet.FieldByName('CON_TPORID').AsString = 'CF') and
    (DataSet.FieldByName('CON_TIP_FC').AsString = 'F') then
    LCodigoFornecedor := DataSet.FieldByName('CON_CDORID').AsString;
  if (DataSet.FieldByName('CON_TPORIC').AsString = 'CF') and
    (DataSet.FieldByName('CON_TIP_FC').AsString = 'F')  then
    LCodigoFornecedor := DataSet.FieldByName('CON_CDORIC').AsString;

  if DataSet.FieldByName('CON_TPORID').AsString = 'PC' then
    LCodigoPlanoConta := DataSet.FieldByName('CON_CDORID').AsString;
  if DataSet.FieldByName('CON_TPORIC').AsString = 'PC' then
    LCodigoPlanoConta := DataSet.FieldByName('CON_CDORIC').AsString;

  pCarregaInformacoesAuditoria(LIncDoc, LAutoInc, LSeqPar, LCodigoPortador,
    LCodigoBandeira, LCodigoCliente, LCodigoPlanoConta, LCodigoFornecedor,
    cbMostrarLogIncDoc.Checked);
end;

procedure TfrmAuditoriaLancamentos.mskContaCreditoClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmAuditoriaLancamentos.mskContaCreditoKeyPress(Sender: TObject;
  var Key: Char);
Var
  LArrPlan: TConsultasArray;
  LTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    LTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaCredito, edtDesContaCredito, Nil, Key, LArrPlan, True, LTplaco, not FExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaCredito.Text := fCarregaDescricaoConta(edtDesContaCredito.Text, edtEmpLan.Text) ;
    edtConCreRed.Text := fCarregaContaReduzida(edtDesContaCredito.Text, edtEmpLan.Text) ;
  End;
end;

procedure TfrmAuditoriaLancamentos.mskContaCreditoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaCredito, False, 2);
  end;
end;

procedure TfrmAuditoriaLancamentos.mskContaDebitoClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmAuditoriaLancamentos.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
Var
  LArrPlan: TConsultasArray;
  LTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    LTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, LArrPlan, True, LTplaco, not FExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaDebito.Text := fCarregaDescricaoConta(mskContaDebito.Text, edtEmpLan.Text) ;
    edtConDebRed.Text := fCarregaContaReduzida(mskContaDebito.Text, edtEmpLan.Text) ;
  End;
end;

procedure TfrmAuditoriaLancamentos.mskContaDebitoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaDebito, False, 1);
  end;
end;

procedure TfrmAuditoriaLancamentos.pBuscarConta(const ADbeTexto: TCustomEdit;
  const AContaReduzida: Boolean; const ATag: Integer);
var
  LTplaco: string ;
begin
  If (fEmptyStr(fSemMascaraPlaNco(ADbeTexto.Text), True)) Then
  Begin
    dbgBuscaConta.Visible := False;
    Exit;
  End;

  LTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;

  dbgBuscaConta.Tag := 0;

  FBuscaPlanoContas.Close;
  FBuscaPlanoContas.SQL.Clear;
  FBuscaPlanoContas.SQL.Add(' SELECT NCO_CODCON AS CODCON, NCO_DESCRI AS DESCON, NCO_CONRED AS CONRED ');
  FBuscaPlanoContas.SQL.Add('   FROM PLANCO ');
  FBuscaPlanoContas.SQL.Add('  WHERE TRUE AND NCO_TPLACO = :TPLACO ');
  FBuscaPlanoContas.ParamByName('TPLACO').AsString := LTplaco ;
  If (AContaReduzida) Then
    FBuscaPlanoContas.SQL.Add('  AND (NCO_CONRED LIKE :CODCON) ')
  Else
    FBuscaPlanoContas.SQL.Add('  AND (NCO_CODCON LIKE :CODCON) ');

  if fCfgCtntsi = 'N' then
  begin
    FBuscaPlanoContas.SQL.Add(' AND IFNULL(NCO_NATURE,"A") = "A" ') ;
  end ;

  FBuscaPlanoContas.ParamByName('CODCON').AsString := '%' + fTiraCaracEspeciais(fSemMascaraPlaNco(ADbeTexto.Text), True, True, True, True, True) + '%';
  FBuscaPlanoContas.SQL.Add('  ORDER BY NCO_CODCON ');
  FBuscaPlanoContas.Open;

  If (Not FBuscaPlanoContas.IsEmpty) Then
  Begin
    If (AContaReduzida) Then
    begin
      if (ATag = 1) then
        FBuscaPlanoContas.Locate('NCO_CODCON', mskContaDebito.Text, [])
      else
        FBuscaPlanoContas.Locate('NCO_CODCON', mskContaCredito.Text, []);
    end;

    dbgBuscaConta.Left := ADbeTexto.Left;
    dbgBuscaConta.Top := ADbeTexto.Top + ADbeTexto.Height + 1;
    dbgBuscaConta.Visible := True;
    dbgBuscaConta.Tag := ATag;
    if AContaReduzida then
    begin
      dbgBuscaConta.Tag := dbgBuscaConta.Tag + 10 ;
    end;
  End
  Else
    dbgBuscaConta.Visible := False;
end;

procedure TfrmAuditoriaLancamentos.pCarregaInformacoesAuditoria(
  const AIncDocLancon, AAutoIncLancon, ASeqParParcon,
      ACodigoPortador, ACodigoBandeira, ACodigoCliente, ACodigoPlanoConta,
      ACodigoFornecedor: string; const AMostrarTodoLogIncDoc: Boolean);
begin
  pCarregarLanconAlteracoes(AAutoIncLancon,
    AIncDocLancon, AMostrarTodoLogIncDoc);

  pCarregarParcon(ASeqParParcon);
  pCarregarParconAlteracoes(ASeqParParcon);

  pCarregarParNco(ASeqParParcon);
  pCarregarParNcoAlteracoes(ASeqParParcon);

  pCarregarCmpPar(ASeqParParcon);
  pCarregarCmpParAlteracoes(ASeqParParcon);

  pCarregarPorNco(ACodigoPortador);
  pCarregarPorNcoAlteracoes(ACodigoPortador);

  pCarregarBanNco(ACodigoBandeira);
  pCarregarBanNcoAlteracoes(ACodigoBandeira);

  pCarregarCliNco(ACodigoCliente);
  pCarregarCliNcoAlteracoes(ACodigoCliente);

  pCarregarForNco(ACodigoFornecedor);
  pCarregarForNcoAlteracoes(ACodigoFornecedor);

  pCarregarCtaNco(ACodigoPlanoConta);
  pCarregarCtaNcoAlteracoes(ACodigoPlanoConta);
end;

procedure TfrmAuditoriaLancamentos.pCarregaPlanoContabilCredito(
  const ABuscaPorChave: Boolean; const ACampoContaReduzida: Boolean);
var
  LTplaco: string ;
begin
  if ABuscaPorChave then
  begin
    edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)]);
    if not ACampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)]);
    end;
  end
  else
  begin
    LTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaCredito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), LTplaco]);
    if not ACampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), LTplaco]);
    end;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregaPlanoContabilDebito(
  const ABuscaPorChave: Boolean; const ACampoContaReduzida: Boolean);
var
  LTplaco : string ;
begin
  if ABuscaPorChave then
  begin
    edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    if not ACampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    end;
  end
  else
  begin
    LTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), LTplaco]);
    if not ACampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), LTplaco]);
    end;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarBanNco(const ACodigo: string);
begin
  dsBanNco.Enabled := False;
  try
    dsBanNco.DataSet := nil;
    if Assigned(FConsultaBanNco) then
    begin
      FreeAndNil(FConsultaBanNco);
    end;
    FConsultaBanNco := FAuditoriaService.fCarregarRegistroAtualBanNco(ACodigo);
    dsBanNco.DataSet := FConsultaBanNco;
  finally
    dsBanNco.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarBanNcoAlteracoes(
  const ACodigo: string);
begin
  dsBanNcoLog.Enabled := False;
  try
    dsBanNcoLog.DataSet := nil;
    if Assigned(FConsultaBanNcoLogs) then
    begin
      FreeAndNil(FConsultaBanNcoLogs);
    end;
    FConsultaBanNcoLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosBanNco(ACodigo);
    dsBanNcoLog.DataSet := FConsultaBanNcoLogs;
  finally
    dsBanNcoLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarCliNco(const ACodigo: string);
begin
  dsCliNco.Enabled := False;
  try
    dsCliNco.DataSet := nil;
    if Assigned(FConsultaCliNco) then
    begin
      FreeAndNil(FConsultaCliNco);
    end;
    FConsultaCliNco := FAuditoriaService.fCarregarRegistroAtualCliNco(ACodigo);
    dsCliNco.DataSet := FConsultaCliNco;
  finally
    dsCliNco.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarCliNcoAlteracoes(
  const ACodigo: string);
begin
  dsCliNcoLog.Enabled := False;
  try
    dsCliNcoLog.DataSet := nil;
    if Assigned(FConsultaCliNcoLogs) then
    begin
      FreeAndNil(FConsultaCliNcoLogs);
    end;
    FConsultaCliNcoLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosCliNco(ACodigo);
    dsCliNcoLog.DataSet := FConsultaCliNcoLogs;
  finally
    dsCliNcoLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarCmpPar(const ASeqPar: string);
begin
  dsCmpPar.Enabled := False;
  try
    dsCmpPar.DataSet := nil;
    if Assigned(FConsultaCmpPar) then
    begin
      FreeAndNil(FConsultaCmpPar);
    end;
    FConsultaCmpPar := FAuditoriaService.fCarregarRegistroAtualCmpPar(ASeqPar);
    dsCmpPar.DataSet := FConsultaCmpPar;
  finally
    dsCmpPar.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarCmpParAlteracoes(
  const ASeqPar: string);
begin
  dsCmpParLog.Enabled := False;
  try
    dsCmpParLog.DataSet := nil;
    if Assigned(FConsultaCmpParLogs) then
    begin
      FreeAndNil(FConsultaCmpParLogs);
    end;
    FConsultaCmpParLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosCmpPar(ASeqPar);
    dsCmpParLog.DataSet := FConsultaCmpParLogs;
  finally
    dsCmpParLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarCtaNco(const ACodigo: string);
begin
  dsCtaNco.Enabled := False;
  try
    dsCtaNco.DataSet := nil;
    if Assigned(FConsultaCtaNco) then
    begin
      FreeAndNil(FConsultaCtaNco);
    end;
    FConsultaCtaNco := FAuditoriaService.fCarregarRegistroAtualCtaNco(ACodigo);
    dsCtaNco.DataSet := FConsultaCtaNco;
  finally
    dsCtaNco.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarCtaNcoAlteracoes(
  const ACodigo: string);
begin
  dsCtaNcoLog.Enabled := False;
  try
    dsCtaNcoLog.DataSet := nil;
    if Assigned(FConsultaCtaNcoLogs) then
    begin
      FreeAndNil(FConsultaCtaNcoLogs);
    end;
    FConsultaCtaNcoLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosCtaNco(ACodigo);
    dsCtaNcoLog.DataSet := FConsultaCtaNcoLogs;
  finally
    dsCtaNcoLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarForNco(const ACodigo: string);
begin
  dsForNco.Enabled := False;
  try
    dsForNco.DataSet := nil;
    if Assigned(FConsultaForNco) then
    begin
      FreeAndNil(FConsultaForNco);
    end;
    FConsultaForNco := FAuditoriaService.fCarregarRegistroAtualForNco(ACodigo);
    dsForNco.DataSet := FConsultaForNco;
  finally
    dsForNco.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarForNcoAlteracoes(
  const ACodigo: string);
begin
  dsForNcoLog.Enabled := False;
  try
    dsForNcoLog.DataSet := nil;
    if Assigned(FConsultaForNcoLogs) then
    begin
      FreeAndNil(FConsultaForNcoLogs);
    end;
    FConsultaForNcoLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosForNco(ACodigo);
    dsForNcoLog.DataSet := FConsultaForNcoLogs;
  finally
    dsForNcoLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarLancon(
  const AFiltros: TArrayFiltrosLog);
begin
  if Assigned(FConsultaLancon) then
  begin
    FConsultaLancon.AfterScroll := Nil;
  end;
  dsLancon.Enabled := False;
  try
    dsLancon.DataSet := nil;
    if Assigned(FConsultaLancon) then
    begin
      FreeAndNil(FConsultaLancon);
    end;
    FConsultaLancon := FAuditoriaService.fCarregarRegistrosAtuaisLancon(
      AFiltros, FTipoPesquisa);
    dsLancon.DataSet := FConsultaLancon;
    FConsultaLancon.First;
  finally
    dsLancon.Enabled := True;
  end;
  FConsultaLancon.AfterScroll := pLanconAfterScroll;
  if not FConsultaLancon.IsEmpty then
    pLanconAfterScroll(FConsultaLancon);
end;

procedure TfrmAuditoriaLancamentos.pCarregarLanconAlteracoes(
  const AAutoInc, AIncDoc: string; const AMostrarTodoLogIncDoc: Boolean);
begin
  dsLanconLog.Enabled := False;
  try
    dsLanconLog.DataSet := nil;
    if Assigned(FConsultaLanconLogs) then
    begin
      FreeAndNil(FConsultaLanconLogs);
    end;
    FConsultaLanconLogs := FAuditoriaService.fCarregarLancamentosAlteradosLancon(
      AAutoInc, AIncDoc);
    pFiltrarLanconAlteracoes(AMostrarTodoLogIncDoc);
    dsLanconLog.DataSet := FConsultaLanconLogs;
  finally
    dsLanconLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarParcon(const ASeqPar: string);
begin
  dsParcon.Enabled := False;
  try
    dsParcon.DataSet := nil;
    if Assigned(FConsultaParcon) then
    begin
      FreeAndNil(FConsultaParcon);
    end;
    FConsultaParcon := FAuditoriaService.fCarregarRegistroAtualParcon(ASeqPar);
    dsParcon.DataSet := FConsultaParcon;
  finally
    dsParcon.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarParconAlteracoes(
  const ASeqPar: string);
begin
  dsParconLog.Enabled := False;
  try
    dsParconLog.DataSet := nil;
    if Assigned(FConsultaParconLogs) then
    begin
      FreeAndNil(FConsultaParconLogs);
    end;
    FConsultaParconLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosParcon(ASeqPar);
    dsParconLog.DataSet := FConsultaParconLogs;
  finally
    dsParconLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarParNco(const ASeqPar: string);
begin
  dsParNco.Enabled := False;
  try
    dsParNco.DataSet := nil;
    if Assigned(FConsultaParNco) then
    begin
      FreeAndNil(FConsultaParNco);
    end;
    FConsultaParNco := FAuditoriaService.fCarregarRegistroAtualParNco(ASeqPar);
    dsParNco.DataSet := FConsultaParNco;
  finally
    dsParNco.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarParNcoAlteracoes(
  const ASeqPar: string);
begin
  dsParNcoLog.Enabled := False;
  try
    dsParNcoLog.DataSet := nil;
    if Assigned(FConsultaParNcoLogs) then
    begin
      FreeAndNil(FConsultaParNcoLogs);
    end;
    FConsultaParNcoLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosParNco(ASeqPar);
    dsParNcoLog.DataSet := FConsultaParNcoLogs;
  finally
    dsParNcoLog.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarPorNco(const ACodigo: string);
begin
  dsPorNco.Enabled := False;
  try
    dsPorNco.DataSet := nil;
    if Assigned(FConsultaPorNco) then
    begin
      FreeAndNil(FConsultaPorNco);
    end;
    FConsultaPorNco := FAuditoriaService.fCarregarRegistroAtualPorNco(ACodigo);
    dsPorNco.DataSet := FConsultaPorNco;
  finally
    dsPorNco.Enabled := True;
  end;
end;

procedure TfrmAuditoriaLancamentos.pCarregarPorNcoAlteracoes(
  const ACodigo: string);
begin
  dsPorNcoLog.Enabled := False;
  try
    dsPorNcoLog.DataSet := nil;
    if Assigned(FConsultaPorNcoLogs) then
    begin
      FreeAndNil(FConsultaPorNcoLogs);
    end;
    FConsultaPorNcoLogs := FAuditoriaService.
      fCarregarRegistrosAlteradosPorNco(ACodigo);
    dsPorNcoLog.DataSet := FConsultaPorNcoLogs;
  finally
    dsPorNcoLog.Enabled := True;
  end;
end;

class function TfrmAuditoriaLancamentos.MontaFiltroIgualdade(
  const ACampo, AValor: String): String;
begin
  If fEmptyStr(AValor) Then
    Result := Format('((%s IS NULL) OR (%s = %s))',
                     [ACampo, ACampo, QuotedStr('')])
  Else
    Result := Format('(%s = %s)', [ACampo, QuotedStr(AValor)]);
end;

procedure TfrmAuditoriaLancamentos.pFiltrarLanconAlteracoes(
  const AMostrarTodoLogIncDoc: Boolean);

  function fCampoExisteCds(const ANome: string): Boolean;
  begin
    Result := Assigned(FConsultaLanconLogs.FindField(ANome));
  end;
var
  LFiltro: String;
begin
  If Not Assigned(FConsultaLanconLogs) Then
    Exit;

  FConsultaLanconLogs.Filtered := False;

  If AMostrarTodoLogIncDoc Then
    Exit;

  LFiltro := EmptyStr;

  if fCampoExisteCds('CON_TIPLAN') then
    LFiltro := LFiltro + IfThen(fEmptyStr(LFiltro), '', ' AND ') + MontaFiltroIgualdade('CON_TIPLAN', FConsultaLancon.FieldByName('CON_TIPLAN').AsString);

  if fCampoExisteCds('CON_DESVAL') then
    LFiltro := LFiltro + IfThen(fEmptyStr(LFiltro), '', ' AND ') + MontaFiltroIgualdade('CON_DESVAL', FConsultaLancon.FieldByName('CON_DESVAL').AsString);

  if fCampoExisteCds('CON_CLAFIS') then
    LFiltro := LFiltro + IfThen(fEmptyStr(LFiltro), '', ' AND ') + MontaFiltroIgualdade('CON_CLAFIS', FConsultaLancon.FieldByName('CON_CLAFIS').AsString);

  if fCampoExisteCds('CON_TABELA') then
    LFiltro := LFiltro + IfThen(fEmptyStr(LFiltro), '', ' AND ') + MontaFiltroIgualdade('CON_TABELA', FConsultaLancon.FieldByName('CON_TABELA').AsString);

  if LFiltro = EmptyStr then
    Exit;

  FConsultaLanconLogs.Filter := LFiltro;
  FConsultaLanconLogs.Filtered := True;
end;

procedure TfrmAuditoriaLancamentos.pFiltroAvancadoInterno;
var
  LFiltros: TArrayFiltrosLog;
begin
  LFiltros := [];
  if (edtDataInicial.Date > 0) and (edtDataFinal.Date > 0) then
  begin
    SetLength(LFiltros, Length(LFiltros) + 1);
    LFiltros[High(LFiltros)] := TParFiltroLog.Entre(
      'CON_DTALAN', edtDataInicial.Date, edtDataFinal.Date);
  end;

  if not fEmptyStr(edtEmpLan.Text) then
  begin
    SetLength(LFiltros, Length(LFiltros) + 1);
    LFiltros[High(LFiltros)] := TParFiltroLog.Igual(
      'CON_EMPLAN', edtEmpLan.Text);
  end;

  if not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
  begin
    SetLength(LFiltros, Length(LFiltros) + 1);
    LFiltros[High(LFiltros)] := TParFiltroLog.Igual(
      'CON_CONDEB', fSemMascaraPlaNco(mskContaDebito.Text));
  end;

  if not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    SetLength(LFiltros, Length(LFiltros) + 1);
    LFiltros[High(LFiltros)] := TParFiltroLog.Igual(
      'CON_CONCRE', fSemMascaraPlaNco(mskContaCredito.Text));
  end;

  if not VarIsNull(edtValor.EditValue) then
  begin
    SetLength(LFiltros, Length(LFiltros) + 1);
    LFiltros[High(LFiltros)] := TParFiltroLog.Igual(
      'CON_VALLAN', edtValor.Value);
  end;

  if not fEmptyStr(edtComplemento.Text) then
  begin
    SetLength(LFiltros, Length(LFiltros) + 1);
    LFiltros[High(LFiltros)] := TParFiltroLog.Contem(
      'CON_HISTOR', edtComplemento.Text);
  end;

  pCarregarLancon(LFiltros);
end;

procedure TfrmAuditoriaLancamentos.pShowInterno;
var
  LFiltros: TArrayFiltrosLog;
begin
  LFiltros := [];
  if not fEmptyStr(FAutoIncremLancon) then
  begin
    LFiltros := [TParFiltroLog.Igual('AUTOINCREM', FAutoIncremLancon)];
  end;
  pCarregarLancon(LFiltros);
end;

procedure TfrmAuditoriaLancamentos.pSincronizarColunaGrid(
  const AOrigem, ADestino: TcxGridDBBandedTableView;
  const AFocusedItem: TcxCustomGridTableItem);
var
  LCnt: Integer;
  LstrFieldName: string;
  LcolOrigem, LcolDestino: TcxGridDBBandedColumn;
begin
  if FblnSincronizandoFoco then
    Exit;

  if not (AFocusedItem is TcxGridDBBandedColumn) then
    Exit;

  LcolOrigem := TcxGridDBBandedColumn(AFocusedItem);
  LstrFieldName := LcolOrigem.DataBinding.FieldName;

  if LstrFieldName = EmptyStr then
    Exit;

  LcolDestino := nil;
  for LCnt := 0 to ADestino.ColumnCount - 1 do
  begin
    if SameText(ADestino.Columns[LCnt].DataBinding.FieldName, LstrFieldName) then
    begin
      LcolDestino := ADestino.Columns[LCnt];
      Break;
    end;
  end;

  if LcolDestino = nil then
    Exit;

  // coluna oculta nao pode receber foco
  if not LcolDestino.Visible then
    Exit;

  FblnSincronizandoFoco := True;
  try
    ADestino.Controller.FocusedColumn := LcolDestino;
  finally
    FblnSincronizandoFoco := False;
  end;
end;

end.
