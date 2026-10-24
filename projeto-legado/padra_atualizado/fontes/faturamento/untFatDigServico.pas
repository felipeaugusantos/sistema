{********************************************}
{* MUDEI A QUERY QUE ESTAVA FIXA qryCon001  *}
{* E QUE RECEBIA frmModuloCadSer.qryCadSer, *}
{* PARA qryCadSer.QUALQUER PROBLEMA É SÓ    *}
{* ARRUMAR.                                 *}
{*****************************************AC*}

unit untFatDigServico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils,
  untFuncFat, untFuncFatTypes, untTypesSistema, Uni, AppEvnts,
  BitBtnLockedIncrem, Mask, MaskEditFocus, System.UITypes,
  MemoFocus, ComboBoxFocus, DateUtils, untConstantes, frxClass, TypInfo,
  frxExportCSVTestabilidade, Vcl.ImgList, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons,
  dxGDIPlusClasses, QColorLabel, System.ImageList, Math, untLiberacao,
  untMsgLiberacao, cxImageList, cxControls, cxContainer, cxEdit, cxGroupBox,
  cxCheckBox, cxCheckGroup, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  recValoresServico = record
    strCodSer: String;
    strDescri: String;
    fltDesPra: Double;
    fltDesMax: Double;
    fltValBru: Double;
    fltValDes: Double;
    fltValLiq: Double;
  end;

type
  TfrmFatDigServico = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlTotais: TPanel;
    pnlDadosEstatisticos: TPanel;
    lbl4: TLabel;
    edtNroPro: TEditFocus;
    lblPreVis: TLabel;
    mskSerIni: TMaskEditFocus;
    lbl1: TLabel;
    mskSerFin: TMaskEditFocus;
    lbl2: TLabel;
    mmoSerObs: TMemoFocus;
    pnl1: TPanel;
    lblTotSer: TLabel;
    edtTotSer: TEditFocus;
    lbl8: TLabel;
    edtPerIss: TEditFocus;
    lbl9: TLabel;
    edtValIss: TEditFocus;
    btnAcompanhaServ: TBitBtnLocked;
    pnlDatas: TPanel;
    edtDtAgeS: TcxDateEdit;
    edtDtEntS: TcxDateEdit;
    edtHrAgeS: TMaskEditFocus;
    edtHrEntS: TMaskEditFocus;
    Label2: TLabel;
    Label4: TLabel;
    pnlPraEnt: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    edtPraEnt: TEditFocus;
    btnAgendamentosProg: TBitBtnLocked;
    Panel1: TPanel;
    lblNroCei: TLabel;
    edtNroCei: TEditFocus;
    btnAdendos: TBitBtnLocked;
    btnIdentTodos: TBitBtnLocked;
    imgIdent: TcxImageList;
    pnlPrisma: TPanel;
    lblTmpMed: TLabel;
    lblTmpTot: TLabel;
    edtTotTmp: TEditFocus;
    pnlLegenda: TPanel;
    Image1: TImage;
    ColorLabel1: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel2: TColorLabel;
    Image2: TImage;
    Image3: TImage;
    ColorLabel3: TColorLabel;
    ColorLabel6: TColorLabel;
    ColorLabel4: TColorLabel;
    lblTotIse: TLabel;
    edtTotIse: TEditFocus;
    lblTotRat: TLabel;
    edtTotRat: TEditFocus;
    imgTotRat: TImage;
    imgTotIse: TImage;
    imgTotCob: TImage;
    Label3: TLabel;
    edtRedIss: TEditFocus;
    Label6: TLabel;
    Label5: TLabel; {Serviço E = Serviço Terceirizado}
    btnDisSer: TBitBtnLocked;
    pnlAlerta: TPanel;
    pnlServicos3: TPanel;
    lblServico3: TLabel;
    lblNumSe21: TLabel;
    lblValSer3: TLabel;
    lblNumSe22: TLabel;
    lblNumSe23: TLabel;
    lblNumSe24: TLabel;
    lblNumSe25: TLabel;
    lblNumSe26: TLabel;
    lblUniSer3: TLabel;
    lblQtdSer3: TLabel;
    lblStaSer3: TLabel;
    lblTmpSer3: TLabel;
    btnMecSe21: TSpeedButton;
    btnMecSe22: TSpeedButton;
    btnMecSe23: TSpeedButton;
    btnMecSe24: TSpeedButton;
    btnMecSe25: TSpeedButton;
    btnMecSe26: TSpeedButton;
    btnObsSe21: TSpeedButton;
    btnObsSe22: TSpeedButton;
    btnObsSe24: TSpeedButton;
    btnObsSe23: TSpeedButton;
    btnObsSe26: TSpeedButton;
    btnObsSe25: TSpeedButton;
    lblPrisma3: TLabel;
    lblNumSe27: TLabel;
    btnMecSe27: TSpeedButton;
    btnObsSe27: TSpeedButton;
    lblNumSe28: TLabel;
    btnMecSe28: TSpeedButton;
    btnObsSe28: TSpeedButton;
    lblNumSe29: TLabel;
    btnMecSe29: TSpeedButton;
    btnObsSe29: TSpeedButton;
    lblNumSe30: TLabel;
    btnMecSe30: TSpeedButton;
    btnObsSe30: TSpeedButton;
    lblDecSer3: TLabel;
    lblLiqSer3: TLabel;
    btnIdent21: TSpeedButton;
    btnIdent22: TSpeedButton;
    btnIdent23: TSpeedButton;
    btnIdent24: TSpeedButton;
    btnIdent28: TSpeedButton;
    btnIdent27: TSpeedButton;
    btnIdent26: TSpeedButton;
    btnIdent25: TSpeedButton;
    btnIdent29: TSpeedButton;
    btnIdent30: TSpeedButton;
    lblBrinde3: TLabel;
    btnParSe21: TSpeedButton;
    btnParSe22: TSpeedButton;
    btnParSe23: TSpeedButton;
    btnParSe24: TSpeedButton;
    btnParSe25: TSpeedButton;
    btnParSe26: TSpeedButton;
    btnParSe27: TSpeedButton;
    btnParSe28: TSpeedButton;
    btnParSe29: TSpeedButton;
    btnParSe30: TSpeedButton;
    edtDesSe21: TEditFocus;
    edtCodSe21: TEditFocus;
    edtValSe21: TEditFocus;
    edtDesSe22: TEditFocus;
    edtCodSe22: TEditFocus;
    edtValSe22: TEditFocus;
    edtDesSe23: TEditFocus;
    edtCodSe23: TEditFocus;
    edtValSe23: TEditFocus;
    edtDesSe24: TEditFocus;
    edtCodSe24: TEditFocus;
    edtValSe24: TEditFocus;
    edtDesSe25: TEditFocus;
    edtCodSe25: TEditFocus;
    edtValSe25: TEditFocus;
    edtDesSe26: TEditFocus;
    edtCodSe26: TEditFocus;
    edtValSe26: TEditFocus;
    edtUniSe26: TEditFocus;
    edtUniSe25: TEditFocus;
    edtUniSe24: TEditFocus;
    edtUniSe23: TEditFocus;
    edtUniSe22: TEditFocus;
    edtUniSe21: TEditFocus;
    edtQtdSe26: TEditFocus;
    edtQtdSe25: TEditFocus;
    edtQtdSe24: TEditFocus;
    edtQtdSe23: TEditFocus;
    edtQtdSe22: TEditFocus;
    edtQtdSe21: TEditFocus;
    cmbStaSe21: TComboBoxFocus;
    cmbStaSe22: TComboBoxFocus;
    cmbStaSe23: TComboBoxFocus;
    cmbStaSe24: TComboBoxFocus;
    cmbStaSe25: TComboBoxFocus;
    cmbStaSe26: TComboBoxFocus;
    edtTmpSe21: TEditFocus;
    edtTmpSe22: TEditFocus;
    edtTmpSe23: TEditFocus;
    edtTmpSe24: TEditFocus;
    edtTmpSe25: TEditFocus;
    edtTmpSe26: TEditFocus;
    edtPriSe21: TEditFocus;
    edtPriSe22: TEditFocus;
    edtPriSe23: TEditFocus;
    edtPriSe24: TEditFocus;
    edtPriSe25: TEditFocus;
    edtPriSe26: TEditFocus;
    edtDesSe27: TEditFocus;
    edtCodSe27: TEditFocus;
    edtValSe27: TEditFocus;
    edtUniSe27: TEditFocus;
    edtQtdSe27: TEditFocus;
    cmbStaSe27: TComboBoxFocus;
    edtTmpSe27: TEditFocus;
    edtPriSe27: TEditFocus;
    edtDesSe28: TEditFocus;
    edtCodSe28: TEditFocus;
    edtValSe28: TEditFocus;
    edtUniSe28: TEditFocus;
    edtQtdSe28: TEditFocus;
    cmbStaSe28: TComboBoxFocus;
    edtTmpSe28: TEditFocus;
    edtPriSe28: TEditFocus;
    edtDesSe29: TEditFocus;
    edtCodSe29: TEditFocus;
    edtValSe29: TEditFocus;
    edtUniSe29: TEditFocus;
    edtQtdSe29: TEditFocus;
    cmbStaSe29: TComboBoxFocus;
    edtTmpSe29: TEditFocus;
    edtPriSe29: TEditFocus;
    edtDesSe30: TEditFocus;
    edtCodSe30: TEditFocus;
    edtValSe30: TEditFocus;
    edtUniSe30: TEditFocus;
    edtQtdSe30: TEditFocus;
    cmbStaSe30: TComboBoxFocus;
    edtTmpSe30: TEditFocus;
    edtPriSe30: TEditFocus;
    edtDecSe21: TEditFocus;
    edtDecSe22: TEditFocus;
    edtDecSe23: TEditFocus;
    edtDecSe25: TEditFocus;
    edtDecSe24: TEditFocus;
    edtDecSe26: TEditFocus;
    edtDecSe27: TEditFocus;
    edtDecSe28: TEditFocus;
    edtDecSe29: TEditFocus;
    edtDecSe30: TEditFocus;
    edtLiqSe30: TEditFocus;
    edtLiqSe29: TEditFocus;
    edtLiqSe28: TEditFocus;
    edtLiqSe27: TEditFocus;
    edtLiqSe26: TEditFocus;
    edtLiqSe25: TEditFocus;
    edtLiqSe24: TEditFocus;
    edtLiqSe23: TEditFocus;
    edtLiqSe22: TEditFocus;
    edtLiqSe21: TEditFocus;
    chkBriSe21: TCheckBox;
    chkBriSe22: TCheckBox;
    chkBriSe23: TCheckBox;
    chkBriSe24: TCheckBox;
    chkBriSe25: TCheckBox;
    chkBriSe26: TCheckBox;
    chkBriSe27: TCheckBox;
    chkBriSe28: TCheckBox;
    chkBriSe29: TCheckBox;
    chkBriSe30: TCheckBox;
    pnlServicos2: TPanel;
    lblServico2: TLabel;
    lblNumSe11: TLabel;
    lblValSer2: TLabel;
    lblNumSe12: TLabel;
    lblNumSe13: TLabel;
    lblNumSe14: TLabel;
    lblNumSe15: TLabel;
    lblNumSe16: TLabel;
    lblUniSer2: TLabel;
    lblQtdSer2: TLabel;
    lblStaSer2: TLabel;
    lblTmpSer2: TLabel;
    btnMecSe11: TSpeedButton;
    btnMecSe12: TSpeedButton;
    btnMecSe13: TSpeedButton;
    btnMecSe14: TSpeedButton;
    btnMecSe15: TSpeedButton;
    btnMecSe16: TSpeedButton;
    btnObsSe11: TSpeedButton;
    btnObsSe12: TSpeedButton;
    btnObsSe14: TSpeedButton;
    btnObsSe13: TSpeedButton;
    btnObsSe16: TSpeedButton;
    btnObsSe15: TSpeedButton;
    lblPrisma2: TLabel;
    lblNumSe17: TLabel;
    btnMecSe17: TSpeedButton;
    btnObsSe17: TSpeedButton;
    lblNumSe18: TLabel;
    btnMecSe18: TSpeedButton;
    btnObsSe18: TSpeedButton;
    lblNumSe19: TLabel;
    btnMecSe19: TSpeedButton;
    btnObsSe19: TSpeedButton;
    lblNumSe20: TLabel;
    btnMecSe20: TSpeedButton;
    btnObsSe20: TSpeedButton;
    lblDecSer2: TLabel;
    lblLiqSer2: TLabel;
    btnIdent11: TSpeedButton;
    btnIdent12: TSpeedButton;
    btnIdent13: TSpeedButton;
    btnIdent14: TSpeedButton;
    btnIdent18: TSpeedButton;
    btnIdent17: TSpeedButton;
    btnIdent16: TSpeedButton;
    btnIdent15: TSpeedButton;
    btnIdent19: TSpeedButton;
    btnIdent20: TSpeedButton;
    lblBrinde2: TLabel;
    btnParSe11: TSpeedButton;
    btnParSe12: TSpeedButton;
    btnParSe13: TSpeedButton;
    btnParSe14: TSpeedButton;
    btnParSe15: TSpeedButton;
    btnParSe16: TSpeedButton;
    btnParSe17: TSpeedButton;
    btnParSe18: TSpeedButton;
    btnParSe19: TSpeedButton;
    btnParSe20: TSpeedButton;
    edtDesSe11: TEditFocus;
    edtCodSe11: TEditFocus;
    edtValSe11: TEditFocus;
    edtDesSe12: TEditFocus;
    edtCodSe12: TEditFocus;
    edtValSe12: TEditFocus;
    edtDesSe13: TEditFocus;
    edtCodSe13: TEditFocus;
    edtValSe13: TEditFocus;
    edtDesSe14: TEditFocus;
    edtCodSe14: TEditFocus;
    edtValSe14: TEditFocus;
    edtDesSe15: TEditFocus;
    edtCodSe15: TEditFocus;
    edtValSe15: TEditFocus;
    edtDesSe16: TEditFocus;
    edtCodSe16: TEditFocus;
    edtValSe16: TEditFocus;
    edtUniSe16: TEditFocus;
    edtUniSe15: TEditFocus;
    edtUniSe14: TEditFocus;
    edtUniSe13: TEditFocus;
    edtUniSe12: TEditFocus;
    edtUniSe11: TEditFocus;
    edtQtdSe16: TEditFocus;
    edtQtdSe15: TEditFocus;
    edtQtdSe14: TEditFocus;
    edtQtdSe13: TEditFocus;
    edtQtdSe12: TEditFocus;
    edtQtdSe11: TEditFocus;
    cmbStaSe11: TComboBoxFocus;
    cmbStaSe12: TComboBoxFocus;
    cmbStaSe13: TComboBoxFocus;
    cmbStaSe14: TComboBoxFocus;
    cmbStaSe15: TComboBoxFocus;
    cmbStaSe16: TComboBoxFocus;
    edtTmpSe11: TEditFocus;
    edtTmpSe12: TEditFocus;
    edtTmpSe13: TEditFocus;
    edtTmpSe14: TEditFocus;
    edtTmpSe15: TEditFocus;
    edtTmpSe16: TEditFocus;
    edtPriSe11: TEditFocus;
    edtPriSe12: TEditFocus;
    edtPriSe13: TEditFocus;
    edtPriSe14: TEditFocus;
    edtPriSe15: TEditFocus;
    edtPriSe16: TEditFocus;
    edtDesSe17: TEditFocus;
    edtCodSe17: TEditFocus;
    edtValSe17: TEditFocus;
    edtUniSe17: TEditFocus;
    edtQtdSe17: TEditFocus;
    cmbStaSe17: TComboBoxFocus;
    edtTmpSe17: TEditFocus;
    edtPriSe17: TEditFocus;
    edtDesSe18: TEditFocus;
    edtCodSe18: TEditFocus;
    edtValSe18: TEditFocus;
    edtUniSe18: TEditFocus;
    edtQtdSe18: TEditFocus;
    cmbStaSe18: TComboBoxFocus;
    edtTmpSe18: TEditFocus;
    edtPriSe18: TEditFocus;
    edtDesSe19: TEditFocus;
    edtCodSe19: TEditFocus;
    edtValSe19: TEditFocus;
    edtUniSe19: TEditFocus;
    edtQtdSe19: TEditFocus;
    cmbStaSe19: TComboBoxFocus;
    edtTmpSe19: TEditFocus;
    edtPriSe19: TEditFocus;
    edtDesSe20: TEditFocus;
    edtCodSe20: TEditFocus;
    edtValSe20: TEditFocus;
    edtUniSe20: TEditFocus;
    edtQtdSe20: TEditFocus;
    cmbStaSe20: TComboBoxFocus;
    edtTmpSe20: TEditFocus;
    edtPriSe20: TEditFocus;
    edtDecSe11: TEditFocus;
    edtDecSe12: TEditFocus;
    edtDecSe13: TEditFocus;
    edtDecSe15: TEditFocus;
    edtDecSe14: TEditFocus;
    edtDecSe16: TEditFocus;
    edtDecSe17: TEditFocus;
    edtDecSe18: TEditFocus;
    edtDecSe19: TEditFocus;
    edtDecSe20: TEditFocus;
    edtLiqSe20: TEditFocus;
    edtLiqSe19: TEditFocus;
    edtLiqSe18: TEditFocus;
    edtLiqSe17: TEditFocus;
    edtLiqSe16: TEditFocus;
    edtLiqSe15: TEditFocus;
    edtLiqSe14: TEditFocus;
    edtLiqSe13: TEditFocus;
    edtLiqSe12: TEditFocus;
    edtLiqSe11: TEditFocus;
    chkBriSe11: TCheckBox;
    chkBriSe12: TCheckBox;
    chkBriSe13: TCheckBox;
    chkBriSe14: TCheckBox;
    chkBriSe15: TCheckBox;
    chkBriSe16: TCheckBox;
    chkBriSe17: TCheckBox;
    chkBriSe18: TCheckBox;
    chkBriSe19: TCheckBox;
    chkBriSe20: TCheckBox;
    pnlServicos1: TPanel;
    lblServico1: TLabel;
    lblNumSe1: TLabel;
    lblValSer1: TLabel;
    lblNumSe2: TLabel;
    lblNumSe3: TLabel;
    lblNumSe4: TLabel;
    lblNumSe5: TLabel;
    lblNumSe6: TLabel;
    lblUniSer1: TLabel;
    lblQtdSer1: TLabel;
    lblStaSer1: TLabel;
    lblTmpSer1: TLabel;
    btnMecSe1: TSpeedButton;
    btnMecSe2: TSpeedButton;
    btnMecSe3: TSpeedButton;
    btnMecSe4: TSpeedButton;
    btnMecSe5: TSpeedButton;
    btnMecSe6: TSpeedButton;
    btnObsSe1: TSpeedButton;
    btnObsSe2: TSpeedButton;
    btnObsSe4: TSpeedButton;
    btnObsSe3: TSpeedButton;
    btnObsSe6: TSpeedButton;
    btnObsSe5: TSpeedButton;
    lblPrisma1: TLabel;
    lblNumSe7: TLabel;
    btnMecSe7: TSpeedButton;
    btnObsSe7: TSpeedButton;
    lblNumSe8: TLabel;
    btnMecSe8: TSpeedButton;
    btnObsSe8: TSpeedButton;
    lblNumSe9: TLabel;
    btnMecSe9: TSpeedButton;
    btnObsSe9: TSpeedButton;
    lblNumSe10: TLabel;
    btnMecSe10: TSpeedButton;
    btnObsSe10: TSpeedButton;
    lblDecSer1: TLabel;
    lblLiqSer1: TLabel;
    btnIdent1: TSpeedButton;
    btnIdent2: TSpeedButton;
    btnIdent3: TSpeedButton;
    btnIdent4: TSpeedButton;
    btnIdent8: TSpeedButton;
    btnIdent7: TSpeedButton;
    btnIdent6: TSpeedButton;
    btnIdent5: TSpeedButton;
    btnIdent9: TSpeedButton;
    btnIdent10: TSpeedButton;
    lblBrinde1: TLabel;
    btnParSe1: TSpeedButton;
    btnParSe2: TSpeedButton;
    btnParSe3: TSpeedButton;
    btnParSe4: TSpeedButton;
    btnParSe5: TSpeedButton;
    btnParSe6: TSpeedButton;
    btnParSe7: TSpeedButton;
    btnParSe8: TSpeedButton;
    btnParSe9: TSpeedButton;
    btnParSe10: TSpeedButton;
    edtDesSe1: TEditFocus;
    edtCodSe1: TEditFocus;
    edtValSe1: TEditFocus;
    edtDesSe2: TEditFocus;
    edtCodSe2: TEditFocus;
    edtValSe2: TEditFocus;
    edtDesSe3: TEditFocus;
    edtCodSe3: TEditFocus;
    edtValSe3: TEditFocus;
    edtDesSe4: TEditFocus;
    edtCodSe4: TEditFocus;
    edtValSe4: TEditFocus;
    edtDesSe5: TEditFocus;
    edtCodSe5: TEditFocus;
    edtValSe5: TEditFocus;
    edtDesSe6: TEditFocus;
    edtCodSe6: TEditFocus;
    edtValSe6: TEditFocus;
    edtUniSe6: TEditFocus;
    edtUniSe5: TEditFocus;
    edtUniSe4: TEditFocus;
    edtUniSe3: TEditFocus;
    edtUniSe2: TEditFocus;
    edtUniSe1: TEditFocus;
    edtQtdSe6: TEditFocus;
    edtQtdSe5: TEditFocus;
    edtQtdSe4: TEditFocus;
    edtQtdSe3: TEditFocus;
    edtQtdSe2: TEditFocus;
    edtQtdSe1: TEditFocus;
    cmbStaSe1: TComboBoxFocus;
    cmbStaSe2: TComboBoxFocus;
    cmbStaSe3: TComboBoxFocus;
    cmbStaSe4: TComboBoxFocus;
    cmbStaSe5: TComboBoxFocus;
    cmbStaSe6: TComboBoxFocus;
    edtTmpSe1: TEditFocus;
    edtTmpSe2: TEditFocus;
    edtTmpSe3: TEditFocus;
    edtTmpSe4: TEditFocus;
    edtTmpSe5: TEditFocus;
    edtTmpSe6: TEditFocus;
    edtPriSe1: TEditFocus;
    edtPriSe2: TEditFocus;
    edtPriSe3: TEditFocus;
    edtPriSe4: TEditFocus;
    edtPriSe5: TEditFocus;
    edtPriSe6: TEditFocus;
    edtDesSe7: TEditFocus;
    edtCodSe7: TEditFocus;
    edtValSe7: TEditFocus;
    edtUniSe7: TEditFocus;
    edtQtdSe7: TEditFocus;
    cmbStaSe7: TComboBoxFocus;
    edtTmpSe7: TEditFocus;
    edtPriSe7: TEditFocus;
    edtDesSe8: TEditFocus;
    edtCodSe8: TEditFocus;
    edtValSe8: TEditFocus;
    edtUniSe8: TEditFocus;
    edtQtdSe8: TEditFocus;
    cmbStaSe8: TComboBoxFocus;
    edtTmpSe8: TEditFocus;
    edtPriSe8: TEditFocus;
    edtDesSe9: TEditFocus;
    edtCodSe9: TEditFocus;
    edtValSe9: TEditFocus;
    edtUniSe9: TEditFocus;
    edtQtdSe9: TEditFocus;
    cmbStaSe9: TComboBoxFocus;
    edtTmpSe9: TEditFocus;
    edtPriSe9: TEditFocus;
    edtDesSe10: TEditFocus;
    edtCodSe10: TEditFocus;
    edtValSe10: TEditFocus;
    edtUniSe10: TEditFocus;
    edtQtdSe10: TEditFocus;
    cmbStaSe10: TComboBoxFocus;
    edtTmpSe10: TEditFocus;
    edtPriSe10: TEditFocus;
    edtDecSe1: TEditFocus;
    edtDecSe2: TEditFocus;
    edtDecSe3: TEditFocus;
    edtDecSe5: TEditFocus;
    edtDecSe4: TEditFocus;
    edtDecSe6: TEditFocus;
    edtDecSe7: TEditFocus;
    edtDecSe8: TEditFocus;
    edtDecSe9: TEditFocus;
    edtDecSe10: TEditFocus;
    edtLiqSe10: TEditFocus;
    edtLiqSe9: TEditFocus;
    edtLiqSe8: TEditFocus;
    edtLiqSe7: TEditFocus;
    edtLiqSe6: TEditFocus;
    edtLiqSe5: TEditFocus;
    edtLiqSe4: TEditFocus;
    edtLiqSe3: TEditFocus;
    edtLiqSe2: TEditFocus;
    edtLiqSe1: TEditFocus;
    chkBriSe1: TCheckBox;
    chkBriSe2: TCheckBox;
    chkBriSe3: TCheckBox;
    chkBriSe4: TCheckBox;
    chkBriSe5: TCheckBox;
    chkBriSe6: TCheckBox;
    chkBriSe7: TCheckBox;
    chkBriSe8: TCheckBox;
    chkBriSe9: TCheckBox;
    chkBriSe10: TCheckBox;
    btnProxPagServ: TBitBtnLocked;
    btnPagAntServ: TBitBtnLocked;
    pnlOutVen: TPanel;
    shpOutVen: TShape;
    Label1: TLabel;
    btnMecPadrao: TBitBtnLocked;
    Label7: TLabel;
    edtDedIss: TEditFocus;
    pnlMunicipioNatureza: TPanel;
    pnlNaturezaServico: TPanel;
    chkNatureza: TcxCheckGroup;
    pnlMunicipioServico: TPanel;
    rdgMunicipioServico: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodSe1KeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure edtDesSe1Change(Sender: TObject);
    procedure edtDesSe1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodSe1Enter(Sender: TObject);
    procedure btnMecSe1Click(Sender: TObject);
    procedure btnAcompanhaServClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnObsSe1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAgendamentosProgClick(Sender: TObject);
    procedure btnAdendosClick(Sender: TObject);
    procedure btnIdent1Click(Sender: TObject);
    procedure btnIdentTodosClick(Sender: TObject);
    procedure btnDisSerClick(Sender: TObject);
    procedure chkBrindeClick(Sender: TObject);
    procedure btnPagAntServClick(Sender: TObject);
    procedure btnProxPagServClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMecPadraoClick(Sender: TObject);
    function fExibeMunicipioServico: Boolean;
    function fExibeNaturezaServico: Boolean;
    function fExibeEnderecoDeEntrega: Boolean;
    procedure chkNaturezaPropertiesEditValueToStates(Sender: TObject;
      const AValue: Variant; var ACheckStates: TcxCheckStates);
    procedure chkNaturezaPropertiesStatesToEditValue(Sender: TObject;
      const ACheckStates: TcxCheckStates; out AValue: Variant);
    procedure chkNaturezaPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    blnConfirma,
    blnUsaDesc,
    blnUsaRateio,
    blnConfServicos: Boolean;

    qryCadSer: TUniQuery;

    strStatFinalServ,
    strStatNaoSeleciona,
    strCodSerAnt : String;

    FNFSeNatureza : String;

    objRegistroServOri,
    objRegistroServAtu : TRegistroMsgLibera;

    blnPedirBrinde: Boolean;

    stlLockedPrismasTmp: TStringList;

    blnFinalizouTodosServicos: Boolean;

    intLinSer: Integer;
    intDecSer: Integer;

    varPodeAlterarServicosOutrosVendedores: Variant;

    objLiberacao : TLiberacao;

    arrValoresServico: Array of recValoresServico;

    function fGetPropValue(strName: String; intServic: Integer): Variant;
    procedure pSetPropValue(strName: String; intServic: Integer; varValue: Variant);

    function fNum(strNome: String): Integer;

    function fGetComponent(strName: String; intServic: Integer): TComponent; overload;
    function fGetComponent(pnlParent: TPanel; strNome: String; intNumSer: Integer): TComponent; overload;

    function fInformarMecanicos(Var strCodMec: String): Boolean;

    function fValorMinimo(codSer: String): Double;

    function fGetBrinde(strIdeSer: String; Var strCodPar, strTipBri: String): String;
    procedure pSetBrinde(strIdeSer, strBrinde, strCodPar, strTipBri: String);

    function fCarregaPrisma(strTipSer, strName: String): String;

    function fCarregaServico(edtCodSer, edtDesSer: TEditFocus; blnBuscaPorChave: Boolean; intIndiceComponente: Integer): Boolean;
    function fValidaValor(edtValor: TEdit): Boolean;
    function fValidaQuantidade(edtQtde: TEdit): Boolean;
    function fValidaUnitario(edtUnitario: TEdit): Boolean;
    function fValidaDesconto(edtDesc: TEdit): Boolean;

    function fEhServicoOutroVendedorSemPermissaoParaAlterar(intIdeSer: Integer): Boolean;

    procedure pCarregaBrindesServico;
    procedure pCarregaStatusServico;
    procedure pDesabilitaServicosOutroVendedor;
    procedure pCarregaTempoMedioServicos;

    procedure pPermicaoAlteraValor(edtUniSer, edtValSer: TEditFocus);

    procedure pSomaValores;
    procedure pDefineNumLinhasServico;
    procedure pColorePrismas;

    function fGeraRegistroServicos: TRegistroMsgLibera;

    function fLockaPrisma(strTipSer, strPrisma: String; blnLockar: Boolean): Boolean; overload;
    function fLockaPrisma(strLockedPrisma: String; blnLockar: Boolean): Boolean; overload;

    procedure pRemanejaServicos;

