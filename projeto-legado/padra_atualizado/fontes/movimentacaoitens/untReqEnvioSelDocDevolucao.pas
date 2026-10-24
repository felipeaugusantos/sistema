unit untReqEnvioSelDocDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, UniClientDataSet, MemDS, DBAccess, Uni,
  untCadLote, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmReqEnvioSelDocDevolucao = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    cxGridDocumentosEntradaLevel1: TcxGridLevel;
    cxGridDocumentosEntradaTableView1: TcxGridDBTableViewCitel;
    cxGridDocumentosEntrada: TcxGridCitel;
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    columnCodigo: TcxGridDBColumn;
    columnDesIte: TcxGridDBColumn;
    columnReferencia: TcxGridDBColumn;
    columnUnidade: TcxGridDBColumn;
    columnQtdSaida: TcxGridDBColumn;
    columnQtdDevolvida: TcxGridDBColumn;
    columnQtdPendente: TcxGridDBColumn;
    columnQtdaDevolver: TcxGridDBColumn;
    dtsDocDevol: TDataSource;
    columnMardes: TcxGridDBColumn;
    btnConsultaDevolvidos: TBitBtnLocked;
    lblLegenda: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure cxGridDocumentosEntradaTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocumentosEntradaTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure columnQtdaDevolverPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnConsultaDevolvidosClick(Sender: TObject);
  private
    { Private declarations }
    cdsDocDevolucao: TUniClientDataSet;
    cdsTemporaria : TUniClientDataSet;
    objCadLot     : TCadLot;
    intDecQtd: Integer;
    procedure pMarcarDesmarcar(blnMarcar: Boolean;fltVlrAtual:Double = 0);
    procedure pSetCasaDecimalCxGrid(column:TcxGridDBColumn);
  public
    { Public declarations }

    strNumDoc, strEspDoc, strCodEmp : String; // Alimentado pela tela ReqEnvioMatVidro
    fltDesOpeCli: Double;                     // Alimentado pela tela ReqEnvioMatVidro
    strTabPreGlobal : String;                // Alimentado pela tela ReqEnvioMatVidro
    procedure pSetTemporaria(Var cdsTemp: TUniClientDataSet);  //Ponteiro do CDS da tela  ReqEnvioMatVidro
    class function fGetSQLDocumentosDevolucao(strNumDoc, strEspdoc, strCodEmp : String) : String;
  end;

implementation

uses StrUtils, untFuncoesSimples, untParCalculaPrecoCusto,
untTConfiguracao, untReqEnvioMatVidro, untReqEnvioMatVidroSelDoc,
untFuncoesRel, untFuncoesRel2, untTFatEntregaFutura, untIFatEntregaFutura;

{$R *.dfm}

procedure TfrmReqEnvioSelDocDevolucao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsDocDevolucao) Then
    FreeAndNil(cdsDocDevolucao);

  If Assigned(objCadLot) Then
    FreeAndNil(objCadLot);

end;

procedure TfrmReqEnvioSelDocDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  objCadLot := TCadLot.Create(Self);
end;

procedure TfrmReqEnvioSelDocDevolucao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
 Case Key Of
   VK_F10 : btnGravar.Click;
   VK_F6  : btnMarcar.Click;
   VK_F7  : btnDesmarcar.Click;
   VK_F8  : btnConsultaDevolvidos.Click;
   VK_ESCAPE : btnSair.Click;
 End;
end;

procedure TfrmReqEnvioSelDocDevolucao.FormShow(Sender: TObject);
  Var
  qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery(Nil);

  With qryAux, SQL Do
  Begin
    Add(fGetSQLDocumentosDevolucao(strNumdoc,strEspDoc,strCodEmp));
    Open;
    Filter   := 'QTDPEN > 0';
    Filtered := True;
  End;

  cdsDocDevolucao     := fCriaClientDatset(qryAux);
  dtsDocDevol.DataSet := cdsDocDevolucao;
  FreeAndNil(qryAux);

  intDecQtd  := fCfgSis('DECQTD', varInteger);
  pSetCasaDecimalCxGrid(columnQtdaDevolver);
  pSetCasaDecimalCxGrid(columnQtdSaida);
  pSetCasaDecimalCxGrid(columnQtdDevolvida);
  pSetCasaDecimalCxGrid(columnQtdPendente);
  pSetCasaDecimalCxGrid(columnQtdDevolvida);
end;

procedure TfrmReqEnvioSelDocDevolucao.pSetCasaDecimalCxGrid(
  column: TcxGridDBColumn);
begin
 column.PropertiesClass := TcxCurrencyEditProperties;
 TcxCurrencyEditProperties(column.Properties).DecimalPlaces := intDecQtd;
 TcxCurrencyEditProperties(column.Properties).DisplayFormat := '0.'+fStrZero('',intDecQtd);
