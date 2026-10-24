unit untControleNumeroSerie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, untFatSeriesItem,
  System.Generics.Collections,
  cxButtonEdit,
  untFuncoesSimples,
  untNumeroSerie,
  untTNumeroSerie,
  untZClient,
  Uni,
  untFuncoesGenerica, Vcl.Grids, Vcl.DBGrids, DBGridCitel
  ;

type
  TfrmControleNumeroSerie = class(TfrmPaiConfirma)
    dtsNumeroSerie: TDataSource;
    Panel1: TPanel;
    cdsNumeroSerie: TUniClientDataSet;
    cdsNumeroSerieCODIGO: TStringField;
    cdsNumeroSerieDESCRI: TStringField;
    cdsNumeroSerieQTDITE: TFloatField;
    cdsNumeroSerieNUMSER: TStringField;
    cdsNumeroSerieEMPITE: TStringField;
    cdsNumeroSerieAUTINC: TStringField;
    cdsNumeroSerieCODBAR: TStringField;
    cdsNumeroSerieDESMAR: TStringField;
    cdsNumeroSerieREFERE: TStringField;
    cdsNumeroSerieCODFAB: TStringField;
    cdsSeries: TUniClientDataSet;
    cdsSeriesLINHA: TIntegerField;
    cdsSeriesSER_NUMSER: TStringField;
    cdsSeriesSER_CODITE: TStringField;
    cdsNumeroSerieVALIDO: TBooleanField;
    dbgConsulta: TDBGridCitel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsNumeroSerieAfterScroll(DataSet: TDataSet);
    procedure cxgNumeroSerieDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgNumeroSerieDBTableViewCitelNUMSERPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaCellClick(Column: TColumn);
  private
    { Private declarations }
    FstrErro: String;
    FstrNumDoc: String;
    FstrCodEmp: String;
    FstrSerie:  String;
    FstrEspDoc: String;
    procedure pCarregarDados;
    function fVisualizarNumeroSerie: Boolean;
    procedure pGerarSERIES(strCodIte: String; intQuantidade: Integer);
    function fValidarCampos: Boolean;
    function fValidarNumeroSeries: Boolean;
    procedure pGravarProSer;
    procedure pAdicionarItem(strCodIte: string; intQtdIte: Integer);
  public
    { Public declarations }
    function fNumDoc(strNumDoc: String): TfrmControleNumeroSerie;
    function fCodEmp(strCodEmp: String): TfrmControleNumeroSerie;
    function fSerie(strSerie: String): TfrmControleNumeroSerie;
    function fEspDoc(strEspDoc: String): TfrmControleNumeroSerie;
    function fAbrirForm: Boolean;
  end;


implementation

{$R *.dfm}

procedure TfrmControleNumeroSerie.btnConfirmaClick(Sender: TObject);
begin
  If fValidarCampos Then
  Begin
    pGravarProSer;
    ModalResult := mrOk;
  End
  Else
    fMensagem('', FstrErro, ['&Ok'])
end;

