unit untCadCotacaoGeralCX;

interface

uses
  cxGridDBDataDefinitions,
  cxVariants,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, EditFocus, Vcl.Mask,
  DBEditFocus, Vcl.ComCtrls, Data.DB, untFuncoesSimples, untCotacao, DBMemoFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid,
  cxGridDBTableView, DBLookupComboBoxFocus, Vcl.CheckLst, cxCheckBox,
  cxDropDownEdit, ComboBoxFocus, untTypessistema, untConsultas, untFuncoesConsulta,
  Vcl.Grids, Vcl.DBGrids, untFuncoesRel, untFuncoesRel2, untCadProdutosCompCusto,
  cxDataControllerConditionalFormattingRulesManagerDialog, untCfgGrid,
  cxTextEdit, untTabQtd, UniClientDataSet, uni, untFatMostraPedSalRes, untCotacaoTypesAndConst,
  untFuncoesPedidoSimples, untFatMostraEstoqueEmp, cxButtonEdit, System.Actions,
  Vcl.ActnList, cxContainer, cxProgressBar, dxCore, cxDateUtils, cxMaskEdit,
  cxCalendar, cxDBEdit, cxImageComboBox, System.ImageList, Vcl.ImgList,
  cxImageList, dxGDIPlusClasses, cxImage, PitStop.Comunicacao,
  cxEditRepositoryItems, Cotacao.ApiPrecos.ConstAndTypes;