//    function fValidarServicosEmBranco: Boolean;
    function fPossuiServico: Boolean;

    procedure pIdentificaServico(Sender: TObject;
                                 intIdenti: Integer;
                                 blnSomaValores: Boolean = True);

    function fGetActivePanel: TPanel;

    procedure pSetarPropriedadesServicos(intIndex: Integer);
    procedure pSetaPropriedadesGeral;
    function fLiberaAlteracaoServiçoOSGarantia(blnRegistroIgual: Boolean): Boolean;
    function fValidaIRPJ: Boolean;
    function fDescMax(strCodSer:String): Double;
    function fMecanicoEhObrigatorio: Boolean;
    function fValidaMecanicos: Boolean;
    function fServicosSemMecanicosInformados: TStringList;
    function fValidaPisCofinsCsll: Boolean;
    function fValidaDeducoes: Boolean;
    function fPodeDefinirMecanico: Boolean;
  protected
    procedure pInicializaIndices;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fatVenda: TFatVenda;
    blnSoVisualizaIdent: Boolean;
    blnNFSeSubstituicao: Boolean;
    fPedeEnderecoEntrega: TBooleanFunction;
    strMecPadrao: String;
    objServicos: TClassDadosServicos;

    procedure pCarregarServicos;

    function fGetMecanico(strIdeSer: String): String;
    procedure pSetMecanico(strIdeSer, strCodMec: String);

    function fGetObservacao(strIdeSer: String): String;
    procedure pSetObservacao(strIdeSer, strObserv: String);

    function fGetPanel(intCont: Integer): TPanel;
 end;

var
  frmFatDigServico: TfrmFatDigServico;

implementation

uses untFuncoes, untFuncoesSimples, untConsultas, Data.DB,
     untDigMecanicos, untConsultaServicosAutocenter, untFatDigServicoDigObs,
     untSQLRepositorio, untFuncoesAutocenter, untConsultaServicosAutocenterVendas,
     untFatDigIdentServico, untPanelCxServico, untPnlDadosServico, untObservacao,
     untDigInfBrinde;

{$R *.dfm}

{ TfrmFatDigServico }

function TfrmFatDigServico.fCarregaPrisma(strTipSer, strName: String): String;
Var
  qryPrisma             : TUniQuery;
  intSer,
  intPrisma,
  intQtdPri,
  intCont               : Integer;
  stlPrismaIndisponivel : TStringList;
  blnJaTemPrisma,
  blnJaUtilizado        : Boolean;
  strNumDoc,
  strNumDoc_Prisma,
  strPrismaMesmoTipoJaUtilizadoNoDoc : String;
begin
  Result := '';

  // Se não aceita prisma no tipo de serviço retorna vazio
  qryCadSer.Locate('TPS_CODIGO', strTipSer, []);
  intQtdPri := qryCadSer.FieldByName('TPS_QTDPRI').AsInteger;
  If intQtdPri = 0 Then
    Exit;

  qryPrisma := fCriaQuery;
  stlPrismaIndisponivel := TStringList.Create;
  Try
    pSQL(qryPrisma, repServicos, 'PRISMAS_DATA_MINIMA',
         [VS_strCodEmp,
          IncMonth(VS_Date, -1)]);
          
    qryPrisma.Open;

    If Assigned(fatVenda) Then
      strNumDoc := fatVenda.strNumOrc + '-' +
                   fatVenda.strEspOrc + '-' +
                   fatVenda.strEmpDoc
    Else
      strNumDoc := '';

    // Verifica se prisma já está em uso
    strPrismaMesmoTipoJaUtilizadoNoDoc := '';

    While Not qryPrisma.Eof Do
    Begin

      strNumDoc_Prisma := qryPrisma.FieldByName('FGO_NUMDOC').AsString + '-' +
                          qryPrisma.FieldByName('FGO_ESPDOC').AsString + '-' +
                          qryPrisma.FieldByName('FGO_CODEMP').AsString;

      For intSer := 1 To 30 Do
      Begin

        // Se não tem o serviço parte para próximo pedido
        If fEmptyStr(qryPrisma.FieldByName('FGO_CODS'+ fStrZero(intSer, 2)).AsString) Then
          Break;

        // Só verifica status não finalizado
        If (Pos(qryPrisma.FieldByName('FGO_STAS'+ fStrZero(intSer, 2)).AsString, strStatFinalServ) > 0) Then
          Continue;

        // Só verifica os serviços que são do mesmo tipo
        qryCadSer.Locate('SER_CODSER', qryPrisma.FieldByName('FGO_CODS'+ fStrZero(intSer, 2)).AsString, []);

        If (qryCadSer.FieldByName('SER_TIPSER').AsString <> strTipSer) Then
          Continue;

        {Se for do próprio documento fica disponível para reutilizar em novos serviços do mesmo tipo!}
        If (strNumDoc = strNumDoc_Prisma) Then
        Begin
          strPrismaMesmoTipoJaUtilizadoNoDoc := qryPrisma.FieldByName('FGO_PRIS' + fStrZero(intSer, 2)).AsString;
          Continue;
        End;

        stlPrismaIndisponivel.Add(qryPrisma.FieldByName('FGO_PRIS' + fStrZero(intSer, 2)).AsString);

      End;

      qryPrisma.Next;

    End;

    For intPrisma := 1 To intQtdPri Do
    Begin

      If stlPrismaIndisponivel.IndexOf(fStrZero(intPrisma, 4)) <> -1 Then
        Continue;

      // Verifica se o prisma já não está selecionado para outro serviço do mesmo tipo nessa mesma tela
      blnJaTemPrisma := False;
      blnJaUtilizado := False;
      For intCont := 1 To 30 Do
      Begin

        If (TEdit(fGetComponent(fGetPanel(intCont), 'edtPriSe', IntCont)).Text = fStrZero(intPrisma, 4)) Then
        Begin

          qryCadSer.Locate('SER_CODSER', TEdit(fGetComponent(fGetPanel(intCont), 'edtCodSe', IntCont)).Text, []);
          If qryCadSer.FieldByName('SER_TIPSER').AsString = strTipSer Then
          Begin
            blnJaTemPrisma := True;
            Break;
          End;

          If (strName <> TEdit(fGetComponent(fGetPanel(intCont), 'edtPriSe', IntCont)).Name) And
             (qryCadSer.FieldByName('SER_TIPSER').AsString = strTipSer) Then
            blnJaUtilizado := True;

        End;

      End;

      {Req.: 124314 - Utiliza o mesmo código de prisma}
      If Not fEmptyStr(strPrismaMesmoTipoJaUtilizadoNoDoc) Then
      Begin
        If (strPrismaMesmoTipoJaUtilizadoNoDoc <> fStrZero(intPrisma, 4)) Then
          Continue;
      End;

      If (blnJaTemPrisma) Then
      Begin
        Result := fStrZero(intPrisma, 4);
        Break;
      End;

      If blnJaUtilizado Then
        Continue;

      // Verifica se está locked, se não estiver então locka.
      If Not fLockaPrisma(strTipSer, fStrZero(intPrisma, 4), True) Then
        Continue;

      Result := fStrZero(intPrisma, 4);
      Break;
    End;

  Finally
    FreeAndNil(qryPrisma);
    FreeAndNil(stlPrismaIndisponivel);
  End;              
end;

function TfrmFatDigServico.fCarregaServico(edtCodSer, edtDesSer: TEditFocus;
  blnBuscaPorChave: Boolean; intIndiceComponente: Integer): Boolean;
  Var
    strSQL         : String;
    strMecTmp      : String;
    edtQtdSer      : TEdit;
    edtUniSer      : TEdit;
    edtValSer      : TEdit;
    edtTmpSer      : TEdit;
    edtPrisma      : TEdit;
    edtDecSer      : TEdit;
    edtLiqSer      : TEdit;
    chkBrinde      : TCheckBox;
    cmbStaSer      : TComboBox;
    intContador    : Integer;
    blnConfirmaServ: Boolean;
    qryGenSer      : TUniQuery;
begin
  qryGenSer := fCriaQuery(Self);
  Try
    blnConfServicos := False;
    blnConfirmaServ := True;
    If (fNum(edtCodSer.Name) = 1) Then
    Begin

      If (fEmptyStr(edtCodSer.Text)) Then
      Begin
        // Se houver itens separados que não voltaram para o armazém não permite retirar serviço
        If (Not fEmptyStr(fatVenda.strNumOrc)) And (fatVenda.strOpcDoc = 'PD') Then
        Begin
          If fQuantidadeItensPendenteAlmoxarifeAutocenter(fatVenda.strNumOrc, 'PD', VS_strCodEmp) > 0 Then
          Begin
            fMensagem('', 'Existem itens expedidos para esse pedido que não voltaram para o armazém. '
                        + 'Para retirar os serviços é preciso efetuar conferência de entrada dos itens!', ['&O k']);
            Result := False;
            Exit;
          End;
        End;

        blnConfirmaServ := True;
        For intContador := 2 To 6 Do
        Begin
          edtValSer := TEdit(fGetComponent('edtValSe', intContador));
          If (Not fEmptyStr(edtValSer.Text)) And (fStrToFloat(edtValSer.Text) > 0)Then
          Begin
            blnConfirmaServ := False;
            Break;
          End;
        End;
      End;

      If fatVenda.fSomenteItensDeServico(fatVenda.arrMatItens) And (fEmptyStr(edtCodSer.Text)) Then
      Begin
        blnConfirmaServ := False;
      End;

    End;

    If (Not blnConfirmaServ) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar o primeiro serviço!', ['&Ok']);
      Result := False;
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SER_DESSER,';
    strSQL := strSQL + '  SER_VALSER,';
    strSQL := strSQL + '  SER_TMPMED,';
    strSQL := strSQL + '  SER_TIPSER,';
    strSQL := strSQL + '  SER_TERCER,';
    strSQL := strSQL + '  TPS_CORIDE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADSER ';
    strSQL := strSQL + '  LEFT JOIN TIPSER ON TPS_CODIGO = SER_TIPSER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  SER_CODSER = :CODSER AND (SER_ATIVO_ = "S") '; {Somente Ativos!}

    If fCfgSis('SEREMP', varBoolean) Then
      strSQL := strSQL + ' AND ((SER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') OR (SER_CODEMP IS NULL)) ';

    if not fEmptyStr(edtCodSer.Text) then
    begin
      qryGenSer.Close;
      qryGenSer.SQL.Clear;
      qryGenSer.SQL.Add(strSQL);
      qryGenSer.ParamByName('CODSER').AsString := edtCodSer.Text;
      qryGenSer.Open;
    end;

    edtQtdSer := TEdit       (fGetComponent('edtQtdSe', fGetNumbers(edtCodSer.Name).ToInteger));
    edtUniSer := TEdit       (fGetComponent('edtUniSe', fGetNumbers(edtCodSer.Name).ToInteger));
    edtValSer := TEdit       (fGetComponent('edtValSe', fGetNumbers(edtCodSer.Name).ToInteger));
    edtTmpSer := TEdit       (fGetComponent('edtTmpSe', fGetNumbers(edtCodSer.Name).ToInteger));
    cmbStaSer := TComboBox   (fGetComponent('cmbStaSe', fGetNumbers(edtCodSer.Name).ToInteger));
    chkBrinde := TCheckBox   (fGetComponent('chkBriSe', fGetNumbers(edtCodSer.Name).ToInteger));
    edtPrisma := TEdit       (fGetComponent('edtPriSe', fGetNumbers(edtCodSer.Name).ToInteger));
    edtDecSer := TEdit       (fGetComponent('edtDecSe', fGetNumbers(edtCodSer.Name).ToInteger));
    edtLiqSer := TEdit       (fGetComponent('edtLiqSe', fGetNumbers(edtCodSer.Name).ToInteger));

    edtDesSer.Enabled     := False;
    edtDesSer.TabStop     := False;
    edtDesSer.ReadOnly    := True;
    edtDesSer.NormalColor := $00FFDFB8;

    If (qryGenSer.Active) and (qryGenSer.FieldByName('SER_TERCER').AsString = 'S') Then
    Begin
      edtCodSer.Font.Color := clRed;
      edtDesSer.Font.Color := clRed;
      edtQtdSer.Font.Color := clRed;
      edtUniSer.Font.Color := clRed;
      edtValSer.Font.Color := clRed;
      edtTmpSer.Font.Color := clRed;
      cmbStaSer.Font.Color := clRed;
      edtDecSer.Font.Color := clRed;
      edtLiqSer.Font.Color := clRed;
    End
    else
    Begin
      edtCodSer.Font.Color := clBlack;
      edtDesSer.Font.Color := clBlack;
      edtQtdSer.Font.Color := clBlack;
      edtUniSer.Font.Color := clBlack;
      edtValSer.Font.Color := clBlack;
      edtTmpSer.Font.Color := clBlack;
      cmbStaSer.Font.Color := clBlack;
      edtDecSer.Font.Color := clBlack;
      edtLiqSer.Font.Color := clBlack;
    End;

    // Libera lock do prisma
    If (edtCodSer.Text <> strCodSerAnt) And (blnBuscaPorChave) And (fatVenda.fEhAutocenter) And qryCadSer.Locate('SER_CODSER', strCodSerAnt, []) Then
      fLockaPrisma(qryCadSer.FieldByName('SER_TIPSER').AsString, edtPrisma.Text, False);

    If (qryGenSer.Active) and (Not qryGenSer.isEmpty) Then
    Begin

      If (fCfgSis('EDISER', varBoolean)) Then
      Begin
        edtDesSer.Enabled     := True;
        edtDesSer.TabStop     := True;
        edtDesSer.ReadOnly    := edtCodSer.ReadOnly;
        edtDesSer.NormalColor := clWindow;
      End;

      edtValSer.Enabled := True;
      cmbStaSer.Enabled := Not edtCodSer.ReadOnly;//Caso o serviço não esteja desabilitado para alterar
      chkBrinde.Enabled := Not edtCodSer.ReadOnly;//Caso o serviço não esteja desabilitado para alterar

      If blnUsaDesc Then
      Begin
        edtDecSer.Enabled  := True;
        edtDecSer.ReadOnly := edtCodSer.ReadOnly;
        edtLiqSer.Enabled  := True;
      End;

      If (fEmptyStr(edtDesSer.Text)) Or (Not edtDesSer.Enabled) Then
        edtDesSer.Text  := qryGenSer.FieldByName('SER_DESSER').AsString;

      If (edtCodSer.Text <> strCodSerAnt) And blnBuscaPorChave Then
      Begin
        edtQtdSer.Text := '1,00';
        edtUniSer.Text := FormatFloat('#,##0.00', qryGenSer.FieldByName('SER_VALSER').AsFloat);
        edtValSer.Text := FormatFloat('#,##0.00', fStrToFloat(edtQtdSer.Text) * fStrToFloat(edtUniSer.Text));
        If fatVenda.fEhAutocenter Then
        Begin
          edtPrisma.Clear;

          edtPrisma.Text := fCarregaPrisma(qryGenSer.FieldByName('SER_TIPSER').AsString, edtPrisma.Name);
          edtPrisma.Color := StrToIntDef(qryGenSer.FieldByName('TPS_CORIDE').AsString, clWhite);
          edtPrisma.Font.Color := fGetCorFonteEdit(edtPrisma.Color);
        End;
      End;

      edtTmpSer.Text := FormatDateTime('hh:mm', qryGenSer.FieldByName('SER_TMPMED').AsDateTime);

      Result := True;

      If Result And Assigned(fPedeEnderecoEntrega) Then
      Begin
        fatVenda.blnDocumentoTemServicos := True;

        If fatVenda.blnPedeEndEntregaServicos And (Not fatVenda.blnPediuEnderecoEntrega) Then
        Begin
          If (Not fPedeEnderecoEntrega) Then
          Begin
            fMensagem('ATENÇÃO!', 'É necessário selecionar o endereço de entrega para o(s) serviço(s)!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            fatVenda.pDefineAliquotaIss;

            objServicos.fltPerIss := fatVenda.fltPerIss;
            objServicos.fltRedIss := fatVenda.fltRedIss;
            objServicos.fltDedIss := fatVenda.fltDedIss;

            edtPerIss.Text := FloatToStrF(objServicos.fltPerIss, ffFixed, 12, intDecSer);
            edtRedIss.Text := FloatToStrF(objServicos.fltRedIss, ffFixed, 12, 2);
            edtDedIss.Text := FloatToStrF(objServicos.fltDedIss, ffFixed, 12, 2);

            pSomaValores;
          End;
        End;
      End;

      If Result And blnBuscaPorChave And (Not fEhServicoOutroVendedorSemPermissaoParaAlterar(fGetNumbers(edtCodSer.Name).ToInteger)) Then
      Begin
        strMecTmp := fGetMecanico(fGetNumbers(edtCodSer.Name));
        if strMecPadrao.IsEmpty then
        begin
          Result := fInformarMecanicos(strMecTmp);

          If Result Then
            pSetMecanico(fGetNumbers(edtCodSer.Name), strMecTmp);
        End;

      End;

      If (Result) And (Length(arrValoresServico) > 0) And (intIndiceComponente >= 0) Then
      Begin
        arrValoresServico[intIndiceComponente].strCodSer := edtCodSer.Text;
        arrValoresServico[intIndiceComponente].strDescri := edtDesSer.Text;
        arrValoresServico[intIndiceComponente].fltDesMax := fDescMax(edtCodSer.Text);
        arrValoresServico[intIndiceComponente].fltValBru := qryGenSer.FieldByName('SER_VALSER').AsFloat;
      End;

    End
    Else
    Begin
      edtDesSer.Clear;
      edtTmpSer.Text := '00:00';
      cmbStaSer.ItemIndex := -1;
      chkBrinde.Checked   := False;

      edtUniSer.Text    := '0,00';
      edtQtdSer.Text    := '0,00';
      edtValSer.Text    := '0,00';
      edtDecSer.Text    := '0,00';
      edtLiqSer.Text    := '0,00';

      edtPrisma.Clear;

      If Not fCfgSis('QTDSER', VarBoolean) Then
        edtValSer.Enabled := False;

      cmbStaSer.Enabled := False;
      chkBrinde.Enabled := False;

      If (fEmptyStr(edtCodSer.Text)) Then
      Begin
        pSetarPropriedadesServicos(fGetNumbers(edtCodSer.Name).ToInteger);

        pSomaValores;

        blnMudarFoco := False;

        If (edtCodSer = edtCodSe1) Then
        Begin
          pSetaPropriedadesGeral;
          blnConfServicos := True;
          btnSair.Click;
          Result := False;
        End
        Else
        Begin
          If pnlDadosEstatisticos.Visible Then
            pSetFocus(edtNroPro)
          Else If pnlDatas.Visible Then
            pSetFocus(edtDtAgeS)
          Else If pnlPraEnt.Visible Then
            pSetFocus(edtPraEnt)
          Else
            pSetFocus(btnConfirma);

          Result := True;
        End;
      End
      Else
      Begin
        If fCfgSis('SEREMP', varBoolean) Then
          fMensagem('ATENÇÃO!', 'Serviço não "Cadastrado/Ativo" ou não vinculado a empresa utilizada!', ['&OK'])
        Else
          fMensagem('ATENÇÃO!', 'Esse serviço não está "Cadastrado/Ativo"!', ['&OK']);
        Result := False;
      End;
    End;

    If (Result) And
       (MatchStr(fatVenda.strOpcDoc, ['OR','PD','VN'])) And
       (fCfgSis('ATCBBD', varBoolean)) Then
    Begin
      If (edtCodSer.Text <> strCodSerAnt) Then
        chkBrinde.Checked := False;

      If (fatvenda.fEhServicoQuePermiteBrinde(edtCodSer.Text)) And
         (fStrToFloat(edtUniSer.Text) = 0) And
         (Not chkBrinde.Checked) Then
      Begin
        chkBrinde.Checked := True;
      End;
    End;

    If (qryGenSer.Active) Then
      qryGenSer.Close;

  Finally
    pDesabilitaServicosOutroVendedor;
    FreeAndNil(qryGenSer);
  End;
end;

function TfrmFatDigServico.fDescMax(strCodSer: String): Double;
begin
  Result := 0;
  if qryCadSer.Locate('SER_CODSER', strCodSer, []) then
    Result := qryCadSer.FieldByName('SER_DESMAX').AsFloat;
end;

function TfrmFatDigServico.fEhServicoOutroVendedorSemPermissaoParaAlterar(intIdeSer: Integer): Boolean;
begin
  Result := (Not fEmptyStr(fGetPropValue('strVenS', intIdeSer))) And
            (Not SameText (fGetPropValue('strVenS', intIdeSer), fatVenda.strCodVen)) And
            fCfgSis('VNDSPD', varBoolean) And (Pos(fatVenda.strOpcDoc, 'OR_PD_VN') > 0);

  If Result And VarIsNull(varPodeAlterarServicosOutrosVendedores) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Alterar / Excluir produtos e serviços de outros Vendedores (PD/OR/VN)');

    objLiberacao.strDirAce := 'ALITOUVEN';
    objLiberacao.strMsgSen := 'Alterar / Excluir produtos e serviços de outros Vendedores (PD/OR/VN)';
    objLiberacao.strCodOpe := fatVenda.strCodVen;
    objLiberacao.strCodDig := fatVenda.strCodDig;
    objLiberacao.strCliente := fatVenda.strCodCli + '-' +      fatVenda.strCliNom;
    objLiberacao.strCpfCnpj := fatVenda.strCliCgc;


    varPodeAlterarServicosOutrosVendedores := fatVenda.fFatMensagemLiberacao(objLiberacao);
  End;

  If Result Then
    Result := (Not varPodeAlterarServicosOutrosVendedores);
end;

function TfrmFatDigServico.fInformarMecanicos(Var strCodMec: String): Boolean;
begin
  Result := True;

  If Not fatVenda.fEhAutocenter Then
    Exit;

  If Not fCfgSis('MECSER', varBoolean) Then
    Exit;

  Try
    pCriarFormularios(TfrmDigMecanicos, frmDigMecanicos);
    frmDigMecanicos.stlMecanicos.CommaText := strCodMec;

    frmDigMecanicos.pnlAltMecGer.Visible := False;

    Result := frmDigMecanicos.ShowModal = mrOk;

    If Result Then
    Begin
      strCodMec   := frmDigMecanicos.stlMecanicos.CommaText;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmDigMecanicos);

