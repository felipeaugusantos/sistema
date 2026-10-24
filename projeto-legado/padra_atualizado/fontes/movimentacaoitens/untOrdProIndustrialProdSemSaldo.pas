unit untOrdProIndustrialProdSemSaldo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade, cxCheckBox, UniClientDataSet, untFuncoesSimples,
  cxTextEdit;

type
  TfrmOrdProIndustrialProdSemSaldo = class(TfrmPaiEdit)
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    shpSubPro: TShape;
    lblSubPro: TLabel;
    cxgItensViewColumn7: TcxGridDBColumn;
    cxgItensViewColumn8: TcxGridDBColumn;
    cxgItensViewColumn9: TcxGridDBColumn;
    btnGerOpe: TBitBtnLocked;
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewColumn9PropertiesEditValueChanged(Sender: TObject);
    procedure btnGerOpeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxgItensViewColumn5PropertiesEditValueChanged(Sender: TObject);
  private

    cdsBakVal: TUniClientDataSet;

    FConfirma: Boolean;

    procedure CreateFields;

    procedure pVerificaSeExisteProdutoIntermediario;


    { Private declarations }
  public

    blnGeraOpSubProdutos : Boolean;

    property blnConfirma: Boolean read FConfirma write FConfirma;

  end;

var
  frmOrdProIndustrialProdSemSaldo: TfrmOrdProIndustrialProdSemSaldo;

implementation

{$R *.dfm}

procedure TfrmOrdProIndustrialProdSemSaldo.btnGerOpeClick(Sender: TObject);
begin
  inherited;
  If Not(cxgItensView.DataController.DataSource.DataSet.Locate('MARDES', 'M', [])) And(fCfgSis('SEPASD', varBoolean)) Then
  Begin
    pMensagemOk('É Necessário informar ao menos 1 produto intermediário!');
    Exit;
  End
  Else
  Begin
    FConfirma:= True;
    Close;
  End;

end;

procedure TfrmOrdProIndustrialProdSemSaldo.cxgItensViewColumn5PropertiesEditValueChanged(
  Sender: TObject);
  var
    fltQtdAcum,
    fltQtdTot,
    fltResult: Double;
    strCodIte: String;
