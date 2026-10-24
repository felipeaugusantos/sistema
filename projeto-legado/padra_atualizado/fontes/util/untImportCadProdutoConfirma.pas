unit untImportCadProdutoConfirma;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, uni, untFuncoesSimples, System.DateUtils,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
 frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
 BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
 cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
 cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
 cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
 untZClient, MyClassesUni, frxDBSet, Vcl.ComCtrls, cxContainer, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox, cxGridCitel,
  Datasnap.DBClient, UniClientDataSet, Vcl.CheckLst, Math, cxCurrencyEdit;

 type
  TTipoDefault = (tpdfNull, tpdfSim, tpdfNao, tpdfZero);

  TTabelaDePrecoLista = (tplTabela1, tplTabela2, tplTabela3, tplTabela4, tplTabela5, tplTabela6, tplTabela7);
  TRecalculoGeral = (rgMargem, rgPrecoVenda);
  TRecTabPrecos = Record
    fltPreVen,
    fltMarBru,
    fltComiss: Double;
    fltVariacao: Double;
  End;


  TArrRecPrecos = Array[1..7] Of TRecTabPrecos;


  TObjTabela = class(TComponent)
  public
    TabelaDePrecoLista: TTabelaDePrecoLista;
    constructor Create(AOwner: TComponent);  override;
  End;

  TfrmImportCadProdutoConfirma = class(TfrmPaiConfirma)
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    dtsDados: TDataSource;
    frxRepNaoImp: TfrxReport;
    btnVisProdNaoImp: TBitBtnLocked;
    pgcContainer: TPageControl;
    tbsAltera: TTabSheet;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    tbsInclui: TTabSheet;
    cxgItensViewCodIte: TcxGridDBColumn;
    cxgItensViewDesIte: TcxGridDBColumn;
    cxgItensViewCodFab: TcxGridDBColumn;
    cxgItensViewCODFOR: TcxGridDBColumn;
    cxgItensViewCODDEP: TcxGridDBColumn;
    cxgItensViewCODDEP_NOV: TcxGridDBColumn;
    cxgItensViewCODGRU: TcxGridDBColumn;
    cxgItensViewCODGRU_NOV: TcxGridDBColumn;
    cxgItensViewDESFAB: TcxGridDBColumn;
    cxgItensViewDESFAB_NOV: TcxGridDBColumn;
    cxgItensViewCODMAR: TcxGridDBColumn;
    cxgItensViewCODMAR_NOV: TcxGridDBColumn;
    cxgItensViewREFERE: TcxGridDBColumn;
    cxgItensViewREFERE_NOV: TcxGridDBColumn;
    cxgItensViewCODUNI: TcxGridDBColumn;
    cxgItensViewCODUNI_NOV: TcxGridDBColumn;
    cxgItensViewUNICOM: TcxGridDBColumn;
    cxgItensViewUNICOM_NOV: TcxGridDBColumn;
    cxgItensViewCODABF: TcxGridDBColumn;
    cxgItensViewCODABF_NOV: TcxGridDBColumn;
    cxgItensViewABFPIS: TcxGridDBColumn;
    cxgItensViewABFPIS_NOV: TcxGridDBColumn;
    cxgItensViewABFCOF: TcxGridDBColumn;
    cxgItensViewABFCOF_NOV: TcxGridDBColumn;
    cxgItensViewABFIPI: TcxGridDBColumn;
    cxgItensViewABFIPI_NOV: TcxGridDBColumn;
    cxgItensViewIPISAI: TcxGridDBColumn;
    cxgItensViewIPISAI_NOV: TcxGridDBColumn;
    cxgItensViewINCPIS: TcxGridDBColumn;
    cxgItensViewINCPIS_NOV: TcxGridDBColumn;
    cxgItensViewCLAIPI: TcxGridDBColumn;
    cxgItensViewCLAIPI_NOV: TcxGridDBColumn;
    cxgItensViewEXCIPI: TcxGridDBColumn;
    cxgItensViewEXCIPI_NOV: TcxGridDBColumn;
    cxgItensViewCDCEST: TcxGridDBColumn;
    cxgItensViewCDCEST_NOV: TcxGridDBColumn;
    cxgItensViewCODONU: TcxGridDBColumn;
    cxgItensViewCODONU_NOV: TcxGridDBColumn;
    cxgItensViewIMPLIS: TcxGridDBColumn;
    cxgItensViewIMPLIS_NOV: TcxGridDBColumn;
    cxgItensViewITEATI: TcxGridDBColumn;
    cxgItensViewITEATI_NOV: TcxGridDBColumn;
    cxgItensViewATICOM: TcxGridDBColumn;
    cxgItensViewATICOM_NOV: TcxGridDBColumn;
    cxgItensViewPESOIT: TcxGridDBColumn;
    cxgItensViewPESOIT_NOV: TcxGridDBColumn;
    cxgItensViewPESLIQ: TcxGridDBColumn;
    cxgItensViewPESLIQ_NOV: TcxGridDBColumn;
    cxgItensViewCODGPR: TcxGridDBColumn;
    cxgItensViewCODGPR_NOV: TcxGridDBColumn;
    cxgItensViewPRDGRU: TcxGridDBColumn;
    cxgItensViewPRDGRU_NOV: TcxGridDBColumn;
    cxgItensViewGRUCMP: TcxGridDBColumn;
    cxgItensViewGRUCMP_NOV: TcxGridDBColumn;
    cxgItensViewMLTVEN: TcxGridDBColumn;
    cxgItensViewMLTVEN_NOV: TcxGridDBColumn;
    cxgItensViewMLTCOM: TcxGridDBColumn;
    cxgItensViewMLTCOM_NOV: TcxGridDBColumn;
    cxgItensViewNVLGIR: TcxGridDBColumn;
    cxgItensViewNVLGIR_NOV: TcxGridDBColumn;
    cxgItensViewNIVGIR: TcxGridDBColumn;
    cxgItensViewNIVGIR_NOV: TcxGridDBColumn;
    cxgItensViewACOOBJ: TcxGridDBColumn;
	  cxgItensViewACOOBJ_NOV: TcxGridDBColumn;
    cxgItensViewAPLICA: TcxGridDBColumn;
    cxgItensViewAPLICA_NOV: TcxGridDBColumn;
    cxgItensViewPRECOM: TcxGridDBColumn;
    cxgItensViewPRECOM_NOV: TcxGridDBColumn;
    cxgItensViewDESF01: TcxGridDBColumn;
    cxgItensViewDESF01_NOV: TcxGridDBColumn;
    cxgItensViewDESF02: TcxGridDBColumn;
    cxgItensViewDESF02_NOV: TcxGridDBColumn;
    cxgItensViewDESF03: TcxGridDBColumn;
    cxgItensViewDESF03_NOV: TcxGridDBColumn;
    cxgItensViewDESF04: TcxGridDBColumn;
    cxgItensViewDESF04_NOV: TcxGridDBColumn;
    cxgItensViewDESF05: TcxGridDBColumn;
    cxgItensViewDESF05_NOV: TcxGridDBColumn;
    cxgItensViewDESF06: TcxGridDBColumn;
    cxgItensViewDESF06_NOV: TcxGridDBColumn;
    cxgItensViewICMENT: TcxGridDBColumn;
    cxgItensViewICMENT_NOV: TcxGridDBColumn;
    cxgItensViewSUBFED: TcxGridDBColumn;
    cxgItensViewSUBFED_NOV: TcxGridDBColumn;
    cxgItensViewIPIENT: TcxGridDBColumn;
    cxgItensViewIPIENT_NOV: TcxGridDBColumn;
    cxgItensViewFREENT: TcxGridDBColumn;
    cxgItensViewFREENT_NOV: TcxGridDBColumn;
    cxgItensViewVALFRE: TcxGridDBColumn;
    cxgItensViewVALFRE_NOV: TcxGridDBColumn;
    cxgItensViewACRFIN: TcxGridDBColumn;
    cxgItensViewACRFIN_NOV: TcxGridDBColumn;
    cxgItensViewSUBSTI: TcxGridDBColumn;
    cxgItensViewSUBSTI_NOV: TcxGridDBColumn;
    cxgItensViewDESADB: TcxGridDBColumn;
    cxgItensViewDESADB_NOV: TcxGridDBColumn;
    cxgItensViewOUTVAL: TcxGridDBColumn;
    cxgItensViewOUTVAL_NOV: TcxGridDBColumn;
    cxgItensViewICMSAI: TcxGridDBColumn;
    cxgItensViewICMSAI_NOV: TcxGridDBColumn;
    cxgItensViewIMPFED: TcxGridDBColumn;
    cxgItensViewIMPFED_NOV: TcxGridDBColumn;
    cxgItensViewDESOPE: TcxGridDBColumn;
    cxgItensViewDESOPE_NOV: TcxGridDBColumn;
    cxgItensViewMARBR1: TcxGridDBColumn;
    cxgItensViewMARBR1_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB1: TcxGridDBColumn;
    cxgItensViewCOMTB1_NOV: TcxGridDBColumn;
    cxgItensViewPREVE1: TcxGridDBColumn;
    cxgItensViewPREVE1_NOV: TcxGridDBColumn;
    cxgItensViewMARBR2: TcxGridDBColumn;
    cxgItensViewMARBR2_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB2: TcxGridDBColumn;
    cxgItensViewCOMTB2_NOV: TcxGridDBColumn;
    cxgItensViewPREVE2: TcxGridDBColumn;
    cxgItensViewPREVE2_NOV: TcxGridDBColumn;
    cxgItensViewMARBR3: TcxGridDBColumn;
    cxgItensViewMARBR3_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB3: TcxGridDBColumn;
    cxgItensViewCOMTB3_NOV: TcxGridDBColumn;
    cxgItensViewPREVE3: TcxGridDBColumn;
    cxgItensViewPREVE3_NOV: TcxGridDBColumn;
    cxgItensViewMARBR4: TcxGridDBColumn;
    cxgItensViewMARBR4_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB4: TcxGridDBColumn;
    cxgItensViewCOMTB4_NOV: TcxGridDBColumn;
    cxgItensViewPREVE4: TcxGridDBColumn;
    cxgItensViewPREVE4_NOV: TcxGridDBColumn;
    cxgItensViewMARBR5: TcxGridDBColumn;
    cxgItensViewMARBR5_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB5: TcxGridDBColumn;
    cxgItensViewCOMTB5_NOV: TcxGridDBColumn;
    cxgItensViewPREVE5: TcxGridDBColumn;
    cxgItensViewPREVE5_NOV: TcxGridDBColumn;
    cxgItensViewMARBR6: TcxGridDBColumn;
    cxgItensViewMARBR6_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB6: TcxGridDBColumn;
    cxgItensViewCOMTB6_NOV: TcxGridDBColumn;
    cxgItensViewPREVE6: TcxGridDBColumn;
    cxgItensViewPREVE6_NOV: TcxGridDBColumn;
    cxgItensViewMARBR7: TcxGridDBColumn;
    cxgItensViewMARBR7_NOV: TcxGridDBColumn;
    cxgItensViewCOMTB7: TcxGridDBColumn;
    cxgItensViewCOMTB7_NOV: TcxGridDBColumn;
    cxgItensViewPREVE7: TcxGridDBColumn;
    cxgItensViewPREVE7_NOV: TcxGridDBColumn;
    cxgItensViewCOMVAR: TcxGridDBColumn;
    cxgItensViewCOMVAR_NOV: TcxGridDBColumn;
    cxgItensViewCOMATA: TcxGridDBColumn;
    cxgItensViewCOMATA_NOV: TcxGridDBColumn;
    cxgItensViewCOMDIS: TcxGridDBColumn;
    cxgItensViewCOMDIS_NOV: TcxGridDBColumn;
    cxgItensViewCOMPRO: TcxGridDBColumn;
    cxgItensViewCOMPRO_NOV: TcxGridDBColumn;
    cxgItensViewDESMAX: TcxGridDBColumn;
    cxgItensViewDESMAX_NOV: TcxGridDBColumn;
    cxgItensViewDESMSU: TcxGridDBColumn;
    cxgItensViewDESMSU_NOV: TcxGridDBColumn;
    cxgItensViewDESMGE: TcxGridDBColumn;
    cxgItensViewDESMGE_NOV: TcxGridDBColumn;
    cxgItensViewMARMIN: TcxGridDBColumn;
    cxgItensViewMARMIN_NOV: TcxGridDBColumn;
    cxgItensViewMARMSG: TcxGridDBColumn;
    cxgItensViewMARMSG_NOV: TcxGridDBColumn;
    cxgItensViewMARMGE: TcxGridDBColumn;
    cxgItensViewMARMGE_NOV: TcxGridDBColumn;
    cxgItensViewTMPGAR: TcxGridDBColumn;
    cxgItensViewTMPGAR_NOV: TcxGridDBColumn;
    cxgItensViewINFGAR: TcxGridDBColumn;
    cxgItensViewINFGAR_NOV: TcxGridDBColumn;
    cxgItensViewLOCFIS: TcxGridDBColumn;
    cxgItensViewLOCFIS_NOV: TcxGridDBColumn;
    cxgItensViewLOCSUP: TcxGridDBColumn;
    cxgItensViewLOCSUP_NOV: TcxGridDBColumn;
    cxgItensViewITEBAS: TcxGridDBColumn;
    cxgItensViewITEBAS_NOV: TcxGridDBColumn;
    cxgItensViewITEPIG: TcxGridDBColumn;
    cxgItensViewITEPIG_NOV: TcxGridDBColumn;
    cxgItensViewCPRCEN: TcxGridDBColumn;
    cxgItensViewCPRCEN_NOV: TcxGridDBColumn;
    cxgItensViewCODMON: TcxGridDBColumn;
    cxgItensViewCODMON_NOV: TcxGridDBColumn;
    cxgItensViewBAREXP: TcxGridDBColumn;
    cxgItensViewBAREXP_NOV: TcxGridDBColumn;
    cxgItensViewMARCADO: TcxGridDBColumn;
    cxItensInsViewCodIte: TcxGridDBColumn;
    cxItensInsViewDesIte: TcxGridDBColumn;
    cxItensInsViewCodFab: TcxGridDBColumn;
    cxItensInsViewCODFOR_NOV: TcxGridDBColumn;
    cxItensInsViewCODDEP_NOV: TcxGridDBColumn;
    cxItensInsViewCODGRU_NOV: TcxGridDBColumn;
    cxItensInsViewDESFAB_NOV: TcxGridDBColumn;
    cxItensInsViewCODMAR_NOV: TcxGridDBColumn;
    cxItensInsViewREFERE_NOV: TcxGridDBColumn;
    cxItensInsViewCODUNI_NOV: TcxGridDBColumn;
    cxItensInsViewUNICOM_NOV: TcxGridDBColumn;
    cxItensInsViewCODABF_NOV: TcxGridDBColumn;
    cxItensInsViewABFPIS_NOV: TcxGridDBColumn;
    cxItensInsViewABFCOF_NOV: TcxGridDBColumn;
    cxItensInsViewABFIPI_NOV: TcxGridDBColumn;
    cxItensInsViewIPISAI_NOV: TcxGridDBColumn;
    cxItensInsViewINCPIS_NOV: TcxGridDBColumn;
    cxItensInsViewCLAIPI_NOV: TcxGridDBColumn;
    cxItensInsViewEXCIPI_NOV: TcxGridDBColumn;
    cxItensInsViewCDCEST_NOV: TcxGridDBColumn;
    cxItensInsViewCODONU_NOV: TcxGridDBColumn;
    cxItensInsViewIMPLIS_NOV: TcxGridDBColumn;
    cxItensInsViewITEATI_NOV: TcxGridDBColumn;
    cxItensInsViewATICOM_NOV: TcxGridDBColumn;
    cxItensInsViewPESOIT_NOV: TcxGridDBColumn;
    cxItensInsViewPESLIQ_NOV: TcxGridDBColumn;
    cxItensInsViewCODGPR_NOV: TcxGridDBColumn;
    cxItensInsViewPRDGRU_NOV: TcxGridDBColumn;
    cxItensInsViewGRUCMP_NOV: TcxGridDBColumn;
    cxItensInsViewMLTVEN_NOV: TcxGridDBColumn;
    cxItensInsViewMLTCOM_NOV: TcxGridDBColumn;
    cxItensInsViewNVLGIR_NOV: TcxGridDBColumn;
    cxItensInsViewNIVGIR_NOV: TcxGridDBColumn;
    cxItensInsViewACOOBJ_NOV: TcxGridDBColumn;
    cxItensInsViewAPLICA_NOV: TcxGridDBColumn;
    cxItensInsViewPRECOM_NOV: TcxGridDBColumn;
    cxItensInsViewDESF01_NOV: TcxGridDBColumn;
    cxItensInsViewDESF02_NOV: TcxGridDBColumn;
    cxItensInsViewDESF03_NOV: TcxGridDBColumn;
    cxItensInsViewDESF04_NOV: TcxGridDBColumn;
    cxItensInsViewDESF05_NOV: TcxGridDBColumn;
    cxItensInsViewDESF06_NOV: TcxGridDBColumn;
    cxItensInsViewICMENT_NOV: TcxGridDBColumn;
    cxItensInsViewSUBFED_NOV: TcxGridDBColumn;
    cxItensInsViewIPIENT_NOV: TcxGridDBColumn;
    cxItensInsViewFREENT_NOV: TcxGridDBColumn;
    cxItensInsViewVALFRE_NOV: TcxGridDBColumn;
    cxItensInsViewACRFIN_NOV: TcxGridDBColumn;
    cxItensInsViewSUBSTI_NOV: TcxGridDBColumn;
    cxItensInsViewDESADB_NOV: TcxGridDBColumn;
    cxItensInsViewOUTVAL_NOV: TcxGridDBColumn;
    cxItensInsViewICMSAI_NOV: TcxGridDBColumn;
    cxItensInsViewIMPFED_NOV: TcxGridDBColumn;
    cxItensInsViewDESOPE_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR1_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB1_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE1_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR2_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB2_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE2_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR3_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB3_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE3_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR4_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB4_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE4_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR5_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB5_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE5_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR6_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB6_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE6_NOV: TcxGridDBColumn;
    cxItensInsViewMARBR7_NOV: TcxGridDBColumn;
    cxItensInsViewCOMTB7_NOV: TcxGridDBColumn;
    cxItensInsViewPREVE7_NOV: TcxGridDBColumn;
    cxItensInsViewCOMVAR_NOV: TcxGridDBColumn;
    cxItensInsViewCOMATA_NOV: TcxGridDBColumn;
    cxItensInsViewCOMDIS_NOV: TcxGridDBColumn;
    cxItensInsViewCOMPRO_NOV: TcxGridDBColumn;
    cxItensInsViewDESMAX_NOV: TcxGridDBColumn;
    cxItensInsViewDESMSU_NOV: TcxGridDBColumn;
    cxItensInsViewDESMGE_NOV: TcxGridDBColumn;
    cxItensInsViewMARMIN_NOV: TcxGridDBColumn;
    cxItensInsViewMARMSG_NOV: TcxGridDBColumn;
    cxItensInsViewMARMGE_NOV: TcxGridDBColumn;
    cxItensInsViewTMPGAR_NOV: TcxGridDBColumn;
    cxItensInsViewINFGAR_NOV: TcxGridDBColumn;
    cxItensInsViewLOCFIS_NOV: TcxGridDBColumn;
    cxItensInsViewLOCSUP_NOV: TcxGridDBColumn;
    cxItensInsViewITEBAS_NOV: TcxGridDBColumn;
    cxItensInsViewITEPIG_NOV: TcxGridDBColumn;
    cxItensInsViewCPRCEN_NOV: TcxGridDBColumn;
    cxItensInsViewCODMON_NOV: TcxGridDBColumn;
    cxItensInsViewBAREXP_NOV: TcxGridDBColumn;
    cxItensInsViewEXPSIT_NOV: TcxGridDBColumn;
    cxItensInsViewDSSITE_NOV: TcxGridDBColumn;
    cxItensInsViewDADTEC_NOV: TcxGridDBColumn;
    cxItensInsViewURLIMG_NOV: TcxGridDBColumn;
    cxItensInsViewNOMITE_NOV: TcxGridDBColumn;
    cxItensInsViewAPLITE_NOV: TcxGridDBColumn;
    cxItensInsViewINCLUS_NOV: TcxGridDBColumn;
    cxItensInsViewEXPALT_NOV: TcxGridDBColumn;
    cxItensInsViewEXPLAR_NOV: TcxGridDBColumn;
    cxItensInsViewEXPPRO_NOV: TcxGridDBColumn;
    cxItensInsViewDESSIT_NOV: TcxGridDBColumn;
    cxItensInsViewCODCAT_NOV: TcxGridDBColumn;
    cxItensInsViewDESTAQ_NOV: TcxGridDBColumn;
    cxItensInsViewATZPRE_NOV: TcxGridDBColumn;
    cxItensInsViewEXPAPP_NOV: TcxGridDBColumn;    
    cxgItensViewCODLSE: TcxGridDBColumn;
    cxgItensViewCODLSE_NOV: TcxGridDBColumn;
    cxgItensInsViewCODLSE_NOV: TcxGridDBColumn;
    cxgItensViewCodBar: TcxGridDBColumn;
    cxItensInsViewCodBar: TcxGridDBColumn;
    dtsDadosIns: TDataSource;
    cxItensInsert: TcxGrid;
    cxItensIns: TcxGridDBTableView;
    cxItensInsLlv: TcxGridLevel;
    btnRelProdCad: TBitBtnLocked;
    frxItensInsert: TfrxReport;
    Panel1: TPanel;
    cxgItensViewDESITE_NOV: TcxGridDBColumn;
    cxgItensViewCODFOR_NOV: TcxGridDBColumn;
    cxgItensViewCODBAR_NOV: TcxGridDBColumn;
    cxgItensViewCODFAB_NOV: TcxGridDBColumn;
    cxgItensViewEXPSIT: TcxGridDBColumn;
    cxgItensViewEXPSIT_NOV: TcxGridDBColumn;
    cxgItensViewDSSITE: TcxGridDBColumn;
    cxgItensViewDSSITE_NOV: TcxGridDBColumn;
    cxgItensViewDADTEC: TcxGridDBColumn;
    cxgItensViewDADTEC_NOV: TcxGridDBColumn;
    cxgItensViewURLIMG: TcxGridDBColumn;
    cxgItensViewURLIMG_NOV: TcxGridDBColumn;
    cxgItensViewNOMITE: TcxGridDBColumn;
    cxgItensViewNOMITE_NOV: TcxGridDBColumn;
    cxgItensViewAPLITE: TcxGridDBColumn;
    cxgItensViewAPLITE_NOV: TcxGridDBColumn;
    cxgItensViewINCLUS: TcxGridDBColumn;
    cxgItensViewINCLUS_NOV: TcxGridDBColumn;
    cxgItensViewEXPALT: TcxGridDBColumn;
    cxgItensViewEXPALT_NOV: TcxGridDBColumn;
    cxgItensViewEXPLAR: TcxGridDBColumn;
    cxgItensViewEXPLAR_NOV: TcxGridDBColumn;
    cxgItensViewEXPPRO: TcxGridDBColumn;
    cxgItensViewEXPPRO_NOV: TcxGridDBColumn;
    cxgItensViewDESSIT: TcxGridDBColumn;
    cxgItensViewDESSIT_NOV: TcxGridDBColumn;
    cxgItensViewCODCAT: TcxGridDBColumn;
    cxgItensViewCODCAT_NOV: TcxGridDBColumn;
    cxgItensViewDESTAQ: TcxGridDBColumn;
    cxgItensViewDESTAQ_NOV: TcxGridDBColumn;
    cxgItensViewEXPAPP: TcxGridDBColumn;
    cxgItensViewEXPAPP_NOV: TcxGridDBColumn;
    Label1: TLabel;
    cxgItensViewLIS_CODFOR: TcxGridDBColumn;
    cxgItensViewLIS_CODFAB: TcxGridDBColumn;
    cxgItensViewLIS_CODCNA: TcxGridDBColumn;
    cxgItensViewESTMIN: TcxGridDBColumn;
    cxgItensViewESTMIN_NOV: TcxGridDBColumn;
    cxgItensViewESTMAX: TcxGridDBColumn;
    cxgItensViewESTMAX_NOV: TcxGridDBColumn;
    cxItensInsESTMIN_NOV: TcxGridDBColumn;
    cxItensInsESTMAX_NOV: TcxGridDBColumn;
    cxgItensInsLIS_CODFOR: TcxGridDBColumn;
    cxgItensInsLIS_CODFAB: TcxGridDBColumn;
    cxgItensInsLIS_CODCNA: TcxGridDBColumn;
    cxgItensViewTCIFCU: TcxGridDBColumn;
    cxgItensViewTCIFCU_NOV: TcxGridDBColumn;
    cxgItensViewTSCUST: TcxGridDBColumn;
    cxgItensViewTSCUST_NOV: TcxGridDBColumn;
    cxgItensView_DEPICO: TcxGridDBColumn;
    cxgItensViewDEPICO_NOV: TcxGridDBColumn;
    cxgItensViewDEICMS: TcxGridDBColumn;
    cxgItensViewDEICMS_NOV: TcxGridDBColumn;
    cxgItensViewFATREG: TcxGridDBColumn;
    cxgItensViewFATREG_NOV: TcxGridDBColumn;
    cxItensInsViewTCIFCU_NOV: TcxGridDBColumn;
    cxItensInsViewTSCUST_NOV: TcxGridDBColumn;
    cxItensInsViewDEPICO_NOV: TcxGridDBColumn;
    cxItensInsViewDEICMS_NOV: TcxGridDBColumn;
    cxItensInsViewFATREG_NOV: TcxGridDBColumn;
    cxgEmbalaCodBar: TcxGridDBColumn;
    cxgEmbalaDescri: TcxGridDBColumn;
    cxgEmbalaEmbala: TcxGridDBColumn;
    cxgEmbalaPreVen: TcxGridDBColumn;
    cxgEmbalaPrinci: TcxGridDBColumn;
    cxgEmbalaCompra: TcxGridDBColumn;
    cxgEmbalaViewBAR_ALTURA: TcxGridDBColumn;
    cxgEmbalaViewBAR_LARGUR: TcxGridDBColumn;
    cxgEmbalaViewBAR_PROFUN: TcxGridDBColumn;
    cxgEmbalaViewBAR_LASTRO: TcxGridDBColumn;
    cxgEmbalaViewBAR_CAMADA: TcxGridDBColumn;
    cxgEmbalaViewBAR_EMPMAX: TcxGridDBColumn;
    cxgEmbalaViewBAR_PESOBR: TcxGridDBColumn;
    cxgEmbalaViewBAR_PESOLQ: TcxGridDBColumn;
    cxgEmbalaExbFat: TcxGridDBColumn;
    cxgEmbalaCODFOR: TcxGridDBColumn;

    dtsEmbalagens: TDataSource;
    cxgEmbala: TcxGridCitel;
    cxgEmbalaView: TcxGridDBTableViewCitel;
    cxgEmbalaLevel1: TcxGridLevel;
    chkExibirEmbala: TCheckBox;
    cxgItensViewUNITRI: TcxGridDBColumn;
    cxgItensViewUNITRI_NOV: TcxGridDBColumn;
    cxgItensViewEXPPOK: TcxGridDBColumn;
    cxgItensViewEXPPOK_NOV: TcxGridDBColumn;
    cxgItensViewTIPPRO: TcxGridDBColumn;
    cxgItensViewTIPPRO_NOV: TcxGridDBColumn;
    cxgItensViewINDREV: TcxGridDBColumn;
    cxgItensViewINDREV_NOV: TcxGridDBColumn;
    cxgItensViewIMPDIR: TcxGridDBColumn;
    cxgItensViewIMPDIR_NOV: TcxGridDBColumn;

    cxItensInsUNITRI_NOV: TcxGridDBColumn;
    cxItensInsEXPPOK_NOV: TcxGridDBColumn;
    cxItensInsTIPPRO_NOV: TcxGridDBColumn;
    cxItensInsINDREV_NOV: TcxGridDBColumn;
    cxItensInsIMPDIR_NOV: TcxGridDBColumn;
    cxItensInsMSGLV1_NOV: TcxGridDBColumn;
    cxItensInsMSGLV2_NOV: TcxGridDBColumn;
    cxItensInsPEEFUT_NOV: TcxGridDBColumn;
    cxItensInsPEFUTP_NOV: TcxGridDBColumn;
    cxItensInsPEFFPR_NOV: TcxGridDBColumn;
    cxgItensViewMSGLV1: TcxGridDBColumn;
    cxgItensViewMSGLV1_NOV: TcxGridDBColumn;
    cxgItensViewMSGLV2: TcxGridDBColumn;
    cxgItensViewMSGLV2_NOV: TcxGridDBColumn;
    cxgItensViewPEEFUT: TcxGridDBColumn;
    cxgItensViewPEEFUT_NOV: TcxGridDBColumn;
    cxgItensViewPEFUTP: TcxGridDBColumn;
    cxgItensViewPEFUTP_NOV: TcxGridDBColumn;
    cxgItensViewPEFFPR: TcxGridDBColumn;
    cxgItensViewPEFFPR_NOV: TcxGridDBColumn;
    cxItensInsLIS_ESMIDG_NOV: TcxGridDBColumn;
    cxItensInsLIS_ESTMIN_NOV: TcxGridDBColumn;
    cxItensInsLIS_ESTMAX_NOV: TcxGridDBColumn;
    cxgItensViewLIS_ESMIDG: TcxGridDBColumn;
    cxgItensViewLIS_ESTMIN: TcxGridDBColumn;
    cxgItensViewLIS_ESTMAX: TcxGridDBColumn;
    cxgItensViewLIS_SITPRO: TcxGridDBColumn;
    cxItensInsLIS_SITPRO_NOV: TcxGridDBColumn;
    cxItensInsDESSIM_NOV: TcxGridDBColumn;
    cxgItensViewDESSIM: TcxGridDBColumn;
    cxgItensViewDESSIM_NOV: TcxGridDBColumn;
    frxRelatorioPrecComReduzido: TfrxReport;
    btnRelSemReducao: TBitBtnLocked;
    cxgItensViewTIPFRE: TcxGridDBColumn;
    cxgItensViewVLCFRE: TcxGridDBColumn;
    cxgItensViewTIPFRE_NOV: TcxGridDBColumn;
    cxgItensViewVLCFRE_NOV: TcxGridDBColumn;
    cxItensInsTIPFRE_NOV: TcxGridDBColumn;
    cxItensInsVLCFRE_NOV: TcxGridDBColumn;
    cxgItensViewQRCODE: TcxGridDBColumn;
    cxgItensViewQRCODE_NOV: TcxGridDBColumn;
    cxItensInsQRCODE_NOV: TcxGridDBColumn;
    cxItensInsEXPB2B_NOV: TcxGridDBColumn;
    cxgItensViewEXPB2B: TcxGridDBColumn;
    cxgItensViewEXPB2B_NOV: TcxGridDBColumn;
    cxItensInsPRAVAL_NOV: TcxGridDBColumn;
    cxgItensViewPRAVAL: TcxGridDBColumn;
    cxgItensViewPRAVAL_NOV: TcxGridDBColumn;
    cxItensInsITE_NVLCRI: TcxGridDBColumn;
    cxItensInsITE_NVLCRI_NOV: TcxGridDBColumn;
    cxgItensViewITE_NVLCRI: TcxGridDBColumn;
    cxgItensViewITE_NVLCRI_NOV: TcxGridDBColumn;
    cxItensInsLIS_ABVFIS_NOV: TcxGridDBColumn;
    cxgItensViewLIS_ABVFIS: TcxGridDBColumn;
    cdsItensInseridos: TUniClientDataSet;
    cdsItensInseridosCODFOR: TStringField;
    cdsItensInseridosCODFAB: TStringField;
    cdsItensInseridosDESITE: TStringField;
    cdsItensInseridosCODBAR: TStringField;
    cxgItensViewRECDEV: TcxGridDBColumn;
    cxgItensViewRECDEV_NOV: TcxGridDBColumn;
    cxItensInsRECDEV_NOV: TcxGridDBColumn;
    cxgItensViewVALOBR: TcxGridDBColumn;
    cxgItensViewVALOBR_NOVO: TcxGridDBColumn;
    cxItensInsVALOBR_NOV: TcxGridDBColumn;
    cxgItensViewCOMPOS: TcxGridDBColumn;
    cxgItensViewCOMPOS_NOVO: TcxGridDBColumn;
    cxgItensViewITESAC: TcxGridDBColumn;
    cxgItensViewITESAC_NOVO: TcxGridDBColumn;
    cxgItensViewPAISOR: TcxGridDBColumn;
    cxgItensViewPAISOR_NOVO: TcxGridDBColumn;
    cxItensInsCOMPOS_NOV: TcxGridDBColumn;
    cxItensInsITESAC_NOV: TcxGridDBColumn;
    cxItensInsPAISOR_NOV: TcxGridDBColumn;
    cxgItensViewPRAPEL: TcxGridDBColumn;
    cxgItensViewPRAPEL_NOVO: TcxGridDBColumn;
    cxItensInsPRAPEL_NOV: TcxGridDBColumn;
    btnVariacao: TBitBtnLocked;
    lstTabPreco: TCheckListBox;
    Panel3: TPanel;
    btnMarcar: TBitBtnLocked;
    btnMarcAll: TBitBtnLocked;
    btnDesmAll: TBitBtnLocked;
    btnAlterarMargens: TBitBtnLocked;
    btnAlterarPrecosVenda: TBitBtnLocked;
    cxgItensViewCODATC: TcxGridDBColumn;
    cxgItensViewCODATC_NOV: TcxGridDBColumn;
    cxItensInsMARCADO: TcxGridDBColumn;
    cxgItensViewMARID1: TcxGridDBColumn;
    cxgItensViewMARID1_NOV: TcxGridDBColumn;
    cxgItensViewMARID2: TcxGridDBColumn;
    cxgItensViewMARID2_NOV: TcxGridDBColumn;
    cxgItensViewMARID3: TcxGridDBColumn;
    cxgItensViewMARID3_NOV: TcxGridDBColumn;
    cxgItensViewMARID4: TcxGridDBColumn;
    cxgItensViewMARID4_NOV: TcxGridDBColumn;
    cxgItensViewMARID5: TcxGridDBColumn;
    cxgItensViewMARID5_NOV: TcxGridDBColumn;
    cxgItensViewMARID6: TcxGridDBColumn;
    cxgItensViewMARID6_NOV: TcxGridDBColumn;
    cxgItensViewMARID7: TcxGridDBColumn;
    cxgItensViewMARID7_NOV: TcxGridDBColumn;
    cxItensInsMARID1_NOV: TcxGridDBColumn;
    cxItensInsMARID2_NOV: TcxGridDBColumn;
    cxItensInsMARID3_NOV: TcxGridDBColumn;
    cxItensInsMARID4_NOV: TcxGridDBColumn;
    cxItensInsMARID5_NOV: TcxGridDBColumn;
    cxItensInsMARID6_NOV: TcxGridDBColumn;
    cxItensInsMARID7_NOV: TcxGridDBColumn;
    cxItensInsQTDPES_NOV: TcxGridDBColumn;
    cxItensInsPORPES_NOV: TcxGridDBColumn;
    cxgItensViewQTDPES: TcxGridDBColumn;
    cxgItensViewQTDPES_NOV: TcxGridDBColumn;
    cxgItensViewPORPES: TcxGridDBColumn;
    cxgItensViewPORPES_NOV: TcxGridDBColumn;
    cxItensInsPER_CI_NOV: TcxGridDBColumn;
    cxItensInsNUMFCI_NOV: TcxGridDBColumn;
    cxgItensViewPER_CI_NOV: TcxGridDBColumn;
    cxgItensViewNUMFCI_NOV: TcxGridDBColumn;
    cxgItensViewFATUTR: TcxGridDBColumn;
    cxgItensViewFATUTR_NOV: TcxGridDBColumn;
    cxItensInsFATUTR: TcxGridDBColumn;
    dtsEmbDescFech: TDataSource;
    cxItensInsITEEMB_NOV: TcxGridDBColumn;
    cxItensITEEMB_NOV: TcxGridDBColumn;
    cxItensITEEMB: TcxGridDBColumn;
    cxgItensViewCEREPI: TcxGridDBColumn;
    cxgItensViewCEREPI_NOV: TcxGridDBColumn;
    cxItensInsCEREPI_NOV: TcxGridDBColumn;
    cxItensInsMARPAD_NOV: TcxGridDBColumn;
    cxgItensViewMARPAD: TcxGridDBColumn;
    cxgItensViewMARPAD_NOV: TcxGridDBColumn;
    cxItensInsLIS_TPESTM: TcxGridDBColumn;
    cxgItensViewLIS_TPESTM: TcxGridDBColumn;
    cxItensInsLIS_ABFPIS_NOV: TcxGridDBColumn;
    cxItensInsLIS_ABFCOF_NOV: TcxGridDBColumn;
    cxgItensViewLIS_ABFPIS: TcxGridDBColumn;
    cxgItensViewLIS_ABFCOF: TcxGridDBColumn;
    function  fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
    function  fAtualizaCampos(pgbProgresso: TcxProgressBar): Boolean;
    function  fRecalculaPreco(pgbProgresso: TcxProgressBar): Boolean;
    function  fInsereProdutos(pgbProgresso: TcxProgressBar): Boolean;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnVisProdNaoImpClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure btnRelProdCadClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmAllClick(Sender: TObject);
    procedure btnMarcAllClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgEmbalaViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxgItensViewDataControllerFilterChanged(Sender: TObject);
    procedure cxItensInsDataControllerFilterChanged(Sender: TObject);
    procedure pgcContainerChange(Sender: TObject);
    procedure chkExibirEmbalaClick(Sender: TObject);
    procedure cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxItensInsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure btnRelSemReducaoClick(Sender: TObject);
    function frxRelatorioPrecComReduzidoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure btnVariacaoClick(Sender: TObject);
    procedure btnAlterarMargensClick(Sender: TObject);
    procedure btnAlterarPrecosVendaClick(Sender: TObject);

  private
    blnGravando: Boolean;
    strAutLogCap: String;
    cdsDadosAlt,
    cdsDadosIns,
    cdsDadosPrecoReduzido,
    cdsDadosEmbalagem,
    cdsDadosEmbDescFech,
    cdsListasIteger,
    cdsRelatorio: TZClient;
    qryCRUD,
    qryEmpresa,
    qryLog: TUniQuery;
    FLista: TStringList;
    intPrimeiroAno: Integer;
    strCodIte: String;
    blnTabPrf,
    blnURapel,
    blnUtiPreIte: Boolean;
    blnMarcar: Boolean;
    blnPreMat: Boolean;
    blnProdutoNaoCadastrado: Boolean;
    dtaDtaAltera: TDate;
    gerRect: TRect;
    strTabelaPrecoAtiva: String;
    RecalculoGeral: TRecalculoGeral;
    fltValorNovo: Double;
    FDataInicioGravacao: TDateTime;
    strTipAbf: String;

    { Private declarations }
    function fConfirmaData: Boolean;
    function fTemTabelasMarcadas: Boolean;
    function fVerificaTabelaMarcada(intTabelaPreco: integer): Boolean;


    function fProcessar(qryManipulada: TUniQuery): Boolean;
    function  fAtualizaCamposAux(qryManipulada: TUniQuery): boolean;
    function  fDesiteExite(AstrCodIte: String; qryManipulada: TUniQuery): boolean;
    procedure pAtualizaListaIteger(strCodite: String; qryManipulada: TUniQuery);
    function  fInsereProdutosAux(qryManipulada: TUniQuery): boolean;
    procedure pIncluiMontadora(qryManipulada: TUniQuery; cdsProcesso: TZClient);
    procedure pIncluiEmbalagens(qryManipulada: TUniQuery; cdsProcesso: TZClient);
    procedure pIncluiEmbDescFech(qryManipulada: TUniQuery; cdsProcesso: TZClient);
    procedure pIncluiITEFOR(qryManipulada: TUniQuery; cdsProcesso: TZClient);
    procedure pMontarGrid;
    procedure pGeraGirIte;
    Function  fRetPrimeiroAnoGiro: Integer;
    procedure pMarcaDesmarcaTodos(blnMarca: boolean);
    function  fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
    function fFornecedorJaRelacionadoComItem(strCodFor: string): Boolean;
    procedure pExibeEmbalagens(AFocusedRecord: TcxCustomGridRecord);
    function fRetFornecedor(strCodForOld, strCodForNew: String): String;
    function  fItemJaInserido: Boolean;
    function fRetTabelaPrecoByInt(int: integer): TTabelaDePrecoLista;

  private
    FstrPath,
    FPreVenMarbruSel,
    FstrBlnRedPrecoVenda: string;
    procedure pSetaTipoPrecoEmbalagem;
    procedure pInsereLogAltCamposImportacao;
    function fCompararCampos(objCampoAntigo, objCampoNovo: TField): Boolean;
    procedure pGravaLogAlteracaoCPR(strCodIte, strNomCam: String; varValorNovo,
      varValorAntigo: Variant; objTipo: TFieldType);
    procedure pInsereLogCamposImportacao;
    procedure pInsereLogCap;
    procedure pAlteraValores(blnMargem: Boolean);
    procedure pIncluiITEURL(qryManipulada: TUniQuery; strCodIte, strEndere , strDescri, strAcao : String);
    function fURLJaCadastradaComItem(strCodIte, strEndere, strDescri: string): Boolean;

  public
    strArqCSV: String;
    strPath,
    strPreVen,
    strNdeDuz: String;
    blnPrecoVenda: Boolean;
    blnProCod: Boolean;
    intArredondamento : integer;
    function fExibirTela(cdsDados, cdsEmbalagem, cdsItensEmbDescFech, cdsListas: TZClient; strPath, PreVenMarbruSel, strBlnRedPrecoVenda: String ): integer;
    class function fGetvalor(cdsItens: TZClient; strNomCam: String): Double;
    class function fGetvalorStr(cdsItens: TZClient; strNomCam: String): String;
    class function fGetIcmsSTParteVenda(strEstEmp, strMarMkp: String; var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;


    { Public declarations }
  end;

var
  frmImportCadProdutoConfirma: TfrmImportCadProdutoConfirma;

implementation

{$R *.dfm}

uses untGravando, untPreAlt, untAltPrecoDigData, untAltEfetivacaoPrecos,
  untCadLote, untSaldoPedidoCompra, untIIteBar, untIteBar, untTypesSistema,
  untImportCadProdutoVariacaoPreVen, untIFuncoes, untDigValor,
  untController.CheckListGarantia,
  untIcmsSTParteVenda, untTDescEmbalagemFechada;

{ TfrmImportCadProdutoConfirma }

Function TfrmImportCadProdutoConfirma.fConfirmaData: Boolean;
  Var strMensagem: String;
Begin
  Result := False;
  If ((cdsDadosAlt.IsEmpty) and (cdsDadosIns.IsEmpty)) Then
  Begin
    fMensagem('Aviso', 'Não há dados para serem processados!', ['&O k']);
    exit;
  End;
  If (Not cdsDadosIns.IsEmpty) And (blnPreMat) Then
  Begin
    If (fMensagem('Aviso', 'Cadastro de Itens permitido somente na Loja Matriz!', ['&Prosseguir', '&Cancelar']) = 2) Then
      Exit;
  end;

  Try
    cdsDadosAlt.Filtered := False;
    cdsDadosAlt.Filter := 'IMPORT = 1 AND MARCADO = 1 AND ALTPRE = 1 AND SEMRED = 0';
    cdsDadosAlt.Filtered := True;

    //Se não houve alteração de preço não pede a data
    If cdsDadosAlt.isEmpty Then
    Begin
      dtaDtaAltera := fNow;
      blnUtiPreIte := false;
      Exit(True);
    End;

  pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);
    frmAltPrecoDigData.Showmodal;
    If frmAltPrecoDigData.blnConfirma Then
    Begin
      If (frmAltPrecoDigData.dtaData = VS_Date) Then
        strMensagem := 'Os preços serão agendados para hoje. Confirma?'
      Else
        strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';
      Result := fMensagem('Confirmação' ,strMensagem, ['&Sim','&Não']) = 1;
    End;

    dtaDtaAltera := frmAltPrecoDigData.dtaData;
    blnUtiPreIte := True;
  Finally
    cdsDadosAlt.Filtered := False;
    cdsDadosAlt.Filter := 'IMPORT = 1 AND MARCADO = 1';
    cdsDadosAlt.Filtered := True;

    FreeAndNil(frmAltPrecoDigData);
  End;
