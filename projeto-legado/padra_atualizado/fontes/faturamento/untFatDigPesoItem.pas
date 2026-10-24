unit untFatDigPesoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, UniClientDataSet, untFuncFat,
  cxProgressBar, cxGrid, untPaiConfirma, cxImageComboBox, Vcl.ImgList,
  dxGDIPlusClasses, cxContainer, cxImage, System.UITypes, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmFatDigPesoItem = class(TfrmPaiEdit)
    cxgProdutDBTableView1: TcxGridDBTableViewCitel;
    cxgProdutLevel1: TcxGridLevel;
    cxgProdut: TcxGridCitel;
    CODITE: TcxGridDBColumn;
    DESITE: TcxGridDBColumn;
    SIGUNI: TcxGridDBColumn;
    QTDITE: TcxGridDBColumn;
    PESBRU: TcxGridDBColumn;
    PESLIQ: TcxGridDBColumn;
    TOTBRU: TcxGridDBColumn;
    TOTLIQ: TcxGridDBColumn;
    dtsProdut: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    Panel1: TPanel;
    ShpCmpEdi: TShape;
    Label3: TLabel;
    EDIPES: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnRestau: TBitBtnLocked;
    cxImageCollection1: TcxImageCollection;
    cxImageCollection1Item1: TcxImageCollectionItem;
    cxImageCollection1Item2: TcxImageCollectionItem;
    cxImageList1: TcxImageList;
    cxImage1: TcxImage;
    cxImage2: TcxImage;
    Label1: TLabel;
    Label2: TLabel;
    btnResOri: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgProdutDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgProdutDBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnRestauClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResOriClick(Sender: TObject);
  private
    cdsProdut: TUniClientDataSet;
    procedure pCriaClienteProdutos;
    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterEdit(DataSet: TDataSet);
    procedure pCarregaItens;
    procedure pFormataCampos;
    procedure pGravar;
    function  fCarregaItens(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fHouveAlteracaoPeso: Boolean;
    function  fGravar(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pInfoStatusGravacao(strInformacao: String; pgbStatus: TcxProgressBar);
    procedure pRestauraPesos;
    procedure pRestauraPesosOriginais;
    function  fRestauraPesos(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fRestauraPesosOriginais(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fTeveAlteracaoNosPesos: Boolean;
  public
    objFatVen: TFatVenda;
    //strEdiPes: String;
  end;

var
  frmFatDigPesoItem: TfrmFatDigPesoItem;
Const
  INTDECPES = 3;

implementation

{$R *.dfm}

uses untGravando, untFuncoesSimples;

procedure TfrmFatDigPesoItem.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmFatDigPesoItem.btnResOriClick(Sender: TObject);
begin
  inherited;
  If (Not btnResOri.Visible) Then
    Exit;

  If (fMensagem('ATENÇÃO!', 'Deseja realmente restaurar os pesos originais dos itens?', ['&S i m', '&N ã o'], 2) = 1) Then
    pRestauraPesosOriginais;

  pSetFocus(cxgProdut);
end;

procedure TfrmFatDigPesoItem.btnRestauClick(Sender: TObject);
begin
  inherited;

  If (fMensagem('ATENÇÃO!', 'Deseja realmente desfazer as alterações realizadas nos pesos dos itens?', ['&S i m', '&N ã o'], 2) = 1) Then
    pRestauraPesos;

  pSetFocus(cxgProdut);
end;

procedure TfrmFatDigPesoItem.btnSairClick(Sender: TObject);
begin

  If (fTeveAlteracaoNosPesos) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Os pesos dos itens sofreram alterações.' + #13#10 + 'Deseja realmente sair sem gravar as informações?', ['&S i m', '&N ã o'], 2) = 2) Then
    Begin
      Exit;
    End
    Else
      inherited;
  End
  Else
    inherited;
end;

procedure TfrmFatDigPesoItem.cxgProdutDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.Item.Options.Editing Then
  Begin
    ACanvas.Brush.Color := shpCmpEdi.Brush.Color;
    ACanvas.Font.Color  := clBlack;
  End;

  If (AViewInfo.GridRecord.Selected) Then
  Begin
    If (AViewInfo.Item.Focused) Then
    Begin
      ACanvas.Font.Color  := clBlue;
      ACanvas.Font.Style  := [fsBold];

      If (Not AViewInfo.Item.Options.Editing) Then
        ACanvas.Brush.Color := clWhite;
    End
    Else
    Begin
      ACanvas.Font.Color := clBlack;
      ACanvas.Font.Style := [];
    End;
  End;

end;

procedure TfrmFatDigPesoItem.cxgProdutDBTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  With cdsProdut Do
  Begin
    Case Key Of
      VK_RETURN: If State = dsEdit Then Post;
    End;
  End;
end;

function TfrmFatDigPesoItem.fCarregaItens(pgbStatus: TcxProgressBar): Boolean;
Var
  intContador:Integer;
  intQtdIte  :Integer;
begin

  pInfoStatusGravacao('Aguarde...Carregando os Itens!', pgbStatus);
  intQtdIte := Length(objFatVen.arrMatItens);

  cdsProdut.EmptyDataSet;

  For intContador := 0 To intQtdIte - 1 Do
  Begin
    pInfoStatusGravacao('Carregando item ' + IntToStr(intContador + 1) + '/' + IntToStr(intQtdIte), pgbStatus);

    cdsProdut.Append;
    cdsProdut.FieldByName('SEQITE').AsInteger   := intContador + 1;
    cdsProdut.FieldByName('CODITE').AsString    := objFatVen.arrMatItens[intContador].strCodIte;
    cdsProdut.FieldByName('DESITE').AsString    := objFatVen.arrMatItens[intContador].strDesIte;
    cdsProdut.FieldByName('SIGUNI').AsString    := objFatVen.arrMatItens[intContador].strSigUni;
    cdsProdut.FieldByName('QTDITE').AsFloat     := objFatVen.arrMatItens[intContador].fltQtdIte;

    If (objFatVen.strEdiPes = 'E') Then
    Begin
      cdsProdut.FieldByName('PESBRU').AsFloat     := objFatVen.arrMatItens[intContador].fltPesoIt;
      cdsProdut.FieldByName('PESLIQ').AsFloat     := objFatVen.arrMatItens[intContador].fltPesLiq;
      cdsProdut.FieldByName('TOTBRU').AsFloat     := fFormataFloat(objFatVen.arrMatItens[intContador].fltPesoIt / objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES);
      cdsProdut.FieldByName('TOTLIQ').AsFloat     := fFormataFloat(objFatVen.arrMatItens[intContador].fltPesLiq / objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES);
    End
    Else If (objFatVen.strEdiPes = 'O') Then
    Begin
      cdsProdut.FieldByName('PESBRU').AsFloat     := fFormataFloat(objFatVen.arrMatItens[intContador].fltPesoItOri / objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES);
      cdsProdut.FieldByName('PESLIQ').AsFloat     := fFormataFloat(objFatVen.arrMatItens[intContador].fltPesLiqOri / objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES);
      cdsProdut.FieldByName('TOTBRU').AsFloat     := objFatVen.arrMatItens[intContador].fltPesoItOri;
      cdsProdut.FieldByName('TOTLIQ').AsFloat     := objFatVen.arrMatItens[intContador].fltPesLiqOri;
    End
    Else
    Begin
      cdsProdut.FieldByName('PESBRU').AsFloat     := fFormataFloat(objFatVen.arrMatItens[intContador].fltPesoItCalc / objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES);
      cdsProdut.FieldByName('PESLIQ').AsFloat     := fFormataFloat(objFatVen.arrMatItens[intContador].fltPesLiqCalc / objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES);
      cdsProdut.FieldByName('TOTBRU').AsFloat     := objFatVen.arrMatItens[intContador].fltPesoItCalc;
      cdsProdut.FieldByName('TOTLIQ').AsFloat     := objFatVen.arrMatItens[intContador].fltPesLiqCalc;
    End;

    cdsProdut.FieldByName('TOTBRUANT').AsFloat   := objFatVen.arrMatItens[intContador].fltPesoItCalc;
    cdsProdut.FieldByName('TOTLIQANT').AsFloat   := objFatVen.arrMatItens[intContador].fltPesLiqCalc;

    cdsProdut.FieldByName('TOTBRUORI').AsFloat   := objFatVen.arrMatItens[intContador].fltPesoItOri;
    cdsProdut.FieldByName('TOTLIQORI').AsFloat   := objFatVen.arrMatItens[intContador].fltPesLiqOri;

    cdsProdut.FieldByName('EDIPES').AsBoolean    := objFatVen.arrMatItens[intContador].blnEdiPes;
    cdsProdut.FieldByName('EDIPESANT').AsBoolean := cdsProdut.FieldByName('EDIPES').AsBoolean;
    cdsProdut.Post;
  End;

  Result := True;
  cdsProdut.First;

end;

function TfrmFatDigPesoItem.fGravar(pgbStatus: TcxProgressBar): Boolean;
Var
  cdsProTmp  : TUniClientDataSet;
  intContador: Integer;
  intQtdIte  : Integer;
  blnPesOri  : Boolean;
begin

  Result := False;

  Try
    pInfoStatusGravacao('Aguarde...Gravando os pesos dos itens!', pgbStatus);

    cdsProTmp := TUniClientDataSet.Create(Self);
    cdsProTmp.Data := cdsProdut.Data;
    cdsProTmp.Open;

    objFatVen.fltPesBru := 0;
    objFatVen.fltPesLiq := 0;

    intQtdIte := Length(objFatVen.arrMatItens);

    blnPesOri := True;

    objFatVen.strEdiPes := 'N';

    If (fHouveAlteracaoPeso) Then
      objFatVen.strEdiPes := 'E';

    For intContador := 0 To intQtdIte - 1 Do
    Begin
      pInfoStatusGravacao('Gravando item ' + IntToStr(intContador + 1) + '/' + IntToStr(intQtdIte), pgbStatus);

      cdsProTmp.Filter   := 'SEQITE = ' + IntToStr(intContador + 1);
      cdsProTmp.Filtered := True;

      objFatVen.arrMatItens[intContador].fltPesoIt := cdsProTmp.FieldByName('PESBRU').AsFloat;
      objFatVen.arrMatItens[intContador].fltPesLiq := cdsProTmp.FieldByName('PESLIQ').AsFloat;
      objFatVen.arrMatItens[intContador].blnEdiPes := cdsProTmp.FieldByName('EDIPES').AsBoolean;

      objFatVen.fltPesBru := objFatVen.fltPesBru + cdsProTmp.FieldByName('TOTBRU').AsFloat;
      objFatVen.fltPesLiq := objFatVen.fltPesLiq + cdsProTmp.FieldByName('TOTLIQ').AsFloat;

      If (fFormataFloat(objFatVen.arrMatItens[intContador].fltPesoIt * objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES) <> fFormataFloat(objFatVen.arrMatItens[intContador].fltPesoItOri, INTDECPES)) Or
         (fFormataFloat(objFatVen.arrMatItens[intContador].fltPesLiq * objFatVen.arrMatItens[intContador].fltQtdIte, INTDECPES) <> fFormataFloat(objFatVen.arrMatItens[intContador].fltPesLiqOri, INTDECPES)) Then
        blnPesOri := False;
    End;

    If (blnPesOri) Then
      objFatVen.strEdiPes := 'O';

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.fGravar]');
  End;

  FreeAndNil(cdsProTmp);

end;

function TfrmFatDigPesoItem.fHouveAlteracaoPeso: Boolean;
Var
  cdsProTmp: TUniClientDataSet;
begin

  Result := False;

  Try
    cdsProTmp := TUniClientDataSet.Create(Self);
    cdsProTmp.Data := cdsProdut.Data;
    cdsProTmp.Open;
    cdsProTmp.Filter   := 'EDIPES = TRUE';
    cdsProTmp.Filtered := True;

    Result := cdsProTmp.RecordCount > 0;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.fHouveAlteracaoPeso]');
  End;

  FreeAndNil(cdsProTmp);

end;

procedure TfrmFatDigPesoItem.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaClienteProdutos;
  dtsProdut.DataSet := cdsProdut;
end;

procedure TfrmFatDigPesoItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsProdut);
end;

procedure TfrmFatDigPesoItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_F5) Then
    btnRestau.Click
  Else If (Key = VK_F6) Then
    btnResOri.Click
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click
  Else
    inherited;
