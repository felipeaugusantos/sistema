unit untCalNivGirEstFornecGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, dxCore,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Grids, DBGrids, Mask, DBCtrls, DBEditFocus, ComCtrls,
  BitBtnLockedIncrem, EditFocus, untZClient, cxCurrencyEdit,
  DBClient, Math, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade, Uni, untParCalculaPrecoCusto, untTConfiguracao,
  Vcl.CheckLst, cxCheckBox;

type
  TrecTabPreVen = record
    fltPreven: Double;
    fltMargem: Double;
    fltPreven_New: Double;
    fltMargem_New: Double;
  End;

  TArrTabPreven = array [1..7] of TrecTabPreVen;

  TfrmCalNivGirEstFornecGrid = class(TfrmPaiEdit)
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    dtsItens: TDataSource;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensPRECUS: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensViewColumn8: TcxGridDBColumn;
    cxgItensViewColumn9: TcxGridDBColumn;
    cxgItensViewColumn10: TcxGridDBColumn;
    cxgItensViewColumn11: TcxGridDBColumn;
    cxgItensViewColumn12: TcxGridDBColumn;
    cxgItensNVLFOR: TcxGridDBColumn;
    cxgItensViewColumn14: TcxGridDBColumn;
    cxgItensViewColumn15: TcxGridDBColumn;
    Panel1: TPanel;
    DBEditFocus1: TDBEditFocus;
    Label1: TLabel;
    DBEditFocus2: TDBEditFocus;
    prgProgresso: TProgressBar;
    btnGravar: TBitBtnLocked;
    cxgItensCODGRP: TcxGridDBColumn;
    Panel2: TPanel;
    Label2: TLabel;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    edtTabFor: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtForPri: TEditFocus;
    Label5: TLabel;
    edtIteGer: TEditFocus;
    Label6: TLabel;
    edtQtdVen: TEditFocus;
    Label7: TLabel;
    edtTotVen: TEditFocus;
    cxgItensSITPRO: TcxGridDBColumn;
    btnGraMkp: TBitBtnLocked;
    cxgItensPERMKP: TcxGridDBColumn;
    cxgItensPREVEN: TcxGridDBColumn;
    cxgItensPREREV: TcxGridDBColumn;
    btnInfMkp: TBitBtnLocked;
    btnExcel: TBitBtnLocked;
    cxgItensViewPREVE1: TcxGridDBColumn;
    cxgItensViewPREVE2: TcxGridDBColumn;
    cxgItensViewPREVE3: TcxGridDBColumn;
    cxgItensViewPREVE4: TcxGridDBColumn;
    cxgItensViewPREVE5: TcxGridDBColumn;
    cxgItensViewPREVE6: TcxGridDBColumn;
    cxgItensViewPREVE7: TcxGridDBColumn;
    cxgItensViewTABPR1: TcxGridDBColumn;
    cxgItensViewTABPR2: TcxGridDBColumn;
    cxgItensViewTABPR3: TcxGridDBColumn;
    cxgItensViewTABPR4: TcxGridDBColumn;
    cxgItensViewTABPR5: TcxGridDBColumn;
    cxgItensViewTABPR6: TcxGridDBColumn;
    cxgItensViewTABPR7: TcxGridDBColumn;
    lblTabSelecionada: TLabel;
    cxgItensViewPREVE1_OLD: TcxGridDBColumn;
    cxgItensViewPREVE2_OLD: TcxGridDBColumn;
    cxgItensViewPREVE3_OLD: TcxGridDBColumn;
    cxgItensViewPREVE4_OLD: TcxGridDBColumn;
    cxgItensViewPREVE5_OLD: TcxGridDBColumn;
    cxgItensViewPREVE6_OLD: TcxGridDBColumn;
    cxgItensViewPREVE7_OLD: TcxGridDBColumn;
    cxgItensATU_CADPRO: TcxGridDBColumn;
    Label8: TLabel;
    Label9: TLabel;
    pnlTabelasAtivas: TPanel;
    chkTabelasAtivas: TCheckListBox;
    Panel4: TPanel;
    Shape1: TShape;
    Label10: TLabel;
    Shape2: TShape;
    Label11: TLabel;
    cxgItensViewPRECUS: TcxGridDBColumn;
    cxgItensViewPRECU1: TcxGridDBColumn;
    cxgItensViewPRECU2: TcxGridDBColumn;
    cxgItensViewPRECU3: TcxGridDBColumn;
    cxgItensViewPRECU4: TcxGridDBColumn;
    cxgItensViewPRECU5: TcxGridDBColumn;
    cxgItensViewPRECU6: TcxGridDBColumn;
    cxgItensViewPRECU7: TcxGridDBColumn;
    pnlCalculo: TPanel;
    lblDadosExibidos: TLabel;
    chkExibirCalculo: TCheckBox;
    memCalculo: TRichEdit;
    memFormula: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure pValidaCor(Sender: TcxCustomGridTableView; var ACanvas: TcxCanvas; ColumAtiva: TcxGridDBColumn; RecordIndex, ColIndex: Integer);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGraMkpClick(Sender: TObject);
    procedure btnInfMkpClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgItensViewPREVE1GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgItensViewFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure chkExibirCalculoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    qryCadIte: TUniQuery;
    qryIteFor: TUniQuery;
    qryTabDet: TUniQuery;
    qryTabelaPreco: TUniQuery;
    fltFatRev: Double;

    strFrmCus :String;
    blnSufram :Boolean;
    cpcParams: TParCalculaPrecoCusto;
    strAgrupadorPreAlt: String;
    ArrTabPreven: TArrTabPreven;
    strID: String;
    strDataFieldMemCalc: String;
    strDataFieldMemForm: String;
    blnArrUlt: Boolean;
    FblnProcessando: Boolean;
    FblnGridHabilitado: Boolean;
    FblnTabelasHabilitado: Boolean;

    Function fGravaNivelGiro: Boolean;

    Procedure pGeraExcel;
    Procedure pBeforePost(dtsDataSet: TDataSet);
    Procedure pBeforePost2(dataSet: TDataSet);

    Procedure pUpdateNivelC;
    procedure pMostraColunasMarkup(blnMostrar: Boolean);

    Procedure pUpdateNivel;
    function fRetTabPrdIndex(ColumAtiva:TcxGridDBColumn): Integer;

    function fRetPrecoCusto(intTabela: Integer;dataSet: TDataSet; blnCnvCus: Boolean): Double;


    Function fRetTotalQtdVendida: Double;
    Function fRetTotalVendido: Double;
    function fPedeDadosMarkup: Boolean;
    function fGravaMarkup: Boolean;
    function fAtualizaDetCus(strIncDet: String; strTabela: Integer;  AfltMarge, AfltVenda: Double): Boolean;

    function fCheckedLista(intTabela: integer): Boolean;
    function fAtualizaIteger(strTabela: String;AStrCodIte: String; AstrEmpAtu: String; AfltPreve, AfltMarBru: Double): Boolean;
    procedure pPreenchaMatriz(intTabela: Integer; AfltPreve, AfltMarBru: Double);
    procedure pIniciaMatriz(AStrCodIte: String; AstrEmpAtu: String);
    procedure pGravaPreAlt(strCodIte: String; fltPreCus, fltPrecom: Double);

    function fCompletaMarkup: Boolean;

    function fAtualizaIteFor(strAutInc: String; fltMarBru, fltPreVen, fltPreRev: Double): Boolean;
    procedure pMarcaDesmarca(blnMarca: Boolean);
    function fExisteTabelaMarcada: Boolean;
    procedure pIniciaProcessamento;
    procedure pFinalizaProcessamento;

  public
    { Public declarations }
    blnPorGru: Boolean;
    strCodFor: String;
    strCodTab: String;
    cdsCadGrp: TZClient;
    strEmpAtu: String;
    strDtaIni: String;
    strDtaFin: String;
    function CloseQuery: Boolean; override;
  end;

var
  frmCalNivGirEstFornecGrid: TfrmCalNivGirEstFornecGrid;

implementation

{$R *.dfm}

Uses
  StrUtils, untTabelaPreco, untFuncoesSimples,
  untGeraExcel, untCalNivGirEstFornecMarkup, untDllOpeProd,
  untDllOpeProdFuncoes, untPreAlt, untPreAlt_Trigger,
  untTMemoriaCalculoPrecoVendaMargem, System.UITypes;