End;

function TfrmImportCadProdutoConfirma.fDesiteExite(AstrCodIte: String; qryManipulada: TUniQuery): boolean;
begin
  qryManipulada.SQL.Clear;
  qryManipulada.SQL.Add('SELECT COUNT(1) AS QTD FROM DESSIT WHERE ITE_CODITE = ' +QuotedStr(AStrCodIte));
  qryManipulada.Open;
  Result := qryManipulada.FieldByName('QTD').AsFloat > 0;
  qryManipulada.SQL.Clear;
end;

procedure TfrmImportCadProdutoConfirma.btnRelSemReducaoClick(Sender: TObject);
begin
  inherited;

  If (Not(cdsDadosPrecoReduzido.IsEmpty)) Then
  Begin
    frxRelatorio.DataSet:= cdsDadosPrecoReduzido;
    frxRelatorioPrecComReduzido.AddFunction('function fRetFornecedor(strCodForOld, strCodForNew: String): String;');
    frxRelatorioPrecComReduzido.Script.Variables['NOMREL'] := 'PRODUTOS QUE NÃO TIVERAM REDUÇÃO NO PREÇO DE COMPRA';
    TfrxMemoView(frxRelatorioPrecComReduzido.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

    TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHederMargem')).Memo.Clear;
    TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHeaderPrev')).Memo.Clear;

    TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHederMargem')).Memo.Add('MARGEM '+strTabelaPrecoAtiva);
    TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHeaderPrev')).Memo.Add('PRE. DE VENDA '+strTabelaPrecoAtiva);

    TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memPreVen')).Memo.Add('[IIF(<frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'_NOV"> > 0, <frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'_NOV">, <frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'">)]');
    TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memMargem')).Memo.Add('[IIF(<frxRelatorio."ITE_MARBR'+strTabelaPrecoAtiva+'_NOV"> > 0, <frxRelatorio."ITE_MARBR'+strTabelaPrecoAtiva+'_NOV">, <frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'">)]');

    pPreviewReport(Self.Name, 'Produtos que não tiveram redução no preço de compra', frxRelatorioPrecComReduzido);
  End;

end;

procedure TfrmImportCadProdutoConfirma.btnAlterarMargensClick(Sender: TObject);
begin
  inherited;
  If Not fTemTabelasMarcadas Then
  begin
    fMensagem('Aviso', 'É preciso marcar ao menos uma tabela para ser alterada!', ['&O k']);
    pSetFocus(lstTabPreco);
    Exit;
  End;
  pAlteraValores(True);


end;

procedure TfrmImportCadProdutoConfirma.btnAlterarPrecosVendaClick(Sender: TObject);
begin
  If Not fTemTabelasMarcadas Then
  begin
    fMensagem('Aviso', 'É preciso marcar ao menos uma tabela para ser alterada!', ['&O k']);
    pSetFocus(lstTabPreco);
    Exit;
  End;

  pAlteraValores(False);

end;

procedure TfrmImportCadProdutoConfirma.pAlteraValores(blnMargem: Boolean);
var fltValor: Double;
    frmRecalculo: TFrmGravando;
    strMascara : String;
begin
  if intArredondamento <> 2 Then
    strMascara := fMskDigitos(intArredondamento)
  else
    strMascara := '#,##0.00';

  If TfrmDigValor.fDigitaValor(fltValor,
                               'Digite o Novo Valor',
                               strMascara,
                               True,
                               False) Then
  Begin
    If blnMargem Then
      RecalculoGeral:= rgMargem
    Else
      RecalculoGeral:= rgPrecoVenda;
    fltValorNovo := fltValor;
    pCriarFormularios(TfrmGravando, frmRecalculo);
    Try
      frmRecalculo.fExecutarAcao := fRecalculaPreco;
      frmRecalculo.lblGravando.Caption := 'Aguarde... Recalculando '+ IIf(RecalculoGeral = rgPrecoVenda, 'Preço de Venda', 'Margem');
      frmRecalculo.Showmodal;
    Finally
      pFreeAndNil(frmRecalculo);
    end;


  End;
End;

function TfrmImportCadProdutoConfirma.fTemTabelasMarcadas: Boolean;
var i: integer;
Begin
  Result := False;
  For i := 0 To lstTabPreco.Count -1 do
  Begin
    If lstTabPreco.Checked[i] Then
      Exit(True);
  End;
End;

function TfrmImportCadProdutoConfirma.fVerificaTabelaMarcada(
  intTabelaPreco: integer): Boolean;
  var i: integer;
begin
  Result := False;
  For i := 0 To lstTabPreco.Count -1 do
  Begin
    If lstTabPreco.Checked[i] then
     If TObjTabela(lstTabPreco.Items.Objects[i]).TabelaDePrecoLista = fRetTabelaPrecoByInt(intTabelaPreco) Then
     Begin
       Result := True;
       Exit;
     End;

  End;
end;

procedure TfrmImportCadProdutoConfirma.btnConfirmaClick(Sender: TObject);
var  frmIns: TfrmGravando;
     frmAlt: TfrmGravando;
     frmAltTab: TfrmGravando;
     qtdDadosAlt: Integer;
begin
  Try
    blnGravando := True;
    pInsereLogCap;
//    cdsDadosAlt.AfterScroll := nil;
//    cdsDadosIns.AfterScroll := nil;
    cxgEmbala.Visible := False;

    cdsDadosIns.Filtered := False;
    cdsDadosIns.Filter := 'IMPORT = 0 AND MARCADO = 1 AND SEMRED = 0';
    cdsDadosIns.Filtered := True;
    FDataInicioGravacao := fNow;
    If (Not cdsDadosIns.IsEmpty)  And  (Not blnPreMat)  Then
    Begin
      pCriarFormularios(TfrmGravando, frmIns);
      Try
        frmIns.fExecutarAcao := fInsereProdutos;
        frmIns.lblGravando.Caption := 'Aguarde... Cadastrando Produtos';
        frmIns.Showmodal
      Finally
        pFreeAndNil(frmIns);
      End;

      If cdsDadosAlt.IsEmpty Then
      Begin
        fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);
        Close;
      End;
    End;
    //Caso nenhum registro foi selecionado para ser atualizado
    cdsDadosAlt.DisableControls;
    Try

      qtdDadosAlt := cdsDadosAlt.RecordCount;
      cdsDadosAlt.Filtered := False;
      cdsDadosAlt.Filter := 'IMPORT = 1 AND MARCADO = 1 AND SEMRED = 0';
      cdsDadosAlt.Filtered := True;

      If (qtdDadosAlt > 0) And (cdsDadosAlt.IsEmpty) Then
      Begin
        fMensagem('Atenção', 'Nenhum produto foi marcado para ser atualizado.', ['&O k']);
        cdsDadosAlt.Filtered := False;
        cdsDadosAlt.Filter := 'IMPORT = 1 AND SEMRED = 0';
        cdsDadosAlt.Filtered := True;
        Exit;
      End;
      If Not cdsDadosAlt.IsEmpty Then
      Begin
        If fConfirmaData then
        Begin
          Try
            pCriarFormularios(TfrmGravando, frmAlt);
            Try
              frmAlt.fExecutarAcao := fAtualizaCampos;
              frmAlt.lblGravando.Caption := 'Aguarde... Atualizando cadastro de produto';
              frmAlt.Showmodal;
            Finally
              pFreeAndNil(frmAlt);
            end;

            pCriarFormularios(TfrmGravando, frmAltTab);
            Try
              frmAltTab.fExecutarAcao := fAlterarTabelas;
              frmAltTab.lblGravando.Caption := 'Aguarde... Criando agendamento das alterações de preços';
              frmAltTab.Showmodal;
            Finally
              pFreeAndNil(frmAltTab);
            End;


            If blnUtiPreIte Then
            Begin
            pCriarFormularios(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
            Try
              frmAltEfetivacaoPrecos.Showmodal;

            //  If frmAltEfetivacaoPrecos.ModalResult = mrOk Then
              Begin
                fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);

                If (Not(cdsDadosPrecoReduzido.IsEmpty)) Then
                Begin
                  frxRelatorio.DataSet:= cdsDadosPrecoReduzido;
                  frxRelatorioPrecComReduzido.AddFunction('function fRetFornecedor(strCodForOld, strCodForNew: String): String;');
                  frxRelatorioPrecComReduzido.Script.Variables['NOMREL'] := 'PRODUTOS QUE NÃO TIVERAM REDUÇÃO NO PREÇO DE COMPRA';
                  TfrxMemoView(frxRelatorioPrecComReduzido.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

                  TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHederMargem')).Memo.Clear;
                  TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHeaderPrev')).Memo.Clear;

                  TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHederMargem')).Memo.Add('MARGEM '+strTabelaPrecoAtiva);
                  TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memHeaderPrev')).Memo.Add('PRE. DE VENDA '+strTabelaPrecoAtiva);

                  TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memPreVen')).Memo.Add('[IIF(<frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'_NOV"> > 0, <frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'_NOV">, <frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'">)]');
                  TfrxMemoView(frxRelatorioPrecComReduzido.FindComponent('memMargem')).Memo.Add('[IIF(<frxRelatorio."ITE_MARBR'+strTabelaPrecoAtiva+'_NOV"> > 0, <frxRelatorio."ITE_MARBR'+strTabelaPrecoAtiva+'_NOV">, <frxRelatorio."ITE_PREVE'+strTabelaPrecoAtiva+'">)]');

                  pPreviewReport(Self.Name, 'Produtos que não tiveram redução no preço de compra', frxRelatorioPrecComReduzido);
                End;

                Close;
              end;
            Finally
              pFreeAndNil(frmAltEfetivacaoPrecos);
            End;
            End
            Else
            Begin
              fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);
              Close;
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '[TfrmImportCadProdutoConfirma.pGravaLoteItens]');
          End;
        End;
      End;
    Finally
      cdsDadosAlt.Filtered := False;
      cdsDadosAlt.Filter := 'IMPORT = 1 AND SEMRED = 0';
      cdsDadosAlt.Filtered := True;
      cdsDadosAlt.EnableControls;
    End;
  Finally
