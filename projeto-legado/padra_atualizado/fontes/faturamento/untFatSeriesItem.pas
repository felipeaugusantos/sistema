unit untFatSeriesItem;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet, untFuncoesSimples,
{$ENDIF}
  System.Classes, System.SysUtils, untTypesSistema, Data.DB, Uni, Variants;

type
  TFatSerieItem = class(TComponent)
  private
    { private declarations }
    FcdsFatSeries: TUniClientDataSet;
    FcdsSeries: TUniClientDataSet;
    FAutoincItem: String;
    FChamouPeloCtrlF3DoCaixa: Boolean;
    FChamouPeloAjusteEstoque: BOolean;

    procedure pCriaDataSet;
    function fGetSeriesUtilizadasEmOutroFaturamento(const ACodIte, AAutIncPedido, AAutIncItem : String): TUniQuery;
    function fSerieJaInserida(const ANumSer : String; blnCdsGravacao: Boolean = False) : Boolean;
    procedure pAtualizaSerieJaInseridaComQuantidadeZero(const ANumSer: String; const ANovaQtd : Double; blnCdsGravacao: Boolean = False);

  protected
    { protected declarations }
  public
    { public declarations }
    property cdsFatSeries: TUniClientDataSet read FcdsFatSeries;
    property cdsSeries: TUniClientDataSet read FcdsSeries;
    property AutoincItem: String read FAutoincItem write FAutoincItem;
    property ChamouPeloCtrlF3DoCaixa: Boolean read FChamouPeloCtrlF3DoCaixa write FChamouPeloCtrlF3DoCaixa;
    property ChamouPeloAjusteEstoque: Boolean read FChamouPeloAjusteEstoque write FChamouPeloAjusteEstoque;

    procedure pFiltraDataSet;
    procedure pFiltraDataSetSeries;
    procedure pCarregaSeriesItem(const ACodIte: String; ACodEmp: String = ''; const ASeqFdo: String = ''; const AAutIncPedido : String = '');
    procedure pPreencheMatriz(var AMatrizSeries: TMatrizSeries);
    procedure pApagaSeries;
    procedure pApagaSeriesGravacao;
    procedure pLimparDigitacaoDeSeries;
    procedure pInsereSerie(const ANumSer: String; const AQtdSer: Double);
    procedure pInsereSerieParaGravacao(const ANumSer: String; const AQtdSer: Double);
    procedure pDeletaSerieDoItem;
    function fGetTotQuant: Double;
    function fGetTotQuantSerie: Double;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TFatSerieItem }

constructor TFatSerieItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ChamouPeloCtrlF3DoCaixa := False;
  ChamouPeloAjusteEstoque := False;
  pCriaDataSet;
end;

destructor TFatSerieItem.Destroy;
begin
  FreeAndNil(FcdsFatSeries);
  FreeAndNil(FcdsSeries);
  inherited;
end;

function TFatSerieItem.fGetTotQuant: Double;
begin
  Result := IfNull(FcdsFatSeries.FieldByName('SUM_QTDSER').Value, 0);
end;

function TFatSerieItem.fGetTotQuantSerie: Double;
begin
  Result := IfNull(FcdsSeries.FieldByName('SUM_QTDSER').Value, 0);
end;

procedure TFatSerieItem.pApagaSeries;
begin
  pFiltraDataSet;

  FcdsFatSeries.First;
  While Not FcdsFatSeries.Eof Do
    FcdsFatSeries.Delete;
end;

procedure TFatSerieItem.pApagaSeriesGravacao;
begin
  pFiltraDataSetSeries;

  FcdsSeries.First;
  While Not FcdsSeries.Eof Do
    FcdsSeries.Delete;
end;

procedure TFatSerieItem.pCarregaSeriesItem(const ACodIte: String;
  ACodEmp: String = ''; const ASeqFdo: String = ''; const AAutIncPedido : String = '');
  Var
    LqryPed: TUniQuery;
    LAutIncBkp: String;
    LSerUti : TUniQuery;