Procedure TfrmCalNivGirEstFornecGrid.pBeforePost(dtsDataSet: TDataSet);
Begin
  With dtsDataSet Do
  Begin
    If dtsItens.DataSet.FieldByName('ATUPRO').AsInteger = 1 then
    Begin
      If (dtsDataSet.FieldByName('ITE_TABPR1').AsString <> strCodTab) And
         (dtsDataSet.FieldByName('ITE_TABPR2').AsString <> strCodTab) And
         (dtsDataSet.FieldByName('ITE_TABPR3').AsString <> strCodTab) And
         (dtsDataSet.FieldByName('ITE_TABPR4').AsString <> strCodTab) And
         (dtsDataSet.FieldByName('ITE_TABPR5').AsString <> strCodTab) And
         (dtsDataSet.FieldByName('ITE_TABPR6').AsString <> strCodTab) And
         (dtsDataSet.FieldByName('ITE_TABPR7').AsString <> strCodTab) Then
      dtsDataSet.FieldByName('ATUPRO').AsInteger := 0;
    End;

    If blnPorGru Then
    Begin
      Fieldbyname('NVLFOR').AsString := UpperCase(Fieldbyname('NVLFOR').AsString);

      If (Length(Fieldbyname('NVLFOR').AsString) = 1) Then
      Begin

        If Pos(Fieldbyname('NVLFOR').AsString, 'ABC') <= 0 Then
        Begin
          pMensagemOk('O Nível de Giro dever ser A, B ou C ou ter o formato A99999 - B99999 - C99999 !');
          Cancel;
          Abort;
        End

      End

      Else If (Length(Fieldbyname('NVLFOR').AsString) <> 6) Or
              (Pos(Fieldbyname('NVLFOR').AsString[1], 'ABC') <= 0) Or
              (StrToIntDef(RightStr(Fieldbyname('NVLFOR').AsString, 5), -1) < 1) Then
      Begin
        pMensagemOk('O Nível de Giro dever ser A, B ou C ou ter o formato A99999 - B99999 - C99999 !');
        Cancel;
        Abort;
      End

    End Else
    Begin

      If (Length(Fieldbyname('NVLFOR').AsString) <= 1) Then
      Begin
        if Pos(Fieldbyname('NVLFOR').AsString, 'ABC') <= 0 Then
        Begin
          pMensagemOk('O Nível de Giro deve ser A, B ou C');
          Cancel;
          Abort;
        End
      End Else
      Begin
        if Pos(Fieldbyname('NVLFOR').AsString[1], 'ABC') <= 0 Then
        Begin
          pMensagemOk('O Nível de Giro deve ser A, B ou C');
          Cancel;
          Abort;
        End
      End;

    End;

    If cxgItensPREVEN.Focused Then
    Begin

      FieldByName('MARBRU').AsFloat := RoundTo(fCalculaPrecoVenda(2,
                                                FieldByName('PRECUS_CNV').AsFloat,
                                                FieldByName('PREVEN_CNV').AsFloat,
                                                FieldByName('MARBRU').AsFloat,
                                                FieldByName('ICMSAI').AsFloat,
                                                FieldByName('IMPFED').AsFloat,
                                                FieldByName('DESOPE').AsFloat,
                                                FieldByName('COMTBL').AsFloat), -2);

    End Else
    Begin

      FieldByName('PREVEN_CNV').AsFloat := RoundTo(fCalculaPrecoVenda(1,
                                                FieldByName('PRECUS_CNV').AsFloat,
                                                FieldByName('PREVEN_CNV').AsFloat,
                                                FieldByName('MARBRU').AsFloat,
                                                FieldByName('ICMSAI').AsFloat,
                                                FieldByName('IMPFED').AsFloat,
                                                FieldByName('DESOPE').AsFloat,
                                                FieldByName('COMTBL').AsFloat), -2);

    End;

    FieldByName('PREREV_CNV').AsFloat :=  RoundTo(fltFatRev * FieldByName('PREVEN_CNV').AsFloat, -2);

    FieldByName('PREVEN').AsFloat := RoundTo(FieldByName('PREVEN_CNV').AsFloat * IfThen(FieldByName('CNVCUS').AsFloat = 0, 1, FieldByName('CNVCUS').AsFloat), -2);

    FieldByName('PREREV').AsFloat := RoundTo(FieldByName('PREREV_CNV').AsFloat * IfThen(FieldByName('CNVCUS').AsFloat = 0, 1, FieldByName('CNVCUS').AsFloat), -2);

  End;
End;

Procedure TfrmCalNivGirEstFornecGrid.pUpdateNivelC;
  Var
    qryNivelC: TUniQuery;
Begin
  qryNivelC := fCriaQuery;

  pnlInfo.Caption := 'Atualizando Nível C';
  pnlInfo.Color   := clYellow;
  Application.ProcessMessages;

  With qryNivelC, SQL Do
  Begin
    Clear;
    Add('UPDATE CADITE SET ITE_NVLFOR = ');

    If blnPorGru Then
      Add('"C99999"')
    Else
      Add('"C"');

    If Not fEmptyStr(strCodFor) Then
    Begin
      Add('WHERE ITE_CODFOR = ' + QuotedStr(strCodFor));
    End;

    ExecSQL;
  End;

  FreeAndNil(qryNivelC);

  pnlInfo.Color   := clBtnFace;
  pnlInfo.Caption := '';
  Application.ProcessMessages;
End;

Procedure TfrmCalNivGirEstFornecGrid.pUpdateNivel;
Begin
  With qryCadIte Do
  Begin
    Close;
    ParamByName('NVLGIR').AsString := dtsItens.DataSet.fieldbyname('NVLFOR').AsString;
    ParamByName('CODITE').AsString := dtsItens.DataSet.fieldbyname('CODITE').AsString;
    ExecSQL;
  End;
End;


function TfrmCalNivGirEstFornecGrid.fRetTabPrdIndex(ColumAtiva:TcxGridDBColumn): Integer;
begin
  Result := -1;
  If Not ((ColumAtiva = cxgItensViewPREVE1) Or
          (ColumAtiva = cxgItensViewPREVE2) Or
          (ColumAtiva = cxgItensViewPREVE3) Or
          (ColumAtiva = cxgItensViewPREVE4) Or
          (ColumAtiva = cxgItensViewPREVE5) Or
          (ColumAtiva = cxgItensViewPREVE6) Or
          (ColumAtiva = cxgItensViewPREVE7)) Then
  Exit(-1);

  If ColumAtiva = cxgItensViewPREVE1 Then
    Result := cxgItensViewTABPR1.Index
  Else if ColumAtiva = cxgItensViewPREVE2 Then
    Result := cxgItensViewTABPR2.Index
  Else If ColumAtiva = cxgItensViewPREVE3 Then
    Result := cxgItensViewTABPR3.Index
  Else If ColumAtiva = cxgItensViewPREVE4 Then
    Result := cxgItensViewTABPR4.Index
  Else If ColumAtiva = cxgItensViewPREVE5 Then
    Result := cxgItensViewTABPR5.Index
  Else If ColumAtiva = cxgItensViewPREVE6 Then
    Result := cxgItensViewTABPR6.Index
  Else If ColumAtiva = cxgItensViewPREVE7 Then
    Result := cxgItensViewTABPR7.Index ;
End;




procedure TfrmCalNivGirEstFornecGrid.pValidaCor(Sender: TcxCustomGridTableView; var ACanvas: TcxCanvas; ColumAtiva: TcxGridDBColumn; RecordIndex, ColIndex: Integer);
Begin
  If Not ((ColumAtiva = cxgItensViewPREVE1) Or
          (ColumAtiva = cxgItensViewPREVE2) Or
          (ColumAtiva = cxgItensViewPREVE3) Or
          (ColumAtiva = cxgItensViewPREVE4) Or
          (ColumAtiva = cxgItensViewPREVE5) Or
          (ColumAtiva = cxgItensViewPREVE6) Or
          (ColumAtiva = cxgItensViewPREVE7)) Then
    Exit;

  If (Sender.DataController.Values[RecordIndex, ColIndex] = strCodTab) Then
    ACanvas.Brush.Color := clMoneyGreen
  Else
    ACanvas.Brush.Color := cl3DLight;
End;

procedure TfrmCalNivGirEstFornecGrid.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If strID <> '' Then
    lblDadosExibidos.Caption := 'Preço de Venda('+strID+') - Item: '  + cxgItensView.DataController.DataSet.FieldByName('CODITE').AsString
  Else
    lblDadosExibidos.Caption := 'Preço de Venda da Tabela de Preço do Fornecedor - Item: '  + cxgItensView.DataController.DataSet.FieldByName('CODITE').AsString;


  memCalculo.Text := cxgItensView.DataController.DataSet.FieldByName(strDataFieldMemCalc).AsString;
  memFormula.Text := cxgItensView.DataController.DataSet.FieldByName(strDataFieldMemForm).AsString;
end;

procedure TfrmCalNivGirEstFornecGrid.chkExibirCalculoClick(Sender: TObject);
begin
  inherited;
  pnlCalculo.Visible := chkExibirCalculo.Checked;
  memFormula.Width := Trunc(Self.Width/2);
  If pnlCalculo.Visible Then
    cdsItensAfterScroll(cxgItensView.DataController.DataSet);