//    cdsDadosAlt.AfterScroll := pAfterScrollUpdate;
//    cdsDadosIns.AfterScroll := pAfterScrollUpdate;
   blnGravando := False;
  End;
end;

class function TfrmImportCadProdutoConfirma.fGetvalor(cdsItens: TZClient; strNomCam: String): Double;
Begin
  Result := IfThen(cdsItens.FieldByName(strNomCam + '_NOV').IsNull,
                   cdsItens.FieldByName(strNomCam).AsFloat,
                   cdsItens.FieldByName(strNomCam + '_NOV').AsFloat);
End;

class function TfrmImportCadProdutoConfirma.fGetIcmsSTParteVenda(strEstEmp, strMarMkp: String; var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
  Var
    strCodSit : String;
begin
  Result := 0.00;
  blnST := False;
  If (strMarMkp = '4') And (Not fEmptyStr(strCodAbf)) Then
  Begin
    strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [strCodAbf, strEstEmp]);
    Result := untIcmsSTParteVenda.fGetIcmsSTParteVenda(strCodAbf, '_SAI_CCO', strCodSit, strEstEmp, fltPreComLiq, fltIpiEnt, fltImcSai, strEstEmp, blnST, strMarMkp);
  End;
end;

class function TfrmImportCadProdutoConfirma.fGetvalorStr(cdsItens: TZClient; strNomCam: String): String;
Begin
  Result := IIf(cdsItens.FieldByName(strNomCam + '_NOV').IsNull,
                   cdsItens.FieldByName(strNomCam).AsString,
                   cdsItens.FieldByName(strNomCam + '_NOV').AsString);
End;


function TfrmImportCadProdutoConfirma.fRecalculaPreco(
  pgbProgresso: TcxProgressBar): Boolean;
  var
   cdsDados: TZClient;
   fltIcmsSTParteVenda,
   fltPreCus,
   fltOutVal,
   fltIcmSai,
   fltDesOpe,
   fltPrecom,
   fltImpFed: Double;
   i, intTabela: integer;
   blnST: Boolean;
   recPrecos: TArrRecPrecos;
   strPcmPro,
   strEstEmp,
   strMarMkp: String;
   intDecUni: integer;

begin
  Result := True;
  intDecUni := fCfgSis('DECUNI', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');
  strEstEmp := fCadEmp('ESTADO');



  If pgcContainer.ActivePage = tbsAltera then
    cdsDados := cdsDadosAlt
  Else
    cdsDados := cdsDadosIns;

  pgbProgresso.Properties.Max := cdsDados.RecordCount;

  cdsDados.First;
  While not cdsDados.Eof Do
  Begin

    fltPreCus := cdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat;

    fltOutVal := cdsDados.FieldByName('ITE_OUTVAL_NOV').AsFloat;
    fltIcmSai := cdsDados.FieldByName('ITE_ICMSAI_NOV').AsFloat;
    fltDesOpe := cdsDados.FieldByName('ITE_DESOPE_NOV').AsFloat;
    fltImpFed := cdsDados.FieldByName('ITE_IMPFED_NOV').AsFloat;

    For i := 1 To 7 do
     recPrecos[i].fltComiss := IfThen(cdsDados.FieldByName('ITE_COMTB' +  IntToStr(i)+ '_NOV').IsNull,
                                      cdsDados.FieldByName('ITE_COMTB' +  IntToStr(i)).AsFloat,
                                      cdsDados.FieldByName('ITE_COMTB' +  IntToStr(i)+ '_NOV').AsFloat);

    If strMarMkp = '4'  Then
    Begin
      fltPrecom := IfThen(cdsDados.FieldByName('ITE_PRECOM_NOV').IsNull, cdsDados.FieldByName('ITE_PRECOM').AsFloat, cdsDados.FieldByName('ITE_PRECOM_NOV').AsFloat);
      fltIcmsSTParteVenda := fGetIcmsSTParteVenda(strEstEmp, strMarMkp, blnST, fGetvalorStr(cdsDados, 'ITE_CODABF'),

                                fCalculaPrecoCompraLiq(fltPrecom,
                                                       fGetvalor(cdsDados, 'ITE_DESF01'),
                                                       fGetvalor(cdsDados, 'ITE_DESF02'),
                                                       fGetvalor(cdsDados, 'ITE_DESF03'),
                                                       fGetvalor(cdsDados, 'ITE_DESF04'),
                                                       fGetvalor(cdsDados, 'ITE_DESF05'),
                                                       fGetvalor(cdsDados, 'ITE_DESF06'),
                                                       intDecUni,
                                                       cdsDados.FieldByName('ITE_PREDOL').AsString = 'S'),

                                 fGetvalor(cdsDados, 'ITE_IPIENT'),
                                 fGetvalor(cdsDados, 'ITE_ICMSAI'))
    End
    Else
    Begin
      blnST := False;
      fltIcmsSTParteVenda := 0;
    End;

    For intTabela := 1 To 7 Do
    Begin
      if fVerificaTabelaMarcada(intTabela) then
      Begin
        cdsDados.Edit;

        cdsDados.FieldByName('ITE_MARID' +  IntToStr(IntTabela)+ '_NOV').AsFloat := cdsDados.FieldByName('ITE_MARID' + IntToStr(IntTabela) + '_NOV').AsFloat;

        recPrecos[intTabela].fltComiss := IfThen(cdsDados.FieldByName('ITE_COMTB' +  IntToStr(IntTabela)+ '_NOV').IsNull,
                                                 cdsDados.FieldByName('ITE_COMTB' +  IntToStr(IntTabela)).AsFloat,
                                                 cdsDados.FieldByName('ITE_COMTB' +  IntToStr(IntTabela)+ '_NOV').AsFloat);


        If  RecalculoGeral = rgMargem Then
        begin
          cdsDados.FieldByName('ITE_MARBR' +  IntToStr(IntTabela)+ '_NOV').AsFloat :=  fltValorNovo;
          cdsDados.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)+ '_NOV').AsFloat :=  fCalculaPrecoVenda(1,
                                                                                                          fltPreCus + fltOutVal,
                                                                                                          0,
                                                                                                          cdsDados.FieldByName('ITE_MARBR' +  IntToStr(IntTabela)+ '_NOV').AsFloat,
                                                                                                          fltIcmSai,
                                                                                                          fltImpFed,
                                                                                                          fltDesOpe,
                                                                                                          recPrecos[intTabela].fltComiss,
                                                                                                          strMarMkp,
                                                                                                          strPcmPro,
                                                                                                          intDecUni,
                                                                                                          fltIcmsSTParteVenda,
                                                                                                          blnST);



        End
        Else
        begin
          cdsDados.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)+ '_NOV').AsFloat :=  fltValorNovo;
          cdsDados.FieldByName('ITE_MARBR' +  IntToStr(IntTabela)+ '_NOV').AsFloat :=  fCalculaPrecoVenda(2,
                                                                                                          fltPreCus + fltOutVal,
                                                                                                          cdsDados.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)+ '_NOV').AsFloat,
                                                                                                          0,
                                                                                                          fltIcmSai,
                                                                                                          fltImpFed,
                                                                                                          fltDesOpe,
                                                                                                          recPrecos[intTabela].fltComiss,
                                                                                                          strMarMkp,
                                                                                                          strPcmPro,
                                                                                                          intDecUni,
                                                                                                          fltIcmsSTParteVenda,
                                                                                                          blnST);
        End;

        cdsDados.FieldByName('VARIACAO' +  IntToStr(IntTabela)).AsFloat :=  (cdsDados.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)+'_NOV').AsFloat/cdsDados.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat -1) * 100;
        cdsDados.Post;
      End;
    End;
    cdsDados.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
End;

function TfrmImportCadProdutoConfirma.fRetFornecedor(strCodForOld, strCodForNew: String): String;
Begin
  Result:= fRetNomFornecedor(strCodForNew);
  if fEmptyStr(Result) then
    Result:= fRetNomFornecedor(strCodForOld);
End;