type

  TPosicaoRegistro = record
    intRecordIndex,
    intPosition: Integer;
  end;

  TPosicaoRegistroPrt = ^TPosicaoRegistro;

  TcxGridDBDataController = class (cxGridDBDataDefinitions.TcxGridDBDataController)
  Private

     Procedure SetOrdenar(Value: Boolean);
     Function GetOrdenar: Boolean;

  protected

  property
    blnOrdenar: Boolean Read GetOrdenar Write SetOrdenar;
  end;

  TMycxCustomDataControllerInfo = class (TcxCustomDataControllerInfo)
  protected
    procedure DoSort; override;
  public
    blnOrdenar: Boolean;
  end;

  TfrmCadCotacaoGeralCX = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dbeNumCot: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    edtNomCmp: TEditFocus;
    edtCodCmp: TEditFocus;
    dbeMulLoj: TDBCheckBox;
    pagCotacao: TPageControl;
    tabItens: TTabSheet;
    tabFornecedores: TTabSheet;
    tabCotForIte: TTabSheet;
    tabComparativo: TTabSheet;
    tabAtualizaPreco: TTabSheet;
    dtsCotGer: TDataSource;
    pnlBotoesItens: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    pnlGiro: TPanel;
    splGiro: TSplitter;
    pnlAplicacao: TPanel;
    pnlTitAplic: TPanel;
    dbeAplica: TDBMemoFocus;
    splAplicacao: TSplitter;
    lblReq: TPanel;
    Panel2: TPanel;
    btnExpArq: TBitBtnLocked;
    btnImpArq: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnForPre: TBitBtnLocked;
    pnlTailFornecedores: TPanel;
    dtsCotCfo: TDataSource;
    pnlHeader: TPanel;
    Fornecedor: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeDtaEnt: TDBEditFocus;
    dbeConPag: TDBEditFocus;
    cxgItensFornecLevel1: TcxGridLevel;
    cxgItensFornec: TcxGrid;
    cxbItensFornec: TcxGridDBBandedTableView;
    cxbItensFornecCODITE: TcxGridDBBandedColumn;
    cxbItensFornecCODFAB: TcxGridDBBandedColumn;
    cxbItensFornecDESITE: TcxGridDBBandedColumn;
    cxbItensFornecREFERE: TcxGridDBBandedColumn;
    cxbItensFornecDESMAR: TcxGridDBBandedColumn;
    cxbItensFornecQTDITE: TcxGridDBBandedColumn;
    cxbItensFornecVALUNI: TcxGridDBBandedColumn;
    cxbItensFornecIPIENT: TcxGridDBBandedColumn;
    cxbItensFornecSUBSTI: TcxGridDBBandedColumn;
    cxbItensFornecVALTOT: TcxGridDBBandedColumn;
    cxbItensFornecDTAULT: TcxGridDBBandedColumn;
    cxbItensFornecFORULT: TcxGridDBBandedColumn;
    cxbItensFornecPREULT: TcxGridDBBandedColumn;
    pnlComparativo: TPanel;
    shp6: TShape;
    lbl7: TLabel;
    Shape3: TShape;
    Label14: TLabel;
    Label15: TLabel;
    Shape4: TShape;
    GroupBox1: TGroupBox;
    btnMarca: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnAtuPre: TBitBtnLocked;
    GroupBox2: TGroupBox;
    btnRecalcPreco: TBitBtnLocked;
    btnRecalcMargem: TBitBtnLocked;
    btnDesPreAtu: TBitBtnLocked;
    cxgAtuPrecos: TcxGrid;
    cxgItensBandedFixa: TcxGridDBBandedTableView;
    cxbAtuPrecos: TcxGridDBBandedTableView;
    cxbAtuPrecosCODITE: TcxGridDBBandedColumn;
    cxbAtuPrecosCODFAB: TcxGridDBBandedColumn;
    cxbAtuPrecosDESITE: TcxGridDBBandedColumn;
    cxbAtuPrecosLOCFIS: TcxGridDBBandedColumn;
    cxbAtuPrecosSIGUNI: TcxGridDBBandedColumn;
    cxbAtuPrecosREFERE: TcxGridDBBandedColumn;
    cxbAtuPrecosPRECOT: TcxGridDBBandedColumn;
    cxbAtuPrecosPRECOM: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVCUS: TcxGridDBBandedColumn;
    cxbAtuPrecosPRECUS: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR1: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE1: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR2: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE2: TcxGridDBBandedColumn;
    cxbAtuPrecosATUPRE: TcxGridDBBandedColumn;
    cxbAtuPrecosSALDOS: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE1: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE2: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR3: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE3: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE3: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR4: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE4: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE4: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR5: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE5: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE5: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR6: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE6: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE6: TcxGridDBBandedColumn;
    cxbAtuPrecosMARBR7: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVVE7: TcxGridDBBandedColumn;
    cxbAtuPrecosPREVE7: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER1: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER2: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER3: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER4: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER5: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER6: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER7: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER8: TcxGridDBBandedColumn;
    cxbAtuPrecosDIFER9: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR1: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR2: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR3: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR4: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR5: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR6: TcxGridDBBandedColumn;
    cxbAtuPrecosNOVBR7: TcxGridDBBandedColumn;
    cxbAtuPrecosTIPALT: TcxGridDBBandedColumn;
    cxbAtuPrecosPJAATU: TcxGridDBBandedColumn;
    cxgItensLevel: TcxGridLevel;
    cmbCodFor: TComboBoxFocus;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle3: TcxStyle;
    cxStyle1: TcxStyle;
    Panel6: TPanel;
    chkNOVIPI: TDBCheckBox;
    pgbProgresso: TProgressBar;
    dtsItens: TDataSource;
    cxbItens: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxbItensCODITE: TcxGridDBColumn;
    cxbItensDESITE: TcxGridDBColumn;
    cxbItensCODFAB: TcxGridDBColumn;
    cxbItensCODGRU: TcxGridDBColumn;
    cxbItensREFERE: TcxGridDBColumn;
    cxbItensQTDITE: TcxGridDBColumn;
    cxbItensDTAULT: TcxGridDBColumn;
    cxbItensFORULT: TcxGridDBColumn;
    cxbItensPREULT: TcxGridDBColumn;
    cxbItensDESMAR: TcxGridDBColumn;
    cxbItensCODSEM: TcxGridDBColumn;
    cxbItensSALDOS: TcxGridDBColumn;
    cxbItensDIAEST: TcxGridDBColumn;
    cxbItensDIASUG: TcxGridDBColumn;
    pnlTailFixo: TPanel;
    lblExiApli: TLabel;
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnGiroEst: TBitBtnLocked;
    btnImporta: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    btnSemelhantes: TBitBtnLocked;
    btnPrepTE: TBitBtnLocked;
    pnlTotFor: TPanel;
    edtValTot: TEditFocus;
    edtValSub: TEditFocus;
    edtValIpi: TEditFocus;
    edtValUni: TEditFocus;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    pnlDigitador: TPanel;
    lblTitDig: TLabel;
    edtNomDig: TEditFocus;
    btnComSisAnt: TBitBtnLocked;
    cxbItensIMPULT: TcxGridDBColumn;
    cxbItensFornecIMPULT: TcxGridDBBandedColumn;
    lblEmpDes: TLabel;
    dbeEmpDes: TDBEditFocus;
    btnIncForGupos: TBitBtnLocked;
    cxImageList1: TcxImageList;
 

    cxbItensFornecFREENT: TcxGridDBBandedColumn;
    Label23: TLabel;
    edtValFre: TEditFocus;
    cxbItensFornecALQCBS: TcxGridDBBandedColumn;
    cxbItensFornecALQIBS: TcxGridDBBandedColumn;
    cxbItensFornecALQ_IS: TcxGridDBBandedColumn;
    lblValCbs: TLabel;
    lblValIbs: TLabel;
    lblValIs: TLabel;
    edtValCbs: TEditFocus;
    edtValIbs: TEditFocus;
    edtValIs: TEditFocus;
    btnReplicaDados: TBitBtnLocked;
    pnlTail: TPanel;
    Label6: TLabel;
    Label9: TLabel;
    edtDesIte: TEditFocus;
    edtQtdIte: TEditFocus;
    edtCodIte: TEditFocus;
    cxbItensGERPED: TcxGridDBColumn;
    btnMarDesGerPed: TBitBtnLocked;
    btnMarGerPed: TBitBtnLocked;
    btnDesGerPed: TBitBtnLocked;
    cxbItensFornecGERPED: TcxGridDBBandedColumn;
    btnEncerra: TBitBtnLocked;
    edtCodDig: TEditFocus;
    btnCompCusto: TBitBtnLocked;
    btnSimilar: TBitBtnLocked;
    pnlPesoTotal: TPanel;
    cxbItensPESOIT: TcxGridDBColumn;
    btnCfgGriItens: TBitBtnLocked;
    cxbItensPRCLIQ: TcxGridDBColumn;
    cxbItensPRECUS: TcxGridDBColumn;
    cxbItensUNIMED: TcxGridDBColumn;
    btnEstoqueDasLojas: TBitBtnLocked;
    btnMarcarDesmarcarExcluir: TBitBtnLocked;
    cxbItensEXCLUI: TcxGridDBColumn;
    cxbItensMEDIA: TcxGridDBColumn;
    cxbItensSALDOSLOJASGIROS: TcxGridDBColumn;
    btnCarregaPedidosVenda: TBitBtnLocked;
    chkSuspendeOrdenacao: TCheckBox;
    Panel4: TPanel;
    pnlObservacao: TPanel;
    dbeObsCmp: TDBMemoFocus;
    Label24: TLabel;
    lblCliFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    btnIncluiFornecedor: TBitBtnLocked;
    btnExcluiFornecedor: TBitBtnLocked;
    cxbItensITESIM: TcxGridDBColumn;
    cxbItensORDITE: TcxGridDBColumn;
    cxbItensFornecITESIM: TcxGridDBBandedColumn;
    cxbItensFornecORDITE: TcxGridDBBandedColumn;
    cxbAtuPrecosORDITE: TcxGridDBBandedColumn;
    cxbAtuPrecosITESIM: TcxGridDBBandedColumn;
    pnlSimilar: TPanel;
    shpSimilar: TShape;
    lblSimilar: TLabel;
    btnInsPla: TSpeedButton;
    cxbItensSALSIM: TcxGridDBColumn;
    pnlComparativoCtn: TPanel;
    splAplicacaoTopo: TSplitter;
    pnlCotainerComp: TPanel;
    Panel5: TPanel;
    lblForUti: TLabel;
    lsvForUti: TCheckListBox;
    Panel1: TPanel;
    lblOcultarGiro: TLabel;
    btnCfgGri: TBitBtnLocked;
    pnlContainerGiroComparativo: TPanel;
    splAplicacaoRodape: TSplitter;
    pnlContainerAplicacao: TPanel;
    pnlTituloAplicacao: TPanel;
    dbeAplicaComparativo: TDBMemoFocus;
    pnlGiroComparativo: TPanel;
    pnlBotoesComparativo: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Shape1: TShape;
    Label12: TLabel;
    Shape2: TShape;
    Label13: TLabel;
    Shape5: TShape;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtTotGer: TEditFocus;
    btnMarPre: TBitBtnLocked;
    btnSelMen: TBitBtnLocked;
    btnExpExcel: TBitBtnLocked;
    btnSimilaresComparativo: TBitBtnLocked;
    btnAlteraValor: TBitBtnLocked;
    rdgTotCot: TRadioGroup;
    btnGerPed: TBitBtnLocked;
    btnGerPedSel: TBitBtnLocked;
    btnSelPedTodos: TBitBtnLocked;
    btnSelPed: TBitBtnLocked;
    btnDocSalRes: TBitBtnLocked;
    cxvComparativo: TcxGrid;
    cxbComparativo: TcxGridDBBandedTableView;
    cxbComparativoCODITE: TcxGridDBBandedColumn;
    cxbComparativoCODFAB: TcxGridDBBandedColumn;
    cxbComparativoDESITE: TcxGridDBBandedColumn;
    cxbComparativoREFERE: TcxGridDBBandedColumn;
    cxbComparativoDESMAR: TcxGridDBBandedColumn;
    cxbComparativoQTDITE: TcxGridDBBandedColumn;
    cxbComparativoDTAULT: TcxGridDBBandedColumn;
    cxbComparativoFORULT: TcxGridDBBandedColumn;
    cxbComparativoPREULT: TcxGridDBBandedColumn;
    cxbComparativoIMPULT: TcxGridDBBandedColumn;
    cxbComparativoCODSIM: TcxGridDBBandedColumn;
    cxbComparativoSIGUNI: TcxGridDBBandedColumn;
    cxbComparativoPRECUS: TcxGridDBBandedColumn;
    cxbComparativoDIFCUS: TcxGridDBBandedColumn;
    cxbComparativoVALTOT01: TcxGridDBBandedColumn;
    cxbComparativoVALTOT02: TcxGridDBBandedColumn;
    cxbComparativoVALTOT03: TcxGridDBBandedColumn;
    cxbComparativoVALTOT04: TcxGridDBBandedColumn;
    cxbComparativoVALTOT05: TcxGridDBBandedColumn;
    cxbComparativoVALTOT06: TcxGridDBBandedColumn;
    cxbComparativoVALTOT07: TcxGridDBBandedColumn;
    cxbComparativoVALTOT08: TcxGridDBBandedColumn;
    cxbComparativoVALTOT09: TcxGridDBBandedColumn;
    cxbComparativoVALTOT10: TcxGridDBBandedColumn;
    cxbComparativoVALTOT11: TcxGridDBBandedColumn;
    cxbComparativoVALTOT12: TcxGridDBBandedColumn;
    cxbComparativoVALTOT13: TcxGridDBBandedColumn;
    cxbComparativoVALTOT14: TcxGridDBBandedColumn;
    cxbComparativoVALTOT15: TcxGridDBBandedColumn;
    cxbComparativoVALTOT16: TcxGridDBBandedColumn;
    cxbComparativoVALTOT17: TcxGridDBBandedColumn;
    cxbComparativoVALTOT18: TcxGridDBBandedColumn;
    cxbComparativoVALTOT19: TcxGridDBBandedColumn;
    cxbComparativoVALTOT20: TcxGridDBBandedColumn;
    cxbComparativoVALTOT21: TcxGridDBBandedColumn;
    cxbComparativoVALTOT22: TcxGridDBBandedColumn;
    cxbComparativoVALTOT23: TcxGridDBBandedColumn;
    cxbComparativoVALTOT24: TcxGridDBBandedColumn;
    cxbComparativoVALTOT25: TcxGridDBBandedColumn;
    cxbComparativoVALTOT26: TcxGridDBBandedColumn;
    cxbComparativoVALTOT27: TcxGridDBBandedColumn;
    cxbComparativoVALTOT28: TcxGridDBBandedColumn;
    cxbComparativoVALTOT29: TcxGridDBBandedColumn;
    cxbComparativoVALTOT30: TcxGridDBBandedColumn;
    cxbComparativoVALTOT31: TcxGridDBBandedColumn;
    cxbComparativoVALTOT32: TcxGridDBBandedColumn;
    cxbComparativoVALTOT33: TcxGridDBBandedColumn;
    cxbComparativoVALTOT34: TcxGridDBBandedColumn;
    cxbComparativoVALTOT35: TcxGridDBBandedColumn;
    cxbComparativoVALTOT36: TcxGridDBBandedColumn;
    cxbComparativoVALTOT37: TcxGridDBBandedColumn;
    cxbComparativoVALTOT38: TcxGridDBBandedColumn;
    cxbComparativoVALTOT39: TcxGridDBBandedColumn;
    cxbComparativoVALTOT40: TcxGridDBBandedColumn;
    cxbComparativoVALTOT41: TcxGridDBBandedColumn;
    cxbComparativoVALTOT42: TcxGridDBBandedColumn;
    cxbComparativoVALTOT43: TcxGridDBBandedColumn;
    cxbComparativoVALTOT44: TcxGridDBBandedColumn;
    cxbComparativoVALTOT45: TcxGridDBBandedColumn;
    cxbComparativoVALTOT46: TcxGridDBBandedColumn;
    cxbComparativoVALTOT47: TcxGridDBBandedColumn;
    cxbComparativoVALTOT48: TcxGridDBBandedColumn;
    cxbComparativoVALTOT49: TcxGridDBBandedColumn;
    cxbComparativoVALTOT50: TcxGridDBBandedColumn;
    cxbComparativoFORMEN: TcxGridDBBandedColumn;
    cxbComparativoFORESC: TcxGridDBBandedColumn;
    cxbComparativoTOTESC: TcxGridDBBandedColumn;
    cxbComparativoVLRUNT: TcxGridDBBandedColumn;
    cxbComparativoMARPED: TcxGridDBBandedColumn;
    cxbComparativoCUSREA: TcxGridDBBandedColumn;
    cxbComparativoDIFREA: TcxGridDBBandedColumn;
    cxbComparativoColumn1: TcxGridDBBandedColumn;
    cxbComparativoColumn2: TcxGridDBBandedColumn;
    cxbComparativoColumn3: TcxGridDBBandedColumn;
    cxbComparativoColumn4: TcxGridDBBandedColumn;
    cxbComparativoColumn5: TcxGridDBBandedColumn;
    cxbComparativoITESIM: TcxGridDBBandedColumn;
    cxbComparativoORDITE: TcxGridDBBandedColumn;
    cxbComparativoDIFCOL: TcxGridDBBandedColumn;
    cxbComparativoGERPED: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    cxbItensQTDREQ: TcxGridDBColumn;
    pnlTipoCotac: TPanel;
    lblTitTct: TLabel;
    edtCodTct: TEditFocus;
    edtDesTct: TEditFocus;
    pnlBID: TPanel;
    Label25: TLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    GroupBox3: TGroupBox;
    lblIntegrado: TLabel;
    rdbNaoLiberado: TRadioButton;
    rdbLiberado: TRadioButton;
    cxbAtuPrecosGERPED: TcxGridDBBandedColumn;
    cxbItensSALDIS: TcxGridDBColumn;
    cxImage1: TcxImage;
    mnuIntegracaPitStop: TPopupMenu;
    mnuBuscapreco1: TMenuItem;
    mnuBuscapreco2: TMenuItem;
    mnuCarregaPreco: TMenuItem;
    mnuRefazCotacao: TMenuItem;
    mnuIntegracao: TPopupMenu;
    mnuBuscaPreco: TMenuItem;
    mnuReiniciaCota: TMenuItem;
    ppmComunicaPitStop: TPopupMenu;
    mnuComPitStop: TMenuItem;
    mnuPitStopParado: TMenuItem;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ButtonItem1: TcxEditRepositoryButtonItem;
    cxgFornecedores: TcxGrid;
    cxvFornecedores: TcxGridDBTableView;
    cxvFornecedoresCODFOR: TcxGridDBColumn;
    cxvFornecedoresNOMFOR: TcxGridDBColumn;
    cxvFornecedoresMARCADO: TcxGridDBColumn;
    cxvFornecedoresCOT_IMGAPI: TcxGridDBColumn;
    cxvFornecedoresACTAPI: TcxGridDBColumn;
    cxvFornecedoresCOT_STAAPI: TcxGridDBColumn;
    cxvFornecedoresCOT_ANCORA: TcxGridDBColumn;
    cxvFornecedoresCOT_PITSTO: TcxGridDBColumn;
    cxvFornecedoresCOT_SKYPEC: TcxGridDBColumn;
    cxvFornecedoresEMAENV: TcxGridDBColumn;
    cxvFornecedoresDTAENV: TcxGridDBColumn;
    cxvFornecedoresENVDES: TcxGridDBColumn;
    cxvFornecedoresOBSERV: TcxGridDBColumn;
    cxvFornecedoresINIINT: TcxGridDBColumn;
    cxgFornecedoresLevel1: TcxGridLevel;
    lblCodSolicitacaoVinculada: TLabel;
    edtCodSolicitacaoVinculada: TEditFocus;
    
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbCodForChange(Sender: TObject);
    procedure lsvForUtiClickCheck(Sender: TObject);
    procedure pagCotacaoChange(Sender: TObject);
    procedure cxbComparativoVALTOT01CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxbComparativoKeyPress(Sender: TObject; var Key: Char);
    procedure cxbComparativoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarPreClick(Sender: TObject);
    procedure btnAlteraValorClick(Sender: TObject);
    procedure cxbItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxbItensFornecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxbAtuPrecosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvFornecedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGiroEstClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure btnSemelhantesClick(Sender: TObject);
    procedure btnPrepTEClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure dbeMulLojClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure splAplicacaoCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure lblExiApliClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxbItensFornecDTAULTCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnIncluiFornecedorClick(Sender: TObject);
    procedure btnExcluiFornecedorClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarDesClick(Sender: TObject);
    procedure cxvFornecedoresCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnForPreClick(Sender: TObject);
    procedure btnExpArqClick(Sender: TObject);
    procedure btnImpArqClick(Sender: TObject);
    procedure cxbItensFornecKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimilaresComparativoClick(Sender: TObject);
    procedure btnSelMenClick(Sender: TObject);
    procedure btnExpExcelClick(Sender: TObject);
    procedure btnGerPedClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure cxbAtuPrecosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnRecalcPrecoClick(Sender: TObject);
    procedure btnRecalcMargemClick(Sender: TObject);
    procedure cxbAtuPrecosNOVVE1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxbAtuPrecosNOVBR1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnDesPreAtuClick(Sender: TObject);
    procedure cxbAtuPrecosNOVBR1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxbAtuPrecosNOVVE1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAtuPreClick(Sender: TObject);
    procedure cxbAtuPrecosATUPREPropertiesChange(Sender: TObject);
    procedure cxbItensFornecVALUNIPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxbItensFornecDataControllerDataChanged(Sender: TObject);
    procedure edtCodCmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnComSisAntClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure chkNovIpiClick(Sender: TObject);
    procedure tabAtualizaPrecoShow(Sender: TObject);
    procedure tabAtualizaPrecoHide(Sender: TObject);
    procedure btnIncForGuposClick(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
    function fGetWidthBand(BandIndex: integer): integer;
    procedure pCarregaArrCampos;
    procedure btnReplicaDadosClick(Sender: TObject);
    procedure cxbItensFornecFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure lblOcultarGiroClick(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure cxbItensGERPEDPropertiesChange(Sender: TObject);
    procedure btnMarDesGerPedClick(Sender: TObject);
    procedure btnMarGerPedClick(Sender: TObject);
    procedure btnDesGerPedClick(Sender: TObject);
    procedure btnSelPedClick(Sender: TObject);
    procedure btnSelPedTodosClick(Sender: TObject);
    procedure edtCodTctKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTctExit(Sender: TObject);

    procedure cxbComparativoMARPEDPropertiesChange(Sender: TObject);
    procedure btnGerPedSelClick(Sender: TObject);
    procedure rdgTotCotClick(Sender: TObject);
    procedure btnEncerraClick(Sender: TObject);
    procedure btnDocSalResClick(Sender: TObject);
    procedure btnCompCustoClick(Sender: TObject);
    procedure cxbAtuPrecosCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure pnlBotoesComparativoCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure btnCfgGriItensClick(Sender: TObject);
    procedure cxbItensDataControllerSummaryFooterSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure btnEstoqueDasLojasClick(Sender: TObject);
    procedure btnMarcarDesmarcarExcluirClick(Sender: TObject);
    procedure cxbItensEXCLUIPropertiesChange(Sender: TObject);
    procedure cxbItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxbItensCODITEHeaderClick(Sender: TObject);
    procedure cxbItensDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
    procedure cxbItensFornecCODITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxbItensFornecDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
    procedure cxbComparativoDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
    procedure cxbAtuPrecosDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
    procedure cxbComparativoCODITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxbAtuPrecosCODITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnInsPlaClick(Sender: TObject);
    procedure btnCarregaPedidosVendaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeDtaEntExit(Sender: TObject);
    procedure chkSuspendeOrdenacaoClick(Sender: TObject);
    procedure cxbComparativoCODITEHeaderClick(Sender: TObject);
    procedure pBloqueiaProcessos;
    procedure pAjustaPainelStutusBID;
    procedure rdbLiberadoClick(Sender: TObject);
    procedure rdbNaoLiberadoClick(Sender: TObject);
    procedure cxbComparativoDataControllerFilterRecord(
      ADataController: TcxCustomDataController; ARecordIndex: Integer;
      var Accept: Boolean);
    procedure cxbAtuPrecosDataControllerFilterRecord(
      ADataController: TcxCustomDataController; ARecordIndex: Integer;
      var Accept: Boolean);
    procedure cxbItensFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure mnuConsultaPrecosPitStopClick(Sender: TObject);
    procedure mnuImportarPrecosPitStopClick(Sender: TObject);
    procedure cxvFornecedoresCOT_STAAPIGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure mnuBuscapreco1Click(Sender: TObject);
    procedure mnuBuscapreco2Click(Sender: TObject);
    procedure mnuCarregaPrecoClick(Sender: TObject);
    procedure mnuRefazCotacaoClick(Sender: TObject);
    procedure mnuReiniciaCotaClick(Sender: TObject);
    procedure mnuBuscaPrecoClick(Sender: TObject);
    procedure cxvFornecedoresACTAPIGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxvFornecedoresEMAENVGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxEditRepository1ButtonItem1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvFornecedoresFocusedRecordChanged(
      Sender:   TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);

    procedure cxvFornecedoresCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure mnuComPitStopClick(Sender: TObject);
    procedure mnuPitStopParadoClick(Sender: TObject);
    procedure edtCodSolicitacaoVinculadaKeyPress(Sender: TObject;
      var Key: Char);

  private
    { Private declarations }
    objCfgGri: TCfgGrid;
    IdCotacaoPitStop: String;
    ArrCamposCfg: TArrCamposCfg;
    ArrCampoBloqueado:  TArrCamposCfg;

    blnJaExcutouRecalculaPrecosInical: Boolean;

    cdsConsultaItem: TUniClientDataSet;
    lstOrdemResgistros: TList;

    blnUtilizaBid: Boolean;

    procedure msgPitStopTerminouProcesso(var Msg: TMessage); message  WM_PIT_STOP_CONCLUIDO;
    procedure pPreparaMnuIntegracaPitStop(AStatusPitStopCotacao: TStatusPitStopCotacao);

    procedure pLimpaItem;
    procedure pGeraPedidos(blnSelecionados: Boolean);
    Procedure pAfterScrollFornecedores(dataSet: TDataSet);
    procedure pAtualizaGridComparativo;
    Procedure pHabilitaDescricao(blnHabilita: Boolean);
    procedure pSimilares(blnVoltaSimilar: Boolean);
    Procedure pMudaPaginaCotacao(intIndex: Integer);

    procedure pIncluiFornecedor(blnValidar: Boolean);
    procedure pLimpaFornecedor;
    procedure pEscondePreços;

    Function fGetColunaValorTotal(intNroCol: integer): TcxGridDBBandedColumn;
    Function fCamposOk: Boolean;
    Function fRetTotalSelecionado: Double;

    Function fTestaLimiteFornecedor: Boolean;

    Procedure pMostraTotais;
    Procedure pSelecionaTipoTotal(intIndex: Integer);

    Function fEstaNaConsultaTab: Boolean;

    Function fSelecionaItem(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
    procedure pHabilitaCamposItem;
    procedure pDesabilitaCamposItem;
    procedure pLimpaCamposItem;
    procedure pFechaSelecionaItem;
    procedure pIncluiNaListaConsulta;
    procedure pIncluiFornecedoresVinculados(strCodIte: String);
    procedure pRetiraDaListaConsulta(strCodIte: String);
    function fItemEstaRepetido(strCodIte: String):Boolean;

    function fGetQtdeTab(const dblQtdePadrao: Double; RectLinhaGrid: TRect): Double;
    procedure pAlinharPainelSimilar(objParent: TWinControl; intLeft,
      intTop: Integer);
    function fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
    procedure pSalvaOrdenacao;
    procedure pLiberaOrdenacao;
  public
    { Public declarations }
    objCotacao: TCotacao;
    Procedure pCarregaComboFonecedores;
    procedure pAddCampoBloqueado(cxColumn: TcxGridDBBandedColumn);

    procedure pOnClickExcluir(Sender: TObject);
    procedure pOnClickExcluirSelecionados(Sender: TObject);
    procedure pAtualizaTotalSelecionado;

  protected
    function fLocalizaPosArray(objArray: TArrCamposCfg; strColuna: string): integer;
    Function fCarregaItensVendas(pgbProgresso: TcxProgressBar): Boolean;


    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaCodigoProduto(blnLoad: Boolean): Boolean;
  end;

var
  frmCadCotacaoGeralCX: TfrmCadCotacaoGeralCX;

implementation

{$R *.dfm}

Uses
  StrUtils, Math, untConstantes,
  untPreparaGeracaoTE, untFatMostraProdSimilar,
  untFatConsVendasAntigas, untTValidaValorPedidoCompra,
  untPanelCxItem, untPanelCxBanner, untPanelCxPreFiltro, untReimpressao, untAgregados,
  untFatRequisicaoCompras, untPnlBanner, untPnlPreFiltroCarro,
  untTelaGiroUma, untCadCotacaoGeralCXItem, untGravando,
  untSelItensVendasParaPedidoCompra,
  Cotacao.ProcessaApi, DateUtils,
  PitStop.Classes.EndPoint, PitStop.ShowLog,

  untCfgHabilitaConsultaCotacaoAPIBalcao, untManutencaoEquipamentoInterno;

Const
  INI_POS_PRECOS = 9;
  COR_SIMILAR = clNavy;

procedure TfrmCadCotacaoGeralCX.pHabilitaCamposItem;
begin
  edtCodIte.Enabled := True;
end;

Procedure TfrmCadCotacaoGeralCX.pHabilitaDescricao(blnHabilita: Boolean);
Begin
  if objCotacao.blnEdiCot Then
    Exit;

  edtDesIte.TabStop := blnHabilita;
  edtDesIte.ReadOnly := Not edtDesIte.TabStop;
End;

procedure TfrmCadCotacaoGeralCX.btnIncForGuposClick(Sender: TObject);
begin
  inherited;
  If Not btnIncForGupos.Enabled Then
    Exit;

  If Not fTestaLimiteFornecedor Then
    Exit;

  If fPergunta('Deseja adicionar os fornecedores pelos grupos de produtos da cotação?') Then
    objCotacao.fAdicionaFornecedoresGruposCotacao;
end;

procedure TfrmCadCotacaoGeralCX.btnIncluiFornecedorClick(Sender: TObject);
begin
  inherited;

  If Not btnIncluiFornecedor.Enabled Then
    Exit;

  pIncluiFornecedor(True);
end;

procedure TfrmCadCotacaoGeralCX.btnAtuPreClick(Sender: TObject);
begin
  inherited;

  objCotacao.fAtualizaPrecos;
end;

procedure TfrmCadCotacaoGeralCX.btnDesGerPedClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarcaTodosGerPed(False);
end;

procedure TfrmCadCotacaoGeralCX.btnCarregaPedidosVendaClick(Sender: TObject);
var frmCarregandoItensVenda: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmCarregandoItensVenda);
  Try
    frmCarregandoItensVenda.lblGravando.Caption := 'Carregando Itens';
    frmCarregandoItensVenda.fExecutarAcao := fCarregaItensVendas;
    frmCarregandoItensVenda.ShowModal;
  Finally
    pFreeAndNil(frmCarregandoItensVenda);
  End;

end;

procedure TfrmCadCotacaoGeralCX.btnCfgGriClick(Sender: TObject);
var arrColunasWidth: TColunasWidth;
    i: integer;
begin
  inherited;
  SetLength(arrColunasWidth, cxbComparativo.ColumnCount);
  for i := 0 To cxbComparativo.ColumnCount -1 do
  Begin
    arrColunasWidth[i] := cxbComparativo.Columns[i].Width;
  End;

  objCfgGri := TCfgGrid.Create(Self, cxbComparativo, 'Cotação de Itens - Comparativo', arrColunasWidth, strLoginUsuarioLogado, True, False, ArrCampoBloqueado);
  Try
    objCfgGri.pConfiguraColunas;
  //  cxbComparativo.Bands[0].Width := fGetWidthBand(0);
  //  cxbComparativo.Bands[1].Width := fGetWidthBand(1);

    pCarregaArrCampos;

  Finally
    FreeAndNil(objCfgGri);
  End;
end;

function TfrmCadCotacaoGeralCX.fGetWidthBand(BandIndex: integer): integer;
var i: integer;
begin
  Result := 0;
  For i:= 0 To cxbComparativo.ColumnCount -1 do
  Begin
    if (cxbComparativo.Columns[i].Visible) And
       (TcxGridDBBandedColumn(cxbComparativo.Columns[i]).Position.BandIndex = BandIndex) Then
     Result := Result + cxbComparativo.Columns[i].Width;
  End;
  //Ajuste para bandas inferiores a ultima.
  If (Result > 0) And (BandIndex < (cxbComparativo.Bands.Count -1)) Then
    Result := Result + 15;


end;



function TfrmCadCotacaoGeralCX.fItemEstaRepetido(strCodIte: String): Boolean;
  Var
    cdsDados: TUniClientDataSet;
begin
  Result := False;

  cdsDados := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsDados, objCotacao.cdsItens);
    With cdsDados Do
    Begin
      Active := False;
      Filter := 'CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;
      Active := True;

      If Not IsEmpty Then
        Result := RecordCount > 1;
    End;

  Finally
    FreeAndNil(cdsDados)
  End;
End;


procedure TfrmCadCotacaoGeralCX.pCarregaArrCampos;
  var
    i : integer;
begin
  SetLength(ArrCamposCfg, 0);
  If Assigned(Self) Then
  begin

    for i := 0 to Self.cxbComparativo.ColumnCount -1 do
    Begin
      if Self.cxbComparativo.Columns[i] is TcxGridDBBandedColumn then
      begin
        SetLength(ArrCamposCfg, Length(ArrCamposCfg) + 1);
        ArrCamposCfg[i].ComponentName := TcxGridDBBandedColumn(Self.cxbComparativo.Columns[i]).Name;
        ArrCamposCfg[i].Visible       := TcxGridDBBandedColumn(Self.cxbComparativo.Columns[i]).Visible;
        ArrCamposCfg[i].Width         := TcxGridDBBandedColumn(Self.cxbComparativo.Columns[i]).Width;
        ArrCamposCfg[i].BandIndex     := TcxGridDBBandedColumn(Self.cxbComparativo.Columns[i]).Position.BandIndex;
      End;
    End;
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnCompCustoClick(Sender: TObject);
Var
  frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin
  inherited;

  Try
    If Not fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    Begin
      fMensagem('', 'Usuário não tem acesso a esse recurso.', ['&Ok']);
      Exit;
    End;

    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := objCotacao.cdsItens.FieldByName('CODITE').AsString;
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmCadprodutosCompCusto);
end;

