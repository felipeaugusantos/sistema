unit untEntDigMultiLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  UniDataSetProvider, UniClientDataSet,  Uni, DBCtrls, Math,
  Mask, DBEditFocus, AppEvnts, Graphics, BitBtnLockedIncrem,
  DateUtils, frxClass, frxExportCSVTestabilidade, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCurrencyEdit, untFuncoesPedidoSimples;

Type
  TCamposTotais = Record
    strNomCampo : String;
    fltQtdTotal : Double;
  End;

type
  TfrmEntDigMultiLojas = class(TfrmPai)
    dtsPcdDet: TDataSource;
    pnlTotais: TPanel;
    lblMaQtSa: TLabel;
    dbeMaQtSa: TDBEditFocus;
    dbeMaDtSa: TDBEditFocus;
    lblMaDtSa: TLabel;
    Label4: TLabel;
    dbeMltCom: TDBEditFocus;
    Label6: TLabel;
    Shape1: TShape;
    Label1: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lblQtdPen: TLabel;
    dbeQtdPen: TDBEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    Label2: TLabel;
    Panel2: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus5: TDBEditFocus;
    Label3: TLabel;
    DBEditFocus4: TDBEditFocus;
    Label39: TLabel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCODEMP: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensDESEMP: TcxGridDBColumn;
    cxgItensQ_V_03: TcxGridDBColumn;
    cxgItensQ_V_02: TcxGridDBColumn;
    cxgItensQ_V_01: TcxGridDBColumn;
    cxgItensVENMES: TcxGridDBColumn;
    cxgItensMEDIA_: TcxGridDBColumn;
    cxgItensMEDIXX: TcxGridDBColumn;
    cxgItensSUGEST: TcxGridDBColumn;
    cxgItensESTMIN: TcxGridDBColumn;
    cxgItensESTMAX: TcxGridDBColumn;
    cxgItensSALDOS: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensDIAEST: TcxGridDBColumn;
    splGrid: TSplitter;
    cxgGiro: TcxGrid;
    cxgGiroView: TcxGridDBTableView;
    cxgGiroCODEMP: TcxGridDBColumn;
    cxgGiroMES001: TcxGridDBColumn;
    cxgGiroMES002: TcxGridDBColumn;
    cxgGiroMES003: TcxGridDBColumn;
    cxgGiroMES004: TcxGridDBColumn;
    cxgGiroMES005: TcxGridDBColumn;
    cxgGiroMES006: TcxGridDBColumn;
    cxgGiroMES007: TcxGridDBColumn;
    cxgGiroMES008: TcxGridDBColumn;
    cxgGiroMES009: TcxGridDBColumn;
    cxgGiroMES010: TcxGridDBColumn;
    cxgGiroMES011: TcxGridDBColumn;
    cxgGiroMES012: TcxGridDBColumn;
    cxgGiroVENMES: TcxGridDBColumn;
    cxgGiroMEDIA_: TcxGridDBColumn;
    cxgGiroSUGEST: TcxGridDBColumn;
    cxgGiroMLTCOM: TcxGridDBColumn;
    cxgGiroSALDOS: TcxGridDBColumn;
    cxgGiroQTDPEN: TcxGridDBColumn;
    cxgGiroSALGAR: TcxGridDBColumn;
    cxgGiroSALRES: TcxGridDBColumn;
    cxgGiroDIAEST: TcxGridDBColumn;
    cxgGiroLOCFIS: TcxGridDBColumn;
    cxgGiroESTMIN: TcxGridDBColumn;
    cxgGiroDTAULT: TcxGridDBColumn;
    cxgGiroNOMFOR: TcxGridDBColumn;
    cxgGiroQTDUCO: TcxGridDBColumn;
    cxgGiroPREULT: TcxGridDBColumn;
    cxgGiroDTAUVE: TcxGridDBColumn;
    cxgGiroDIAUCO: TcxGridDBColumn;
    cxgGiroDIAUVE: TcxGridDBColumn;
    cxgGiroLevel1: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgItensNIVGIR: TcxGridDBColumn;
    cxgGiroNIVGIR: TcxGridDBColumn;
    pnlMeses: TPanel;
    lblQtdM04: TLabel;
    lblQtdM05: TLabel;
    lblQtdM06: TLabel;
    lblQtdM07: TLabel;
    lblQtdM08: TLabel;
    lblQtdM09: TLabel;
    lblQtdM10: TLabel;
    lblQtdM11: TLabel;
    lblQtdM12: TLabel;
    dbeQtdM04: TDBEditFocus;
    dbeQtdM05: TDBEditFocus;
    dbeQtdM06: TDBEditFocus;
    dbeQtdM07: TDBEditFocus;
    dbeQtdM08: TDBEditFocus;
    dbeQtdM09: TDBEditFocus;
    dbeQtdM10: TDBEditFocus;
    dbeQtdM11: TDBEditFocus;
    dbeQtdM12: TDBEditFocus;
    cxgItensQ_V_04: TcxGridDBColumn;
    cxgItensQ_V_05: TcxGridDBColumn;
    cxgItensQ_V_06: TcxGridDBColumn;
    cxgItensQ_V_07: TcxGridDBColumn;
    cxgItensQ_V_08: TcxGridDBColumn;
    cxgItensQ_V_09: TcxGridDBColumn;
    cxgItensQ_V_10: TcxGridDBColumn;
    cxgItensQ_V_11: TcxGridDBColumn;
    cxgItensQ_V_12: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensQ_V_03CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensVENMESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxgGiroMES001CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES002CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES003CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES004CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES005CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES006CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES007CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES008CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES009CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES010CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES011CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES012CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroVENMESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    intDiaEst: Integer;

    intRecNo: Integer;
    blnEntBrf: Boolean;

    procedure pAfterInsert(Dataset: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pAtualizaCaptions;

    procedure pMostraGiroAnalitico;

    procedure pFormataColunas;
    procedure pAjustaTamanhoDescricao;
    procedure pMostraPedidosVendas;

    procedure pPreparaGeracaoTE;

    procedure pDestacaMes(intMes: Integer; ACanvas: TcxCanvas);

    function fGravaEstoqueMin: Boolean;
    function fRetSQLAtuEstMin: String;
    Function fRetDiasEstoq: Integer;

  public
    { Public declarations }
    pAtualizaMeses: TPrcAtualizaMeses;

    strCodIte: String;
    strDesIte: String;
    strCodUni: String;

    intQtdMes,
    intMosMes: Integer;
    strMeses: String;
    dtaDataBase: TDateTime;
    blnConsMesAtu,
    blnUsaNvGir: Boolean;

    intDiaComGer: Integer;
    intDiaComNvA: Integer;
    intDiaComNvB: Integer;
    intDiaComNvC: Integer;

    cdsPcdDet: TUniClientDataSet;

    blnConGir: Boolean;

    strEmpGir : String;

    Function fRetQtdTotal: Double;
  end;

var
  frmEntDigMultiLojas: TfrmEntDigMultiLojas;

implementation

uses untfuncoesSimples, untEntGiroAnalitico,
    untAltEst, untPedidoAbertoItem, untPreparaGeracaoTE;

{$R *.dfm}

Function TfrmEntDigMultiLojas.fRetQtdTotal: Double;
Begin
  With cdsPcdDet Do
  Begin
    Result := 0;
    First;
    While (Not Eof) Do
    Begin
      Result := Result + FieldByName('ITE_QTDITE').AsFloat;
      Next;
    End;
    First;
  End;
End;

Function TfrmEntDigMultiLojas.fRetDiasEstoq: Integer;
  Var
    fltSaldos, fltMedia: Double;
Begin
  With cdsPcdDet Do
  Begin
    fltSaldos := 0;
    fltMedia  := 0;

    First;
    While (Not Eof) Do
    Begin
      fltSaldos := fltSaldos + FieldByName('ITE_SALDOS').AsFloat;
      fltMedia  := fltMedia  + FieldByName('ITE_MEDIA_').AsFloat;

      Next;
    End;
    First;
  End;

  If fltMedia > 0 Then
    Result := Trunc(fltSaldos / (fltMedia / 30))
  Else
    Result := 0;
End;

procedure TfrmEntDigMultiLojas.FormShow(Sender: TObject);
  Var
    qryCadEmp: TUniQuery;
    intContador: Integer;
    qrySaldos: TUniQuery;
begin
  inherited;

  lblMaDtSa.Visible := blnConGir;
  dbeMaDtSa.Visible := blnConGir;
  lblMaQtSa.Visible := blnConGir;
  dbeMaQtSa.Visible := blnConGir;

  If (intMosMes >= 0) Then
  Begin
    pnlTotais.Height := 38;
    pnlTotais.Top    := 192;
  End;

  If (intMosMes > 6) Then // 12 meses
  Begin
    lblQtdM04.Visible := True;
    lblQtdM05.Visible := True;
    lblQtdM06.Visible := True;
    lblQtdM07.Visible := True;
    lblQtdM08.Visible := True;
    lblQtdM09.Visible := True;
    lblQtdM10.Visible := True;
    lblQtdM11.Visible := True;
    lblQtdM12.Visible := True;

    dbeQtdM04.Visible := True;
    dbeQtdM05.Visible := True;
    dbeQtdM06.Visible := True;
    dbeQtdM07.Visible := True;
    dbeQtdM08.Visible := True;
    dbeQtdM09.Visible := True;
    dbeQtdM10.Visible := True;
    dbeQtdM11.Visible := True;
    dbeQtdM12.Visible := True;

    dbeQtdM04.DataField := 'ITE_Q_V_12';
    dbeQtdM05.DataField := 'ITE_Q_V_11';
    dbeQtdM06.DataField := 'ITE_Q_V_10';
    dbeQtdM07.DataField := 'ITE_Q_V_09';
    dbeQtdM08.DataField := 'ITE_Q_V_08';
    dbeQtdM09.DataField := 'ITE_Q_V_07';
    dbeQtdM10.DataField := 'ITE_Q_V_06';
    dbeQtdM11.DataField := 'ITE_Q_V_05';
    dbeQtdM12.DataField := 'ITE_Q_V_04';

    pnlTotais.Height := 83;
  End

  Else If (intMosMes > 3) Then // 6 meses
  Begin
    pnlTotais.Height := 41;
    pnlTotais.Top    := 192;

    lblQtdM04.Visible := True;
    lblQtdM05.Visible := True;
    lblQtdM06.Visible := True;

    dbeQtdM04.Visible := True;
    dbeQtdM05.Visible := True;
    dbeQtdM06.Visible := True;

    dbeQtdM04.DataField := 'ITE_Q_V_06';
    dbeQtdM05.DataField := 'ITE_Q_V_05';
    dbeQtdM06.DataField := 'ITE_Q_V_04';
  End;

  If intQtdMes > 3 Then
  Begin
    lblQtdM10.Font.Color := clRed;
    lblQtdM11.Font.Color := clRed;
    lblQtdM12.Font.Color := clRed;

    dbeQtdM10.Font.Color := clRed;
    dbeQtdM11.Font.Color := clRed;
    dbeQtdM12.Font.Color := clRed;
  End;

  If intQtdMes > 6 Then
  Begin
    lblQtdM04.Font.Color := clRed;
    lblQtdM05.Font.Color := clRed;
    lblQtdM06.Font.Color := clRed;

    dbeQtdM04.Font.Color := clRed;
    dbeQtdM05.Font.Color := clRed;
    dbeQtdM06.Font.Color := clRed;

    lblQtdM07.Font.Color := clRed;
    lblQtdM08.Font.Color := clRed;
    lblQtdM09.Font.Color := clRed;

    dbeQtdM07.Font.Color := clRed;
    dbeQtdM08.Font.Color := clRed;
    dbeQtdM09.Font.Color := clRed;
  End;

  If (intMosMes = 0) Then
    intMosMes := 3;

  cdsPcdDet.DisableControls;
  cdsPcdDet.Filtered := False;
  cdsPcdDet.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
  cdsPcdDet.Filtered := True;

  {*****************************************}
  {* CASO NÃO TENHA MOVIMENTO DE MULTI-LO- *}
  {* JAS, CRIA O MESMO.                    *}
  {**************************************MV*}
  If (cdsPcdDet.RecordCount <= 0) Then
  Begin
    qrySaldos := fCriaQuery(Self);
    qrySaldos.SQL.Add('SELECT ');
    qrySaldos.SQL.Add('  G.ITE_CODITE, ');
    qrySaldos.SQL.Add('  G.ITE_LOCFIS, ');
    qrySaldos.SQL.Add('  G.ITE_CODEMP, ');
    qrySaldos.SQL.Add('  G.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0) AS ITE_SALDOS, ');
    qrySaldos.SQL.Add('  G.ITE_CPRCEN, ');
    qrySaldos.SQL.Add('  I.ITE_MLTCOM, ');
    qrySaldos.SQL.Add('  U.UNI_ITEFRA, ');
    qrySaldos.SQL.Add('  G.ITE_ESTMIN, ');
    qrySaldos.SQL.Add('  G.ITE_ESTMAX, ');

    If fCfgSis('TIPGIR') = 'S' Then
      qrySaldos.SQL.Add('  G.ITE_NIVGIR AS ITE_NVLGIR, ')
    Else
      qrySaldos.SQL.Add('  I.ITE_NVLGIR, ');

    qrySaldos.SQL.Add('  G.ITE_DTAUVE, ');
    qrySaldos.SQL.Add('  G.ITE_PREUVE, ');
    qrySaldos.SQL.Add('  G.ITE_QTDUVE, ');

    qrySaldos.SQL.Add('  G.ITE_PREULT, ');
    qrySaldos.SQL.Add('  G.ITE_QTDUCO, ');
    qrySaldos.SQL.Add('  G.ITE_FORULT, ');
    qrySaldos.SQL.Add('  UF.FOR_NOMFOR AS ITE_NOMFOR, ');
    qrySaldos.SQL.Add('  G.ITE_DTAULT, ');

    qrySaldos.SQL.Add('  SUM(ROUND(IF(PM.PCD_QTDBAI > PM.PCD_QTDITE, 0, PM.PCD_QTDITE - PM.PCD_QTDBAI), ' + fCfgSis('DEQTPC') + ')) AS ITE_QTDPEN ');

    qrySaldos.SQL.Add('FROM  ');
    qrySaldos.SQL.Add('  ITEGER G');

    qrySaldos.SQL.Add('INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');

    qrySaldos.SQL.Add('LEFT JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ');

    qrySaldos.SQL.Add('LEFT JOIN PCMDET PM ON PM.PCD_CODITE = G.ITE_CODITE AND ');

    qrySaldos.SQL.Add('  (SELECT IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) FROM PCMGER WHERE ');
    qrySaldos.SQL.Add('     PCG_NUMCTN = 0             AND ');
    qrySaldos.SQL.Add('     PCG_NUMPED = PM.PCD_NUMPED AND ');
    qrySaldos.SQL.Add('     PCG_CODEMP = PM.PCD_CODEMP AND ');
    qrySaldos.SQL.Add('     PCG_ESPDOC = PM.PCD_ESPDOC) = G.ITE_CODEMP AND ');

    qrySaldos.SQL.Add('                       ROUND(PM.PCD_QTDITE - PM.PCD_QTDBAI,' + fCfgSis('DEQTPC') + ') > 0 AND ');
    qrySaldos.SQL.Add('                       PM.PCD_NUMCTN = 0 AND ');
    qrySaldos.SQL.Add('                       PM.PCD_BAIXAD = 0 AND ');
    qrySaldos.SQL.Add('                       PM.PCD_ESPDOC = "PD" AND ');
    qrySaldos.SQL.Add('                       (NOT LOCATE(PM.PCD_CODFOR, ' + QuotedStr(fRetForFilialTodos) + ') > 0) ');

    qrySaldos.SQL.Add('  LEFT JOIN CADFOR UF ON UF.FOR_CODFOR = G.ITE_FORULT ');

    qrySaldos.SQL.Add('WHERE ');
    qrySaldos.SQL.Add('  G.ITE_CODITE = :CODITE ');
    If Not fEmptyStr(strEmpGir) Then
      qrySaldos.SQL.Add(' AND LOCATE(G.ITE_CODEMP, ' +  QuotedStr(strEmpGir) + ' ) ');

    qrySaldos.SQL.Add('GROUP BY ');
    qrySaldos.SQL.Add('  G.ITE_CODITE, G.ITE_CODEMP ');

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.Open;

    qryCadEmp := fCriaQuery(Self);
    qryCadEmp.SQL.Add('SELECT ');
    qryCadEmp.SQL.Add('  EMP_CODEMP, ');
    qryCadEmp.SQL.Add('  EMP_NOMEMP ');
    qryCadEmp.SQL.Add('FROM ');
    qryCadEmp.SQL.Add('  CADEMP ');
    If Not fEmptyStr(strEmpGir) Then
      qryCadEmp.SQL.Add(' WHERE LOCATE(EMP_CODEMP, ' +  QuotedStr(strEmpGir) + ' ) ');

    qryCadEmp.Open;
    While (Not qryCadEmp.Eof) Do
    Begin

      cdsPcdDet.Append;
      cdsPcdDet.FieldByName('ITE_CODITE').AsString := strCodIte;
      cdsPcdDet.FieldByName('ITE_CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
      cdsPcdDet.FieldByName('ITE_DESEMP').AsString := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;

      For intContador := 0 To cdsPcdDet.FieldCount -1 Do
      Begin
        If cdsPcdDet.Fields[intContador].DataType = ftFloat Then
          cdsPcdDet.Fields[intContador].AsFloat := 0.0;
      End;

      If (qrySaldos.Locate('ITE_CODITE;ITE_CODEMP',
          VarArrayOf([strCodIte, qryCadEmp.FieldByName('EMP_CODEMP').AsString]), [])) Then
      Begin
        cdsPcdDet.FieldByName('ITE_SALDOS').AsFloat  := qrySaldos.FieldByName('ITE_SALDOS').AsFloat;
        cdsPcdDet.FieldByName('ITE_ESTMIN').AsFloat  := qrySaldos.FieldByName('ITE_ESTMIN').AsFloat;
        cdsPcdDet.FieldByName('ITE_ESTMAX').AsFloat  := qrySaldos.FieldByName('ITE_ESTMAX').AsFloat;
        cdsPcdDet.FieldByName('ITE_MLTCOM').AsFloat  := qrySaldos.FieldByName('ITE_MLTCOM').AsFloat;
        cdsPcdDet.FieldByName('ITE_QTDPEN').AsFloat  := qrySaldos.FieldByName('ITE_QTDPEN').AsFloat;
        cdsPcdDet.FieldByName('ITE_CPRCEN').AsString := qrySaldos.FieldByName('ITE_CPRCEN').AsString;
        cdsPcdDet.FieldByName('ITE_CPCEMO').AsString := IIF(qrySaldos.FieldByName('ITE_CPRCEN').AsString='S', 'C', 'I');
        cdsPcdDet.FieldByName('ITE_LOCFIS').AsString := qrySaldos.FieldByName('ITE_LOCFIS').AsString;
        cdsPcdDet.FieldByName('ITE_ITEFRA').AsString := qrySaldos.FieldByName('UNI_ITEFRA').AsString;
        cdsPcdDet.FieldByName('ITE_NVLGIR').AsString := qrySaldos.FieldByName('ITE_NVLGIR').AsString;
      End;

      pRetCamposGiro(cdsPcdDet,
                     strCodIte,
                     qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                     strMeses,
                     blnUsaNvGir,
                     blnConsMesAtu,
                     intQtdMes,
                     intMosMes,
                     intDiaComGer, intDiaComNvA, intDiaComNvB, intDiaComNvC);

      cdsPcdDet.FieldByName('ITE_VENMES').AsFloat  := fRetVendasMesItem(strCodIte,
                                                              qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                                                              MOnthOf(VS_Date),
                                                              YearOf(VS_Date));

      cdsPcdDet.FieldByName('ITE_PREULT').Value := qrySaldos.FieldByName('ITE_PREULT').Value;
      cdsPcdDet.FieldByName('ITE_QTDUCO').Value := qrySaldos.FieldByName('ITE_QTDUCO').Value;
      cdsPcdDet.FieldByName('ITE_FORULT').Value := qrySaldos.FieldByName('ITE_FORULT').Value;
      cdsPcdDet.FieldByName('ITE_NOMFOR').Value := qrySaldos.FieldByName('ITE_NOMFOR').Value;
      cdsPcdDet.FieldByName('ITE_DTAULT').Value := qrySaldos.FieldByName('ITE_DTAULT').Value;

      If (Not cdsPcdDet.FieldByName('ITE_DTAULT').IsNull) And (cdsPcdDet.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
        cdsPcdDet.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsPcdDet.FieldByName('ITE_DTAULT').AsDateTime);

      cdsPcdDet.FieldByName('ITE_PREUVE').Value := qrySaldos.FieldByName('ITE_PREUVE').Value;
      cdsPcdDet.FieldByName('ITE_QTDUVE').Value := qrySaldos.FieldByName('ITE_QTDUVE').Value;
      cdsPcdDet.FieldByName('ITE_DTAUVE').Value := qrySaldos.FieldByName('ITE_DTAUVE').Value;

      If (Not cdsPcdDet.FieldByName('ITE_DTAUVE').IsNull) And (cdsPcdDet.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
        cdsPcdDet.FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - cdsPcdDet.FieldByName('ITE_DTAUVE').AsDateTime);

      cdsPcdDet.Post;
      qryCadEmp.Next;
    End;

    qryCadEmp.Close;
    FreeAndNil(qryCadEmp);
  End
  {*****************************************}
  {* CASO TENHA MOVIMENTO DE MULTI-LOJAS,  *}
  {* CARREGA O MESMO.                      *}
  {**************************************MV*}
  Else
  Begin
    cdsPcdDet.First;
    While (Not cdsPcdDet.Eof) Do
    Begin
      cdsPcdDet.Edit;
      cdsPcdDet.FieldByName('ITE_QTDTMP').AsFloat := cdsPcdDet.FieldByName('ITE_QTDITE').AsFloat;
      cdsPcdDet.Post;
      cdsPcdDet.Next;
    End;

    cdsPcdDet.First;

  End;

  intDiaEst := fRetDiasEstoq;

  pAtualizaCaptions;

  cdsPcdDet.First;

  cdsPcdDet.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

  cdsPcdDet.EnableControls;

  pFormataColunas;

  cdsPcdDet.AfterInsert := pAfterInsert;
  cdsPcdDet.BeforePost  := pBeforePost;

  dtsPcdDet.DataSet := cdsPcdDet;

  intRecNo := -1;

  cdsPcdDet.First;

  pSetFocus(cxgItens);
  cxgItensQTDITE.Focused := True;

  If Assigned(pAtualizaMeses) Then
  Begin
    pnlTotais.Visible := False;
    cxgGiro.Visible   := True;
    splGrid.Visible   := True;
    cxgGiroView.DataController.DataSource := dtsPcdDet;

  //  pAtualizaMeses(cxgGiroView);
  End;

  If intQtdMes = 0 Then
   pnlTotais.Visible := False;
end;

procedure TfrmEntDigMultiLojas.pAfterInsert(Dataset: TDataSet);
begin
  Dataset.Cancel;
end;

procedure TfrmEntDigMultiLojas.FormCreate(Sender: TObject);
begin
  inherited;
  intQtdMes := 0;
  blnEntBrf := fCfgSis('ENTBRF', varBoolean);
  pAtualizaMeses := Nil;
end;

procedure TfrmEntDigMultiLojas.pAtualizaCaptions;
begin

  While (fEmptyStr(cdsPcdDet.FieldByName('ITE_DESM01').AsString)) And
        (Not cdsPcdDet.Eof)                                       Do
  Begin
    cdsPcdDet.Next;
  End;

  If intQtdMes <> 12 Then
  Begin
    cxgItensQ_V_12.Visible := False;
    cxgItensQ_V_11.Visible := False;
    cxgItensQ_V_10.Visible := False;
    cxgItensQ_V_09.Visible := False;
    cxgItensQ_V_08.Visible := False;
    cxgItensQ_V_07.Visible := False;
    cxgItensQ_V_06.Visible := False;
    cxgItensQ_V_05.Visible := False;
    cxgItensQ_V_04.Visible := False;
  End Else
  Begin
    pnlMeses.Visible := False;
    pnlTotais.Height := 40;
  End;

  If fEmptyStr(cdsPcdDet.FieldByName('ITE_DESM01').AsString) Then
  Begin
    If intQtdMes = 12 Then
    Begin
      cxgItensQ_V_12.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -12));
      cxgItensQ_V_11.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -11));
      cxgItensQ_V_10.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -10));
      cxgItensQ_V_09.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -9));
      cxgItensQ_V_08.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -8));
      cxgItensQ_V_07.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -7));
      cxgItensQ_V_06.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -6));
      cxgItensQ_V_05.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -5));
      cxgItensQ_V_04.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -4));
    End;

    cxgItensQ_V_03.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -3));
    cxgItensQ_V_02.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -2));
    cxgItensQ_V_01.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -1));
  End
  Else
  Begin
    If intQtdMes = 12 Then
    Begin
      cxgItensQ_V_12.Caption := cdsPcdDet.FieldByName('ITE_DESM12').AsString;
      cxgItensQ_V_11.Caption := cdsPcdDet.FieldByName('ITE_DESM11').AsString;
      cxgItensQ_V_10.Caption := cdsPcdDet.FieldByName('ITE_DESM10').AsString;
      cxgItensQ_V_09.Caption := cdsPcdDet.FieldByName('ITE_DESM09').AsString;
      cxgItensQ_V_08.Caption := cdsPcdDet.FieldByName('ITE_DESM08').AsString;
      cxgItensQ_V_07.Caption := cdsPcdDet.FieldByName('ITE_DESM07').AsString;
      cxgItensQ_V_06.Caption := cdsPcdDet.FieldByName('ITE_DESM06').AsString;
      cxgItensQ_V_05.Caption := cdsPcdDet.FieldByName('ITE_DESM05').AsString;
      cxgItensQ_V_04.Caption := cdsPcdDet.FieldByName('ITE_DESM04').AsString;
    End;

    cxgItensQ_V_03.Caption := cdsPcdDet.FieldByName('ITE_DESM03').AsString;
    cxgItensQ_V_02.Caption := cdsPcdDet.FieldByName('ITE_DESM02').AsString;
    cxgItensQ_V_01.Caption := cdsPcdDet.FieldByName('ITE_DESM01').AsString;
  End;

  If (intMosMes > 6) Then
  Begin
    lblQtdM04.Caption := cdsPcdDet.FieldByName('ITE_DESM12').AsString;
    lblQtdM05.Caption := cdsPcdDet.FieldByName('ITE_DESM11').AsString;
    lblQtdM06.Caption := cdsPcdDet.FieldByName('ITE_DESM10').AsString;
    lblQtdM07.Caption := cdsPcdDet.FieldByName('ITE_DESM09').AsString;
    lblQtdM08.Caption := cdsPcdDet.FieldByName('ITE_DESM08').AsString;
    lblQtdM09.Caption := cdsPcdDet.FieldByName('ITE_DESM07').AsString;
    lblQtdM10.Caption := cdsPcdDet.FieldByName('ITE_DESM06').AsString;
    lblQtdM11.Caption := cdsPcdDet.FieldByName('ITE_DESM05').AsString;
    lblQtdM12.Caption := cdsPcdDet.FieldByName('ITE_DESM04').AsString;
  End

  Else If (intMosMes > 3) Then
  Begin
    lblQtdM04.Caption := cdsPcdDet.FieldByName('ITE_DESM06').AsString;
    lblQtdM05.Caption := cdsPcdDet.FieldByName('ITE_DESM05').AsString;
    lblQtdM06.Caption := cdsPcdDet.FieldByName('ITE_DESM04').AsString;
  End;

  If Not blnUsaNvGir Then
  Begin
    cxgItensMEDIXX.Caption := 'Media ' + IntToStr(intDiaComGer);
  End

  Else If cdsPcdDet.FieldByName('ITE_NVLGIR').AsString = 'A' Then
  Begin
    cxgItensMEDIXX.Caption := 'Media ' + IntToStr(intDiaComNvA)
  End

  Else If cdsPcdDet.FieldByName('ITE_NVLGIR').AsString = 'B' Then
  Begin
    cxgItensMEDIXX.Caption := 'Media ' + IntToStr(intDiaComNvB)
  End

  Else If cdsPcdDet.FieldByName('ITE_NVLGIR').AsString = 'C' Then
  Begin
    cxgItensMEDIXX.Caption := 'Media ' + IntToStr(intDiaComNvC);
  End;