end;

function TfrmFatDigServico.fLiberaAlteracaoServiçoOSGarantia(blnRegistroIgual: Boolean): Boolean;
var
  strPedidos: String;
begin
  Result := True;

  if (fCfgSis('DESOSG', varBoolean)) and (fatVenda.blnPedFabOSG) and (not blnRegistroIgual) then
  begin
    if (not Assigned(fatVenda.qryTemporariaConfirmacao)) or
       (not fatVenda.qryTemporariaConfirmacao.Active) or
       (fatVenda.qryTemporariaConfirmacao.IsEmpty) then
      strPedidos := fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + '-' + fatVenda.strEmpDoc
    else
    begin
      strPedidos := '';

      fatVenda.qryTemporariaConfirmacao.First;

      while not fatVenda.qryTemporariaConfirmacao.Eof do
      begin
        strPedidos := strPedidos + ', ' + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + '-' +
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString + '-' +
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;

        fatVenda.qryTemporariaConfirmacao.Next;
      end;

      strPedidos := Copy(strPedidos, 3, Length(strPedidos));
    end;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir alterar serviços e valores na confirmação de pedidos de fabricantes que foram originados na rotina de ordem de serviço');
    objLiberacao.objMsgLibera.pAddTexto('Serviços Originais:');
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.objMsgLibera.lstRegistros.Add(objRegistroServOri.fGetClone);

    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('Serviços Modificados:');
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.objMsgLibera.lstRegistros.Add(objRegistroServAtu.fGetClone);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('Referente aos documentos: '+ strPedidos);

    objLiberacao.strDirAce := 'CPSFOS';
    objLiberacao.strMsgSen := 'Permitir alterar serviços e valores na confirmação de pedidos de fabricantes que foram originados na rotina de ordem de serviço';
    objLiberacao.strCodOpe := fatVenda.strCodVen;
    objLiberacao.strCodDig := fatVenda.strCodDig;

    Result := objLiberacao.fLibera;
  end;
end;

function TfrmFatDigServico.fLockaPrisma(strLockedPrisma: String; blnLockar: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := fLock_Unlock('PRISMA_' + strLockedPrisma, blnLockar, False);

  If Result Then
  Begin
    If blnLockar Then
    Begin
      fatVenda.stlLockedPrismas.Add(strLockedPrisma);
      stlLockedPrismasTmp.Add(strLockedPrisma);
    End
    Else
    Begin
      intIndex := fatVenda.stlLockedPrismas.IndexOf(strLockedPrisma);
      If intIndex >= 0 Then
        fatVenda.stlLockedPrismas.Delete(intIndex);

      intIndex := stlLockedPrismasTmp.IndexOf(strLockedPrisma);
      If intIndex >= 0 Then
        stlLockedPrismasTmp.Delete(intIndex);
    End;
  End;
end;

function TfrmFatDigServico.fNum(strNome: String): Integer;
begin
  Result := StrToIntDef(fGetNumbers(strNome), 0);
end;

function TfrmFatDigServico.fLockaPrisma(strTipSer, strPrisma: String; blnLockar: Boolean): Boolean;
begin
  Result := fLockaPrisma(strTipSer+'_'+strPrisma, blnLockar);
end;

function TfrmFatDigServico.fGeraRegistroServicos: TRegistroMsgLibera;
  Var
    i: Integer;
    blnSemServico: Boolean;
    strCodSer, strDesSer, strQtdSer, strUniSer, strValSer, strStaSer, strTmpSer: String;
    objLinha  : TLinhaMsgLibera;
begin
  blnSemServico := True;

  For i := 1 To 30 Do
    If Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', i)).Text) Then
      blnSemServico := False;

  If blnSemServico Then
  Begin
    Result := TRegistroMsgLiberaTexto.Create;
    (Result as TRegistroMsgLiberaTexto).strTexto :=' Nenhum serviço ';
    Exit;
  End;

  Result := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna('', 'CÓD.'      , 5  , alEsquerda , teAutcom);
  objLinha.pAddColuna('', 'DESCRIÇÃO' , 30 , alEsquerda , teAutcom);

  if fCfgSis('QTDSER', VarBoolean) then
  begin
    objLinha.pAddColuna('', 'QTD.'    , 10 , alDireita  , teAutcom);
    objLinha.pAddColuna('', 'UNITÁRIO', 12 , alDireita  , teAutcom);
  end;

  objLinha.pAddColuna(''  , 'TOTAL'   , 12 , alDireita  , teAutcom);

  if fatVenda.fEhAutocenter then
  begin
    objLinha.pAddColuna(''  , 'STATUS', 15 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'T.M.'  , 10 , alDireita  , teAutcom);
  end;

  (Result as TRegistroMsgLiberaTabela).lstLinhas.Add(objLinha);

  For i := 1 To intLinSer Do
  Begin
    strCodSer := TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text;
    strDesSer := TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Text;
    strQtdSer := TEdit(fGetComponent(fGetPanel(i), 'edtQtdSe', i)).Text;
    strUniSer := TEdit(fGetComponent(fGetPanel(i), 'edtUniSe', i)).Text;
    strValSer := TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text;
    strStaSer := TComboBox(fGetComponent(fGetPanel(i), 'cmbStaSe', i)).Text;
    strTmpSer := TEdit(fGetComponent(fGetPanel(i), 'edtTmpSe', i)).Text;

    If fEmptyStr(strCodSer) Then
      Continue;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('CÓD.'      , strCodSer , 5  , alEsquerda);
    objLinha.pAddColuna('DESCRIÇÃO' , strDesSer , 30 , alEsquerda);

    if fCfgSis('QTDSER', VarBoolean) then
    begin
      objLinha.pAddColuna('QTD.'    , strQtdSer , 10 , alDireita );
      objLinha.pAddColuna('UNITÁRIO', strUniSer , 12 , alDireita );
    end;

    objLinha.pAddColuna('TOTAL'     , strValSer , 12 , alDireita );

    if fatVenda.fEhAutocenter then
    begin
      objLinha.pAddColuna('STATUS'  , strStaSer , 15 , alEsquerda);
      objLinha.pAddColuna('T.M.'    , strTmpSer , 10 , alDireita );
    end;

    (Result as TRegistroMsgLiberaTabela).lstLinhas.Add(objLinha);
  End;
end;

function TfrmFatDigServico.fGetComponent(pnlParent: TPanel; strNome: String; intNumSer: Integer): TComponent;
begin
  Result := fComponentByName(pnlParent, strNome + IntToStr(intNumSer));
end;

function TfrmFatDigServico.fGetObservacao(strIdeSer: String): String;
begin
  Result := fGetPropValue('strObsS', strIdeSer.ToInteger);
end;

function TfrmFatDigServico.fGetPanel(intCont: Integer): TPanel;
begin
  Case (Ceil(intCont / 10)) Of
    1: Result := pnlServicos1;
    2: Result := pnlServicos2;
    3: Result := pnlServicos3;
  Else
    Result := nil;
  End;
end;

function TfrmFatDigServico.fGetActivePanel: TPanel;
begin
  If (pnlServicos1.Visible) Then
    Result := pnlServicos1
  Else If (pnlServicos2.Visible) Then
    Result := pnlServicos2
  Else If (pnlServicos3.Visible) Then
    Result := pnlServicos3
  Else
    Result := nil;
end;

function TfrmFatDigServico.fGetBrinde(strIdeSer: String; Var strCodPar, strTipBri: String): String;
begin
  Result    := fGetPropValue('strBriS', strIdeSer.ToInteger);
  strCodPar := fGetPropValue('strParS', strIdeSer.ToInteger);
  strTipBri := fGetPropValue('strTBrS', strIdeSer.ToInteger);
end;

function TfrmFatDigServico.fPossuiServico: Boolean;
var intServic: Integer;
begin
  Result := False;
  For intServic := 1 To 30 Do
  Begin
    If Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intServic)).Text) Then
    Begin
       Result := True;
       Break;
    End;
  End;
end;

function TfrmFatDigServico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    edtTemp: TEditFocus;
    cmbTemp: TComboBoxFocus;
    strStaAnt, strStaAtu: String;
    objServicosAux: TClassDadosServicos;
    intIndiceServico: Integer;

  function fValidaAliquotasISS: Boolean;
    Var
      intSer: Integer;
      fltAliqIss: Double;
  begin
    Result := True;
    If Not fEmptyStr(TEditFocus(sender).Text) Then
    Begin
      fltAliqIss := fCampoTabela('SER_ALQISS','CADSER', ['SER_CODSER'], [TEditFocus(sender).Text]);
      For intSer := 1 To 30 Do
      Begin
        If (Not fEmptyStr(TEditFocus(fGetComponent(fGetPanel(intSer), 'edtCodSe', intSer)).Text)) Then
        Begin
          If fltAliqIss <> fCampoTabela('SER_ALQISS','CADSER', ['SER_CODSER'], [TEditFocus(fGetComponent(fGetPanel(intSer), 'edtCodSe', intSer)).Text]) Then
          Begin
            Result := False;
            Break;
          End;
        End;
      End;
      objServicosAux := TClassDadosServicos.Create(fatVenda.FRecSer);
      try
        pSetarPropriedadesServicos(fGetNumbers(sender.Name).ToInteger);
        fatVenda.FRecSer      := objServicos.recServicos;

        fatVenda.pDefineAliquotaIss;

        objServicos.fltPerIss := fatVenda.fltPerIss;
        objServicos.fltRedIss := fatVenda.fltRedIss;
        objServicos.fltDedIss := fatVenda.fltDedIss;
      finally
        fatVenda.FRecSer := objServicosAux.recServicos;
        FreeAndNil(objServicosAux);
      end;

      edtPerIss.Text := FloatToStrF(objServicos.fltPerIss, ffFixed, 12, intDecSer);
      edtRedIss.Text := FloatToStrF(objServicos.fltRedIss, ffFixed, 12, 2);
      edtDedIss.Text := FloatToStrF(objServicos.fltDedIss, ffFixed, 12, 2);
    End;
  end;

  function fValidaReducaoISS: Boolean;
    Var
      intSer: Integer;
      fltRedIss: Double;
  begin
    Result := True;
    If Not fEmptyStr(TEditFocus(sender).Text) Then
    Begin
      fltRedIss := fCampoTabela('SER_REDISS','CADSER', ['SER_CODSER'], [TEditFocus(sender).Text]);
      For intSer := 1 To 30 Do
      Begin
        If (Not fEmptyStr(TEditFocus(fGetComponent(fGetPanel(intSer), 'edtCodSe', intSer)).Text)) Then
        Begin
          If fltRedIss <> fCampoTabela('SER_REDISS','CADSER', ['SER_CODSER'], [TEditFocus(fGetComponent(fGetPanel(intSer), 'edtCodSe', intSer)).Text]) Then
          Begin
            Result := False;
            Break;
          End;
        End;
      End;

      objServicosAux := TClassDadosServicos.Create(fatVenda.FRecSer);
      try
        pSetarPropriedadesServicos(fGetNumbers(sender.Name).ToInteger);
        fatVenda.FRecSer      := objServicos.recServicos;

        fatVenda.pDefineAliquotaIss;

        objServicos.fltPerIss := fatVenda.fltPerIss;
        objServicos.fltRedIss := fatVenda.fltRedIss;
        objServicos.fltDedIss := fatVenda.fltDedIss;
      finally
        fatVenda.FRecSer := objServicosAux.recServicos;
        FreeAndNil(objServicosAux);
      end;

      edtPerIss.Text := FloatToStrF(objServicos.fltPerIss, ffFixed, 12, intDecSer);
      edtRedIss.Text := FloatToStrF(objServicos.fltRedIss, ffFixed, 12, 2);
      edtDedIss.Text := FloatToStrF(objServicos.fltDedIss, ffFixed, 12, 2);
    End;
  end;