begin
  inherited;

  If fCfgSis('SEPASD', varBoolean) Then
  Begin
    If cxgItensView.DataController.DataSource.DataSet.State = dsEdit Then
    Begin

      If fProdutoIntermediario(cxgItensView.DataController.DataSource.DataSet.FieldByName('ITESUB').AsString) Then
      Begin
        If cxgItensView.DataController.DataSource.DataSet.FieldByName('MARDES').AsString = 'M' Then
        Begin
          fltQtdAcum:= cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOTACUMULADO').AsCurrency;
          fltQtdTot := cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOT').AsCurrency;
          strCodIte := cxgItensView.DataController.DataSource.DataSet.FieldByName('ITESUB').AsString;

          if cdsBakVal.Locate('CODITE', cxgItensView.DataController.DataSource.DataSet.FieldByName('ITESUB').AsString, []) then
            cdsBakVal.Edit
          Else
            cdsBakVal.Insert;
          cdsBakVal.FieldByName('CODITE').AsString  := strCodIte;
          cdsBakVal.FieldByName('VALOLD').AsCurrency:= fltQtdTot;
          cdsBakVal.FieldByName('VALACU').AsCurrency:= fltQtdAcum;
          cdsBakVal.Post;

          cxgItensView.DataController.DataSource.DataSet.Post;

          cxgItensView.DataController.DataSource.DataSet.Edit;

          fltResult:= (fltQtdAcum / fltQtdTot);

          cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOTACUMULADO').AsCurrency :=
            (cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOT').AsCurrency * fltResult);

          cxgItensView.DataController.DataSource.DataSet.Post;

        End
        Else
        Begin
          pMensagemOk('Só é permitido informar a quantidade para produtos que estão selecionados!');
          cxgItensView.DataController.DataSource.DataSet.Cancel;
        End;
      End
      Else
      Begin
        pMensagemOk('Só é permitido informar a quantidade a ser produzida para produtos intermediários!');
        cxgItensView.DataController.DataSource.DataSet.Cancel;
      End;

    End;
  End;

end;

procedure TfrmOrdProIndustrialProdSemSaldo.cxgItensViewColumn9PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  If fCfgSis('SEPASD', varBoolean) Then
  Begin
    If cxgItensView.DataController.DataSource.DataSet.State = dsEdit Then
    Begin

      cxgItensView.DataController.DataSource.DataSet.Post;

      If (cxgItensView.DataController.DataSource.DataSet.FieldByName('MARDES').AsString = 'M') Then
      Begin

        If Not(fProdutoIntermediario(cxgItensView.DataController.DataSource.DataSet.FieldByName('ITESUB').AsString)) Then
        Begin
          pMensagemOk('Só é permitido selecionar itens intermediários!');
          cxgItensView.DataController.DataSource.DataSet.Edit;
          cxgItensView.DataController.DataSource.DataSet.FieldByName('MARDES').AsString:= 'D';
          cxgItensView.DataController.DataSource.DataSet.Post;
        End;

      End
      Else
      Begin
        if cdsBakVal.Locate('CODITE', cxgItensView.DataController.DataSource.DataSet.FieldByName('ITESUB').AsString, []) then
        Begin

          cxgItensView.DataController.DataSource.DataSet.Edit;

          cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOT').AsCurrency :=
            cdsBakVal.FieldByName('VALOLD').AsCurrency;
          cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOTACUMULADO').AsCurrency :=
            cdsBakVal.FieldByName('VALACU').AsCurrency;

          cxgItensView.DataController.DataSource.DataSet.Post;

        End;
      End;

    End;

  End;

end;

procedure TfrmOrdProIndustrialProdSemSaldo.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if blnGeraOpSubProdutos Then
  Begin
    If Sender.DataController.GetValue(AViewInfo.GridRecord.RecordIndex, cxgItensViewColumn6.Index) = 'S' Then
      ACanvas.Brush.Color := shpSubPro.Brush.Color;
  End;

end;

procedure TfrmOrdProIndustrialProdSemSaldo.btnSairClick(Sender: TObject);
begin
  inherited;
  FConfirma:= False;
end;

procedure TfrmOrdProIndustrialProdSemSaldo.CreateFields;
Begin
  cdsBakVal.FieldDefs.Add('CODITE', ftString, 7);
  cdsBakVal.FieldDefs.Add('VALOLD', ftFloat);
  cdsBakVal.FieldDefs.Add('VALACU', ftFloat);
  cdsBakVal.CreateDataSet;
End;


procedure TfrmOrdProIndustrialProdSemSaldo.FormCreate(Sender: TObject);
begin
  inherited;
  If fCfgSis('SEPASD', varBoolean) Then
  Begin
    cdsBakVal:= TUniClientDataSet.Create(Self);
    CreateFields;
  End;
  FConfirma:= True;

end;

procedure TfrmOrdProIndustrialProdSemSaldo.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsBakVal) Then
    FreeAndNil(cdsBakVal);
end;

procedure TfrmOrdProIndustrialProdSemSaldo.FormShow(Sender: TObject);
begin
  inherited;
  shpSubPro.Visible := blnGeraOpSubProdutos;
  lblSubPro.Visible := blnGeraOpSubProdutos;

  If fCfgSis('SEPASD', varBoolean) And (btnGerOpe.Visible) Then
    pVerificaSeExisteProdutoIntermediario;

end;

procedure TfrmOrdProIndustrialProdSemSaldo.pVerificaSeExisteProdutoIntermediario;
Begin
  cxgItensView.DataController.DataSource.DataSet.First;
  Begin
    While Not(cxgItensView.DataController.DataSource.DataSet.Eof) Do
    Begin

      If fProdutoIntermediario(cxgItensView.DataController.DataSource.DataSet.FieldByName('ITESUB').AsString) Then
      Begin
        btnGerOpe.Visible:= True;
        Break;
      End
      Else
        btnGerOpe.Visible:= False;

      cxgItensView.DataController.DataSource.DataSet.Next;

    End;

  End;
End;


end.
