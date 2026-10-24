unit untEntDigMultiLojasNovo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCurrencyEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, Uni, UniClientDataSet, untFuncoesSimples,
  untFuncoesPedidoSimples, untPreparaGeracaoTE,
  untLiberaPrepTE,
  cxDataControllerConditionalFormattingRulesManagerDialog, EditFocus, untCfgGrid,
  cxTextEdit, cxDropDownEdit;

type
  TfrmEntDigMultiLojasNovo = class(TfrmPaiEdit)
    btnGiroAna: TBitBtnLocked;
    cxgGiro: TcxGrid;
    cxgItensCODEMP: TcxGridDBBandedColumn;
    cxgItensQ_V_01: TcxGridDBBandedColumn;
    cxgItensQ_V_02: TcxGridDBBandedColumn;
    cxgItensQ_V_03: TcxGridDBBandedColumn;
    cxgItensQ_V_04: TcxGridDBBandedColumn;
    cxgItensQ_V_05: TcxGridDBBandedColumn;
    cxgItensQ_V_06: TcxGridDBBandedColumn;
    cxgItensQ_V_07: TcxGridDBBandedColumn;
    cxgItensQ_V_08: TcxGridDBBandedColumn;
    cxgItensQ_V_09: TcxGridDBBandedColumn;
    cxgItensQ_V_10: TcxGridDBBandedColumn;
    cxgItensQ_V_11: TcxGridDBBandedColumn;
    cxgItensQ_V_12: TcxGridDBBandedColumn;
    cxgItensVENMES: TcxGridDBBandedColumn;
    cxgItensMEDIA_: TcxGridDBBandedColumn;
    cxgItensSUGEST: TcxGridDBBandedColumn;
    cxgItensMLTCOM: TcxGridDBBandedColumn;
    cxgItensSALFIS: TcxGridDBBandedColumn;
    cxgItensQTDPEN: TcxGridDBBandedColumn;
    cxgItensSALGAR: TcxGridDBBandedColumn;
    cxgItensSALRES: TcxGridDBBandedColumn;
    cxgItensDIAEST: TcxGridDBBandedColumn;
    cxgItensLOCFIS: TcxGridDBBandedColumn;
    cxgItensESTMIN: TcxGridDBBandedColumn;
    cxgItensDTAULT: TcxGridDBBandedColumn;
    cxgItensNOMFOR: TcxGridDBBandedColumn;
    cxgItensQTDUCO: TcxGridDBBandedColumn;
    cxgItensPREULT: TcxGridDBBandedColumn;
    cxgItensDTAUVE: TcxGridDBBandedColumn;
    cxgItensDIAUCO: TcxGridDBBandedColumn;
    cxgItensDIAUVE: TcxGridDBBandedColumn;
    cxgItensNIVGIR: TcxGridDBBandedColumn;
    cxgGiroLevel1: TcxGridLevel;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensNOMEMP: TcxGridDBBandedColumn;
    cxgItensCPRCEN: TcxGridDBBandedColumn;
    cxgItensMEDIXX: TcxGridDBBandedColumn;
    cxgItensQTDITE: TcxGridDBBandedColumn;
    cxgItensESTMAX: TcxGridDBBandedColumn;
    cxgItensFUTPRE: TcxGridDBBandedColumn;
    cxgItensDIASUG: TcxGridDBBandedColumn;
    pnlLegendas: TPanel;
    dtsPcdDet: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnPedVen: TBitBtnLocked;
    btnPrepTE: TBitBtnLocked;
    cxgItensCODITE: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgItensMAQTSA: TcxGridDBBandedColumn;
    cxgItensMADTSA: TcxGridDBBandedColumn;
    cxgItensPESOIT: TcxGridDBBandedColumn;
    cxgItensSALDIS: TcxGridDBBandedColumn;
    cxsNegrito: TcxStyle;
    cxgItensMEDAJU: TcxGridDBBandedColumn;
    cxgItensFORULT: TcxGridDBBandedColumn;
    cxgItensNIVCRI: TcxGridDBBandedColumn;
    cxgItensPONPED: TcxGridDBBandedColumn;
    cxgItensQTDREQ: TcxGridDBBandedColumn;
    cxgItensQTDTRA: TcxGridDBBandedColumn;
    cxgItensQTDEXC: TcxGridDBBandedColumn;
    cxgItensAJUSTA: TcxGridDBBandedColumn;
    cxgItensSALTRA: TcxGridDBBandedColumn;
    cxgItensMINDIG: TcxGridDBBandedColumn;
    cxgItensMAXDIG: TcxGridDBBandedColumn;
    cxgItensVARCOM: TcxGridDBBandedColumn;
    cxgItensSALEND: TcxGridDBBandedColumn;
    cxgItensFUTFAL: TcxGridDBBandedColumn;
    cxgItensFUTAGU: TcxGridDBBandedColumn;
    cxgItensSALBAS: TcxGridDBBandedColumn;
    cxgItensORDPRO: TcxGridDBBandedColumn;
    cxgItensPMED_V: TcxGridDBBandedColumn;
    cxgItensDIASAI: TcxGridDBBandedColumn;
    btnPreTEGrid: TBitBtnLocked;
    cxgItensQTDEMB: TcxGridDBBandedColumn;
    cxgItensQTDVEN: TcxGridDBBandedColumn;
    cxgItensSIGUNI: TcxGridDBBandedColumn;
    cxgItensReaTra: TcxGridDBBandedColumn;
    cxgItensFANEMP: TcxGridDBBandedColumn;
    cxgItensSALEXT: TcxGridDBBandedColumn;
    cxgItensVENPER: TcxGridDBBandedColumn;
    cxgItensIMPULT: TcxGridDBBandedColumn;
    cxgItensREFERE: TcxGridDBBandedColumn;
    cxgItensESMIDG: TcxGridDBBandedColumn;
    cxgItensSALEXC: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP01: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP02: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP03: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP04: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP05: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP06: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP07: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP08: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP09: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP10: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP11: TcxGridDBBandedColumn;
    cxgItensITE_Q_VP12: TcxGridDBBandedColumn;
    cxgItensITE_Q_VPME: TcxGridDBBandedColumn;
    cxgItensTIPABS: TcxGridDBBandedColumn;
    cxgItensVNOLCD: TcxGridDBBandedColumn;
    Panel1: TPanel;
    FlowPanel1: TFlowPanel;
    Label5: TLabel;
    pnlLeg1: TPanel;
    Panel2: TPanel;
    shpMesMed: TShape;
    lblMesMed: TLabel;
    Panel3: TPanel;
    Shape2: TShape;
    Label2: TLabel;
    pnlAltera: TPanel;
    shpAltera: TShape;
    lblAltera: TLabel;
    pnlEmpVis: TPanel;
    shpEmpVis: TShape;
    lblEmpVis: TLabel;
    Panel6: TPanel;
    Shape1: TShape;
    Label3: TLabel;
    Panel7: TPanel;
    lblListaMesesGiro: TLabel;
    lblLegMesPromo: TLabel;
    lblExiApli: TLabel;
    lblResPad: TLabel;
    lblSalbas: TLabel;
    lblConfiguraColunas: TLabel;
    lblTestTamanho: TLabel;
    cxgItensITE_PONEXP: TcxGridDBBandedColumn;
    cxgItensITE_QTEP_S: TcxGridDBBandedColumn;
    cxgItensESTEXC: TcxGridDBBandedColumn;
    cxgItensDIFSUG: TcxGridDBBandedColumn;
    btnPedidosPend: TBitBtnLocked;

    procedure cxgGiroDIAESTSummaryGetText(
      Sender: TcxDataSummaryItem; const [Ref] AValue: Variant;
      AIsFooter: Boolean; var AText: string);
    procedure cxgGiroDIASUGSummaryGetText(
      Sender: TcxDataSummaryItem; const [Ref] AValue: Variant;
      AIsFooter: Boolean; var AText: string);
    procedure cxgItensQ_V_01CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_02CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_03CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_04CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_05CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_06CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_07CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_08CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_09CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_10CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_11CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_12CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensVENMESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQTDITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cxgItensESTMINCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPedVenClick(Sender: TObject);
    procedure btnPrepTEClick(Sender: TObject);
    procedure btnGiroAnaClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cxgItensCPRCENGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure lblResPadClick(Sender: TObject);
    procedure cxgItensNOMFORGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensCODITEGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnSairClick(Sender: TObject);
    procedure cxgItensViewDblClick(Sender: TObject);
    procedure cxgItensViewDataControllerSummaryFooterSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure cxgItensCODEMPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensNOMEMPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroExit(Sender: TObject);
    procedure lblSalbasClick(Sender: TObject);
    procedure cxgItensViewColumnSizeChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure btnPreTEGridClick(Sender: TObject);
    procedure cxgItensQTDVENGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensSIGUNIGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensQTDEMBGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems42GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxgItensReaTraGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensFANEMPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure lblConfiguraColunasClick(Sender: TObject);
    procedure lblListaMesesGiroClick(Sender: TObject);
    procedure btnPedidosPendClick(Sender: TObject);
    procedure cxgItensVNOLCDGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensTIPABSGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);

  private
    { Private declarations }
    intRecNo: Integer;
    blnEmpVis: Boolean;
    objCfgGri: TCfgGrid;
    intDEQTPC: Integer;
    procedure pDestacaMes(intMes: Integer; ACanvas: TcxCanvas; blnSelected: Boolean; AViewInfo: TcxGridTableDataCellViewInfo);
    Procedure pAtualizaCaptions;
    procedure pMostraGiroAnalitico;
    procedure pMostraPedidosVendas;
    procedure pPreparaGeracaoTE;

    procedure pDefineTransferencia;

  public
    { Public declarations }
    cdsDigMultLoja: TComponent;
    strEmpCalc: string;
    blnCotacao: Boolean;
    ArrCamposCfg: TArrCamposCfg;
    ArrCampoBloqueado:  TArrCamposCfg;

    function fGetVisibleArrCamposCfg(cxColumn: TcxGridDBBandedColumn): boolean;