procedure TfrmImportCadProdutoConfirma.btnDesmAllClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadProdutoConfirma.btnMarcAllClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadProdutoConfirma.btnMarcarClick(Sender: TObject);
var cdsDados: TZClient;
begin
  If pgcContainer.ActivePage = tbsAltera then
    cdsDados := cdsDadosAlt
  Else
    cdsDados := cdsDadosIns;
  cdsDados.Edit;
  cdsDados.FieldByName('MARCADO').AsInteger := IIf(cdsDados.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDados.Post;
end;

procedure TfrmImportCadProdutoConfirma.btnRelProdCadClick(Sender: TObject);
begin
  frxRelatorio.DataSet := cdsDadosIns;
  frxItensInsert.Script.Variables['NOMREL'] := 'PRODUTOS QUE SERAO CADASTRADOS';
  TfrxMemoView(frxItensInsert.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  frxItensInsert.DotMatrixReport           := False;
  frxItensInsert.PrintOptions.PrintMode    := pmScale;
  frxItensInsert.PrintOptions.PrintOnSheet := 9; //A4
  pPreviewReport(Self.Name, Self.Caption + ' (Produtos que serao cadastrados)', frxItensInsert);
end;

procedure TfrmImportCadProdutoConfirma.btnVariacaoClick(Sender: TObject);
begin
  inherited;
  TfrmImportCadProdutoVariacaoPreVen.pExibeVariacao(cdsDadosAlt);
end;

procedure TfrmImportCadProdutoConfirma.btnVisProdNaoImpClick(Sender: TObject);
begin
  inherited;
  frxRelatorio.DataSet := cdsRelatorio;
  frxRepNaoImp.Script.Variables['NOMREL'] := 'RELATÓRIO DE CRÍTICAS';
  TfrxMemoView(frxRepNaoImp.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  frxRepNaoImp.DotMatrixReport           := False;
  frxRepNaoImp.PrintOptions.PrintMode    := pmScale;
  frxRepNaoImp.PrintOptions.PrintOnSheet := 9; //A4
  pPreviewReport(Self.Name, Self.Caption + ' (Relatório de críticas)', frxRepNaoImp);
end;

procedure TfrmImportCadProdutoConfirma.chkExibirEmbalaClick(Sender: TObject);
begin
  inherited;
  If pgcContainer.ActivePage = tbsAltera Then
    pExibeEmbalagens(cxgItensView.Controller.FocusedRow)
  Else
    pExibeEmbalagens(cxItensIns.Controller.FocusedRow);

end;

procedure TfrmImportCadProdutoConfirma.cxgEmbalaViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  If pgcContainer.ActivePage = tbsAltera Then
    pExibeEmbalagens(cxgItensView.Controller.FocusedRow)
  Else
    pExibeEmbalagens(cxItensIns.Controller.FocusedRow);
end;

procedure TfrmImportCadProdutoConfirma.pAtualizaListaIteger(strCodite: String; qryManipulada: TUniQuery);
var strVirgula: String;
begin

  while not cdsListasIteger.Eof Do
  Begin
    If (cdsListasIteger.FieldByName('ITE_NIVCRI').AsString <> '') Or
       (cdsListasIteger.FieldByName('ITE_ESTMIN').AsString <> '') Or
       (cdsListasIteger.FieldByName('ITE_ESTMAX').AsString <> '') Or
       (cdsListasIteger.FieldByName('ITE_SITPRO').AsString <> '') Or
       (cdsListasIteger.FieldByName('ITE_TPESTM').AsString <> '') Or
       (cdsListasIteger.FieldByName('ITE_ESMIDG').AsString <> '') Then
    Begin

      qryManipulada.SQL.Clear;
      strVirgula := '';
      qryManipulada.SQL.Add ('UPDATE ITEGER SET');
      If cdsListasIteger.FieldByName('ITE_ESTMIN').AsString <> '' Then
      Begin
        qryManipulada.SQL.Add ('    ITE_ESTMIN = :ESTMIN ');
        strVirgula := ',';
      End;

      If cdsListasIteger.FieldByName('ITE_ESTMAX').AsString <> '' Then
      Begin
        qryManipulada.SQL.Add (strVirgula + '    ITE_ESTMAX = :ESTMAX ' );
        strVirgula := ',';
      End;

      If cdsListasIteger.FieldByName('ITE_TPESTM').AsString <> '' Then
      Begin
        qryManipulada.SQL.Add (strVirgula + '    ITE_TPESTM = :TPESTM ' );
        strVirgula := ',';
      End;

      If cdsListasIteger.FieldByName('ITE_SITPRO').AsString <> '' Then
      Begin
        qryManipulada.SQL.Add ( strVirgula + '    ITE_SITPRO = :SITPRO ' );
        strVirgula := ',';
      End;

      If cdsListasIteger.FieldByName('ITE_NIVCRI').AsString <> '' Then
      Begin
        qryManipulada.SQL.Add ( strVirgula + '    ITE_NIVCRI = :NIVCRI ' );
        strVirgula := ',';
      End;

      If cdsListasIteger.FieldByName('ITE_ESMIDG').AsString <> '' Then
        qryManipulada.SQL.Add (strVirgula + '    ITE_ESMIDG = :ESMIDG ');

      qryManipulada.SQL.Add (' WHERE ITE_CODITE = :CODITE ');
      qryManipulada.SQL.Add ('   AND ITE_CODEMP = :CODEMP ');

      If cdsListasIteger.FieldByName('ITE_ESTMIN').AsString <> '' Then
        qryManipulada.ParamByName('ESTMIN').Value := cdsListasIteger.FieldByName('ITE_ESTMIN').Value;

      If cdsListasIteger.FieldByName('ITE_TPESTM').AsString <> '' Then
        qryManipulada.ParamByName('TPESTM').Value := cdsListasIteger.FieldByName('ITE_TPESTM').Value;

      If cdsListasIteger.FieldByName('ITE_ESTMAX').AsString <> '' Then
        qryManipulada.ParamByName('ESTMAX').Value := cdsListasIteger.FieldByName('ITE_ESTMAX').Value;

      If cdsListasIteger.FieldByName('ITE_SITPRO').AsString <> '' Then
        qryManipulada.ParamByName('SITPRO').Value := fStrZero(cdsListasIteger.FieldByName('ITE_SITPRO').AsString, 3);

      If cdsListasIteger.FieldByName('ITE_ESMIDG').AsString <> '' Then
        qryManipulada.ParamByName('ESMIDG').Value := cdsListasIteger.FieldByName('ITE_ESMIDG').Value;

      If cdsListasIteger.FieldByName('ITE_NIVCRI').AsString <> '' Then
        qryManipulada.ParamByName('NIVCRI').Value := cdsListasIteger.FieldByName('ITE_NIVCRI').Value;

       qryManipulada.ParamByName('CODITE').AsString := strCodIte;
       qryManipulada.ParamByName('CODEMP').AsString := cdsListasIteger.FieldByName('ITE_CODEMP').ASString;

       qryManipulada.ExecSQL;
    End;

    If (cdsListasIteger.FieldByName('ITE_SITPRO').AsString <> '') And (fCfgSis('SITEMP', varInteger, cdsListasIteger.FieldByName('ITE_CODEMP').ASString) =  1) Then
    Begin
      If cdsListasIteger.FieldByName('ITE_SITPRO').AsString <> '' Then
      Begin
        qryManipulada.SQL.Text := 'UPDATE CADITE SET ITE_SITPRO = :SITPRO WHERE ITE_CODITE = :CODITE';
        qryManipulada.ParamByName('SITPRO').Value := fStrZero(cdsListasIteger.FieldByName('ITE_SITPRO').AsString, 3);
        qryManipulada.ParamByName('CODITE').AsString := strCodIte;
        qryManipulada.ExecSQL;
      End;
    End;


    If (cdsListasIteger.FieldByName('ITE_CODABF').AsString <> '') And (strTipAbf = '2') Then
    Begin
      If fCfgSis('TIPABF', varInteger, cdsListasIteger.FieldByName('ITE_CODEMP').AsString) = 1 Then
        qryManipulada.SQL.Text := 'UPDATE CADITE SET ITE_CODABF = :CODABF WHERE ITE_CODITE = :CODITE'
      Else
      Begin
        qryManipulada.SQL.Text := 'UPDATE ITEGER SET ITE_CODABF = :CODABF WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
        qryManipulada.ParamByName('CODEMP').Value := cdsListasIteger.FieldByName('ITE_CODEMP').AsString;
      End;

      qryManipulada.ParamByName('CODABF').Value := cdsListasIteger.FieldByName('ITE_CODABF').AsString;
      qryManipulada.ParamByName('CODITE').AsString := strCodIte;
      qryManipulada.ExecSQL;
    End;

    If cdsListasIteger.FieldByName('ITE_ABFPIS').AsString <> '' Then
    Begin
      qryManipulada.SQL.Text := 'UPDATE ITEGER SET ITE_ABFPIS = :ABFPIS WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
      qryManipulada.ParamByName('CODEMP').Value := cdsListasIteger.FieldByName('ITE_CODEMP').AsString;

      qryManipulada.ParamByName('ABFPIS').Value := cdsListasIteger.FieldByName('ITE_ABFPIS').AsString;
      qryManipulada.ParamByName('CODITE').AsString := strCodIte;
      qryManipulada.ExecSQL;
    End;

    If cdsListasIteger.FieldByName('ITE_ABFCOF').AsString <> '' Then
    Begin
      qryManipulada.SQL.Text := 'UPDATE ITEGER SET ITE_ABFCOF = :ABFCOF WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
      qryManipulada.ParamByName('CODEMP').Value := cdsListasIteger.FieldByName('ITE_CODEMP').AsString;
      qryManipulada.ParamByName('ABFCOF').Value := cdsListasIteger.FieldByName('ITE_ABFCOF').AsString;
      qryManipulada.ParamByName('CODITE').AsString := strCodIte;
      qryManipulada.ExecSQL;
    End;


    cdsListasIteger.Next;
  End;

end;

procedure TfrmImportCadProdutoConfirma.pExibeEmbalagens(AFocusedRecord: TcxCustomGridRecord);
begin
  If blnGravando Then
    Exit;
  If Not chkExibirEmbala.Checked Then
  Begin
    cxgEmbala.Visible := False;
    Exit;
  End;
  If cdsDadosAlt.RecordCount > 0 Then
  Begin
    cdsDadosEmbalagem.Filtered := False;
    If pgcContainer.ActivePage = tbsAltera Then
      cdsDadosEmbalagem.Filter := 'ID = ' + QuotedStr(cdsDadosAlt.FieldByName('ID').AsString)
    Else
      cdsDadosEmbalagem.Filter := 'ID = ' + QuotedStr(cdsDadosIns.FieldByName('ID').AsString);
    cdsDadosEmbalagem.Filtered := True;

    If cdsDadosEmbalagem.RecordCount > 0 Then
    begin

      gerRect := AFocusedRecord.ViewInfo.FocusRectBounds;

      cxgEmbala.Visible := True;

      cxgEmbala.Top :=  gerRect.Bottom + 30;
      If cxgEmbala.Top + cxgEmbala.Height > Self.Height Then
         cxgEmbala.Top := gerRect.Top - cxgEmbala.Height;
      cxgEmbala.Left := 15;
    End
    Else
      cxgEmbala.Visible := False;
  End
  Else
    cxgEmbala.Visible := False;
end;

procedure TfrmImportCadProdutoConfirma.pgcContainerChange(Sender: TObject);
begin
  inherited;
  cxgEmbala.Visible := False;
end;

procedure TfrmImportCadProdutoConfirma.cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var ColMarcad : TcxGridDBColumn;
begin
  If TcxGridDBTableView(Sender).DataController.DataSource.DataSet.RecordCount = 0 Then
    Exit;

  If Sender = cxgItensView then
    ColMarcad := cxgItensViewMARCADO
  Else
    ColMarcad := cxItensInsMARCADO;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ColMarcad.Index] = '1') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
  If Pos('Novo', AViewInfo.Item.Caption) > 0 then
    ACanvas.Brush.Color := clMoneyGreen
end;

procedure TfrmImportCadProdutoConfirma.cxgItensViewDataControllerFilterChanged(Sender: TObject);
begin
  inherited;
  cxgEmbala.Visible := True;
  cdsDadosAlt.Filtered := False;
  cdsDadosAlt.Filter := UpperCase(cxgItensView.DataController.Filter.FilterText);
  If cdsDadosAlt.Filter = '' Then
    cdsDadosAlt.Filter := 'IMPORT = 1 AND SEMRED = 0';


  cdsDadosAlt.Filtered := cdsDadosAlt.Filter <> '';
end;


procedure TfrmImportCadProdutoConfirma.cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  pExibeEmbalagens(AFocusedRecord);
end;

procedure TfrmImportCadProdutoConfirma.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarClick(Sender);
  End;
end;

procedure TfrmImportCadProdutoConfirma.cxItensInsDataControllerFilterChanged(Sender: TObject);
begin
  inherited;
  cdsDadosIns.Filtered := False;
  cdsDadosIns.Filter := UpperCase(cxItensIns.DataController.Filter.FilterText);
  cdsDadosIns.Filtered := cdsDadosIns.Filter <> '';
end;

procedure TfrmImportCadProdutoConfirma.cxItensInsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  pExibeEmbalagens(AFocusedRecord);

end;

function TfrmImportCadProdutoConfirma.fAtualizaCampos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cdsDadosAlt.First;
  cdsDadosAlt.DisableControls;

  pgbProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;
  Try
    While not cdsDadosAlt.Eof Do
    Begin
      fStartTransaction;
      if  fAtualizaCamposAux(qryCRUD) Then
      begin
        pInsereLogAltCamposImportacao;
        fCommit;
      end
      else
         fRollback;
      cdsDadosAlt.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    cdsDadosAlt.EnableControls;
  End;
end;

procedure TfrmImportCadProdutoConfirma.pInsereLogAltCamposImportacao;
var
  objCampo,
  objCampoNovo: TField;
  strNomeCampoOriginal: String;
  strNomeCampo: String;
  blnAlterado: Boolean;
  strCodIte: String;
begin

  qryLog.Close;
  qryLog.SQL.Text := 'SELECT * FROM LOGIMP WHERE FALSE';
  qryLog.Open;
  qryLog.Append;
  qryLog.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGIMP',VS_StrCodEmp);
  qryLog.FieldByName('LIP_SEQGER').AsString := strAutLogCap;
  blnAlterado := False;

  qryLog.FieldByName('LIP_DTAIMP').AsDateTime := FDataInicioGravacao;
  qryLog.FieldByName('LIP_CODEMP').AsString := VS_StrCodEmp;
  qryLog.FieldByName('LIP_CODOPE').AsString :=strLoginUsuarioLogado;
  qryLog.FieldByName('LIP_ARQPTH').AsString :=FstrPath;
  qryLog.FieldByName('LIP_RECALC').AsString := FPreVenMarbruSel;
  qryLog.FieldByName('LIP_NDEDUZ').AsString :=FstrBlnRedPrecoVenda;
  strCodIte := cdsDadosAlt.FieldByName('ITE_CODITE').AsString;
  For objCampo in cdsDadosAlt.Fields Do
  Begin
    If (Pos('_NOV',objCampo.FieldName) > 4) Then
      Continue;


    objCampoNovo := cdsDadosAlt.FindField(objCampo.FieldName + '_NOV');
    strNomeCampoOriginal := objCampo.FieldName;
    strNomeCampo := ('LIP_' + strNomeCampoOriginal)
      .Replace('ITE_','',[])
      .Replace('LOG_','',[]);
    If Assigned(qryLog.FindField(strNomeCampo)) Then
    Begin
      If Assigned(objCampoNovo) Then
      Begin
        blnAlterado := true;
        qryLog.FieldByName(strNomeCampo).Value := objCampo.Value;
        qryLog.FieldByName(strNomeCampo + '_NOV').Value := objCampoNovo.Value;
      End
      Else If Assigned(qryLog.FindField(strNomeCampo)) Then
        qryLog.FieldByName(strNomeCampo).Value := objCampo.Value;
    End;

    If (Not fCompararCampos(objCampo, objCampoNovo)) And
       (Assigned(objCampoNovo)) And
       (Not fEmptyStr(objCampoNovo.AsString)) Then
    Begin
      pGravaLogAlteracaoCPR(strCodIte, strNomeCampoOriginal , objCampoNovo.Value, objCampo.Value, objCampo.DataType);
    End;
  End;

  If blnAlterado Then
    qryLog.Post
  else
    qryLog.Cancel;

end;

procedure TfrmImportCadProdutoConfirma.pInsereLogCap;
Begin
  strAutLogCap := fRetAutoIncrem('LOGCAP', VS_StrCodEmp);
  qryLog.Close;
  qryLog.SQL.Text := 'SELECT * FROM LOGCAP WHERE FALSE';
  qryLog.Open;
  qryLog.Append;
  qryLog.FieldByName('AUTOINCREM').AsString := strAutLogCap;
  qryLog.FieldByName('LCP_DTAIMP').Value := fNow;
  qryLog.FieldByName('LCP_CODOPE').Value := strLoginUsuarioLogado;
  qryLog.FieldByName('LCP_CODEMP').Value := VS_strCodEmp;
  qryLog.FieldByName('LCP_ARQPTH').Value := strPath;
  qryLog.FieldByName('LCP_RECALC').Value := IIF(blnPrecoVenda, 'PREÇO DE VENDA','MARGEM LUCRO');
  qryLog.FieldByName('LCP_NDEDUZ').Value := strNdeDuz;
  qryLog.FieldByName('LCP_ARQCSV').Value := strArqCSV;
  qryLog.Post;
End;

procedure TfrmImportCadProdutoConfirma.pInsereLogCamposImportacao;
Var
  objCampo: TField;
  strNomeCampo: String;
begin
  qryLog.Close;
  qryLog.SQL.Text := 'SELECT * FROM LOGIMP WHERE FALSE';
  qryLog.Open;
  qryLog.Append;
  qryLog.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGIMP',VS_StrCodEmp);
  qryLog.FieldByName('LIP_SEQGER').AsString := strAutLogCap;
  qryLog.FieldByName('LIP_DTAIMP').Value := fNow;
  qryLog.FieldByName('LIP_CODOPE').Value := strLoginUsuarioLogado;
  qryLog.FieldByName('LIP_CODEMP').Value := VS_strCodEmp;
  qryLog.FieldByName('LIP_ARQPTH').Value := strPath;
  qryLog.FieldByName('LIP_RECALC').Value := IIF(blnPrecoVenda, 'PREÇO DE VENDA','MARGEM LUCRO');
  qryLog.FieldByName('LIP_NDEDUZ').Value := strNdeDuz;

  For objCampo in cdsDadosIns.Fields Do
  Begin
    strNomeCampo := objCampo.FieldName;
    strNomeCampo := ('LIP_' + strNomeCampo)
      .Replace('ITE_','',[])
      .Replace('LOG_','',[]);

    If Assigned( qryLog.FindField(strNomeCampo + '_NOV') ) Then
      qryLog.FieldByName(strNomeCampo).Value := objCampo.Value
    Else If Assigned( qryLog.FindField(strNomeCampo) ) Then
      qryLog.FieldByName(strNomeCampo).Value := objCampo.Value;
  End;
  qryLog.Post
end;


function TfrmImportCadProdutoConfirma.fInsereProdutos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cdsDadosIns.First;
  cdsDadosIns.DisableControls;
  pgbProgresso.Properties.Max := cdsDadosIns.RecordCount -1;
  Try
    While not cdsDadosIns.Eof Do
    Begin
      If (Not fItemJaInserido) Then
      Begin
        fStartTransaction;
        if  fInsereProdutosAux(qryCRUD) Then
        Begin
          pInsereLogCamposImportacao;
          fCommit
        End else
           fRollback;
      End;
      cdsDadosIns.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    cdsDadosIns.First;
    qryEmpresa.First;
//    TCheckListGarantiaController.fGravarChecklistImportacaoProdutos(cdsDadosIns, qryEmpresa);

    If fEnviarMsgNovoProduto Then
    Begin
      fMensagemNovoProdutoCadastrado(cdsDadosIns, True);
    End;

  Finally
    If blnProdutoNaoCadastrado Then
      fMensagem('Aviso', 'Existe um ou mais produtos que não foram cadatrados devido a sequencia PROCOD estar inválida!', ['&O k']);
    cdsDadosAlt.EnableControls;
  End;
end;

function TfrmImportCadProdutoConfirma.fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cdsDadosAlt.First;
  cdsDadosAlt.DisableControls;

  If Not blnUtiPreIte Then
    Exit(True);

  cdsDadosAlt.Filtered := False;
  cdsDadosAlt.Filter := 'IMPORT = 1 AND MARCADO = 1 AND ALTPRE = 1  AND SEMRED = 0';
  cdsDadosAlt.Filtered := True;

  pgbProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;
  Try
    While not cdsDadosAlt.Eof Do
    Begin
      fStartTransaction;
      If fProcessar(qryCRUD) Then
         fCommit
      Else
         fRollback;
      cdsDadosAlt.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    cdsDadosAlt.EnableControls;
  End;
end;

procedure TfrmImportCadProdutoConfirma.FormCreate(Sender: TObject);
var blnInfEmb : Boolean;
   strTabelas : string;
   i: integer;
   ObjTabela: TObjTabela;
begin
  inherited;

  strTipAbf := fCfgSIs('TIPABF');
  blnGravando := False;
  blnURapel := fCfgSis('URAPEL', varBoolean);
  blnInfEmb := fUsaRotinaWMS Or (fArqIni(0, 'GERAL', 'INFEMB', '') = 'S');

  cxgEmbalaViewBAR_ALTURA.Visible := blnInfEmb;
  cxgEmbalaViewBAR_LARGUR.Visible := blnInfEmb;
  cxgEmbalaViewBAR_PROFUN.Visible := blnInfEmb;
  cxgEmbalaViewBAR_PESOBR.Visible := blnInfEmb;
  cxgEmbalaViewBAR_PESOLQ.Visible := blnInfEmb;
  cxgEmbalaViewBAR_LASTRO.Visible := blnInfEmb;
  cxgEmbalaViewBAR_CAMADA.Visible := blnInfEmb;
  cxgEmbalaViewBAR_EMPMAX.Visible := blnInfEmb;

  lstTabPreco.Clear;
  strTabelas:= fCfgSis('TABPRC');
  for I := 0 to Length(strTabelas) do
  Begin
    If strTabelas[i] = 'S' Then
    Begin
      ObjTabela := TObjTabela.Create(Self);
      ObjTabela.TabelaDePrecoLista := fRetTabelaPrecoByInt(i);
      lstTabPreco.AddItem('Tabela ' + IntToStr(i), ObjTabela);
    End;
  End;
end;

function TfrmImportCadProdutoConfirma.fRetTabelaPrecoByInt(int: integer): TTabelaDePrecoLista;
Begin
  Result := tplTabela1;
  case int of
    1: Result := tplTabela1;
    2: Result := tplTabela2;
    3: Result := tplTabela3;
    4: Result := tplTabela4;
    5: Result := tplTabela5;
    6: Result := tplTabela6;
    7: Result := tplTabela7;
  End;
End;

procedure TfrmImportCadProdutoConfirma.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDadosAlt);
  FreeAndNil(cdsDadosIns);
  FreeAndNil(cdsRelatorio);
  FreeAndNil(qryCRUD);
  FreeAndNil(qryEmpresa);
  FreeAndNil(FLista);
  FreeAndNil(cdsDadosPrecoReduzido);
  inherited;
end;

procedure TfrmImportCadProdutoConfirma.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
    Case Key Of
      VK_F2   : btnMarcAllClick(Sender);
      VK_F3   : btnDesmAllClick(Sender);
      VK_SPACE: btnMarcarClick(Sender);
    End;
  End;
{ TObjTabela }