procedure TfrmCadCotacaoGeralCX.btnComSisAntClick(Sender: TObject);
begin
  inherited;
  If Not btnComSisAnt.Visible Then
    Exit;
  pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
  Try
    frmFatConsVendasAntigas.pSetarParaConsultaDeCompra;
    If not fEmptyStr(cxbItens.DataController.DataSource.DataSet.FieldByname('CODITE').AsString) Then
       frmFatConsVendasAntigas.edtProdutos.Text := cxbItens.DataController.DataSource.DataSet.FieldByname('CODITE').AsString;

    frmFatConsVendasAntigas.ShowModal;
  Finally
    FreeAndNil(frmFatConsVendasAntigas);
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarcaTodosAtualizaPreco(False);

end;

procedure TfrmCadCotacaoGeralCX.btnDesPreAtuClick(Sender: TObject);
begin
  inherited;

  objCotacao.pDesmarcaPrecosAtualizados;
end;

procedure TfrmCadCotacaoGeralCX.btnDocSalResClick(Sender: TObject);
begin
  With objCotacao.cdsItens Do
  Begin
    If IsEmpty Then
      Exit;

    TfrmFatMostraPedSalRes.pExibeDocsSaldosReservado(FieldByName('CODITE').AsString, VS_StrCodEmp, pMostraDocumentoReimpressao);
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnEncerraClick(Sender: TObject);
begin
  inherited;

  If fCamposOk And fPergunta('Ao encerrar a cotação ela não ficará mais disponível para alteração' + #13#10 +
                             'ou geração de Pedidos de Compra. Deseja prosseguir?') Then
  Begin
    objCotacao.blnEncerra := True;
    Close;
  End;


end;

procedure TfrmCadCotacaoGeralCX.btnEstoqueDasLojasClick(Sender: TObject);
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  inherited;
  objCotacao.EmProcessamento := True;
  Try

    Try

      If fEmptyStr(cxbItens.DataController.DataSource.DataSet.FieldByname('CODITE').AsString) And
        fEmptyStr(cxbItens.DataController.DataSource.DataSet.FieldByname('DESITE').AsString) Then
        Exit;


      pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

      frmFatMostraEstoqueEmp.blnFaturamento := False;
      frmFatMostraEstoqueEmp.strCodIte      := cxbItens.DataController.DataSource.DataSet.FieldByname('CODITE').AsString;
      frmFatMostraEstoqueEmp.strTabPre      := '';
      frmFatMostraEstoqueEmp.edtItem.Text   := cxbItens.DataController.DataSource.DataSet.FieldByname('CODITE').AsString + ' - ' +
                                               cxbItens.DataController.DataSource.DataSet.FieldByname('DESITE').AsString;
      frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(cxbItens.DataController.DataSource.DataSet.FieldByname('CODITE').AsString);
      frmFatMostraEstoqueEmp.showModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
    End;

    pFreeAndNil(frmFatMostraEstoqueEmp);
  Finally
    objCotacao.EmProcessamento := False;

  End;
end;

procedure TfrmCadCotacaoGeralCX.btnExcluiFornecedorClick(Sender: TObject);
begin
  inherited;
  If Not btnExcluiFornecedor.Enabled Then
    Exit;

  objCotacao.pExcluiFornecedor;
end;

procedure TfrmCadCotacaoGeralCX.btnCfgGriItensClick(Sender: TObject);
var
  arrColunasWidth: TColunasWidth;
begin
  inherited;
  objCfgGri := TCfgGrid.Create(Self, cxbItens,'Cotação de Itens - Itens', arrColunasWidth, strLoginUsuarioLogado, True, False, []);
  Try
    objCfgGri.pConfiguraColunas;
  Finally
    FreeAndNil(objCfgGri);
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnAlteraValorClick(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;

  If objCotacao.cdsItens.IsEmpty Then
    Exit;

  If Pos('UNITOT', cxbComparativo.Columns[cxbComparativo.Controller.FocusedColumn.Index].DataBinding.FieldName) > 0 Then
  Begin
    intIndex := cxbComparativo.Controller.FocusedColumn.Index;
    objCotacao.fAlteraValorUnitario(cxbComparativo.Columns[cxbComparativo.Controller.FocusedColumn.Index].DataBinding.FieldName);
    pAtualizaTotalSelecionado;
    cxbComparativo.Columns[intIndex].Focused := True;
  End;

end;

procedure TfrmCadCotacaoGeralCX.btnExcluirClick(Sender: TObject);
var
  blnMarcExc: Boolean;
  intRecNo: Integer;
begin
  inherited;
  If Not btnExcluir.Enabled Then
    Exit;

  With objCotacao.cdsItens Do
  Begin
    DisableControls;
    intRecNo := objCotacao.cdsItens.recNo;
    First;
    blnMarcExc := False;
    While not Eof do
    Begin
      if FieldByName('EXCLUI').AsString = 'S' Then
      Begin
        blnMarcExc := True;
        Break;
      End;
      Next;
    End;
    EnableControls;
    if blnMarcExc Then
      pOnClickExcluirSelecionados(Sender)
    Else
    Begin
      objCotacao.cdsItens.recNo := intRecNo;
      pOnClickExcluir(Sender);
    End;
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnExpArqClick(Sender: TObject);
begin
  inherited;

  objCotacao.pExportarArquivos;
end;

procedure TfrmCadCotacaoGeralCX.btnExpExcelClick(Sender: TObject);
begin
  inherited;
//  objCotacao.pExportarExcelComparativo;
  objCotacao.pExportarExcelComparativoNovo;
end;


procedure TfrmCadCotacaoGeralCX.btnForPreClick(Sender: TObject);
begin
  inherited;

  If Not btnForPre.Visible Then
    Exit;
  objCotacao.EmProcessamento := True;

  If objCotacao.fCarregaPrecosFornecedor Then
    fMensagem('','Atualização realizada com sucesso!', ['&OK']);
  objCotacao.EmProcessamento := False;

end;

procedure TfrmCadCotacaoGeralCX.pGeraPedidos(blnSelecionados: Boolean);
begin
  If Not objCotacao.fFornecedorOk Then
    Exit;

  If (Not fValidaCampos(edtCodCmp, False) ) Then
  Begin
    Exit;
  End;

  If Not objCotacao.fTemPrecoSelecionado(blnSelecionados) Then
  Begin
    pMensagemOk('Não há preços selecionados!');
    Exit;
  End;

  If Not objCotacao.fMostraPedidosPendentes(blnSelecionados) Then
  Begin
    pMensagemOk('Não há itens com quantidade maior que zero!');
    Exit;
  End;

  If Not objCotacao.fPedeTransportadora Then
    Exit;

  objValidaValorPedidoCompra := TValidaValorPedidoCompra.Create(objCotacao.cdsItensMultiLojas,
                                                          objCotacao.cdsItens,
                                                                objCotacao.cdsFornecedores,
                                                                '',
                                                                objCotacao.recObserv.fltDesAce,
                                                                objCotacao.recObserv.fltValFre);
  Try
    //Deu erro ao criar o CDS.
    If objValidaValorPedidoCompra.blnErroAoExecutar Then
      Exit;
    If objValidaValorPedidoCompra.blnExistePedidosComValoresInferiores then
      If Not objValidaValorPedidoCompra.fPedeSenhaLiberarTrava Then
        Exit;

  Finally
    FreeAndNil(objValidaValorPedidoCompra);
  End;

  If objCotacao.fValidaItensSemFornecedor Then
  Begin
    If blnSelecionados Then
      objCotacao.tpgGerarPedidos := tpgGeraF2
    Else
      objCotacao.tpgGerarPedidos := tpgTodos;

    btnGravar.Click;
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnGerPedClick(Sender: TObject);
begin
  if dtsCotCfo.DataSet.RecordCount = 1 then
    btnSelMenClick(Sender);

  pGeraPedidos(False);
end;

procedure TfrmCadCotacaoGeralCX.btnGerPedSelClick(Sender: TObject);
begin
  inherited;
  pGeraPedidos(True);
end;

procedure TfrmCadCotacaoGeralCX.btnGiroEstClick(Sender: TObject);
begin
  inherited;

  If Not (btnGiroEst.Visible) Then
    Exit;
  objCotacao.EmProcessamento := True;

  objCotacao.blnDeveExcluirCOTFOR := False;
  If (Not objCotacao.cdsItens.IsEmpty) And
     (Not fPergunta('Os itens da cotação serão excluidos e a cotação ficará com os novos itens do giro. Confima?')) Then
    Exit
  Else
    objCotacao.blnDeveExcluirCOTFOR := True;

  objCotacao.fPedeItensGiro;

  If Assigned(frmTelaGiroUma) Then
   frmTelaGiroUma.pHabilitaAlteracaEstMinMax;

  If (dbeMulLoj.Checked) And (Not cxbItensSALDOSLOJASGIROS.Visible) Then
  Begin
    cxgItens.Width := cxgItens.Width + cxbItensSALDOSLOJASGIROS.Width;
    cxbItensSALDOSLOJASGIROS.Visible := True;
    cxbItensSALDOSLOJASGIROS.Index   := cxbItensSALDOS.Index + 1;
  End;
  objCotacao.EmProcessamento := False;

end;

procedure TfrmCadCotacaoGeralCX.btnGravarClick(Sender: TObject);
begin
{  cdsItensGiro,
  cdsItensMultiLojas}
  inherited;
  chkNOVIPI.OnClick := nil;

end;

procedure TfrmCadCotacaoGeralCX.btnImpArqClick(Sender: TObject);
begin
  inherited;

  objCotacao.pImportaArquivos;
  pAtualizaTotalSelecionado;
end;

procedure TfrmCadCotacaoGeralCX.btnImportaClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCmp.Text) Then
  Begin
    fMensagem('','É preciso informar o comprardor para executar este processo!', ['&OK']);
    pSetFocus(edtCodCmp);
    Exit;
  End;
  objCotacao.EmProcessamento := True;
  objCotacao.fImportaRequisicao(edtCodCmp.Text);
  pSetFocus(edtCodIte);
  objCotacao.EmProcessamento := False;
end;

procedure TfrmCadCotacaoGeralCX.btnIncluirClick(Sender: TObject);
begin
    inherited;
  If Not btnIncluir.Enabled Then
    Exit;

  fValidaCampos(edtQtdIte, True);
end;

procedure TfrmCadCotacaoGeralCX.btnInsPlaClick(Sender: TObject);
begin
  inherited;
  objCotacao.pImportarItens;
end;

procedure TfrmCadCotacaoGeralCX.btnMarcaClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarcaDesmarcaAtualizaPreco;
end;

procedure TfrmCadCotacaoGeralCX.btnMarcarDesmarcarExcluirClick(Sender: TObject);
begin
  inherited;
  objCotacao.pMarDesExcluirItens;
end;

procedure TfrmCadCotacaoGeralCX.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarcaTodosAtualizaPreco(True);
end;

procedure TfrmCadCotacaoGeralCX.btnMarDesClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarcaDesmarcaFornecedor;
end;

procedure TfrmCadCotacaoGeralCX.btnMarDesGerPedClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarDesGerPed;
end;

procedure TfrmCadCotacaoGeralCX.btnMarGerPedClick(Sender: TObject);
begin
  inherited;

  objCotacao.pMarcaTodosGerPed(True);
end;

procedure TfrmCadCotacaoGeralCX.btnMarPreClick(Sender: TObject);
begin
  inherited;

  If objCotacao.cdsItens.IsEmpty Then
    Exit;

  If Pos('UNITOT', cxbComparativo.Columns[cxbComparativo.Controller.FocusedColumn.Index].DataBinding.FieldName) > 0 Then
  Begin
    objCotacao.pMarcaEscolhido(cxbComparativo.Columns[cxbComparativo.Controller.FocusedColumn.Index].DataBinding.FieldName);
    pAtualizaTotalSelecionado;
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnPrepTEClick(Sender: TObject);
  Var
    objPreparaGer: TPreparaGeracaoTE;
    strCodIte: String;
begin
  inherited;

  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;
  objCotacao.EmProcessamento := True;

  With objCotacao.cdsItens Do
  Begin
    If IsEmpty Then
      strCodIte := ''
    Else
      strCodIte := FieldByName('CODITE').AsString;

    objPreparaGer := TPreparaGeracaoTE.Create;
    objPreparaGer.pInformaPreparacao(strCodIte);

    FreeAndNil(objPreparaGer);
  End;
  objCotacao.EmProcessamento := False;
end;

procedure TfrmCadCotacaoGeralCX.btnRecalcMargemClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma o recálculo da margem com preço atual do cadastro de produtos?') Then
    objCotacao.fRecalculaPrecos(False);
end;

procedure TfrmCadCotacaoGeralCX.btnRecalcPrecoClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma o recálculo do preço de venda com a margem atual do cadastro de produtos?') Then
    objCotacao.fRecalculaPrecos(True);
end;

procedure TfrmCadCotacaoGeralCX.btnReplicaDadosClick(Sender: TObject);
  var blnAll: Boolean;
begin
  inherited;
  If cxbItensFornec.DataController.DataSet.State in dsEditmodes Then
  Begin
    pSetFocus(btnReplicaDados);
  End;
  If btnReplicaDados.Enabled Then
  Begin
    blnAll := fPergunta('Substituir este valor nos registros com valores maior que zero?');


    objCotacao.pReplicaDados(TcxGridDBBandedColumn(cxbItensFornec.Controller.FocusedColumn).DataBinding.FieldName, blnAll);
  End;
end;

procedure TfrmCadCotacaoGeralCX.pSimilares(blnVoltaSimilar: Boolean);
  Var
    objParametrosRelatorio: TParametrosRelatorio;
begin
  With objCotacao.cdsItens Do
  Begin
    If Assigned(prcExecutaRelatorio) Then
    begin
      objParametrosRelatorio := TParametrosRelatorio.Create;
      objParametrosRelatorio.strCampoRetorno := 'ITE_CODITE';
      objParametrosRelatorio.blnRetornaCampoComEnter := True;
      objParametrosRelatorio.strMensagemRodape := ' Tecle [ ENTER ] sobre o produto para incluí-lo na cotação';

      prcExecutaRelatorio(63,
                          5036,
                          [],
                          ['CODSIM','CODEMP'],
                          [objCotacao.cdsItens.FieldByName('CODSIM').AsString,''],
                          btnSimilares,
                          nil,
                          True{blnExecutarDireto},
                          True{blnExibirMensagem: Boolean = True},
                          ''{strDirAce: String = ''},
                          False{blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False},
                          objParametrosRelatorio);

      If blnVoltaSimilar And (Not objParametrosRelatorio.strValorRetorno.IsEmpty) Then
      Begin
        edtCodIte.Text := objParametrosRelatorio.strValorRetorno;

        If fValidaCampos(edtCodIte, True) Then
          pSetFocus(edtQtdIte);
      End

      Else pSetFocus(ActiveControl);

      FreeAndNil(objParametrosRelatorio);
    End;

  End;
end;

procedure TfrmCadCotacaoGeralCX.rdbLiberadoClick(Sender: TObject);
begin
  inherited;
  If Not blnUtilizaBid Then
    Exit;

  If (rdbLiberado.Checked) and (objCotacao.FieldByName('COT_LIBBID').AsString = 'N') Then
  Begin
    If Not fPergunta('Ao liberar esta cotação para o BID de Compras, não será possível' +#$A#$D +
                     'realizar nenhuma edição adicional. ' +#$A#$D +
                     'Confirma realmente a liberação desta cotação ?') Then
     rdbNaoLiberado.Checked := True
   Else
     objCotacao.FieldByName('COT_LIBBID').AsString := 'L';
  End;

  If objCotacao.FieldByName('COT_LIBBID').AsString <> 'N' Then
    pBloqueiaProcessos;
  pAjustaPainelStutusBID;
end;

procedure TfrmCadCotacaoGeralCX.rdbNaoLiberadoClick(Sender: TObject);
begin
  inherited;
  lblIntegrado.Visible := False;
end;

procedure TfrmCadCotacaoGeralCX.rdgTotCotClick(Sender: TObject);
begin
  inherited;

  pSelecionaTipoTotal(rdgTotCot.ItemIndex);

end;

procedure TfrmCadCotacaoGeralCX.btnSelMenClick(Sender: TObject);
begin
  inherited;

  If (Sender = btnSelMen) then
  begin
   if Not fPergunta('Confirma a seleção dos itens pelo menor preço?') Then
    Exit;
  end;

  objCotacao.fSelecionaMenoresPrecos;
  pAtualizaTotalSelecionado;
end;

procedure TfrmCadCotacaoGeralCX.btnSelPedClick(Sender: TObject);
begin
  inherited;
  cxvComparativo.Enabled := False;
  Try
    objCotacao.pMarDesMarPed;
    pSelecionaTipoTotal(rdgTotCot.ItemIndex);
  Finally
    cxvComparativo.Enabled := True;
    pSetFocus(cxvComparativo);
  End;
end;

procedure TfrmCadCotacaoGeralCX.btnSelPedTodosClick(Sender: TObject);
begin
  inherited;
  objCotacao.pMarDesMarPedTodos;
  pSelecionaTipoTotal(rdgTotCot.ItemIndex);

end;

procedure TfrmCadCotacaoGeralCX.btnSemelhantesClick(Sender: TObject);
begin
  inherited;
  objCotacao.EmProcessamento := True;

  With objCotacao.cdsItens Do
  If Not IsEmpty Then
   begin
      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(64, 5044, [],
                            ['CODITE'],
                            [FieldByName('CODITE').AsString],
                            nil,
                            nil,
                            True);
      End;
   end;
  objCotacao.EmProcessamento := False;
end;