end;

procedure TfrmFatDigPesoItem.FormShow(Sender: TObject);
begin
  inherited;
  btnResOri.Visible := (Not fEmptyStr(objFatVen.strNumOrc)) Or (objFatVen.blnExpedi) Or (Pos(objFatVen.strOpcDoc, 'CF_CI_') > 0);
  pCarregaItens;
  pSetFocus(cxgProdut);
end;

function TfrmFatDigPesoItem.fRestauraPesos(pgbStatus: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin

  Result := False;

  Try

    pInfoStatusGravacao('Aguarde...Desfazendo Alterações dos Pesos dos Itens!', pgbStatus);

    With cdsProdut Do
    Begin
      intRecNo := cdsProdut.RecNo;
      First;

      While Not Eof Do
      Begin
        pInfoStatusGravacao('Desfazendo Alterações dos Pesos dos Itens: ' + IntToStr(RecNo) + '/' + IntToStr(RecordCount), pgbStatus);

        Edit;
        cdsProdut.FieldByName('PESBRU').AsFloat := fFormataFloat(cdsProdut.FieldByName('TOTBRUANT').AsFloat / cdsProdut.FieldByName('QTDITE').AsFloat, INTDECPES);
        cdsProdut.FieldByName('PESLIQ').AsFloat := fFormataFloat(cdsProdut.FieldByName('TOTLIQANT').AsFloat / cdsProdut.FieldByName('QTDITE').AsFloat, INTDECPES);
        cdsProdut.FieldByName('TOTBRU').AsFloat := cdsProdut.FieldByName('TOTBRUANT').AsFloat;
        cdsProdut.FieldByName('TOTLIQ').AsFloat := cdsProdut.FieldByName('TOTLIQANT').AsFloat;
        Post;

        Next;
      End;

      cdsProdut.RecNo := intRecNo;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TfrmFatDigPesoItem.fRestauraPesos]');
  End;