begin
  LqryPed := fCriaQuery;
  Try
    LqryPed.SQL.Add('SELECT NUMSER, SUM(QTDSER) AS QTDSER');
    LqryPed.SQL.Add('FROM( ');
    LqryPed.SQL.Add('  SELECT P.SER_NUMSER AS NUMSER,');
    LqryPed.SQL.Add('         0.00 AS QTDSER');
    LqryPed.SQL.Add('  FROM PROSER P');
    LqryPed.SQL.Add('  WHERE P.SER_CODITE = :CODITE');
    LqryPed.SQL.Add('    AND P.SER_CODEMP = :CODEMP');

    If Not fEmptyStr(ASeqFdo) Then
    Begin
      LqryPed.SQL.Add('  UNION');
      LqryPed.SQL.Add('  SELECT N.NSE_NUMSER AS NUMSER,');
      LqryPed.SQL.Add('         N.NSE_QTDSER AS QTDSER');
      LqryPed.SQL.Add('  FROM NSEDOR N');
      LqryPed.SQL.Add('  WHERE N.NSE_SEQFDO = :SEQFDO');
      LqryPed.SQL.Add('  AND N.NSE_NUMSER NOT IN (SELECT D.SER_NUMSER FROM DETSER D INNER JOIN MOVDET M ON D.SER_SEQGER = M.AUTOINCREM WHERE M.DET_CODITE = :CODITE AND M.DET_CLAFIS > "5000" AND M.DET_TIP_FC = "C")');
    End;

    LqryPed.SQL.Add(') AS CONS');
    LqryPed.SQL.Add('GROUP BY NUMSER');
    LqryPed.SQL.Add('ORDER BY NUMSER');

    LqryPed.ParamByName('CODITE').AsString := ACodIte;
    LqryPed.ParamByName('CODEMP').AsString := IIF(fEmptyStr(ACodEmp), VS_strCodEmp, ACodEmp);
    If Not fEmptyStr(ASeqFdo) Then
      LqryPed.ParamByName('SEQFDO').AsString := ASeqFdo;
    LqryPed.Open;

    pApagaSeries;

    If Not fEmptyStr(ASeqFdo) Then
      pApagaSeriesGravacao;

    LqryPed.First;
    While Not LqryPed.Eof Do
    Begin
      If Not FcdsSeries.Locate('NUMSER', LqryPed.FieldByName('NUMSER').AsString,[]) Then
      Begin
        pInsereSerie(LqryPed.FieldByName('NUMSER').AsString,
                     LqryPed.FieldByName('QTDSER').AsFloat);


        If LqryPed.FieldByName('QTDSER').AsFloat > 0 Then
          pInsereSerieParaGravacao(LqryPed.FieldByName('NUMSER').AsString,
                                  LqryPed.FieldByName('QTDSER').AsFloat);
      End
      Else If (ChamouPeloCtrlF3DoCaixa) And (FcdsSeries.FieldByName('QTDSER').AsFloat > 0) Then
      Begin
        pInsereSerie(FcdsSeries.FieldByName('NUMSER').AsString,
                     FcdsSeries.FieldByName('QTDSER').AsFloat);
      End
      Else If (ChamouPeloAjusteEstoque) And (FcdsSeries.FieldByName('QTDSER').AsFloat > 0) Then
      Begin
        LAutIncBkp := FAutoincItem;
        FAutoincItem := FcdsSeries.FieldByName('AUTINC').AsString;

        pInsereSerie(FcdsSeries.FieldByName('NUMSER').AsString,
                     FcdsSeries.FieldByName('QTDSER').AsFloat);

        FAutoincItem := LAutIncBkp;
      End;

      LqryPed.Next;
    End;
  Finally
    FreeAndNil(LqryPed);
  End;

  If (Not fEmptyStr(AAutIncPedido)) And (Not fEmptyStr(ASeqFdo)) Then
  Begin
    LSerUti := fGetSeriesUtilizadasEmOutroFaturamento(ACodIte, AAutIncPedido, ASeqFdo);
    Try
      LSerUti.First;
      While Not LSerUti.Eof Do
      Begin
        If (fSerieJaInserida(LSerUti.FieldByName('NUMSER').AsString)) Then
        Begin
          pAtualizaSerieJaInseridaComQuantidadeZero(LSerUti.FieldByName('NUMSER').AsString,
                                                    LSerUti.FieldByName('QTDSER').AsFloat);
        End
        Else
        Begin
          pInsereSerie(LSerUti.FieldByName('NUMSER').AsString,
                       LSerUti.FieldByName('QTDSER').AsFloat);
        End;

        If (LSerUti.FieldByName('QTDSER').AsFloat > 0) Then
        Begin
          If (fSerieJaInserida(LSerUti.FieldByName('NUMSER').AsString, True)) Then
          Begin
            pAtualizaSerieJaInseridaComQuantidadeZero(LSerUti.FieldByName('NUMSER').AsString,
                                                      LSerUti.FieldByName('QTDSER').AsFloat,
                                                      True);
          End
          Else
          Begin
            pInsereSerieParaGravacao(LSerUti.FieldByName('NUMSER').AsString,
                                     LSerUti.FieldByName('QTDSER').AsFloat);
          End;
        End;

        LSerUti.Next;
      End;
    Finally
      FreeAndNil(LSerUti);
    End;
  End;