begin

  Result := True;

  If Pos(UpperCase('edtCodSe'), UpperCase(Sender.Name)) > 0 Then
  Begin
    edtTemp := TEditFocus(fGetComponent('edtDesSe', fGetNumbers(Sender.Name).ToInteger));

    If fCfgSis('ISSSER', varBoolean) Then
    Begin
      If Not fValidaAliquotasISS Then
      Begin
        fMensagem('ATENÇÃO!', 'A alíquota de ISS dos serviços devem ser todas iguais!', ['&OK']);
        pSetFocus(edtTemp);
        Result := False;
        Exit;
      End;
      If Not fValidaReducaoISS Then
      Begin
        fMensagem('ATENÇÃO!', 'A redução de ISS dos serviços devem ser todas iguais!', ['&OK']);
        pSetFocus(edtTemp);
        Result := False;
        Exit;
      End;
    End;

    intIndiceServico := StrToIntDef(Copy(Sender.Name, Pos(UpperCase('edtCodSe'), UpperCase(Sender.Name)) + 8, Length(Sender.Name)), 0) - 1;

    Result := fCarregaServico(TEditFocus(Sender), edtTemp, blnBuscaPorChave, intIndiceServico);
  End

  Else If Pos('chkBriSe', Sender.Name) > 0 Then
  Begin
    If blnBuscaPorChave Then
      chkBrindeClick(Sender);
  End

  Else If Pos(UpperCase('edtValSe'), UpperCase(Sender.Name)) > 0 Then
  Begin
    edtTemp := TEditFocus(fGetComponent('edtValSe', fGetNumbers(Sender.Name).ToInteger));
    If (edtTemp.Visible) And (edtTemp.Enabled) {And (Not edtTemp.ReadOnly)} Then
      Result := fValidaValor(edtTemp);
  End

  Else If Pos(UpperCase('edtDecSe'), UpperCase(Sender.Name)) > 0 Then
  Begin
    edtTemp := TEditFocus(fGetComponent('edtDecSe', fGetNumbers(Sender.Name).ToInteger));
    If (edtTemp.Visible) And (edtTemp.Enabled) {And (Not edtTemp.ReadOnly)} Then
      Result := fValidaDesconto(edtTemp);
  End

  Else If Pos(UpperCase('edtUniSe'), UpperCase(Sender.Name)) > 0 Then
  Begin
    edtTemp := TEditFocus(fGetComponent('edtUniSe', fGetNumbers(Sender.Name).ToInteger));
    If (edtTemp.Visible) And (edtTemp.Enabled) {And (Not edtTemp.ReadOnly)} Then
      Result := fValidaUnitario(edtTemp);
  End

  Else If Pos(UpperCase('edtQtdSe'), UpperCase(Sender.Name)) > 0 Then
  Begin
    edtTemp := TEditFocus(fGetComponent('edtQtdSe', fGetNumbers(Sender.Name).ToInteger));
    If (edtTemp.Visible) And (edtTemp.Enabled) {And (Not edtTemp.ReadOnly)} Then
      Result := fValidaQuantidade(edtTemp);
  End

  Else If Pos(UpperCase('cmbStaSe'), UpperCase(Sender.Name)) > 0 Then
  Begin

    cmbTemp := TComboBoxFocus(Sender);
    If (cmbTemp.Visible) And (cmbTemp.Enabled) Then
    Begin
      If (cmbTemp.Items.Count > 0) And fEmptyStr(cmbTemp.Text) Then
      Begin
        pMensagemOk('Selecione o Status do Serviço');
        Result := False;
      End
      Else
      Begin
        strStaAtu := RightStr(cmbTemp.Text, 4);
        // Se for status que não pode selecionar verifica se está sendo modificado ou já estava com esse status
        If Pos(strStaAtu, strStatNaoSeleciona) > 0 Then
        Begin
          strStaAnt := fGetPropValue('strStaS', fNum(Sender.Name));

          If strStaAnt <> strStaAtu Then
          Begin
            pMensagemOk('Status digitado não é permitido nesta tela');
            Result := False;
          End;
        End;
      End;
    End;

  End

  Else If (Sender = edtNroPro) And pnlDadosEstatisticos.Visible Then
  Begin

    If (fEmptyStr(edtNroPro.Text)) Then
    Begin
      edtNroPro.Text := '0';
    End
    Else
    Begin
      If (fStrToFloat(edtNroPro.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número de profissionais na obra deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If (fEmptyStr(edtCodSe1.Text)) And (fStrToFloat(edtNroPro.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos um serviço!', ['&Ok']);
        Result := False;
      End;
    End;  

  End

  Else If (Sender = mskSerIni) And pnlDadosEstatisticos.Visible Then
  Begin
    mskSerFin.Enabled := True;

    If (fEmptyStr(fTiraCaracEspeciais(mskSerIni.Text))) Then
    Begin
      mskSerFin.Enabled := False;
      mskSerFin.Clear;
    End
    Else If (StrToDateTimeDef(mskSerIni.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a data de início da obra corretamente!', ['&Ok']);
      Result := False;
    End
    Else If (fEmptyStr(edtCodSe1.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos um serviço!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = mskSerFin) And mskSerFin.Enabled And pnlDadosEstatisticos.Visible Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(mskSerFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a data de término da obra!', ['&Ok']);
      Result := False;
    End
    Else If (StrToDateTimeDef(mskSerFin.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a data de término da obra corretamente!', ['&Ok']);
      Result := False;
    End
    Else If (StrToDateTimeDef(mskSerFin.Text, 0) < StrToDateTimeDef(mskSerIni.Text, 0)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de término da obra não deve ser inferir a data de início!', ['&Ok']);
      Result := False;
    End
    Else If (fEmptyStr(edtCodSe1.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos um serviço!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = mmoSerObs) And pnlDadosEstatisticos.Visible Then
  Begin

    If (fEmptyStr(AnsiReplaceStr(mmoSerObs.Texto, STRING_QUEBRA, ''))) Then
    Begin
      mmoSerObs.Clear;
    End
    Else If (fEmptyStr(edtCodSe1.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos um serviço!', ['&Ok']);
      Result := False;
    End
    Else If blnBuscaPorChave Then
      blnMudarFoco := False;

  End

  Else If (Sender = edtPraEnt) Then
  Begin

    If (fEmptyStr(edtPraEnt.Text)) Then
    Begin
      edtPraEnt.Text := '0';
    End
    Else If (fStrToFloat(edtPraEnt.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O prazo de entrega deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtPerIss) Then
  Begin

    If (fEmptyStr(edtPerIss.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A alíquota de ISS deve ser preenchida!', ['&Ok']);
      Result := False;
    End

    Else If (fStrToFloat(edtPerIss.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A alíquota de ISS não pode ser menor ou igual a zero!', ['&Ok']);
      Result := False;
    End

    Else If (Not fValidaEscala(edtPerIss.Text, 0.00, 100)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A alíquota de ISS deve estar entre 0.01 e 100!', ['&Ok']);
      Result := False;
    End

    Else
    Begin
      pSomaValores;
    End;

  End

  Else If (Sender = edtRedIss) Then
  Begin

    If (Not fValidaEscala(edtRedIss.Text, 0.00, 100)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de reduda Base de ISS deve estar entre 0 e 100!', ['&Ok']);
      Result := False;
    End

    Else
    Begin
      pSomaValores;
    End;

  End

  Else If (Sender = edtDedIss) And (not edtDedIss.ReadOnly) Then
  Begin

    If (fStrToFloat(edtDedIss.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da dedução de Base de ISS não pode ser menor que zero!', ['&Ok']);
      Result := False;
    End

    Else
    Begin
      pSomaValores;
    End;

  End

  Else If Sender = edtDtAgeS Then
  Begin
    If Not fEmptyStr(edtDtAgeS.Text, True) Then
    Begin
      If StrToDateDef(edtDtAgeS.Text, 0) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Data Agendamento inválida!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If Sender = edtHrAgeS Then
  Begin
    If Not fEmptyStr(edtHrAgeS.Text, True) Then
    Begin
      If StrToTimeDef(edtHrAgeS.Text, -1) = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Horário Agendamento inválido!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If Sender = edtDtEntS Then
  Begin
    If Not fEmptyStr(edtDtEntS.Text, True) Then
    Begin
      If StrToDateDef(edtDtEntS.Text, 0) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Data Entrega inválida!', ['&Ok']);
        Result := False;
      End
      // Valida data entrega maior que data de agendamento
      Else If StrToDateDef(edtDtAgeS.Text, 0) > 0 Then
      Begin
        If StrToDate(edtDtEntS.Text) < StrToDate(edtDtAgeS.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Data de Entrega deve ser maior ou igual a data de agendamento!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (pnlDatas.Visible) And fCfgSis('OBDTHR', VarBoolean) And (fPossuiServico) Then
    Begin
      fMensagem('ATENÇÃO!', 'Data de Entrega com preenchimento obrigatório!', ['&Ok']);
      Result := False;
    End;
  End

  Else If Sender = edtHrEntS Then
  Begin
    If Not fEmptyStr(edtHrEntS.Text, True) Then
    Begin
      If StrToTimeDef(edtHrEntS.Text, -1) = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Horário Entrega inválido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFatDigServico.fValidaDesconto(edtDesc: TEdit): Boolean;
  Var
    fltTotDes: Double;
    edtLiqSer: TEditFocus;
    edtValSer: TEditFocus;
begin
  Result := True;

  edtLiqSer := TEditFocus(fGetComponent('edtLiqSe', fGetNumbers(edtDesc.Name).ToInteger));
  edtValSer := TEditFocus(fGetComponent('edtValSe', fGetNumbers(edtDesc.Name).ToInteger));

  If (fEmptyStr(edtDesc.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Desconto deve ser preenchido!', ['&Ok']);
    Result := False;
  End

  Else If (fStrToFloat(edtDesc.Text) < 0.0) Or (fStrToFloat(edtDesc.Text) > 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'O porcentagem do desconto deve estar entre 0 e 100%!', ['&Ok']);
    Result := False;
  End

  Else
  Begin
    fltTotDes      := fStrToFloat(edtValSer.Text) * (fStrToFloat(edtDesc.Text) / 100);
    edtLiqSer.Text := FormatFloat('#,##0.00', fStrToFloat(edtValSer.Text) - fltTotDes);
    pSomaValores;
  End;
end;

function TfrmFatDigServico.fValidaIRPJ: Boolean;
var
  strSQL,
  strRet,
  strNRet,
  strCodSer,
  strCodSer1,
  strDesSer1: String;
  intCont   : Integer;
  blnRetem,
  blnNRetem,
  blnRet01  : Boolean;
  fltValSer : Double;
  qryAux    : TUniQuery;
begin
  Result := True;

  if (not fCfgSis('IRCSER', varBoolean)) then
    Exit;

  blnRetem  := False;
  blnNRetem := False;
  blnRet01  := False;

  qryAux := fCriaQuery;
  strSQL := '';
  strSQL := strSQL + 'SELECT SER_CODSER, SER_DESSER, SER_REIRPJ, SER_VLIRPJ ';
  strSQL := strSQL + 'FROM CADSER ';
  strSQL := strSQL + 'WHERE SER_CODSER = :CODSER AND (SER_ATIVO_ = "S") ';

  if fCfgSis('SEREMP', varBoolean) then
    strSQL := strSQL + ' AND ((SER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') OR (SER_CODEMP IS NULL)) ';

  qryAux.SQL.Text := strSQL;

  try
    for intCont := 1 to 30 do
    begin
      strCodSer := TEditFocus(fGetComponent('edtCodSe', intCont)).Text;

      if (fEmptyStr(strCodSer)) then
        Continue;

      fltValSer := fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtValSe', intCont)).Text), 2);

      qryAux.Close;
      qryAux.ParamByName('CODSER').AsString := strCodSer;
      qryAux.Open;

      if (not qryAux.IsEmpty) then
      begin
        if fEmptyStr(strCodSer1) then
        begin
          strCodSer1 := qryAux.FieldByName('SER_CODSER').AsString;
          strDesSer1 := qryAux.FieldByName('SER_DESSER').AsString;
          blnRet01   := (qryAux.FieldByName('SER_REIRPJ').AsString = 'S') and
            (fFormataFloat(qryAux.FieldByName('SER_VLIRPJ').AsFloat, 2) <= fltValSer);
        end;

        if (qryAux.FieldByName('SER_REIRPJ').AsString = 'S') and
          (fFormataFloat(qryAux.FieldByName('SER_VLIRPJ').AsFloat, 2) <= fltValSer) then
          blnRetem := True
        else
          blnNRetem := True;

        if (blnRetem) and (blnNRetem) then          
        begin
          Result := False;

          if (blnRet01) then
          begin
            strRet  := '    Retém IRPJ: ' + strCodSer1 + ' - ' + strDesSer1;
            strNRet := 'Não Retém IRPJ: ' + qryAux.FieldByName('SER_CODSER').AsString + ' - ' + qryAux.FieldByName('SER_DESSER').AsString;
          end
          else
          begin
            strRet  := '    Retém IRPJ: ' + qryAux.FieldByName('SER_CODSER').AsString + ' - ' + qryAux.FieldByName('SER_DESSER').AsString;
            strNRet := 'Não Retém IRPJ: ' + strCodSer1 + ' - ' + strDesSer1;
          end;

          fMensagem('ATENÇÃO!', 'Não é permitido informar para a mesma emissão de nota ' +
            ' de serviço um serviço que retém irpj com um que não retém.' + #13 + #13 + strRet + #13 + strNRet, ['&Ok']);

          Exit;
        end;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmFatDigServico.fValidaValor(edtValor: TEdit): Boolean;
  function fQtdDecUnitario : Integer;
  Begin
    Result := IIF( Pos(fatVenda.strOpcDoc, 'CF_CI_CN_CP_') > 0, 4, 2 );
  End;
begin

  Result := True;

  If (fEmptyStr(edtValor.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser preenchido!', ['&Ok']);
    Result := False;
  End

  Else If (fStrToFloat(edtValor.Text) < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser maior ou igual a Zero!', ['&Ok']);
    Result := False;
  End

  Else If fatVenda.blnApenasUnitarioAcimaDoSugerido Then
  Begin
    If fFormataFloat(fStrToFloat(edtValor.text),fQtdDecUnitario)  < fFormataFloat(fValorMinimo(TEditFocus(fGetComponent('edtCodSe', fGetNumbers(edtValor.Name).ToInteger)).Text), fQtdDecUnitario) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor deve ser maior ou igual a '+FloatToStrF(fFormataFloat(fValorMinimo(TEditFocus(fGetComponent('edtCodSe', fGetNumbers(edtValor.Name).ToInteger)).Text), fQtdDecUnitario), ffFixed, 12, fQtdDecUnitario)+' !', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  pSomaValores;

end;

function TfrmFatDigServico.fValorMinimo(codSer: string): Double;
var strSQL: String;
    qryGenSer: TUniQuery;
begin

  Result := 0;

  If fEmptyStr(codSer) Then
    Exit;

  qryGenSer := fCriaQuery(Self);

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SER_DESSER,';
    strSQL := strSQL + '  SER_VALSER,';
    strSQL := strSQL + '  SER_TMPMED,';
    strSQL := strSQL + '  SER_TIPSER,';
    strSQL := strSQL + '  SER_TERCER,';
    strSQL := strSQL + '  TPS_CORIDE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADSER ';
    strSQL := strSQL + '  LEFT JOIN TIPSER ON TPS_CODIGO = SER_TIPSER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  SER_CODSER = :CODSER AND (SER_ATIVO_ = "S") '; {Somente Ativos!}

    If fCfgSis('SEREMP', varBoolean) Then
      strSQL := strSQL + ' AND ((SER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') OR (SER_CODEMP IS NULL)) ';


    With qryGenSer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODSER').AsString := codSer;
      Open;

      If Not isEmpty Then
        Result := FieldByName('SER_VALSER').AsFloat;
    End;

  Finally
    FreeAndNil(qryGenSer);
  End;

end;

function TfrmFatDigServico.fValidaUnitario(edtUnitario: TEdit): Boolean;
  Var
    edtQtdSer: TEditFocus;
    edtValSer: TEditFocus;
  function fQtdDecUnitario : Integer;
  Begin
    Result := IIF( Pos(fatVenda.strOpcDoc, 'CF_CI_CN_CP_') > 0, 4, 2 );
  End;
begin
  Result := True;

  edtQtdSer := TEditFocus(fGetComponent('edtQtdSe', fGetNumbers(edtUnitario.Name).ToInteger));
  edtValSer := TEditFocus(fGetComponent('edtValSe', fGetNumbers(edtUnitario.Name).ToInteger));

  If (fEmptyStr(edtUnitario.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O preço do serviço deve ser preenchido!', ['&Ok']);
    Result := False;
  End

  Else If (fStrToFloat(edtUnitario.Text) < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O preço deve ser maior ou igual a Zero!', ['&Ok']);
    Result := False;
  End

  Else If fatVenda.blnApenasUnitarioAcimaDoSugerido Then
  Begin
    If fFormataFloat(fStrToFloat(edtUnitario.text),fQtdDecUnitario)  < fFormataFloat(fValorMinimo(TEditFocus(fGetComponent('edtCodSe', fGetNumbers(edtUnitario.Name).ToInteger)).Text), fQtdDecUnitario) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor deve ser maior ou igual a '+FloatToStrF(fFormataFloat(fValorMinimo(TEditFocus(fGetComponent('edtCodSe', fGetNumbers(edtUnitario.Name).ToInteger)).Text), fQtdDecUnitario), ffFixed, 12, fQtdDecUnitario)+' !', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  edtValSer.Text := FormatFloat('#,##0.00', fStrToFloat(edtQtdSer.Text) * fStrToFloat(edtUnitario.Text));
  pSomaValores;

end;


function TfrmFatDigServico.fValidaQuantidade(edtQtde: TEdit): Boolean;
  Var
    edtCodSer: TEditFocus;
    edtUniSer: TEditFocus;
    edtValSer: TEditFocus;
begin

  Result := True;

  edtCodSer := TEditFocus(fGetComponent('edtCodSe', fGetNumbers(edtQtde.Name).ToInteger));
  edtUniSer := TEditFocus(fGetComponent('edtUniSe', fGetNumbers(edtQtde.Name).ToInteger));
  edtValSer := TEditFocus(fGetComponent('edtValSe', fGetNumbers(edtQtde.Name).ToInteger));

  If (fEmptyStr(edtQtde.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
    Result := False;
  End

  Else If (fStrToFloat(edtQtde.Text) <= 0.0) Then
  Begin
    If fEmptyStr(edtCodSer.Text) Then
      edtQtde.Text := '0,00'
    Else
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else
  Begin
    edtValSer.Text := FormatFloat('#,##0.00', fStrToFloat(edtQtde.Text) * fStrToFloat(edtUniSer.Text));  
    pSomaValores;
  End;

end;

{function TfrmFatDigServico.fValidarServicosEmBranco: Boolean;
  Var
    intSer: Integer;
begin
  Result := False;
  For intSer := 2 To 30 Do
  Begin
    If (intLinSer >= intSer) And
       (Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intSer  )).Text)) And
       (    fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intSer-1)).Text)) Then
    Begin
      pMensagemOk('Os serviços devem ser informados na ordem exibida na tela, ' +
        'verifique se existem serviços em branco na ordem informada!');
      Result := True;
      Break;
    End;
  End;
end;}

procedure TfrmFatDigServico.pSetObservacao(strIdeSer, strObserv: String);
begin
  pSetPropValue('strObsS', strIdeSer.ToInteger, strObserv);
end;

procedure TfrmFatDigServico.pSetPropValue(strName: String; intServic: Integer; varValue: Variant);
begin
  SetPropValue(objServicos, strName + fStrZero(intServic, 2), varValue);
end;

procedure TfrmFatDigServico.pSetaPropriedadesGeral;
var
  LTotSer: Double;
begin
  objServicos.intPraEnt := StrToIntDef(edtPraEnt.Text, 0);

  objServicos.intNroPro := StrToIntDef(edtNroPro.Text,  0);
  objServicos.strNroCei := edtNroCei.Text;
  objServicos.dtaSerIni := StrToDateDef(mskSerIni.Text, 0);
  objServicos.dtaSerFin := StrToDateDef(mskSerFin.Text, 0);
  objServicos.strSerObs := mmoSerObs.Texto;

  objServicos.dtaDtAgeS := StrToDateDef(edtDtAgeS.Text, 0);
  objServicos.horHrAgeS := StrToTimeDef(edtHrAgeS.Text, 0);
  objServicos.dtaDtEntS := StrToDateDef(edtDtEntS.Text, 0);
  objServicos.horHrEntS := StrToTimeDef(edtHrEntS.Text, 0);

  objServicos.fltTotSer := fFormataFloat(fStrToFloat(edtTotSer.Text), 2);
  objServicos.fltRedIss := fFormataFloat(fStrToFloat(edtRedIss.Text), 2);
  objServicos.fltDedIss := fFormataFloat(fStrToFloat(edtDedIss.Text), 2);
  objServicos.fltPerIss := fFormataFloat(fStrToFloat(edtPerIss.Text), intDecSer);

  LTotSer := objServicos.fltTotSer;

  If objServicos.fltDedIss > 0 Then
  Begin
    LTotSer := LTotSer - objServicos.fltDedIss;
  End;

  objServicos.fltBasIss := fFormataFloat(LTotSer * (1 - objServicos.fltRedIss / 100), 2);
  objServicos.fltValIss := fFormataFloat(fStrToFloat(edtValIss.Text), 2);

  If pnlMunicipioServico.Visible Then
  Begin
    objServicos.strMunPre := IIF(rdgMunicipioServico.ItemIndex = 0, '1','2');
  End;

  If pnlMunicipioNatureza.Visible Then
  Begin
    objServicos.strNatSer := chkNatureza.EditValue;
  End;

end;

procedure TfrmFatDigServico.pSetarPropriedadesServicos(intIndex: Integer);
begin
  pSetPropValue('strCodS', intIndex, TEditFocus(fGetComponent('edtCodSe', intIndex)).Text);
  pSetPropValue('strDesS', intIndex, TEditFocus(fGetComponent('edtDesSe', intIndex)).Text);

  If fCfgSis('QTDSER', VarBoolean) Then
  Begin
    pSetPropValue('fltQtdS', intIndex, fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtQtdSe', intIndex)).Text), 2));
    pSetPropValue('fltUniS', intIndex, fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtUniSe', intIndex)).Text), 2));
  End
  Else
  Begin
    pSetPropValue('fltQtdS', intIndex, 1.00);
    pSetPropValue('fltUniS', intIndex, fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtValSe', intIndex)).Text), 2));
  End;

  pSetPropValue('fltValS', intIndex, fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtValSe', intIndex)).Text), 2));
  pSetPropValue('strStaS', intIndex, RightStr(TComboBoxFocus(fGetComponent('cmbStaSe', intIndex)).Text, 4));
  pSetPropValue('strPriS', intIndex, TEditFocus(fGetComponent('edtPriSe', intIndex)).Text);
  pSetPropValue('fltDecS', intIndex, fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtDecSe', intIndex)).Text), 2));
  pSetPropValue('strIdeS', intIndex, IIF(fGetComponent('btnIdent', intIndex).Tag = 0, 'S', IIF(fGetComponent('btnIdent', intIndex).Tag  = 1, 'I', 'R')));
  pSetPropValue('fltCusS', intIndex, fRetCustoServico(fGetPropValue('strCodS', intIndex)));

  If fEmptyStr(fGetPropValue('strCodS', intIndex)) Then
  Begin
    pSetPropValue('strVenS', intIndex, '');
    pSetPropValue('strVe2S', intIndex, '');
  End
  Else
  Begin
    If fCfgSis('VNDSPD', varBoolean) And (Pos(fatVenda.strOpcDoc, 'OR_PD_VN') > 0) Then
    Begin
      If fEmptyStr(fGetPropValue('strVenS', intIndex)) Then
        pSetPropValue('strVenS', intIndex, fatVenda.strCodVen);

      If fEmptyStr(fGetPropValue('strVe2S', intIndex)) Then
        pSetPropValue('strVe2S', intIndex, fatVenda.strCodVe2);
    End
    Else
    Begin
      If fatVenda.strOpcDoc <> 'CP' Then
      Begin
        pSetPropValue('strVenS', intIndex, fatVenda.strCodVen);
        pSetPropValue('strVe2S', intIndex, fatVenda.strCodVe2);
      End;
    End;
  End;
end;

procedure TfrmFatDigServico.pSetBrinde(strIdeSer, strBrinde, strCodPar, strTipBri: String);
begin
  If strBrinde <> 'S' Then
  Begin
    strCodPar := '';
    strTipBri := '';
  End;

  pSetPropValue('strBriS', strIdeSer.ToInteger, strBrinde);
  pSetPropValue('strParS', strIdeSer.ToInteger, strCodPar);
  pSetPropValue('strTBrS', strIdeSer.ToInteger, strTipBri);
end;

procedure TfrmFatDigServico.pSetMecanico(strIdeSer, strCodMec: String);
begin
  pSetPropValue('strMecS', strIdeSer.ToInteger, strCodMec);
end;

procedure TfrmFatDigServico.pSomaValores;
  Var
    fltTotal,
    fltTotIse,
    fltTotRat,
    fltTotIss,
    fltTotTmp: Double;

    i: Integer;
begin
  fltTotal  := 0.00;
  fltTotTmp := 0.00;
  fltTotIse := 0.00;
  fltTotRat := 0.00;

  For i := 1 To intLinSer Do
  Begin
    If blnUsaRateio Then
    Begin

      If Not blnUsaDesc Then
      Begin
        Case TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Tag Of
          0: fltTotal  := fltTotal  + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text));
          1: fltTotIse := fltTotIse + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text));
          2: fltTotRat := fltTotRat + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text));
        End;
      End
      Else
      Begin
        Case TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Tag Of
          0: fltTotal  := fltTotal  + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text));
          1: fltTotIse := fltTotIse + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text));
          2: fltTotRat := fltTotRat + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text));
        End;
      End;

    End
    Else
    Begin

      If Not blnUsaDesc Then
        fltTotal := fltTotal + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text))
      Else
        fltTotal := fltTotal + IIF(fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text),  0, fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text));

    End;
  End;

  If blnUsaRateio Then
  Begin
    edtTotIse.Text := FloatToStrF(fltTotIse, ffFixed, 12, 2);
    edtTotRat.Text := FloatToStrF(fltTotRat, ffFixed, 12, 2);
  End;

  edtTotSer.Text := FloatToStrF(fltTotal, ffFixed, 12, 2);

  If (fEmptyStr(edtPerIss.Text)) Then
    edtPerIss.Text := '0,00';

  If (fEmptyStr(edtRedIss.Text)) Then
    edtRedIss.Text := '0,00';

  If (fEmptyStr(edtDedIss.Text)) Then
    edtDedIss.Text := '0,00';

  If fStrToFloat(edtDedIss.Text) > 0 Then
  Begin
    fltTotal := fltTotal - fStrToFloat(edtDedIss.Text);
  End;

  objServicos.fltBasIss := fFormataFloat(fltTotal  * (1 - fStrToFloat(edtRedIss.Text) / 100.0), 2);
  fltTotIss := fCalculaValorIss(objServicos.fltBasIss, fStrToFloat(edtPerIss.Text));

  edtValIss.Text := FormatFloat('#,##0.00', fltTotIss);

  For i := 1 To intLinSer Do
    fltTotTmp := fltTotTmp + (StrToTimeDef(TEdit(fGetComponent(fGetPanel(i), 'edtTmpSe', i)).Text,  0) * fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtQtdSe', i)).Text));

  edtTotTmp.Text := fSegToTempoStr(SecondsBetween(0,fltTotTmp));
  edtTotTmp.Text := LeftStr(edtTotTmp.Text, Length(edtTotTmp.Text) - 3);//Tira os Segundos
end;

procedure TfrmFatDigServico.FormShow(Sender: TObject);
  Var
    intSer: Integer;
begin
  inherited;

  If fCfgSis('SUDASF', varBoolean) Then
  Begin
    edtDtAgeS.Date := Date;
    edtHrAgeS.Text := TimeToStr(fTime());
  End;

  If fCfgSis('SUDESF', varBoolean) Then
  Begin
    edtDtEntS.Date := Date;
    edtHrEntS.Text := TimeToStr(fTime());
  End;

  edtDedIss.ReadOnly    := True;
  edtDedIss.TabStop     := False;
  edtDedIss.Color       := $00FFDFB8;
  edtDedIss.NormalColor := $00FFDFB8;

  If fCfgSis('DEDISS', VarBoolean) Then
  Begin
    edtDedIss.ReadOnly    := False;
    edtDedIss.TabStop     := True;
    edtDedIss.Color       := clWindow;
    edtDedIss.NormalColor := clWindow;
  End;

  pnlMunicipioServico.Visible  := fExibeMunicipioServico;
  pnlNaturezaServico.Visible   := fExibeNaturezaServico;
  pnlMunicipioNatureza.Visible := (pnlMunicipioServico.Visible Or pnlNaturezaServico.Visible);

  If pnlMunicipioServico.Visible Then
  Begin
    rdgMunicipioServico.ItemIndex := fCfgSis('NTOPNS', varInteger) - 1;
  End;

  If pnlMunicipioServico.Visible And (Pos(fatVenda.strOpcDoc, 'OR_PD_VN_VS_CP_') > 0) Then
  Begin
    fatVenda.blnPedeEndEntregaServicos := False;
    fatVenda.blnUsaEndEntregaServicosPedidoOrcamento := False;
  End;

  If not pnlMunicipioNatureza.Visible Then
  Begin
    pnlTotais.Height := pnlTotais.Height - pnlMunicipioNatureza.Height;
  End;

  pnlServicos1.Visible := True;
  pnlServicos2.Visible := False;
  pnlServicos3.Visible := False;

  btnProxPagServ.Visible := (fCfgSis('LINSER', varInteger) > 10);
  btnPagAntServ.Visible  := btnProxPagServ.Visible;

  edtPerIss.EditFormat := '#,##' + '0.' + StringOfChar('0', intDecSer);

  If (fStrToFloat(edtPerIss.Text) <= 0.0) Or (fStrToFloat(edtRedIss.Text) <= 0.0) Then
  Begin
    fatVenda.pDefineAliquotaIss;

    objServicos.fltPerIss := fatVenda.fltPerIss;
    objServicos.fltRedIss := fatVenda.fltRedIss;
    objServicos.fltDedIss := fatVenda.fltDedIss;

    edtPerIss.Text := FloatToStrF(objServicos.fltPerIss, ffFixed, 12, intDecSer);
    edtRedIss.Text := FloatToStrF(objServicos.fltRedIss, ffFixed, 12, 2);
    edtDedIss.Text := FloatToStrF(objServicos.fltDedIss, ffFixed, 12, 2);
  End;

  blnUsaDesc := Not (fCfgSis('QTDSER', VarBoolean) Or fCfgSis('ALVLSE', VarBoolean));

  SetLength(arrValoresServico, 0);

  If (Not blnUsaDesc) Then
  Begin
    SetLength(arrValoresServico, intLinSer);
  End;

  pInicializaIndices;
  pSomaValores;
  blnConfirma := False;

  If Not fCfgSis('ESTSER', VarBoolean) Then
  Begin
    pnlDadosEstatisticos.Visible := False;
    Self.Height := Self.Height - pnlDadosEstatisticos.Height;
  End;

  For intSer := 1 To 30 Do
  Begin
    TCheckBox(fGetComponent(fGetPanel(intSer), 'chkBriSe', intSer)).Visible := fPos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') And fCfgSis('USABRI', VarBoolean);
    TCheckBox(fGetComponent(fGetPanel(intSer), 'chkBriSe', intSer)).Checked := False;

    If (Pos(fatVenda.strOpcDoc, 'CP_') > 0) Then
      If TCheckBox(fGetComponent(fGetPanel(intSer), 'chkBriSe', intSer)).Visible Then
        TCheckBox(fGetComponent(fGetPanel(intSer), 'chkBriSe', intSer)).Enabled := False;

    TSpeedButton(fGetComponent(fGetPanel(intSer), 'btnParSe', intSer)).Visible :=
      TCheckBox(fGetComponent(fGetPanel(intSer), 'chkBriSe', intSer)).Visible And fCfgSis('USAPAR', VarBoolean);
  End;

  lblBrinde1.Visible := fPos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') And fCfgSis('USABRI', VarBoolean);
  lblBrinde2.Visible := fPos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') And fCfgSis('USABRI', VarBoolean);
  lblBrinde3.Visible := fPos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') And fCfgSis('USABRI', VarBoolean);

  If (Not lblBrinde1.Visible) Then
    Self.Width := Self.Width - lblBrinde1.Width;

  If Not fatVenda.fEhAutocenter Then
  Begin
    lblPrisma1.Visible := False;
    lblPrisma2.Visible := False;
    lblPrisma3.Visible := False;

    Self.Width := Self.Width - edtPriSe1.Width;

    For intSer := 1 To 30 Do
      TEdit(fGetComponent(fGetPanel(intSer), 'edtPriSe', intSer)).Visible := False;

    If Not blnUsaRateio Then
    Begin
      pnlPrisma.Visible := False;
      Self.Height := Self.Height - pnlPrisma.Height;
    End;

    lblTmpSer1.Visible := False;
    lblStaSer1.Visible := False;

    lblTmpSer2.Visible := False;
    lblStaSer2.Visible := False;

    lblTmpSer3.Visible := False;
    lblStaSer3.Visible := False;

    Self.Width := Self.Width - cmbStaSe1.Width - edtTmpSe1.Width - IIF(Not blnUsaRateio, btnIdent1.Width, 0);
  End
  Else
  Begin
    If Not blnUsaRateio Then
    Begin
      Self.Width  := Self.Width - btnIdent1.Width;
    End;
  End;

  mmoSerObs.OnKeyDown := pOnKeyDownEdits;

  pDefineNumLinhasServico;

  If fPos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') Then
    pCarregaBrindesServico;

  If fatVenda.fEhAutocenter Then
  Begin
    pCarregaStatusServico;
    pDesabilitaServicosOutroVendedor;
    pCarregaTempoMedioServicos;
    pSomaValores;
    pColorePrismas;
  End;

  if Assigned(objRegistroServOri) then
    FreeAndNil(objRegistroServOri);

  objRegistroServOri := fGeraRegistroServicos;

  btnAcompanhaServ.Visible := fatVenda.fEhAutocenter;
  btnAcompanhaServ.Enabled := fVerificaAcessoSistema('ACEACOSERFAT');

  btnAgendamentosProg.Visible := fatVenda.fEhAutocenter;
  btnAgendamentosProg.Enabled := fVerificaAcessoSistema('ACEACOSERFAT');
  edtPerIss.Enabled := fVerificaAcessoSistema('DIRALIQISS');

  pnlPraEnt.Visible := Not fatVenda.fEhAutocenter;
  pnlDatas.Visible  := fatVenda.fEhAutocenter;

  If (fCfgSis('LINSER', varInteger) > 30) Then
    pMensagemOk('Somente 30 serviços podem ser listados na digitação de serviços. Verifique a configuração de sistema ' +
      QuotedStr('CFG_LINSER') + ' para que esta mensagem não seja exibida novamente! A tela será ajustada para 30 itens de serviço.');

  If (fCfgSis('LINSER', varInteger) > 10) Then
    TPanel(fGetActivePanel()).Align := alClient;
end;

procedure TfrmFatDigServico.pCarregaBrindesServico;
  Var
    intSer: Integer;
begin
  blnPedirBrinde := False;

  For intSer := 1 To 10 Do
    TCheckBox(fGetComponent('chkBriSe', intSer)).Checked := fGetPropValue('strBriS', intSer) = 'S';

  If (intLinSer > 10) Then
  Begin
    pnlServicos1.Visible := False;
    pnlServicos3.Visible := False;
    pnlServicos2.Visible := True;
    pnlServicos2.BringToFront;

    For intSer := 10 To 20 Do
      TCheckBox(fGetComponent('chkBriSe', intSer)).Checked := fGetPropValue('strBriS', intSer) = 'S';

    If (intLinSer > 20) Then
    Begin
      pnlServicos1.Visible := False;
      pnlServicos2.Visible := False;
      pnlServicos3.Visible := True;
      pnlServicos3.BringToFront;

      For intSer := 21 To 30 Do
        TCheckBox(fGetComponent('chkBriSe', intSer)).Checked := fGetPropValue('strBriS', intSer) = 'S';
    End
  End;

  If (intLinSer > 10) Then
  Begin
    pnlServicos2.Visible := False;
    pnlServicos3.Visible := False;
    pnlServicos1.Visible := True;
    pnlServicos1.BringToFront;
  End;

  blnPedirBrinde := True;
end;

procedure TfrmFatDigServico.pCarregarServicos;
  Var
    intSer: Integer;

  function fQtdDecUnitario : Integer;
  Begin
    Result := IIF( Pos(fatVenda.strOpcDoc, 'CF_CI_CN_CP_') > 0, 4, 2 );
  End;

begin
  objServicos := TClassDadosServicos.Create(fatVenda.FRecSer);

  For intSer := 1 To 30 Do
  Begin
    TEditFocus(fGetComponent('edtCodSe', intSer)).Text := fGetPropValue('strCodS', intSer);
    TEditFocus(fGetComponent('edtDesSe', intSer)).Text := fGetPropValue('strDesS', intSer);
    TEditFocus(fGetComponent('edtQtdSe', intSer)).Text := FloatToStrF(fGetPropValue('fltQtdS', intSer), ffFixed, 12, 2);
    TEditFocus(fGetComponent('edtUniSe', intSer)).Text := FloatToStrF(fGetPropValue('fltUniS', intSer), ffFixed, 12, fQtdDecUnitario);
    TEditFocus(fGetComponent('edtValSe', intSer)).Text := FloatToStrF(fGetPropValue('fltValS', intSer), ffFixed, 12, 2);
    TEditFocus(fGetComponent('edtDecSe', intSer)).Text := FloatToStrF(fGetPropValue('fltDecS', intSer), ffFixed, 12, 2);
    TEditFocus(fGetComponent('edtValSe', intSer)).Text := FloatToStrF(fGetPropValue('fltValS', intSer), ffFixed, 12, 2);
    TEditFocus(fGetComponent('edtLiqSe', intSer)).Text := FloatToStrF(fGetPropValue('fltValS', intSer) - (fGetPropValue('fltValS', intSer) * (fGetPropValue('fltDecS', intSer) / 100)), ffFixed, 12, 2);
    TEditFocus(fGetComponent('edtPriSe', intSer)).Text := fGetPropValue('strPriS', intSer);
    pIdentificaServico(fGetComponent('btnIdent', intSer), IIF(fGetPropValue('strIdeS', intSer) = 'I', 1, IIF(fGetPropValue('strIdeS', intSer) = 'R', 2, 0)));
  End;

  If objServicos.dtaSerIni > 0 Then
  Begin
    mskSerIni.Text := DateToStr(objServicos.dtaSerIni);
    mskSerFin.Text := DateToStr(objServicos.dtaSerFin);
  End;

  edtNroPro.Text  := IntToStr(objServicos.intNroPro);
  edtNroCei.Text  := objServicos.strNroCEI;
  mmoSerObs.Texto := objServicos.strSerObs;

  edtPraEnt.Text := IntToStr(objServicos.intPraEnt);

  edtTotSer.Text := FloatToStrF(objServicos.fltTotSer, ffFixed, 12, 2);
  edtPerIss.Text := FloatToStrF(objServicos.fltPerIss, ffFixed, 12, intDecSer);
  edtRedIss.Text := FloatToStrF(objServicos.fltRedIss, ffFixed, 12, 2);
  edtDedIss.Text := FloatToStrF(objServicos.fltDedIss, ffFixed, 12, 2);
  edtValIss.Text := FloatToStrF(objServicos.fltValIss, ffFixed, 12, 2);

  If objServicos.dtaDtAgeS > 0 Then
    edtDtAgeS.Text := DateToStr(objServicos.dtaDtAgeS);

  If objServicos.horHrAgeS > 0 Then
    edtHrAgeS.Text := FormatDateTime('hh:mm', objServicos.horHrAgeS);

  If objServicos.dtaDtEntS > 0 Then
    edtDtEntS.Text := DateToStr(objServicos.dtaDtEntS);

  If objServicos.horHrEntS > 0 Then
    edtHrEntS.Text := FormatDateTime('hh:mm', objServicos.horHrEntS);

  If pnlMunicipioNatureza.Visible Then
  Begin
    chkNatureza.EditValue := IIF(fEmptyStr(objServicos.strNatSer), fatVenda.FRecSer.strNatSer, objServicos.strNatSer);
  End;
end;

function TfrmFatDigServico.fGetComponent(strName: String; intServic: Integer): TComponent;
begin
  Result := fComponentByName(fGetPanel(intServic), strName + intToStr(intServic));
end;

function TfrmFatDigServico.fGetMecanico(strIdeSer: String): String;
begin
  Result := fGetPropValue('strMecS', strIdeSer.ToInteger);
end;

function TfrmFatDigServico.fGetPropValue(strName: String; intServic: Integer): Variant;
begin
  Result := GetPropValue(objServicos, strName + fStrZero(intServic, 2));
end;

procedure TfrmFatDigServico.pCarregaStatusServico;
  Var
    strStatus   : String;
    intServic   : Integer;
    blnLibSer   : Boolean;
begin

  With fCriaQuery(nil), SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE ');
    Add('  STS_CODIGO AS CODIGO,');
    Add('  STS_DESCRI AS DESCRI,');
    Add('  STS_FINALI AS FINALI, ');
    Add('  STS_SELFAT AS SELFAT ');
    Add('FROM');
    Add('  STASER');
    Add('ORDER BY 1');

    Open;

    strStatFinalServ := '';
    strStatNaoSeleciona := '';

    For intServic := 1 To 30 Do
      TComboBox(fGetComponent('cmbStaSe', intServic)).Clear;

    While Not Eof Do
    Begin
      strStatus := fPadR(FieldByName('DESCRI').AsString, 40) + '-' +
                         FieldByName('CODIGO').AsString;

      For intServic := 1 To 30 Do
        TComboBox(fGetComponent('cmbStaSe', intServic)).Items.Add(strStatus);

      If FieldByName('FINALI').AsString = 'S' Then
        strStatFinalServ := strStatFinalServ + FieldByName('CODIGO').AsString + '_';

      If FieldByName('SELFAT').AsString = 'N' Then
        strStatNaoSeleciona := strStatNaoSeleciona + FieldByName('CODIGO').AsString + '_';

      Next;
    End;

    For intServic := 1 To 30 Do
      If Locate('CODIGO', fGetPropValue('strStaS', intServic), []) Then
        TComboBox(fGetComponent('cmbStaSe', intServic)).ItemIndex := RecNo -1;

    {*****************************************************************************}
    {* CASO ESTEJA ALTERANDO UM PEDIDO QUE POSSUA SERVICOS FINALIZADOS ENTAO     *}
    {* NAO PERMITE ALTERAR OS CODIGOS, QUANTIDADES, STATUS DO SERVIÇO E O PRISMA *}
    {*************************************************************************JC**}
    If Not fEmptyStr(fatVenda.strNumOrc) Then
    Begin
      blnFinalizouTodosServicos := True;

      For intServic := 1 To 30 Do
      Begin
        If fPos(fGetPropValue('strStaS', intServic), strStatFinalServ) Then
        Begin
          TEditFocus(fGetComponent('edtCodSe', intServic)).ReadOnly := True;
          TEditFocus(fGetComponent('edtQtdSe', intServic)).ReadOnly := True;
          TComboBox (fGetComponent('cmbStaSe', intServic)).Enabled  := False;
        End;

        If Not TEditFocus(fGetComponent('edtCodSe', intServic)).ReadOnly And
           Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intServic)).Text) Then
        Begin
          blnFinalizouTodosServicos := False;
        End;
      End;

      blnLibSer := True;

      {*********************************************************************************}
      {* CASO TODOS OS SERVICOS ESTEJAM FINALIZADOS NAO PERMITE INCLUIR NOVOS SERVICOS *}
      {* POIS O NUMERO DO PRISMA JA FICOU DISPONIVEL PARA OUTRO PEDIDO UTILIZAR        *}
      {******************************************************************************JC*}
      If (blnFinalizouTodosServicos) And (Not fEmptyStr(edtCodSe1.Text)) Then
      Begin
        blnLibSer := False;

        If (fatVenda.strOpcDoc = 'PD') And
           (fPergunta('Todos os serviços deste documento já foram ' +
                      'finalizados. Deseja incluir novos serviços?', False)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Autocenter - Incluir novos serviços em um pedido de venda com todos serviços já finalizados.');

          objLiberacao.strDirAce := 'ACEINCSERPDFIN';
          objLiberacao.strMsgSen := 'Autocenter - Incluir novos serviços em um pedido de venda com todos serviços já finalizados.';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := fatVenda.strCodVen;
          objLiberacao.strCodDig := fatVenda.strCodDig;

          blnLibSer := objLiberacao.fLibera;
        End;
      End;

      For intServic := 1 To 30 Do
      Begin
        //Se ja finalizou todos os servicos entao o prisma ja foi liberado para outros pedidos
        If blnFinalizouTodosServicos And blnLibSer Then
          TEditFocus(fGetComponent('edtPriSe', intServic)).Clear;

        If fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intServic)).Text) Then
        Begin
          TEditFocus(fGetComponent('edtCodSe', intServic)).ReadOnly := Not blnLibSer;
          TEditFocus(fGetComponent('edtQtdSe', intServic)).ReadOnly := Not blnLibSer;
          TComboBox (fGetComponent('cmbStaSe', intServic)).Enabled  := blnLibSer;
        End;
      End;

    End;

    Destroy;
  End;

end;

procedure TfrmFatDigServico.pCarregaTempoMedioServicos;
  Var
    intSer: Integer;
begin
  For intSer := 1 To 30 Do
    If TEditFocus(fGetComponent('edtCodSe', intSer)).Visible Then
      TEditFocus(fGetComponent('edtTmpSe', intSer)).Text :=
        fRetTempoMedioServico(TEditFocus(fGetComponent('edtCodSe', intSer)).Text);
end;

procedure TfrmFatDigServico.pColorePrismas;
  Var
    intSer: Integer;
    strCodSer: String;
    edtPrisma: TEdit;
begin
  For intSer := 1 To 30 Do
  Begin
    strCodSer := TEdit(fGetComponent(fGetPanel(intSer), 'edtCodSe', intSer)).Text;
    If Not fEmptyStr(strCodSer) Then
    Begin
      If qryCadSer.Locate('SER_CODSER', strCodSer, []) Then
      Begin
        edtPrisma := TEdit(fGetComponent(fGetPanel(intSer), 'edtPriSe', intSer));
        
        edtPrisma.Color := StrToIntDef(qryCadSer.FieldByName('TPS_CORIDE').AsString, clWhite);
        edtPrisma.Font.Color := fGetCorFonteEdit(edtPrisma.Color)
      End;
    End;
  End;
end;

function TfrmFatDigServico.fPodeDefinirMecanico: Boolean;
begin
  Result := False;

  If Not fCfgSis('MECSER', varBoolean) Then
    Exit;

  If Self.blnNFSeSubstituicao Then
    Exit(True);

  If Not fatVenda.fEhAutocenter Then
    Exit;

  Result := True;
end;

procedure TfrmFatDigServico.btnMecPadraoClick(Sender: TObject);
begin
  inherited;

  If not fPodeDefinirMecanico Then
    Exit;

  Try
    pCriarFormularios(TfrmDigMecanicos, frmDigMecanicos);
    frmDigMecanicos.stlMecanicosPadrao.CommaText := strMecPadrao;
    frmDigMecanicos.blnMecPadrao := True;


    If frmDigMecanicos.ShowModal = mrOk Then
      strMecPadrao   := frmDigMecanicos.stlMecanicosPadrao.CommaText;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'btnMecPadraoClick');
    End;
  End;

  pFreeAndNil(frmDigMecanicos);
end;

procedure TfrmFatDigServico.btnAcompanhaServClick(Sender: TObject);
begin
  If Not (btnAcompanhaServ.Enabled And btnAcompanhaServ.Visible)Then
    Exit;

  If fCfgSis('ACOSER') = '1' Then  
    pCriarForm(TfrmConsultaServicosAutocenter)
  Else
    pCriarForm(TfrmConsultaServicosAutocenterVendas);
end;

procedure TfrmFatDigServico.btnAdendosClick(Sender: TObject);
  Var
    chrKey: Char;
    qryTmp: TUniQuery;
    arrAdendo: TConsultasArray;
begin
  If pnlDadosEstatisticos.Visible Then
  Begin
    chrKey := '/';
    qryTmp := fCriaQuery;

    If fPesqCadAdendo(Self, Nil, Nil, qryTmp, chrKey, arrAdendo) Then
      mmoSerObs.Texto := qryTmp.FieldByName('ADE_TEXTO_').AsString;

    If Assigned(qryTmp) Then
      pFreeAndNil(qryTmp);

    pSetFocus(mmoSerObs);
    mmoSerObs.SelStart := Length(mmoSerObs.Texto);
  End;
end;

procedure TfrmFatDigServico.btnAgendamentosProgClick(Sender: TObject);
  Var
    frmConsultaServicosAutocenter : TfrmConsultaServicosAutocenter;
begin
  If Not (btnAgendamentosProg.Enabled And btnAgendamentosProg.Visible) Then
    Exit;
     
  pCriarFormularios(TfrmConsultaServicosAutocenter, frmConsultaServicosAutocenter);
  Try
    frmConsultaServicosAutocenter.blnAgendamento := True;
    frmConsultaServicosAutocenter.ShowModal;
  Finally
    pFreeAndNil(frmConsultaServicosAutocenter);
  End;
end;

procedure TfrmFatDigServico.btnConfirmaClick(Sender: TObject);
  Var
    i                : Integer;

    blnTravaDesc,
    blnTemServIsento,
    blnTemServRateio,
    blnTemServTercei,
    blnSoIsentos,
    blnVendaSemItens : Boolean;

    fltValDes        : Double;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    blnRegistroIgual : boolean;

  function fSomenteBrindes: Boolean;
    Var
      intSer: Integer;
  begin
    Result := Not fEmptyStr(edtCodSe1.Text);//Tem servico informado

    For intSer := 1 To 30 Do
    Begin
      If (Not fEmptyStr(TEditFocus(fGetComponent(fGetPanel(intSer), 'edtCodSe', intSer)).Text)) And
         (Not TCheckBox(fGetComponent(fGetPanel(intSer), 'chkBriSe', intSer)).Checked) Then
      Begin
        Result := False;
        Break;
      End;
    End;
  end;
  
begin
  inherited;

  pRemanejaServicos;

  If (Not fValidaCampos(edtCodSe1, False)) Then
    Exit;

  If (Not fVerificaCampos) Then
  Begin
    Exit;
  End;

  if (not fValidaIRPJ) then
    Exit;

  if (not fValidaPisCofinsCsll) then
    Exit;

  If not fValidaDeducoes Then
    Exit;

//  If (fValidarServicosEmBranco()) Then Exit;

  If (fUsaDiscriminacaoServico) And
     (fEmptyStr(objServicos.strDisSer)) And
     (fCfgSis('EMPSER', varString) = 'CITEL') And
     (fCfgSis('DSERCI', varBoolean)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário informar a discriminação do serviço, botão: "' + btnDisSer.Caption + '"', ['&OK']);
    pSetFocus(btnDisSer);
    Exit;
  End;

  If Not blnUsaRateio Then
  Begin
    If (fStrToFloat(edtTotSer.Text) <= 0.0) And Not fSomenteBrindes Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar o valor do serviço!', ['&Ok']);

      If Not chkBriSe1.Visible Then
        pSetFocus(edtValSe1);

      Exit;
    End;
  End
  Else
  Begin
    If ((fStrToFloat(edtTotSer.Text) +
         fStrToFloat(edtTotIse.Text) +
         fStrToFloat(edtTotRat.Text)) <= 0.0) And Not fSomenteBrindes Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar o valor do serviço!', ['&Ok']);
      pSetFocus(edtValSe1);
      Exit;
    End;
  End;

  If (fEmptyStr(edtDesSe1.Text)) And
     (fEmptyStr(edtDesSe2.Text)) And
     (fEmptyStr(edtDesSe3.Text)) And
     (fEmptyStr(edtDesSe4.Text)) And
     (fEmptyStr(edtDesSe5.Text)) And
     (fEmptyStr(edtDesSe6.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos uma descrição!', ['&Ok']);

    pSetFocus(edtCodSe1);

    Exit;
  End;

  If (fMecanicoEhObrigatorio) And (Not fValidaMecanicos) Then
    Exit;

  if Assigned(objRegistroServAtu) then
    FreeAndNil(objRegistroServAtu);

  objRegistroServAtu := fGeraRegistroServicos;


  //quando é texto, não existem serviços
  if (objRegistroServAtu is TRegistroMsgLiberaTexto) and (objRegistroServOri is TRegistroMsgLiberaTexto) then
    blnRegistroIgual :=  True
  else if (objRegistroServAtu is TRegistroMsgLiberaTabela) and (objRegistroServOri is TRegistroMsgLiberaTabela) then
    blnRegistroIgual := (objRegistroServAtu as TRegistroMsgLiberaTabela).fIgual((objRegistroServOri as TRegistroMsgLiberaTabela))
  else
    blnRegistroIgual := False;

  // Pede senha para alteração dos serviços quando estiver configurado e estiver sendo efetuado alteração de pedido.
  If (fCfgSis('OBGSES', varBoolean)) And (Not fEmptyStr(fatVenda.strNumOrc)) And (fatVenda.strOpcDoc = 'PD') And (not blnRegistroIgual)  Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Alteração de Pedido [ '+ fatVenda.strNumOrc +'-PD ] - Alterar serviços');
    objLiberacao.objMsgLibera.pAddTexto('Serviços Originais:');
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.objMsgLibera.lstRegistros.Add(objRegistroServOri.fGetClone);

    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('Serviços Modificados:');
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.objMsgLibera.lstRegistros.Add(objRegistroServAtu.fGetClone);

    objLiberacao.strDirAce := 'SEALTS';
    objLiberacao.strSenLib := fCfgSis('SEALTS');
    objLiberacao.strMsgSen := 'Alteração de Pedido - Alterar serviços';
    objLiberacao.strCodOpe := fatVenda.strCodVen;
    objLiberacao.strCodDig := fatVenda.strCodDig;

    If Not objLiberacao.fLibera Then
      Exit;
  End;

  if (not fLiberaAlteracaoServiçoOSGarantia(blnRegistroIgual)) then
    Exit;

  {*************************************************************************}
  {* SE UTILIZAR OPÇÃO DE DESCONTO POR SERVIÇO, VERIFICAR SE OS DESCONTOS  *}
  {* INFORMADOS NÃO ULTRAPASSAM O DESCONTO MÁXIMO. CASO SIM, ENVIAR MSG DE *}
  {* LIBERAÇÃO PARA GERENTE, INFORMANDO TODOS OS SERVIÇOS E SEUS DESCONTOS *}
  {**********************************************************************MM*}
  If blnUsaDesc Then
  Begin
    i := 1;
    blnTravaDesc := False;

    While i <= intLinSer Do
    Begin
      If fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtDecSe', i)).Text) > fDescMax(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text) Then
      Begin
        blnTravaDesc := True;
        i := intLinSer;
      End;

      i := i + 1;
    End;

    If blnTravaDesc Then
    Begin
      objLiberacao.Clear;
      If (fCfgSis('SENFVU',varString) = 'F') Then
      Begin
        objLiberacao.objMsgLibera.pAddTexto('Desconto informado é maior que o permitido. Serviços bloqueados:');

        For i := 1 To intLinSer Do
        Begin

          If (Not fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text)) And
             (fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtDecSe', i)).Text) > fDescMax(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text)) Then
          Begin
            objLiberacao.objMsgLibera.pAddTexto('    * ' + TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text + ' - ' + TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Text);
          End;
        End;
      End
      Else
      Begin
        objLiberacao.objMsgLibera.pAddTexto('DESCONTO MÁXIMO DE SERVIÇO ULTRAPASSADO ');

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'VER'        , 3  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'SERVIÇO'    , 19 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DESC.PRAT.%', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'DESC.MÁXI.%', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VALOR BRUTO', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VALOR DESC.', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VALOR LÍQUI', 11 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        For i := 1 To intLinSer Do
        Begin
          fltValDes := fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text) * (fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtDecSe', i)).Text) / 100);

          If Not fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text) Then
          begin
            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('VER'        , IIF(fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtDecSe', i)).Text) > fDescMax(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text),' * ','   ') , 3  , alCentro  );
            objLinha.pAddColuna('SERVIÇO'    , TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text + '-' + TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Text                                   , 19 , alEsquerda);
            objLinha.pAddColuna('DESC.PRAT.%', FloatToStrF(fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtDecSe', i)).Text), ffFixed, 10,2)                                                         , 11 , alDireita );
            objLinha.pAddColuna('DESC.MÁXI.%', FloatToStrF(fDescMax(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text), ffFixed, 10,2)                                                            , 11 , alDireita );
            objLinha.pAddColuna('VALOR BRUTO', FloatToStrF(fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text), ffFixed, 10,2)                                                         , 11 , alDireita );
            objLinha.pAddColuna('VALOR DESC.', FloatToStrF(fltValDes, ffFixed, 10,2)                                                                                                                   , 11 , alDireita );
            objLinha.pAddColuna('VALOR LÍQUI', FloatToStrF(fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).Text), ffFixed, 10,2)                                                         , 11 , alDireita );
            objTabela.lstLinhas.Add(objLinha);

          end;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      End;

      objLiberacao.strDirAce := 'DEMXSE';
      objLiberacao.strSenLib := fCfgSis('SENDMX');
      objLiberacao.strMsgSen := 'Desconto Máximo Ultrapassado';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;

      If (Not objLiberacao.fLibera) Then
        Exit;
    End;
  End
  Else
  Begin
    i := 1;
    blnTravaDesc := False;

    While i <= intLinSer Do
    Begin
      if fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text) Then
        Break;

      If (Not fCfgSis('QTDSER', VarBoolean)) And (fCfgSis('ALVLSE', VarBoolean)) Then
      Begin
        arrValoresServico[i-1].fltValLiq := fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text);
      End
      Else If (fCfgSis('QTDSER', VarBoolean)) Then
      Begin
        arrValoresServico[i-1].fltValLiq := fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtUniSe', i)).Text);
      End;

      arrValoresServico[i-1].fltValDes := arrValoresServico[i-1].fltValBru - arrValoresServico[i-1].fltValLiq;
      arrValoresServico[i-1].fltDesPra := ((arrValoresServico[i-1].fltValDes * 100) / arrValoresServico[i-1].fltValBru);

      If arrValoresServico[i-1].fltDesPra > arrValoresServico[i-1].fltDesMax Then
        blnTravaDesc := True;

      i := i + 1;
    End;

    If blnTravaDesc Then
    Begin
      objLiberacao.Clear;
      If (fCfgSis('SENFVU',varString) = 'F') Then
      Begin
        objLiberacao.objMsgLibera.pAddTexto('Desconto informado é maior que o permitido. Serviços bloqueados:');

        For i := 1 To intLinSer Do
        Begin

          If (Not fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text)) And
             (arrValoresServico[i-1].fltDesPra > arrValoresServico[i-1].fltDesMax) Then
          Begin
            objLiberacao.objMsgLibera.pAddTexto('    * ' + TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text + ' - ' + TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Text);
          End;
        End;
      End
      Else
      Begin
        objLiberacao.objMsgLibera.pAddTexto('DESCONTO MÁXIMO DE SERVIÇO ULTRAPASSADO ');

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'VER'        , 3  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'SERVIÇO'    , 19 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DESC.PRAT.%', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'DESC.MÁXI.%', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VALOR BRUTO', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VALOR DESC.', 11 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VALOR LÍQUI', 11 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        For i := 1 To intLinSer Do
        Begin
          If Not fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text) Then
          begin
            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('VER'        , IIF(arrValoresServico[i-1].fltDesPra > arrValoresServico[i-1].fltDesMax ,' * ','   ') , 3  , alCentro  );
            objLinha.pAddColuna('SERVIÇO'    , arrValoresServico[i-1].strCodSer + arrValoresServico[i-1].strDescri                   , 19 , alEsquerda);
            objLinha.pAddColuna('DESC.PRAT.%', FloatToStrF(arrValoresServico[i-1].fltDesPra, ffFixed, 10,2)                          , 11 , alDireita );
            objLinha.pAddColuna('DESC.MÁXI.%', FloatToStrF(arrValoresServico[i-1].fltDesMax, ffFixed, 10,2)                          , 11 , alDireita );
            objLinha.pAddColuna('VALOR BRUTO', FloatToStrF(arrValoresServico[i-1].fltValBru, ffFixed, 10,2)                          , 11 , alDireita );
            objLinha.pAddColuna('VALOR DESC.', FloatToStrF(arrValoresServico[i-1].fltValDes, ffFixed, 10,2)                          , 11 , alDireita );
            objLinha.pAddColuna('VALOR LÍQUI', FloatToStrF(arrValoresServico[i-1].fltValLiq, ffFixed, 10,2)                          , 11 , alDireita );
            objTabela.lstLinhas.Add(objLinha);
          end;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      End;

      objLiberacao.strDirAce := 'DEMXSE';
      objLiberacao.strSenLib := fCfgSis('SENDMX');
      objLiberacao.strMsgSen := 'Desconto Máximo Ultrapassado';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;

      If (Not objLiberacao.fLibera) Then
        Exit;
    End;
  End;

  If blnUsaRateio Then
  Begin
    blnTemServIsento := False;
    blnTemServRateio := False;
    blnTemServTercei := False;

    i := 1;

    While i <= intLinSer Do
    Begin
      If (Not fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text)) Then
      Begin

        If (TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Tag = 1) Then
        Begin
          blnTemServIsento := True;

          If (TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Font.Color = clRed) Then
            blnTemServTercei := True;
        End
        Else If (TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Tag = 2) Then
        Begin
          blnTemServRateio := True;

          If (TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Font.Color = clRed) Then
            blnTemServTercei := True;
        End;

      End;

      i := i + 1;
    End;

    {**********************************************}
    {* VERIFICA SE HÁ PRODUTOS INSERIDOS NA VENDA *}
    {*******************************************MM*}
    blnVendaSemItens := True;

    For i := 0 To High(fatVenda.arrMatItens) Do
    Begin
      If (fatVenda.arrMatItens[i].strCodIte <> fCfgSis('ITESER',varString)) And
         (fatVenda.arrMatItens[i].strCodIte <> fCfgSis('SERTER',varString)) Then
      Begin
        blnVendaSemItens := False;
      End;
    End;

    {********************************************************************}
    {* SE ALGUM SERVIÇO TERCEIRIZADO FOR DIFERENTE DE "COBRANÇA EM NS", *}
    {* SISTEMA DEVE TRAVAR E NÃO PERMITIR SALVAR O DOCUMENTO.           *}
    {*****************************************************************MM*}
    If blnTemServTercei Then
    Begin
      fMensagem('ATENÇÃO!', 'Serviços Terceirizados não podem ser Isentos nem Rateados nos itens.' + #13 +
                            'Modifique a identificação destes serviços para "Cobrança em NS"!', ['&Ok']);
      pSetFocus(edtCodSe1);
      Exit;
    End;

    {*********************************************************************}
    {* SE UTILIZAR OPÇÃO DE "ISENÇÃO DE SERVIÇO", SISTEMA DEVE SOLICITAR *}
    {* LIBERAÇÃO INFORMANDO TODOS OS SERVIÇOS QUE SERÃO ISENTOS.         *}
    {******************************************************************MM*}
    If blnTemServIsento Then
    Begin
      i := 1;
      blnSoIsentos := True;

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto(' SERVIÇOS QUE SERÃO ISENTOS DE COBRANÇA:');

      objTabela := TRegistroMsgLiberaTabela.Create;
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'SERVIÇO'  , 40 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VALOR R$' , 11 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      While i <= intLinSer Do
      Begin
        If (Not fEmptyStr(TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text)) Then
        Begin
          If (TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Tag = 1) Then
          Begin
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('SERVIÇO'  , TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Text + '-' + TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Text , 40 , alEsquerda );
            objLinha.pAddColuna('VALOR R$' , FloatToStrF(fStrToFloat(TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Text), ffFixed, 10,2)                       , 11 , alDireita  );
            objTabela.lstLinhas.Add(objLinha);
          End
          Else
            blnSoIsentos := False;
        End;

        i := i + 1;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      {***********************************************************}
      {* SE A VENDA NÃO TIVER PRODUTOS E FOR SELECIONADO SOMENTE *}
      {* SERVIÇOS ISENTOS, O SISTEMA DEVE BLOQUEAR               *}
      {********************************************************MM*}
      If blnSoIsentos And blnVendaSemItens Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta NF não possui produtos e todos os serviços estão "Isentos"' + #13 +
                              'Modifique a identificação de pelo menos um serviço para "Cobrança em NS"!', ['&Ok']);
        pSetFocus(edtCodSe1);
        Exit;
      End;

      objLiberacao.strDirAce := 'ISCOSE';
      objLiberacao.strMsgSen := 'Alterar identificação do serviço';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;

      If Not objLiberacao.fLibera Then
        Exit;
    End;

    {*************************************************************}
    {* SE UTILIZAR OPÇÃO DE "RATEAR NOS ITENS", SÓ DEVE PERMITIR *}
    {* ESSA IDENTIFICAÇÃO QUANDO TIVER PRODUTOS INSERIDOS NA NF. *}
    {**********************************************************MM*}
    If blnTemServRateio Then
    Begin
      If blnVendaSemItens Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta NF não possui produtos.' + #13 +
                              'Modifique a identificação dos serviços que estão como "Ratear nos Itens"!', ['&Ok']);
        pSetFocus(edtCodSe1);
        Exit;
      End;
    End;
  End;

  If fExibeEnderecoDeEntrega Then
  Begin
    fatVenda.blnPedeEndEntregaServicos := True;

    If (fatVenda.strOpcDoc = 'VS') And (Not fPedeEnderecoEntrega) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário selecionar o endereço de entrega para o(s) serviço(s)!', ['&Ok']);
      pSetFocus(btnDisSer);
      Exit;
    End;
  End;

  Close;
  ModalResult := mrOk;

  For i := 1 To 30 Do
    pSetarPropriedadesServicos(i);

  pSetaPropriedadesGeral;
end;

procedure TfrmFatDigServico.btnDisSerClick(Sender: TObject);
begin
  If Not ((btnDisSer.Enabled) And (btnDisSer.Visible)) Then
    Exit;

  Try
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.Caption := 'Discriminação dos Serviços';
    frmObservacao.lblMensagem.Caption := 'Discriminação dos Serviços: ';
    frmObservacao.memObs.Text := objServicos.strDisSer;
    frmObservacao.blnUtilizarConfirmacao := True;
    frmObservacao.ShowModal;
    If (frmObservacao.blnConfirmou) Then
      objServicos.strDisSer := frmObservacao.memObs.Text;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatDigServico.btnDisSerClick]');
  End;
  pFreeAndNil(frmObservacao);
end;

procedure TfrmFatDigServico.btnIdent1Click(Sender: TObject);
begin
  inherited;

  If blnSoVisualizaIdent Then
    Exit;

  If fEhServicoOutroVendedorSemPermissaoParaAlterar(fGetNumbers(TSpeedButton(Sender).Name).ToInteger) Then
    Exit;

  pCriarFormularios(TfrmFatDigIdentServico, frmFatDigIdentServico);
  frmFatDigIdentServico.ShowModal;

  If (frmFatDigIdentServico.ModalResult = mrOk) Then
    pIdentificaServico(Sender, frmFatDigIdentServico.intIndImg);

  pFreeAndNil(frmFatDigIdentServico);
end;

procedure TfrmFatDigServico.edtCodSe1Enter(Sender: TObject);
begin
  inherited;
  strCodSerAnt := TEditFocus(Sender).Text;
end;

procedure TfrmFatDigServico.edtCodSe1KeyPress(Sender: TObject; var Key: Char);
  Var
    arrServ: TConsultasArray;
    objfrmPnl : TPanelCxServico;
begin
  inherited;
  If TEditFocus(Sender).ReadOnly Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE SERVIÇOS   *}
  {****************************RV*}
  objfrmPnl := TPanelCxServico.Create(TfrmPnlDadosServico);
  If fPesqServicos(Self, TEditFocus(Sender),
                   TEditFocus(FindComponent('edtDesSe' + fGetNumbers(TEditFocus(Sender).Name))),
                   Nil, Key, arrServ, True, False, objfrmPnl) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigServico.pIdentificaServico(Sender: TObject;
                                               intIdenti: Integer;
                                               blnSomaValores: Boolean = True);
begin
  TSpeedButton(Sender).Glyph.Assign(nil);
  imgIdent.GetBitmap(intIdenti, TSpeedButton(Sender).Glyph);
  TSpeedButton(Sender).Tag := intIdenti;

  Case intIdenti Of
   0: TSpeedButton(Sender).Hint := 'Cobrança em NS';
   1: TSpeedButton(Sender).Hint := 'Isento de Cobrança';
   2: TSpeedButton(Sender).Hint := 'Rateado nos Itens';
  End;

  If blnSomaValores Then
    pSomaValores;
end;

procedure TfrmFatDigServico.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SER_DESSER');
  stlCampos.Add('SER_CODSER');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SER_DESSER');
  stlCamInd.Add('SER_CODSER');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

End;

procedure TfrmFatDigServico.pPermicaoAlteraValor(edtUniSer, edtValSer: TEditFocus);
var
  blnPerfilCliente: Boolean;
  blnCndVenFim:     Boolean;
begin



  blnPerfilCliente := fCfgSis('PFLCLI', varBoolean);
  blnCndVenFim := fCfgSis('CNDVEN', VarString) = 'F';

  If (blnPerfilCliente) And ((Not fRetCampoCndPagto(fatVenda.strCodCnd, 'CND_ALTPRE')) And (Not blnCndVenFim)) Then
  Begin
    edtUniSer.readOnly := True;
    edtValSer.readOnly := True;
  End;

  If (Not fCfgSis('ALVLSE', VarBoolean)) and (not fatVenda.blnPedFabOSG) Then
  Begin
    If fCfgSis('CNDVEN', VarString) = 'F' Then
    Begin
      edtUniSer.readOnly := False;
      edtValSer.readOnly := False;
    End;
  End;
end;

{*************************************************************************}
{* REMANEJA AS LINHAS DE SERVIÇO PARA QUE NÃO FIQUE INTERVALOS EM BRANCO *}
{* INTERVALOS ESSES QUE DÃO PROBLEMA NA AUTORIZAÇÃO DE NFSE REQ: 45654   *}
{**********************************************************************VA*}
procedure TfrmFatDigServico.pRemanejaServicos;
  Const
   strControlesServicos: String = 'edtCodSe/edtDesSe/edtDecSe/edtLiqSe/edtQtdSe/edtUniSe/edtValSe/chkBriSe/cmbStaSe/edtTmpSe/edtPriSe/btnIdent/';
   contQtdMaxSrv: Integer = 30;
  Var
   strBrinde: String;
   strCodPar: String;
   strTipBri: String;
   intIdxCmp: Integer;
   intIdxAux: Integer;
   SL: TStringList;

  Function fHaUmHiato: Boolean;
   Var
    intIdxAux: Integer;
  Begin
    Result := False;
    For intIdxAux := 1 To contQtdMaxSrv-1 Do
    Begin
       If (fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intIdxAux)).Text)) And
          (Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intIdxAux + 1)).Text)) Then
       Begin
          Result := True;
          Break;
       End;
    End;
  End;