end;

function TfrmFatDigPesoItem.fRestauraPesosOriginais(
  pgbStatus: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin

  Result := False;

  Try

    pInfoStatusGravacao('Aguarde...Restaurando os Pesos Originais dos Itens!', pgbStatus);

    With cdsProdut Do
    Begin
      intRecNo := cdsProdut.RecNo;
      First;

      While Not Eof Do
      Begin
        pInfoStatusGravacao('Restaurando Pesos Originais dos Itens: ' + IntToStr(RecNo) + '/' + IntToStr(RecordCount), pgbStatus);

        Edit;
        cdsProdut.FieldByName('PESBRU').AsFloat := fFormataFloat(cdsProdut.FieldByName('TOTBRUORI').AsFloat / cdsProdut.FieldByName('QTDITE').AsFloat, INTDECPES);
        cdsProdut.FieldByName('PESLIQ').AsFloat := fFormataFloat(cdsProdut.FieldByName('TOTLIQORI').AsFloat / cdsProdut.FieldByName('QTDITE').AsFloat, INTDECPES);
        cdsProdut.FieldByName('TOTBRU').AsFloat := cdsProdut.FieldByName('TOTBRUORI').AsFloat;
        cdsProdut.FieldByName('TOTLIQ').AsFloat := cdsProdut.FieldByName('TOTLIQORI').AsFloat;
        Post;

        Next;
      End;

      cdsProdut.RecNo := intRecNo;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TfrmFatDigPesoItem.fRestauraPesosOriginais]');
  End;