end;

procedure TfrmCalNivGirEstFornecGrid.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var Index: integer;
begin
  inherited;

  If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;

  Index := fRetTabPrdIndex(TcxGridDBColumn(AViewInfo.Item));
  If Index > -1 Then
    pValidaCor(Sender, ACanvas, TcxGridDBColumn(AViewInfo.Item), AViewInfo.GridRecord.RecordIndex, Index);

  If ((AViewInfo.Item = cxgItensViewPREVE1_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR1.Index] <> strCodTab)) Or
     ((AViewInfo.Item = cxgItensViewPREVE2_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR2.Index] <> strCodTab)) Or
     ((AViewInfo.Item = cxgItensViewPREVE3_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR3.Index] <> strCodTab)) Or
     ((AViewInfo.Item = cxgItensViewPREVE4_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR4.Index] <> strCodTab)) Or
     ((AViewInfo.Item = cxgItensViewPREVE5_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR5.Index] <> strCodTab)) Or
     ((AViewInfo.Item = cxgItensViewPREVE6_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR6.Index] <> strCodTab)) Or
     ((AViewInfo.Item = cxgItensViewPREVE7_OLD) And (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTABPR7.Index] <> strCodTab)) Then
    ACanvas.Brush.Color := cl3DLight;

end;

procedure TfrmCalNivGirEstFornecGrid.cxgItensViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  strID := '';
  strDataFieldMemCalc := 'CALCULO';
  strDataFieldMemForm := 'FORMULA';
  If chkExibirCalculo.Checked Then
  begin
    If AFocusedItem  = cxgItensViewPREVE1 then
      strID := '1'
    Else If AFocusedItem  = cxgItensViewPREVE2 then
      strID := '2'
    Else If AFocusedItem  = cxgItensViewPREVE3 then
      strID := '3'
    Else If AFocusedItem  = cxgItensViewPREVE4 then
      strID := '4'
    Else If AFocusedItem  = cxgItensViewPREVE5 then
      strID := '5'
    Else If AFocusedItem  = cxgItensViewPREVE6 then
      strID := '6'
    Else If AFocusedItem  = cxgItensViewPREVE7 then
      strID := '7';

    strDataFieldMemCalc := 'CALCULO'    + strID;
    strDataFieldMemForm := 'FORMULA'    + strID;

    memCalculo.Text := cxgItensView.DataController.DataSet.FieldByName(strDataFieldMemCalc).AsString;
    memFormula.Text := cxgItensView.DataController.DataSet.FieldByName(strDataFieldMemForm).AsString;



  End;
  If strID <> '' Then
    lblDadosExibidos.Caption := 'Preço de Venda('+strID+') - Item: '  + cxgItensView.DataController.DataSet.FieldByName('CODITE').AsString
  Else
    lblDadosExibidos.Caption := 'Preço de Venda da Tabela de Preço do Fornecedor - Item: '  + cxgItensView.DataController.DataSet.FieldByName('CODITE').AsString
end;

procedure TfrmCalNivGirEstFornecGrid.cxgItensViewPREVE1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText <> '' Then
    If StrToFloat(AText) = 0 Then
      AText := '';

end;


Function TfrmCalNivGirEstFornecGrid.fGravaNivelGiro: Boolean;
Begin

  With dtsItens.DataSet Do
  Begin

    Try
      Try
        DisableControls;

        prgProgresso.Max      := RecordCount;
        prgProgresso.Position := 0;
        prgProgresso.Visible  := True;

        pUpdateNivelC;

        First;
        While Not Eof Do
        Begin
          pUpdateNivel;

          Next;

          prgProgresso.StepBy(1);
          Application.ProcessMessages;
        End;

        Result := True;

      Except
        On E: Exception Do
        Begin
           Result := False;
          pMensagensErro(E.Message, 'TfrmCalNivGirEstFornecGrid.fGravaNivelGiro');
        End;
      End;
    Finally
      prgProgresso.Visible := False;
      EnableControls;
    End;
  End;

  cxgItensView.NavigatorButtons.First.Click;
End;

procedure TfrmCalNivGirEstFornecGrid.FormCreate(Sender: TObject);
var i: integer;
begin
  inherited;
  strAgrupadorPreAlt := '';
  strFrmCus := fCfgSis('FRMCUS', varString);
  blnSufram := fCfgSis('SUFRAM', varBoolean);

  strDataFieldMemCalc := 'CALCULO';
  strDataFieldMemForm := 'FORMULA';
  strID := '';

  qryTabelaPreco := fCriaQuery(Self);
  qryIteFor := fCriaQuery(Self);
  qryIteFor.SQL.Text := TTabelaPreco.fSQLUpdatePrecoRevistaGerencial;

  qryTabDet := fCriaQuery(Self);

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Text := ' UPDATE CADITE SET ITE_NVLFOR = :NVLGIR WHERE ITE_CODITE = :CODITE ';

  fltFatRev := fCfgSis('FATREV', varDouble);

  cpcParams := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao, True, True);

  chkTabelasAtivas.Items.Clear;
  For i := 1 To  7 Do
  Begin
    If VS_strTabPrc[i] = 'S' Then
    Begin
      chkTabelasAtivas.Items.Add('Tabela de Preço ' + IntToStr(i));
      chkTabelasAtivas.Checked[chkTabelasAtivas.Items.Count -1] := False;
    End;
  End;
  pnlTabelasAtivas.Visible := false;
  chkExibirCalculo.Visible := false;
end;

procedure TfrmCalNivGirEstFornecGrid.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabelaPreco);
  FreeAndNil(cpcParams);

end;

procedure TfrmCalNivGirEstFornecGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  With dtsItens.DataSet Do
  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And
                  (State = dsEdit) And
                  (cxgItensNVLFOR.Focused Or
                   cxgItensPERMKP.Focused Or
                   cxgItensPREVEN.Focused) Then
                 Begin
                   cxgItensView.NavigatorButtons.Next.Click;
                   If (State = dsEdit) Then
                   Begin
                     Post;
                     pSetFocus(btnGravar);
                   End;
                 End;

    VK_F10 : If btnGravar.Enabled Then
               btnGravar.Click
             Else If btnGraMkp.Enabled Then
               btnGraMkp.Click;

    VK_F5: pMarcaDesmarca(True);
    VK_F6: pMarcaDesmarca(False);
  End;
end;

procedure TfrmCalNivGirEstFornecGrid.FormResize(Sender: TObject);
begin
  inherited;
  memFormula.Width := Trunc(Self.Width/2)
end;

procedure TfrmCalNivGirEstFornecGrid.pIniciaProcessamento;
begin
  {Liga o flag de processamento e trava o grid e a lista de tabelas: com ProcessMessages no laco, teclas, cliques e
   rolagem no grid reposicionariam o cursor ou abririam edicao, e a lista de tabelas nao pode mudar no meio da gravacao.
   Verificar Nota 1 - Req. 466702}
  FblnProcessando       := True;
  FblnGridHabilitado    := cxgItens.Enabled;
  FblnTabelasHabilitado := chkTabelasAtivas.Enabled;
  cxgItens.Enabled          := False;
  chkTabelasAtivas.Enabled  := False;
end;

procedure TfrmCalNivGirEstFornecGrid.pFinalizaProcessamento;
begin
  cxgItens.Enabled         := FblnGridHabilitado;
  chkTabelasAtivas.Enabled := FblnTabelasHabilitado;
  FblnProcessando          := False;

  If cxgItens.Enabled Then
    pSetFocus(cxgItens);
end;

function TfrmCalNivGirEstFornecGrid.CloseQuery: Boolean;
begin
  {Nao permite fechar a tela durante o Marca/Desmarca.
   Verificar Nota 1 - Req. 466702}
  Result := Not FblnProcessando;
  If Result Then
    Result := inherited CloseQuery;
end;