end;

procedure TfrmEntDigMultiLojas.pMostraGiroAnalitico;
  Var
    cdsGiroAna: TUniClientDataSet;
begin

  Screen.Cursor := crHourGlass;

  cdsGiroAna := fCalculaGiroAnalitico(dtaDataBase,
                                      strCodIte,
                                      cdsPcdDet.FieldByName('ITE_CODEMP').AsString,
                                      intQtdMes);

  Screen.Cursor := crDefault;

  Try
    pCriarFormularios(TfrmEntGiroAnalitico, frmEntGiroAnalitico);
    frmEntGiroAnalitico.dtsGiro.DataSet := cdsGiroAna;
    frmEntGiroAnalitico.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntDigMultiLojas.pMostraGiroAnalitico]');
    End;
  End;

  pFreeAndNil(frmEntGiroAnalitico);

end;

procedure TfrmEntDigMultiLojas.pMostraPedidosVendas;
begin
  Try
    pCriarFormularios(TfrmPedidoAbertoItem, frmPedidoAbertoItem);
    frmPedidoAbertoItem.strCodIte := strCodIte;
    frmPedidoAbertoItem.Caption   := frmPedidoAbertoItem.Caption + ': ' + strCodIte + ' - ' +
                                                                          fRetNomProduto(strCodIte) + ' - ' +
                                                                          strCodUni;
    frmPedidoAbertoItem.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmPedidoAbertoItem);