procedure TfrmControleNumeroSerie.cdsNumeroSerieAfterScroll(DataSet: TDataSet);
begin
  inherited;
  cdsSeries.Filtered := True;
  cdsSeries.Filter := 'SER_CODITE = ''' + cdsNumeroSerieCODIGO.AsString + '''';
end;

procedure TfrmControleNumeroSerie.cxgNumeroSerieDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
//Var
//  strTexto: String;
begin
//  If AViewInfo.Item.Index = cxgNumeroSerieDBTableViewCitelNUMSER.Index Then
//  Begin
//    Try
//      strTexto := 'Definir';
//      If VarToStrDef(AViewInfo.GridRecord.Values[cxgNumeroSerieDBTableViewCitelVALIDO.Index],'') = 'True' Then
//        strTexto := 'Concluído';
//      TcxButtonEditProperties(AViewInfo.Properties).Buttons.Items[0].Caption := strTexto;
//      ADone := True;
//    Except
//      On E: Exception Do
//        ADone := False;
//    End;
//  End;
end;

procedure TfrmControleNumeroSerie.cxgNumeroSerieDBTableViewCitelNUMSERPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  fVisualizarNumeroSerie;
end;

procedure TfrmControleNumeroSerie.dbgConsultaCellClick(Column: TColumn);
begin
  inherited;
  If Column.FieldName = 'NUMSER' Then
    fVisualizarNumeroSerie;
end;

procedure TfrmControleNumeroSerie.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  bcolor: TColor;

begin
  inherited;
  If Column.FieldName = 'NUMSER' Then
  begin
    dbgConsulta.Canvas.FillRect(Rect);
    BUTTON := 0;
    R:=Rect;
    InflateRect(R,-1,-1); //Diminue o tamanho do Botão
    DrawFrameControl(dbgConsulta.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    bcolor := dbgConsulta.Canvas.Brush.Color; // guarda a cor de fundo original
    dbgConsulta.Canvas.Brush.Color := clBtnFace; // muda a cor de fundo

    DrawText(dbgConsulta.Canvas.Handle,'Definir', 7, R, DT_VCENTER or DT_CENTER);
    If cdsNumeroSerie.FieldByName('VALIDO').AsBoolean Then
      DrawText(dbgConsulta.Canvas.Handle,'Concluído', 9, R, DT_VCENTER or DT_CENTER);

    dbgConsulta.Canvas.Brush.Color := bcolor; // devolve a cor original
  End
end;

function TfrmControleNumeroSerie.fAbrirForm: Boolean;
begin
  Result := True;
  pCarregarDados;
  If Not cdsNumeroSerie.IsEmpty Then
    Result := ShowModal = mrOk;
end;

function TfrmControleNumeroSerie.fCodEmp(
  strCodEmp: String): TfrmControleNumeroSerie;
begin
  Result := Self;
  FstrCodEmp := strCodEmp;
end;

function TfrmControleNumeroSerie.fEspDoc(
  strEspDoc: String): TfrmControleNumeroSerie;
begin
  Result := Self;
  FstrEspDoc := strEspDoc;
end;

procedure TfrmControleNumeroSerie.pAdicionarItem(strCodIte: string; intQtdIte: Integer);
begin
  cdsNumeroSerie.Append;
  cdsNumeroSerieCODIGO.AsString := strCodIte;
  cdsNumeroSerieDESCRI.AsString := fRetNomProduto(strCodIte);
  cdsNumeroSerieQTDITE.AsInteger := intQtdIte;
  cdsNumeroSerieCODBAR.AsString := fRetCodBarra(strCodIte);
  cdsNumeroSerieDESMAR.AsString := fRetNomMarcaItem(strCodIte);
  cdsNumeroSerieREFERE.AsString := fRetReferenciaProd(strCodIte);
  cdsNumeroSerieCODFAB.AsString := fRetCodFabProduto(strCodIte);
  cdsNumeroSerie.Post;

  pGerarSERIES(strCodIte, intQtdIte);
end;

function TfrmControleNumeroSerie.fNumDoc(
  strNumDoc: String): TfrmControleNumeroSerie;
begin
  Result := Self;
  FstrNumDoc := strNumDoc;
end;

procedure TfrmControleNumeroSerie.pCarregarDados;
Var
  strCodIte: String;
  intQtdIte: Integer;
  qryEntMer: TUniQuery;
Begin
  qryEntMer := fCriaQuery(Self);
  Try
    qryEntMer.SQL.Add(' SELECT  ');
    qryEntMer.SQL.Add('   ENT_CODITE CODITE,');
    qryEntMer.SQL.Add('   ENT_QTDITE QTDITE');
    qryEntMer.SQL.Add(' FROM TMP_ENTMER');
    qryEntMer.SQL.Add(' INNER JOIN ITEGER ON ITE_CODITE = ENT_CODITE');
    qryEntMer.SQL.Add('                  AND ITE_CODEMP = "' +VS_strCodEmp + '"');
    qryEntMer.SQL.Add(' WHERE ITE_USASER = "S"');
    qryEntMer.Open;

    While Not qryEntMer.Eof Do
    Begin
      strCodIte := qryEntMer.FieldByName('CODITE').AsString;
      intQtdIte := qryEntMer.FieldByName('QTDITE').AsInteger;

      If fProdutoUsaNumeroDeSerie(strCodIte, VS_strCodEmp) Then
        pAdicionarItem(strCodIte, intQtdIte);

      qryEntMer.Next;
    End;
  Finally
    qryEntMer.Free;
  End;
End;


procedure TfrmControleNumeroSerie.FormCreate(Sender: TObject);
begin
  inherited;
  cdsNumeroSerie.FieldByName('CODIGO').Size := fTamCodIte;
  cdsNumeroSerie.CreateDataSet;

  cdsSeries.FieldByName('SER_CODITE').Size := fTamCodIte;
  cdsSeries.CreateDataSet;
end;

procedure TfrmControleNumeroSerie.pGerarSERIES(strCodIte: String; intQuantidade: Integer);
Var
  intContador: Integer;
begin
  inherited;
  For intContador := 1 To intQuantidade Do
    cdsSeries.InsertRecord([intContador, strCodIte, '']);
end;

function TfrmControleNumeroSerie.fSerie(
  strSerie: String): TfrmControleNumeroSerie;
begin
  Result := Self;
  FstrSerie := strSerie;
end;

function TfrmControleNumeroSerie.fVisualizarNumeroSerie: Boolean;
Begin
  pCriarFormularios(TfrmNumeroSerie, frmNumeroSerie);
  Try
    frmNumeroSerie.ModoAbertura := maEntrada;
    frmNumeroSerie.Caption := 'Informe os Números de Serie - Cód Produto: ' + cdsNumeroSerieCODIGO.AsString;
    frmNumeroSerie.dtsDados.DataSet := cdsSeries;
    frmNumeroSerie.blnSomenteLeitura := False;
    Result := frmNumeroSerie.ShowModal = mrOk;

    cdsNumeroSerie.Edit;
    cdsNumeroSerieVALIDO.AsBoolean := fValidarNumeroSeries;
    cdsNumeroSerie.Post;
  Finally
    FreeAndNil(frmNumeroSerie);
  End;
End;

function TfrmControleNumeroSerie.fValidarCampos: Boolean;
Begin
  FstrErro := '';
  cdsNumeroSerie.First;
  While Not cdsNumeroSerie.Eof Do
  Begin
    cdsSeries.First;
    While Not cdsSeries.Eof Do
    Begin
      If  fEmptyStr(cdsSeriesSER_NUMSER.AsString) Then
        FstrErro := FstrErro +
          cdsSeriesLINHA.AsString + ' - ' +
            cdsNumeroSerieCODIGO.AsString + ' ' +
            cdsNumeroSerieDESCRI.AsString +  #13;
      cdsSeries.Next;
    End;
    cdsNumeroSerie.Next;
  End;
  Result := fEmptyStr(FstrErro);
End;

function TfrmControleNumeroSerie.fValidarNumeroSeries: Boolean;
Begin
  Result := True;
  cdsSeries.First;
  While Not cdsSeries.Eof Do
  Begin
    If fEmptyStr(cdsSeriesSER_NUMSER.AsString) Then
      Exit(False);
    cdsSeries.Next;
  End;
End;

procedure TfrmControleNumeroSerie.pGravarProSer;
Var
  objDataSet: TUniQuery;
Begin
  objDataSet := fCriaQuery();
  Try
    objDataSet.SQL.Text := 'INSERT INTO PROSER (AUTOINCREM, SER_CODITE, SER_NUMSER,' +
      'SER_CODEMP, SER_NUMDOC, SER_EMPDOC, SER_ESPDOC) VALUES (:AUTOINCREM, :SER_CODITE,' +
      ':SER_NUMSER, :SER_CODEMP, :SER_NUMDOC, :SER_EMPDOC, :SER_ESPDOC)';
    cdsSeries.Filtered := False;
    cdsSeries.First;
    While Not cdsSeries.Eof Do
    Begin
      objDataSet.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('PROSER', FstrCodEmp);
      objDataSet.ParamByName('SER_CODITE').AsString := cdsSeriesSER_CODITE.AsString;
      objDataSet.ParamByName('SER_NUMSER').AsString := cdsSeriesSER_NUMSER.AsString;
      objDataSet.ParamByName('SER_CODEMP').AsString := FstrCodEmp;
      objDataSet.ParamByName('SER_NUMDOC').AsString := FstrNumDoc;
      objDataSet.ParamByName('SER_EMPDOC').AsString := FstrCodEmp;
      objDataSet.ParamByName('SER_ESPDOC').AsString := FstrEspDoc;
      objDataSet.ExecSQL;
      cdsSeries.Next;
    End;
  Finally
    FreeAndNil(cdsSeries);
  End;
End;


end.
