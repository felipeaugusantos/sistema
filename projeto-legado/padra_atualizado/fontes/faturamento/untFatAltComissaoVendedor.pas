unit untFatAltComissaoVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, StdCtrls, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, DB, UniClientDataSet, BitBtnLockedIncrem, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, untFuncFat, untFuncFatTypes,
  cxEditRepositoryItems, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatAltComissaoVendedor = class(TfrmPaiSimples)
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    intgrfldItensAUTINC: TIntegerField;
    strngfldItensCODITE: TStringField;
    strngfldItensDESITE: TStringField;
    strngfldItensREFERE: TStringField;
    strngfldItensSIGUNI: TStringField;
    cdsItensUNIDIG: TFloatField;
    cdsItensDESCON: TFloatField;
    cdsItensUNITAR: TFloatField;
    cdsItensTOTITE: TFloatField;
    cdsItensQTDITE: TFloatField;
    cdsItensPERCOM: TFloatField;
    cdsItensVALCOM: TFloatField;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel: TcxGridLevel;
    cxgItensViewCODITE: TcxGridDBColumn;
    cxgItensViewDESITE: TcxGridDBColumn;
    cxgItensViewREFERE: TcxGridDBColumn;
    cxgItensViewQTDITE: TcxGridDBColumn;
    cxgItensViewSIGUNI: TcxGridDBColumn;
    cxgItensViewUNIDIG: TcxGridDBColumn;
    cxgItensViewDESCON: TcxGridDBColumn;
    cxgItensViewUNITAR: TcxGridDBColumn;
    cxgItensViewTOTITE: TcxGridDBColumn;
    cxgItensViewPERCOM: TcxGridDBColumn;
    cxgItensViewVALCOM: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    pnlLegenda: TPanel;
    shp2: TShape;
    lbl2: TLabel;
    btnRestaurar: TBitBtnLocked;
    strngfldItensALTPCO: TStringField;
    cxgItensViewALTPCO: TcxGridDBColumn;
    cxedtRepository: TcxEditRepository;
    cxrEdtValPer: TcxEditRepositoryCurrencyItem;
    shp1: TShape;
    lbl1: TLabel;
    btnInfPerCom: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cdsItensBeforePost(DataSet: TDataSet);
    procedure cxrEdtValPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnInfPerComClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    procedure pCarregaItensGrid(blnRecalculando: Boolean = False);
    procedure pAdicionaItem(var item: TDadosFechamento);
  public
    { Public declarations }
    fatVenda: TFatVenda;
    strOpcDoc: String;
  end;

var
  frmFatAltComissaoVendedor: TfrmFatAltComissaoVendedor;

implementation

uses untFuncoesSimples, untFatCalcComissaoVendedor, untConstantes, untFuncoes, System.UITypes,
  untTypesSistema;

{$R *.dfm}

procedure TfrmFatAltComissaoVendedor.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If cdsItens.IsEmpty Then
    Exit;

  If Not fPergunta('Confirma alteração dos percentuais de comissão?') Then
    Exit;

  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      If cdsVenda.Locate('AUTOINCREM', FieldByName('AUTINC').AsInteger, []) Then
      Begin
        cdsVenda.Edit;
        cdsVenda.FieldByName('ITE_ALTPCO').AsString := FieldByName('ALTPCO').AsString;
        cdsVenda.FieldByName('ITE_PERCOM').AsFloat  := FieldByName('PERCOM').AsFloat;        
        cdsVenda.Post;
      End;
      Next;
    End;
  End;

  Close;

end;

procedure TfrmFatAltComissaoVendedor.btnInfPerComClick(Sender: TObject);
  Var
    fltPerCom: Double;
begin
  inherited;
  If Not fDigitaValor(fltPerCom, 'Percentual de Comissão', '#,##0.00', True) Then
    Exit;

  If Not fValidaEscala(FloatToStr(fltPerCom), 0, 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'O percentual de comissão deve estar entre 0 e 100!', ['&Ok']);
    Exit;
  End;

  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ALTPCO').AsString := 'S';
      FieldByName('PERCOM').AsFloat  := fltPerCom;
      Post;
      Next;
    End;
    cxgItensView.DataController.GotoFirst;
  End;

end;

procedure TfrmFatAltComissaoVendedor.btnMarcarTodosClick(Sender: TObject);
var
  intRegistroSelecionado: integer;
begin
  inherited;
  If (cdsItens.IsEmpty) Then
    exit;

  If (Not fPergunta('Deseja marcar todos os itens como alterados manualmente?')) Then
    Exit;

  intRegistroSelecionado := cdsItens.RecNo;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ALTPCO').AsString := 'S';
      cdsItens.Post;
      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;

  cdsItens.RecNo := intRegistroSelecionado;
  If (cxgItens.CanFocus) Then
    pSetFocus(cxgItens);

end;

procedure TfrmFatAltComissaoVendedor.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Confirma alteração dos percentuais de comissão?') Then
    pCarregaItensGrid(True);
end;

procedure TfrmFatAltComissaoVendedor.cdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If (State In [dsEdit]) And (FieldByname('PERCOM').Value <> FieldByname('PERCOM').OldValue) Then
    Begin
      FieldByName('ALTPCO').AsString := 'S';
    End;
    FieldByname('VALCOM').Value := FieldByname('TOTITE').Value * FieldByname('PERCOM').Value / 100;
  End;
end;