procedure TfrmCalNivGirEstFornecGrid.pMarcaDesmarca(blnMarca: Boolean);
var bckEvent: TDataSetNotifyEvent;
begin
  {ProcessMessages permite novo F5/F6 durante o laco; evita reentrada.
   Verificar Nota 1 - Req. 466702}
  If FblnProcessando Then
    Exit;

  pIniciaProcessamento;
  bckEvent := dtsItens.DataSet.BeforePost;

  dtsItens.DataSet.BeforePost := nil;
  Try
    dtsItens.DataSet.DisableControls;

    prgProgresso.Max      := dtsItens.DataSet.RecordCount;
    prgProgresso.Position := 0;
    prgProgresso.Visible  := True;

    dtsItens.DataSet.First;
    While not dtsItens.DataSet.Eof do
    Begin
      dtsItens.DataSet.Edit;
      dtsItens.DataSet.FieldByName('ATUPRO').AsInteger := IIf(blnMarca, 1 , 0);
      If dtsItens.DataSet.FieldByName('ATUPRO').AsInteger = 1 then
      Begin
        If (dtsItens.DataSet.FieldByName('ITE_TABPR1').AsString <> strCodTab) And
           (dtsItens.DataSet.FieldByName('ITE_TABPR2').AsString <> strCodTab) And
           (dtsItens.DataSet.FieldByName('ITE_TABPR3').AsString <> strCodTab) And
           (dtsItens.DataSet.FieldByName('ITE_TABPR4').AsString <> strCodTab) And
           (dtsItens.DataSet.FieldByName('ITE_TABPR5').AsString <> strCodTab) And
           (dtsItens.DataSet.FieldByName('ITE_TABPR6').AsString <> strCodTab) And
           (dtsItens.DataSet.FieldByName('ITE_TABPR7').AsString <> strCodTab) Then
        dtsItens.DataSet.FieldByName('ATUPRO').AsInteger := 0;
      End;

      dtsItens.DataSet.Post;
      dtsItens.DataSet.Next;

      prgProgresso.StepBy(1);
      Application.ProcessMessages;
    End;
  Finally
    prgProgresso.Visible := False;
    dtsItens.DataSet.EnableControls;
    dtsItens.DataSet.BeforePost := bckEvent;
    pFinalizaProcessamento;
  End;
end;

function TfrmCalNivGirEstFornecGrid.fExisteTabelaMarcada: Boolean;
var i: Integer;
begin
  {Lista vazia = nenhuma tabela de venda ativa, nada a marcar}
  Result := chkTabelasAtivas.Items.Count = 0;

  For i := 0 To chkTabelasAtivas.Items.Count - 1 Do
  Begin
    If chkTabelasAtivas.Checked[i] Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TfrmCalNivGirEstFornecGrid.pMostraColunasMarkup(blnMostrar: Boolean);
Begin
  cxgItensViewPRECUS.Visible := blnMostrar;
  cxgItensPERMKP.Visible := blnMostrar;
  cxgItensPREVEN.Visible := blnMostrar;
  cxgItensATU_CADPRO.Visible := blnMostrar;
  cxgItensATU_CADPRO.Index := cxgItensPREVEN.Index + 1;
  If VS_strTabPrc[1] = 'S' Then
  Begin
    cxgItensViewPREVE1.Visible := blnMostrar;
    cxgItensViewPREVE1_OLD.Visible := blnMostrar;
    cxgItensViewPRECU1.Visible := blnMostrar;
  End;
  If VS_strTabPrc[2] = 'S' Then
  Begin
    cxgItensViewPREVE2.Visible := blnMostrar;
    cxgItensViewPREVE2_OLD.Visible := blnMostrar;
    cxgItensViewPRECU2.Visible := blnMostrar;
  End;
  If VS_strTabPrc[3] = 'S' Then
  Begin
    cxgItensViewPREVE3.Visible := blnMostrar;
    cxgItensViewPREVE3_OLD.Visible := blnMostrar;
    cxgItensViewPRECU3.Visible := blnMostrar;
  End;
  If VS_strTabPrc[4] = 'S' Then
  Begin
    cxgItensViewPREVE4.Visible := blnMostrar;
    cxgItensViewPREVE4_OLD.Visible := blnMostrar;
    cxgItensViewPRECU4.Visible := blnMostrar;
  End;
  If VS_strTabPrc[5] = 'S' Then
  Begin
    cxgItensViewPREVE5.Visible := blnMostrar;
    cxgItensViewPREVE5_OLD.Visible := blnMostrar;
    cxgItensViewPRECU5.Visible := blnMostrar;
  End;
  If VS_strTabPrc[6] = 'S' Then
  Begin
    cxgItensViewPREVE6.Visible := blnMostrar;
    cxgItensViewPREVE6_OLD.Visible := blnMostrar;
    cxgItensViewPRECU6.Visible := blnMostrar;
  End;
  If VS_strTabPrc[7] = 'S' Then
  Begin
    cxgItensViewPREVE7.Visible := blnMostrar;
    cxgItensViewPREVE7_OLD.Visible := blnMostrar;
    cxgItensViewPRECU7.Visible := blnMostrar;
  End;

  cxgItensPREREV.Visible := blnMostrar;

  cxgItensPREREV.Options.Editing := False;
  cxgItensNVLFOR.Options.Editing := Not blnMostrar;
End;

procedure TfrmCalNivGirEstFornecGrid.FormShow(Sender: TObject);
begin
  inherited;

  pMostraColunasMarkup(False);

  btnInfMkp.Visible := blnPorGru;

  dtsItens.DataSet.BeforePost := pBeforePost;


  If blnPorGru Then
  Begin
    cxgItensCODGRP.GroupIndex := 1;
  End Else
  Begin
    cxgItensCODGRP.GroupIndex := -1;
    cxgItensCODGRP.Visible    := False;
  End;

  cxgItensView.ViewData.Expand(True);
  cxgItensView.NavigatorButtons.First;
  cxgItensNVLFOR.Focused := True;

  edtTabFor.Text := IntToStr(TTabelaPreco.fRetTotalItensTabela(strCodTab));
  edtIteGer.Text := IntToStr(dtsItens.DataSet.RecordCount);
  edtForPri.Text := IntToStr(TTabelaPreco.fRetTotalItensPrincipal(strCodFor));
  edtQtdVen.Text := FormatFloat('###,##0.00',fRetTotalQtdVendida);
  edtTotVen.Text := FormatFloat('###,##0.00',fRetTotalVendido);


  TcxCustomCurrencyEditProperties(cxgItensViewPREVE1.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE2.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE3.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE4.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE5.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE6.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE7.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));

  TcxCustomCurrencyEditProperties(cxgItensViewPREVE1_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE2_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE3_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE4_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE5_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE6_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPREVE7_OLD.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));


  TcxCustomCurrencyEditProperties(cxgItensViewPRECUS.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU1.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU2.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU3.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU4.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU5.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU6.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));
  TcxCustomCurrencyEditProperties(cxgItensViewPRECU7.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));


  TcxCustomCurrencyEditProperties(cxgItensPREVEN.Properties).DisplayFormat := '0.' + fStrZero('0', fCfgSis('DECUNI', varInteger));

  pSetFocus(cxgItens);
end;

function TfrmCalNivGirEstFornecGrid.fRetTotalQtdVendida: Double;
begin
  Result := 0;
  Try
    dtsItens.DataSet.DisableControls;
    With dtsItens.DataSet Do
    Begin
      First;
      While Not Eof Do
      Begin
        Result := Result + FieldByName('QTDITE').AsFloat;

        Next;
      End;
    End;
  Finally
    dtsItens.DataSet.First;
    dtsItens.DataSet.EnableControls;
  End;
end;

function TfrmCalNivGirEstFornecGrid.fRetTotalVendido: Double;
begin
  Result := 0;
  Try
    dtsItens.DataSet.DisableControls;
    With dtsItens.DataSet Do
    Begin
      First;
      While Not Eof Do
      Begin
        Result := Result + FieldByName('TOTITE').AsFloat;

        Next;
      End;
    End;
  Finally
    dtsItens.DataSet.First;
    dtsItens.DataSet.EnableControls;
  End;
end;

procedure TfrmCalNivGirEstFornecGrid.btnExcelClick(Sender: TObject);
begin
  inherited;

  {Ignora o clique enquanto ha processamento em andamento.
   Verificar Nota 1 - Req. 466702}
  If FblnProcessando Then
    Exit;

  If fPergunta('Confirma a geração do Excel?') Then
    pGeraExcel;
end;

procedure TfrmCalNivGirEstFornecGrid.btnGraMkpClick(Sender: TObject);
begin
  inherited;

  {Ignora o clique enquanto o Marca/Desmarca esta em andamento.
   Verificar Nota 1 - Req. 466702}
  If FblnProcessando Then
    Exit;

  With dtsItens.DataSet Do
  Begin
    If State = dsEdit Then
      Post;
  End;

  {Exige ao menos uma Tabela de Preco marcada antes de gravar o Markup.
   Verificar Nota 2 - Req. 466702}
  If Not fExisteTabelaMarcada Then
  Begin
    pMensagemOk('Selecione ao menos uma Tabela de Preço para gravar o Markup!');
    pSetFocus(chkTabelasAtivas);
    Exit;
  End;

  If fPergunta('Confirma a gravação do Markup?') And fGravaMarkup Then
  Begin
    If fPergunta('Markup gravado com sucesso!. Deseja exportar os dados para o Excel?') Then
      pGeraExcel;

    Close;
  End;

end;