end;

procedure TFatSerieItem.pCriaDataSet;
begin
  FcdsFatSeries := TUniClientDataSet.Create(Self);

  //AUTINC pode receber tanto o AUTOINCREM do frmFatVendas.cdsVenda (integer), quanto o AUTOINCREM da FATDOR (string)
  FcdsFatSeries.FieldDefs.Add('AUTINC', ftString, 20);
  FcdsFatSeries.FieldDefs.Add('NUMSER', ftString, 30);
  FcdsFatSeries.FieldDefs.Add('QTDSER', ftFloat);

  pCriaAggregate(FcdsFatSeries, 'QTDSER', 'SUM_QTDSER');

  FcdsFatSeries.CreateDataSet;
  FcdsFatSeries.LogChanges := False;
  FcdsFatSeries.AggregatesActive := True;

  FcdsSeries := TUniClientDataSet.Create(Self);
  FcdsSeries.FieldDefs.Add('AUTINC', ftString, 20);
  FcdsSeries.FieldDefs.Add('NUMSER', ftString, 30);
  FcdsSeries.FieldDefs.Add('QTDSER', ftFloat);
  pCriaAggregate(FcdsSeries, 'QTDSER', 'SUM_QTDSER');
  pCloneDataSet(FcdsSeries, FcdsFatSeries);
  FcdsSeries.LogChanges := False;
  FcdsSeries.AggregatesActive := True;
end;

procedure TFatSerieItem.pDeletaSerieDoItem;
begin
  While cdsSeries.Locate('AUTINC', FAutoincItem, []) Do
    cdsSeries.Delete;
end;

procedure TFatSerieItem.pFiltraDataSet;
begin
  FcdsFatSeries.Filtered := False;
  FcdsFatSeries.Filter   := 'AUTINC = '+ FAutoincItem.QuotedString;
  FcdsFatSeries.Filtered := True;
end;

procedure TFatSerieItem.pFiltraDataSetSeries;
begin
  FcdsSeries.Filtered := False;
  FcdsSeries.Filter   := 'AUTINC = '+ FAutoincItem.QuotedString;
  FcdsSeries.Filtered := True;
end;

procedure TFatSerieItem.pInsereSerie(const ANumSer: String; const AQtdSer: Double);
begin
  if FcdsFatSeries.Locate('AUTINC;NUMSER', VarArrayOf([FAutoincItem, ANumSer]),[]) then
  begin
    FcdsFatSeries.Edit;
    FcdsFatSeries.FieldByName('QTDSER').AsFloat  := AQtdSer;
    FcdsFatSeries.Post;
  end
  else
  begin
    FcdsFatSeries.Append;
    FcdsFatSeries.FieldByName('AUTINC').AsString := FAutoincItem;
    FcdsFatSeries.FieldByName('NUMSER').AsString := ANumSer;
    FcdsFatSeries.FieldByName('QTDSER').AsFloat  := AQtdSer;
    FcdsFatSeries.Post;
  end;
end;

procedure TFatSerieItem.pInsereSerieParaGravacao(const ANumSer: String;
  const AQtdSer: Double);
begin
  If FcdsSeries.Locate('AUTINC;NUMSER', VarArrayOf([FAutoincItem, ANumSer]),[]) Then
  Begin
    FcdsSeries.Edit;
    FcdsSeries.FieldByName('QTDSER').AsFloat  := AQtdSer;
    FcdsSeries.Post;
  End
  Else
  Begin
    FcdsSeries.Append;
    FcdsSeries.FieldByName('AUTINC').AsString := FAutoincItem;
    FcdsSeries.FieldByName('NUMSER').AsString := ANumSer;
    FcdsSeries.FieldByName('QTDSER').AsFloat  := AQtdSer;
    FcdsSeries.Post;
  End;
end;

procedure TFatSerieItem.pLimparDigitacaoDeSeries;
begin
  pFiltraDataSet;
  FcdsFatSeries.First;
  While Not FcdsFatSeries.Eof Do
  Begin
    FcdsFatSeries.Edit;
    FcdsFatSeries.FieldByName('QTDSER').AsFloat := 0;
    FcdsFatSeries.Post;
    FcdsFatSeries.Next;
  End;