procedure TfrmFatAltComissaoVendedor.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strAltPCo: String;
begin
  inherited;
  strAltPCo := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewALTPCO.Index]);

  If (cdsItens.IsEmpty) Then
    Exit;

  If (strAltPCo = 'S') Then
  Begin
    If AViewInfo.Selected And Assigned(ActiveControl) And fCheckParent(ActiveControl, cxgItens) Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clRed;
  End
  Else
  Begin
    If AViewInfo.Selected And Assigned(ActiveControl) And fCheckParent(ActiveControl, cxgItens) Then
      ACanvas.Font.Color := clWhite
    Else
      ACanvas.Font.Color := clBlue;
  End;

  If (ACanvas.Brush.Color <> clHighlight) And
     (AViewInfo.GridRecord.RecordIndex Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  End;

end;

procedure TfrmFatAltComissaoVendedor.cxgItensViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If cdsItens.State In [dsEdit] Then
                 cdsItens.Post;
  End;
end;

procedure TfrmFatAltComissaoVendedor.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE : btnSair.Click;
  End;
end;

procedure TfrmFatAltComissaoVendedor.cxrEdtValPerPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If Not fValidaEscala(VarToStrDef(DisplayValue, '-1'), 0, 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'O percentual de comissão deve estar entre 0 e 100!', ['&Ok']);
    DisplayValue := '0';
    Error := False;
  End;
end;

procedure TfrmFatAltComissaoVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  blnFecharForm := False;
end;

procedure TfrmFatAltComissaoVendedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5 : btnInfPerCom.Click;  
    VK_F6 : btnRestaurar.Click;
    VK_F7 : btnMarcarTodos.Click;
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmFatAltComissaoVendedor.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Self.Close;
end;

procedure TfrmFatAltComissaoVendedor.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte(strngfldItensCODITE);

  cdsItens.CreateDataSet;

  TFloatField(cdsItens.FieldByName('UNIDIG')).DisplayFormat := fMskDigitos(fatVenda.VS_intDecUni);
  TFloatField(cdsItens.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(fatVenda.VS_intDecUni);
  TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  TFloatField(cdsItens.FieldByName('DESCON')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('TOTITE')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('PERCOM')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('VALCOM')).DisplayFormat := fMskDigitos(2);

  pCarregaItensGrid;
  pSetFocus(cxgItens);

end;

procedure TfrmFatAltComissaoVendedor.pAdicionaItem(var item: TDadosFechamento);
  Var
    strVendedor: String;
    objCalcComissaoVend: TCalculoComissaoVendedor;
begin
  strVendedor := IIF(fatVenda.fEhAutocenter, item.strCodVen, fatVenda.strCodVen);

  objCalcComissaoVend := fatVenda.fCriaCalculoComissaoVendedor(strVendedor);

  item.fltPerCom := objCalcComissaoVend.fRetPerComissao(item, fatVenda.strTipVen);

  FreeAndNil(objCalcComissaoVend);

  cdsItens.Append;
  cdsItens.FieldByName('AUTINC').AsInteger := item.intAutInc;
  cdsItens.FieldByName('CODITE').AsString  := item.strCodIte;
  cdsItens.FieldByName('DESITE').AsString  := item.strDesIte;
  cdsItens.FieldByName('REFERE').AsString  := item.strRefere;
  cdsItens.FieldByName('QTDITE').AsFloat   := item.fltQtdIte;
  cdsItens.FieldByName('SIGUNI').AsString  := item.strSigUni;
  cdsItens.FieldByName('UNIDIG').AsFloat   := item.fltUniDig;
  cdsItens.FieldByName('DESCON').AsFloat   := item.fltDesCon;
  cdsItens.FieldByName('UNITAR').AsFloat   := item.fltUniTar;
  cdsItens.FieldByName('TOTITE').AsFloat   := item.fltTotIte;
  cdsItens.FieldByName('PERCOM').AsFloat   := item.fltPerCom;
  cdsItens.FieldByName('ALTPCO').AsString  := item.strAltPCo; 
  cdsItens.FieldByName('VALCOM').AsFloat   := item.fltTotIte * item.fltPerCom / 100;
  cdsItens.Post;
end;

procedure TfrmFatAltComissaoVendedor.pCarregaItensGrid(blnRecalculando: Boolean = False);
  Var
    index: Integer;
    item: TDadosFechamento;
    intCnt: Integer;
begin
  Try
    fatVenda.pPreencheMatrizFechamento;

    For intCnt := 0 To Length(fatVenda.arrMatItens) -1 Do
    Begin
      If fEmptyStr(fatVenda.arrMatItens[intCnt].strClaFis) Then
      Begin
        If (Pos(strOpcDoc, 'DV_OF_') > 0) Then
          fatVenda.arrMatItens[intCnt].strClaFis := '1102'
        Else
          fatVenda.arrMatItens[intCnt].strClaFis := '5102';
      End;
    End;

    cdsItens.EmptyDataSet;

    For index := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
    Begin
      item := fatVenda.arrMatItens[index];

      If blnRecalculando Then
        item.strAltPCo := 'N';

      pAdicionaItem(item);
    End;

  Except
    On E: Exception Do
    Begin
      blnFecharForm := True;
      pMensagensErro(E.Message, '');
    End;

    On E: ExceptionAutCom Do
    Begin
      blnFecharForm := True;
      fMensagem('', E.Message, ['&O K']);
    End;
  End;
end;

end.