begin
  SL := TStringList.Create;
  ExtractStrings(['/'], [' '], PWideChar(strControlesServicos), SL);
  Try
    blnPedirBrinde := False;
    While fHaUmHiato Do
    Begin
      For intIdxCmp := 1 To contQtdMaxSrv-1 Do
      Begin
        If (fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intIdxCmp)).Text)) And
           (Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intIdxCmp + 1)).Text)) Then
        Begin
          pSetPropValue('strCodS', intIdxCmp, fGetPropValue('strCodS', intIdxCmp + 1));
          pSetPropValue('strDesS', intIdxCmp, fGetPropValue('strDesS', intIdxCmp + 1));
          pSetPropValue('fltQtdS', intIdxCmp, fGetPropValue('fltQtdS', intIdxCmp + 1));
          pSetPropValue('fltUniS', intIdxCmp, fGetPropValue('fltUniS', intIdxCmp + 1));
          pSetPropValue('fltValS', intIdxCmp, fGetPropValue('fltValS', intIdxCmp + 1));
          pSetPropValue('fltCusS', intIdxCmp, fGetPropValue('fltCusS', intIdxCmp + 1));
          pSetPropValue('fltDecS', intIdxCmp, fGetPropValue('fltDecS', intIdxCmp + 1));
          pSetPropValue('strMecS', intIdxCmp, fGetPropValue('strMecS', intIdxCmp + 1));
          pSetPropValue('strObsS', intIdxCmp, fGetPropValue('strObsS', intIdxCmp + 1));
          pSetPropValue('strBriS', intIdxCmp, fGetPropValue('strBriS', intIdxCmp + 1));
          pSetPropValue('strParS', intIdxCmp, fGetPropValue('strParS', intIdxCmp + 1));
          pSetPropValue('strTBrS', intIdxCmp, fGetPropValue('strTBrS', intIdxCmp + 1));
          pSetPropValue('strStaS', intIdxCmp, fGetPropValue('strStaS', intIdxCmp + 1));
          pSetPropValue('strPriS', intIdxCmp, fGetPropValue('strPriS', intIdxCmp + 1));
          pSetPropValue('strIdeS', intIdxCmp, fGetPropValue('strIdeS', intIdxCmp + 1));
          pSetPropValue('strVenS', intIdxCmp, fGetPropValue('strVenS', intIdxCmp + 1));
          pSetPropValue('strVe2S', intIdxCmp, fGetPropValue('strVe2S', intIdxCmp + 1));

          pSetMecanico(IntToStr(intIdxCmp), fGetMecanico(IntToStr(intIdxCmp + 1)));
          pSetMecanico(IntToStr(intIdxCmp + 1), '');

          pSetObservacao(IntToStr(intIdxCmp), fGetObservacao(IntToStr(intIdxCmp + 1)));
          pSetObservacao(IntToStr(intIdxCmp + 1), '');

          strBrinde := fGetBrinde(IntToStr(intIdxCmp + 1), strCodPar, strTipBri);
          pSetBrinde(IntToStr(intIdxCmp), strBrinde, strCodPar, strTipBri);
          pSetBrinde(IntToStr(intIdxCmp + 1), 'N', '', '');

          For intIdxAux := 0 To SL.Count-1 Do
          Begin
            If fGetComponent(SL[intIdxAux], intIdxCmp) Is TEditFocus Then
            Begin
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp)).Text        := TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Text;
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp)).Enabled     := TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Enabled;
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp)).ReadOnly    := TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).ReadOnly;
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp)).Color       := TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Color;
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp)).NormalColor := TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).NormalColor;
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp)).FocusColor  := TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).FocusColor;
              TEditFocus(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Clear;
            End
            Else If fGetComponent(SL[intIdxAux], intIdxCmp) Is TComboBox Then
            begin
              TComboBox(fGetComponent(SL[intIdxAux], intIdxCmp)).ItemIndex := TComboBox(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).ItemIndex;
              TComboBox(fGetComponent(SL[intIdxAux], intIdxCmp)).Enabled   := TComboBox(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Enabled;
              TComboBox(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).ItemIndex := -1;
            End
            Else If fGetComponent(SL[intIdxAux], intIdxCmp) Is TCheckBox Then
            begin
              TCheckBox(fGetComponent(SL[intIdxAux], intIdxCmp)).Checked := TCheckBox(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Checked;
              TCheckBox(fGetComponent(SL[intIdxAux], intIdxCmp)).Enabled := TCheckBox(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Enabled;
              TCheckBox(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Checked := False;
            End
            Else If fGetComponent(SL[intIdxAux], intIdxCmp) Is TSpeedButton Then
            begin
              TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp)).Tag     := TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Tag;
              TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp)).Enabled := TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Enabled;
              TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Tag := 0;

              pIdentificaServico(TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp)), TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp)).Tag, False);
              pIdentificaServico(TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp + 1)), TSpeedButton(fGetComponent(SL[intIdxAux], intIdxCmp + 1)).Tag, False);
            End;
          End;

          pSetPropValue('strCodS', intIdxCmp + 1, '');
          pSetPropValue('strDesS', intIdxCmp + 1, '');
          pSetPropValue('fltQtdS', intIdxCmp + 1, 0 );
          pSetPropValue('fltUniS', intIdxCmp + 1, 0 );
          pSetPropValue('fltValS', intIdxCmp + 1, 0 );
          pSetPropValue('fltCusS', intIdxCmp + 1, 0 );
          pSetPropValue('fltDecS', intIdxCmp + 1, 0 );
          pSetPropValue('strMecS', intIdxCmp + 1, '');
          pSetPropValue('strObsS', intIdxCmp + 1, '');
          pSetPropValue('strBriS', intIdxCmp + 1, '');
          pSetPropValue('strParS', intIdxCmp + 1, '');
          pSetPropValue('strTBrS', intIdxCmp + 1, '');
          pSetPropValue('strStaS', intIdxCmp + 1, '');
          pSetPropValue('strPriS', intIdxCmp + 1, '');
          pSetPropValue('strIdeS', intIdxCmp + 1, '');
          pSetPropValue('strVenS', intIdxCmp + 1, '');
          pSetPropValue('strVe2S', intIdxCmp + 1, '');
        End;
      End;
    End;
  Finally
    blnPedirBrinde := True;
    FreeAndNil(SL);
  End;