procedure TfrmCadCotacaoGeralCX.btnSimilaresClick(Sender: TObject);
begin
  inherited;
  objCotacao.EmProcessamento := True;

  pSimilares(True);
  objCotacao.EmProcessamento := False;

end;


procedure TfrmCadCotacaoGeralCX.btnSimilaresComparativoClick(Sender: TObject);
begin
  inherited;
  objCotacao.EmProcessamento := True;

  If Not fVerificaAcessoSistema('CPSIMI', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  Else
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(99, 5687, [],
                          ['CODSIM'],
                          [objCotacao.cdsItens.FieldByName('CODSIM').AsString],
                          Sender,
                          nil,
                          True);
  End;
   objCotacao.EmProcessamento := False;

end;

procedure TfrmCadCotacaoGeralCX.mnuBuscapreco1Click(Sender: TObject);
begin
  inherited;
  If Not FileExists(ExtractFilePath(Application.ExeName) + '\ConsultaPitStop.exe') Then
  Begin
    pMensagemOk('Não foi encontrado o executável ConsultaPitStop.exe, entre em contato com a Citel');
    Exit;
  End;

  If fEmptyStr(objCotacao.FieldByName('COT_NUMCOT').AsString) Then
  Begin
    pMensagemOk('Para fazer esta consulta é preciso salvar a cotação!');
    Exit;
  End;
  objCotacao.pProcessaApiCotacao(idRedePitStop);
end;

procedure TfrmCadCotacaoGeralCX.mnuBuscapreco2Click(Sender: TObject);
begin
  inherited;
  If fEmptyStr(objCotacao.FieldByName('COT_NUMCOT').AsString) Then
  Begin
    pMensagemOk('Para fazer esta consulta é preciso salvar a cotação!');
    Exit;
  End;

  If fPergunta('É aconselhável fazer esse processo depois de todos os preços cotados, deseja prosseguir?') then
    objCotacao.pIniciaSegundaEtapaCotacao;
end;

procedure TfrmCadCotacaoGeralCX.mnuBuscaPrecoClick(Sender: TObject);
begin
  inherited;
  objCotacao.EmProcessamento := true;
  Try
    case mnuIntegracao.Tag of
      idRedeSkyPecas: objCotacao.pProcessaApiCotacao(idRedeSkyPecas);
      idRedeAncora: objCotacao.pProcessaApiCotacao(idRedeAncora);
    End;
  Finally
    objCotacao.EmProcessamento := False;
  End;
end;

procedure TfrmCadCotacaoGeralCX.mnuCarregaPrecoClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(objCotacao.FieldByName('COT_NUMCOT').AsString) Then
  Begin
    pMensagemOk('Para fazer esta consulta é preciso salvar a cotação!');
    Exit;
  End;

  objCotacao.pCarregaPrecosCotacaoPitStop;
end;


procedure TfrmCadCotacaoGeralCX.cmbCodForChange(Sender: TObject);
begin
  inherited;

  With objCotacao.cdsFornecedores Do
  Begin
    IndexFieldNames := 'COT_CODFOR';

    FindKey([LeftStr(cmbCodFor.Text, 8)]);

    pMostraTotais;
  End;
end;

Procedure TfrmCadCotacaoGeralCX.pMostraTotais;
Begin
  If (pagCotacao.ActivePage = tabCotForIte) And Assigned(objCotacao) And Assigned(objCotacao.cdsFornecedores) Then
  With objCotacao.cdsFornecedores Do
  Begin
    If IsEmpty Then
      Exit;

    edtValTot.Text := FormatFloat('#,##0.00', objCotacao.fRetSumValTot(objCotacao.cdsFornecedores.FieldByName('POSICAO').AsInteger));
    edtValUni.Text := FormatFloat('#,##0.00', objCotacao.fRetSumValUni(FieldByName('POSICAO').AsInteger));
    edtValIpi.Text := FormatFloat('#,##0.00', objCotacao.fRetSumIpiEnt(FieldByName('POSICAO').AsInteger));
    edtValSub.Text := FormatFloat('#,##0.00', objCotacao.fRetSumSubsti(FieldByName('POSICAO').AsInteger));
    edtValFre.Text := FormatFloat('#,##0.00', objCotacao.fRetSumFreEnt(objCotacao.cdsFornecedores.FieldByName('POSICAO').AsInteger));
    edtValCbs.Text := FormatFloat('#,##0.00', objCotacao.fRetSumCampo('TOTCBS', FieldByName('POSICAO').AsInteger));
    edtValIbs.Text := FormatFloat('#,##0.00', objCotacao.fRetSumCampo('TOTIBS', FieldByName('POSICAO').AsInteger));
    edtValIs.Text  := FormatFloat('#,##0.00', objCotacao.fRetSumCampo('TOT_IS', FieldByName('POSICAO').AsInteger));

  End;
End;

Function TfrmCadCotacaoGeralCX.fCamposOk: Boolean;
Begin
  With objCotacao Do
  Result := fValidaCampos(dbeDescri, False) And
            fValidaCampos(edtCodCmp, False) And
            fValidaCampos(edtCodDig, False) And
            fItemOk And
            fFornecedorOk;
End;

function TfrmCadCotacaoGeralCX.fEstaNaConsultaTab: Boolean;
begin
  Result := Assigned(frmCadCotacaoGeralCXItem);
end;

procedure TfrmCadCotacaoGeralCX.FormClose(Sender: TObject; var Action: TCloseAction);
var
  strMsg: String;
begin
  inherited;

  If modalResult = mrOk Then
  Begin
    If (objCotacao.tpgGerarPedidos = tpgNaoGera) Then
    Begin
      objCotacao.blnDesmembraCotacao := False;
      If fCfgSis('CTDESC', varBoolean) Then
        If objCotacao.blnMulLoj Then
          objCotacao.blnDesmembraCotacao := fPergunta('Gerar a cotação individualmente por empresa?');

      objCotacao.pTemQuantidadeZerada;

      If (Not objCotacao.blnDesmembraCotacao) And (Not fPergunta('Confirma a gravação da cotação?')) Then
      Begin
        Action := caNone;
        Exit;
      End;

      If (Not fCamposOk) Then
      Begin
        Action := caNone;
        Exit;
      End;

    End;

  End Else
  Begin
    If Not objCotacao.blnSalvouCotacao Then
    Begin
      If objCotacao.blnRecuperaCotacao Then
      Begin
        strMsg := 'A cotação corrente foi recuperada, porém ainda não foi salva.' + #13#10 +
                  'Ao sair as alterações recuperadas serão perdidas. Deseja prosseguir?';
      End
      Else
        strMsg := 'Deseja abandonar a tarefa?';

      If (Not objCotacao.blnEncerra) And (fMensagem('', strMsg, ['&Sim', '&Não']) = 2) Then
      Begin
      Action := caNone;
      Exit;
    End;
  End;

  End;
  pLiberaOrdenacao;
  objCotacao.stlItens.Clear;
  chkNOVIPI.OnClick := nil;
  objCotacao.cdsFornecedores.AfterScroll := Nil;
  blnJaExcutouRecalculaPrecosInical := False;

end;

procedure TfrmCadCotacaoGeralCX.pEscondePreços;
  Var
    intContador: Integer;
Begin
  for intContador := 1 to Length(VS_strTabPrc) do
  Begin
    If VS_strTabPrc[intContador] <> 'S' then
    Begin
      cxbAtuPrecos.Bands[03 + intContador].Visible := False;
    End;
  End;
End;

procedure TfrmCadCotacaoGeralCX.pFechaSelecionaItem;
begin
  If fEstaNaConsultaTab Then
    frmCadCotacaoGeralCXItem.Close;
end;

procedure TfrmCadCotacaoGeralCX.FormCreate(Sender: TObject);
begin
  inherited;
  btnSimilar.Enabled := false;

  blnUtilizaBid := fCfgSis('UTIBID', varBoolean);
  pnlBID.Visible := blnUtilizaBid;

  cdsConsultaItem := Nil;
  objCotacao := Nil;

  blnValidarComTAB := True;

  pagCotacao.ActivePageIndex := 0;

  pEscondePreços;

  frmCadCotacaoGeralCX.cxbItensSALDOSLOJASGIROS.Visible := False;

  cxbItensFornecALQCBS.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
  cxbItensFornecALQIBS.Visible := cxbItensFornecALQCBS.Visible;
  cxbItensFornecALQ_IS.Visible := cxbItensFornecALQCBS.Visible;
  cxbItensFornecALQCBS.VisibleForCustomization := cxbItensFornecALQCBS.Visible;
  cxbItensFornecALQIBS.VisibleForCustomization := cxbItensFornecALQCBS.Visible;
  cxbItensFornecALQ_IS.VisibleForCustomization := cxbItensFornecALQCBS.Visible;
  lblValCbs.Visible := cxbItensFornecALQCBS.Visible;
  lblValIbs.Visible := cxbItensFornecALQCBS.Visible;
  lblValIs.Visible  := cxbItensFornecALQCBS.Visible;
  edtValCbs.Visible := cxbItensFornecALQCBS.Visible;
  edtValIbs.Visible := cxbItensFornecALQCBS.Visible;
  edtValIs.Visible  := cxbItensFornecALQCBS.Visible;

  blnJaExcutouRecalculaPrecosInical := False;

end;

procedure TfrmCadCotacaoGeralCX.FormDestroy(Sender: TObject);
begin
  pLiberaOrdenacao;
  FreeAndNil(lstOrdemResgistros);
  inherited;
  If (Not objCotacao.strSeqGerBKP.IsEmpty) And
  ((objCotacao.blnApagaOnClose) Or (fMensagem('ATENÇÃO!', 'Salvar esta Cotação para ser restaurada mais tarde?', ['&Sim', '&Não']) = 2)) Then
    objCotacao.pApaga_CopiaSeguranca(objCotacao.strSeqGerBKP);

  objCotacao.strSeqGerBKP := '';
  objCotacao.blnRecuperaCotacao := False;
  objCotacao.blnApagaOnClose := False;
  objCotacao.pLiberaCotacoes;

end;

procedure TfrmCadCotacaoGeralCX.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If pagCotacao.ActivePage = tabItens Then
  Begin

    Case Key Of
      VK_F1: if btnComSisAnt.Visible then btnComSisAnt.click;

      VK_F4: btnCompCusto.Click;
      VK_F5: If ssAlt In Shift Then
               btnMarGerPed.Click
             Else
               btnMarDesGerPed.Click;

      VK_F6:  If ssAlt In Shift Then
                btnDesGerPed.Click
              Else
                 btnGiroEst.Click;
      VK_F7:  btnImporta.Click;
      VK_F8:  btnPrepTE.Click;
      VK_F9:  btnSemelhantes.Click;
      VK_F11: btnSimilares.Click;
    End;

  End Else If pagCotacao.ActivePage = tabFornecedores Then
  Begin

    Case Key Of
      VK_F5:  btnIncForGupos.Click;
    End;

  End

  Else If pagCotacao.ActivePage = tabCotForIte Then
  Begin

    Case Key Of

      VK_F2:  btnReplicaDados.Click;
      VK_RETURN: Begin
                   If cmbCodFor.Focused And dbeDtaEnt.CanFocus Then
                   Begin
                     If objCotacao.cdsFornecedores.State <> dsEdit Then
                       objCotacao.cdsFornecedores.Edit;
                   End;

                   If cxbItensFornec.Focused And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecVALUNI) And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecIPIENT) And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecFREENT) And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecALQCBS) And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecALQIBS) And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecALQ_IS) And
                      (cxbItensFornec.Controller.FocusedColumn <> cxbItensFornecSUBSTI) Then
                     cxbItensFornecVALUNI.Focused := True

                   Else If objCotacao.cdsItens.State = dsEdit Then
                        Begin
                          objCotacao.cdsItens.Post;
                          cxbItensFornecKeyDown(Sender, Key, Shift);
                          Key := 0;
                        End;
                 End;
    End;

  End

  Else If pagCotacao.ActivePage = tabComparativo Then
  Begin


    Case Key Of
      VK_F11: If ssAlt In Shift Then
                btnDocSalRes.Click
              Else
                btnSimilares.Click;

      VK_F2: If ssAlt In Shift Then
               btnSelPedTodos.Click
             Else
               btnSelPed.Click;
    End;

  End

  Else If pagCotacao.ActivePage = tabAtualizaPreco Then
  Begin

    Case Key of
      VK_RETURN: If objCotacao.cdsItens.State = dsEdit then
                   objCotacao.cdsItens.Post;

      VK_F3 : Begin
                btnDesPreAtu.Click;
                Key := 0;
              End;
      VK_F5 : btnMarca.Click;
      VK_F6 : btnMarcaTodos.Click;
      VK_F7 : btnDesmarcaTodos.Click;
      VK_F8 : btnAtuPre.Click;
      VK_F9 : btnRecalcPreco.Click;
      VK_F11: btnRecalcMargem.Click;
      VK_F12: btnSimilar.Click;
    end;

  End;

End;


procedure TfrmCadCotacaoGeralCX.FormShow(Sender: TObject);
begin
  inherited;
  lstOrdemResgistros := TList.Create;

  btnForPre.Visible := fCfgSis('PRESPD', varBoolean);
  btnComSisAnt.Visible := fCfgSis('PCGANT') = 'S';

  If  (dbeNumCot.DataSource.DataSet.State = dsEdit) Then
  Begin
    dbeNumCot.Text    := dbeNumCot.Field.AsString;
    dbeDtaCad.Text    := dbeDtaCad.Field.AsString;
    dbeDtaFin.Text    := dbeDtaFin.Field.AsString;
    dbeDescri.Text    := dbeDescri.Field.AsString;
    dbeEmpDes.Text    := dbeEmpDes.Field.AsString;
    dbeMulLoj.Checked := (dbeMulLoj.Field.AsString = 'S');
    chkNovIpi.Checked := (IIf(chkNovIpi.Field.AsString = '', 'N',chkNovIpi.Field.AsString) = 'S');
  End;

  pSetFocus(dbeDescri);

  cxbItens.OptionsView.Footer := True;

  // ITENS POR FORNECEDOR
  btnExpArq.Enabled := objCotacao.State <> dsInsert;
  btnImpArq.Enabled := objCotacao.State <> dsInsert;
  btnMarDes.Enabled := objCotacao.State <> dsInsert;
  btnForPre.Enabled := objCotacao.State <> dsInsert;

  cxbItensGERPED.Visible       := objCotacao.State <> dsInsert;
  cxbItensFornecGERPED.Visible := objCotacao.State <> dsInsert;


  lblEmpDes.Visible := Not dtsCotGer.DataSet.FieldByName('COT_EMPDES').IsNull;
  dbeEmpDes.Visible := Not dtsCotGer.DataSet.FieldByName('COT_EMPDES').IsNull;
  If (Assigned(objCotacao.cdsItens)) And (objCotacao.cdsItens.Filtered) Then
  Begin
    objCotacao.cdsItens.Filtered := False;
    objCotacao.cdsItens.Filter := '';
  End;

  objCotacao.blnMarDesAtual := True;
  btnCarregaPedidosVenda.Visible := fCfgSis('URCPVR', varBoolean) And (Not dbeMulLoj.Checked);

  if Not dbeMulLoj.Checked then
  begin
    lblCodSolicitacaoVinculada.Visible := fCfgSis('URMEIE', varBoolean);
    edtCodSolicitacaoVinculada.Visible := fCfgSis('URMEIE', varBoolean);

    If (dbeNumCot.DataSource.DataSet.State = dsEdit) AND (Not objCotacao.blnRecuperaCotacao) Then
    Begin
      edtCodSolicitacaoVinculada.Text := TManutencaoEquipamentoInterno.fRetornaSolicitacaoVinculada(dbeNumCot.Text, 'CT');
    end;
  end
  else
  begin
    lblCodSolicitacaoVinculada.Visible := False;
    edtCodSolicitacaoVinculada.Visible := False;
  end;
End;

Procedure TfrmCadCotacaoGeralCX.pCarregaComboFonecedores;
Begin
  cmbCodFor.Items.Clear;
  lsvForUti.Clear;

  With objCotacao.cdsFornecedores Do
  Begin
    IndexFieldNames := 'NOMFOR';

    First;

    While Not Eof Do
    Begin
      cmbCodFor.Items.Add(FieldByName('COT_CODFOR').AsString + '-' + FieldByName('NOMFOR').AsString);

      lsvForUti.Items.Add(FieldByName('COT_CODFOR').AsString + '-' + FieldByName('NOMFOR').AsString);

      If FieldByName('COT_UTILIZ').AsString = 'S' Then
        lsvForUti.Checked[RecNo -1] := True;

      Next;
    End;

  End;

  If cmbCodFor.Items.Count > 0 Then
    cmbCodFor.ItemIndex := 0;
End;

procedure TfrmCadCotacaoGeralCX.pDesabilitaCamposItem;
begin
  edtCodIte.Enabled := False;
end;

Procedure TfrmCadCotacaoGeralCX.pAfterScrollFornecedores(dataSet: TDataSet);
Begin
  If DataSet.ControlsDisabled Then
    Exit;

  If Assigned(objCotacao) Then
  With objCotacao, cdsFornecedores Do
  If Not IsEmpty Then
  Begin
    cxbItensFornecVALUNI.DataBinding.FieldName := 'VALUNI' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecIPIENT.DataBinding.FieldName := 'IPIENT' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecFREENT.DataBinding.FieldName := 'FREENT' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecSUBSTI.DataBinding.FieldName := 'SUBSTI' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecALQCBS.DataBinding.FieldName := 'ALQCBS' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecALQIBS.DataBinding.FieldName := 'ALQIBS' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecALQ_IS.DataBinding.FieldName := 'ALQ_IS' +  fIndice(FieldByName('POSICAO').AsInteger);
    cxbItensFornecVALTOT.DataBinding.FieldName := 'VALTOT' +  fIndice(FieldByName('POSICAO').AsInteger);
  End;
End;