end;

procedure TfrmReqEnvioSelDocDevolucao.pSetTemporaria(
  var cdsTemp: TUniClientDataSet);
begin
  cdsTemporaria := cdsTemp;
end;

procedure TfrmReqEnvioSelDocDevolucao.pMarcarDesmarcar(blnMarcar: Boolean;fltVlrAtual:Double = 0);
  Var
  blnTemQtdPend : Boolean;
begin
 With cdsDocDevolucao Do
  Begin
    If IsEmpty Then
      Exit;

    blnTemQtdPend := (FieldByName('QTDPEN').AsFloat <> 0);

    Edit;
    If blnTemQtdPend Then
      FieldByName('MARDES').AsString := IfThen(blnMarcar,'M','D');

    If (blnMarcar) And (blnTemQtdPend) Then
    Begin
      If fltVlrAtual <> 0 Then
        FieldByName('QTDDEVOLVER').AsFloat := fltVlrAtual
      Else
        FieldByName('QTDDEVOLVER').AsFloat := FieldByName('QTDPEN').AsFloat
    End
    Else
      FieldByName('QTDDEVOLVER').AsFloat := 0;

    Post;
  End;
end;

procedure TfrmReqEnvioSelDocDevolucao.btnConsultaDevolvidosClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(162, 7282, [],
                        ['NUMDOC','ESPDOC','CODEMP'],
                        [strNumDoc,
                        strEspDoc,
                        strCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmReqEnvioSelDocDevolucao.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  cdsDocDevolucao.First;
  While Not cdsDocDevolucao.Eof Do
  Begin
     pMarcarDesmarcar(false);
     cdsDocDevolucao.Next;
  End;
end;

procedure TfrmReqEnvioSelDocDevolucao.btnGravarClick(Sender: TObject);

  function fGetSqlIteGer: String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  G.*, ';
    Result := Result + '  C.*  ';
    Result := Result + 'FROM ';
    Result := Result + '  ITEGER G ';
    Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
    Result := Result + 'WHERE ';
    Result := Result + '  G.ITE_CODITE = :CODITE AND ';
    Result := Result + '  G.ITE_CODEMP = :CODEMP ';
  end;

  Var
  recItems :  TRecItemsEnvioMaterial;
  recParametros:TRecParametrosEnvioMaterial;
  strTabPre: String;
  qryConIte: TUniQuery;
begin
  inherited;

  qryConIte := fCriaQuery(Self);
  With qryConIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSqlIteGer);
    ParamByName('CODITE').AsString := cdsDocDevolucao.FieldByName('DET_CODITE').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

 cdsDocDevolucao.Filter   := 'MARDES = ' +QuotedStr('M');
 cdsDocDevolucao.Filtered := True;
 With cdsDocDevolucao Do
 Begin

   First;
   While Not Eof Do
   Begin
     strTabPre := cdsDocDevolucao.FieldByName('DET_TABPRE').AsString;

     If fEmptyStr(strTabPre) Then
       strTabPre := strTabPreGlobal;

     With recParametros Do
     Begin
       strCodIte := FieldByName('DET_CODITE').AsString;
       strEntSai := 'E';

       If fUsaQtdPendenteEntregaFutura Then
         fltSaldos := qryConIte.FieldByName('ITE_SALDOS').AsFloat  +
                                                   TEntregaFutura.New(
                                                     TParamEF.New()
                                                       .CodIte(strCodIte)
                                                       .CodEmp(VS_strCodEmp)
                                                       .TipoTE(tteTodas)
                                                     ).Total()
       Else
         fltSaldos := qryConIte.FieldByName('ITE_SALDOS').AsFloat;


       {*CASO TENHA LOTE O ITEM*}
       If Not fEmptyStr(FieldByName('DET_NUMLOT').AsString) Then
         fltSaldos := objCadLot.fSaldoLote(FieldByName('DET_CODITE').AsString,
                                      VS_strCodEmp, FieldByName('DET_NUMLOT').AsString);

       fltQtdIte   := cdsDocDevolucao.FieldByName('QTDDEVOLVER').AsFloat;
       fltQtdPec   := FieldByName('DET_QTDPEC').AsFloat;
       fltComPec   := FieldByName('DET_COMPEC').AsFloat;
       fltLarPec   := FieldByName('DET_LARPEC').AsFloat;
       fltUnitar   := qryConIte.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
       fltTotIte   := cdsDocDevolucao.FieldByName('QTDDEVOLVER').AsFloat *   qryConIte.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
       strNumLote  := FieldByName('DET_NUMLOT').AsString;
       fltDesOpeCli:= fltDesOpeCli;
     End;

     TfrmReqEnvioMatVidro.pPreencheRecordItemsTemporaria(recItems,recParametros);

     TfrmReqEnvioMatVidro.pAdicionaItem(recItems,cdsTemporaria);
     Next;
   End;
 End;

 If cdsDocDevolucao.IsEmpty Then
 Begin
   fMensagem('Atenção!','É necessário selecionar ao menos um item!', ['&Ok']);
   cdsDocDevolucao.Filter   := '';
   cdsDocDevolucao.Filtered := False;
   Exit;
 End;

 cdsDocDevolucao.Filter   := '';
 cdsDocDevolucao.Filtered := False;
 Close;
end;

procedure TfrmReqEnvioSelDocDevolucao.btnMarcarClick(Sender: TObject);
begin
  inherited;
  With cdsDocDevolucao Do
  Begin
    First;
    While Not Eof Do
    Begin
       pMarcarDesmarcar(true);
       Next;
    End;
  End;
end;

procedure TfrmReqEnvioSelDocDevolucao.btnSairClick(Sender: TObject);
begin
 inherited;
  Close;
end;

procedure TfrmReqEnvioSelDocDevolucao.columnQtdaDevolverPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If DisplayValue <> 0 Then
  Begin
    If DisplayValue > cdsDocDevolucao.FieldByName('QTDPEN').AsFloat Then
    Begin
      fMensagem('Atenção!','Não é possível devolver mais do que a quantidade pendente!',['&O K']);
      DisPlayValue := 0;
    End
    Else If DisplayValue < 0 Then
    Begin
      fMensagem('Atenção!','Não é possível devolver menos do que a quantidade pendente!',['&O K']);
      DisPlayValue := 0;
    End;
    pMarcarDesmarcar(true,DisplayValue);
  End
  Else
    pMarcarDesmarcar(false);
end;

procedure TfrmReqEnvioSelDocDevolucao.cxGridDocumentosEntradaTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, columnMardes.Index]) = 'M' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;
end;