constructor TObjTabela.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmImportCadProdutoConfirma.FormShow(Sender: TObject);
begin
  inherited;

  If (fCfgSis('SUFRAM', varBoolean)) And (fCfgSis('FRMCUS', varString) = '4') Then
  Begin
    cxgItensViewTCIFCU.Visible       := True;
    cxgItensViewTCIFCU_NOV.Visible   := True;
    cxgItensViewTSCUST.Visible       := True;
    cxgItensViewTSCUST_NOV.Visible   := True;
    cxgItensView_DEPICO.Visible      := True;
    cxgItensViewDEPICO_NOV.Visible   := True;
    cxgItensViewDEICMS.Visible       := True;
    cxgItensViewDEICMS_NOV.Visible   := True;
    cxgItensViewFATREG.Visible       := True;
    cxgItensViewFATREG_NOV.Visible   := True;
    cxItensInsViewTCIFCU_NOV.Visible := True;
    cxItensInsViewTSCUST_NOV.Visible := True;
    cxItensInsViewDEPICO_NOV.Visible := True;
    cxItensInsViewDEICMS_NOV.Visible := True;
    cxItensInsViewFATREG_NOV.Visible := True;
  End;

  strTabelaPrecoAtiva:= IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));

  If Not fCfgSis('PRVEMB', VarBoolean) Then
  Begin
    cxgEmbalaDescri.Visible := False;
    cxgEmbalaPreVen.Visible := False;
  End
  Else
    pSetaTipoPrecoEmbalagem;

  If blnURapel then
  begin
    cxgItensViewPRAPEL.Visible      := blnURapel;
    cxgItensViewPRAPEL_NOVO.Visible := blnURapel;
    cxItensInsPRAPEL_NOV.Visible    := blnURapel;
    TcxCurrencyEditProperties(cxgItensViewPRAPEL.Properties).DisplayFormat := fMskDigitos(2);
    TcxCurrencyEditProperties(cxgItensViewPRAPEL_NOVO.Properties).DisplayFormat := fMskDigitos(2);
    TcxCurrencyEditProperties(cxItensInsPRAPEL_NOV.Properties).DisplayFormat := fMskDigitos(2);
  end;

  If (Not btnConfirma.Enabled) Then
    btnVisProdNaoImp.Click;

  If intArredondamento > 0 Then
  Begin
    TcxCurrencyEditProperties(cxItensInsViewPREVE1_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxItensInsViewPREVE2_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxItensInsViewPREVE3_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxItensInsViewPREVE4_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxItensInsViewPREVE5_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxItensInsViewPREVE6_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxItensInsViewPREVE7_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
  End;

  if fCfgSis('UTPEST', varBoolean) then
  begin
    cxItensInsQTDPES_NOV.Visible := True;
    cxItensInsPORPES_NOV.Visible := True;

    TcxCurrencyEditProperties(cxItensInsQTDPES_NOV.Properties).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));
    TcxCurrencyEditProperties(cxItensInsPORPES_NOV.Properties).DisplayFormat := fMskDigitos(2);

    cxgItensViewQTDPES.Visible := True;
    cxgItensViewPORPES.Visible := True;
    cxgItensViewQTDPES_NOV.Visible := True;
    cxgItensViewPORPES_NOV.Visible := True;

    TcxCurrencyEditProperties(cxgItensViewQTDPES.Properties).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));
    TcxCurrencyEditProperties(cxgItensViewQTDPES_NOV.Properties).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));
    TcxCurrencyEditProperties(cxgItensViewPORPES.Properties).DisplayFormat := fMskDigitos(2);
    TcxCurrencyEditProperties(cxgItensViewPORPES_NOV.Properties).DisplayFormat := fMskDigitos(2);
  end;

  if fCfgSis('UNITRI', varBoolean) then
  begin
    cxItensInsFATUTR.Visible := True;
    cxgItensViewFATUTR.Visible := True;
    cxgItensViewFATUTR_NOV.Visible := True;
    TcxCurrencyEditProperties(cxItensInsFATUTR.Properties).DisplayFormat := fMskDigitos(6);
    TcxCurrencyEditProperties(cxgItensViewFATUTR.Properties).DisplayFormat := fMskDigitos(6);
    TcxCurrencyEditProperties(cxgItensViewFATUTR_NOV.Properties).DisplayFormat := fMskDigitos(6);
  end;

  if fCfgSis('MARPAD', varBoolean) then
  begin
    cxgItensViewMARPAD.Visible := True;
    cxItensInsMARPAD_NOV.Visible := True;
    cxgItensViewMARPAD_NOV.Visible := True;
    TcxCurrencyEditProperties(cxgItensViewMARPAD.Properties).DisplayFormat := fMskDigitos(2);
    TcxCurrencyEditProperties(cxItensInsMARPAD_NOV.Properties).DisplayFormat := fMskDigitos(2);
    TcxCurrencyEditProperties(cxgItensViewMARPAD_NOV.Properties).DisplayFormat := fMskDigitos(2);
  end;

  if fCfgSis('MINPRO', varBoolean) then
  begin
    cxgItensViewLIS_TPESTM.Visible := True;
    cxItensInsLIS_TPESTM.Visible := True;
  end;

  cxItensInsViewCODABF_NOV.Visible  := strTipAbf = '1';
  cxgItensViewCODABF.Visible        := strTipAbf = '1';
  cxgItensViewCODABF_NOV.Visible    := strTipAbf = '1';
  cxItensInsLIS_ABVFIS_NOV.Visible  := strTipAbf = '2';
  cxgItensViewLIS_ABVFIS.Visible    := strTipAbf = '2';
end;

function TfrmImportCadProdutoConfirma.fProcessar(qryManipulada: TUniQuery): Boolean;
begin
  Try
     Result := True;
     pIncluiPreIte(qryManipulada, cdsDadosAlt, dtaDtaAltera, 'TfrmImportCadProdutoConfirma', fRetSequencial('PROPRI', VS_strCodEmp), False, False);
  Except
    On E:Exception do
    Begin
      pMensagensErro(E.Message,'[TfrmImportCadProdutoConfirma.fProcessar.pIncluiPreIte]');
      Result := False;
    End;
  End;
end;

function TfrmImportCadProdutoConfirma.fRetPrimeiroAnoGiro: Integer;
  Var
   qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Text := 'SELECT MIN(GIR_A_N_O_) AS ANO FROM GIRITE';
    qryConsulta.Open;
    Result := StrToIntDef(qryConsulta.FieldByName('ANO').AsString, YearOf(VS_Date));
    If Result = YearOf(VS_Date) then
      Result := (YearOf(VS_Date))-1;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmImportCadProdutoConfirma.frxGenGetValue(const VarName: string; var Value: Variant);