procedure TfrmCalNivGirEstFornecGrid.btnGravarClick(Sender: TObject);
begin
  inherited;

  {Ignora o clique enquanto o Marca/Desmarca esta em andamento.
   Verificar Nota 1 - Req. 466702}
  If FblnProcessando Then
    Exit;

  {Bloqueia F5/F6, outros botoes e fechar a tela durante a gravacao/preenchimento.
   Verificar Nota 1 - Req. 466702}
  pIniciaProcessamento;
  Try
    With dtsItens.DataSet Do
    Begin
      If State = dsEdit Then
        Post;
    End;

    If fPergunta('Confirma a gravação do Nível de Giro?') And fGravaNivelGiro Then
    Begin
      pMensagemOk('Nível de Giro gravado com sucesso!');

      If fPedeDadosMarkup Then
      Begin
        btnGravar.Enabled := False;

        btnGraMkp.Enabled := fCompletaMarkup;

        btnInfMkp.Enabled := btnGraMkp.Enabled;
        btnExcel.Enabled  := btnGraMkp.Enabled;
      End;

    End;
  Finally
    pFinalizaProcessamento;
  End;

end;

procedure TfrmCalNivGirEstFornecGrid.btnInfMkpClick(Sender: TObject);
begin
  inherited;

  {Ignora o clique enquanto ha processamento em andamento.
   Verificar Nota 1 - Req. 466702}
  If FblnProcessando Then
    Exit;

  {Bloqueia F5/F6, outros botoes e fechar a tela durante a gravacao/preenchimento.
   Verificar Nota 1 - Req. 466702}
  pIniciaProcessamento;
  Try
    If fPedeDadosMarkup Then
    Begin
      btnGravar.Enabled := False;

      btnGraMkp.Enabled := fCompletaMarkup;
    End;
  Finally
    pFinalizaProcessamento;
  End;

end;

function TfrmCalNivGirEstFornecGrid.fPedeDadosMarkup: Boolean;
var strFilter: String;
    eEvent: TDataSetNotifyEvent;
    i: integer;
Begin
  pnlTabelasAtivas.Visible := True;
  chkExibirCalculo.Visible := True;


  pCriarFormularios(TfrmCalNivGirEstFornecMarkup, frmCalNivGirEstFornecMarkup);
  Try

    frmCalNivGirEstFornecMarkup.edtCodEmpresa.Text := strEmpAtu;
    frmCalNivGirEstFornecMarkup.edtDesEmpresa.Text := fRetFantasiaEmpresa(strEmpAtu);

    frmCalNivGirEstFornecMarkup.edtFornecedor.Text    := strCodFor;
    frmCalNivGirEstFornecMarkup.edtDesFornecedor.Text := fRetNomFornecedor(strCodFor);

    frmCalNivGirEstFornecMarkup.edtTabPre.Text        := strCodTab;
    frmCalNivGirEstFornecMarkup.edtNomTab.Text        := fRetNomeTabelaPreco(strCodTab);

    frmCalNivGirEstFornecMarkup.mskDtaIni.Text        := strDtaIni;
    frmCalNivGirEstFornecMarkup.mskDtaFin.Text        := strDtaFin;

    frmCalNivGirEstFornecMarkup.cxgGruposView.DataController.DataSource := cdsCadGrp.dtsSource;
    frmCalNivGirEstFornecMarkup.qryTabelaPreco := qryTabelaPreco;

    frmCalNivGirEstFornecMarkup.ShowModal;

    strCodTab := frmCalNivGirEstFornecMarkup.edtTabPre.Text;

    Result :=  frmCalNivGirEstFornecMarkup.blnConfirma;

    blnArrUlt := frmCalNivGirEstFornecMarkup.chkArrMai.Checked;
    If qryTabelaPreco.RecordCount > 0 Then
    Begin
      eEvent := dtsItens.DataSet.BeforePost;
      lblTabSelecionada.Caption := 'Tabela de Preço Selecionada: ' + strCodTab + '-' + frmCalNivGirEstFornecMarkup.edtNomTab.Text;
      Try
        dtsItens.DataSet.DisableControls;
        qryTabelaPreco.First;
        dtsItens.DataSet.BeforePost := nil;
        prgProgresso.Max      := qryTabelaPreco.RecordCount;
        prgProgresso.Position := 0;
        prgProgresso.Visible  := True;

        while not qryTabelaPreco.Eof do
        Begin
          If dtsItens.DataSet.Locate('CODITE', qryTabelaPreco.FieldByName('ITE_CODITE').AsString, []) Then
          begin
            dtsItens.DataSet.Edit;
            dtsItens.DataSet.FieldByName('AUTDET').AsString := qryTabelaPreco.FieldByName('AUTOINCREM').AsString;
            dtsItens.DataSet.FieldByName('CNVCUS').AsFloat := qryTabelaPreco.FieldByName('ITE_CNVCUS').AsFloat;

            dtsItens.DataSet.FieldByName('PRECUS').AsFloat := qryTabelaPreco.FieldByName('ITE_PRECUS').AsFloat;
            dtsItens.DataSet.FieldByName('PRECUS_CNV').AsFloat := qryTabelaPreco.FieldByName('ITE_PRECUS').AsFloat/qryTabelaPreco.FieldByName('ITE_CNVCUS').AsFloat;
            dtsItens.DataSet.FieldByName('PREVEN_CNV').AsFloat := qryTabelaPreco.FieldByName('ITE_PREVEN').AsFloat/qryTabelaPreco.FieldByName('ITE_CNVCUS').AsFloat;
            dtsItens.DataSet.FieldByName('ICMSAI').AsFloat := qryTabelaPreco.FieldByName('ITE_ICMSAI').AsFloat;
            dtsItens.DataSet.FieldByName('IMPFED').AsFloat := qryTabelaPreco.FieldByName('ITE_IMPFED').AsFloat;
            dtsItens.DataSet.FieldByName('DESOPE').AsFloat := qryTabelaPreco.FieldByName('ITE_DESOPE').AsFloat;
            dtsItens.DataSet.FieldByName('COMTBL').AsFloat := qryTabelaPreco.FieldByName('ITE_COMTBL').AsFloat;


            dtsItens.DataSet.FieldByName('ITE_PRECOM').AsFloat := qryTabelaPreco.FieldByName('ITE_PRECOM').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESF01').AsFloat := qryTabelaPreco.FieldByName('ITE_DESF01').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESF02').AsFloat := qryTabelaPreco.FieldByName('ITE_DESF02').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESF03').AsFloat := qryTabelaPreco.FieldByName('ITE_DESF03').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESF04').AsFloat := qryTabelaPreco.FieldByName('ITE_DESF04').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESF05').AsFloat := qryTabelaPreco.FieldByName('ITE_DESF05').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESF06').AsFloat := qryTabelaPreco.FieldByName('ITE_DESF06').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_ICMENT').AsFloat := qryTabelaPreco.FieldByName('ITE_ICMENT').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_IPIENT').AsFloat := qryTabelaPreco.FieldByName('ITE_IPIENT').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_FREENT').AsFloat := qryTabelaPreco.FieldByName('ITE_FREENT').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_ACRFIN').AsFloat := qryTabelaPreco.FieldByName('ITE_ACRFIN').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_SUBSTI').AsFloat := qryTabelaPreco.FieldByName('ITE_SUBSTI').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_VALFRE').AsFloat := qryTabelaPreco.FieldByName('ITE_VALFRE').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DESADB').AsFloat := qryTabelaPreco.FieldByName('ITE_DESADB').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_TCIFCU').AsFloat := qryTabelaPreco.FieldByName('ITE_TCIFCU').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_TSCUST').AsFloat := qryTabelaPreco.FieldByName('ITE_TSCUST').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DEPICO').AsFloat := qryTabelaPreco.FieldByName('ITE_DEPICO').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_DEICMS').AsFloat := qryTabelaPreco.FieldByName('ITE_DEICMS').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_FATREG').AsFloat := qryTabelaPreco.FieldByName('ITE_FATREG').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_PREDOL').AsString:= qryTabelaPreco.FieldByName('ITE_PREDOL').AsString;

            dtsItens.DataSet.FieldByName('ITE_ICMENT').AsFloat := qryTabelaPreco.FieldByName('ITE_ICMENT').AsFloat;
            dtsItens.DataSet.FieldByName('ITE_SUBSTI').AsFloat := qryTabelaPreco.FieldByName('ITE_SUBSTI').AsFloat;


            For i := 1 To 7 Do
            Begin
              dtsItens.dataSet.FieldByName('CUS_IMPFED' + IntToStr(i)).AsFloat := qryTabelaPreco.FieldByName('ITE_IMPFED').AsFloat;
              dtsItens.dataSet.FieldByName('CUS_SUBFED' + IntToStr(i)).AsFloat := qryTabelaPreco.FieldByName('ITE_SUBFED').AsFloat;
              dtsItens.dataSet.FieldByName('CUS_DESOPE' + IntToStr(i)).AsFloat := qryTabelaPreco.FieldByName('CUS_DESOPE' + IntToStr(i)).AsFloat;
              dtsItens.dataSet.FieldByName('CUS_OUTVAL' + IntToStr(i)).AsFloat := qryTabelaPreco.FieldByName('CUS_OUTVAL' + IntToStr(i)).AsFloat;
              dtsItens.DataSet.FieldByName('CUS_ICMSAI' + IntToStr(i)).AsFloat := qryTabelaPreco.FieldByName('CUS_ICMSAI' + IntToStr(i)).AsFloat;

              If dtsItens.DataSet.FieldByName('ITE_TABPR'+IntToStr(i)).AsString <> strCodTab Then
              Begin
                dtsItens.dataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat := qryTabelaPreco.FieldByName('DET_PREVEN' + IntToStr(i)).AsFloat;
                dtsItens.dataSet.FieldByName('ITE_PREVE' + IntToStr(i)+ '_OLD').AsFloat := qryTabelaPreco.FieldByName('DET_PREVEN' + IntToStr(i)).AsFloat;
              End;
            End;

            dtsItens.DataSet.Post;
          End;

          If (qryTabelaPreco.RecNo Mod 50) = 0 Then
          Begin
            prgProgresso.Position := qryTabelaPreco.RecNo;
            Application.ProcessMessages;
          End;

          If (qryTabelaPreco.RecNo Mod 200) = 0 Then
          Begin
            Try
              qryTabelaPreco.Connection.Ping;
            Except
              On E: Exception Do
              Begin
                If (Pos('lost connection', LowerCase(E.Message)) > 0) Or
                   (Pos('gone away', LowerCase(E.Message)) > 0) Or
                   (Pos('broken pipe', LowerCase(E.Message)) > 0) Or
                   (Pos('communications link failure', LowerCase(E.Message)) > 0) Then
                Begin
                  // Encerra o loop de forma controlada, sem deixar a
                  // exceção subir para o handler global (MadExceptionException),
                  // evitando acionar o watchdog TThreadFinalizarAutcomMonitor.
                  prgProgresso.Visible := False;
                  MessageDlg('A conexão com o banco de dados foi perdida durante o ' +
                              'processamento do markup.'#13#10 +
                              'Feche e reabra o Autcom, e refaça a operação.',
                              mtError, [mbOK], 0);
                  Abort;
                End
                Else
                  Raise; // erro de outra natureza: mantém comportamento padrão
              End;
            End;
          End;

          qryTabelaPreco.Next;
        End;
      Finally
        dtsItens.DataSet.BeforePost := eEvent;
        dtsItens.DataSet.EnableControls;
        prgProgresso.Visible := False;
      End;

      strFilter := dtsItens.DataSet.Filter;
      If strFilter <> '' Then
        strFilter := strFilter + ' AND AUTDET <> ' + QuotedStr('')
      Else
        strFilter := 'AUTDET <> ' + QuotedStr('');
    End;

    dtsItens.DataSet.Filtered := False;
    dtsItens.DataSet.Filter :=  strFilter;
    If dtsItens.DataSet.Filter <>'' Then
      dtsItens.DataSet.Filtered := True;
  Finally
    pFreeAndNil(frmCalNivGirEstFornecMarkup);
  End;