procedure TfrmReqEnvioSelDocDevolucao.cxGridDocumentosEntradaTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_SPACE Then
    pMarcarDesmarcar(cdsDocDevolucao.FieldByName('MARDES').AsString = 'D');
end;

class function TfrmReqEnvioSelDocDevolucao.fGetSQLDocumentosDevolucao(strNumDoc, strEspdoc, strCodEmp : String) : String;
begin
  Result := '';
  Result := Result  + ' SELECT ';
  Result := Result  + ' DET_QTDPEC, ';
  Result := Result  + ' DET_COMPEC, ';
  Result := Result  + ' DET_LARPEC, ';
  Result := Result  + ' DET_NUMLOT, ';
  Result := Result  + ' DET_TABPRE, ';
  Result := Result  + ' DET_CODITE, ';
  Result := Result  + ' DET_UNIDAD, ';
  Result := Result  + ' DET_DESCRI, ';
  Result := Result  + ' DET_REFERE, ';
  Result := Result  + ' SUM(IF(DET_CLAFIS > "5000",DET_QTDITE,0)) AS QTDSAI, ';
  Result := Result  + ' SUM(IF(DET_CLAFIS < "5000",DET_QTDITE,0)) AS QTDDEV, ';
  Result := Result  + ' IF(SUM(IF(DET_CLAFIS > "5000",DET_QTDITE,0)) - SUM(IF(DET_CLAFIS < "5000",DET_QTDITE ,0)) < 0, 0,'+
                          'SUM(IF(DET_CLAFIS > "5000",DET_QTDITE,0)) - SUM(IF(DET_CLAFIS < "5000",DET_QTDITE ,0)) )  AS QTDPEN, ';
  Result := Result  + ' 0.00 AS QTDDEVOLVER, ';
  Result := Result  + ' "D" AS MARDES,  ';
  Result := Result  + ' IF(SUM( IF(DET_CLAFIS > "5000", DET_QTDITE, 0)) - SUM(IF(DET_CLAFIS < "5000", DET_QTDITE, 0)) <= 0,"Total","Parcial") AS LEGENDA';
  Result := Result  + ' FROM      ';
  Result := Result  + '  MOVDET ';
  Result := Result  + '  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result  + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE    ';
  Result := Result  + '  LEFT  JOIN MOVMAD ON MOVMAD.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result  + 'WHERE     ';
  Result := Result  + '  DET_NUMFAT = ' + QuotedStr(strNumDoc) + ' AND ';
  Result := Result  + '  DET_TIPFAT = ' + QuotedStr(strEspDoc) + ' AND ';
  Result := Result  + '  DET_EMPFAT = ' + QuotedStr(strCodEmp) + ' AND ';
  Result := Result  + '  DET_ESPDOC = ' + QuotedStr('RQ');
  Result := Result  + '  GROUP BY DET_CODITE ';
  Result := Result  + '  ORDER BY DET_CODITE ';
end;

end.