end;

function TfrmFatDigPesoItem.fTeveAlteracaoNosPesos: Boolean;
Var
  intRecNo: Integer;
begin

  Result   := False;
  intRecNo := cdsProdut.RecNo;

  Try

    With cdsProdut Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        If (FieldByName('EDIPES').asBoolean <> FieldByName('EDIPESANT').asBoolean) Then
        Begin
          Result := True;
          Break;
        End;

        Next;
      End;
    End;

  Finally
    cdsProdut.RecNo := intRecNo;
    cdsProdut.EnableControls;
  End;

end;

procedure TfrmFatDigPesoItem.pAfterEdit(DataSet: TDataSet);
begin
//
end;

procedure TfrmFatDigPesoItem.pBeforePost(DataSet: TDataSet);
begin

  With DataSet Do
  Begin
    If (DataSet.FieldByName('PESBRU').AsFloat < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Peso Bruto deve ser maior ou igual a zero!', ['&O k']);
      Cancel;
      Abort;
    End
    Else If (DataSet.FieldByName('PESLIQ').AsFloat < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Peso Líquido deve ser maior ou igual a zero!', ['&O k']);
      Cancel;
      Abort;
    End
    Else
    Begin
      DataSet.FieldByName('TOTBRU').AsFloat := fFormataFloat(fFormataFloat(DataSet.FieldByName('PESBRU').AsFloat, INTDECPES) * DataSet.FieldByName('QTDITE').AsFloat, INTDECPES);
      DataSet.FieldByName('TOTLIQ').AsFloat := fFormataFloat(fFormataFloat(DataSet.FieldByName('PESLIQ').AsFloat, INTDECPES) * DataSet.FieldByName('QTDITE').AsFloat, INTDECPES);

      If (fFormataFloat(DataSet.FieldByName('TOTBRU').AsFloat, INTDECPES) <> fFormataFloat(DataSet.FieldByName('TOTBRUORI').AsFloat, INTDECPES)) Or
         (fFormataFloat(DataSet.FieldByName('TOTLIQ').AsFloat, INTDECPES) <> fFormataFloat(DataSet.FieldByName('TOTLIQORI').AsFloat, INTDECPES)) Then
      Begin
        DataSet.FieldByName('EDIPES').AsBoolean := True;

        If (DataSet.State = dsInsert) Then
          DataSet.FieldByName('EDIPESANT').AsBoolean := True;
      End
      Else
      Begin
        DataSet.FieldByName('EDIPES').AsBoolean := False;
      End;
    End;

  End;

end;

procedure TfrmFatDigPesoItem.pCarregaItens;
begin

  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaItens;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.pCarregaItens]');
  End;

  FreeAndNil(frmGravando);

end;

procedure TfrmFatDigPesoItem.pCriaClienteProdutos;
begin
  Try
    cdsProdut := TUniClientDataSet.Create(Self);

    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'SEQITE';    DataType := ftInteger;             Required := False; End;
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'CODITE';    DataType := ftString; Size := fTamCodIte; Required := False; End;
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'DESITE';    DataType := ftString; Size := 101; Required := False; End;
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'SIGUNI';    DataType := ftString; Size := 006; Required := False; End;
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE';    DataType := ftFloat;               Required := False; End; //(12,04)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'PESLIQ';    DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'PESBRU';    DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'TOTBRU';    DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'TOTLIQ';    DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'TOTBRUANT'; DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'TOTLIQANT'; DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'TOTBRUORI'; DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'TOTLIQORI'; DataType := ftFloat;               Required := False; End; //(14,03)
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'EDIPES';    DataType := ftBoolean;             Required := False; End;
    With cdsProdut.FieldDefs.AddFieldDef Do Begin Name := 'EDIPESANT'; DataType := ftBoolean;             Required := False; End;

    cdsProdut.CreateDataSet;
    cdsProdut.BeforePost      := pBeforePost;
    cdsProdut.AfterEdit       := pAfterEdit;
    cdsProdut.IndexFieldNames := 'SEQITE';

    pFormataCampos;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.pCriaClienteProdutos]');
  End;