end;

procedure TFatSerieItem.pPreencheMatriz(var AMatrizSeries: TMatrizSeries);
  Var
    LCont: Integer;
begin
  SetLength(AMatrizSeries, 0);
  FillChar(AMatrizSeries, SizeOf(AMatrizSeries), #0);

  pFiltraDataSetSeries;
  Try
    If FcdsSeries.IsEmpty Then
      Exit;

    LCont := 0;

    FcdsSeries.First;
    While Not FcdsSeries.Eof Do
    Begin
      If FcdsSeries.FieldByName('QTDSER').AsFloat > 0 Then
      Begin
        SetLength(AMatrizSeries, LCont +1);
        AMatrizSeries[LCont].strNumSer := FcdsSeries.FieldByName('NUMSER').AsString;
        AMatrizSeries[LCont].fltQtdSer := FcdsSeries.FieldByName('QTDSER').AsFloat;
        Inc(LCont);
      End;

      FcdsSeries.Next;
    End;
  Finally
    FcdsSeries.Filtered := False;
  End;
end;

function TFatSerieItem.fGetSeriesUtilizadasEmOutroFaturamento(const ACodIte, AAutIncPedido, AAutIncItem : String): TUniQuery;
begin
  Result := fCriaQuery;

  Try
    Result.SQL.Clear;
    Result.SQL.Add(' SELECT DETSER.SER_NUMSER AS NUMSER, CONCAT(MOVDET.DET_NUMDOC, "-", MOVDET.DET_ESPDOC, "-", MOVDET.DET_CODEMP) AS DOCFAT, NSE_QTDSER AS QTDSER ');
    Result.SQL.Add('   FROM DETSER ');
    Result.SQL.Add('   JOIN MOVDET ON DETSER.SER_SEQGER = MOVDET.AUTOINCREM ');
    Result.SQL.Add('              AND MOVDET.DET_CODITE = :CODITE ');
    Result.SQL.Add('              AND MOVDET.DET_CLAFIS > "5000" ');
    Result.SQL.Add('              AND MOVDET.DET_TIP_FC = "C"    ');
    Result.SQL.Add('   JOIN FATDOR ON FATDOR.FDO_NUMDOC = MOVDET.DET_NUM_PD ');
    Result.SQL.Add('              AND FATDOR.FDO_ESPDOC = MOVDET.DET_ESP_PD ');
    Result.SQL.Add('              AND FATDOR.FDO_CODEMP = MOVDET.DET_EMP_PD ');
    Result.SQL.Add('              AND FATDOR.FDO_CODITE = MOVDET.DET_CODITE ');
    Result.SQL.Add('   JOIN NSEDOR ON DETSER.SER_NUMSER = NSEDOR.NSE_NUMSER AND NSEDOR.NSE_SEQFDO = :INCDOR ');
    Result.SQL.Add('  WHERE FATDOR.FDO_SEQGER <> :SEQGER ');

    Result.ParamByName('CODITE').AsString := ACodIte;
    Result.ParamByName('SEQGER').AsString := AAutIncPedido;
    Result.ParamByName('INCDOR').AsString := AAutIncItem;

    Result.Open;
  Except
    FreeAndNil(Result);
    Raise;
  End;
end;

function TFatSerieItem.fSerieJaInserida(const ANumSer: String; blnCdsGravacao: Boolean = False): Boolean;
begin
  If blnCdsGravacao Then
    Result := FcdsSeries.Locate('NUMSER', ANumSer, [])
  Else
    Result := FcdsFatSeries.Locate('NUMSER', ANumSer, []);
end;

procedure TFatSerieItem.pAtualizaSerieJaInseridaComQuantidadeZero(const ANumSer: String; const ANovaQtd : Double; blnCdsGravacao: Boolean = False);
var
  LcdsSeries: TUniClientDataSet;
begin
  If blnCdsGravacao Then
    LcdsSeries := FcdsSeries
  Else
    LcdsSeries := FcdsFatSeries;

  If (Not LcdsSeries.Locate('NUMSER', ANumSer, [])) Then
    Exit;

  If (fFormataFloat(LcdsSeries.FieldByName('QTDSER').AsFloat, 4) > 0) Then
    Exit;

  LcdsSeries.Edit;
  LcdsSeries.FieldByName('QTDSER').AsFloat := ANovaQtd;
  LcdsSeries.Post;
end;

end.