procedure TfrmCadCotacaoGeralCX.pagCotacaoChange(Sender: TObject);
begin
  inherited;


  If pagCotacao.ActivePage <> tabAtualizaPreco Then
    objCotacao.tpcTipoCalculoExterno := tpcNenhum;

  pnlDados.Height := 82;

  objCotacao.cdsFornecedores.AfterScroll := Nil;

  objCotacao.pTiraAfterScrollItens;

  Case pagCotacao.ActivePageIndex Of
    0:  Begin
          If Assigned(objCotacao.cdsDigMultLoja) Then
            objCotacao.cdsDigMultLoja.pAncora(True, False, pnlGiro);

          objCotacao.pSetaAfterScrollItensGiro;
         pAlinharPainelSimilar(pnlTail, 615, 12);
        End;

    2: Begin
         pnlHeader.Enabled      := Not objCotacao.cdsFornecedores.IsEmpty;
         cxgItensFornec.Visible := Not objCotacao.cdsFornecedores.IsEmpty;

         cmbCodForChange(Nil);
         objCotacao.cdsFornecedores.AfterScroll := pAfterScrollFornecedores;
         cmbCodForChange(Nil);
         pAlinharPainelSimilar(pnlTotFor, 961, 36);
       End;

    3: Begin
         pAtualizaGridComparativo;
         lblOcultarGiro.Visible := False;

         If Assigned(objCotacao.cdsDigMultLoja) Then
         Begin
           objCotacao.cdsDigMultLoja.pAncora(True, False, pnlGiroComparativo);
           lblOcultarGiro.Visible := True;
           If (lblOcultarGiro.Caption = 'Ocultar Giro') And (pnlContainerGiroComparativo.Height < (pnlContainerAplicacao.Height + 145)) Then
             pnlContainerGiroComparativo.Height := pnlContainerAplicacao.Height + 145;
         End
         Else
           pnlContainerGiroComparativo.Height := pnlContainerAplicacao.Height + 5;

         If Not blnJaExcutouRecalculaPrecosInical Then
         Begin
           objCotacao.pRecalculaPrecosInical;
           blnJaExcutouRecalculaPrecosInical := True;
         End;

         pnlDados.Height := 1;

         objCotacao.pSetaAfterScrollItensGiro;
         pAlinharPainelSimilar(pnlBotoesComparativo, 1001, 56);
       End;
    4: Begin
         objCotacao.pRecalculaPrecosInical;
          pAlinharPainelSimilar(pnlComparativo, 598,85);
       End;
  End;


  If pagCotacao.ActivePageIndex = 0 Then
    If Assigned(objCotacao.cdsDigMultLoja) And (cxbItens.Controller.FocusedRowIndex = -1) Then
      cxbItens.Controller.FocusedRowIndex := 1;

  If pagCotacao.ActivePageIndex = 3 Then
    If Assigned(objCotacao.cdsDigMultLoja) And (cxbComparativo.Controller.FocusedRowIndex = -1) Then
      cxbComparativo.Controller.FocusedRowIndex := 1;

end;

procedure TfrmCadCotacaoGeralCX.pLimpaItem;
Begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Text := '0,00';
  edtCodIte.ReadOnly := False;
  pSetFocus(edtCodIte);
  blnMudarFoco := FALSE;
  pHabilitaDescricao(False);
End;

procedure TfrmCadCotacaoGeralCX.splAplicacaoCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := pnlAplicacao.Height > 1;
end;

procedure TfrmCadCotacaoGeralCX.tabAtualizaPrecoHide(Sender: TObject);
begin
  inherited;
  chkNOVIPI.OnClick := nil;;

end;

procedure TfrmCadCotacaoGeralCX.tabAtualizaPrecoShow(Sender: TObject);
begin
  inherited;
  chkNOVIPI.OnClick := chkNovIpiClick;
end;

Procedure TfrmCadCotacaoGeralCX.pMudaPaginaCotacao(intIndex: Integer);
Begin
  If pagCotacao.ActivePageIndex <> intIndex Then
  Begin
    pagCotacao.ActivePageIndex := intIndex;
    pagCotacaoChange(Nil);
  End;
End;

procedure TfrmCadCotacaoGeralCX.pnlBotoesComparativoCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  inherited;
   If NewHeight <  114 Then
      NewHeight := pnlBotoesComparativo.Height
end;

procedure TfrmCadCotacaoGeralCX.pOnClickExcluir(Sender: TObject);
begin
  pRetiraDaListaConsulta(objCotacao.cdsItens.FieldByName('CODITE').AsString);

  If fEstaNaConsultaTab Then
  Begin
    objCotacao.pExcluiItem(True);
    pFechaSelecionaItem;
  End
  Else
    objCotacao.pExcluiItem;

  pSetFocus(cxgItens);
end;

procedure TfrmCadCotacaoGeralCX.pOnClickExcluirSelecionados(Sender: TObject);
begin
  With objCotacao.cdsItens do
  Begin
    if (fMensagem('', 'Confirma a exclusão dos itens marcados para a exclusâo?', ['&Sim', '&Não']) = 1) Then
    Begin
      DisableControls;
      Filtered := False;
      Filter := 'EXCLUI = ' + QuotedStr('S');
      Filtered := True;
      First;
      While not objCotacao.cdsItens.isEmpty do
      begin

        pRetiraDaListaConsulta(FieldByName('CODITE').AsString);

        objCotacao.pExcluiItem(True);

      End;
      Filter := '';
      Filtered := False;

      EnableControls;
    End;
  End;
end;

procedure TfrmCadCotacaoGeralCX.pPreparaMnuIntegracaPitStop(
  AStatusPitStopCotacao: TStatusPitStopCotacao);
begin
  mnuBuscapreco1.Enabled:= False;
  mnuBuscapreco2.Enabled:= False;
  mnuCarregaPreco.Enabled:= False;
  mnuRefazCotacao.Enabled:= False;


  case AStatusPitStopCotacao of
    spscComApi: mnuBuscapreco1.Enabled:= True;
    spscPendenteRecotarPreco: mnuBuscapreco2.Enabled:= True;
    spscPendenteImportarConsultaPreco,
    spscPendenteImportarRecotarPreco: mnuCarregaPreco.Enabled:= True;
  end;

  If (NOt (AStatusPitStopCotacao in [spscSemApi, spscComApi, spscPendenteConsultaPreco])) Then
    mnuRefazCotacao.Enabled := True;
end;

procedure TfrmCadCotacaoGeralCX.pRetiraDaListaConsulta(strCodIte: String);

  Var
    intIndice: Integer;
Begin
  (*********************************************************}
  {* SE ESTÁ REPETIDO MANTEM AINDA A MARCAÇÃO POIS CASO    *}
  {* ELE DER "TAB" NOVAMENTE, ELE CARREGARÁ O PRÓXIMO ITEM *}
  {* DE MESMO CÓDIGO                                       *}
  {******************************************************VA*)
  If fItemEstaRepetido(strCodIte) Then
    Exit;

  If objCotacao.stlItens.Find(QuotedStr(strCodIte), intIndice) Then
    objCotacao.stlItens.Delete(intIndice);

  If Assigned(cdsConsultaItem) And (Not cdsConsultaItem.IsEmpty) And
     (cdsConsultaItem.FieldByName('ITE_CODITE').AsString = strCodIte) Then
  Begin
    cdsConsultaItem.Edit;
    cdsConsultaItem.FieldByName('VENDIDO').Clear;
    cdsConsultaItem.Post;
  End;
end;

function TfrmCadCotacaoGeralCX.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    fltDiaEst,
    fltDiaSug,
    fltSalFis,
    fltMedVen: Double;
    strCodComp: String;
    intRecNo: integer;

begin
  blnMudarFoco := TRUE;

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDescri) Then
    Begin

      If fEmptyStr(Trim(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&O k']);
        Result := FALSE;
      End;

      If dbeDescri.Text <> dbeDescri.Field.OldValue  Then
        objCotacao.fIncluir_CopiaSeguranca_AtualizaCapa;

    End

    Else If (Sender = edtCodCmp) Then
    Begin

      If fEmptyStr(edtCodCmp.Text) Then
        Result := False
      Else
      Begin
        edtNomCmp.Text := '';
        strCodComp := objCotacao.fRetCodComprador(edtCodCmp.Text);
        If strCodComp <> '' Then
          edtNomCmp.Text := fRetNomVendRep(strCodComp);
        Result := Not fEmptyStr(edtNomCmp.Text);
      End;

      If Not Result Then
      Begin
        If edtCodCmp.PasswordChar = '*' Then
          pMensagemOk('Senha do comprador inválida!')
        Else
          pMensagemOk('Código do comprador inválido!')
      End Else
      Begin
        If objCotacao.State In dsEditModes Then
          objCotacao.FieldByName('COT_CODCMP').AsString := objCotacao.fRetCodComprador(edtCodCmp.Text);

//        If blnBuscaPorChave Then
//        Begin
//          pMudaPaginaCotacao(0);
//          pSetFocus(edtCodIte);
//          blnMudarFoco := FALSE;
//        End;
      End;

      If objCotacao.FieldByName('COT_CODCMP').AsString <> objCotacao.FieldByName('COT_CODCMP').OldValue Then
        objCotacao.fIncluir_CopiaSeguranca_AtualizaCapa;
    End

    Else If (Sender = edtCodDig) And (pnlDigitador.Visible) Then
    Begin
      edtNomDig.Text := '';
      strCodComp :=  objCotacao.fRetCodDigitador(edtCodDig.Text);
      If strCodComp <> '' Then
        edtNomDig.Text := fRetNomVendRep(strCodComp);
      Result := Not fEmptyStr(edtNomDig.Text);

      If Not Result Then
      Begin
        pMensagemOk('Senha do digitador inválida!')
      End Else
      Begin
        If objCotacao.State In dsEditModes Then
          objCotacao.FieldByName('COT_CODDIG').AsString := objCotacao.fRetCodDigitador(edtCodDig.Text);
      End;

      If objCotacao.FieldByName('COT_CODDIG').AsString <> objCotacao.FieldByName('COT_CODDIG').OldValue Then
        objCotacao.fIncluir_CopiaSeguranca_AtualizaCapa;
    End

    Else If (Sender = edtCodIte) Then
    Begin
      Result := fValidaCodigoProduto(True);
    End

    Else If (Sender = edtDesIte) Then
    Begin

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        pMudaPaginaCotacao(0);
        fMensagem('ATENÇÃO!', 'Informe a descrição do produto!', ['&O k']);
        Result := False;
      End

      Else If blnBuscaPorChave Then
      Begin
        blnMudarFoco := FALSE;
        pSetFocus(edtQtdIte);
      End;

    End

    Else If (Sender = edtQtdIte) And objCotacao.blnValidaQuantidade Then
    Begin

      If objCotacao.blnMulLoj And blnBuscaPorChave Then
      Begin
        Result := fValidaCampos(edtCodIte, True) And objCotacao.fDigQuantidadeMultilojaCotacao;
      End;

      If Result  Then
      Begin
        If fEmptyStr(edtQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&O k']);
          pMudaPaginaCotacao(0);
          Result := False;
        End
        Else If (fStrToFloat(edtQtdIte.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior ou igual a zero!', ['&O k']);
          pMudaPaginaCotacao(0);
          Result := False;
        End Else
        Begin
          If blnBuscaPorChave Then
          Begin
            fltDiaEst := 0;
            fltDiaSug := 0;
            fltMedVen := 0;

            If objCotacao.blnMulLoj Then
            Begin

              If Assigned(objCotacao.cdsItensGiro) And objCotacao.cdsItensGiro.Active And
                 (objCotacao.cdsItensGiro.FieldByName('ITE_CODITE').AsString = edtCodIte.Text)Then
              Begin
                fltDiaEst := objCotacao.cdsItensGiro.FieldByName('ITE_DIAEST').AsFloat;
                fltDiaSug := objCotacao.cdsItensGiro.FieldByName('ITE_DIASUG').AsFloat;
                fltMedVen := objCotacao.cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat;
              End;

            End;

            objCotacao.pSetaEventosItem(False, True, True, False);

            If (Not objCotacao.blnMulLoj) And (Not fValidaCodigoProduto(False)) Then
              Exit;

            fltSalFis := 0;
            If Assigned(objCotacao.cdsItensGiro.FindField('ITE_SALFIS')) Then
              fltSalFis := objCotacao.cdsItensGiro.FieldByName('ITE_SALFIS').AsFloat;
            If objCotacao.fIncluiItem(edtCodIte.Text, edtDesIte.Text, fStrToFloat(edtQtdIte.Text), fltDiaEst, fltDiaSug, fltMedVen, False, False, fltSalFis) Then
            Begin

              //INCLUIR COPIA DE SEGURANÇA
              objCotacao.fIncluir_CopiaSeguranca;

              pIncluiNaListaConsulta;

              If fCfgSis('FORCOT') = 'S' Then
              Begin
                pIncluiFornecedoresVinculados(edtCodIte.Text);
              End;

              pLimpaItem;

              If fEstaNaConsultaTab Then
                pFechaSelecionaItem;

              If objCotacao.blnEditando Then
                pSetFocus(cxgItens);
            End;

            objCotacao.pSetaEventosItem(True, True, True, False);

          End;
        End;
      End

      Else pLimpaItem;
    End

    Else If Sender = edtCodFor Then
    Begin

      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
          edtCodFor.Clear;
          pMudaPaginaCotacao(1);
          Result := FALSE;
        End

        Else If blnBuscaPorChave Then
        Begin
          pIncluiFornecedor(False);
          blnMudarFoco := FALSE;
        End;

      End Else
      Begin
        pMudaPaginaCotacao(1);
        fMensagem('AVISO','Código do fornecedor em branco.', ['&O K']);
        Result := FALSE;
      End;

    End

    Else If (Sender = dbeDtaEnt) Then
    Begin

      If Not fEmptyDate(dbeDtaEnt.Text) Then
        dbeDtaEnt.Text := FormatDateTime('dd/mm/yyyy',StrToDate(dbeDtaEnt.Text));

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaEnt.Text)) Then
      Begin
        pMudaPaginaCotacao(2);
        fMensagem('ATENÇÃO!', 'Informe a data de entrega!', ['&O k']);
        Result := False;
      End
      Else If objCotacao.cdsFornecedores.State = dsEdit Then
      Begin
        intRecNo := objCotacao.cdsFornecedores.Recno;
        objCotacao.cdsFornecedores.Post;

        //INCLUIR COPIA DE SEGURANÇA
        If FEmptyStr(objCotacao.strSeqGerBKP) Then
          objCotacao.fIncluir_CopiaSeguranca
        Else
          objCotacao.fIncluiFornecedores_CopiaSeguranca(False,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_CODFOR').AsString,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_UTILIZ').AsString,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_CONPAG').AsString,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_DTAENT').AsDateTime);
        objCotacao.cdsFornecedores.Recno := intRecNo;

      End;
    End

    Else If (Sender = dbeConPag) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(dbeConPag.Text)) Then
      Begin
        pMudaPaginaCotacao(2);
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCndPag(dbeConPag.Text) Then
      Begin
        pMudaPaginaCotacao(2);
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é válida!', ['&O k']);
        Result := False;
      End
      Else If objCotacao.cdsFornecedores.State = dsEdit Then
      Begin

        intRecNo := objCotacao.cdsFornecedores.RecNo;
        objCotacao.cdsFornecedores.Post;

        //INCLUIR COPIA DE SEGURANÇA
        If FEmptyStr(objCotacao.strSeqGerBKP) Then
          objCotacao.fIncluir_CopiaSeguranca
        Else
          objCotacao.fIncluiFornecedores_CopiaSeguranca(False,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_CODFOR').AsString,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_UTILIZ').AsString,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_CONPAG').AsString,
                                                        objCotacao.cdsFornecedores.FieldByName('COT_DTAENT').AsDateTime);
        objCotacao.cdsFornecedores.RecNo := intRecNo;
        cxbItensFornecVALUNI.Focused := True;
      End;
    End

    Else If (Sender = edtCodTct) Then
    Begin
      If Not fEmptyStr(edtCodTct.Text) Then
      Begin
        edtDesTct.Text := fCampoTabela('TCT_DESTCT', 'CADTCT', ['TCT_CODTCT'], [edtCodTct.Text]);
        If fEmptyStr(edtDesTct.Text) Then
        Begin
          fMensagem('','Tipo de Cotação não cadastrado!',['&Ok']);
          edtDesTct.Clear;
          Result := False;
        End;
      End
      Else
      Begin
        edtDesTct.Clear;
      End;

      If Result Then
      Begin
        If (objCotacao.State In dsEditModes) Then
        Begin
          If Not fEmptyStr(edtDesTct.Text) Then
            objCotacao.FieldByName('COT_CODTCT').AsString := edtCodTct.Text
          Else
            objCotacao.FieldByName('COT_CODTCT').Value := Null
        End;

        If (blnBuscaPorChave) Then
        Begin
//          pMudaPaginaCotacao(0);
            pSetFocus(edtCodIte);
          blnMudarFoco := FALSE;
        End;
      End;

      If objCotacao.FieldByName('COT_CODTCT').AsString <> objCotacao.FieldByName('COT_CODTCT').OldValue Then
        objCotacao.fIncluir_CopiaSeguranca_AtualizaCapa;
    End
    Else If Sender = edtCodSolicitacaoVinculada Then
    Begin
      If (objCotacao.State In dsEditModes) Then
      Begin
        If Not fEmptyStr(edtCodSolicitacaoVinculada.Text) Then
            objCotacao.FieldByName('COT_CODSOL').AsString := edtCodSolicitacaoVinculada.Text
        Else
            objCotacao.FieldByName('COT_CODSOL').Value := Null
      End;

      If objCotacao.FieldByName('COT_CODSOL').AsString <> objCotacao.FieldByName('COT_CODSOL').OldValue Then
        objCotacao.fIncluir_CopiaSeguranca_AtualizaCapa;
    End

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End;

end;