//     function fGetCampoCfgIndex(cxColumn: string): Integer;
    procedure pCarregaArrCampos;
    function fGetWidthBand(BandIndex: integer): integer;
    procedure pAddCampoBloqueado(cxColumn: TcxGridDBBandedColumn);
    function fLocalizaPosArray(objArray: TArrCamposCfg; strColuna: string): integer;

  end;

implementation

{$R *.dfm}
uses
  StrUtils,
  untDemostrativoBaseCompra,
  untCdsDigMultLoja,
  untFuncoesRel, untFuncoesRel2, untRecuperaPedido, untTGiroPromocao;

procedure TfrmEntDigMultiLojasNovo.pDestacaMes(intMes: Integer; ACanvas: TcxCanvas; blnSelected: Boolean; AViewInfo: TcxGridTableDataCellViewInfo);
var cxgItensITE_Q_VP: TcxGridDBBandedColumn;
Begin
  If Assigned(cdsDigMultLoja) And ((intMes <= TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.intMesGir) Or ((intMes = 13) And TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.blnConsMesAtu) ) And
     (TCdsDigMultLoja(CdsDigMultLoja).blnComGir Or (Assigned(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt) And
                                    TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt.blnEncontrouGiro)) Then
  Begin
    ACanvas.Font.Color := clRed;
    ACanvas.Font.Style := [fsBold];

    If blnSelected Then
      ACanvas.Brush.Color := $00F5DBC2;
  End;

  cxgItensITE_Q_VP := nil;
  case intMes of
     1: cxgItensITE_Q_VP := cxgItensITE_Q_VP01;
     2: cxgItensITE_Q_VP := cxgItensITE_Q_VP02;
     3: cxgItensITE_Q_VP := cxgItensITE_Q_VP03;
     4: cxgItensITE_Q_VP := cxgItensITE_Q_VP04;
     5: cxgItensITE_Q_VP := cxgItensITE_Q_VP05;
     6: cxgItensITE_Q_VP := cxgItensITE_Q_VP06;
     7: cxgItensITE_Q_VP := cxgItensITE_Q_VP07;
     8: cxgItensITE_Q_VP := cxgItensITE_Q_VP08;
     9: cxgItensITE_Q_VP := cxgItensITE_Q_VP09;
    10: cxgItensITE_Q_VP := cxgItensITE_Q_VP10;
    11: cxgItensITE_Q_VP := cxgItensITE_Q_VP11;
    12: cxgItensITE_Q_VP := cxgItensITE_Q_VP12;
    13: cxgItensITE_Q_VP := cxgItensITE_Q_VPME;
  end;
  If Assigned(cxgItensITE_Q_VP) Then
    If (cxgItensView.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensITE_Q_VP.Index] > 0) Then
      ACanvas.Font.Color := clBlue;

End;