end;

procedure TfrmFatDigServico.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodSe1);
end;

procedure TfrmFatDigServico.FormCreate(Sender: TObject);
  Var
    i: Integer;
    intTamanhoCampo: Integer;
begin
  inherited;

  varPodeAlterarServicosOutrosVendedores := Null;

  qryCadSer := fCriaQuery;
  qryCadSer.SQL.Add('SELECT *');
  qryCadSer.SQL.Add('  FROM CADSER ');
  qryCadSer.SQL.Add('  LEFT JOIN TIPSER ON TPS_CODIGO = SER_TIPSER');
  qryCadSer.Open;

  stlLockedPrismasTmp := TStringList.Create;

  objLiberacao := TLiberacao.Create;

  blnSoVisualizaIdent := False;

  blnNFSeSubstituicao := False;

  blnPedirBrinde := True;

  blnUsaRateio := fUsaRateioDeServicos;

  intDecSer := fObterQtdeCasasDecimaisCampo('CADCLI','CLI_ALQISS');

  If (fCfgSis('LINSER', varInteger) > 30) Then
    intLinSer := 30
  Else
    intLinSer := fCfgSis('LINSER', varInteger);

  intTamanhoCampo := fRetornaTamanhoCampoTabela('MOVGER', 'GER_DESS01');

  For i := 1 To intLinSer Do
  Begin
    TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Enabled := True;
    TSpeedButton(fGetComponent(fGetPanel(i), 'btnIdent', i)).Visible := True;

    TEditFocus(fGetComponent(fGetPanel(i), 'edtDesSe', i)).MaxLength := Max(intTamanhoCampo, 80);
    TEditFocus(fGetComponent(fGetPanel(i), 'edtDesSe', i)).TamCampo :=  Max(intTamanhoCampo, 80);

    TEditFocus(fGetComponent(fGetPanel(i), 'edtCodSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtDesSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtQtdSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtUniSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtValSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtTmpSe', i)).StyleElements := [seClient,seBorder];
    TComboBoxFocus(fGetComponent(fGetPanel(i), 'cmbStaSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtDecSe', i)).StyleElements := [seClient,seBorder];
    TEditFocus(fGetComponent(fGetPanel(i), 'edtLiqSe', i)).StyleElements := [seClient,seBorder];
  End;

  btnIdentTodos.Visible := blnUsaRateio;
  pnlLegenda.Visible    := blnUsaRateio;
  lblTotIse.Visible     := blnUsaRateio;
  edtTotIse.Visible     := blnUsaRateio;
  lblTotRat.Visible     := blnUsaRateio;
  edtTotRat.Visible     := blnUsaRateio;
  lblTotSer.Caption     := IIF(blnUsaRateio, 'Total Cobrança:', 'Total:');
  imgTotIse.Visible     := blnUsaRateio;
  imgTotRat.Visible     := blnUsaRateio;
  imgTotCob.Visible     := blnUsaRateio;
  btnDisSer.Visible     := fUsaDiscriminacaoServico;