function TfrmCadCotacaoGeralCX.fValidaCodigoProduto(blnLoad: Boolean): Boolean;
begin
  If fEmptyStr(edtCodIte.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o código ou a descrição do produto!', ['&O k']);
    Result := False;
    pMudaPaginaCotacao(0);
  End Else
  Begin
    Result := True;

    If (fIsNumber(edtCodIte.Text)) Then
    Begin
      if Length(edtCodIte.Text) < fTamCodIte then
        edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);

      If blnLoad Then
      Begin

        If objCotacao.fCarregaItem(edtCodIte.Text) Then
        Begin
          edtDesIte.Text := objCotacao.dtsCadIteEdicao.FieldByName('DESITE').AsString;

          If objCotacao.cdsItens.FieldByName('CODITE').AsString = edtCodIte.Text Then
          Begin
            edtQtdIte.Text := FormatFloat('#0.00', objCotacao.cdsItens.FieldByName('QTDITE').AsFloat);
            edtDesIte.Text := objCotacao.cdsItens.FieldByName('DESITE').AsString;
          End;

          blnMudarFoco := FALSE;

          pHabilitaDescricao(Pos('ITEM ESPECIAL', objCotacao.dtsCadIteEdicao.FieldByName('DESCRI').AsString) > 0);

          If edtDesIte.ReadOnly Then
            pSetFocus(edtQtdIte)
          Else
            pSetFocus(edtDesIte);
        End

        Else Result := False;

      End
      Else
      Begin
        If fEmptyStr(fRetNomProduto(edtCodIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do produto inválido!', ['&O k']);
          Result := False;
          pMudaPaginaCotacao(0);
        End;
      End;
    End;
  End;
end;

Function TfrmCadCotacaoGeralCX.fTestaLimiteFornecedor: Boolean;
Begin
  Result := False;

  If objCotacao.cdsItens.IsEmpty Then
  Begin
    fMensagem('AVISO','Para inclusão de Fornecedores é necessário incluir pelo menos 1 item!', ['&O K']);
    Exit;
  End;

  If objCotacao.cdsFornecedores.RecordCount >= INT_MAX_FORNECEDOR Then
  Begin
    pMensagemOk('O número fornecedores na cotação chegou ao limite (' + IntToStr(INT_MAX_FORNECEDOR) + ') !');
    Exit;
  End;

  Result := True;
End;

procedure TfrmCadCotacaoGeralCX.pIncluiFornecedor(blnValidar: Boolean);
Begin
  Try
    If Not fliberaTravaValidadeCertGestao(edtCodFor.Text) Then
      Exit;

    If Not fTestaLimiteFornecedor Then
      Exit;

    If (Not blnValidar) Or fValidaCampos(edtCodFor, False) Then
    begin
      objCotacao.fIncluiFornecedor(edtCodFor.Text, edtNomFor.text);
      objCotacao.MarcaTodosComoAlterado;

    End;

    pLimpaFornecedor;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pIncluiFornecedor]');
    End;
  End;

End;

procedure TfrmCadCotacaoGeralCX.pIncluiFornecedoresVinculados(strCodIte: String);
var
  qryGenerico: TUniQuery;
begin
  qryGenerico:= fCriaQuery();
  Try
    qryGenerico.Close;
    qryGenerico.SQL.Clear;
    qryGenerico.SQL.Add('SELECT ITEFOR.ITE_CODFOR FROM ITEFOR ');
    qryGenerico.SQL.Add(' WHERE ITEFOR.ITE_CODITE = :CODITE');
    qryGenerico.SQL.Add(' UNION ALL ');
    qryGenerico.SQL.Add('SELECT CADITE.ITE_CODFOR FROM CADITE ');
    qryGenerico.SQL.Add(' WHERE CADITE.ITE_CODITE = :CODITE');

    qryGenerico.ParamByName('CODITE').AsString:= strCodIte;

    qryGenerico.Open;

    qryGenerico.First;
    While Not(qryGenerico.Eof) Do
    Begin
      objCotacao.fIncluiFornecedor(qryGenerico.FieldByName('ITE_CODFOR').AsString, fRetNomFornecedor(qryGenerico.FieldByName('ITE_CODFOR').AsString));
      qryGenerico.Next;
    End;
    objCotacao.MarcaTodosComoAlterado;

  Finally
    FreeAndNil(qryGenerico);
  End;

end;

procedure TfrmCadCotacaoGeralCX.pIncluiNaListaConsulta;
  Var
    intRecNo: Integer;
    intIndice: Integer;
    strCodIte: String;
Begin
  If (Not Assigned(objCotacao.cdsItens)) Or objCotacao.cdsItens.IsEmpty Then
    Exit;

  strCodIte := objCotacao.cdsItens.FieldByName('CODITE').AsString;
  If Not objCotacao.stlItens.Find(QuotedStr(strCodIte), intIndice) Then
    objCotacao.stlItens.Add(QuotedStr(strCodIte));

  If Assigned(cdsConsultaItem) And (Not cdsConsultaItem.IsEmpty) Then
  Begin
    With cdsConsultaItem Do
    Begin
      intRecNo := RecNo;
      If Locate('ITE_CODITE', strCodIte, []) Then
      Begin
        Edit;
        FieldByName('VENDIDO').AsInteger := 1;
        Post;
      End;
      RecNo := intRecNo;
    End;
  End
end;

procedure TfrmCadCotacaoGeralCX.lblExiApliClick(Sender: TObject);
begin
  inherited;

  If pnlAplicacao.Visible Then
  Begin
    splAplicacao.Visible := False;
    pnlAplicacao.Visible := False;
    lblExiApli.Caption  := 'Exibir Aplicação do Produto';
  End
  Else
  Begin
    pnlAplicacao.Visible := True;
    splAplicacao.Visible := True;
    splAplicacao.Top     := pnlAplicacao.Top;
    lblExiApli.Caption   := 'Ocultar Aplicação do Produto';
  End;

  splGiro.Top := pnlGiro.Top;

end;

procedure TfrmCadCotacaoGeralCX.lblOcultarGiroClick(Sender: TObject);
begin
  { Deixa spliter do topo da aplicação e pnl da aplicação invisiveis
    para após o processo de ocultação/exibição do Giro torná-los visíveis novamente
    e manter o alinamento correto seguindo a ordem ( 1º spliter 2º pnlAplicacao e 3º pnlGiro 4º spliter)
    todos alinhados a alBottom}
  pnlContainerAplicacao.Visible := False;
  splAplicacaoTopo.Visible := False;
  splAplicacaoRodape.Visible := False;

  If lblOcultarGiro.Caption = 'Ocultar Giro' Then
  Begin
    pnlGiroComparativo.Visible := False;
    lblOcultarGiro.Caption := 'Exibir Giro';
    pnlContainerGiroComparativo.Height := pnlContainerAplicacao.Height + 5;
  End
  Else
  Begin
    pnlGiroComparativo.Visible := True;
    lblOcultarGiro.Caption := 'Ocultar Giro';
    pnlContainerGiroComparativo.Height := pnlContainerAplicacao.Height + 145;


  End;
  splAplicacaoTopo.Visible := True;
  pnlContainerAplicacao.Visible := True;
  splAplicacaoRodape.Visible := True;
  splAplicacaoRodape.Top := pnlGiroComparativo.Top;
end;

procedure TfrmCadCotacaoGeralCX.mnuPitStopParadoClick(Sender: TObject);
begin
  inherited;
  StartProcess(ExtractFilePath(Application.ExeName) + '\ConsultaPitStop',
               VS_StrCodEmp + ' ' +
               IdCotacaoPitStop + ' False');

end;

procedure TfrmCadCotacaoGeralCX.mnuRefazCotacaoClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Voltar o status para pendente de integração?') Then
    objCotacao.pReiniciarCotacaoPitStop;
end;

procedure TfrmCadCotacaoGeralCX.mnuReiniciaCotaClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Voltar o status para pendente de integração?') Then
  Begin
    case mnuIntegracao.Tag of
      idRedeSkyPecas: objCotacao.pReiniciaIntegracao(idRedeSkyPecas);
      idRedeAncora: objCotacao.pReiniciaIntegracao(idRedeAncora);
    End;
  End;

end;

procedure TfrmCadCotacaoGeralCX.cxEditRepository1ButtonItem1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
 ARect: TRect;
 APoint: TPoint;
begin
  inherited;
  If cxvFornecedores.DataController.DataSet.FieldByName('COT_PITSTO').AsInteger > 0 Then
  begin
    ARect := TcxButtonEdit(Sender).ViewInfo.ButtonsInfo[AButtonIndex].Bounds;
    APoint.X := TcxButtonEdit(Sender).BoundsRect.Left;
    APoint.Y := TcxButtonEdit(Sender).BoundsRect.Bottom;
    APoint := cxvFornecedores.Site.ClientToScreen(APoint);
    pPreparaMnuIntegracaPitStop(TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cxvFornecedores.DataController.DataSet.FieldByName('COT_PITSTO').AsInteger));
    mnuIntegracaPitStop.Popup(APoint.X, APoint.Y);
  End;
  mnuBuscaPreco.Enabled := False;
  mnuReiniciaCota.Enabled := False;
  mnuIntegracao.Tag := 0;
  If cxvFornecedores.DataController.DataSet.FieldByName('COT_ANCORA').AsInteger > 0 Then
  begin
    If cxvFornecedores.DataController.DataSet.FieldByName('COT_ANCORA').AsInteger = 8 Then
      mnuReiniciaCota.Enabled := True
    Else
      mnuBuscaPreco.Enabled := True;
    ARect := TcxButtonEdit(Sender).ViewInfo.ButtonsInfo[AButtonIndex].Bounds;
    APoint.X := TcxButtonEdit(Sender).BoundsRect.Left;
    APoint.Y := TcxButtonEdit(Sender).BoundsRect.Bottom;
    APoint := cxvFornecedores.Site.ClientToScreen(APoint);
    mnuIntegracao.Tag := idRedeAncora;
    mnuIntegracao.Popup(APoint.X, APoint.Y);
  End;
  If cxvFornecedores.DataController.DataSet.FieldByName('COT_SKYPEC').AsInteger > 0 Then
  begin
    If cxvFornecedores.DataController.DataSet.FieldByName('COT_SKYPEC').AsInteger = 8 Then
      mnuReiniciaCota.Enabled := True
    Else
      mnuBuscaPreco.Enabled := True;
    ARect := TcxButtonEdit(Sender).ViewInfo.ButtonsInfo[AButtonIndex].Bounds;
    APoint.X := TcxButtonEdit(Sender).BoundsRect.Left;
    APoint.Y := TcxButtonEdit(Sender).BoundsRect.Bottom;
    APoint := cxvFornecedores.Site.ClientToScreen(APoint);
    mnuIntegracao.Tag := idRedeSkyPecas;
    mnuIntegracao.Popup(APoint.X, APoint.Y);
  End;

end;

procedure TfrmCadCotacaoGeralCX.cxvFornecedoresACTAPIGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  if (ARecord <> nil) and ((VarToStr(ARecord.Values[cxvFornecedoresCOT_ANCORA.Index]) <> '0') or
                           (VarToStr(ARecord.Values[cxvFornecedoresCOT_PITSTO.Index]) <> '0') or
                           (VarToStr(ARecord.Values[cxvFornecedoresCOT_SKYPEC.Index]) <> '0')) then
    AProperties := cxEditRepository1ButtonItem1.Properties;

end;

procedure TfrmCadCotacaoGeralCX.cxvFornecedoresCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  ARect: TRect;
  APoint: TPoint;
begin
  IdCotacaoPitStop := '';
  If cxvFornecedoresCOT_IMGAPI.Focused Then
    If cxvFornecedores.DataController.DataSet.FieldByName('COT_PITSTO').AsInteger > 2 Then
      If AButton = mbRight Then
      begin
        ARect :=  ACellViewInfo.Bounds;
        APoint.X := ACellViewInfo.Bounds.Left;
        APoint.Y := ACellViewInfo.Bounds.Bottom;
        APoint := cxvFornecedores.Site.ClientToScreen(APoint);
        mnuPitStopParado.Visible := False;
        if TStatusCotacaoPitStop.IntToStatusPitStopCotacao(
            cxvFornecedores.DataController.DataSet.FieldByName('COT_PITSTO').AsInteger) in
            [spscIntegrandoConsultaPreco, spscIntegrandoRecotarPreco] Then
          mnuPitStopParado.Visible := Not TfrmLogPitStop.fServicoConectado(dbeNumCot.Text, objCotacao.cdsFornecedores.FieldByName('COT_CODFOR').AsString, IdCotacaoPitStop);
        ppmComunicaPitStop.Popup(APoint.X, APoint.Y);

      End;
end;


procedure TfrmCadCotacaoGeralCX.cxvFornecedoresCOT_STAAPIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  lStaApi: integer;
  lDataIni: TDateTime;
begin
  inherited;
  AText := 'Sem API';
  lDataIni := StrToDateTimeDef(VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvFornecedoresINIINT.Index]), fNow);
  lStaApi := StrToIntDef(VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvFornecedoresCOT_PITSTO.Index]), 0);
  If lStaApi > 0 Then
    AText := TStatusCotacaoPitStop.DescricaoStatusPitStopCotacao(TStatusCotacaoPitStop.IntToStatusPitStopCotacao(lStaApi), lDataIni);
  If AText = 'Sem API' Then
  begin
    lStaApi := StrToIntDef(VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvFornecedoresCOT_ANCORA.Index]), 0);
    If lStaApi = 0 Then
      lStaApi := StrToIntDef(VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvFornecedoresCOT_SKYPEC.Index]), 0);
    If lStaApi > 0 Then
    Begin
      case lStaApi of
       1: AText := 'Integração não foi iniciada';
       8: AText := 'Importação da cotação concluída';
      End;
    End;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxvFornecedoresEMAENVGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = '' Then
    AText := 'Não'


end;

procedure TfrmCadCotacaoGeralCX.cxvFornecedoresFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If Assigned(AFocusedRecord) Then
  Begin
    IF (VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxvFornecedoresCOT_ANCORA.Index]) <> '0') or
       (VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxvFornecedoresCOT_PITSTO.Index]) <> '0') or
       (VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxvFornecedoresCOT_SKYPEC.Index]) <> '0') Then
       cxvFornecedoresACTAPI.Options.Editing := True
     Else
       cxvFornecedoresACTAPI.Options.Editing := False;
  End;

end;



procedure TfrmCadCotacaoGeralCX.mnuComPitStopClick(Sender: TObject);
begin
  inherited;
  TfrmLogPitStop.pShowLogPitStop(dbeNumCot.Text, objCotacao.cdsFornecedores.FieldByName('COT_CODFOR').AsString);
end;

procedure TfrmCadCotacaoGeralCX.lsvForUtiClickCheck(Sender: TObject);
begin
  inherited;

  objCotacao.pUtilizaFornecedor(LeftStr(lsvForUti.Items[lsvForUti.ItemIndex], 8),
                                lsvForUti.Checked[lsvForUti.ItemIndex]);

  objCotacao.fAtualizaMenorFornecedor;

  pAtualizaGridComparativo;
end;

procedure TfrmCadCotacaoGeralCX.pAtualizaGridComparativo;
  Var
//    intLargura,
    intContador: Integer;
    cxcColuna: TcxGridDBBandedColumn;
Begin
  //intLargura := 903;
  cxbComparativo.BeginUpdate;
  Try
    For intContador := 1 To INT_MAX_FORNECEDOR Do
    Begin
      cxcColuna := fGetColunaValorTotal(intContador);
      cxcColuna.Tag := intContador;

      If Assigned(cxcColuna) Then
        cxcColuna.Visible := False;
    End;

    With objCotacao.cdsFornecedores Do
    Begin
      First;

      While Not Eof Do
      Begin
        If FieldByName('COT_UTILIZ').AsString = 'S' Then
        Begin
          cxcColuna := fGetColunaValorTotal(FieldByName('POSICAO').AsInteger);

          If Assigned(cxcColuna) Then
          Begin
            cxcColuna.Caption := FieldByName('NOMFOR').AsString;
            cxcColuna.Visible := True;
  //          intLargura := intLargura + cxcColuna.Width;
          End;
        End;

        Next;
      End;

    End;

  //  cxbComparativo.Bands[1].Width := intLargura;

    pAtualizaTotalSelecionado;
  Finally
    cxbComparativo.EndUpdate;
  End;
End;

procedure TfrmCadCotacaoGeralCX.pAtualizaTotalSelecionado;
Begin
  edtTotGer.Text := FormatFloat('#,##0.00', fRetTotalSelecionado);
End;

procedure TfrmCadCotacaoGeralCX.pBloqueiaProcessos;
begin
  If Not blnUtilizaBid Then
   Exit;
  edtCodIte.Enabled := False;
  rdbLiberado.Enabled := False;
  rdbNaoLiberado.Enabled := False;
  cxbItensQTDITE.Options.Editing := false;
  objCotacao.DesabilitaEdicaoQtdMltLoja;
  btnExcluir.Enabled := False;
  btnIncluir.Enabled := False;
  btnImporta.Enabled := False;
  edtCodFor.Enabled := False;
  btnIncluiFornecedor.Enabled := False;
  btnExcluiFornecedor.Enabled := False;
  btnIncForGupos.Enabled := False;
  btnGiroEst.Visible := False;

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosATUPREPropertiesChange(
  Sender: TObject);
begin
  inherited;

  With objCotacao.cdsItens Do
  If State = dsEdit then
    Post;

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
Var
  strCodigo: String;
begin
  inherited;
  strCodigo := VarToStrDef(ARecord.Values[cxbAtuPrecosCODITE.Index],'');
  strCodigo := fCampoTabela('ITE_CODSIM', 'CADITE', ['ITE_CODITE'], [strCodigo], False);
  btnSimilar.Enabled := Not fEmptyStr(strCodigo);
end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosCODITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbAtuPrecosITESIM.Index])) = 'S' Then
  Begin
    ACanvas.Font.Color := COR_SIMILAR;

    ACanvas.Brush.Color := clWhite;
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clYellow;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;



  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbAtuPrecosATUPRE.Index])) = 'S' Then
  Begin
    ACanvas.Font.Color := clGreen;

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clYellow
    Else
      ACanvas.Brush.Color := clWhite;
  End

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
Var
  intIndCod, intIndOrd: Integer;
  varOrdIte1, varOrdIte2: Variant;