End;

function TfrmCalNivGirEstFornecGrid.fCompletaMarkup: Boolean;
Begin
  With dtsItens.DataSet Do
  Begin

    Try
      Try
        DisableControls;

        prgProgresso.Max      := RecordCount;
        prgProgresso.Position := 0;
        prgProgresso.Visible  := True;

        BeforePost := pBeforePost2;
        AfterScroll := cdsItensAfterScroll;

        First;
        While Not Eof Do
        Begin
          If Not blnPorGru Then
          begin
            If (Not fEmptyStr(FieldByName('NVLFOR').AsString)) Then
            Begin
              Edit;

              Case FieldByName('NVLFOR').AsString[1] Of
                'A': FieldByName('MARBRU').AsFloat := cdsCadGrp.FieldByName('MKPNVA').AsFloat;
                'B': FieldByName('MARBRU').AsFloat := cdsCadGrp.FieldByName('MKPNVB').AsFloat;
                'C': FieldByName('MARBRU').AsFloat := cdsCadGrp.FieldByName('MKPNVC').AsFloat;
              End;

              Post;
            End;
          End
          Else
          Begin
            cdsCadGrp.First;
            If cdsCadGrp.Locate('CODGRP', FieldByName('CODGRP').AsString, []) And
               (Not fEmptyStr(FieldByName('NVLFOR').AsString)) Then
            Begin
              Edit;

              Case FieldByName('NVLFOR').AsString[1] Of
                'A': FieldByName('MARBRU').AsFloat := cdsCadGrp.FieldByName('MKPNVA').AsFloat;
                'B': FieldByName('MARBRU').AsFloat := cdsCadGrp.FieldByName('MKPNVB').AsFloat;
                'C': FieldByName('MARBRU').AsFloat := cdsCadGrp.FieldByName('MKPNVC').AsFloat;
              End;

              Post;
            End;
          End;

          Next;

          prgProgresso.StepBy(1);
          Application.ProcessMessages;
        End;


        Result := True;

      Except
        On E: Exception Do
        Begin
           Result := False;
          pMensagensErro(E.Message, 'TfrmCalNivGirEstFornecGrid.fCompletaMarkup');
        End;
      End;

  //    BeforePost := pBeforePost;
    Finally
      prgProgresso.Visible := False;
      EnableControls;
    End;
  End;

  cxgItensView.NavigatorButtons.First.Click;
  pMostraColunasMarkup(True);
End;