end;

procedure TfrmFatDigServico.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(stlCampos) Then FreeAndNil(stlCampos);
  If Assigned(stlCamInd) Then FreeAndNil(stlCamInd);
  If Assigned(stlDesInd) Then FreeAndNil(stlDesInd);
  If Assigned(qryCadSer) Then FreeAndNil(qryCadSer);
  If Assigned(objServicos) Then FreeAndNil(objServicos);
  If Assigned(stlLockedPrismasTmp) Then FreeAndNil(stlLockedPrismasTmp);
  If Assigned(objLiberacao) Then FreeAndNil(objLiberacao);
  If Assigned(objRegistroServOri) then FreeAndNil(objRegistroServOri);
  If Assigned(objRegistroServAtu) then FreeAndNil(objRegistroServAtu);
end;

procedure TfrmFatDigServico.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    i: Integer;
begin
  inherited;
  If Key = VK_F1 Then
  Begin
    If blnSoVisualizaIdent Then
      Exit;

    If (Shift = [ssCtrl, ssAlt]) Then
    Begin
      For i := 1 To intLinSer Do
        pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), 0);
    End
    Else If (Shift = [ssAlt]) Then
    Begin
      For i := 1 To intLinSer Do
      Begin
        If (TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtQtdSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtUniSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Focused Or
            TComboBox(fGetComponent(fGetPanel(i), 'cmbStaSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtTmpSe', i)).Focused) Then
          pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), 0);
      End;
    End;
  End

  Else If Key = VK_F2 Then
  Begin
    If blnSoVisualizaIdent Then
      Exit;

    If (Shift = [ssCtrl, ssAlt]) Then
    Begin
      For i := 1 To intLinSer Do
        pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), 1);
    End
    Else If (Shift = [ssAlt]) Then
    Begin
      For i := 1 To intLinSer Do
      Begin
        If (TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtQtdSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtUniSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Focused Or
            TComboBox(fGetComponent(fGetPanel(i), 'cmbStaSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtTmpSe', i)).Focused) Then
          pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), 1);
      End;
    End;
  End

  Else If Key = VK_F3 Then
  Begin
    If blnSoVisualizaIdent Then
      Exit;

    If (Shift = [ssCtrl, ssAlt]) Then
    Begin
      For i := 1 To intLinSer Do
        pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), 2);
    End
    Else If (Shift = [ssAlt]) Then
    Begin
      For i := 1 To intLinSer Do
      Begin
        If (TEdit(fGetComponent(fGetPanel(i), 'edtCodSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtDesSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtQtdSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtUniSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtValSe', i)).Focused Or
            TComboBox(fGetComponent(fGetPanel(i), 'cmbStaSe', i)).Focused Or
            TEdit(fGetComponent(fGetPanel(i), 'edtTmpSe', i)).Focused) Then
          pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), 2);
      End;
    End
    Else
      btnAdendos.Click;
  End

  ELse If Key = VK_F5 Then
  Begin
    If btnAcompanhaServ.Visible Then
      btnAcompanhaServ.Click
  End

  Else If Key = VK_F6 Then
  Begin
    If btnAgendamentosProg.Visible Then
      btnAgendamentosProg.Click
  End

  Else If Key = VK_F7 Then
  Begin
    If btnIdentTodos.Visible Then
      btnIdentTodos.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    If btnDisSer.Visible Then
      btnDisSer.Click;
  End

  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
    Key := 0;
  End

  Else If Key = VK_F11 Then
  Begin
    If btnPagAntServ.Visible Then
      btnPagAntServ.Click();
  End

  Else If Key = VK_F12 Then
  Begin
    If btnProxPagServ.Visible Then
      btnProxPagServ.Click();
  End;
end;

procedure TfrmFatDigServico.btnMecSe1Click(Sender: TObject);
  Var
    strMecTmp: String;
    btnCodMec: TSpeedButton;
    edtCodSer: TEditFocus;
begin
  inherited;
  btnCodMec := TSpeedButton(Sender);
  edtCodSer := TEditFocus(fGetComponent('edtCodSe', fGetNumbers(btnCodMec.Name).ToInteger));

  If fEhServicoOutroVendedorSemPermissaoParaAlterar(fGetNumbers(TSpeedButton(Sender).Name).ToInteger) Then
    Exit;

  If Not fEmptyStr(edtCodSer.Text) Then
  Begin
    strMecTmp := fGetMecanico(fGetNumbers(btnCodMec.Name));
    If fInformarMecanicos(strMecTmp) Then
      pSetMecanico(fGetNumbers(btnCodMec.Name), strMecTmp);
  End;
end;

procedure TfrmFatDigServico.btnObsSe1Click(Sender: TObject);
  Var
    strObsTmp: String;
    btnObsSer: TSpeedButton;
    edtCodSer: TEditFocus;
begin
  btnObsSer := TSpeedButton(Sender);
  edtCodSer := TEditFocus(fGetComponent('edtCodSe', fGetNumbers(btnObsSer.Name).ToInteger));

  If fEhServicoOutroVendedorSemPermissaoParaAlterar(fGetNumbers(TSpeedButton(Sender).Name).ToInteger) Then
    Exit;

  If Not fEmptyStr(edtCodSer.Text) Then
  Begin
    strObsTmp := fGetObservacao(fGetNumbers(btnObsSer.Name));
    strObsTmp := TfrmFatDigServicoDigObs.fGetObservacao(strObsTmp);
    pSetObservacao(fGetNumbers(btnObsSer.Name), strObsTmp);
  End;
end;

procedure TfrmFatDigServico.btnPagAntServClick(Sender: TObject);
begin
  inherited;

  If (fGetActivePanel() = pnlServicos1) Then Begin
    pnlServicos1.Visible := False;

    If (Ceil(intLinSer / 10) = 2) Then Begin
      pnlServicos2.Visible := True;
      pnlServicos2.BringToFront;

      pSetFocus(edtCodSe11);
    End;

    If (Ceil(intLinSer / 10) = 3) Then Begin
      pnlServicos3.Visible := True;
      pnlServicos3.BringToFront;

      pSetFocus(edtCodSe21);
    End;
  End Else If (fGetActivePanel() = pnlServicos2) Then Begin
    pnlServicos2.Visible := False;
    pnlServicos3.Visible := False;

    pnlServicos1.Visible := True;
    pnlServicos1.BringToFront;

    pSetFocus(edtCodSe1);
  End Else If (fGetActivePanel() = pnlServicos3) Then Begin
    pnlServicos3.Visible := False;
    pnlServicos1.Visible := False;

    pnlServicos2.Visible := True;
    pnlServicos2.BringToFront;

    pSetFocus(edtCodSe11);
  End;

  TPanel(fGetActivePanel()).Align := alClient;
end;

procedure TfrmFatDigServico.btnProxPagServClick(Sender: TObject);
begin
  inherited;

  If (fGetActivePanel() = pnlServicos1) Then Begin
    pnlServicos1.Visible := False;
    pnlServicos3.Visible := False;

    pnlServicos2.Visible := True;
    pnlServicos2.BringToFront;

    pSetFocus(edtCodSe11);
  End Else If (fGetActivePanel() = pnlServicos2) Then Begin
    pnlServicos2.Visible := False;

    If (Ceil(intLinSer / 10) = 2) Then Begin
      pnlServicos1.Visible := True;
      pnlServicos1.BringToFront;

      pSetFocus(edtCodSe1);
    End;

    If (Ceil(intLinSer / 10) = 3) Then Begin
      pnlServicos3.Visible := True;
      pnlServicos3.BringToFront;

      pSetFocus(edtCodSe21);
    End;
  End Else If (fGetActivePanel() = pnlServicos3) Then Begin
    pnlServicos3.Visible := False;
    pnlServicos2.Visible := False;

    pnlServicos1.Visible := True;
    pnlServicos1.BringToFront;

    pSetFocus(edtCodSe1);
  End;

  TPanel(fGetActivePanel()).Align := alClient;
end;

procedure TfrmFatDigServico.btnIdentTodosClick(Sender: TObject);
  Var
    i: Integer;
begin
  inherited;
  pCriarFormularios(TfrmFatDigIdentServico, frmFatDigIdentServico);
  frmFatDigIdentServico.ShowModal;

  If (frmFatDigIdentServico.ModalResult = mrOk) Then
  Begin
    For i := 1 To intLinSer Do
      pIdentificaServico(fGetComponent(fGetPanel(i), 'btnIdent', i), frmFatDigIdentServico.intIndImg);
  End;

  pFreeAndNil(frmFatDigIdentServico);
end;

procedure TfrmFatDigServico.btnSairClick(Sender: TObject);
  Var
    intSecur: Integer;
begin
  //inherited;
  intSecur := stlLockedPrismasTmp.Count * 2;
  While stlLockedPrismasTmp.Count > 0 Do
  Begin
    fLockaPrisma(stlLockedPrismasTmp[0], False);

    Dec(intSecur);
    If intSecur = 0 Then
      Break;
  End;

  Close;
  If (blnConfServicos) Then
    ModalResult := mrOk;
end;