begin
  inherited;
  intIndCod := cxbAtuPrecosCODITE.Index;
  intIndOrd := cxbAtuPrecosORDITE.Index;
  If AItemIndex =  intIndCod Then
  Begin
    varOrdIte1 := ADataController.Values[ARecordIndex1, intIndOrd];
    varOrdIte2 := ADataController.Values[ARecordIndex2, intIndOrd];
    Compare := VarCompare(varOrdIte1, varOrdIte2);
  End
  Else
    Compare := VarCompare(V1,V2);
end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosDataControllerFilterRecord(
  ADataController: TcxCustomDataController; ARecordIndex: Integer;
  var Accept: Boolean);
begin
  inherited;
  Accept := True;
  If objCotacao.FieldByName('COT_DTAFIN').AsDateTime = 0 Then
    Accept := VarToStr(ADataController.GetValue(ARecordIndex, cxbAtuPrecosGERPED.Index)) = 'N'

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If objCotacao.cdsItens.State <> dsEdit Then
                 btnSair.Click;
  End;

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosNOVBR1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If SameText(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxbAtuPrecosTIPALT.Index]), STR_TIPALT_MARGEM) Then
  Begin
    ACanvas.Font.Color := clWhite;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Brush.Color := clRed;
  End

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosNOVBR1PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  objCotacao.tpcTipoCalculoExterno := tpcPrecoVenda;
end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosNOVVE1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If SameText(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxbAtuPrecosTIPALT.Index]), STR_TIPALT_PRECO) Then
  Begin
    ACanvas.Font.Color := clWhite;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Brush.Color := clBlue;
  End

end;

procedure TfrmCadCotacaoGeralCX.cxbAtuPrecosNOVVE1PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  objCotacao.tpcTipoCalculoExterno := tpcMargem;
end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoCODITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbComparativoITESIM.Index])) = 'S' Then
  Begin
    ACanvas.Font.Color := COR_SIMILAR;

    ACanvas.Brush.Color := clWhite;
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clYellow;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoCODITEHeaderClick(
  Sender: TObject);
begin
  chkSuspendeOrdenacao.Checked := False;
  TThread.CreateAnonymousThread(
  procedure
  begin
      TThread.Sleep(500);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        chkSuspendeOrdenacao.Checked := True;
      end);
  end).Start;
end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
var
   intPosition1, intPosition2: Integer;
begin

  If chkSuspendeOrdenacao.Checked  then
  Begin

    intPosition1 := fGetPositionByRecordIndex(ARecordIndex1);
    intPosition2 := fGetPositionByRecordIndex(ARecordIndex2);

    If cxbComparativo.SortedItems[0].SortOrder = soAscending Then
      Compare := VarCompare(intPosition1, intPosition2)
    Else
      Compare := VarCompare(intPosition2, intPosition1);

  End Else
  Begin

    Compare := VarCompare(V1, V2);

  End;

end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoDataControllerFilterRecord(
  ADataController: TcxCustomDataController; ARecordIndex: Integer;
  var Accept: Boolean);
begin
  inherited;
  Accept := True;
  If objCotacao.FieldByName('COT_DTAFIN').AsDateTime = 0 Then
    Accept := VarToStr(ADataController.GetValue(ARecordIndex, cxbComparativoGERPED.Index)) = 'N'
end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN : btnAlteraValor.Click;
    VK_ESCAPE: If objCotacao.cdsItens.State <> dsEdit Then
                 btnSair.Click;
  End;

end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Case Key Of
    ' ' : btnMarPre.Click;
  End;

end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoMARPEDPropertiesChange(
  Sender: TObject);
begin
  inherited;

  Try
    cxvComparativo.Enabled := False;
    With objCotacao.cdsItens Do
    Begin
      If State = dsEdit Then
      Begin
        Post;
        pAtualizaTotalSelecionado;
      End
    End;
  Finally
    cxvComparativo.Enabled := True;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbComparativoVALTOT01CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnMenor,
    blnEscolhido: Boolean;
begin
  inherited;

  blnMenor := objCotacao.arrCodFor[cxbComparativo.Columns[AViewInfo.Item.Index].Tag] =
              VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbComparativoFORMEN.Index]);

  blnEscolhido := objCotacao.arrCodFor[cxbComparativo.Columns[AViewInfo.Item.Index].Tag] =
                  VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbComparativoFORESC.Index]);

  If blnMenor And blnEscolhido Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color := clBlue;
  End

  Else If blnMenor Then
  Begin
    ACanvas.Brush.Color := clGreen;
    ACanvas.Font.Color := clWhite;

  End

  Else If blnEscolhido Then
  Begin
    ACanvas.Brush.Color := $0000B9B9;
    ACanvas.Font.Color := clBlue;
  End;

  If AViewInfo.Selected Then
    If cxbComparativo.Columns[AViewInfo.Item.Index].Focused Then
       ACanvas.Font.Style := [fsBold];
end;

procedure TfrmCadCotacaoGeralCX.cxbItensCODITEHeaderClick(Sender: TObject);
begin
  inherited;
  cxbItensORDITE.SortIndex := -1;
  IF cxbItensCODITE.SortIndex >= 0 Then
  Begin
    cxbItensCODITE.SortIndex := 1;
    cxbItensORDITE.SortIndex := 0;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensITESIM.Index])) = 'S' Then
  Begin
    ACanvas.Font.Color := COR_SIMILAR;

    ACanvas.Brush.Color := clWhite;
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clYellow;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
Var
  intIndCod, intIndOrd: Integer;
  varOrdIte1, varOrdIte2: Variant;
begin
  inherited;
  intIndCod := cxbItensCODITE.Index;
  intIndOrd := cxbItensORDITE.Index;
  If AItemIndex =  intIndCod Then
  Begin
    varOrdIte1 := ADataController.Values[ARecordIndex1, intIndOrd];
    varOrdIte2 := ADataController.Values[ARecordIndex2, intIndOrd];
    Compare := VarCompare(varOrdIte1, varOrdIte2);
  End
  Else
    Compare := VarCompare(V1,V2);
end;

procedure TfrmCadCotacaoGeralCX.cxbItensDataControllerSummaryFooterSummaryItemsSummary(
  ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
  var OutArguments: TcxSummaryEventOutArguments);
var
  SummFooterIdx: integer;
  fltQtdIte: Double;
begin
  inherited;
  If VarToStrDef(cxbItens.DataController.Values[Arguments.RecordIndex, cxbItensITESIM.Index],'N') =  'S' Then
    OutArguments.Value := 0;

  Try
    fltQtdIte := (cxbItens.DataController.Values[Arguments.RecordIndex, cxbItensQTDITE.Index]);
  Except
    fltQtdIte := 0;
  End;

  If (TCxGridDBTableSummaryItem(Arguments.SummaryItem).Column <> cxbItensQTDITE) And ((TCxGridDBTableSummaryItem(Arguments.SummaryItem).Column <> cxbItensPESOIT)) Then
  Begin
    SummFooterIdx := Arguments.SummaryItem.Index;

    If SummFooterIdx > -1 Then
      OutArguments.Value := OutArguments.Value * fltQtdIte;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensEXCLUIPropertiesChange(Sender: TObject);
begin
  inherited;
  With objCotacao.cdsItens Do
  Begin
    If State = dsEdit Then
      Post;

  End
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If dbeMulLoj.Checked Then
  begin
    cxbItensQTDITE.Options.Editing := False;
    Exit;
  end;

  If Assigned(AFocusedRecord) Then
  Begin
    If Not blnUtilizaBid Then
      cxbItensQTDITE.Options.Editing := (VarToStr(AFocusedRecord.Values[cxbItensITESIM.Index]) <> 'S')
    Else If (objCotacao.FieldByName('COT_LIBBID').AsString = 'N') Or (objCotacao.FieldByName('COT_LIBBID').AsString = '') Then
      cxbItensQTDITE.Options.Editing := (VarToStr(AFocusedRecord.Values[cxbItensITESIM.Index]) <> 'S');
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecCODITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensFornecITESIM.Index])) = 'S' Then
  Begin
    ACanvas.Font.Color := COR_SIMILAR;

    ACanvas.Brush.Color := clWhite;
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clYellow;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
Var
  intIndCod, intIndOrd: Integer;
  varOrdIte1, varOrdIte2: Variant;
begin
  inherited;
  intIndCod := cxbItensFornecCODITE.Index;
  intIndOrd := cxbItensFornecORDITE.Index;
  If AItemIndex =  intIndCod Then
  Begin
    varOrdIte1 := ADataController.Values[ARecordIndex1, intIndOrd];
    varOrdIte2 := ADataController.Values[ARecordIndex2, intIndOrd];
    Compare := VarCompare(varOrdIte1, varOrdIte2);
  End
  Else
    Compare := VarCompare(V1,V2);
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecDataControllerDataChanged(
  Sender: TObject);
begin
  inherited;

  pMostraTotais;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecDTAULTCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := 13434828;
  ACanvas.Font.Color  := clBlack;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
   btnReplicaDados.Enabled := (AFocusedItem = cxbItensFornecIPIENT) Or
                              (AFocusedItem = cxbItensFornecSUBSTI) Or
                              (AFocusedItem = cxbItensFornecFREENT) Or
                              (AFocusedItem = cxbItensFornecALQCBS) Or
                              (AFocusedItem = cxbItensFornecALQIBS) Or
                              (AFocusedItem = cxbItensFornecALQ_IS);

end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If objCotacao.cdsItens.State <> dsEdit Then
                 btnSair.Click;

    VK_RETURN: Begin
                 If (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecALQ_IS) Or
                    ((cxbItensFornec.Controller.FocusedColumn = cxbItensFornecFREENT) And (Not cxbItensFornecALQCBS.Visible)) Then
                 Begin
                   cxbItensFornec.NavigatorButtons.Next.Click;
                   cxbItensFornecVALUNI.Focused := True;
                 End

                 Else If (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecVALUNI) Or
                    (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecIPIENT) Or
                     (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecSUBSTI) Or
                    (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecFREENT) Or
                    (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecALQCBS) Or
                    (cxbItensFornec.Controller.FocusedColumn = cxbItensFornecALQIBS) Then
                   cxbItensFornec.Controller.FocusNextCell(True);
               End;

  End;

end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCadCotacaoGeralCX.cxbItensFornecVALUNIPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If (Not fEmptyStr(DisplayValue)) Then
    DisplayValue := RoundTo(DisplayValue, - objCotacao.intDecUni);
end;

procedure TfrmCadCotacaoGeralCX.cxbItensGERPEDPropertiesChange(Sender: TObject);
begin
  inherited;

  With objCotacao.cdsItens Do
  Begin
    If State = dsEdit Then
      Post;
  End
end;

procedure TfrmCadCotacaoGeralCX.cxbItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If objCotacao.cdsItens.State <> dsEdit Then
                 btnSair.Click;

    VK_RETURN : With objCotacao.cdsItens Do
                Begin

                  If Not IsEmpty then
                  Begin
                    edtCodIte.Text := FieldByName('CODITE').AsString;
                    edtDesIte.Text := FieldByName('DESITE').AsString;
                    edtQtdIte.Text := FormatFloat('#0.00', FieldByName('QTDITE').AsFloat);

                    pHabilitaDescricao(Pos('ITEM ESPECIAL', FieldByName('DESCRI').AsString) > 0);

                    edtCodIte.ReadOnly := objCotacao.blnMulLoj;

                    If objCotacao.blnMulLoj Then
                      fValidaCampos(edtQtdIte, True)
                    Else
                      pSetFocus(edtCodIte);

                  End Else
                  Begin
                    edtCodIte.ReadOnly := False;
                    pSetFocus(edtCodIte);
                  End;

                End;
  End;
end;

procedure TfrmCadCotacaoGeralCX.cxvFornecedoresCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvFornecedoresMARCADO.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
    ACanvas.Font.Color   := clBlue;
  End;

end;

procedure TfrmCadCotacaoGeralCX.cxvFornecedoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: objCotacao.pMarcaDesmarcaFornecedor;

    VK_ESCAPE: If objCotacao.cdsFornecedores.State <> dsEdit Then
                 btnSair.Click;
  End;

end;

procedure TfrmCadCotacaoGeralCX.chkNovIpiClick(Sender: TObject);
begin
  inherited;
  If dtsCotGer.State in dsEditModes Then
  Begin
    dtsCotGer.DataSet.FieldByName('COT_NOVIPI').AsString := IIf(chkNovIpi.Checked, 'S', 'N');
    objCotacao.fIncluir_CopiaSeguranca_AtualizaCapa;
    objCotacao.fSelecionaMenoresPrecos;
  End;
end;

procedure TfrmCadCotacaoGeralCX.dbeDtaEntExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeDtaEnt, True);
end;

procedure TfrmCadCotacaoGeralCX.chkSuspendeOrdenacaoClick(Sender: TObject);
begin
  If chkSuspendeOrdenacao.Checked Then
    pSalvaOrdenacao;

  TcxGridDBDataController(cxbComparativo.DataController).blnOrdenar := False;

  cxbComparativo.DataController.Refresh;

  If Not chkSuspendeOrdenacao.Checked Then
    pSalvaOrdenacao;
end;

procedure TfrmCadCotacaoGeralCX.dbeMulLojClick(Sender: TObject);
begin
  inherited;

  If dbeMulLoj.Enabled Then
    objCotacao.pSetaMultiLojas(True);

  btnCarregaPedidosVenda.Visible := fCfgSis('URCPVR', varBoolean) And (Not dbeMulLoj.Checked);
  cxbItensSALSIM.DataBinding.FieldName := 'SALSIM';
  If dbeMulLoj.Enabled Then
    cxbItensSALSIM.DataBinding.FieldName := 'SLMSIM';

  edtCodSolicitacaoVinculada.Visible := not dbeMulLoj.Checked;
  lblCodSolicitacaoVinculada.Visible := edtCodSolicitacaoVinculada.Visible;
  edtCodSolicitacaoVinculada.Text := EmptyStr;
end;

procedure TfrmCadCotacaoGeralCX.edtCodCmpKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;

  If (Not fCfgSis('DIGCOT', varBoolean)) Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    If (fPesqOperador(Self, edtCodCmp, edtNomCmp, Nil, Key, arrSel)) then
    Begin
      If fValidaCampos(edtCodCmp, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCotacaoGeralCX.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
    i: TConsultas;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec,  False) Then
  Begin
    If Length(arrFornec) > 1 Then
    Begin
      for i in arrFornec do
      begin
        If dtsCotCfo.DataSet.RecordCount > 50 Then
         Break;
        edtCodFor.Text := i.strCodigo;
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        pIncluiFornecedor(False);
      End
    End
    Else
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCotacaoGeralCX.edtCodIteEnter(Sender: TObject);
begin
  inherited;

  If fEstaNaConsultaTab Then
    Exit;
end;