Procedure TfrmCalNivGirEstFornecGrid.pBeforePost2(dataSet: TDataSet);
var i: integer;
Begin
  With dataSet Do
  Begin
    If dtsItens.DataSet.FieldByName('ATUPRO').AsInteger = 1 then
    Begin
      If (dtsItens.DataSet.FieldByName('ITE_TABPR1').AsString <> strCodTab) And
         (dtsItens.DataSet.FieldByName('ITE_TABPR2').AsString <> strCodTab) And
         (dtsItens.DataSet.FieldByName('ITE_TABPR3').AsString <> strCodTab) And
         (dtsItens.DataSet.FieldByName('ITE_TABPR4').AsString <> strCodTab) And
         (dtsItens.DataSet.FieldByName('ITE_TABPR5').AsString <> strCodTab) And
         (dtsItens.DataSet.FieldByName('ITE_TABPR6').AsString <> strCodTab) And
         (dtsItens.DataSet.FieldByName('ITE_TABPR7').AsString <> strCodTab) Then
      dtsItens.DataSet.FieldByName('ATUPRO').AsInteger := 0;
    End;

    If FieldByName('MARBRU').AsFloat <= 0 Then
    Begin
      pMensagemOk('A margem deve ser maior que zero!');
      Cancel;
      Abort;
      Exit;
    End;

    dataSet.FieldByName('PREVEN').AsFloat := RoundTo(fCalculaPrecoVenda(1,
                                              dataSet.FieldByName('PRECUS').AsFloat + dataSet.FieldByName('OUTVAL').AsFloat,
                                              dataSet.FieldByName('PREVEN').AsFloat,
                                              dataSet.FieldByName('MARBRU').AsFloat,
                                              dataSet.FieldByName('ICMSAI').AsFloat,
                                              dataSet.FieldByName('IMPFED').AsFloat,
                                              dataSet.FieldByName('DESOPE').AsFloat,
                                              dataSet.FieldByName('COMTBL').AsFloat,
                                              '','',-1,0,False,0,0,0,False,dataSet.FieldByName('CNVCUS').AsFloat),  fCfgSis('DECUNI', varInteger) * -1);
    dataSet.FieldByName('FORMULA').AsString :=  TMemoriaCalculoPrecoVendaMargem.strFormula;
    dataSet.FieldByName('CALCULO').AsString :=  TMemoriaCalculoPrecoVendaMargem.strCalculo;



    For i := 1 To 7 do
    Begin

        dataSet.FieldByName('ITE_PRECUS' + IntToStr(i)).AsFloat := fRetPrecoCusto(i, dataSet, True);
        If dataSet.FieldByName('ITE_TABPR' + IntToStr(i)).AsString = strCodTab Then
          dataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat := RoundTo(fCalculaPrecoVenda(1,
                                                                            dataSet.FieldByName('ITE_PRECUS' + intToStr(I)).AsFloat + dataSet.FieldByName('CUS_OUTVAL' + intToStr(I)).AsFloat,
                                                                            0,
                                                                            dataSet.FieldByName('MARBRU').AsFloat,
                                                                            dataSet.FieldByName('CUS_ICMSAI' + intToStr(I)).AsFloat,
                                                                            dataSet.FieldByName('CUS_IMPFED' + intToStr(I)).AsFloat,
                                                                            dataSet.FieldByName('CUS_DESOPE' + intToStr(I)).AsFloat,
                                                                            dataSet.FieldByName('COMTBL').AsFloat,
                                                                            '','',-1,0,False,0,0,0,False,dataSet.FieldByName('CNVCUS').AsFloat), fCfgSis('DECUNI', varInteger) * -1)/ dataSet.FieldByName('CNVCUS').AsFloat
        Else If dataSet.FieldByName('ITE_TABPR' + IntToStr(i)).AsString = strCodTab Then
          dataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat := RoundTo(fCalculaPrecoVenda(1,
                                                                            dataSet.FieldByName('ITE_PRECUS' + intToStr(I)).AsFloat + dataSet.FieldByName('CUS_OUTVAL' + intToStr(I)).AsFloat,
                                                                            0,
                                                                            dataSet.FieldByName('MARBRU').AsFloat,
                                                                            dataSet.FieldByName('CUS_ICMSAI' + intToStr(I)).AsFloat,
                                                                            dataSet.FieldByName('CUS_IMPFED' + intToStr(I)).AsFloat,
                                                                            dataSet.FieldByName('CUS_DESOPE' + intToStr(I)).AsFloat,
                                                                            dataSet.FieldByName('COMTBL').AsFloat,
                                                                            '','',-1,0,False,0,0,0,False), fCfgSis('DECUNI', varInteger) * -1);

        dataSet.FieldByName('FORMULA' + IntToStr(i)).AsString :=  TMemoriaCalculoPrecoVendaMargem.strFormula;
        dataSet.FieldByName('CALCULO' + IntToStr(i)).AsString :=  TMemoriaCalculoPrecoVendaMargem.strCalculo;

    End;

    If blnArrUlt Then
    Begin
      FieldByName('PREVEN').AsFloat := fArredondaMais(FieldByName('PREVEN').AsFloat, True);

      FieldByName('MARBRU').AsFloat := RoundTo(fCalculaPrecoVenda(2,
                                                dataSet.FieldByName('PRECUS').AsFloat + dataSet.FieldByName('OUTVAL').AsFloat,
                                                FieldByName('PREVEN').AsFloat,
                                                FieldByName('MARBRU').AsFloat,
                                                FieldByName('ICMSAI').AsFloat,
                                                FieldByName('IMPFED').AsFloat,
                                                FieldByName('DESOPE').AsFloat,
                                                FieldByName('COMTBL').AsFloat), fCfgSis('DECUNI', varInteger) * -1);
    End;

    FieldByName('PREREV').AsFloat :=  RoundTo(fltFatRev * FieldByName('PREVEN').AsFloat, fCfgSis('DECUNI', varInteger) * -1);

    FieldByName('PREVEN_CNV').AsFloat := RoundTo(FieldByName('PREVEN').AsFloat /
                                                 IfThen(FieldByName('CNVCUS').AsFloat = 0, 1, FieldByName('CNVCUS').AsFloat), fCfgSis('DECUNI', varInteger) * -1);

    FieldByName('PREREV_CNV').AsFloat := RoundTo(FieldByName('PREREV').AsFloat /
                                                 IfThen(FieldByName('CNVCUS').AsFloat = 0, 1, FieldByName('CNVCUS').AsFloat), fCfgSis('DECUNI', varInteger) * -1);
  End;
End;


function TfrmCalNivGirEstFornecGrid.fRetPrecoCusto(intTabela: Integer;dataSet: TDataSet; blnCnvCus: Boolean): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
    strTabela: string;
begin

  strTabela := IntToStr(intTabela);

  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM').AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01').AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02').AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03').AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04').AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05').AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06').AsFloat;
  cpcParams.curICMSEnt:= dataSet.FieldByName('ITE_ICMENT').AsFloat;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT').AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT').AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN').AsFloat;
  cpcParams.curSubsti := dataSet.FieldByName('ITE_SUBSTI').AsFloat;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE').AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB').AsFloat;
  cpcParams.curSubFed := dataSet.FieldByName('CUS_SUBFED' + strTabela).AsFloat;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU').AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST').AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO').AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS').AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG').AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL').AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
  Result := Result; //IIf(blnCnvCus, dataSet.FieldByName('CNVCUS').AsFloat, 1);
end;


function TfrmCalNivGirEstFornecGrid.fCheckedLista(intTabela: integer): Boolean;
var i: integer;
begin
  If VS_strTabPrc[intTabela] <> 'S' Then
    Exit(False);

  For i := 0 To chkTabelasAtivas.Items.Count -1 do
  Begin
    If Pos(IntToStr(intTabela), chkTabelasAtivas.Items[i]) > 0 then
      Break
  End;

  Result := chkTabelasAtivas.Checked[i];
End;

function TfrmCalNivGirEstFornecGrid.fGravaMarkup: Boolean;
var i: integer;
    blnPrealt: Boolean;
Begin
  Result := True;

  With dtsItens.DataSet Do
  Begin

    {Bloqueia F5/F6, cliques, fechar a tela, o grid e a lista de tabelas durante a gravacao.
     Verificar Nota 1 - Req. 466702}
    pIniciaProcessamento;
    Try
      Try
        DisableControls;

        prgProgresso.Max      := RecordCount;
        prgProgresso.Position := 0;
        prgProgresso.Visible  := True;

        First;
        pPreAltDefineVariaveisAltPre(fNow, 'CALC NIVEL GIRO FORNECEDOR', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

        While Not Eof Do
        Begin
          blnPrealt := False;
          TTabelaPreco.pSQUpdatePrecoRevistaFilias(qryTabDet, dtsItens.DataSet);
          pIniciaMatriz(FieldByName('CODITE').AsString, strEmpAtu);

          If Not fEmptyStr(dtsItens.DataSet.FieldByName('AUTDET').AsString) then
          Begin
            Result := fAtualizaIteFor(FieldByName('AUTDET').AsString,
                                      FieldByName('MARBRU').AsFloat,
                                      FieldByName('PREVEN').AsFloat,
                                      FieldByName('PREREV').AsFloat);


            For i := 1 To 7 do
            begin
              If dtsItens.DataSet.FieLdByName('ATUPRO').AsInteger = 1 Then
              Begin
                If fCheckedLista(i) Then
                Begin
                  If dtsItens.DataSet.FieldByName('ITE_TABPR' + IntToStr(i)).AsString = strCodTab Then
                  Begin


                    Result := Result And fAtualizaIteger(IntToStr(i),
                                                         FieldByName('CODITE').AsString,
                                                         strEmpAtu,
                                                         dtsItens.DataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat,
                                                         dtsItens.DataSet.FieldByName('MARBRU').AsFloat);
  
                    Result := Result And fAtualizaDetCus(dtsItens.DataSet.FieldByName('AUTDET').AsString, i,
                                                         dtsItens.DataSet.FieldByName('MARBRU').AsFloat,
                                                         dtsItens.DataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat *
                                                          dtsItens.DataSet.FieldByName('CNVCUS').AsFloat);

    
                    blnPrealt := True;
                  End;

                End;
              End
              Else If fCheckedLista(i) And
                      (dtsItens.DataSet.FieldByName('ITE_TABPR' + IntToStr(i)).AsString = strCodTab) Then
                {Item sem ATUPRO: grava so o DETCUS da tabela marcada, ITEGER permanece.
                 Verificar Nota 3 - Req. 466702}
                Result := Result And fAtualizaDetCus(dtsItens.DataSet.FieldByName('AUTDET').AsString, i,
                                                     dtsItens.DataSet.FieldByName('MARBRU').AsFloat,
                                                     dtsItens.DataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat *
                                                      dtsItens.DataSet.FieldByName('CNVCUS').AsFloat);
              If dtsItens.DataSet.FieldByName('ITE_TABPR' + IntToStr(i)).AsString <> strCodTab Then
                Result := Result And fAtualizaDetCus(dtsItens.DataSet.FieldByName('AUTDET').AsString, i,
                                                     dtsItens.DataSet.FieldByName('MARBRU').AsFloat,
                                                     dtsItens.DataSet.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat);


            End;
            If blnPrealt Then
              pGravaPreAlt(FieldByName('CODITE').AsString, FieldByName('PRECUS').AsFloat, FieldByName('ITE_PRECOM').AsFloat);
          End;
          If Not Result Then
            Break;

          Next;

          prgProgresso.StepBy(1);
          Application.ProcessMessages;
        End;
        strAgrupadorPreAlt := '';

      Except
        On E: Exception Do
        Begin
           Result := False;
          pMensagensErro(E.Message, 'TfrmCalNivGirEstFornecGrid.fGravaMarkup');
        End;
      End;
    Finally
      prgProgresso.Visible := False;
      EnableControls;
      pFinalizaProcessamento;
    End;
  End;

  cxgItensView.NavigatorButtons.First.Click;
End;

function TfrmCalNivGirEstFornecGrid.fAtualizaDetCus(strIncDet: String;
  strTabela: Integer; AfltMarge, AfltVenda: Double): Boolean;
var qryComand: TUniQuery;

begin
  Result := True;
  qryComand := fCriaQuery;
  Try
    Try
      qryComand.SQL.Add('UPDATE DETCUS');
      qryComand.SQL.Add('   SET DET_MARBRU = :MARBRU,');
      qryComand.SQL.Add('       DET_PREVEN = :PREVEN');
      qryComand.SQL.Add(' WHERE DET_SEQDET = :SEQDET');
      qryComand.SQL.Add('   AND DET_TABELA = :TABELA');
      qryComand.ParamByName('SEQDET').Value :=  strIncDet;
      qryComand.ParamByName('TABELA').Value :=  strTabela;
      qryComand.ParamByName('MARBRU').Value :=  AfltMarge;
      qryComand.ParamByName('PREVEN').Value :=  AfltVenda;
      qryComand.ExecSQL;
    Except
      on E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TTabelaPreco.fSalvaDetCus]');
      End;
    End;
  Finally
    FreeAndNil(qryComand);
  End;

