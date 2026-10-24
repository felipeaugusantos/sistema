unit untDivergenciasDevAD;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untIFuncoes,
{$ENDIF}
  SysUtils, Classes, Uni, Math;

Type
  TDivergencia = class;

  TDivergencias = class
    private
      lstDivergencias: TList;
      function GetItem(Index: Integer): TDivergencia;
    public
      constructor Create;
      destructor Destroy; override;

      procedure pAdiciona(strCodIte, strDesIte, strUnidad: String;
        fltQtdDev, fltUniDev, fltTotDev, fltQtdAde, fltUniAde, fltTotAde: Double);

      function Count: Integer;
      property Items[Index: Integer]: TDivergencia Read GetItem; default;
  end;

  TDivergencia = class
    private
      FCodIte: String;
      FDesIte: String;
      FUnidad: String;

      FQtdDev: Double;
      FUniDev: Double;
      FTotDev: Double;

      FQtdAde: Double;
      FUniAde: Double;
      FTotAde: Double;

      function GetQtdDif: Double;
      function GetTotDif: Double;
      function GetUniDif: Double;
    public
      constructor Create(strCodIte, strDesIte, strUnidad: String;
        fltQtdDev, fltUniDev, fltTotDev, fltQtdAde, fltUniAde, fltTotAde: Double);


      property strCodIte: String Read FCodIte;
      property strDesIte: String Read FDesIte;
      property strUnidad: String Read FUnidad;

      property fltQtdDev: Double Read FQtdDev;
      property fltUniDev: Double Read FUniDev;
      property fltTotDev: Double Read FTotDev;

      property fltQtdAde: Double Read FQtdAde;
      property fltUniAde: Double Read FUniAde;
      property fltTotAde: Double Read FTotAde;

      property fltQtdDif: Double Read GetQtdDif;
      property fltUniDif: Double Read GetUniDif;
      property fltTotDif: Double Read GetTotDif;
  end;

  function fRetornaInconsistencias(strNumAde: String;
    strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String;
    blnMostrarTodos: Boolean): TDivergencias;

  function fRetornaStringInconsistencias(strNumAde: String;
    strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String): String;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untConstantes;

function fRetornaStringInconsistencias(strNumAde: String;
  strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String): String;
  Var
    divergencias: TDivergencias;
    intContador: Integer;

  function fQtd(fltValor: Double): String;
  begin
    Result := FloatToStrF(fltValor, ffNumber, 12, fCfgSis('DECQTD', varInteger))
  end;

begin
  Result := '';
  divergencias := fRetornaInconsistencias(strNumAde, strTabela, strNumDoc,
    strEspDoc, strCodEmp, strCodCli, strSerie, False);

  For intContador := 0 To divergencias.Count -1 Do
  Begin
    If divergencias[intContador].fltQtdDif < 0 Then
    Begin
      Result := Result + 'Item ' + divergencias[intContador].strCodIte +
        ' faltando na DV (' + fQtd(Abs(divergencias[intContador].fltQtdDif)) + ')' + STRING_QUEBRA;
    End
    Else
    Begin
      Result := Result + 'Item ' + divergencias[intContador].strCodIte +
        ' a mais na DV (' + fQtd(Abs(divergencias[intContador].fltQtdDif)) + ')' + STRING_QUEBRA;
    End;
  End;

  FreeAndNil(divergencias);
end;

function fRetornaInconsistencias(strNumAde: String;
  strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String;
  blnMostrarTodos: Boolean): TDivergencias;
  Var
    qryAD: TUniQuery;
    qryDev: TUniQuery;
    fltDifQtd: Double;
    fltDifUni: Double;