begin

  If VarName = 'EMP_NOMEMP' Then
    Value := fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'EMP_NOMFAN' Then
    Value := fCampoTabela('EMP_NOMFAN', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name

  Else If VarName = 'EMP_NOMCID' Then
    Value := fCampoTabela('CID_NOMCID', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

end;

function TfrmImportCadProdutoConfirma.frxRelatorioPrecComReduzidoUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  if SameText(MethodName, 'fRetFornecedor') then
    Result := fRetFornecedor(Params[0], Params[1]);
end;

procedure TfrmImportCadProdutoConfirma.pMarcaDesmarcaTodos(blnMarca: boolean);
  var frmMarca: TfrmGravando;
begin
  blnMarcar := blnMarca;
  pCriarFormularios(TfrmGravando, frmMarca);
  Try
    frmMarca.lblGravando.Caption := 'Efetivando marcação dos itens...';
    frmMarca.fExecutarAcao := fMarcaDesmarcaTodosAux;
    frmMarca.Showmodal;
  Finally
    pFreeAndNil(frmMarca);
  End;
end;

function TfrmImportCadProdutoConfirma.fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
var cdsDados: TZClient;
begin
  If pgcContainer.ActivePage = tbsAltera then
    cdsDados := cdsDadosAlt
  Else
    cdsDados := cdsDadosIns;

  prgProgresso.Properties.Max := cdsDados.RecordCount -1;
  cdsDados.DisableControls;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('MARCADO').AsInteger := IIf(blnMarcar, 1, 0);
      cdsDados.Post;
      cdsDados.Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsDados.EnableControls;
  End;
end;

function TfrmImportCadProdutoConfirma.fInsereProdutosAux(qryManipulada: TUniQuery): boolean;
var strSQLCampos,
    strBinds:  String;

  procedure pAddSQLInsert(strCampo: string; strOrigem: string = '');
    var blnCampoSemNovo: Boolean;
  begin
    blnCampoSemNovo := (strCampo = 'ITE_CODITE');

    If strOrigem <> '' Then
      strOrigem := '_' +  strOrigem;
    If Not (cdsDadosIns.FieldByName(strCampo + strOrigem + IIf(blnCampoSemNovo, '', '_NOV')).Value = null) Then
    Begin
      strSQLCampos := strSQLCampos + IIf(fEmptyStr(strSQLCampos), '', ',') + strCampo;
      strBinds     := strBinds     + IIf(fEmptyStr(strBinds), '', ',') + ':' + strCampo;
    End;
  End;

  procedure pSetBind(strCampo: string; strOrigem: string = ''; TipoDefault: TTipoDefault = tpdfNull);
  Begin
    If strOrigem <> '' Then
      strOrigem := '_' +  strOrigem;

    If Assigned(qryManipulada.FindParam(strCampo)) Then
    Begin
      qryManipulada.ParamByName(strCampo).Value := cdsDadosIns.FieldByName(strCampo + strOrigem + '_NOV').Value;
      If qryManipulada.ParamByName(strCampo).Value = null then
      begin
        case TipoDefault of
          tpdfSim : qryManipulada.ParamByName(strCampo).Value := 'S';
          tpdfNao : qryManipulada.ParamByName(strCampo).Value := 'N';
          tpdfZero: qryManipulada.ParamByName(strCampo).Value := 0;
        end
      end;
    End;

  end;


Begin

  Result := True;
  strSQLCampos := '';
  strBinds := '';
  If blnProCod Then
  Begin
    strCodite := fAtualizaProCod('CADITE', 'ITE_CODITE', '', 1, Nil,
      function (const AValue : String) : String
      begin
        Result := fPadL(AValue, fTamCodIte, '0');
      end
    );
    If fProdutoCadastrado(strCodIte) Then
    Begin
      blnProdutoNaoCadastrado := True;
      Exit;
    End;

    cdsDadosIns.Edit;
    cdsDadosIns.FieldByName('ITE_CODITE').AsString := strCodIte;
    cdsDadosIns.Post;

  End
  Else
    strCodIte := cdsDadosIns.FieldByName('ITE_CODITE').AsString;
  Try
    {$Region 'CADITE'}
    qryManipulada.SQL.Clear;
    pAddSQLInsert('ITE_CODITE');
    pAddSQLInsert('ITE_CODFAB');
    pAddSQLInsert('ITE_DIAFOR');
    pAddSQLInsert('ITE_CODFOR');
    pAddSQLInsert('ITE_CODBAR');
    pAddSQLInsert('ITE_CODDEP');
    pAddSQLInsert('ITE_CODGRU');
    pAddSQLInsert('ITE_DESITE');
    pAddSQLInsert('ITE_DESSIM');
    pAddSQLInsert('ITE_DESFAB');
    pAddSQLInsert('ITE_CODMAR');
    pAddSQLInsert('ITE_REFERE');
    pAddSQLInsert('ITE_CODUNI');
    pAddSQLInsert('ITE_UNICOM');
    pAddSQLInsert('ITE_INCPIS');
    pAddSQLInsert('ITE_CLAIPI');
    pAddSQLInsert('ITE_EXCIPI');
    pAddSQLInsert('ITE_CDCEST');
    pAddSQLInsert('ITE_CODONU');
    pAddSQLInsert('ITE_ATICOM');
    pAddSQLInsert('ITE_ITEATI');
    pAddSQLInsert('ITE_PESOIT');
    pAddSQLInsert('ITE_PESLIQ');
    pAddSQLInsert('ITE_CODGPR');
    pAddSQLInsert('ITE_PRDGRU');
    pAddSQLInsert('ITE_GRUCMP');
    pAddSQLInsert('ITE_MLTVEN');
    pAddSQLInsert('ITE_MLTCOM');
    pAddSQLInsert('ITE_ACOOBJ');
    pAddSQLInsert('ITE_APLICA');
    pAddSQLInsert('ITE_TMPGAR');
    If strTipAbf <> '2' Then
      pAddSQLInsert('ITE_CODABF');

    If fCfgSis('TPABPC') <> '2' Then
    Begin
      pAddSQLInsert('ITE_ABFPIS');
      pAddSQLInsert('ITE_ABFCOF');
      pAddSQLInsert('ITE_ABFIPI');
    end;
    pAddSQLInsert('ITE_INFGAR');
    pAddSQLInsert('ITE_MSGLV1');
    pAddSQLInsert('ITE_MSGLV2');
    pAddSQLInsert('ITE_PEEFUT');
    pAddSQLInsert('ITE_PEFUTP');
    pAddSQLInsert('ITE_PEFFPR');


    pAddSQLInsert('ITE_NVLGIR');

    pAddSQLInsert('ITE_NVLCRI');


    pAddSQLInsert('ITE_ITEBAS');
    pAddSQLInsert('ITE_ITEPIG');
    pAddSQLInsert('ITE_BAREXP');
    pAddSQLInsert('ITE_CPRCEN');
    //Dados E-Commerce
    pAddSQLInsert('ITE_EXPSIT');
    pAddSQLInsert('ITE_EXPAPP');

    pAddSQLInsert('ITE_UNITRI');
    pAddSQLInsert('ITE_EXPPOK');

    If fCfgSis('IMPDIG') <> '2' Then
      pAddSQLInsert('ITE_IMPDIR');

    If fCfgSis('INDREV') <> '2' Then
      pAddSQLInsert('ITE_INDREV');

    pAddSQLInsert('ITE_TIPFRE');
    pAddSQLInsert('ITE_VLCFRE');
    pAddSQLInsert('ITE_QRCODE');
    pAddSQLInsert('ITE_EXPB2B');
    pAddSQLInsert('ITE_PRAVAL');

    pAddSQLInsert('ITE_VALOBR');
    pAddSQLInsert('ITE_COMPOS');
    pAddSQLInsert('ITE_ITESAC');
    pAddSQLInsert('ITE_PAISOR');

    if (fCfgSis('UTPEST', varBoolean)) then
    begin
      pAddSQLInsert('ITE_QTDPES');
      pAddSQLInsert('ITE_PORPES');
    end;

    pAddSQLInsert('ITE_PER_CI');
    pAddSQLInsert('ITE_NUMFCI');

    if (fCfgSis('UNITRI', varBoolean)) then
      pAddSQLInsert('ITE_FATUTR');

    If blnURapel Then
      pAddSQLInsert('ITE_PRAPEL');

    pAddSQLInsert('ITE_CEREPI');

    qryManipulada.SQL.Add('INSERT INTO CADITE (' + strSQLCampos + ', ITE_CODEMP, ITE_DTACAD, AUTOINCREM, ITE_CODOPE, ITE_FABRIC) VALUES ( ' +
                               strBinds + ', :ITE_CODEMP, CURDATE(), ' + fQuotedStr(fRetAutoIncrem('CADITE',  VS_strCodEmp)) + ', :ITE_CODOPE, :FABRIC)');

    qryManipulada.ParamByName('ITE_CODITE').AsString := strCodIte;
    qryManipulada.ParamByName('ITE_CODEMP').AsString := VS_StrCodEmp;
    qryManipulada.ParamByName('ITE_CODOPE').AsString := strLoginUsuarioLogado;
    If cdsDadosIns.FieldByName('ITE_CODFAB_NOV').AsString <> '' Then
      qryManipulada.ParamByName('FABRIC').AsString := '| ' + cdsDadosIns.FieldByName('ITE_CODFAB_NOV').AsString + ' |';


    pSetBind('ITE_CODFAB');
    pSetBind('ITE_DIAFOR');
    pSetBind('ITE_CODFOR');
    pSetBind('ITE_CODBAR');
    pSetBind('ITE_CODDEP');
    pSetBind('ITE_CODGRU');
    pSetBind('ITE_DESITE');
    pSetBind('ITE_DESSIM');
    pSetBind('ITE_DESFAB');
    pSetBind('ITE_CODMAR');
    pSetBind('ITE_REFERE');
    pSetBind('ITE_CODUNI');
    pSetBind('ITE_UNICOM');
    pSetBind('ITE_INCPIS');
    pSetBind('ITE_CLAIPI');
    pSetBind('ITE_EXCIPI');
    pSetBind('ITE_CDCEST');
    pSetBind('ITE_CODONU');
    pSetBind('ITE_ATICOM');
    pSetBind('ITE_ITEATI');
    pSetBind('ITE_PESOIT');
    pSetBind('ITE_PESLIQ');
    pSetBind('ITE_CODGPR');
    pSetBind('ITE_PRDGRU');
    pSetBind('ITE_GRUCMP');
    pSetBind('ITE_MLTVEN');
    pSetBind('ITE_MLTCOM');
    pSetBind('ITE_ACOOBJ');
    pSetBind('ITE_APLICA');
    pSetBind('ITE_TMPGAR');
    If strTipAbf <> '2' Then
      pSetBind('ITE_CODABF');

    If fCfgSis('TPABPC') <> '2' Then
    Begin
      pSetBind('ITE_ABFPIS');
      pSetBind('ITE_ABFCOF');
      pSetBind('ITE_ABFIPI');
    end;
    pSetBind('ITE_INFGAR');
    pSetBind('ITE_MSGLV1');
    pSetBind('ITE_MSGLV2');
    pSetBind('ITE_PEEFUT');
    pSetBind('ITE_PEFUTP');
    pSetBind('ITE_PEFFPR');
    pSetBind('ITE_NVLGIR');
    pSetBind('ITE_NVLCRI');

    pSetBind('ITE_ITEBAS', '', tpdfNao);
    pSetBind('ITE_ITEPIG');
    pSetBind('ITE_BAREXP');
    pSetBind('ITE_CPRCEN');
    //Dados E-Commerce
    pSetBind('ITE_EXPSIT');
    pSetBind('ITE_EXPAPP');

    pSetBind('ITE_UNITRI');
    pSetBind('ITE_EXPPOK');

    If fCfgSis('IMPDIG') <> '2' Then
      pSetBind('ITE_IMPDIR');

    If fCfgSis('INDREV') <> '2' Then
      pSetBind('ITE_INDREV');

    pSetBind('ITE_TIPFRE');
    pSetBind('ITE_VLCFRE');
    pSetBind('ITE_QRCODE');
    pSetBind('ITE_EXPB2B');
    pSetBind('ITE_PRAVAL');

    pSetBind('ITE_VALOBR');
    pSetBind('ITE_COMPOS');
    pSetBind('ITE_ITESAC');
    pSetBind('ITE_PAISOR');

    if (fCfgSis('UTPEST', varBoolean)) then
    begin
      pSetBind('ITE_QTDPES');
      pSetBind('ITE_PORPES');
    end;

    pSetBind('ITE_PER_CI');
    pSetBind('ITE_NUMFCI');

    if (fCfgSis('UNITRI', varBoolean)) then
      pSetBind('ITE_FATUTR');

    If blnURapel Then
      pSetBind('ITE_PRAPEL');

    pSetBind('ITE_CEREPI');

    qryManipulada.ExecSQL;
    {$EndRegion 'CADITE'}
    If fCfgSis('MOEXSI') <> 0 Then
    Begin
      qryManipulada.SQL.Clear;
      strSQLCampos := '';
      strBinds := '';
      //Dados E-Commerce
      pAddSQLInsert('ITE_DESITE','SITE');
      pAddSQLInsert('ITE_DADTEC');
      pAddSQLInsert('ITE_URLIMG');
      pAddSQLInsert('ITE_NOMITE');
      pAddSQLInsert('ITE_APLITE');
      pAddSQLInsert('ITE_INCLUS');
      pAddSQLInsert('ITE_EXPALT');
      pAddSQLInsert('ITE_EXPLAR');
      pAddSQLInsert('ITE_EXPPRO');
      pAddSQLInsert('ITE_DESSIT');
      pAddSQLInsert('ITE_CODCAT');
      pAddSQLInsert('ITE_DESTAQ');
      pAddSQLInsert('ITE_ATZPRE');

      qryManipulada.SQL.Add('INSERT INTO DESSIT ('+ strSQLCampos +  ', ITE_CODITE)VALUES (' + strBinds + ', :CODITE)');
      qryManipulada.ParamByName('CODITE').AsString := strCodIte;

      //Dados E-Commerce
      pSetBind('ITE_DESITE','SITE');
      pSetBind('ITE_DADTEC');
      pSetBind('ITE_URLIMG');
      pSetBind('ITE_NOMITE');
      pSetBind('ITE_APLITE');
      pSetBind('ITE_INCLUS');
      pSetBind('ITE_EXPALT');
      pSetBind('ITE_EXPLAR');
      pSetBind('ITE_EXPPRO');
      pSetBind('ITE_DESSIT');
      pSetBind('ITE_CODCAT');
      pSetBind('ITE_DESTAQ');
      pSetBind('ITE_ATZPRE');

      qryManipulada.ExecSQL;

      If Not fEmptyStr(cdsDadosIns.FieldByName('ITE_URLIMG_NOV').AsString) Then
        pIncluiITEURL(qryManipulada, strCodIte, cdsDadosIns.FieldByName('ITE_URLIMG_NOV').AsString,
                      cdsDadosIns.FieldByName('ITE_DESITE_SITE_NOV').AsString, 'INSERIR');

    End;
    {$Region 'ITEGER'}
    strSQLCampos := '';
    strBinds := '';
    //Iteger
    qryManipulada.SQL.Clear;

    pAddSQLInsert('ITE_CODITE');
    pAddSQLInsert('ITE_IPISAI');
    If strTipAbf = '2' Then
      pAddSQLInsert('ITE_CODABF');
    If fCfgSis('TPABPC') = '2' Then
    Begin
      pAddSQLInsert('ITE_ABFPIS');
      pAddSQLInsert('ITE_ABFCOF');
      pAddSQLInsert('ITE_ABFIPI');
    end;
    pAddSQLInsert('ITE_EXCIPI');
    pAddSQLInsert('ITE_IMPLIS');
    pAddSQLInsert('ITE_PRECOM');
    pAddSQLInsert('ITE_PRECUS');
    pAddSQLInsert('ITE_DESF01');
    pAddSQLInsert('ITE_DESF02');
    pAddSQLInsert('ITE_DESF03');
    pAddSQLInsert('ITE_DESF04');
    pAddSQLInsert('ITE_DESF05');
    pAddSQLInsert('ITE_DESF06');
    pAddSQLInsert('ITE_ICMENT');
    pAddSQLInsert('ITE_SUBFED');
    pAddSQLInsert('ITE_IPIENT');
    pAddSQLInsert('ITE_FREENT');
    pAddSQLInsert('ITE_VALFRE');
    pAddSQLInsert('ITE_ACRFIN');
    pAddSQLInsert('ITE_SUBSTI');
    pAddSQLInsert('ITE_DESADB');
    pAddSQLInsert('ITE_TCIFCU');
    pAddSQLInsert('ITE_TSCUST');
    pAddSQLInsert('ITE_DEPICO');
    pAddSQLInsert('ITE_DEICMS');
    pAddSQLInsert('ITE_FATREG');
    pAddSQLInsert('ITE_OUTVAL');
    pAddSQLInsert('ITE_ICMSAI');
    pAddSQLInsert('ITE_IMPFED');
    pAddSQLInsert('ITE_DESOPE');
    pAddSQLInsert('ITE_MARBR1');
    pAddSQLInsert('ITE_COMTB1');
    pAddSQLInsert('ITE_PREVE1');
    pAddSQLInsert('ITE_MARBR2');
    pAddSQLInsert('ITE_COMTB2');
    pAddSQLInsert('ITE_PREVE2');
    pAddSQLInsert('ITE_MARBR3');
    pAddSQLInsert('ITE_COMTB3');
    pAddSQLInsert('ITE_PREVE3');
    pAddSQLInsert('ITE_MARBR4');
    pAddSQLInsert('ITE_COMTB4');
    pAddSQLInsert('ITE_PREVE4');
    pAddSQLInsert('ITE_MARBR5');
    pAddSQLInsert('ITE_COMTB5');
    pAddSQLInsert('ITE_PREVE5');
    pAddSQLInsert('ITE_MARBR6');
    pAddSQLInsert('ITE_COMTB6');
    pAddSQLInsert('ITE_PREVE6');
    pAddSQLInsert('ITE_MARBR7');
    pAddSQLInsert('ITE_COMTB7');
    pAddSQLInsert('ITE_PREVE7');
    pAddSQLInsert('ITE_COMVAR');
    pAddSQLInsert('ITE_COMATA');
    pAddSQLInsert('ITE_COMDIS');
    pAddSQLInsert('ITE_COMPRO');
    pAddSQLInsert('ITE_DESMAX');
    pAddSQLInsert('ITE_DESMSU');
    pAddSQLInsert('ITE_DESMGE');
    pAddSQLInsert('ITE_MARMIN');
    pAddSQLInsert('ITE_MARMSG');
    pAddSQLInsert('ITE_MARMGE');
    pAddSQLInsert('ITE_LOCFIS');
    pAddSQLInsert('ITE_LOCSUP');
    pAddSQLInsert('ITE_CODLSE');
    pAddSQLInsert('ITE_CPRCEN');

    pAddSQLInsert('ITE_TIPPRO');

    If fCfgSis('IMPDIG') = '2' Then
      pAddSQLInsert('ITE_IMPDIR');

    If fCfgSis('INDREV') = '2' Then
      pAddSQLInsert('ITE_INDREV');

    pAddSQLInsert('ITE_RECDEV');
    pAddSQLInsert('ITE_CODATC');

    pAddSQLInsert('ITE_SOBENC');
    pAddSQLInsert('ITE_MLTRCA');

    pAddSQLInsert('ITE_MARID1');
    pAddSQLInsert('ITE_MARID2');
    pAddSQLInsert('ITE_MARID3');
    pAddSQLInsert('ITE_MARID4');
    pAddSQLInsert('ITE_MARID5');
    pAddSQLInsert('ITE_MARID6');
    pAddSQLInsert('ITE_MARID7');

  if fCfgSis('MARPAD', varBoolean) then
    pAddSQLInsert('ITE_MARPAD');


    qryManipulada.SQL.Add('INSERT INTO ITEGER (' + strSQLCampos + ', ITE_CODEMP, ITE_ESTMIN, ITE_ESTMAX, ITE_NIVGIR, ITE_NIVCRI, ITE_DTABAL, ITE_SALBAL, ITE_ML_BAL, ITE_SALDOS, ITE_SAL_ML, AUTOINCREM) ' +
                          ' VALUES ( ' + strBinds + ', :ITE_CODEMP, :ITE_ESTMIN, :ITE_ESTMAX, :ITE_NIVGIR, :ITE_NIVCRI, (DATE_SUB(CURDATE(), INTERVAL 1 DAY)), 0, 0, 0, 0, :AUTINC)');

    qryManipulada.ParamByName('ITE_CODITE').AsString := strCodIte;
    qryManipulada.ParamByName('ITE_ESTMIN').AsInteger := cdsDadosIns.FieldByName('ITE_ESTMIN_NOV').AsInteger;
    qryManipulada.ParamByName('ITE_ESTMAX').AsInteger := cdsDadosIns.FieldByName('ITE_ESTMAX_NOV').AsInteger;
    If (fEmptyStr(cdsDadosIns.FieldByName('ITE_NIVGIR_NOV').AsString)) And
       (Not fEmptyStr(cdsDadosIns.FieldByName('ITE_NVLGIR_NOV').AsString)) Then
      qryManipulada.ParamByName('ITE_NIVGIR').AsString := cdsDadosIns.FieldByName('ITE_NVLGIR_NOV').AsString
    Else
      qryManipulada.ParamByName('ITE_NIVGIR').AsString := cdsDadosIns.FieldByName('ITE_NIVGIR_NOV').AsString;

    qryManipulada.ParamByName('ITE_NIVCRI').AsString := cdsDadosIns.FieldByName('ITE_NVLCRI_NOV').AsString;
    pSetBind('ITE_IPISAI');

    If strTipAbf = '2' Then
      pSetBind('ITE_CODABF');

    If fCfgSis('TPABPC') = '2' Then
    Begin
      pSetBind('ITE_ABFPIS');
      pSetBind('ITE_ABFCOF');
      pSetBind('ITE_ABFIPI');
    end;
    pSetBind('ITE_EXCIPI');
    pSetBind('ITE_IMPLIS');
    pSetBind('ITE_PRECOM');
    pSetBind('ITE_PRECUS');
    pSetBind('ITE_DESF01');
    pSetBind('ITE_DESF02');
    pSetBind('ITE_DESF03');
    pSetBind('ITE_DESF04');
    pSetBind('ITE_DESF05');
    pSetBind('ITE_DESF06');
    pSetBind('ITE_ICMENT');
    pSetBind('ITE_SUBFED');
    pSetBind('ITE_IPIENT');
    pSetBind('ITE_FREENT');
    pSetBind('ITE_VALFRE');
    pSetBind('ITE_ACRFIN');
    pSetBind('ITE_SUBSTI');
    pSetBind('ITE_DESADB');
    pSetBind('ITE_TCIFCU');
    pSetBind('ITE_TSCUST');
    pSetBind('ITE_DEPICO');
    pSetBind('ITE_DEICMS');
    pSetBind('ITE_FATREG');
    pSetBind('ITE_OUTVAL');
    pSetBind('ITE_ICMSAI');
    pSetBind('ITE_IMPFED');
    pSetBind('ITE_DESOPE');
    pSetBind('ITE_MARBR1');
    pSetBind('ITE_COMTB1');
    pSetBind('ITE_PREVE1');
    pSetBind('ITE_MARBR2');
    pSetBind('ITE_COMTB2');
    pSetBind('ITE_PREVE2');
    pSetBind('ITE_MARBR3');
    pSetBind('ITE_COMTB3');
    pSetBind('ITE_PREVE3');
    pSetBind('ITE_MARBR4');
    pSetBind('ITE_COMTB4');
    pSetBind('ITE_PREVE4');
    pSetBind('ITE_MARBR5');
    pSetBind('ITE_COMTB5');
    pSetBind('ITE_PREVE5');
    pSetBind('ITE_MARBR6');
    pSetBind('ITE_COMTB6');
    pSetBind('ITE_PREVE6');
    pSetBind('ITE_MARBR7');
    pSetBind('ITE_COMTB7');
    pSetBind('ITE_PREVE7');
    pSetBind('ITE_COMVAR');
    pSetBind('ITE_COMATA');
    pSetBind('ITE_COMDIS');
    pSetBind('ITE_COMPRO');
    pSetBind('ITE_DESMAX');
    pSetBind('ITE_DESMSU');
    pSetBind('ITE_DESMGE');
    pSetBind('ITE_MARMIN');
    pSetBind('ITE_MARMSG');
    pSetBind('ITE_MARMGE');
    pSetBind('ITE_LOCFIS');
    pSetBind('ITE_LOCSUP');
    pSetBind('ITE_CODLSE');
    pSetBind('ITE_CPRCEN');

    pSetBind('ITE_TIPPRO');

    If fCfgSis('IMPDIG') = '2' Then
      pSetBind('ITE_IMPDIR');

    If fCfgSis('INDREV') = '2' Then
      pSetBind('ITE_INDREV');

    pSetBind('ITE_RECDEV');
    pSetBind('ITE_CODATC');
    pSetBind('ITE_SOBENC');
    pSetBind('ITE_MLTRCA');
    pSetBind('ITE_MARID1');
    pSetBind('ITE_MARID2');
    pSetBind('ITE_MARID3');
    pSetBind('ITE_MARID4');
    pSetBind('ITE_MARID5');
    pSetBind('ITE_MARID6');
    pSetBind('ITE_MARID7');

    if fCfgSis('MARPAD', varBoolean) then
      pSetBind('ITE_MARPAD');


    While not qryEmpresa.Eof do
    begin
      If (fCfgSis('CTLEST', varInteger, qryEmpresa.FieldByName('EMP_CODEMP').AsString) <> 1) And
         Assigned(qryManipulada.FindParam('ITE_CODLSE')) Then
          qryManipulada.ParamByName('ITE_CODLSE').Value := null

      Else If (Not ((fCfgSis('GRUSEP', VarString, qryEmpresa.FieldByName('EMP_CODEMP').AsString) = 'S') Or
               (fCfgSis('TPLREC', VarString, qryEmpresa.FieldByName('EMP_CODEMP').AsString) = 'L'))) And
               Assigned(qryManipulada.FindParam('ITE_CODLSE'))  Then
             qryManipulada.ParamByName('ITE_CODLSE').Value := null;

      qryManipulada.ParamByName('ITE_CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
      qryManipulada.ParamByName('AUTINC').AsString :=  fRetAutoIncrem('ITEGER',  VS_strCodEmp);

      qryManipulada.ExecSQL;

      pIncluiRegistroSaldoPedidoCompra(strCodIte, qryEmpresa.FieldByName('EMP_CODEMP').AsString);

      qryEmpresa.Next;
    End;
    {$EndRegion 'ITEGER'}
    If Not fEmptyStr(cdsDadosIns.FieldByName('ITE_CODBAR_NOV').AsString) Then
    Begin
      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Text := 'INSERT INTO ITEBAR(AUTOINCREM, BAR_CODITE, BAR_CODBAR, BAR_CODEMP, BAR_PRINCI, BAR_COMPRA, BAR_EMBALA, BAR_EXBFAT) VALUES ('+
                                                   fQuotedStr(fRetAutoIncrem('ITEBAR', VS_strCodEmp)) + ', ' +
                                                   ' :BAR_CODITE, ' +
                                                   ' :BAR_CODBAR, ' +
                                                   ' :BAR_CODEMP, ' +
                                                   ' :BAR_PRINCI, ' +
                                                   ' :BAR_COMPRA, ' +
                                                   ' :BAR_EMBALA, ' +
                                                   ' :BAR_EXBFAT)';
      qryManipulada.ParamByname('BAR_CODITE').AsString := strCodIte ;
      qryManipulada.ParamByname('BAR_CODBAR').AsString := cdsDadosIns.FieldByName('ITE_CODBAR_NOV').AsString;
      qryManipulada.ParamByname('BAR_CODEMP').AsString := VS_strCodEmp;
      qryManipulada.ParamByname('BAR_PRINCI').AsString := '1';
      qryManipulada.ParamByname('BAR_COMPRA').AsString := '1';
      qryManipulada.ParamByname('BAR_EMBALA').AsString := '1';
      qryManipulada.ParamByname('BAR_EXBFAT').AsString := 'S';
      qryManipulada.ExecSQL;
    End;

    pIncluiMontadora(qryManipulada, cdsDadosIns);
    pIncluiEmbalagens(qryManipulada, cdsDadosIns);

    If (cdsDadosEmbDescFech.RecordCount > 0) And ( Not fEmptyStr(cdsDadosIns.FieldByName('ITE_ITEEMB_NOV').AsString)) Then
      pIncluiEmbDescFech(qryManipulada, cdsDadosIns);

    If Trim(cdsDadosIns.FieldByName('LIS_CODFOR').AsString) <> '' Then
      pIncluiITEFOR(qryManipulada, cdsDadosIns);
    qryEmpresa.First;
    pGeraGirIte;
    qryEmpresa.First;
    fAtualizaBarFabIte(strCodIte);

    If Assigned(cdsListasIteger) Then
    Begin
      cdsListasIteger.Filtered := False;
      cdsLIstasIteger.Filter := 'ID = ' + IntToStr(cdsDadosIns.FieldByName('ID').AsInteger);
      cdsListasIteger.Filtered := True;
      cdsListasIteger.First;
      If cdsListasIteger.RecordCount > 0 Then
        pAtualizaListaIteger(strCodite, qryManipulada);
    end;

    TCadLot.fGeraADefinirWMS(strCodIte);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmImportCadProdutoConfirma.fAtualizaCampos]');
    End;
  End;
End;

function TfrmImportCadProdutoConfirma.fItemJaInserido: Boolean;
begin
  Result := False;
  cdsItensInseridos.First;

  If (Not fEmptyStr(cdsDadosIns.FieldByName('ITE_CODFOR_NOV').AsString)) And (Not fEmptyStr(cdsDadosIns.FieldByName('ITE_CODFAB_NOV').AsString)) Then
    Result := cdsItensInseridos.Locate('CODFOR;CODFAB' , VarArrayOf([cdsDadosIns.FieldByName('ITE_CODFOR_NOV').AsString, cdsDadosIns.FieldByName('ITE_CODFAB_NOV').AsString]),[])
  Else If (Not fEmptyStr(cdsDadosIns.FieldByName('ITE_CODBAR_NOV').AsString)) Then
    Result := cdsItensInseridos.Locate('CODBAR', cdsDadosIns.FieldByName('ITE_CODBAR_NOV').AsString,[])
  Else If (Not fEmptyStr(cdsDadosIns.FieldByName('ITE_DESITE_NOV').AsString)) Then
    Result := cdsItensInseridos.Locate('DESITE', cdsDadosIns.FieldByName('ITE_DESITE_NOV').AsString,[]);

  If not Result then
  Begin
    cdsItensInseridos.Insert;
    cdsItensInseridos.FieldByName('CODFOR').AsString := cdsDadosIns.FieldByName('ITE_CODFOR_NOV').AsString;
    cdsItensInseridos.FieldByName('CODFAB').AsString := cdsDadosIns.FieldByName('ITE_CODFAB_NOV').AsString;
	  cdsItensInseridos.FieldByName('DESITE').AsString := cdsDadosIns.FieldByName('ITE_DESITE_NOV').AsString;
    cdsItensInseridos.FieldByName('CODBAR').AsString := cdsDadosIns.FieldByName('ITE_CODBAR_NOV').AsString;
    cdsItensInseridos.post;
  End;

end;

function TfrmImportCadProdutoConfirma.fAtualizaCamposAux(qryManipulada: TUniQuery): boolean;
  var blnInseriuCampo: Boolean;
  strBinds, strSQLCampos: String;
  blnInfMat :Boolean;
  blnPreMat :Boolean;

  procedure pAddSQLUpdate(strCampo: string; strOrigem: string = '');
  begin
    If strOrigem <> '' Then
      strOrigem := '_' +  strOrigem;

    If cdsDadosAlt.FieldByName(strCampo + strOrigem + '_NOV').AsString <> '' Then
    begin

      qryManipulada.SQL.Add(IIf(blnInseriuCampo, ',', '') + strCampo + ' = :' +strCampo);
      qryManipulada.ParamByName(strCampo).Value := cdsDadosAlt.FieldByName(strCampo + strOrigem + '_NOV').Value;

      If (strCampo = 'ITE_IMPLIS') Then
        pAtualizaImpLisLojas(qryManipulada.ParamByName(strCampo).Value, cdsDadosAlt.FieldByName('ITE_CODITE').AsString);

      blnInseriuCampo := True;
    end;
  end;

   procedure pAddSQLInsert(strCampo: string; strOrigem: string = '');
    var blnCampoSemNovo: Boolean;
  begin
    blnCampoSemNovo := (strCampo = 'ITE_CODITE');

    If strOrigem <> '' Then
      strOrigem := '_' +  strOrigem;
    If Not (cdsDadosAlt.FieldByName(strCampo + strOrigem + IIf(blnCampoSemNovo, '', '_NOV')).Value = null) Then
    Begin
      strSQLCampos := strSQLCampos + IIf(fEmptyStr(strSQLCampos), '', ',') + strCampo;
      strBinds     := strBinds     + IIf(fEmptyStr(strBinds), '', ',') + ':' + strCampo;
    End;
  End;

  procedure pSetBind(strCampo: string; strOrigem: string = '');
  Begin
    If strOrigem <> '' Then
      strOrigem := '_' +  strOrigem;

    If Assigned(qryManipulada.FindParam(strCampo)) Then
    Begin
      qryManipulada.ParamByName(strCampo).Value := cdsDadosAlt.FieldByName(strCampo + strOrigem + '_NOV').Value;
    End;

  end;



  procedure pCamposReplica(blnResFor: Boolean);
    var
      strEmpresas: String;
  Begin
    If blnPreMat Then
      Exit;

    strEmpresas := fRetEmpresasUsamPrecoMatriz;

    If strEmpresas = (VS_strCodEmp + '_') Then
      Exit;
    blnInseriuCampo := False;

    qryManipulada.SQL.Clear;
    qryManipulada.SQL.Add('UPDATE ITEGER SET ');

    pAddSQLUpdate('ITE_DESMAX');
    pAddSQLUpdate('ITE_DESMSU');
    pAddSQLUpdate('ITE_DESMGE');
    pAddSQLUpdate('ITE_MARMIN');
    pAddSQLUpdate('ITE_MARMSG');
    pAddSQLUpdate('ITE_MARMGE');
    pAddSQLUpdate('ITE_COMVAR');
    pAddSQLUpdate('ITE_COMATA');
    pAddSQLUpdate('ITE_COMDIS');
    pAddSQLUpdate('ITE_COMPRO');
    pAddSQLUpdate('ITE_RECDEV');
    qryManipulada.SQL.Add('WHERE ITE_CODITE = ' + fQuotedStr(cdsDadosAlt.FieldByName('ITE_CODITE').AsString));
    If blnResFor Then
      qryManipulada.SQL.Add('AND LOCATE(ITE_CODEMP, :CODEMP) = 0 ')
    Else
      qryManipulada.SQL.Add('AND LOCATE(ITE_CODEMP, :CODEMP) > 0 ');

    qryManipulada.ParamByname('CODEMP').AsString := strEmpresas;
    If blnInseriuCampo Then
      qryManipulada.ExecSQL;
  End;


begin
  blnInfMat := fCfgSis('INFMAT', varBoolean);
  blnPreMat := fPreMat;
  Result := True;
  blnInseriuCampo := False;
  Try
    qryManipulada.SQL.Clear;
    qryManipulada.SQL.Add('UPDATE CADITE SET ');

    pAddSQLUpdate('ITE_CODDEP');
    pAddSQLUpdate('ITE_CODGRU');
    pAddSQLUpdate('ITE_DESITE');
    pAddSQLUpdate('ITE_DESSIM');
    pAddSQLUpdate('ITE_CODFOR');
    pAddSQLUpdate('ITE_CODFAB');
    pAddSQLUpdate('ITE_DIAFOR');

    If fEmptyStr(cdsDadosAlt.FieldByName('ITE_CODBAR').AsString) Then
      pAddSQLUpdate('ITE_CODBAR');

    pAddSQLUpdate('ITE_DESFAB');
    pAddSQLUpdate('ITE_CODMAR');
    pAddSQLUpdate('ITE_REFERE');
    pAddSQLUpdate('ITE_CODUNI');
    pAddSQLUpdate('ITE_UNICOM');
    pAddSQLUpdate('ITE_INCPIS');
    pAddSQLUpdate('ITE_CLAIPI');
    pAddSQLUpdate('ITE_EXCIPI');
    pAddSQLUpdate('ITE_CDCEST');
    pAddSQLUpdate('ITE_CODONU');

    pAddSQLUpdate('ITE_ATICOM');
    pAddSQLUpdate('ITE_ITEATI');

    pAddSQLUpdate('ITE_PESOIT');
    pAddSQLUpdate('ITE_PESLIQ');
    pAddSQLUpdate('ITE_CODGPR');
    pAddSQLUpdate('ITE_PRDGRU');
    pAddSQLUpdate('ITE_GRUCMP');
    pAddSQLUpdate('ITE_MLTVEN');
    pAddSQLUpdate('ITE_MLTCOM');
    pAddSQLUpdate('ITE_ACOOBJ');
    pAddSQLUpdate('ITE_APLICA');
    pAddSQLUpdate('ITE_TMPGAR');
    pAddSQLUpdate('ITE_NVLGIR');

    If strTipAbf <> '2' Then
      pAddSQLUpdate('ITE_CODABF');

    If fCfgSis('TPABPC') <> '2' Then
    Begin
      pAddSQLUpdate('ITE_ABFPIS');
      pAddSQLUpdate('ITE_ABFCOF');
      pAddSQLUpdate('ITE_ABFIPI');
    end;

    pAddSQLUpdate('ITE_ITEBAS');
    pAddSQLUpdate('ITE_ITEPIG');
    pAddSQLUpdate('ITE_BAREXP');
    pAddSQLUpdate('ITE_CPRCEN');

    pAddSQLUpdate('ITE_INFGAR');
    pAddSQLUpdate('ITE_MSGLV1');
    pAddSQLUpdate('ITE_MSGLV2');
    pAddSQLUpdate('ITE_PEEFUT');
    pAddSQLUpdate('ITE_PEFUTP');
    pAddSQLUpdate('ITE_PEFFPR');

    //Dados E-Commerce
    pAddSQLUpdate('ITE_EXPSIT');
    pAddSQLUpdate('ITE_EXPAPP');
    pAddSQLUpdate('ITE_UNITRI');
    pAddSQLUpdate('ITE_EXPPOK');

    If fCfgSis('IMPDIG') <> '2' Then
      pAddSQLUpdate('ITE_IMPDIR');

    If fCfgSis('INDREV') <> '2' Then
      pAddSQLUpdate('ITE_INDREV');

    pAddSQLUpdate('ITE_TIPFRE');
    pAddSQLUpdate('ITE_VLCFRE');
    pAddSQLUpdate('ITE_QRCODE');
    pAddSQLUpdate('ITE_EXPB2B');
    pAddSQLUpdate('ITE_PRAVAL');
    pAddSQLUpdate('ITE_NVLCRI');
    pAddSQLUpdate('ITE_VALOBR');
    pAddSQLUpdate('ITE_COMPOS');
    pAddSQLUpdate('ITE_ITESAC');
    pAddSQLUpdate('ITE_PAISOR');

    if (fCfgSis('UTPEST', varBoolean)) then
    begin
      pAddSQLUpdate('ITE_QTDPES');
      pAddSQLUpdate('ITE_PORPES');
    end;

    pAddSQLUpdate('ITE_PER_CI');
    pAddSQLUpdate('ITE_NUMFCI');

    if (fCfgSis('UNITRI', varBoolean)) then
      pAddSQLUpdate('ITE_FATUTR');

    If blnURapel Then
      pAddSQLUpdate('ITE_PRAPEL');

    pAddSQLUpdate('ITE_CEREPI');

    qryManipulada.SQL.Add('WHERE ITE_CODITE = ' + fQuotedStr(cdsDadosAlt.FieldByName('ITE_CODITE').AsString));
    If blnInseriuCampo Then
      qryManipulada.ExecSQL;

    qryManipulada.SQL.Clear;
    blnInseriuCampo := False;

    If (Not fDesiteExite(cdsDadosAlt.FieldByName('ITE_CODITE').AsString, qryManipulada)) Then
    Begin
      strSQLCampos := '';
      strBinds := '';
      //Dados E-Commerce
      pAddSQLInsert('ITE_DESITE','SITE');
      pAddSQLInsert('ITE_DADTEC');
      pAddSQLInsert('ITE_URLIMG');
      pAddSQLInsert('ITE_NOMITE');
      pAddSQLInsert('ITE_APLITE');
      pAddSQLInsert('ITE_INCLUS');
      pAddSQLInsert('ITE_EXPALT');
      pAddSQLInsert('ITE_EXPLAR');
      pAddSQLInsert('ITE_EXPPRO');
      pAddSQLInsert('ITE_DESSIT');
      pAddSQLInsert('ITE_CODCAT');
      pAddSQLInsert('ITE_DESTAQ');
      pAddSQLInsert('ITE_ATZPRE');

      qryManipulada.SQL.Add('INSERT INTO DESSIT ('+ strSQLCampos +  ', ITE_CODITE)VALUES (' + strBinds + ', :CODITE)');
      qryManipulada.ParamByName('CODITE').AsString := cdsDadosAlt.FieldByName('ITE_CODITE').AsString;

      //Dados E-Commerce
      pSetBind('ITE_DESITE','SITE');
      pSetBind('ITE_DADTEC');
      pSetBind('ITE_URLIMG');
      pSetBind('ITE_NOMITE');
      pSetBind('ITE_APLITE');
      pSetBind('ITE_INCLUS');
      pSetBind('ITE_EXPALT');
      pSetBind('ITE_EXPLAR');
      pSetBind('ITE_EXPPRO');
      pSetBind('ITE_DESSIT');
      pSetBind('ITE_CODCAT');
      pSetBind('ITE_DESTAQ');
      pSetBind('ITE_ATZPRE');

      qryManipulada.ExecSQL;

      If Not fEmptyStr(cdsDadosAlt.FieldByName('ITE_URLIMG_NOV').AsString) Then
        pIncluiITEURL(qryManipulada, cdsDadosAlt.FieldByName('ITE_CODITE').AsString,cdsDadosAlt.FieldByName('ITE_URLIMG_NOV').AsString,
                      cdsDadosAlt.FieldByName('ITE_DESITE_SITE_NOV').AsString, 'INSERIR');
    End
    Else
    Begin

      qryManipulada.SQL.Add('UPDATE DESSIT SET');
      //Dados E-Commerce
      pAddSQLUpdate('ITE_DESITE','SITE');
      pAddSQLUpdate('ITE_DADTEC');
      pAddSQLUpdate('ITE_URLIMG');
      pAddSQLUpdate('ITE_NOMITE');
      pAddSQLUpdate('ITE_APLITE');
      pAddSQLUpdate('ITE_INCLUS');
      pAddSQLUpdate('ITE_EXPALT');
      pAddSQLUpdate('ITE_EXPLAR');
      pAddSQLUpdate('ITE_EXPPRO');
      pAddSQLUpdate('ITE_DESSIT');
      pAddSQLUpdate('ITE_CODCAT');
      pAddSQLUpdate('ITE_DESTAQ');
      pAddSQLUpdate('ITE_ATZPRE');      

      qryManipulada.SQL.Add('WHERE ITE_CODITE = ' + fQuotedStr(cdsDadosAlt.FieldByName('ITE_CODITE').AsString));
      If blnInseriuCampo Then
        qryManipulada.ExecSQL;

      If Not fEmptyStr(cdsDadosAlt.FieldByName('ITE_URLIMG_NOV').AsString) Then
        pIncluiITEURL(qryManipulada, cdsDadosAlt.FieldByName('ITE_CODITE').AsString,cdsDadosAlt.FieldByName('ITE_URLIMG_NOV').AsString,
                      cdsDadosAlt.FieldByName('ITE_DESITE_SITE_NOV').AsString, 'ATUALIZAR');

    End;

    qryManipulada.SQL.Clear;
    blnInseriuCampo := False;
    qryManipulada.SQL.Add('UPDATE ITEGER SET');
    pAddSQLUpdate('ITE_IPISAI');

    If strTipAbf = '2' Then
      pAddSQLUpdate('ITE_CODABF');

    If fCfgSis('TPABPC') = '2' Then
    Begin
      pAddSQLUpdate('ITE_ABFPIS');
      pAddSQLUpdate('ITE_ABFCOF');
      pAddSQLUpdate('ITE_ABFIPI');
    end;

    pAddSQLUpdate('ITE_EXCIPI');
    pAddSQLUpdate('ITE_IMPLIS');
    pAddSQLUpdate('ITE_COMVAR');
    pAddSQLUpdate('ITE_COMATA');
    pAddSQLUpdate('ITE_COMDIS');
    pAddSQLUpdate('ITE_COMPRO');
    pAddSQLUpdate('ITE_DESMAX');
    pAddSQLUpdate('ITE_DESMSU');
    pAddSQLUpdate('ITE_DESMGE');
    pAddSQLUpdate('ITE_MARMIN');
    pAddSQLUpdate('ITE_MARMSG');
    pAddSQLUpdate('ITE_MARMGE');
    pAddSQLUpdate('ITE_LOCFIS');
    pAddSQLUpdate('ITE_CPRCEN');
    pAddSQLUpdate('ITE_LOCSUP');
    pAddSQLUpdate('ITE_ESTMIN');
    pAddSQLUpdate('ITE_ESTMAX');

    pAddSQLUpdate('ITE_MARID1');
    pAddSQLUpdate('ITE_MARID2');
    pAddSQLUpdate('ITE_MARID3');
    pAddSQLUpdate('ITE_MARID4');
    pAddSQLUpdate('ITE_MARID5');
    pAddSQLUpdate('ITE_MARID6');
    pAddSQLUpdate('ITE_MARID7');

    If (fCfgSis('CTLEST', varInteger, qryEmpresa.FieldByName('EMP_CODEMP').AsString) =  1) And
       ((fCfgSis('GRUSEP', VarString, VS_StrCodEmp) = 'S') Or
        (fCfgSis('TPLREC', VarString, VS_StrCodEmp) = 'L')) Then
      pAddSQLUpdate('ITE_CODLSE');

    pAddSQLUpdate('ITE_NIVGIR');

    pAddSQLUpdate('ITE_TIPPRO');

    If fCfgSis('IMPDIG') = '2' Then
      pAddSQLUpdate('ITE_IMPDIR');

    If fCfgSis('INDREV') = '2' Then
      pAddSQLUpdate('ITE_INDREV');

    pAddSQLUpdate('ITE_RECDEV');

    pAddSQLUpdate('ITE_CODATC');
    pAddSQLUpdate('ITE_SOBENC');
    pAddSQLUpdate('ITE_MLTRCA');

    if fCfgSis('MARPAD', varBoolean) then
      pAddSQLUpdate('ITE_MARPAD');

    qryManipulada.SQL.Add('WHERE ITE_CODITE = ' + fQuotedStr(cdsDadosAlt.FieldByName('ITE_CODITE').AsString));
    qryManipulada.SQL.Add('  AND ITE_CODEMP = ' + fQuotedStr(VS_StrCodEmp));

    If blnInseriuCampo Then
      qryManipulada.ExecSQL;
    pCamposReplica(False);
    If blnInfMat And fEhEmpresaResponsavelFornecedor(cdsDadosAlt.FieldByName('ITE_CODFOR_NOV').AsString)Then
      pCamposReplica(True);

    strCodIte := cdsDadosAlt.FieldByName('ITE_CODITE').AsString;

    If (Not fEmptyStr(cdsDadosAlt.FieldByName('ITE_CODBAR_NOV').AsString)) And
       (Pos(cdsDadosAlt.FieldByName('ITE_CODBAR_NOV').AsString, cdsDadosAlt.FieldByName('ITE_CODBAR').AsString) = 0) Then
    Begin
      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Text := 'INSERT INTO ITEBAR(AUTOINCREM, BAR_CODITE, BAR_CODBAR, BAR_CODEMP, BAR_PRINCI, BAR_COMPRA, BAR_EMBALA, BAR_EXBFAT) VALUES ('+
                                                   fQuotedStr(fRetAutoIncrem('ITEBAR', VS_strCodEmp)) + ', ' +
                                                   ' :BAR_CODITE, ' +
                                                   ' :BAR_CODBAR, ' +
                                                   ' :BAR_CODEMP, ' +
                                                   ' :BAR_PRINCI, ' +
                                                   ' :BAR_COMPRA, ' +
                                                   ' :BAR_EMBALA, ' +
                                                   ' :BAR_EXBFAT)';

      qryManipulada.ParamByname('BAR_CODITE').AsString := strCodIte;
      qryManipulada.ParamByname('BAR_CODBAR').AsString := cdsDadosAlt.FieldByName('ITE_CODBAR_NOV').AsString;
      qryManipulada.ParamByname('BAR_CODEMP').AsString := VS_strCodEmp;

      If fEmptyStr(cdsDadosAlt.FieldByName('ITE_CODBAR').AsString) Then
      Begin
        qryManipulada.ParamByname('BAR_PRINCI').AsString := '1';
        qryManipulada.ParamByname('BAR_COMPRA').AsString := '1';
      End Else
      Begin
        qryManipulada.ParamByname('BAR_PRINCI').AsString := '0';
        qryManipulada.ParamByname('BAR_COMPRA').AsString := '0';
      End;

      qryManipulada.ParamByname('BAR_EMBALA').AsString := '1';
      qryManipulada.ParamByname('BAR_EXBFAT').AsString := 'S';
      qryManipulada.ExecSQL;
    End;

    pIncluiMontadora(qryManipulada, cdsDadosAlt);
    pIncluiEmbalagens(qryManipulada, cdsDadosAlt);

    If (cdsDadosEmbDescFech.RecordCount > 0) And ( Not fEmptyStr(cdsDadosAlt.FieldByName('ITE_ITEEMB_NOV').AsString)) Then
      pIncluiEmbDescFech(qryManipulada, cdsDadosAlt);

//    TCheckListGarantiaController.fGravarChecklistImportacaoProdutos(cdsDadosAlt, VS_strCodEmp);

    If Assigned(cdsListasIteger) Then
    Begin
      cdsListasIteger.Filtered := False;
      cdsLIstasIteger.Filter := 'ID = ' + IntToStr(cdsDadosAlt.FieldByName('ID').AsInteger);
      cdsListasIteger.Filtered := True;
      cdsListasIteger.First;
      If cdsListasIteger.RecordCount > 0 Then
        pAtualizaListaIteger(strCodite, qryManipulada);
    end;

    fAtualizaBarFabIte(strCodIte);

    If Trim(cdsDadosAlt.FieldByName('LIS_CODFOR').AsString) <> '' Then
      pIncluiITEFOR(qryManipulada, cdsDadosAlt);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmImportCadProdutoConfirma.fAtualizaCampos]');
    End;
  End;
end;

procedure TfrmImportCadProdutoConfirma.pMontarGrid;
  var
    i: integer;
    blnVisible: Boolean;
begin

  For i := 1 To 7 Do
  Begin
    blnVisible := VS_strTabPrc[i] = 'S';
    Case i of
     1: Begin
          cxgItensViewPREVE1.Visible := blnVisible;
          cxgItensViewPREVE1_NOV.Visible := blnVisible;
          cxgItensViewMARBR1.Visible := blnVisible;
          cxgItensViewMARBR1_NOV.Visible := blnVisible;
          cxgItensViewMARID1.Visible := blnVisible;
          cxgItensViewMARID1_NOV.Visible := blnVisible;
        End;
     2: Begin
          cxgItensViewPREVE2.Visible := blnVisible;
          cxgItensViewPREVE2_NOV.Visible := blnVisible;
          cxgItensViewMARBR2.Visible := blnVisible;
          cxgItensViewMARBR2_NOV.Visible := blnVisible;
          cxgItensViewMARID2.Visible := blnVisible;
          cxgItensViewMARID2_NOV.Visible := blnVisible;
        End;
     3: Begin
          cxgItensViewPREVE3.Visible := blnVisible;
          cxgItensViewPREVE3_NOV.Visible := blnVisible;
          cxgItensViewMARBR3.Visible := blnVisible;
          cxgItensViewMARBR3_NOV.Visible := blnVisible;
          cxgItensViewMARID3.Visible := blnVisible;
          cxgItensViewMARID3_NOV.Visible := blnVisible;
        End;
     4: Begin
          cxgItensViewPREVE4.Visible := blnVisible;
          cxgItensViewPREVE4_NOV.Visible := blnVisible;
          cxgItensViewMARBR4.Visible := blnVisible;
          cxgItensViewMARBR4_NOV.Visible := blnVisible;
          cxgItensViewMARID4.Visible := blnVisible;
          cxgItensViewMARID4_NOV.Visible := blnVisible;
        End;
     5: Begin
          cxgItensViewPREVE5 .Visible := blnVisible;
          cxgItensViewPREVE5_NOV.Visible := blnVisible;
          cxgItensViewMARBR5.Visible := blnVisible;
          cxgItensViewMARBR5_NOV.Visible := blnVisible;
          cxgItensViewMARID5.Visible := blnVisible;
          cxgItensViewMARID5_NOV.Visible := blnVisible;
        End;
     6: Begin
          cxgItensViewPREVE6.Visible := blnVisible;
          cxgItensViewPREVE6_NOV.Visible := blnVisible;
          cxgItensViewMARBR6.Visible := blnVisible;
          cxgItensViewMARBR6_NOV.Visible := blnVisible;
          cxgItensViewMARID6.Visible := blnVisible;
          cxgItensViewMARID6_NOV.Visible := blnVisible;
        End;
     7: Begin
          cxgItensViewPREVE7.Visible := blnVisible;
          cxgItensViewPREVE7_NOV.Visible := blnVisible;
          cxgItensViewMARBR7.Visible := blnVisible;
          cxgItensViewMARBR7_NOV.Visible := blnVisible;
          cxgItensViewMARID7.Visible := blnVisible;
          cxgItensViewMARID7_NOV.Visible := blnVisible;
        End;
    End;
  End;
 {
  if (cxgItensViewMARBR1_NOV.Visible and cxgItensViewPREVE1_NOV.Visible) Then
  begin
    cxgItensViewMARBR1_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE1_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR2_NOV.Visible and cxgItensViewPREVE2_NOV.Visible) Then
  begin
    cxgItensViewMARBR2_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE2_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR3_NOV.Visible and cxgItensViewPREVE3_NOV.Visible) Then
  begin
    cxgItensViewMARBR3_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE3_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR4_NOV.Visible and cxgItensViewPREVE4_NOV.Visible) Then
  begin
    cxgItensViewMARBR4_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE4_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR5_NOV.Visible and cxgItensViewPREVE5_NOV.Visible) Then
  begin
    cxgItensViewMARBR5_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE5_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR6_NOV.Visible and cxgItensViewPREVE6_NOV.Visible) Then
  begin
    cxgItensViewMARBR6_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE6_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR7_NOV.Visible and cxgItensViewPREVE7_NOV.Visible) Then
  begin
    cxgItensViewMARBR7_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE7_NOV.Visible := blnPrecoVenda;
  End;
  }
  cxgItensViewDESADB.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  cxgItensViewDESADB_NOV.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')(Novo)';

  cxgItensViewOUTVAL.Caption := fCfgSis('DOVCPP') + ' (+)';
  cxgItensViewOUTVAL_NOV.Caption := fCfgSis('DOVCPP') + ' (+)(Novo)';

  cxgItensViewVALFRE.Caption := fCfgSis('DESVFR');
  cxgItensViewVALFRE_NOV.Caption := fCfgSis('DESVFR') + '(Novo)';

  cxItensIns.ApplyBestFit(cxgItensViewDESADB);
  cxItensIns.ApplyBestFit(cxgItensViewDESADB_NOV);

  cxgItensViewCODLSE.Visible :=  (fCfgSis('CTLEST', varInteger, VS_StrCodEmp) = 1) And ((fCfgSis('GRUSEP', VarString, VS_StrCodEmp) = 'S') Or (fCfgSis('TPLREC', VarString, VS_StrCodEmp) = 'L'));
  cxgItensViewCODLSE_NOV.Visible := cxgItensViewCODLSE.Visible;

  cxItensIns.ApplyBestFit(cxgItensViewOUTVAL);
  cxItensIns.ApplyBestFit(cxgItensViewOUTVAL_NOV);

  cxItensIns.ApplyBestFit(cxgItensViewVALFRE);
  cxItensIns.ApplyBestFit(cxgItensViewVALFRE_NOV);