procedure TfrmCadCotacaoGeralCX.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    strTabPre: String;
begin
  If fEntraCons(Key) And fEstaNaConsultaTab Then
    Exit;

  if fEmptyStr(edtCodIte.Text) then
  Begin
    edtCodIte.MaxLength := 0;
    edtCodIte.TamCampo  := 0;
    edtCodIte.CompZeros := False;
  End
  Else
  if CharInSet( edtCodIte.Text[1] , ['0'..'9']) Then
  Begin
    if Not MatchStr( key, ['0','1','2','3','4','5','6','7','8','9','*','%', '/', '?', #8]) then
      Key := #0;
  End;

  inherited;

  strTabPre := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));
  Try
    objfrmPnl := TPanelCxItem.New();
    Try
      If ((Not fEmptyStr(edtCodIte.Text)) And (Not fIsNumber(edtCodIte.Text))) Then
        If (Key = #$D) or (Key = #9) Then
          Key := '?';

      {******************************************************************}
      {* NÃO CHAMA MAIS A COSULTA ESPECÍFICA, AGORA CHAMA A NOVA FUNÇÃO *}
      {***************************************************************AC*}


      objFrmPnl.procMostraDocumentoReimpressao := pMostraDocumentoReimpressao;
      objFrmPnl.sltLista   := objCotacao.stlItens;
      objFrmPnl.strNomForm := Self.Name;
      objFrmPnl.recParametros.strCodCli  := '';
      objFrmPnl.strCodVen  := '';
      objFrmPnl.strCodDig  := '';
      objFrmPnl.intPraMedio:= 0;
      objFrmPnl.blnFaturamento := True;
      objFrmPnl.recParametros.strTabPre  := strTabPre;
      objfrmPnl.strNumOrc  := '';
      objfrmPnl.strEspOrc  := '';
      objFrmPnl.procExibeAgregados := TfrmAgregados.pExibe;
      objFrmPnl.ProcExibeRequisicaoCompra := TfrmFatRequisicaoCompras.pExibe;
      objFrmPnl.fncTeclaTab := fSelecionaItem;

      If fPesqItem(conIteCompleta,
                   Self,
                   edtCodIte,
                   edtDesIte,
                   nil,
                   Key,
                   arrSel,
                   True,
                   objfrmPnl,
                   'Consulta de Itens',
                   strTabPre,
                   '',
                   0,
                   false,
                   false,
                   0,
                   cdrCodIte,
                   '',
                   True,
                   '',
                   '',
                   True,
                   False,
                   True,
                   '',
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   True,
                   False,
                   '',
                   -1,
                   False,
                   '',
                   True,
                   '',
                   '',
                   '',
                   IIF(fIsNumber(edtCodIte.Text), '', edtCodIte.Text)) Then
      Begin
        If (fValidaCampos(edtCodIte, True)) Then
          blnMudarFoco := True;
      End
      Else
      Begin
        If ((Key = #0) And (Not fEmptyStr(edtCodIte.Text)) And (Not fIsNumber(edtCodIte.Text))) Then
          pSetFocus(edtCodIte);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pConsultaItem]');
      End;
    End;

  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmCadCotacaoGeralCX.edtCodSolicitacaoVinculadaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrPesq: TConsultasArray;
  strStatus: string;
begin
  inherited;

  If Key <> '/' Then
    Key := #0;

  strStatus := QuotedStr(TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(tsAprovada));

  If fPesqSoliManutEquipInterno(Self, edtCodSolicitacaoVinculada, Nil, Key, arrPesq, true, True, strStatus) Then
  Begin
    If fValidaCampos(edtCodSolicitacaoVinculada) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCotacaoGeralCX.edtCodTctExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodTct, True);
end;

procedure TfrmCadCotacaoGeralCX.edtCodTctKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrAux: TConsultasArray;
begin
  inherited;

  If fPesqTipoCotacaoPedCpr(Self, edtCodTct, edtDesTct, qryTabela, Key, arrAux) Then
  Begin
    fValidaCampos(edtCodTct, True);
  End;
end;

Function TfrmCadCotacaoGeralCX.fGetColunaValorTotal(intNroCol: integer): TcxGridDBBandedColumn;
Begin
  Case intNroCol Of
    01:  Result := cxbComparativoVALTOT01;
    02:  Result := cxbComparativoVALTOT02;
    03:  Result := cxbComparativoVALTOT03;
    04:  Result := cxbComparativoVALTOT04;
    05:  Result := cxbComparativoVALTOT05;
    06:  Result := cxbComparativoVALTOT06;
    07:  Result := cxbComparativoVALTOT07;
    08:  Result := cxbComparativoVALTOT08;
    09:  Result := cxbComparativoVALTOT09;
    10:  Result := cxbComparativoVALTOT10;
    11:  Result := cxbComparativoVALTOT11;
    12:  Result := cxbComparativoVALTOT12;
    13:  Result := cxbComparativoVALTOT13;
    14:  Result := cxbComparativoVALTOT14;
    15:  Result := cxbComparativoVALTOT15;
    16:  Result := cxbComparativoVALTOT16;
    17:  Result := cxbComparativoVALTOT17;
    18:  Result := cxbComparativoVALTOT18;
    19:  Result := cxbComparativoVALTOT19;
    20:  Result := cxbComparativoVALTOT20;
    21:  Result := cxbComparativoVALTOT21;
    22:  Result := cxbComparativoVALTOT22;
    23:  Result := cxbComparativoVALTOT23;
    24:  Result := cxbComparativoVALTOT24;
    25:  Result := cxbComparativoVALTOT25;
    26:  Result := cxbComparativoVALTOT26;
    27:  Result := cxbComparativoVALTOT27;
    28:  Result := cxbComparativoVALTOT28;
    29:  Result := cxbComparativoVALTOT29;
    30:  Result := cxbComparativoVALTOT30;
    31:  Result := cxbComparativoVALTOT31;
    32:  Result := cxbComparativoVALTOT32;
    33:  Result := cxbComparativoVALTOT33;
    34:  Result := cxbComparativoVALTOT34;
    35:  Result := cxbComparativoVALTOT35;
    36:  Result := cxbComparativoVALTOT36;
    37:  Result := cxbComparativoVALTOT37;
    38:  Result := cxbComparativoVALTOT38;
    39:  Result := cxbComparativoVALTOT39;
    40:  Result := cxbComparativoVALTOT40;
    41:  Result := cxbComparativoVALTOT41;
    42:  Result := cxbComparativoVALTOT42;
    43:  Result := cxbComparativoVALTOT43;
    44:  Result := cxbComparativoVALTOT44;
    45:  Result := cxbComparativoVALTOT45;
    46:  Result := cxbComparativoVALTOT46;
    47:  Result := cxbComparativoVALTOT47;
    48:  Result := cxbComparativoVALTOT48;
    49:  Result := cxbComparativoVALTOT49;
    50:  Result := cxbComparativoVALTOT50;
    Else Result := Nil;
  End;
End;

function TfrmCadCotacaoGeralCX.fGetQtdeTab(const dblQtdePadrao: Double;
  RectLinhaGrid: TRect): Double;
var
  objForm: TfrmTabQtd;
begin
  If RectLinhaGrid = RectLinhaGrid.Empty Then
  Begin
    Result := -1;
    Exit;
  End;

  objForm := TfrmTabQtd.Create(nil);

  try
    objForm.dblQtde := dblQtdePadrao;
    objForm.Left := RectLinhaGrid.Left + 40;
    objForm.Top  := RectLinhaGrid.Bottom + 35;

    objForm.pnlAmbiente.Visible := False;
    objForm.pnlQuantidade.Align := alClient;
    objForm.Width := 125;


    if objForm.ShowModal = mrOk then
    begin
      Result := StrToFloatDef(objForm.edtQtde.Text, 0);
    end
    else
    begin
      Result := -1;
    end;
  finally
    FreeAndNil(objForm);
  end;
end;

procedure TfrmCadCotacaoGeralCX.pLimpaCamposItem;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Clear;
end;

procedure TfrmCadCotacaoGeralCX.pLimpaFornecedor;
Begin
  edtCodFor.Clear;
  edtNomFor.Clear;
  pSetFocus(edtCodFor);
End;

Function TfrmCadCotacaoGeralCX.fRetTotalSelecionado: Double;
  Var
    intContador: Integer;
Begin
  Result := 0;
  For intContador := 0 To INT_MAX_FORNECEDOR - 1 Do
    If cxbComparativo.DataController.Summary.FooterSummaryValues[intContador] <> Null Then
     Result := Result + cxbComparativo.DataController.Summary.FooterSummaryValues[intContador];
End;

function TfrmCadCotacaoGeralCX.fSelecionaItem(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;

Var
  blnConfiguracaoQtdeTab : Boolean;
  dblQtdeTab             : Double;
  strDefaultQtdeTab      : String;
Begin

  dblQtdeTab := 0;
  Result := False;
  edtCodIte.Clear;
  btnExcluir.Visible := False;

  edtCodIte.ReadOnly := False;
  edtCodIte.TabStop  := True;

  Try

    Try

      If cdsConsulta.IsEmpty Then
        Exit;

      (***************************************************************}
      {* cdsConsultaItem COM VARIÁVEL DE REFERÊNCIA DE cdsConsulta   *}
      {* E É USADA PARA EDITAR O CAMPO "VENDIDO" DURANTE A EXIBIÇÃO  *}
      {* DA CONSULTA DE ITENS. ANTES DE SAIR DESTA FUNÇÃO A VARIÁVEL *}
      {* É DESVINCULADA POR cdsConsultaItem := Nil POIS ESTAVA DANDO *}
      {* VIOLAÇÃO DE MEMÓRIA EM ALGUMAS SITUAÇÕES                    *}
      {************************************************************VA*)
      cdsConsultaItem := cdsConsulta;

      edtCodIte.Text := cdsConsulta.FieldByName('ITE_CODITE').AsString;
      If objCotacao.cdsItens.Locate('CODITE', edtCodIte.Text, []) Then
      Begin
        btnExcluir.Visible := True;
      End;

      If fValidaCampos(edtCodIte, True) Then
      Begin
        blnConfiguracaoQtdeTab := VS_strModoTAB = '2'; // Pegar a configuração

        if blnConfiguracaoQtdeTab then
        begin
          strDefaultQtdeTab := '1';

          If (cdsConsulta.FieldByName('ITE_CODITE').AsString = objCotacao.cdsItens.FieldByName('CODITE').AsString) And (objCotacao.cdsItens.FieldByName('QTDITE').AsFloat > 0) Then
            strDefaultQtdeTab := objCotacao.cdsItens.FieldByName('QTDITE').AsString;

          dblQtdeTab := fGetQtdeTab(StrToFloatDef(strDefaultQtdeTab, 0), RectLinhaGrid);
        end;

        if (blnConfiguracaoQtdeTab) and (dblQtdeTab = 0) then
        begin
          if cdsConsulta.FieldByName('VENDIDO').AsInteger = 1 then
          begin
            if objCotacao.cdsItens.Locate('CODITE', cdsConsulta.FieldByName('ITE_CODITE').AsString, []) then
            begin
              cdsConsulta.Edit;
              cdsConsulta.FieldByName('VENDIDO').Value := Null;
              cdsConsulta.Post;
            end;
          end;
        end
        else
        begin

          SelectNext(ActiveControl, True, True);

          pDesabilitaCamposItem;

          pCriarFormularios(TfrmCadCotacaoGeralCXItem, frmCadCotacaoGeralCXItem);
          pnlTail.Parent     := frmCadCotacaoGeralCXItem;
          pnlTail.BevelOuter := bvNone;
          frmCadCotacaoGeralCXItem.fValidaCamposVenda := fValidaCampos;
          If btnExcluir.visible Then
          Begin
            frmCadCotacaoGeralCXItem.btnExcluir.Visible := True;
            frmCadCotacaoGeralCXItem.pOnClickExcluir := pOnClickExcluir;
          End;
          frmCadCotacaoGeralCXItem.edtCodEmp.Text := VS_strCodEmp;

          edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 1);

          //quando acessado o TAB do produto, iniciar como 1,00 como default e não 0,00; req: 63928
          //se o produto em questão já estiver quantidade, carregar a informada anteriormente
          If (cdsConsulta.FieldByName('ITE_CODITE').AsString = objCotacao.cdsItens.FieldByName('CODITE').AsString) And (objCotacao.cdsItens.FieldByName('QTDITE').AsFloat > 0) Then
            edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, objCotacao.cdsItens.FieldByName('QTDITE').AsFloat);

          frmCadCotacaoGeralCXItem.Width := 630;

          frmCadCotacaoGeralCXItem.ClientHeight := frmCadCotacaoGeralCXItem.pnlEmpresa.Height + pnlTail.Height + frmCadCotacaoGeralCXItem.pnlStatus.Height;

          edtCodIte.ReadOnly := True;
          edtCodIte.TabStop  := False;

          // Quando a quantidade já veio informada a partir da configuração
          // para agilizar a inserção de itens no orçamento
          if (blnConfiguracaoQtdeTab) then
          begin
            if (dblQtdeTab > 0) then
            begin
              edtQtdIte.Text := FormatFloat(',0.00', dblQtdeTab);
              btnIncluir.Click;
            end;
          end
          else
            frmCadCotacaoGeralCXItem.ShowModal;

        end;

        Result := True;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatVendas.fVendeItem]');
      End;

      On E: ExceptionAutCom Do
      Begin
        Result := False;
        pMensagemOk(E.Message);
      End;

    End;

  Finally

    If cdsConsultaItem <> Nil Then
      cdsConsultaItem := Nil;

    btnExcluir.Visible := True;

    pnlTail.Parent := pnlTailFixo;
    edtCodIte.ReadOnly := False;
    edtCodIte.TabStop  := True;
    pFreeAndNil(frmCadCotacaoGeralCXItem);
    pHabilitaCamposItem;
    pLimpaCamposItem;
  End;
end;

Procedure TfrmCadCotacaoGeralCX.pSelecionaTipoTotal(intIndex: Integer);
  Var
    intContador: Integer;
Begin
  For intContador := 0 To INT_MAX_FORNECEDOR - 1 Do
    TcxGridDBTableSummaryItem(cxbComparativo.DataController.Summary.FooterSummaryItems[intContador]).FieldName :=
      'TOTESC' + IfThen(intIndex = 0, 'F2', '') + objCotacao.fIndice(Succ(intContador));

  pAtualizaTotalSelecionado;
End;

procedure TfrmCadCotacaoGeralCX.pAddCampoBloqueado(cxColumn: TcxGridDBBandedColumn);
begin
  If fLocalizaPosArray(ArrCampoBloqueado, cxColumn.Name) = -1  Then
  Begin
    SetLength(ArrCampoBloqueado, Length(ArrCampoBloqueado) + 1);
    ArrCampoBloqueado[Length(ArrCampoBloqueado) -1].ComponentName := cxColumn.name;
  end;
end;

function TfrmCadCotacaoGeralCX.fLocalizaPosArray(objArray: TArrCamposCfg; strColuna: string): integer;
  var
    i: integer;
begin
  Result := -1;

  if Length(objArray) = 0 then
    Exit;

  for i := 0 To Length(objArray) -1 do
    if objArray[i].ComponentName = strColuna Then
    begin
      Result := i;
      Break;
    end;
end;

procedure TfrmCadCotacaoGeralCX.pAjustaPainelStutusBID;
begin
  lblIntegrado.Visible := (objCotacao.FieldByName('COT_LIBBID').AsString <> 'N');
  If objCotacao.FieldByName('COT_LIBBID').AsString = 'L' Then
    lblIntegrado.Font.Color := clRed
  Else If objCotacao.FieldByName('COT_LIBBID').AsString = 'I' Then
    lblIntegrado.Font.Color := clBlue;

end;

procedure TfrmCadCotacaoGeralCX.pAlinharPainelSimilar(objParent: TWinControl; intLeft, intTop: Integer);
Begin
  pnlSimilar.Parent := objParent;
  pnlSimilar.Left := intLeft;
  pnlSimilar.Top := intTop;
  lblSimilar.Font.Color := COR_SIMILAR;
  shpSimilar.Brush.Color := COR_SIMILAR;
  pnlSimilar.Visible := fCfgSis('COTSIM', varBoolean);
End;

Function TfrmCadCotacaoGeralCX.fCarregaItensVendas(pgbProgresso: TcxProgressBar): Boolean;
var blnInseriu: Boolean;
    frmSelItensVendasParaPedidoCompra: TfrmSelItensVendasParaPedidoCompra;
Begin
  inherited;
  Result := True;
  frmSelItensVendasParaPedidoCompra := TfrmSelItensVendasParaPedidoCompra.fSelecionaItens;
  Try
    If frmSelItensVendasParaPedidoCompra.blnConfirma Then
    Begin
      pgbProgresso.Properties.Max := frmSelItensVendasParaPedidoCompra.cdsItens.RecordCount;
      frmSelItensVendasParaPedidoCompra.cdsItens.First;
      while not frmSelItensVendasParaPedidoCompra.cdsItens.Eof Do
      begin
        edtCodIte.Text := frmSelItensVendasParaPedidoCompra.cdsItens.FieldByName('DET_CODITE').AsString;
        blnInseriu := fValidaCodigoProduto(True);

        If blnInseriu Then
        Begin
          edtQtdIte.Text := frmSelItensVendasParaPedidoCompra.cdsItens.FieldByName('DET_QTDITE').AsString;

          fValidaCampos(edtQtdIte);
        End;


        frmSelItensVendasParaPedidoCompra.cdsItens.Next;
        pgbProgresso.Position := frmSelItensVendasParaPedidoCompra.cdsItens.RecNo;
        Application.ProcessMessages;
      End;
    End;
  Finally
    FreeAndNil(frmSelItensVendasParaPedidoCompra);
  End;

End;

procedure TMycxCustomDataControllerInfo.DoSort;
begin
  inherited;
end;

Procedure TcxGridDBDataController.SetOrdenar(Value: Boolean);
Begin
  If Value <> TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar Then
  Begin
    TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar := Value;

    If Value Then
      TMycxCustomDataControllerInfo(DataControllerInfo).DoSort;

  End;

End;

Function TcxGridDBDataController.GetOrdenar: Boolean;
Begin
  Result := TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar;
End;

function TfrmCadCotacaoGeralCX.fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
  Var
    intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To lstOrdemResgistros.Count -1 Do
    If TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intRecordIndex = ARecordIndex Then
    Begin
      Result := TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intPosition;
      Break;
    End;

end;

procedure TfrmCadCotacaoGeralCX.pSalvaOrdenacao;
  Var
    intRecNo,
    intContador: Integer;
    ptrRegistro: TPosicaoRegistroPrt;
begin
  pLiberaOrdenacao;

  If objCotacao.cdsItens.IsEmpty Then
    Exit;

  intRecNo := objCotacao.cdsItens.RecNo;

  With cxbComparativo.DataController do
  For intContador := 0 To RecordCount - 1 Do
  begin
    New(ptrRegistro);
    ptrRegistro^.intRecordIndex := intContador;
    ptrRegistro^.intPosition := GetRowIndexByRecordIndex(intContador, False);
    lstOrdemResgistros.Add(ptrRegistro);
  end;

  objCotacao.cdsItens.RecNo := intRecNo;
end;

procedure TfrmCadCotacaoGeralCX.pLiberaOrdenacao;
  Var
    intContador: Integer;
Begin
  For intContador := 0 To lstOrdemResgistros.Count -1 Do
    Dispose(TPosicaoRegistroPrt(lstOrdemResgistros[intContador]));

  lstOrdemResgistros.Clear;
End;


procedure TfrmCadCotacaoGeralCX.mnuConsultaPrecosPitStopClick(Sender: TObject);
begin
  inherited;

  If Not FileExists(ExtractFilePath(Application.ExeName) + '\ConsultaPitStop.exe') Then
    pMensagemOk('Não foi encontrado o executável ConsultaPitStop.exe, entre em contato com a Citel');


  If fEmptyStr(objCotacao.FieldByName('COT_NUMCOT').AsString) Then
  Begin
    pMensagemOk('Para fazer esta consulta é preciso salvar a cotação!');
    Exit;
  End;
  objCotacao.pProcessaApiCotacao(idRedePitStop);
end;

procedure TfrmCadCotacaoGeralCX.mnuImportarPrecosPitStopClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(objCotacao.FieldByName('COT_NUMCOT').AsString) Then
  Begin
    pMensagemOk('Para fazer esta consulta é preciso salvar a cotação!');
    Exit;
  End;

  objCotacao.pCarregaPrecosCotacaoPitStop;
  {}
end;


procedure TfrmCadCotacaoGeralCX.msgPitStopTerminouProcesso(var Msg: TMessage);
var lNumCot: String;
    lCodFor: String;
    lCotSeqGer: String;
Begin
  lNumcot := fStrZero(Msg.WParam, 6);
  lCodFor := fStrZero(Msg.LParam, 8);


  If objCotacao.FieldByName('COT_NUMCOT').AsString <> lNumcot Then
    Exit;

  lCotSeqGer := fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT'], [lNumcot]);

  objCotacao.pAtualizaStatusFornecedoresPitStop(lCotSeqGer, lCodFor);
  If fPergunta('A Consulta Pit Stop foi finalizada, deseja carregar os preços?') Then
  begin
    objCotacao.pCarregaPrecosCotacaoPitStop;
  End;
end;

end.