begin
  Result := TDivergencias.Create;
  qryAD  := fCriaQuery(Nil);
  qryDev := fCriaQuery(Nil);

  qryAD.SQL.Add('SELECT ');
  qryAD.SQL.Add('  DET_CODITE, ');
  qryAD.SQL.Add('  DET_DESCRI, ');
  qryAD.SQL.Add('  UNI_SIGUNI, ');
  qryAD.SQL.Add('  SUM(DET_QTDITE) AS DET_QTDITE, ');
  qryAD.SQL.Add('  DET_UNITAR, ');
  qryAD.SQL.Add('  ROUND(SUM(DET_TOTITE), 2) AS DET_TOTITE ');

  qryAD.SQL.Add(' FROM ( ');

  qryAD.SQL.Add('SELECT DISTINCT ');
  qryAD.SQL.Add('  A.AUTOINCREM, ');
  qryAD.SQL.Add('  A.DET_CODITE, ');
//  qryAD.SQL.Add('  D.DET_DESCRI, ');
  qryAD.SQL.Add('  C.ITE_DESITE AS DET_DESCRI, ');
  qryAD.SQL.Add('  U.UNI_SIGUNI, ');
  qryAD.SQL.Add('  A.DET_QTDDEV AS DET_QTDITE, ');
  qryAD.SQL.Add('  A.DET_UNIDEV AS DET_UNITAR, ');
  qryAD.SQL.Add('  A.DET_QTDDEV * A.DET_UNIDEV AS DET_TOTITE ');
  qryAD.SQL.Add('FROM ');
  qryAD.SQL.Add('  ADEDET A ');
  qryAD.SQL.Add('  LEFT JOIN CADITE C ON A.DET_CODITE = C.ITE_CODITE ');