end;

function TfrmCalNivGirEstFornecGrid.fAtualizaIteFor(strAutInc: String; fltMarBru, fltPreVen, fltPreRev: Double): Boolean;
Begin
  Result := True;

  Try

    With qryIteFor Do
    Begin
      Close;

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('MARBRU').AsFloat  := fltMarBru;
      ParamByName('PREVEN').AsFloat  := fltPreVen;
      ParamByName('PREREV').AsFloat  := fltPreRev;

      ExecSQL;
    End;


  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCalNivGirEstFornecGrid.fAtualizaIteFor');
    End;
  End;
End;


procedure TfrmCalNivGirEstFornecGrid.pPreenchaMatriz(intTabela: Integer; AfltPreve, AfltMarBru: Double);
begin
  ArrTabPreven[intTabela].fltPreven_New := AfltPreve;
  ArrTabPreven[intTabela].fltMargem_New := AfltMarBru;
End;

procedure TfrmCalNivGirEstFornecGrid.pIniciaMatriz(AStrCodIte: String; AstrEmpAtu: String);
var qryIteger: TUniQuery;
    i: integer;
Begin
  qryIteger := fCriaQuery;
  Try
    qryIteger.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODEMP = "'+AstrEmpAtu+'" AND ITE_CODITE = "'+AStrCodIte+'"');
    qryIteger.Open;

    For i := 1 To 7 do
    Begin
      ArrTabPreven[i].fltPreven := qryIteger.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat;
      ArrTabPreven[i].fltMargem := qryIteger.FieldByName('ITE_MARBR' + IntToStr(i)).AsFloat;
      ArrTabPreven[i].fltPreven_New := qryIteger.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat;
      ArrTabPreven[i].fltMargem_New := qryIteger.FieldByName('ITE_MARBR' + IntToStr(i)).AsFloat;
    End;
  Finally
    FreeAndNil(qryIteger);
  End;

End;

function TfrmCalNivGirEstFornecGrid.fAtualizaIteger(strTabela: String;AStrCodIte: String; AstrEmpAtu: String; AfltPreve, AfltMarBru: Double): Boolean;
var qryComand: TUniQuery;
    strEmpresas: String;
begin
  qryComand := fCriaQuery;
  Try

    strEmpresas := fRetEmpresasUsamPrecoMatriz(nil, AstrEmpAtu, AstrEmpAtu);

    qryComand.SQL.Add('UPDATE ITEGER SET ITE_PREVE' + strTabela + ' = :PREVEN , ITE_MARBR' + strTabela + ' = :MARBRU');
    qryComand.SQL.Add(' WHERE ITE_CODEMP IN (' + fStringSQLLocateToStringSQLIN(strEmpresas)+ ')');
    qryComand.SQL.Add('   AND ITE_CODITE = :CODITE');

    qryComand.ParamByName('CODITE').AsString := AStrCodIte;
    qryComand.ParamByName('PREVEN').AsFloat := AfltPreve;
    qryComand.ParamByName('MARBRU').AsFloat := AfltMarBru;

    qryComand.ExecSQL;
    pPreenchaMatriz(StrToInt(strTabela), AfltPreve, AfltMarBru);
    Result := True;
  Finally
    FreeAndNil(qryComand);
  End
end;


procedure TfrmCalNivGirEstFornecGrid.pGravaPreAlt(strCodIte: String; fltPreCus, fltPrecom: Double);
begin
    If Not VS_blnPreAltViaTrigger Then
      fGravaPreAlt(strCodIte,
                   fltPreCus,
                   fltPreCus,
                   ArrTabPreven[1].fltPreven,
                   ArrTabPreven[1].fltPreven_new,
                   ArrTabPreven[1].fltMargem,
                   ArrTabPreven[1].fltMargem_New,

                   ArrTabPreven[2].fltPreven,
                   ArrTabPreven[2].fltPreven_new,
                   ArrTabPreven[2].fltMargem,
                   ArrTabPreven[2].fltMargem_New,

                   ArrTabPreven[3].fltPreven,
                   ArrTabPreven[3].fltPreven_new,
                   ArrTabPreven[3].fltMargem,
                   ArrTabPreven[3].fltMargem_New,

                   ArrTabPreven[4].fltPreven,
                   ArrTabPreven[4].fltPreven_new,
                   ArrTabPreven[4].fltMargem,
                   ArrTabPreven[4].fltMargem_New,

                   ArrTabPreven[5].fltPreven,
                   ArrTabPreven[5].fltPreven_new,
                   ArrTabPreven[5].fltMargem,
                   ArrTabPreven[5].fltMargem_New,

                   ArrTabPreven[6].fltPreven,
                   ArrTabPreven[6].fltPreven_new,
                   ArrTabPreven[6].fltMargem,
                   ArrTabPreven[6].fltMargem_New,

                   ArrTabPreven[7].fltPreven,
                   ArrTabPreven[7].fltPreven_new,
                   ArrTabPreven[7].fltMargem,
                   ArrTabPreven[7].fltMargem_New,

                   fltPrecom,
                   fltPrecom,
                   'CALC NIVEL GIRO FORNECEDOR',
                   nil,
                   strEmpAtu,
                   strLoginUsuarioLogado);
End;



Procedure TfrmCalNivGirEstFornecGrid.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
    intIndice: Integer;
    strNomExc: String;
Begin
  objGeraExcel := nil;

  {Bloqueia F5/F6, botoes e fechar a tela enquanto o TGeraExcel percorre o dataset.
   Verificar Nota 1 - Req. 466702}
  pIniciaProcessamento;
  Try
    With dtsItens.DataSet Do
    Begin

      Try
        Try
          DisableControls;

          prgProgresso.Visible  := True;

          TClientDataSet(dtsItens.DataSet).IndexFieldNames := 'CODITE';

          First;

          strNomExc := ExtractFilePath(Application.ExeName) + strCodFor + '_' + FormatDateTime('YYYYMMDD', VS_Date);

          If FileExists(strNomExc) Then
            If Not DeleteFile(strNomExc) Then
            Begin
              fMensagem('','Não é possível gerar o arquivo, ' +
                           'verifique se o mesmo está sendo utilizado!', ['&Ok']);
              Exit;
            End;

          objGeraExcel := TGeraExcel.Create(dtsItens.DataSet, prgProgresso);

          With objGeraExcel Do
          Begin
            strNomArq := strNomExc;

            strNomRel := 'NÍVEL DE GIRO DE ESTOQUE POR FORNECEDOR';

            AddFiltro('Fonecedor: ' + strCodFor + ' - ' + fRetNomFornecedor(strCodFor));
            AddFiltro('Tabela de Preço do Fornecedor: ' + strCodTab + ' - ' + fRetNomeTabelaPreco(strCodTab));

            For intIndice := 0 To cxgItensView.ColumnCount - 1 Do
              objGeraExcel.AddCampo(cxgItensView.Columns[intIndice].DataBinding.FieldName,
                                    cxgItensView.Columns[intIndice].Caption);

            If fGerarRelatorio Then
              pMensagemOk('Arquivo gerado com sucesso em ' + strNomExc + '!');
          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, 'TfrmCalNivGirEstFornecGrid.pGeraExcel');
            If Assigned(objGeraExcel) And Not VarIsEmpty(objGeraExcel.objExcel.Excel) Then
              objGeraExcel.objExcel.FecharArquivo;
          End;
        End;
      Finally
        FreeAndNil(objGeraExcel);
        prgProgresso.Visible := False;
        EnableControls;
      End;
    End;
  Finally
    pFinalizaProcessamento;
  End;

End;

end.