end;

procedure TfrmImportCadProdutoConfirma.pIncluiEmbalagens(qryManipulada: TUniQuery; cdsProcesso: TZClient);
  var
    objIteBar : TIteBar;
    strCodBar: String;
begin
  cdsDadosEmbalagem.Filtered := False;
  cdsDadosEmbalagem.Filter := 'ID = ' + QuotedStr(cdsProcesso.FieldByName('ID').AsString);
  cdsDadosEmbalagem.Filtered := True;

  If cdsDadosEmbalagem.IsEmpty Then
    Exit;

  objIteBar := TItebar.Create(opcOperacoes);
  objIteBar.pCarregaDados(strCodIte);
  While not cdsDadosEmbalagem.EoF Do
  begin
    If (cdsDadosEmbalagem.FieldByName('BAR_CODBAR').AsString = '') And
       (cdsDadosEmbalagem.FieldByName('BAR_GERAUT').AsInteger = 1) Then
       strCodBar := objIteBar.fGeraCodBarAuto(cdsDadosEmbalagem.FieldByName('BAR_EMBALA').AsFloat)
    Else
      strCodBar := cdsDadosEmbalagem.FieldByName('BAR_CODBAR').AsString;

    If strCodBar = '' Then
    Begin
      cdsDadosEmbalagem.Next;
      Continue;
    End;

    objIteBar.pIncluiCodigo(strCodBar,
                            cdsDadosEmbalagem.FieldByName('BAR_EMBALA').AsFloat,
                            cdsDadosEmbalagem.FieldByName('BAR_PRINCI').AsInteger = 1,
                            cdsDadosEmbalagem.FieldByName('BAR_COMPRA').AsInteger = 1,
                            cdsDadosEmbalagem.FieldByName('BAR_EXBFAT').AsString  = 'S',
                            cdsDadosEmbalagem.FieldByName('BAR_PREVEN').Asfloat,
                            cdsDadosEmbalagem.FieldByName('BAR_DESCRI').AsString,
                            cdsDadosEmbalagem.FieldByName('BAR_TABPRE').AsString,
                            cdsDadosEmbalagem.FieldByName('BAR_CODFOR').AsString,
                            cdsDadosEmbalagem.FieldByName('BAR_ALTURA').AsFloat,
                            cdsDadosEmbalagem.FieldByName('BAR_LARGUR').AsFloat,
                            cdsDadosEmbalagem.FieldByName('BAR_PROFUN').AsFloat,
                            cdsDadosEmbalagem.FieldByName('BAR_LASTRO').AsInteger,
                            cdsDadosEmbalagem.FieldByName('BAR_CAMADA').AsInteger,
                            cdsDadosEmbalagem.FieldByName('BAR_EMPMAX').AsInteger,
                            cdsDadosEmbalagem.FieldByName('BAR_PESOBR').AsFloat,
                            cdsDadosEmbalagem.FieldByName('BAR_PESOLQ').AsFloat,
                            True);

    cdsDadosEmbalagem.Next;
  End;
  objIteBar.pSalvaDados(strCodIte, True);