//  qryAD.SQL.Add('  LEFT JOIN MOVDET D ON D.DET_NUMDOC = A.DET_NUMDOC AND ');
//  qryAD.SQL.Add('                   D.DET_ESPDOC = A.DET_ESPDOC AND ');
//  qryAD.SQL.Add('                   D.DET_CODEMP = A.DET_CODEMP AND ');
//  qryAD.SQL.Add('                   D.DET_CODCLI = A.DET_FORCLI AND ');
//  qryAD.SQL.Add('                   D.DET_TIP_FC = A.DET_TIP_FC AND ');
//  qryAD.SQL.Add('                   IFNULL(D.DET_SERIE_, "") = IFNULL(A.DET_SERIE_, "") AND ');
//  qryAD.SQL.Add('                   D.DET_CODITE = A.DET_CODITE ');
  qryAD.SQL.Add('  LEFT JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI ');
  qryAD.SQL.Add('WHERE ');
  qryAD.SQL.Add('  A.DET_CODADE = :CODADE AND ');
  qryAD.SQL.Add('  A.DET_CODEMP = :CODEMP ');

  qryAD.SQL.Add(' ) AS TAB ');

  qryAD.SQL.Add('GROUP BY ');
  qryAD.SQL.Add('  DET_CODITE, DET_UNITAR ');
  qryAD.SQL.Add('ORDER BY ');
  qryAD.SQL.Add('  DET_CODITE ');

  qryDev.SQL.Add('SELECT ');
  qryDev.SQL.Add('  D.DET_CODITE, ');
  qryDev.SQL.Add('  D.DET_DESCRI, ');
  qryDev.SQL.Add('  U.UNI_SIGUNI, ');
  qryDev.SQL.Add('  SUM(D.DET_QTDITE) AS DET_QTDITE, ');
  qryDev.SQL.Add('  D.DET_UNITAR, ');
  qryDev.SQL.Add('  SUM(D.DET_TOTITE) AS DET_TOTITE ');
  qryDev.SQL.Add('FROM ');
  qryDev.SQL.Add('  ' + strTabela + ' D ');
  qryDev.SQL.Add('  JOIN CADUNI U ON U.UNI_CODUNI = D.DET_UNIDAD ');
  qryDev.SQL.Add('WHERE ');
  qryDev.SQL.Add('  D.DET_NUMDOC = :NUMDOC AND ');
  qryDev.SQL.Add('  D.DET_ESPDOC = :ESPDOC AND ');
  qryDev.SQL.Add('  D.DET_CODEMP = :CODEMP AND ');
  qryDev.SQL.Add('  D.DET_CODCLI = :CODCLI AND ');
  qryDev.SQL.Add('  IFNULL(D.DET_SERIE_, "") = :SERIE_ ');
  qryDev.SQL.Add('GROUP BY ');
  qryDev.SQL.Add('  DET_CODITE, DET_UNITAR ');
  qryDev.SQL.Add('ORDER BY ');
  qryDev.SQL.Add('  D.DET_CODITE ');

  qryAD.ParamByName('CODADE').AsString := strNumAde;
  qryAD.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAD.Open;

  qryDev.ParamByName('NUMDOC').AsString := strNumDoc;
  qryDev.ParamByName('ESPDOC').AsString := strEspDoc;
  qryDev.ParamByName('CODEMP').AsString := strCodEmp;
  qryDev.ParamByName('CODCLI').AsString := strCodCli;
  qryDev.ParamByName('SERIE_').AsString := strSerie;
  qryDev.Open;

  While ((Not qryAD.Eof) Or (Not qryDev.Eof)) Do
  Begin

    If (qryAD.FieldByName('DET_CODITE').AsString < qryDev.FieldByName('DET_CODITE').AsString) Then
    Begin
      If qryAD.Eof Then
      Begin
        Result.pAdiciona(qryDev.FieldByName('DET_CODITE').AsString,
                         qryDev.FieldByName('DET_DESCRI').AsString,
                         qryDev.FieldByName('UNI_SIGUNI').AsString,

                         qryDev.FieldByName('DET_QTDITE').AsFloat,
                         qryDev.FieldByName('DET_UNITAR').AsFloat,
                         qryDev.FieldByName('DET_TOTITE').AsFloat,

                         0,
                         0,
                         0);
                         
        qryDev.Next;
      End
      Else
      Begin
        Result.pAdiciona(qryAD.FieldByName('DET_CODITE').AsString,
                         qryAD.FieldByName('DET_DESCRI').AsString,
                         qryAD.FieldByName('UNI_SIGUNI').AsString,

                         0,
                         0,
                         0,

                         qryAD.FieldByName('DET_QTDITE').AsFloat,
                         qryAD.FieldByName('DET_UNITAR').AsFloat,
                         qryAD.FieldByName('DET_TOTITE').AsFloat);
      End;

      qryAD.Next;
    End

    Else If (qryDev.FieldByName('DET_CODITE').AsString < qryAD.FieldByName('DET_CODITE').AsString) Then
    Begin
      If qryDev.Eof Then
      Begin
        Result.pAdiciona(qryAD.FieldByName('DET_CODITE').AsString,
                         qryAD.FieldByName('DET_DESCRI').AsString,
                         qryAD.FieldByName('UNI_SIGUNI').AsString,

                         0,
                         0,
                         0,

                         qryAD.FieldByName('DET_QTDITE').AsFloat,
                         qryAD.FieldByName('DET_UNITAR').AsFloat,
                         qryAD.FieldByName('DET_TOTITE').AsFloat);
        qryAD.NExt;
      End
      Else
      Begin
        Result.pAdiciona(qryDev.FieldByName('DET_CODITE').AsString,
                         qryDev.FieldByName('DET_DESCRI').AsString,
                         qryDev.FieldByName('UNI_SIGUNI').AsString,

                         qryDev.FieldByName('DET_QTDITE').AsFloat,
                         qryDev.FieldByName('DET_UNITAR').AsFloat,
                         qryDev.FieldByName('DET_TOTITE').AsFloat,

                         0,
                         0,
                         0);
      End;

      qryDev.Next;

    End
    Else
    Begin
      fltDifQtd := fFormataFloat(qryDev.FieldByName('DET_QTDITE').AsFloat -
                                 qryAD.FieldByName('DET_QTDITE').AsFloat, 2);

      fltDifUni := fFormataFloat(qryDev.FieldByName('DET_UNITAR').AsFloat -
                                 qryAD.FieldByName('DET_UNITAR').AsFloat, 2);

      If (blnMostrarTodos) Or
         (fFormataFloat(fltDifQtd, 2) <> 0) Or
         (fFormataFloat(fltDifUni, 2) <> 0) Then
      Begin
        Result.pAdiciona(qryDev.FieldByName('DET_CODITE').AsString,
                         qryDev.FieldByName('DET_DESCRI').AsString,
                         qryDev.FieldByName('UNI_SIGUNI').AsString,

                         qryDev.FieldByName('DET_QTDITE').AsFloat,
                         qryDev.FieldByName('DET_UNITAR').AsFloat,
                         qryDev.FieldByName('DET_TOTITE').AsFloat,

                         qryAD.FieldByName('DET_QTDITE').AsFloat,
                         qryAD.FieldByName('DET_UNITAR').AsFloat,
                         qryAD.FieldByName('DET_TOTITE').AsFloat);
      End;

      qryAD.Next;
      qryDev.Next;
    End;

  End;

  FreeAndNil(qryAD);
  FreeAndNil(qryDev);