end;

procedure TfrmEntDigMultiLojas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsPcdDet.AfterPost   := Nil;
  cdsPcdDet.AfterInsert := Nil;
  cdsPcdDet.BeforePost  := Nil;
  cdsPcdDet.AfterScroll := Nil;

  cdsPcdDet.ReadOnly := False;
end;

procedure TfrmEntDigMultiLojas.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If cdsPcdDet.State In [dsEdit] Then
    cdsPcdDet.Post;
  
  If (fGravaEstoqueMin) Then
    ModalResult := mrOk;
end;

procedure TfrmEntDigMultiLojas.pBeforePost(DataSet: TDataSet);
  Var
    blnTravar: Boolean;
    fltQtdTra: Double;
begin

  blnTravar := False;
  fltQtdTra := 0.0;

  If DataSet.FieldByName('ITE_CPRCEN').AsString = 'S' Then
  Begin

    If (DataSet.FieldByName('ITE_CODEMP').AsString <> fCfgSis('EMPMAT')) And
       (DataSet.FieldByName('ITE_QTDITE').AsFloat > 0)                   And
       (Not fLiberaCompraCentralizada(DataSet.FieldByName('ITE_CODITE').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Produto com compra centralizada.' + #13#10 +
                            'Somente a matriz pode incluí-lo no pedido de compra.', ['&Ok']);
      DataSet.FieldByName('ITE_QTDITE').Value := 0;
      Exit;
    End;

  End;

  If (DataSet.FieldByName('ITE_QTDBAI').AsFloat > 0.0) Then
  Begin
    If (DataSet.FieldByName('ITE_QTDITE').AsFloat < DataSet.FieldByName('ITE_QTDBAI').AsFloat) Then
    Begin
      blnTravar := True;
      fltQtdTra := DataSet.FieldByName('ITE_QTDBAI').AsFloat;
    End;
  End
  Else
  Begin
    If (DataSet.FieldByName('ITE_QTDITE').AsFloat < 0.0) Then
    Begin
      blnTravar := True;
      fltQtdTra := 0.0;
    End;
  End;

  If (DataSet.FieldByName('ITE_ESTMIN').AsFloat < 0.0) Then
  Begin
    pMensagemOk('O Estoque mínimo deve ser maior ou igual a zero!');
    Abort;
    Exit;
  End;

  If (DataSet.FieldByName('ITE_ESTMAX').AsFloat < 0.0) Then
  Begin
    pMensagemOk('O Estoque máximo deve ser maior ou igual a zero!');
    Abort;
    Exit;
  End;

  If (DataSet.FieldByName('ITE_ESTMIN').AsFloat > DataSet.FieldByName('ITE_ESTMAX').AsFloat) Then
  Begin
    pMensagemOk('O Estoque máximo deve ser maior ou igual ao estoque mínimo!');
    Abort;
    Exit;
  End;

  If (blnTravar) Then
  Begin
    fMensagem('ATENÇÃO!', 'A quantidade não pode ser menor que ' + FloatToStrF(fltQtdTra, ffNumber, 12, 2), ['&Ok']);
    DataSet.FieldByName('ITE_QTDITE').AsFloat := DataSet.FieldByName('ITE_QTDITE').OldValue;
    Abort;
  End;

end;

procedure TfrmEntDigMultiLojas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intPos: Integer;
begin
  inherited;

  Case Key Of
    VK_ESCAPE: btnSair.Click;
    VK_F2    : pMostraGiroAnalitico;
    VK_F3    : pMostraPedidosVendas;
    VK_F5    : pPreparaGeracaoTE;

    VK_RETURN: If (cdsPcdDet.State = dsEdit) Or (intRecNo = cdsPcdDet.RecNo) Then
               Begin
                 intRecNo := -1;

                 intPos := cdsPcdDet.RecNo;
                 cxgItensView.NavigatorButtons.Next.Click;

                 If intPos = cdsPcdDet.RecNo Then
                   pSetFocus(btnConfirmaDados)
               End

               Else intRecNo := cdsPcdDet.RecNo;


    VK_F10: Begin
              Key := 0;
              btnConfirmaDados.Click;
            End;
  End;

end;

procedure TfrmEntDigMultiLojas.FormResize(Sender: TObject);
  Var
    intColWid: Integer;
begin
  inherited;

  If Self.ClientWidth <= 800 Then
  Begin
    cxgItensDESEMP.Width := 70
  End Else
  Begin
    intColWid := 70 + Self.ClientWidth - 800;

    If intColWid > 300 Then
      intColWid := 300
    Else If intColWid < 70 Then
      intColWid := 70;

    cxgItensDESEMP.Width := intColWid;
  End;

  If Self.Width < Screen.Width Then
  Begin
    Self.Left := (Screen.Width  - Self.Width ) Div 2;
    Self.Top  := (Screen.Height - Self.Height) Div 2;
  End;

end;

procedure TfrmEntDigMultiLojas.cxgGiroMES001CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(12, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES002CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(11, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES003CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(10, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES004CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(9, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES005CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(8, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES006CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(7, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES007CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(6, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES008CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(5, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES009CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(4, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES010CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(3, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES011CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(2, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroMES012CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(1, ACanvas);
end;

procedure TfrmEntDigMultiLojas.cxgGiroVENMESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If blnConsMesAtu Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmEntDigMultiLojas.cxgItensQ_V_03CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Font.Color := clRed;
end;

procedure TfrmEntDigMultiLojas.cxgItensVENMESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if blnConsMesAtu Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmEntDigMultiLojas.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                          cxgItensCODEMP.Index]) = VS_strCodEmp Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
  End;
end;

procedure TfrmEntDigMultiLojas.cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;

  AText := IntToStr(intDiaEst);
end;

procedure TfrmEntDigMultiLojas.pAjustaTamanhoDescricao;
  var
    intColumn: Integer;
    intTamUti: Integer;
begin
  intTamUti := 0;
  For intColumn := 0 To cxgItensView.ColumnCount -1 Do
    With cxgItensView.Columns[intColumn] Do
      If Visible And (cxgItensView.Columns[intColumn] <> cxgItensDESEMP) Then
        Inc(intTamUti, Width);

  cxgItensDESEMP.Width := Min(cxgItens.Width - intTamUti - 50, 300);
end;

procedure TfrmEntDigMultiLojas.pFormataColunas;
begin
(*  For intContador := 3 To dbgItens.Columns.Count -1 Do
  Begin
    fldCampo := cdsPcdDet.FieldByName(dbgItens.Columns[intContador].FieldName);
    TFloatField(fldCampo).DisplayFormat := '#0';
  End;

  cdsPcdDet.First;
  While (Not cdsPcdDet.Eof) Do
  Begin

    For intContador := 3 To dbgItens.Columns.Count -1 Do
    Begin

      fldCampo := cdsPcdDet.FieldByName(dbgItens.Columns[intContador].FieldName);
      If (fldCampo.FieldName <> 'ITE_QTDITE') Then
      Begin
        If Frac(fldCampo.AsFloat) > 0 Then
        Begin
          TFloatField(fldCampo).DisplayFormat := '#,##0.00';
        End;
      End
      Else
      Begin
        TFloatField(fldCampo).DisplayFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));
      End;

    End;

    cdsPcdDet.Next;
  End;
*)

  TcxCustomCurrencyEditProperties(cxgItensQTDITE.Properties).DecimalPlaces := fCfgSis('DEQTPC', varInteger);

  pAjustaTamanhoDescricao;
end;

function TfrmEntDigMultiLojas.fGravaEstoqueMin: Boolean;
Var
  cdsItePed: TUniClientDataSet;
  strSQL   : String;
  qryEst   : TUniQuery;
begin

  Result := False;

  Try

    cdsItePed := TUniClientDataSet.Create(Self);
    qryEst    := fCriaQuery(Self);
    strSQL    := fRetSQLAtuEstMin;

    cdsItePed.Data := cdsPcdDet.Data;
    cdsItePed.Filter   := 'ITE_CODITE = ' + QuotedStr(strcodite);
    cdsItePed.Filtered := True;

    fStartTransaction;

    With cdsItePed Do
    Begin
      First;

      While Not Eof Do
      Begin
        If (FieldByName('ITE_ESTMIN').Value <> FieldByName('ITE_ESTMIN').OldValue) Or
           (FieldByName('ITE_ESTMAX').Value <> FieldByName('ITE_ESTMAX').OldValue) Then
          TAltEst.fGravaLog(Self,
                            FieldByName('ITE_CODITE').AsString,
                            FieldByName('ITE_CODEMP').AsString,
                            FieldByName('ITE_ESTMIN').AsFloat,
                            FieldByName('ITE_ESTMAX').AsFloat,
                            True,
                            False);

        qryEst.Close;
        qryEst.SQL.Clear;
        qryEst.SQL.Add(strSQL);
        qryEst.ParamByName('ESTMIN').AsFloat  := FieldByName('ITE_ESTMIN').AsFloat;
        qryEst.ParamByName('ESTMAX').AsFloat  := FieldByName('ITE_ESTMAX').AsFloat;
        qryEst.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        qryEst.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
        qryEst.ExecSQL;
        Next;
      End;
    End;

    fCommit;
    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmEntDigMultiLojas.fGravaEstoqueMin]');
    End;
  End;

  FreeAndNil(cdsItePed);
  FreeAndNil(qryEst);

end;

function TfrmEntDigMultiLojas.fRetSQLAtuEstMin: String;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'UPDATE   ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'SET      ';
  strSQL := strSQL + '  ITE_ESTMIN = :ESTMIN, ';
  strSQL := strSQL + '  ITE_ESTMAX = :ESTMAX  ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP     ';

  Result := strSQL;

end;

procedure TfrmEntDigMultiLojas.pPreparaGeracaoTE;
  Var
    objPreparaGer: TPreparaGeracaoTE;
begin
  inherited;

  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;

  objPreparaGer := TPreparaGeracaoTE.Create;
  objPreparaGer.pInformaPreparacao(strCodIte);

  FreeAndNil(objPreparaGer);
end;

procedure TfrmEntDigMultiLojas.pDestacaMes(intMes: Integer; ACanvas: TcxCanvas);
Begin
  If (intMes <= intQtdMes) Then
    ACanvas.Font.Color := clRed;
End;

end.