procedure TfrmFatDigServico.chkBrindeClick(Sender: TObject);
  Var
    strCodPar, strTipBri: String;
    chkBrinde: TCheckBox;
    edtCodSer: TEditFocus;
    edtDesSer: TEditFocus;
    edtQtdSer: TEditFocus;
    edtUniSer: TEditFocus;
    edtValSer: TEditFocus;
    edtLiqSer: TEditFocus;
    edtDecSer: TEditFocus;

  function fVendedorTemPermissaoEmitirBrinde: Boolean;
  begin
    If (fCfgSis('USADIG', varBoolean)) And (Not fEmptyStr(fatVenda.strCodDig)) Then
      Result := fVerificaAcessoSistema('frmFatVendas - BR', fatVenda.strCodDig)
    Else
      Result := fVerificaAcessoSistema('frmFatVendas - BR', fatVenda.strCodVen);

    If Not Result Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Emitir Brinde de Serviço');
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Serviço'    , edtCodSer.Text + ' - ' + edtDesSer.Text, 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade' , edtQtdSer.Text                         , 10);
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.strDirAce := 'frmFatVendas - BR';
      objLiberacao.strMsgSen := 'Emitir Brinde de Serviço';
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;
      objLiberacao.strCliente := fatVenda.strCodCli + '-' + fatVenda.strCliNom;

      Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
    End;
  end;

  function fAutorizadaPermissaoBrinde: Boolean;
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir informar produtos Brinde nos Pedidos de Venda');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTexto('VENDA DE SERVIÇO COMO BRINDE');
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , fatVenda.strCodCli + '-' + fatVenda.strCliNom                   , 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor', fatVenda.strCodVen + '-' + fRetNomeOperador(fatVenda.strCodVen) , 10);
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTextoCaption('Serviço' , edtCodSer.Text + ' - ' + edtDesSer.Text                         , 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor'   , edtValSer.Text                                                  , 10);
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.strDirAce  := 'PERSERVBRINDE';
    objLiberacao.strMsgSen  := 'Permitir informar produtos Brinde nos Pedidos de Venda';
    objLiberacao.strCodOpe  := fatVenda.strCodVen;
    objLiberacao.strCodDig  := fatVenda.strCodDig;

    Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
  end;

begin
  inherited;
  If (Sender Is TCheckBox) Then
    chkBrinde := TCheckBox(Sender)
  Else
    chkBrinde := TCheckBox(fGetComponent('chkBriSe', fGetNumbers(TSpeedButton(Sender).Name).ToInteger));

  If fEhServicoOutroVendedorSemPermissaoParaAlterar(fGetNumbers(chkBrinde.Name).ToInteger) And blnPedirBrinde Then
    Exit;

  edtCodSer := TEditFocus(fGetComponent('edtCodSe', fGetNumbers(chkBrinde.Name).ToInteger));
  edtDesSer := TEditFocus(fGetComponent('edtDesSe', fGetNumbers(chkBrinde.Name).ToInteger));
  edtQtdSer := TEditFocus(fGetComponent('edtQtdSe', fGetNumbers(chkBrinde.Name).ToInteger));
  edtUniSer := TEditFocus(fGetComponent('edtUniSe', fGetNumbers(chkBrinde.Name).ToInteger));
  edtValSer := TEditFocus(fGetComponent('edtValSe', fGetNumbers(chkBrinde.Name).ToInteger));
  edtLiqSer := TEditFocus(fGetComponent('edtLiqSe', fGetNumbers(chkBrinde.Name).ToInteger));
  edtDecSer := TEditFocus(fGetComponent('edtDecSe', fGetNumbers(chkBrinde.Name).ToInteger));

  If (blnPedirBrinde) And
     (Not fEmptyStr(edtCodSer.Text)) And
     (chkBrinde.Checked) And
     (Not fatVenda.fEhServicoQuePermiteBrinde(edtCodSer.Text)) Then
  Begin
    If Not fAutorizadaPermissaoBrinde Then
    Begin
      chkBrinde.Checked := False;
      Exit;
    End;
  End;

  If chkBrinde.Checked Then
  Begin
    chkBrinde.Caption    := 'SIM';
    chkBrinde.Font.Style := [fsBold];
    chkBrinde.Color      := clYellow;
  End
  Else
  Begin
    chkBrinde.Caption    := 'NÃO';
    chkBrinde.Font.Style := [];
    chkBrinde.Color      := Self.Color;
  End;

  If fEmptyStr(edtCodSer.Text) Then
  Begin
    chkBrinde.Checked := False;
    strCodPar := '';
    strTipBri := '';
    Exit;
  End;

  If chkBrinde.Checked And chkBrinde.Focused And Not fVendedorTemPermissaoEmitirBrinde Then
  Begin
    chkBrinde.Checked := False;
    strCodPar := '';
    strTipBri := '';
    Exit;
  End;

  fGetBrinde(fNum(chkBrinde.Name).ToString, strCodPar, strTipBri);

  If blnPedirBrinde And Not fPedeDadosBrinde(chkBrinde.Checked, strCodPar, strTipBri) Then
  Begin
    chkBrinde.Checked := False;
    strCodPar := '';
    strTipBri := '';
  End;

  pSetBrinde(fNum(chkBrinde.Name).ToString, IIF(chkBrinde.Checked, 'S','N'), strCodPar, strTipBri);

  If chkBrinde.Visible Then
  Begin
    If chkBrinde.Checked Then
    Begin
      edtUniSer.Text := '0,00';
      edtValSer.Text := '0,00';
      edtLiqSer.Text := '0,00';
      edtDecSer.Text := '0,00';

      edtUniSer.ReadOnly := True;
      edtValSer.ReadOnly := True;
      edtLiqSer.ReadOnly := True;
      edtDecSer.ReadOnly := True;
    End
    Else
    Begin
      If edtUniSer.Visible Then
      Begin
        If fStrToFloat(edtUniSer.Text) = 0 Then
        Begin
          edtUniSer.Text := FormatFloat('#,##0.00', fRetornaValorServico(edtCodSer.Text));
          edtValSer.Text := FormatFloat('#,##0.00', fStrToFloat(edtQtdSer.Text) * fStrToFloat(edtUniSer.Text));
          edtDecSer.Text := FormatFloat('#,##0.00', 0);
          edtLiqSer.Text := FormatFloat('#,##0.00', fStrToFloat(edtValSer.Text) * (1 - (fStrToFloat(edtDecSer.Text) / 100)));
        End;
      End
      Else If (fStrToFloat(edtValSer.Text) = 0) Then
      Begin
        edtUniSer.Text := FormatFloat('#,##0.00', fRetornaValorServico(edtCodSer.Text));
        edtValSer.Text := FormatFloat('#,##0.00', fRetornaValorServico(edtCodSer.Text));
        edtDecSer.Text := FormatFloat('#,##0.00', 0);
        edtLiqSer.Text := FormatFloat('#,##0.00', fRetornaValorServico(edtCodSer.Text));
      End;

      edtUniSer.ReadOnly := (Not fCfgSis('ALVLSE', VarBoolean)) and (not fatVenda.blnPedFabOSG);
      edtValSer.ReadOnly := ((Not fCfgSis('ALVLSE', VarBoolean)) Or edtUniSer.Visible) and (not fatVenda.blnPedFabOSG);
      pPermicaoAlteraValor(edtUniSer, edtValSer);
      edtDecSer.ReadOnly := blnUsaDesc;
    End;
  End;

  blnMudarFoco := False;
  SelectNext(chkBrinde, True, True);
end;

procedure TfrmFatDigServico.pDefineNumLinhasServico;
  Var
    intCont: Integer;

  function fGetEdit(strNome: String; intNumSer: Integer): TEditFocus;
  begin
    Result := TEditFocus(fGetComponent(fGetPanel(intCont), strNome, intNumSer));
  end;

  function fGetCmbF(strNome: String; intNumSer: Integer): TComboBoxFocus;
  begin
    Result := TComboBoxFocus(fGetComponent(fGetPanel(intCont), strNome, intNumSer));
  end;

  function fGetCheckBox(strNome: String; intNumSer: Integer): TCheckBox;
  begin
    Result := TCheckBox(fGetComponent(fGetPanel(intCont), strNome, intNumSer));
  end;

begin

  // Se não utiliza NFE pode informar no máximo 6 linhas de serviço
  If Not fCfgSis('NFEUSA', varBoolean) Then
  Begin
    If (intLinSer > 6) Or (intLinSer <= 0) Then
      intLinSer := 6;
  End;

  If (intLinSer <= 0) Then
    Exit;

  If (intLinSer <= 10) Then
    fGetActivePanel().Height := fGetActivePanel().Height - (22 * (10 - intLinSer));

  For intCont := intLinSer + 1 To 30 Do
  Begin
    TLabel(fGetComponent(fGetPanel(intCont), 'lblNumSe',  intCont)).Visible := False;

    TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnMecSe', intCont)).Visible := False;
    TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnObsSe', intCont)).Visible := False;
    TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnIdent', intCont)).Visible := False;
    TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnParSe', intCont)).Visible := False;

    TCheckBox(fGetComponent(fGetPanel(intCont), 'chkBriSe', intCont)).Visible   := False;
    TCheckBox(fGetComponent(fGetPanel(intCont), 'chkBriSe', intCont)).Checked   := False;

    fGetEdit('edtCodSe', intCont).Visible := False;
    fGetEdit('edtDesSe', intCont).Visible := False;
    fGetEdit('edtValSe', intCont).Visible := False;
    fGetEdit('edtUniSe', intCont).Visible := False;
    fGetEdit('edtQtdSe', intCont).Visible := False;
    fGetEdit('edtTmpSe', intCont).Visible := False;
    fGetEdit('edtPriSe', intCont).Visible := False;
    fGetCmbF('cmbStaSe', intCont).Visible := False;
    fGetEdit('edtDecSe', intCont).Visible := False;
    fGetEdit('edtLiqSe', intCont).Visible := False;

    fGetEdit('edtCodSe', intCont).Clear;
    fGetEdit('edtDesSe', intCont).Clear;
    fGetEdit('edtValSe', intCont).Clear;
    fGetEdit('edtUniSe', intCont).Clear;
    fGetEdit('edtQtdSe', intCont).Clear;
    fGetEdit('edtTmpSe', intCont).Clear;
    fGetEdit('edtPriSe', intCont).Clear;
    fGetCmbF('cmbStaSe', intCont).Clear;
    fGetEdit('edtDecSe', intCont).Clear;
    fGetEdit('edtLiqSe', intCont).Clear;
  End;

  If (intLinSer <= 10) Then
    Self.Height := Self.Height - (23 * (10 - intLinSer));

  lblQtdSer1.Visible := fCfgSis('QTDSER', VarBoolean);
  lblUniSer1.Visible := fCfgSis('QTDSER', VarBoolean);
  lblDecSer1.Visible := blnUsaDesc;
  lblLiqSer1.Visible := blnUsaDesc;

  lblQtdSer2.Visible := fCfgSis('QTDSER', VarBoolean);
  lblUniSer2.Visible := fCfgSis('QTDSER', VarBoolean);
  lblDecSer2.Visible := blnUsaDesc;
  lblLiqSer2.Visible := blnUsaDesc;

  lblQtdSer3.Visible := fCfgSis('QTDSER', VarBoolean);
  lblUniSer3.Visible := fCfgSis('QTDSER', VarBoolean);
  lblDecSer3.Visible := blnUsaDesc;
  lblLiqSer3.Visible := blnUsaDesc;

  For intCont := 1 To intLinSer Do
  Begin
    If (intLinSer > 10) Then Begin
      If (Ceil(intCont / 10) = 2) Then Begin
        pnlServicos1.Visible := False;
        pnlServicos3.Visible := False;
        pnlServicos2.Visible := True;
        pnlServicos2.BringToFront;
      End Else If (Ceil(intCont / 10) = 3) Then Begin
        pnlServicos1.Visible := False;
        pnlServicos2.Visible := False;
        pnlServicos3.Visible := True;
        pnlServicos3.BringToFront;
      End;
    End;

    If Not fCfgSis('QTDSER', VarBoolean) Then
    Begin
      fGetEdit('edtQtdSe', intCont).Visible := False;
      fGetEdit('edtUniSe', intCont).Visible := False;

      If Not fCfgSis('ALVLSE', VarBoolean) Then
      Begin
        fGetEdit('edtDecSe', intCont).Visible := True;
        fGetEdit('edtLiqSe', intCont).Visible := True;

        fGetEdit('edtDecSe', intCont).Left    := fGetEdit('edtUniSe', intCont).Left;
        fGetEdit('edtLiqSe', intCont).Left    := fGetEdit('edtValSe', intCont).Left;
        fGetEdit('edtValSe', intCont).Left    := fGetEdit('edtQtdSe', intCont).Left;

        fGetEdit('edtDecSe', intCont).TabOrder := fGetEdit('edtUniSe', intCont).TabOrder;
        fGetEdit('edtLiqSe', intCont).TabOrder := fGetEdit('edtValSe', intCont).TabOrder;
        fGetEdit('edtValSe', intCont).TabOrder := fGetEdit('edtQtdSe', intCont).TabOrder;

        TLabel(fGetComponent(fGetPanel(intCont), 'lblDecSer', Ceil(intCont / 10))).Width := fGetEdit('edtDecSe', intCont).Width;
        TLabel(fGetComponent(fGetPanel(intCont), 'lblLiqSer', Ceil(intCont / 10))).Width := fGetEdit('edtLiqSe', intCont).Width;
        TLabel(fGetComponent(fGetPanel(intCont), 'lblValSer', Ceil(intCont / 10))).Width := fGetEdit('edtValSe', intCont).Width;

        TLabel(fGetComponent(fGetPanel(intCont), 'lblDecSer', Ceil(intCont / 10))).Left := fGetEdit('edtDecSe', intCont).Left;
        TLabel(fGetComponent(fGetPanel(intCont), 'lblLiqSer', Ceil(intCont / 10))).Left := fGetEdit('edtLiqSe', intCont).Left;
        TLabel(fGetComponent(fGetPanel(intCont), 'lblValSer', Ceil(intCont / 10))).Left := fGetEdit('edtValSe', intCont).Left;
        TLabel(fGetComponent(fGetPanel(intCont), 'lblBrinde', Ceil(intCont / 10))).Left := fGetCheckBox('chkBriSe', intCont).Left + 5;
      End Else Begin
        fGetEdit('edtValSe', intCont).Left    := fGetEdit('edtValSe', intCont).Left - 4;
        lblValSer1.Left  := fGetEdit('edtValSe', intCont).Left;

        fGetEdit('edtDesSe', intCont).Width   := fGetEdit('edtDesSe', intCont).Width +
                                                 fGetEdit('edtQtdSe', intCont).Width +
                                                 fGetEdit('edtUniSe', intCont).Width;
      End;

      TCheckBox(fGetComponent(fGetPanel(intCont), 'chkBriSe', intCont)).Left :=
        TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnIdent', intCont)).Left;

      TLabel(fGetComponent(fGetPanel(intCont), 'lblBrinde', Ceil(intCont / 10))).Left := fGetCheckBox('chkBriSe', intCont).Left + 5;
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnParSe', intCont)).Left := fGetCheckBox('chkBriSe', intCont).Left +
                                                             fGetCheckBox('chkBriSe', intCont).Width;
      pPermicaoAlteraValor(fGetEdit('edtUniSe', intCont), fGetEdit('edtValSe', intCont));
    End
    Else
    Begin
      fGetEdit('edtValSe', intCont).ReadOnly    := True;
      fGetEdit('edtValSe', intCont).TabStop     := False;
      fGetEdit('edtValSe', intCont).Color       := $00FFDFB8;
      fGetEdit('edtValSe', intCont).NormalColor := $00FFDFB8;

      If Not fatVenda.fEhAutocenter Then Begin
        TCheckBox(fGetComponent(fGetPanel(intCont), 'chkBriSe', intCont)).Left :=
          TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnIdent', intCont)).Left + 3;

        TLabel(fGetComponent(fGetPanel(intCont), 'lblBrinde', Ceil(intCont / 10))).Left := fGetCheckBox('chkBriSe', intCont).Left + 7;

        TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnParSe', intCont)).Left := fGetCheckBox('chkBriSe', intCont).Left +
                                                               fGetCheckBox('chkBriSe', intCont).Width;
      End;
    End;

    If (Not fCfgSis('ALVLSE', VarBoolean)) and (not fatVenda.blnPedFabOSG) Then
    Begin
      fGetEdit('edtUniSe', intCont).ReadOnly := True;
      fGetEdit('edtValSe', intCont).ReadOnly := True;
    End;

    If Not blnUsaRateio Then
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnIdent', intCont)).Visible := False;

    If Not fatVenda.fEhAutocenter Then
    Begin
      fGetEdit('edtTmpSe', intCont).Visible := False;
      fGetCmbF('cmbStaSe', intCont).Visible := False;

      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnMecSe', intCont)).Visible := False;
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnObsSe', intCont)).Visible := False;

      fGetEdit('edtDesSe', intCont).Width := fGetEdit('edtDesSe', intCont).Width +
                           TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnMecSe', intCont)).Width +
                           TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnObsSe', intCont)).Width;
    End
    Else
    Begin
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnMecSe', intCont)).Left := fGetEdit('edtDesSe', intCont).Left +
                                                               fGetEdit('edtDesSe', intCont).Width;
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnObsSe', intCont)).Left := TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnMecSe', intCont)).Left +
                                                               TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnMecSe', intCont)).Width;
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnIdent', intCont)).Left := fGetEdit('edtValSe', intCont).Left +
                                                               fGetEdit('edtValSe', intCont).Width;
      TSpeedButton(fGetComponent(fGetPanel(intCont), 'btnParSe', intCont)).Left := fGetEdit('chkBriSe', intCont).Left +
                                                               fGetEdit('chkBriSe', intCont).Width;
    End;

  End;

  If (intLinSer > 10) Then Begin
    pnlServicos2.Visible := False;
    pnlServicos3.Visible := False;
    pnlServicos1.Visible := True;
    pnlServicos1.BringToFront;
  End;
end;

procedure TfrmFatDigServico.pDesabilitaServicosOutroVendedor;
  Var
    intServic: Integer;

  procedure pDesabilitar(obj: TObject);
  begin
    If obj Is TEditFocus Then
    Begin
      TEditFocus(obj).Color       := shpOutVen.Brush.Color;
      TEditFocus(obj).FocusColor  := shpOutVen.Brush.Color;
      TEditFocus(obj).NormalColor := shpOutVen.Brush.Color;
      TEditFocus(obj).ReadOnly    := True;
    End

    Else If obj Is TCheckBox Then
      TCheckBox(obj).Enabled := False

    Else If obj Is TComboBox Then
      TComboBox(obj).Enabled := False;
  end;

begin

  pnlOutVen.Visible := fCfgSis('VNDSPD', varBoolean) And (Pos(fatVenda.strOpcDoc, 'OR_PD_VN') > 0);

  If Not pnlOutVen.Visible Then
    Exit;

  For intServic := 1 To 30 Do
  Begin
    If Not fEmptyStr(TEditFocus(fGetComponent('edtCodSe', intServic)).Text) Then
    Begin
      If fEhServicoOutroVendedorSemPermissaoParaAlterar(intServic) Then
      Begin
        pDesabilitar(fGetComponent('edtCodSe', intServic));
        pDesabilitar(fGetComponent('edtDesSe', intServic));
        pDesabilitar(fGetComponent('edtDecSe', intServic));
        pDesabilitar(fGetComponent('edtLiqSe', intServic));
        pDesabilitar(fGetComponent('edtQtdSe', intServic));
        pDesabilitar(fGetComponent('edtUniSe', intServic));
        pDesabilitar(fGetComponent('edtValSe', intServic));
        pDesabilitar(fGetComponent('chkBriSe', intServic));
        pDesabilitar(fGetComponent('cmbStaSe', intServic));
      End;
    End;
  End;
end;

procedure TfrmFatDigServico.edtDesSe1Change(Sender: TObject);
begin
  inherited;
  edtDesSe1.Text := fTiraCaracEspeciais(edtDesSe1.Text);
end;

procedure TfrmFatDigServico.edtDesSe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strTmp: String;
begin
  inherited;
  strTmp := String(Key);

  strTmp := fTiraCaracNota(strTmp);
  If (strTmp = '') Then
    Key := #0
  Else
    Key := strTmp[1];

  If (Key = 'Ç') Or (Key = 'ç') Then
    Key := 'C';
end;

function TfrmFatDigServico.fMecanicoEhObrigatorio: Boolean;
begin
  Result := False;

  If Not fatVenda.fEhAutocenter Then
    Exit;

  If Not fCfgSis('MECSER', varBoolean) Then
    Exit;

  If (Not fCfgSis('OBRMEC', varBoolean)) Then
    Exit;

  Result := True;
end;

function TfrmFatDigServico.fValidaMecanicos: Boolean;
  Var
    stlServicos: TStringList;

  function fMensagemOBRMEC: String;
    Var
      strIdeServ: String;
      intCont: Integer;
  begin
    Result := '';

    For intCont := 0 To stlServicos.Count - 1 Do
    Begin
      strIdeServ := fGetNumbers(stlServicos[intCont]);

      If (fEmptyStr(Result)) Then
        Result := strIdeServ
      Else If (intCont = stlServicos.Count - 1) Then
        Result := Result + ' e ' + strIdeServ
      Else
        Result := Result + ', ' + strIdeServ;
    End;

    Result := 'Conforme configuração "CFG_OBRMEC", é obrigatório o '+
      'preenchimento do(s) mecânico(s) para os serviços.' + #13 +
      'Mecânico(s) não informado(s) para o(s) serviço(s): '+ Result +
      '.' + #13 + 'Favor informa-lo(s).'
  end;

begin
  Result := False;

  Try
    stlServicos := fServicosSemMecanicosInformados;

    If (stlServicos.Count > 0) Then
    Begin
      fMensagem('ATENÇÃO!',fMensagemOBRMEC,['&OK']);
      pSetFocus(TEditFocus(FindComponent(stlServicos[0])));
      Exit;
    End;

    Result := True;
  Finally
    FreeAndNil(stlServicos);
  End;
end;

function TfrmFatDigServico.fServicosSemMecanicosInformados: TStringList;
  Var
    intIdeSer: Integer;
    intQuantServ: Integer;
    edtServico: TEditFocus;
    strMecanico: String;
begin
  Result := TStringList.Create;
  intQuantServ := fCfgSis('LINSER', varInteger);

  For intIdeSer := 1 To intQuantServ Do
  Begin
    edtServico := TEditFocus(fGetComponent('edtCodSe', intIdeSer));

    If (edtServico = Nil) Or (fEmptyStr(edtServico.Text)) Then
      Continue;

    strMecanico := fGetMecanico(fGetNumbers(edtServico.Name));

    If (fEmptyStr(strMecanico)) Then
      Result.Add(edtServico.Name);
  End;
end;

function TfrmFatDigServico.fExibeMunicipioServico: Boolean;
begin
  Result := False;

  If not fCfgSis('NFSENO', varBoolean) Then
    Exit;

  If not fCfgSis('ENOMPS', varBoolean) Then
    Exit;

  If (fCfgSis('NTOPNS', varString) = '0') Then
    Exit;

  Result := True;
end;

function TfrmFatDigServico.fExibeNaturezaServico: Boolean;
begin
  Result := False;

  If not fCfgSis('NFSENO', varBoolean) Then
    Exit;

  If not (fCfgSis('CIDNFS', varString) = 'PREFEITURA DE CAMPINAS-SP') Then
    Exit;

  Result := True;
end;

function TfrmFatDigServico.fExibeEnderecoDeEntrega: Boolean;
begin
  Result := False;

  If not pnlMunicipioServico.Visible Then
    Exit;

  If not (Pos(fatVenda.strOpcDoc, 'OR_PD_VN_VS_CP_') > 0) Then
    Exit;

  If not (rdgMunicipioServico.ItemIndex = 2) Then
    Exit;

  Result := True;
end;

procedure TfrmFatDigServico.chkNaturezaPropertiesChange(Sender: TObject);
begin
  inherited;
  SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatDigServico.chkNaturezaPropertiesEditValueToStates(
  Sender: TObject; const AValue: Variant; var ACheckStates: TcxCheckStates);
begin
  inherited;
  ACheckStates[0] := cbsUnChecked;
  ACheckStates[1] := cbsUnChecked;
  ACheckStates[2] := cbsUnChecked;
  ACheckStates[3] := cbsUnChecked;
  ACheckStates[4] := cbsUnChecked;
  ACheckStates[5] := cbsUnChecked;

  If VarToStr(AValue).Contains('A') Then
    ACheckStates[0] := cbsChecked;

  If VarToStr(AValue).Contains('B')Then
    ACheckStates[1] := cbsChecked;

  If VarToStr(AValue).Contains('C')Then
    ACheckStates[2] := cbsChecked;

  If VarToStr(AValue).Contains('D') Then
    ACheckStates[3] := cbsChecked;

  If VarToStr(AValue).Contains('I')Then
    ACheckStates[4] := cbsChecked;

  If VarToStr(AValue).Contains('J')Then
    ACheckStates[5] := cbsChecked;

  FNFSeNatureza := AValue;
end;

procedure TfrmFatDigServico.chkNaturezaPropertiesStatesToEditValue(
  Sender: TObject; const ACheckStates: TcxCheckStates; out AValue: Variant);
begin
  inherited;
  AValue := '';
  if ACheckStates[0] = cbsChecked then
  Begin
    AValue := 'A';
    If (FNFSeNatureza <> AValue) Then
      Exit;
  End;
  if ACheckStates[1] = cbsChecked then
  Begin
    AValue := 'B';
    If (FNFSeNatureza <> AValue) Then
      Exit;
  End;
  if ACheckStates[2] = cbsChecked then
  Begin
    AValue := 'C';
    If (FNFSeNatureza <> AValue) Then
      Exit;
  End;
  if ACheckStates[3] = cbsChecked then
  Begin
    AValue := 'D';
    If (FNFSeNatureza <> AValue) Then
      Exit;
  End;
  if ACheckStates[4] = cbsChecked then
  Begin
    AValue := 'I';
    If (FNFSeNatureza <> AValue) Then
      Exit;
  End;
  if ACheckStates[5] = cbsChecked then
  Begin
    AValue := 'J';
    If (FNFSeNatureza <> AValue) Then
      Exit;
  End;
end;

function TfrmFatDigServico.fValidaPisCofinsCsll: Boolean;
var
  strSQL,
  strRet,
  strNRet,
  strCodSer,
  strCodSer1,
  strDesSer1: String;
  intCont   : Integer;
  blnRetem,
  blnNRetem,
  blnRet01  : Boolean;
  fltValSer : Double;
  qryAux    : TUniQuery;
begin
  Result := True;

  if (not fCfgSis('PCCSER', varBoolean)) then
    Exit;

  blnRetem  := False;
  blnNRetem := False;
  blnRet01  := False;

  qryAux := fCriaQuery;
  strSQL := '';
  strSQL := strSQL + 'SELECT SER_CODSER, SER_DESSER, SER_RETPCC, SER_VALPCC ';
  strSQL := strSQL + 'FROM CADSER ';
  strSQL := strSQL + 'WHERE SER_CODSER = :CODSER AND (SER_ATIVO_ = "S") ';

  if fCfgSis('SEREMP', varBoolean) then
    strSQL := strSQL + ' AND ((SER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') OR (SER_CODEMP IS NULL)) ';

  qryAux.SQL.Text := strSQL;

  try
    for intCont := 1 to 30 do
    begin
      strCodSer := TEditFocus(fGetComponent('edtCodSe', intCont)).Text;

      if (fEmptyStr(strCodSer)) then
        Continue;

      fltValSer := fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtValSe', intCont)).Text), 2);

      qryAux.Close;
      qryAux.ParamByName('CODSER').AsString := strCodSer;
      qryAux.Open;

      if (not qryAux.IsEmpty) then
      begin
        if fEmptyStr(strCodSer1) then
        begin
          strCodSer1 := qryAux.FieldByName('SER_CODSER').AsString;
          strDesSer1 := qryAux.FieldByName('SER_DESSER').AsString;
          blnRet01   := (qryAux.FieldByName('SER_RETPCC').AsString = 'S') and
            (fFormataFloat(qryAux.FieldByName('SER_VALPCC').AsFloat, 2) <= fltValSer);
        end;

        if (qryAux.FieldByName('SER_RETPCC').AsString = 'S') and
          (fFormataFloat(qryAux.FieldByName('SER_VALPCC').AsFloat, 2) <= fltValSer) then
          blnRetem := True
        else
          blnNRetem := True;

        if (blnRetem) and (blnNRetem) then
        begin
          Result := False;

          if (blnRet01) then
          begin
            strRet  := '    Retém PIS/COFINS/CSLL: ' + strCodSer1 + ' - ' + strDesSer1;
            strNRet := 'Não Retém PIS/COFINS/CSLL: ' + qryAux.FieldByName('SER_CODSER').AsString + ' - ' + qryAux.FieldByName('SER_DESSER').AsString;
          end
          else
          begin
            strRet  := '    Retém PIS/COFINS/CSLL: ' + qryAux.FieldByName('SER_CODSER').AsString + ' - ' + qryAux.FieldByName('SER_DESSER').AsString;
            strNRet := 'Não Retém PIS/COFINS/CSLL: ' + strCodSer1 + ' - ' + strDesSer1;
          end;

          fMensagem('ATENÇÃO!', 'Não é permitido informar para a mesma emissão de nota ' +
                    ' de serviço um serviço que retém PIS/COFINS/CSLL com um que não retém.' + #13 + #13 + strRet + #13 + strNRet, ['&Ok']);

          Exit;
        end;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;
{****************************************************************}
{* Validação feita por causa da Prefeitura de João Monlevade-MG *}
{* O arredondamento feito pela prefeitura não usa formatação    *}
{*************************************************************BZ*}
function TfrmFatDigServico.fValidaDeducoes: Boolean;
var
  intCont: Integer;
  strCodSer: String;
  fltRedIss: Double;
  fltValSer: Double;
  fltTotSer: Double;
  fltVlrDed: Double;
  fltPerDed: Double;
begin
  Result := True;

  if (not fCfgSis('TRDISS', varBoolean)) then
    Exit;

  fltRedIss := fCfgSis('REDISS', varCurrency);

  If (fltRedIss <= 0) Then
    Exit;

  fltTotSer := 0;

  for intCont := 1 to 30 do
  begin
    strCodSer := TEditFocus(fGetComponent('edtCodSe', intCont)).Text;

    If (fEmptyStr(strCodSer)) Then
      Continue;

    fltValSer := fFormataFloat(fStrToFloat(TEditFocus(fGetComponent('edtValSe', intCont)).Text), 2);

    If (fltValSer <= 0) Then
      Continue;

    fltTotSer := fltTotSer + fltValSer;
    fltVlrDed := fFormataFloat((fltRedIss * fltTotSer) / 100, 2);
    fltPerDed := (fltVlrDed / fltTotSer) * 100;

    If (fltPerDed > fltRedIss) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O valor total da dedução ultrapassou o que foi definido na CFG_REDISS.'+#13+
                            'Ajustar o valor do serviço!', ['&Ok']);
      Break;
    End;
  end;

end;

end.