end;

procedure TfrmImportCadProdutoConfirma.pIncluiITEFOR(qryManipulada: TUniQuery;
  cdsProcesso: TZClient);
  var i: integer;
    intQtdLinhas: Integer;
    strCodIteRet,
    strCodFor,
    strCodCNA,
    strCodFab: string;
begin

  FLista.DelimitedText := cdsProcesso.FieldByName('LIS_CODFOR').AsString;
  intQtdLinhas := FLista.Count;


  For i := 0 To intQtdLinhas -1 Do
  Begin
    strCodCNA := '';
    FLista.DelimitedText := cdsProcesso.FieldByName('LIS_CODFOR').AsString;
    strCodFor := FLista.Strings[i];
    FLista.DelimitedText := cdsProcesso.FieldByName('LIS_CODFAB').AsString;
    strCodFab := FLista.Strings[i];
    FLista.DelimitedText := cdsProcesso.FieldByName('LIS_CODCNA').AsString;
    If i < FLista.Count  Then
      strCodCNA := FLista.Strings[i];

    qryManipulada.SQL.Clear;
    strCodIteRet := '';
    fValidaCodForFabItem(strCodFor, strCodFab, strCodIte, True, strCodIteRet);
    If (strCodIteRet = '') And (Not fFornecedorJaRelacionadoComItem(strCodFor)) Then
    Begin
      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Add('INSERT INTO ITEFOR (ITE_CODITE, ITE_CODITF, ITE_CODCNA, ITE_CODFOR, ITE_CODEMP, AUTOINCREM) VALUES ');
      qryManipulada.SQL.Add('(:CODITE, :CODITF, :CODCNA, :CODFOR, :CODEMP, :AUTINC)');

      qryManipulada.ParamByName('CODEMP').AsString := VS_StrCodEmp;
      qryManipulada.ParamByName('AUTINC').AsString := fRetAutoincrem('ITEFOR', VS_StrCodEmp);

    End
    Else
    Begin
      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Add('UPDATE ITEFOR SET ITE_CODITF = :CODITF');
      If strCodCNA <> '' Then
        qryManipulada.SQL.Add('                  ,ITE_CODCNA = :CODCNA');
      qryManipulada.SQL.Add(' WHERE ITE_CODFOR = :CODFOR');
      qryManipulada.SQL.Add('   AND ITE_CODITE = :CODITE');

    End;
    qryManipulada.ParamByName('CODITE').AsString := strCodIte;
    qryManipulada.ParamByName('CODITF').AsString := strCodFab;
    If strCodCNA <> '' Then
      qryManipulada.ParamByName('CODCNA').AsString := strCodCna;
    qryManipulada.ParamByName('CODFOR').AsString := strCodFor;
    qryManipulada.ExecSQL;
  End;
end;

procedure TfrmImportCadProdutoConfirma.pIncluiMontadora(qryManipulada: TUniQuery; cdsProcesso: TZClient);
var i: integer;
    strIntCodMon: string;
begin
  FLista.CommaText := cdsProcesso.FieldByName('ITE_CODMON_NOV').AsString;
  qryManipulada.SQL.Clear;
  qryManipulada.SQL.Add('INSERT INTO ITEMON (AUTOINCREM, ITM_CODMON, ITM_CODITE) VALUES ');
  qryManipulada.SQL.Add(' (:AUTINC, :CODMON, :CODITE)');
  For i := 0 To FLista.Count -1 do
  Begin
    If pos(FLista[i], cdsProcesso.FieldByName('ITE_CODMON').AsString) =  0 Then
    Begin
      strIntCodMon := fRetAutoincrem('ITEMON', VS_strCodEmp);
      qryManipulada.ParamByname('AUTINC').AsString := strIntCodMon;
      qryManipulada.ParamByname('CODMON').AsString := FLista[i];
      qryManipulada.ParamByname('CODITE').AsString := strCodIte;
      qryManipulada.ExecSQL;
    End;
  End;
end;


procedure TfrmImportCadProdutoConfirma.pIncluiITEURL(qryManipulada: TUniQuery; strCodIte, strEndere, strDescri, strAcao: String);
var strAutInc: string;

    procedure pInserirITEURL();
    Begin
      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Add('INSERT INTO ITEURL (AUTOINCREM, URL_CODITE, URL_DESCRI, URL_ENDERE, URL_PRINCI) VALUES ');
      qryManipulada.SQL.Add(' (:AUTINC, :CODITE, :DESCRI, :ENDERE, :PRINCI )');

      strAutInc := fRetAutoincrem('ITEURL', VS_strCodEmp);
      qryManipulada.ParamByname('AUTINC').AsString := strAutInc;
      qryManipulada.ParamByname('CODITE').AsString := strCodIte;
      qryManipulada.ParamByname('DESCRI').AsString := strDescri;
      qryManipulada.ParamByname('ENDERE').AsString := strEndere;
      qryManipulada.ParamByname('PRINCI').AsString := '1';

      qryManipulada.ExecSQL;

      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Add('UPDATE ITEURL SET URL_PRINCI = 0 ');
      qryManipulada.SQL.Add('WHERE URL_CODITE = :CODITE ');
      qryManipulada.SQL.Add('AND AUTOINCREM <> :AUTINC ');

      qryManipulada.ParamByname('CODITE').AsString := strCodIte;
      qryManipulada.ParamByname('AUTINC').AsString := strAutInc;
      qryManipulada.ExecSQL;

    End;

begin

  If strAcao = 'INSERIR' Then
    pInserirITEURL
  Else
  Begin
    If fURLJaCadastradaComItem(strCodIte, strEndere, strDescri) Then
    Begin
      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Add('DELETE FROM ITEURL ');
      qryManipulada.SQL.Add('WHERE URL_CODITE = :CODITE ');
      qryManipulada.SQL.Add('AND URL_ENDERE = :ENDERE');

      qryManipulada.ParamByname('CODITE').AsString := strCodIte;
      qryManipulada.ParamByname('ENDERE').AsString := strEndere;
      qryManipulada.ExecSQL;

      qryManipulada.SQL.Clear;
      qryManipulada.SQL.Add('DELETE FROM ITEURL ');
      qryManipulada.SQL.Add('WHERE URL_CODITE = :CODITE ');
      qryManipulada.SQL.Add('AND URL_DESCRI = :DESCRI');

      qryManipulada.ParamByname('CODITE').AsString := strCodIte;
      qryManipulada.ParamByname('DESCRI').AsString := strDescri;
      qryManipulada.ExecSQL;

    End;

    pInserirITEURL;

  End;

end;

function TfrmImportCadProdutoConfirma.fURLJaCadastradaComItem(strCodIte, strEndere, strDescri: string): Boolean;
begin
  qryCRUD.SQL.Clear;
  qryCRUD.SQL.Text := 'SELECT COUNT(1) AS QTD FROM ITEURL WHERE URL_CODITE = :CODITE AND ((URL_ENDERE = :ENDERE) OR (URL_DESCRI = :DESCRI))';
  qryCRUD.ParamByName('CODITE').AsString := strCodIte;
  qryCRUD.ParamByName('ENDERE').AsString := strEndere;
  qryCRUD.ParamByName('DESCRI').AsString := strDescri;
  qryCRUD.Open;

  Result := qryCRUD.FieldByName('QTD').AsInteger > 0;
end;


function TfrmImportCadProdutoConfirma.fExibirTela(cdsDados, cdsEmbalagem, cdsItensEmbDescFech, cdsListas: TZClient; strPath, PreVenMarbruSel, strBlnRedPrecoVenda: String): integer;
begin
  blnTabPrf := fCfgSis('TABPRF', varBoolean);

  FstrPath := strPath;
  FPreVenMarbruSel := PreVenMarbruSel;
  FstrBlnRedPrecoVenda := strBlnRedPrecoVenda;

  cdsDadosAlt := TZClient.Create(Self, '');
  cdsListasIteger := cdsListas;
  cdsDadosIns := TZClient.Create(Self, '');
  cdsDadosEmbalagem := cdsEmbalagem;
  cdsDadosEmbDescFech := cdsItensEmbDescFech;
  cdsRelatorio := TZClient.Create(Self, '');
  dtsEmbalagens.DataSet := cdsDadosEmbalagem;
  dtsEmbDescFech.DataSet := cdsItensEmbDescFech;
  cdsDadosPrecoReduzido := TZClient.Create(Self, '');
  qryCRUD := fCriaQuery;
  qryEmpresa := fCriaQuery;
  qryLog := fCriaQuery;
  FLista:= TStringList.Create;

  chkExibirEmbala.Checked := False;

  intPrimeiroAno := fRetPrimeiroAnoGiro;
  FLista.StrictDelimiter := True;
  FLista.Delimiter := ',';
  blnProCod := fUsaProCodigo('CADITE');
  qryEmpresa.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
  qryEmpresa.Open;

  {****************************************************************************}
  {* import 1 = Ocorreu tudo certo durante a Importação                               }
  {* import 2 = A calculo para a tabela de preço excedeu 100% do valor do produto     }
  {* import 0 = Não foi possivel localizar o produto informado no excel sera inserido              }
  {****************************************************************************}
  cdsDados.Filtered := True;
  cdsDados.Filter := 'IMPORT = 1 AND SEMRED = 0';
  cdsDadosAlt.SetProvider(cdsDados);
  cdsDadosAlt.Open;
  cdsDadosAlt.AggregatesActive := False;
  dtsDados.DataSet := cdsDadosAlt;

  cdsDados.Filter := 'IMPORT = 0 ';
  cdsDadosIns.SetProvider(cdsDados);
  cdsDadosIns.Open;
  cdsDadosIns.AggregatesActive := False;
  dtsDadosIns.DataSet := cdsDadosIns;

  cdsDados.Filter := 'SEMRED = 1 ';
  cdsDadosPrecoReduzido.SetProvider(cdsDados);
  cdsDadosPrecoReduzido.Open;

  cdsDados.Filter := 'IMPORT = 2 ';
  cdsRelatorio.SetProvider(cdsDados);
  cdsRelatorio.Open;

  tbsAltera.Enabled := cdsDadosAlt.RecordCount > 0;

  btnRelProdCad.Enabled := cdsDadosIns.RecordCount > 0;
  tbsInclui.Enabled  := cdsDadosIns.RecordCount > 0;
  btnRelSemReducao.Enabled := cdsDadosPrecoReduzido.RecordCount > 0;

  // PELO MENOS UMA ABA FICA VISÍVEL - PARA NAO FICAR UMA TELA EM BRANCO
  If tbsAltera.Enabled Then
  Begin
    pgcContainer.ActivePage := tbsAltera;

    If Not tbsInclui.Enabled Then
      tbsInclui.TabVisible := False;

  End

  Else If tbsInclui.Enabled Then
  Begin
    pgcContainer.ActivePage := tbsInclui;

    If Not tbsAltera.Enabled Then
      tbsAltera.TabVisible := False;
  End;

  frxRelatorio.DataSet := cdsRelatorio;

  btnConfirma.Enabled := ((cdsDadosAlt.RecordCount > 0) Or (cdsDadosIns.RecordCount > 0));
  btnVisProdNaoImp.Enabled := cdsRelatorio.RecordCount > 0;
  pnlInfo.Caption := 'Itens que serão alterados: ' + IntToStr(cdsDadosAlt.RecordCount);
  pnlInfo.Caption := pnlInfo.Caption + '    Itens que serão inseridos: '   + IntToStr(cdsDadosIns.RecordCount);
  pnlInfo.Caption := pnlInfo.Caption + '    Itens Processados com Falha: '   + IntToStr(cdsRelatorio.RecordCount);

//  cdsDadosAlt.AfterScroll := pAfterScrollUpdate;
//  cdsDadosIns.AfterScroll := pAfterScrollUpdate;

  pMontarGrid;
  chkExibirEmbala.Checked := True;

  Self.Showmodal;
  Result := mrOK;
end;

procedure TfrmImportCadProdutoConfirma.pIncluiEmbDescFech(qryManipulada: TUniQuery; cdsProcesso: TZClient);
var strIntCodEmbDescFech: string;
    objDescEmbalagemFechada : TDescEmbalagemFechada;
begin

  If (fCfgSis('TPDCEM', varString) = '2') Then
  Begin
    Try
      objDescEmbalagemFechada := TDescEmbalagemFechada.Create(cdsDadosEmbDescFech, strCodIte);
      objDescEmbalagemFechada.pReplicarIteEmbEmpresas;
    Finally
      FreeAndNil(objDescEmbalagemFechada);
    End;
  End
  Else
  Begin

    qryManipulada.SQL.Clear;
    qryManipulada.SQL.Add('INSERT INTO ITEEMB (AUTOINCREM, ITB_CODEMP,  ITB_CODITE,  ITB_DESCON, ITB_QTDEMB,  ITB_TABPRE, ITB_PRIROM  ) VALUES ');
    qryManipulada.SQL.Add(' (:AUTINC, :CODEMP, :CODITE, :DESCON, :QTDEMB, :TABPRE, :PRIROM )');

    cdsDadosEmbDescFech.first;

    While not cdsDadosEmbDescFech.Eof do
    Begin
      If (cdsDadosEmbDescFech.FieldByName('ITB_CODITE').AsString = strCodIte) And (cdsDadosEmbDescFech.FieldByName('ITB_CODEMP').AsString = VS_strCodEmp) Then
      Begin
        strIntCodEmbDescFech := fRetAutoincrem('ITEEMB', VS_strCodEmp);
        qryManipulada.ParamByname('AUTINC').AsString := strIntCodEmbDescFech;
        qryManipulada.ParamByname('CODEMP').AsString := cdsDadosEmbDescFech.FieldByName('ITB_CODEMP').AsString;
        qryManipulada.ParamByname('CODITE').AsString := cdsDadosEmbDescFech.FieldByName('ITB_CODITE').AsString;
        qryManipulada.ParamByname('DESCON').AsFloat  := cdsDadosEmbDescFech.FieldByName('ITB_DESCON').AsFloat;
        qryManipulada.ParamByname('QTDEMB').AsFloat  := cdsDadosEmbDescFech.FieldByName('ITB_QTDEMB').AsFloat;
        qryManipulada.ParamByname('TABPRE').AsString := cdsDadosEmbDescFech.FieldByName('ITB_TABPRE').AsString;
        qryManipulada.ParamByname('PRIROM').AsString := 'N';
        qryManipulada.ExecSQL;
      End;

      cdsDadosEmbDescFech.next;
    End;

  End;

end;

function TfrmImportCadProdutoConfirma.fFornecedorJaRelacionadoComItem(
  strCodFor: string): Boolean;
begin
  qryCRUD.SQL.Clear;
  qryCRUD.SQL.Text := 'SELECT COUNT(1) AS QTD FROM ITEFOR WHERE ITE_CODITE = "' + strCodIte + '" AND ITE_CODFOR = "' + strCodFor + '"';
  qryCRUD.Open;
  Result := qryCRUD.FieldByName('QTD').AsInteger > 0;
end;

procedure TfrmImportCadProdutoConfirma.pGeraGirIte;
  Var
    qryGirIte: TUniQuery;
    intCampos, intAno : Integer;
Begin
  qryGirIte := fCriaQuery;
  Try
    qryGirIte.SQL.Text := 'SELECT * FROM GIRITE WHERE FALSE';
    qryGirIte.Open;
    While Not qryEmpresa.Eof Do
    Begin
      For intAno := intPrimeiroAno To YearOf(VS_Date) Do
      Begin
        qryGirIte.Insert;
        For intCampos := 0 To qryGirIte.FieldCount -1 Do
          If qryGirIte.Fields[intCampos].DataType In [ftWord, ftFloat, ftInteger] Then
            qryGirIte.Fields[intCampos].Value := 0;
        qryGirIte.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GIRITE', qryEmpresa.FieldByName('EMP_CODEMP').AsString);
        qryGirIte.FieldByName('GIR_CODITE').AsString := strCodIte;
        qryGirIte.FieldByName('GIR_CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
        qryGirIte.FieldByName('GIR_A_N_O_').AsString := IntToStr(intAno);
        qryGirIte.Post;
      End;
      qryEmpresa.Next;
    End;
  Finally
    FreeAndNil(qryGirIte);
  End;
End;


procedure TfrmImportCadProdutoConfirma.pSetaTipoPrecoEmbalagem;
begin
  If fCfgSis('PREEMB', VarString) = '1' Then
  Begin
    cxgEmbalaPreVen.Caption := 'Preço de Venda';
    cxgEmbalaPreVen.DataBinding.FieldName := 'BAR_PREVEN';
    cxgEmbalaPreVen.HeaderAlignmentHorz := taRightJustify;
  End
  Else
  Begin
    cxgEmbalaPreVen.Caption := 'Tabela de Preço';
    cxgEmbalaPreVen.DataBinding.FieldName := 'BAR_TABPRE';
    cxgEmbalaPreVen.HeaderAlignmentHorz := taLeftJustify;
  End;
end;

function TfrmImportCadProdutoConfirma.fCompararCampos(objCampoAntigo, objCampoNovo: TField): Boolean;
Begin
  Result := false;
  If Assigned(objCampoNovo) Then
  Begin
    case objCampoAntigo.DataType of
      ftTime,
      ftDate,
      ftDateTime
        : Result := objCampoAntigo.AsDateTime = objCampoNovo.AsDateTime;

      ftString,
      ftWideString,
      ftMemo
        : Result := objCampoAntigo.AsString = objCampoNovo.AsString;

      ftFloat,
      ftBCD,
      ftCurrency,
      ftInteger,
      ftSmallint,
      ftWord,
      ftLargeint
        : Result := objCampoAntigo.AsCurrency = objCampoNovo.AsCurrency;
    else
      Result := objCampoAntigo.Value = objCampoNovo.Value;
    End;
  End;
End;

procedure TfrmImportCadProdutoConfirma.pGravaLogAlteracaoCPR(strCodIte, strNomCam: String; varValorNovo, varValorAntigo: Variant; objTipo: TFieldType);
Var
  qryLogCpr: TUniQuery;
Begin
  qryLogCpr := fCriaQuery;
  Try
    qryLogCpr.SQL.Text := 'SELECT * FROM LOGCPR WHERE FALSE';
    qryLogCpr.Open;
    qryLogCpr.Append;
    qryLogCpr.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCPR', VS_strCodEmp);
    qryLogCpr.FieldByName('LOG_CODITE').AsString := strCodIte;
    qryLogCpr.FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
    qryLogCpr.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
    qryLogCpr.FieldByName('LOG_HORALT').AsDateTime := fTime();
    qryLogCpr.FieldByName('LOG_NOMCAM').AsString := fUpper(strNomCam);
    qryLogCpr.FieldByName('LOG_EMPLOG').AsString := VS_strCodEmp;
    qryLogCpr.FieldByName('LOG_EMPFIS').AsString := fRetEmpresaFisica;

    Case objTipo of
      ftFloat:
      Begin
        If varValorAntigo <> null Then
          qryLogCpr.FieldByName('LOG_VALANT').AsString := FormatFloat('#,##0.00', varValorAntigo);
        If varValorNovo <> null Then
        qryLogCpr.FieldByName('LOG_VALPOS').AsString := FormatFloat('#,##0.00', varValorNovo);
      End;

      ftTime:
      Begin
        If varValorAntigo <> null Then
          qryLogCpr.FieldByName('LOG_VALANT').AsString := FormatFloat('HH:NN', varValorAntigo);
        If varValorNovo <> null Then
        qryLogCpr.FieldByName('LOG_VALPOS').AsString := FormatFloat('HH:NN', varValorNovo);
      End;

      ftDate:
      Begin
        If varValorAntigo <> null Then
          qryLogCpr.FieldByName('LOG_VALANT').AsString := FormatFloat('DD/MM/YYYY', varValorAntigo);
        If varValorNovo <> null Then
        qryLogCpr.FieldByName('LOG_VALPOS').AsString := FormatFloat('DD/MM/YYYY', varValorNovo);
      End;

      ftDateTime:
      Begin
        If varValorAntigo <> null Then
          qryLogCpr.FieldByName('LOG_VALANT').AsString := FormatFloat('DD/MM/YYYY', varValorAntigo);
        If varValorNovo <> null Then
        qryLogCpr.FieldByName('LOG_VALPOS').AsString := FormatFloat('DD/MM/YYYY', varValorNovo);
      End;

      ftWord,
      ftInteger,
      ftMemo,
      ftString:
      Begin
        If varValorAntigo <> null Then
          qryLogCpr.FieldByName('LOG_VALANT').Value := varValorAntigo;
        If varValorNovo <> null Then
          qryLogCpr.FieldByName('LOG_VALPOS').Value := varValorNovo;
      End;
    End;
    qryLogCpr.Post;
  Finally
    FreeAndNil(qryLogCpr);
  End;

End;


end.