end;

procedure TfrmFatDigPesoItem.pFormataCampos;
begin

  With cdsProdut Do
  Begin
    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('PESBRU')).DisplayFormat := fMskDigitos(INTDECPES);
    TFloatField(FieldByName('PESLIQ')).DisplayFormat := fMskDigitos(INTDECPES);
    TFloatField(FieldByName('TOTBRU')).DisplayFormat := fMskDigitos(INTDECPES);
    TFloatField(FieldByName('TOTLIQ')).DisplayFormat := fMskDigitos(INTDECPES);
  End;

end;

procedure TfrmFatDigPesoItem.pGravar;
Var
  blnConfirma: Boolean;
begin

  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravar;
    frmGravando.ShowModal;
    blnConfirma := frmGravando.blnConfirma;
    pFreeAndNil(frmGravando);

    If (Not blnConfirma) Then
      Exit;

  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmGravando);
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.pGravar]');
    End;
  End;


end;

procedure TfrmFatDigPesoItem.pInfoStatusGravacao(strInformacao: String; pgbStatus: TcxProgressBar);
Begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
End;

procedure TfrmFatDigPesoItem.pRestauraPesos;
begin

  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fRestauraPesos;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.pCarregaItens]');
  End;

  FreeAndNil(frmGravando);

end;

procedure TfrmFatDigPesoItem.pRestauraPesosOriginais;
begin
  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fRestauraPesosOriginais;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigPesoItem.pCarregaItens]');
  End;

  FreeAndNil(frmGravando);
end;

end.