end;

{ TDivergencias }

function TDivergencias.Count: Integer;
begin
  Result := lstDivergencias.Count;
end;

constructor TDivergencias.Create;
begin
  Inherited;
  lstDivergencias := TList.Create;
end;

destructor TDivergencias.Destroy;
  Var
    intCont: Integer;
    objFree: TObject;
begin
  For intCont := 0 To lstDivergencias.Count-1 Do
  Begin
    objFree := lstDivergencias[intCont];
    FreeAndNil(objFree);
  End;
  lstDivergencias.Clear;
  FreeAndNil(lstDivergencias);
  
  inherited;
end;

function TDivergencias.GetItem(Index: Integer): TDivergencia;
begin
  Result := lstDivergencias[Index];
end;

procedure TDivergencias.pAdiciona(strCodIte, strDesIte, strUnidad: String;
  fltQtdDev, fltUniDev, fltTotDev, fltQtdAde, fltUniAde, fltTotAde: Double);
  Var
    divergencia: TDivergencia;
begin
  divergencia := TDivergencia.Create(strCodIte, strDesIte, strUnidad,
    fltQtdDev, fltUniDev, fltTotDev, fltQtdAde, fltUniAde, fltTotAde);
    
  lstDivergencias.Add(divergencia);
end;

{ TDivergencia }

constructor TDivergencia.Create(strCodIte, strDesIte, strUnidad: String;
  fltQtdDev, fltUniDev, fltTotDev, fltQtdAde, fltUniAde, fltTotAde: Double);
begin
  FCodIte := strCodIte;
  FDesIte := strDesIte;
  FUnidad := strUnidad;

  FQtdDev := fltQtdDev;
  FUniDev := fltUniDev;
  FTotDev := fltTotDev;

  FQtdAde := fltQtdAde;
  FUniAde := fltUniAde;
  FTotAde := fltTotAde;
end;

function TDivergencia.GetQtdDif: Double;
begin
  Result := FQtdDev - FQtdAde;
end;

function TDivergencia.GetTotDif: Double;
begin
  Result := FTotDev - FTotAde;
end;

function TDivergencia.GetUniDif: Double;
begin
  If fFormataFloat(fltQtdDif, 2) = 0 Then
    Result := 0
  Else If fFormataFloat(fltUniDev, 2) <> fFormataFloat(fltUniAde, 2) Then
  Begin
    If (
        (fFormataFloat(fltQtdAde, 2) = 0) And (fFormataFloat(fltUniAde, 2) = 0)
       ) Or (
        (fFormataFloat(fltQtdDev, 2) = 0) And (fFormataFloat(fltUniDev, 2) = 0)
       ) Then
    Begin
      Result := Max(FUniDev, FUniAde);
    End
    Else
      Result := 0
  End
  Else
    Result := Max(FUniDev, FUniAde);
end;

end.