procedure TfrmEntDigMultiLojasNovo.cxgItensViewColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBBandedColumn(AColumn).Position.Band.Width := fGetWidthBand(TcxGridDBBandedColumn(AColumn).Position.BandIndex)
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                          cxgItensCODEMP.Index]) = VS_strCodEmp) And
  (AViewInfo.Item.Index <> cxgItensQTDITE.Index) And
  (AViewInfo.Item.Index <> cxgItensESTMIN.Index) And
  (AViewInfo.Item.Index <> cxgItensESTMAX.Index) And
  (AViewInfo.Item.Index <> cxgItensMINDIG.Index) And
  (AViewInfo.Item.Index <> cxgItensMAXDIG.Index) Then
  Begin
      ACanvas.Brush.Color := clMoneyGreen;

    If AViewInfo.Selected Then
    Begin
      ACanvas.Font.Color := clWhite;
      ACanvas.Brush.Color := -16777203;
      If AViewInfo.Item = cxgItensQ_V_01 Then
        pDestacaMes(01, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_02 Then
        pDestacaMes(02, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_03 Then
        pDestacaMes(03, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_04 Then
        pDestacaMes(04, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_05 Then
        pDestacaMes(05, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_06 Then
        pDestacaMes(06, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_07 Then
        pDestacaMes(07, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_08 Then
        pDestacaMes(08, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_09 Then
        pDestacaMes(09, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_10 Then
        pDestacaMes(10, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_11 Then
        pDestacaMes(11, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensQ_V_12 Then
        pDestacaMes(12, ACanvas, AViewInfo.Selected, AViewInfo);
      If AViewInfo.Item = cxgItensVENMES Then
        pDestacaMes(13, ACanvas, AViewInfo.Selected, AViewInfo);

    End;
  End;

end;

procedure TfrmEntDigMultiLojasNovo.pDefineTransferencia;
Begin
  If cxgItensQTDTRA.Focused And Assigned(cdsDigMultLoja) And
     Assigned(TCdsDigMultLoja(CdsDigMultLoja).pDefineTransferencia) Then
    TCdsDigMultLoja(CdsDigMultLoja).pDefineTransferencia;
End;

procedure TfrmEntDigMultiLojasNovo.cxgItensViewDataControllerSummaryFooterSummaryItemsSummary(
  ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
  var OutArguments: TcxSummaryEventOutArguments);
begin
  inherited;
  If blnCotacao  Then
    Exit;
  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If (Not blnEmpVis) Then
    Exit;

  If (strEmpCalc <> '') And (Pos(VarToStr(cxgItensView.DataController.Values[Arguments.RecordIndex, cxgItensCODEMP.Index]), strEmpCalc) = 0) Then
     OutArguments.Done := True
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensCODEMPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If blnCotacao Then
    Exit;

  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If (Not blnEmpVis) Then
    Exit;

  If (strEmpCalc <> '') And (Pos(VarToStr(cxgItensView.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensCODEMP.Index]), strEmpCalc) = 0) Then
    ACanvas.Font.Color := clFuchsia;

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensViewDblClick(Sender: TObject);
begin
  inherited;

  pDefineTransferencia;

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems42GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
  Var
    fltQtdIte,
    fltEmbala: Double;
begin
  inherited;

  If Assigned(cdsDigMultLoja) Then
    fltEmbala := TCdsDigMultLoja(CdsDigMultLoja).fltQtdEmb
  Else
    fltEmbala := 1;

  fltQtdIte := IFNull(cxgItensView.DataController.Summary.FooterSummaryValues[16], 0);

  AText := FormatFloat('#,##0.00', fltEmbala * fltQtdIte);
end;

function TfrmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(
  cxColumn: TcxGridDBBandedColumn): boolean;
  var campo : TRecCampoCfg;
begin
  Result := False;
  // Proucura o campo apenas se ele não estiver na lista de bloqueio
  If (Length(ArrCampoBloqueado) > 0) and (fLocalizaPosArray(ArrCampoBloqueado, cxColumn.Name) <> -1)  Then
    Exit;
  For campo in ArrCamposCfg do
  Begin
    If campo.ComponentName = cxColumn.Name Then
    Begin
      Result := Campo.Visible;
      break
    End;
  End;

end;

function TfrmEntDigMultiLojasNovo.fGetWidthBand(BandIndex: integer): integer;
var i: integer;
begin
  Result := 0;
  For i:= 0 To cxgItensView.ColumnCount -1 do
  Begin
    if (cxgItensView.Columns[i].Visible) And
       (TcxGridDBBandedColumn(cxgItensView.Columns[i]).Position.BandIndex = BandIndex) Then
     Result := Result + cxgItensView.Columns[i].Width;
  End;
  //Ajuste para bandas inferiores a ultima.
  If (Result > 0) And (BandIndex < (cxgItensView.Bands.Count -1)) Then
    Result := Result + 15;


end;



function TfrmEntDigMultiLojasNovo.fLocalizaPosArray(objArray: TArrCamposCfg; strColuna: string): integer;
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

procedure TfrmEntDigMultiLojasNovo.pCarregaArrCampos;
  var
    i : integer;
begin
  SetLength(ArrCamposCfg, 0);
  If Assigned(Self) Then
  begin

    for i := 0 to Self.cxgItensView.ColumnCount -1 do
    Begin
      if Self.cxgItensView.Columns[i] is TcxGridDBBandedColumn then
      begin
        SetLength(ArrCamposCfg, Length(ArrCamposCfg) + 1);
        ArrCamposCfg[i].ComponentName := TcxGridDBBandedColumn(Self.cxgItensView.Columns[i]).Name;
        ArrCamposCfg[i].Visible       := TcxGridDBBandedColumn(Self.cxgItensView.Columns[i]).Visible;
        ArrCamposCfg[i].Width         := TcxGridDBBandedColumn(Self.cxgItensView.Columns[i]).Width;
        ArrCamposCfg[i].BandIndex     := TcxGridDBBandedColumn(Self.cxgItensView.Columns[i]).Position.BandIndex;
      End;
    End;
  End;
end;


procedure TfrmEntDigMultiLojasNovo.btnGiroAnaClick(Sender: TObject);
begin
  inherited;

  pMostraGiroAnalitico;

end;

procedure TfrmEntDigMultiLojasNovo.btnPedidosPendClick(Sender: TObject);
begin
  inherited;

  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(TCdsDigMultLoja(cdsDigMultLoja).cdsItens) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(472, 34131, [],
                        ['LSTITE','CODEMP'],
                        [TCdsDigMultLoja(cdsDigMultLoja).strCodIte,
                        TCdsDigMultLoja(cdsDigMultLoja).cdsItens.FieldByName('ITE_CODEMP').AsString],
                        nil,
                        nil,
                        True);
  End;
end;

procedure TfrmEntDigMultiLojasNovo.btnPedVenClick(Sender: TObject);
begin
  inherited;

  pMostraPedidosVendas;
end;

procedure TfrmEntDigMultiLojasNovo.btnPrepTEClick(Sender: TObject);
begin
  inherited;
  If btnPrepTE.Visible Then
    pPreparaGeracaoTE;

end;

procedure TfrmEntDigMultiLojasNovo.btnPreTEGridClick(Sender: TObject);
begin
  inherited;

  If Not btnPreTEGrid.Visible Then
    Exit;

  pCriarFormularios(TfrmLiberaPrepTE, frmLiberaPrepTE);

  frmLiberaPrepTE.oblPrepTe := TCdsDigMultLoja(CdsDigMultLoja).objPreparaGerMultiLoja;
  frmLiberaPrepTE.ShowModal;

  pFreeAndNil(frmLiberaPrepTE);
end;

procedure TfrmEntDigMultiLojasNovo.btnSairClick(Sender: TObject);
begin
  inherited;

  If Assigned(cdsDigMultLoja) And Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) And
     TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Active And (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.strPedMlj = 'S') And
     (TCdsDigMultLoja(CdsDigMultLoja).cdsItens.State = dsEdit) Then
    TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Cancel;

end;


procedure TfrmEntDigMultiLojasNovo.cxgGiroDIAESTSummaryGetText(
  Sender: TcxDataSummaryItem; const [Ref] AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;

  If Assigned(cdsDigMultLoja) Then
    AText := IntToStr(TCdsDigMultLoja(CdsDigMultLoja).fRetDiaEstSint);
end;

procedure TfrmEntDigMultiLojasNovo.cxgGiroDIASUGSummaryGetText(
  Sender: TcxDataSummaryItem; const [Ref] AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;

  If Assigned(cdsDigMultLoja) Then
    AText := IntToStr(TCdsDigMultLoja(CdsDigMultLoja).fRetDiaSugSint);
end;

procedure TfrmEntDigMultiLojasNovo.cxgGiroExit(Sender: TObject);
begin
  inherited;

  If Assigned(cdsDigMultLoja) And Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) And
    (TCdsDigMultLoja(CdsDigMultLoja).cdsItens.State = dsEdit) Then
    TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Post;
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensCODITEGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Assigned(cdsDigMultLoja) Then
    AText := AText +  ' - ' + TCdsDigMultLoja(CdsDigMultLoja).FDesIte;
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensCPRCENGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If AText = 'S' Then
    AText := 'C'
  Else
    AText := 'I';
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensESTMINCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (cxgItensView.OptionsData.Editing) AND (AViewInfo.Item.Options.Editing) Then
  Begin
    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
     ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensFANEMPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If blnCotacao Then
    Exit;

  If (Not blnEmpVis) Then
    Exit;

  If (strEmpCalc <> '') And (Pos(VarToStr(cxgItensView.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensCODEMP.Index]), strEmpCalc) = 0) Then
    ACanvas.Font.Color := clFuchsia;
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensNOMEMPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If blnCotacao Then
    Exit;

  If (Not blnEmpVis) Then
    Exit;

  If (strEmpCalc <> '') And (Pos(VarToStr(cxgItensView.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensCODEMP.Index]), strEmpCalc) = 0) Then
    ACanvas.Font.Color := clFuchsia;

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensNOMFORGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  AText := VarToStr(cxgItensView.DataController.Values[ARecord.RecordIndex,
                                          cxgItensFORULT.Index]) + '-' + AText;

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_01CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(01, ACanvas, AViewInfo.Selected, AViewInfo);

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_02CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(02, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_03CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(03, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_04CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(04, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_05CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(05, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_06CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(06, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_07CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(07, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_08CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(08, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_09CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(09, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_10CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(10, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_11CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(11, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQ_V_12CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(12, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensReaTraGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;

  If AText = '' Then
    AText := FormatFloat(fMskDigitos(fCfgSis('DEQTPC', varInteger)), 0)

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensSIGUNIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Assigned(cdsDigMultLoja) And (Not TCdsDigMultLoja(CdsDigMultLoja).fAncorado) Then
    AText := TCdsDigMultLoja(CdsDigMultLoja).strSigUniPed;
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQTDEMBGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Assigned(cdsDigMultLoja) And (Not TCdsDigMultLoja(CdsDigMultLoja).fAncorado) Then
    AText := FormatFloat(fMskDigitos(8), TCdsDigMultLoja(CdsDigMultLoja).fltQtdEmb);

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQTDITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If cxgItensView.OptionsData.Editing Then
  Begin
    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
     ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensQTDVENGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
   Var
     fltEmbala,
     fltQtdIte: Double;
begin
  inherited;

  If Assigned(cdsDigMultLoja) And (Not TCdsDigMultLoja(CdsDigMultLoja).fAncorado) Then
    fltEmbala := TCdsDigMultLoja(CdsDigMultLoja).fltQtdEmb
  Else
    fltEmbala := fStrToFloat(VarToStr(cxgItensView.DataController.Values[ARecord.RecordIndex, cxgItensQTDEMB.Index]));

  fltQtdIte := fStrToFloat(VarToStr(cxgItensView.DataController.Values[ARecord.RecordIndex, cxgItensQTDITE.Index]));

  AText := FormatFloat('#,##0.00', fltEmbala * fltQtdIte);

end;

procedure TfrmEntDigMultiLojasNovo.cxgItensVENMESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;


  If Assigned(cdsDigMultLoja) And TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.blnConsMesAtu And
     (TCdsDigMultLoja(CdsDigMultLoja).blnComGir Or (Assigned(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt) And
                                    TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt.blnEncontrouGiro)) Then
  Begin
    ACanvas.Font.Color := clRed;
    ACanvas.Font.Style := [fsBold];
  End;
  pDestacaMes(13, ACanvas, AViewInfo.Selected, AViewInfo);
end;

procedure TfrmEntDigMultiLojasNovo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(cdsDigMultLoja) Then
  With TCdsDigMultLoja(cdsDigMultLoja), cdsItens Do
  Begin

    If ModalResult = mrOk Then
    Begin
      If Not fValidaDados(True) Then
      Begin
        If Self.Active Then
          Action := caNone;

        Exit;
      End;
    End;

    pSalvaRecDim(Self);

    If State In [dsEdit] Then
      Post;
  End;

end;

procedure TfrmEntDigMultiLojasNovo.FormCreate(Sender: TObject);
begin
  inherited;
  blnCotacao := False;
  cdsDigMultLoja := Nil;
  intRecNo       := -1;
  intDEQTPC := fCfgSis('DEQTPC', varInteger);
  blnEmpVis := fCfgSis('EMPVIS', varBoolean);

  cxgItensPMED_V.Visible := fCfgSis('RNPMVE', varBoolean);

  cxgItensESTMAX.Options.Editing := fVerificaAcessoSistema('ALEPCM');
  cxgItensESTMIN.Options.Editing := fVerificaAcessoSistema('ALEPCM');

  If fCfgSis('ESMILJ', varBoolean) Then //N-> iteger / S-> Cadite : Quando está S, não deve carregar as colunas.
    pAddCampoBloqueado(cxgItensESMIDG);

  TcxCustomCurrencyEditProperties(cxgItensQTDITE.Properties).DecimalPlaces := fCfgSis('DEQTPC', varInteger);
end;

procedure TfrmEntDigMultiLojasNovo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intPos: Integer;
begin
  inherited;

  Case Key Of
    VK_RETURN: If Assigned(cdsDigMultLoja) And cxgItensQTDITE.Focused Then
               Begin

                 With TCdsDigMultLoja(cdsDigMultLoja), cdsItens Do
                 If (State = dsEdit) Or (intRecNo = RecNo) Then
                 Begin
                   intRecNo := -1;

                   intPos := RecNo;
                   cxgItensView.NavigatorButtons.Next.Click;

                   If intPos = RecNo Then
                   Begin
                     If State = dsEdit Then
                       Post;

                     pSetFocus(btnConfirma)
                   End;
                 End

                 Else intRecNo := RecNo;

               End

               Else If Assigned(cdsDigMultLoja) And Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) And
                  TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Active And (TCdsDigMultLoja(CdsDigMultLoja).cdsItens.State = dsEdit) And
                  (cxgItensESTMIN.Focused Or cxgItensMINDIG.Focused) Then
                 TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Post

               Else If cxgItensQTDTRA.Focused Then
                      pDefineTransferencia;

     Else If Assigned(Parent) And Assigned(cdsDigMultLoja) And
             Assigned(TCdsDigMultLoja(CdsDigMultLoja).frmPaiGiro) Then
             Begin
               Case Key Of
                 VK_ESCAPE: Begin
                              //  TCdsDigMultLoja(CdsDigMultLoja).frmPaiGiro.Close;
                              Key := 0;
                            End;

                 Else TCdsDigMultLoja(CdsDigMultLoja).frmPaiGiro.OnKeyDown(Nil, Key, Shift);
               End;

               If Key = VK_F10 Then
                 Key := 0;
             End;
  End;

  If Not Assigned(Parent) Then
  Begin

    Case Key Of
      VK_ESCAPE: If blnFecharComEscape Then
                   btnSair.Click;

      VK_F2    : pMostraGiroAnalitico;
      VK_F3    : pMostraPedidosVendas;
      VK_F5    : pPreparaGeracaoTE;

      VK_F6    : btnPreTEGrid.Click;
      VK_F7    : btnPedidosPend.Click;
      VK_F10: Begin
                Key := 0;
                btnConfirma.Click;
              End;
    End;

  End;

end;

procedure TfrmEntDigMultiLojasNovo.FormResize(Sender: TObject);
begin
  inherited;

  If Assigned(cdsDigMultLoja) And Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) And
     TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Active And (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.strPedMlj = 'S') Then
  Begin
    If cxgGiro.Height > (TCdsDigMultLoja(CdsDigMultLoja).cdsItens.RecordCount + 5) * 20 Then
    Begin
      cxgItensView.OptionsView.Footer       := False;
      cxgItensView.OptionsView.GroupFooters := gfAlwaysVisible;
    End Else
    Begin
      cxgItensView.OptionsView.Footer       := True;
      cxgItensView.OptionsView.GroupFooters := gfInvisible;
    End;

  End;

end;

procedure TfrmEntDigMultiLojasNovo.FormShow(Sender: TObject);
  Var
    intBand0W,
    intCodEmpW,
    intNomEmpW: Integer;
begin
  btnPreTEGrid.Visible := Assigned(cdsDigMultLoja) And
                          Assigned(TCdsDigMultLoja(CdsDigMultLoja).objPreparaGerMultiLoja) And
                          TCdsDigMultLoja(CdsDigMultLoja).objPreparaGerMultiLoja.blnAculumarDigitacao;

  blnFecharComEscape := False;

  If Assigned(cdsDigMultLoja) Then
  Begin
    TCdsDigMultLoja(CdsDigMultLoja).blnAlterouEstoqueMinMax := False;

    If blnEmpVis And Assigned(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt) Then
      blnEmpVis := TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt.blnEncontrouGiro;

    cxgItensQTDEXC.Visible := TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.blnSpoTra And (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.strPedMlj = 'S') And (fGetVisibleArrCamposCfg(cxgItensQTDEXC));
    cxgItensReaTra.Visible := cxgItensQTDEXC.Visible;
    If Not((TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.blnSpoTra) And (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.strPedMlj = 'S')) Then
      pAddCampoBloqueado(cxgItensQTDEXC);

    TCdsDigMultLoja(CdsDigMultLoja).colQtdIte := cxgItensQTDITE;
    dtsPcdDet.DataSet := TCdsDigMultLoja(CdsDigMultLoja).cdsItens;
    While dtsPcdDet.DataSet.ControlsDisabled Do
      dtsPcdDet.DataSet.EnableControls;

    If Not (((TCdsDigMultLoja(CdsDigMultLoja).blnComGir)  Or (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.strPedMlj = 'S')) Or
            (Assigned(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt) And TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt.blnEncontrouGiro)) Then
    Begin
      cxgItensSUGEST.Visible := False;
      cxgItensDIASUG.Visible := False;
      pAddCampoBloqueado(cxgItensSUGEST);
      pAddCampoBloqueado(cxgItensDIASUG);
    End;

    If Not (TCdsDigMultLoja(CdsDigMultLoja).blnComGir Or (Assigned(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt) And
             TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objSalInt.blnEncontrouGiro)) Then
    Begin
      lblMesMed.Visible := False;
      shpMesMed.Visible := False;
      cxgItensQTDEXC.Visible := False;
      cxgItensReaTra.Visible := cxgItensQTDEXC.Visible;
      pAddCampoBloqueado(cxgItensQTDEXC);
    End;

    If (TCdsDigMultLoja(CdsDigMultLoja).strCnvEmb = 'N') Or (TCdsDigMultLoja(CdsDigMultLoja).FCotacao) Then
    Begin
      cxgItensQTDEMB.Visible := False;
      cxgItensQTDVEN.Visible := False;
    End;

    If Assigned(TCdsDigMultLoja(CdsDigMultLoja).pAtualizaMeses) Then
    Begin
      TCdsDigMultLoja(CdsDigMultLoja).pAtualizaMeses(cxgItensView);
    End;

    TCdsDigMultLoja(CdsDigMultLoja).pCarregaRecDim(Self);

    cxgItensMEDAJU.Visible := (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.intMesGir > 3) And (fGetVisibleArrCamposCfg(cxgItensMEDAJU)) and ((fGetVisibleArrCamposCfg(cxgItensQ_V_04)));{And (TCdsDigMultLoja(CdsDigMultLoja).fltLimAma > 0)};
    If Not (TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.intMesGir > 3) Then
      pAddCampoBloqueado(cxgItensMEDAJU);


    if (fCfgSis('EXIPCT', varString) = 'S') then
    begin
      cxgItensTIPABS.Visible := True;
      cxgItensVNOLCD.Visible := True;
    end
    else
    begin
      cxgItensTIPABS.Visible := False;
      cxgItensVNOLCD.Visible := False;
      pAddCampoBloqueado(cxgItensTIPABS);
      pAddCampoBloqueado(cxgItensVNOLCD);
    end;

    If fCfgSis('LIBETE') <> '2' Then
      If Assigned(CdsDigMultLoja) then
        If Assigned(TRecuperaPedido(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objRecupera)) Then
         If TRecuperaPedido(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objRecupera).recPcmger.strPedMlj = 'S' Then
         Begin
           TCdsDigMultLoja(CdsDigMultLoja).objPreparaGerMultiLoja.AutincPedidoCompra := TRecuperaPedido(TCdsDigMultLoja(CdsDigMultLoja).recOpcGir.objRecupera).recPcmger.strAutInc;
           TCdsDigMultLoja(CdsDigMultLoja).objPreparaGerMultiLoja.pAtualizaAutoincremPedido;
         End;

    cxgItensITE_PONEXP.Visible := fCfgSis('PONEXP', varString) = 'S';

  End;

  cxgItensREFERE.Visible := False;

  shpEmpVis.Visible := blnEmpVis;
  lblEmpVis.Visible := blnEmpVis;
  pnlEmpVis.Visible := blnEmpVis;

  pAtualizaCaptions;

  pSetFocus(cxgGiro);

  If Assigned(Parent) Then
  Begin
   // cxgItensVENMES.Focused := True;
    cxgItensView.Controller.LeftPos := 0;
  End Else
    cxgItensQTDITE.Focused := True;

  cxgItensView.ViewData.Expand(True);

  cxgItensView.NavigatorButtons.First.Click;
  cxgItensView.NavigatorButtons.Next.Click;

  intBand0W  := cxgItensView.Bands[0].Width;
  intCodEmpW := cxgItensCODEMP.Width;
  intNomEmpW := cxgItensNOMEMP.Width;

//  cxgItensView.ApplyBestFit;

  cxgItensView.Bands[0].Width := intBand0W;
  cxgItensCODEMP.Width := intCodEmpW;
  cxgItensNOMEMP.Width := intNomEmpW;

  cxgItensESMIDG.Visible := fGetVisibleArrCamposCfg(cxgItensESMIDG);
  cxgItensESTEXC.Visible := TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento;
  cxgItensDIFSUG.Visible := TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento;


  inherited;
end;

procedure TfrmEntDigMultiLojasNovo.lblConfiguraColunasClick(Sender: TObject);
var arrColunasWidth: TColunasWidth;
    i: integer;
begin
  inherited;
  SetLength(arrColunasWidth, cxgItensView.ColumnCount);
  for i := 0 To cxgItensView.ColumnCount -1 do
  Begin
    arrColunasWidth[i] := cxgItensView.Columns[i].Width;
  End;


  objCfgGri := TCfgGrid.Create(Self, cxgItensView, 'Digitação de quantidade multiloja', arrColunasWidth, strLoginUsuarioLogado, True, False, ArrCampoBloqueado);
  Try
    objCfgGri.pConfiguraColunas;
    cxgItensView.Bands[0].Width := fGetWidthBand(0);
    cxgItensView.Bands[1].Width := fGetWidthBand(1);

    pCarregaArrCampos;

  Finally
    FreeAndNil(objCfgGri);
  End;

end;

procedure TfrmEntDigMultiLojasNovo.lblListaMesesGiroClick(Sender: TObject);
var intMesMos: integer;
    cdsItens: TDataSet;
    ArrGirPromocao: TArrGirPromocao;
    dtaDataBaseGir : TDateTime;
    i: integer;
    blnCampoMesDes: Boolean;
    procedure pAlimetaArray(posicao: integer);
      var strComplemento: String;
    Begin
      strComplemento := fStrZero(posicao, 2);
      If blnCampoMesDes And (posicao <> 0) Then
        ArrGirPromocao[posicao].Mes :=  cdsItens.FieldByName('ITE_DESM'+ strComplemento).AsString
      Else
        ArrGirPromocao[posicao].Mes := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -posicao));
      If posicao = 0 Then
      Begin
        ArrGirPromocao[posicao].QtdVenProm := cdsItens.FieldByName('ITE_Q_VPME').AsFloat;
        ArrGirPromocao[posicao].QtdVendida := cdsItens.FieldByName('ITE_VENMES').AsFloat;
        ArrGirPromocao[posicao].QtdSemProm := ArrGirPromocao[posicao].QtdVendida - ArrGirPromocao[posicao].QtdVenProm;
      End
      Else
      Begin
        ArrGirPromocao[posicao].QtdVenProm := cdsItens.FieldByName('ITE_Q_VP'+ strComplemento).AsFloat;
        ArrGirPromocao[posicao].QtdVendida := cdsItens.FieldByName('ITE_Q_V_'+ strComplemento ).AsFloat;
        ArrGirPromocao[posicao].QtdSemProm := ArrGirPromocao[posicao].QtdVendida - ArrGirPromocao[posicao].QtdVenProm;
      End
    End;
begin
  inherited;

  intMesMos :=  TCdsDigMultLoja(cdsDigMultLoja).recOpcGir.intMesMos;
  cdsItens  := cxgItensView.DataController.DataSet;
  dtaDataBaseGir := TCdsDigMultLoja(cdsDigMultLoja).recOpcGir.dtaDataBaseGir;



  If intMesMos > 6 Then
    SetLength(ArrGirPromocao, 13)
  Else If intMesMos > 3 Then
    SetLength(ArrGirPromocao, 7)
  Else
    SetLength(ArrGirPromocao, 4);
  blnCampoMesDes := Not fEmptyStr(cdsItens.FieldByName('ITE_DESM01').AsString);
  For i := 0 To  Length(ArrGirPromocao) -1 do
  Begin
    ArrGirPromocao[i].Mes := '';
    ArrGirPromocao[i].QtdVenProm := 0;
    ArrGirPromocao[i].QtdVendida := 0;
    ArrGirPromocao[i].QtdSemProm := 0;
  End;
  If intMesMos > 6 Then
  Begin
      pAlimetaArray(12);
      pAlimetaArray(11);
      pAlimetaArray(10);
      pAlimetaArray(09);
      pAlimetaArray(08);
      pAlimetaArray(07);

  End;
  If intMesMos > 3 Then
  Begin
    pAlimetaArray(06);
    pAlimetaArray(05);
    pAlimetaArray(04);
  End;
  pAlimetaArray(03);
  pAlimetaArray(02);
  pAlimetaArray(01);

  pAlimetaArray(00);


  TfrmGiroPromocao.pExecuta(ArrGirPromocao,cdsItens.FieldByName('ITE_CODITE').AsString,
                                           cdsItens.FieldByName('ITE_REFERE').AsString,
                                           cdsItens.FieldByName('ITE_SIGUNI').AsString);

end;

procedure TfrmEntDigMultiLojasNovo.lblResPadClick(Sender: TObject);
begin
  inherited;

  If Assigned(cdsDigMultLoja) Then
  Begin
    TCfgGrid.pResetaConfiguracao(strLoginUsuarioLogado, 'Digitação de quantidade multiloja');
    TCdsDigMultLoja(CdsDigMultLoja).pRestauraPadrao;
  End;

end;

procedure TfrmEntDigMultiLojasNovo.lblSalbasClick(Sender: TObject);
begin
  inherited;

  If Assigned(cdsDigMultLoja) And Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) And
     TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Active And (Not TCdsDigMultLoja(CdsDigMultLoja).cdsItens.IsEmpty) Then
    TfrmDemostrativoBaseCompra.pDesmonstra(TCdsDigMultLoja(CdsDigMultLoja).cdsItens, TCdsDigMultLoja(CdsDigMultLoja).recOpcGir, TCdsDigMultLoja(CdsDigMultLoja).blnComGir);
end;

procedure TfrmEntDigMultiLojasNovo.pAddCampoBloqueado(cxColumn: TcxGridDBBandedColumn);
begin
  If fLocalizaPosArray(ArrCampoBloqueado, cxColumn.Name) = -1  Then
  Begin
    SetLength(ArrCampoBloqueado, Length(ArrCampoBloqueado) + 1);
    ArrCampoBloqueado[Length(ArrCampoBloqueado) -1].ComponentName := cxColumn.name;
  end;
end;

Procedure TfrmEntDigMultiLojasNovo.pAtualizaCaptions;
  Var
    intContador: Integer;
    intWidth: Integer;
    strNivGir: String;
begin
  If Assigned(cdsDigMultLoja) And Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) And
     TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Active Then
  With TCdsDigMultLoja(cdsDigMultLoja), cdsItens, recOpcGir, recNivEst Do
  Begin

    cxgItensQ_V_04.Visible := (intMesMos >= 6)  And (fGetVisibleArrCamposCfg(cxgItensQ_V_04));
    cxgItensQ_V_05.Visible := (intMesMos >= 6)  And (fGetVisibleArrCamposCfg(cxgItensQ_V_05));
    cxgItensQ_V_06.Visible := (intMesMos >= 6)  And (fGetVisibleArrCamposCfg(cxgItensQ_V_06));
    If Not (intMesMos >= 6) Then
    Begin
      pAddCampoBloqueado(cxgItensQ_V_04);
      pAddCampoBloqueado(cxgItensQ_V_05);
      pAddCampoBloqueado(cxgItensQ_V_06);
    end;

    cxgItensQ_V_07.Visible := (intMesMos >= 12) And (fGetVisibleArrCamposCfg(cxgItensQ_V_07));
    cxgItensQ_V_08.Visible := (intMesMos >= 12) And (fGetVisibleArrCamposCfg(cxgItensQ_V_08));
    cxgItensQ_V_09.Visible := (intMesMos >= 12) And (fGetVisibleArrCamposCfg(cxgItensQ_V_09));
    cxgItensQ_V_10.Visible := (intMesMos >= 12) And (fGetVisibleArrCamposCfg(cxgItensQ_V_10));
    cxgItensQ_V_11.Visible := (intMesMos >= 12) And (fGetVisibleArrCamposCfg(cxgItensQ_V_11));
    cxgItensQ_V_12.Visible := (intMesMos >= 12) And (fGetVisibleArrCamposCfg(cxgItensQ_V_12));
    If Not (intMesMos >= 12) Then
    Begin
      pAddCampoBloqueado(cxgItensQ_V_07);
      pAddCampoBloqueado(cxgItensQ_V_08);
      pAddCampoBloqueado(cxgItensQ_V_09);
      pAddCampoBloqueado(cxgItensQ_V_10);
      pAddCampoBloqueado(cxgItensQ_V_11);
      pAddCampoBloqueado(cxgItensQ_V_12);
    End;

    DisableControls;
    First;
    cxgItensVENMES.Caption := FormatDateTime('MM/YYYY', VS_Date);

    While (fEmptyStr(FieldByName('ITE_DESM01').AsString)) And
          (Not Eof)                                       Do
    Begin
      Next;
    End;
    EnableControls;


    If fEmptyStr(FieldByName('ITE_DESM01').AsString) Then
    Begin
      If intMesMos > 6 Then
      Begin
        cxgItensQ_V_12.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -12)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP12') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_11.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -11)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP11') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_10.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -10)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP10') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_09.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -9)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP09') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_08.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -8)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP08') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_07.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -7)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP07') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      End;

      If intMesMos > 3 Then
      Begin
        cxgItensQ_V_06.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -6)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP06') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_05.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -5)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP05') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_04.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -4)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP04') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      End;

      cxgItensQ_V_03.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -3)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP03') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      cxgItensQ_V_02.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -2)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP02') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      cxgItensQ_V_01.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -1)) + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP01') > 0, fEscreAsteriscoPromocao(recOpcGir), '');

      cxgItensVENMES.Caption := StringReplace(cxgItensVENMES.Caption, '(*)', '', []);
      If TCdsDigMultLoja(CdsDigMultLoja).cdsItens.FieldByName('ITE_Q_VPME').AsFloat > 0 Then
         cxgItensVENMES.Caption := cxgItensVENMES.Caption + fEscreAsteriscoPromocao(recOpcGir);

    End
    Else
    Begin
      If intMesMos > 6 Then
      Begin
        cxgItensQ_V_12.Caption := FieldByName('ITE_DESM12').AsString + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP12') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_11.Caption := FieldByName('ITE_DESM11').AsString + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP11') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_10.Caption := FieldByName('ITE_DESM10').AsString + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP10') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_09.Caption := FieldByName('ITE_DESM09').AsString + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP09') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_08.Caption := FieldByName('ITE_DESM08').AsString + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP08') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_07.Caption := FieldByName('ITE_DESM07').AsString + IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP07') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      End;

      If intMesMos > 3 Then
      Begin 
        cxgItensQ_V_06.Caption := FieldByName('ITE_DESM06').AsString+ IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP06') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_05.Caption := FieldByName('ITE_DESM05').AsString+ IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP05') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
        cxgItensQ_V_04.Caption := FieldByName('ITE_DESM04').AsString+ IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP04') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      End;

      cxgItensQ_V_03.Caption := FieldByName('ITE_DESM03').AsString+ IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP03') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      cxgItensQ_V_02.Caption := FieldByName('ITE_DESM02').AsString+ IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP02') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
      cxgItensQ_V_01.Caption := FieldByName('ITE_DESM01').AsString+ IIf(TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VP01') > 0, fEscreAsteriscoPromocao(recOpcGir), '');
    End;

    lblLegMesPromo.Visible := (fEscreAsteriscoPromocao(recOpcGir) <> '');
    lblListaMesesGiro.Visible := (fEscreAsteriscoPromocao(recOpcGir) <> '');

    cxgItensVENMES.Caption := StringReplace(cxgItensVENMES.Caption, '(*)', '',[]);
    If TCdsDigMultLoja(CdsDigMultLoja).fGetQtdProSintetica('ITE_Q_VPME') > 0 Then
      cxgItensVENMES.Caption := cxgItensVENMES.Caption + fEscreAsteriscoPromocao(recOpcGir);

     cxgItensVENMES.Visible := pos(cxgItensVENMES.Caption, cxgItensQ_V_12.Caption + '_' +
                                  cxgItensQ_V_11.Caption + '_' +
                                  cxgItensQ_V_10.Caption + '_' +
                                  cxgItensQ_V_09.Caption + '_' +
                                  cxgItensQ_V_08.Caption + '_' +
                                  cxgItensQ_V_07.Caption + '_' +
                                  cxgItensQ_V_06.Caption + '_' +
                                  cxgItensQ_V_05.Caption + '_' +
                                  cxgItensQ_V_04.Caption + '_' +
                                  cxgItensQ_V_03.Caption + '_' +
                                  cxgItensQ_V_02.Caption + '_' +
                                  cxgItensQ_V_01.Caption) <= 0;

    strNivGir := FieldByName('ITE_NVLGIR').AsString;
    if strNivGir = '' Then
      strNivGir := ' ';

    If nivEstoque = nivNenhum Then
    Begin
      cxgItensMEDIXX.Caption := 'Média ' + IntToStr(intDiaComGer);
      cxgItensMEDAJU.Caption := 'Média ' + IntToStr(intDiaComGer) + ' Ajustada';
    End

    Else If strNivGir[1] = 'A' Then
    Begin
      cxgItensMEDIXX.Caption := 'Média ' + IntToStr(intDiaComNvA);
      cxgItensMEDAJU.Caption := 'Média ' + IntToStr(intDiaComNvA) + ' Ajustada';
    End

    Else If strNivGir[1] = 'B' Then
    Begin
      cxgItensMEDIXX.Caption := 'Média ' + IntToStr(intDiaComNvB);
      cxgItensMEDAJU.Caption := 'Média ' + IntToStr(intDiaComNvB) + ' Ajustada';
    End

    Else If strNivGir[1] = 'C' Then
    Begin
      cxgItensMEDIXX.Caption := 'Média ' + IntToStr(intDiaComNvC);
      cxgItensMEDAJU.Caption := 'Média ' + IntToStr(intDiaComNvC) + ' Ajustada';
    End;

  End;

  intWidth := 0;
  For intContador := 0 To cxgItensView.ColumnCount - 1 Do
    If cxgItensView.Columns[intContador].Visible And (cxgItensView.Columns[intContador].Position.BandIndex = 1) Then
    Begin
      lblTestTamanho.Caption := cxgItensView.Columns[intContador].Caption;

      If lblTestTamanho.Width > cxgItensView.Columns[intContador].width Then
      Begin
        intWidth := intWidth + cxgItensView.Columns[intContador].width +
                              (lblTestTamanho.Width - cxgItensView.Columns[intContador].width);
        cxgItensView.Columns[intContador].width := lblTestTamanho.Width;
      end
      Else
        intWidth := intWidth + cxgItensView.Columns[intContador].width;
    End;

  cxgItensView.Bands[1].Width := intWidth;

  cxgItensView.Bands[0].Width := fGetWidthBand(0);

end;

procedure TfrmEntDigMultiLojasNovo.pMostraGiroAnalitico;
begin
  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(TCdsDigMultLoja(CdsDigMultLoja).cdsItens) Then
    Exit;

  If Not TCdsDigMultLoja(CdsDigMultLoja).cdsItens.Active Then
    Exit;

  Screen.Cursor := crHourGlass;

  With TCdsDigMultLoja(cdsDigMultLoja), recOpcGir Do


  Begin
    If recOpcGir.blninfMes Then
      pCalculaGiroAnalitico(strCodIte,
                            cdsItens.FieldByName('ITE_CODEMP').AsString,
                            recOpcGir.strMeses + IIf(recOpcGir.blnConsMesAtu, FormatDateTime('YYYY/MM', fNow) , ''),
                            '1',
                            recOpcGir.blnAgrSim)
    Else
      pCalculaGiroAnalitico(dtaDataBaseGir,
                          strCodIte,
                          cdsItens.FieldByName('ITE_CODEMP').AsString,
                          intMesGir,
                          '2');
  End;

  Screen.Cursor := crDefault;

end;

procedure TfrmEntDigMultiLojasNovo.pMostraPedidosVendas;
begin

  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(103, 5793, [],
                        ['CODITE'],
                        [TCdsDigMultLoja(cdsDigMultLoja).strCodIte],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmEntDigMultiLojasNovo.pPreparaGeracaoTE;
begin
  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;

  TCdsDigMultLoja(CdsDigMultLoja).objPreparaGerMultiLoja.pInformaPreparacao(TCdsDigMultLoja(CdsDigMultLoja).strCodIte);
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensVNOLCDGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    lValor: String;
begin
  inherited;
  lValor := VarToStrDef(cxgItensView
                        .DataController
                         .Values[ARecord.RecordIndex, cxgItensVNOLCD.Index], '');

  if lValor = 'S' then
    AText := 'Sim'
  else
    AText := 'Não';
end;

procedure TfrmEntDigMultiLojasNovo.cxgItensTIPABSGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    lValor: String;
begin
  inherited;
  lValor := VarToStr(cxgItensView.DataController.Values[ARecord.RecordIndex, cxgItensTIPABS.Index]);

  Case  IndexStr(lValor,['C','T']) of
    0: AText := 'Compra fábrica';
    1: AText := 'Transferência'
  else
    AText := 'Ambos';
  end;

end;

end.

