unit untSpoolImpressao;

interface

uses
{$if defined(LINUX)}
  DBClient, FMX.frxExportPDF, FMX.frxPreview, FMX.frxClass;
{$else}
  Vcl.Dialogs, ShellApi, Windows, Printers,
  UniClientDataSet, frxExportPDF, frxPreview, frxClass,
  untWorkStationInfo;
{$ifend}

Type
  TSpoolImpressaoCitel = class
  public const
    NomeFilaSeparator = ' >> ';
    PontoNaoImprimir = 'NÃO IMPRIMIR';
    PontoExportarPDF = 'EXPORTAR PARA PDF';
  public type
    TPontoImpressao = record
      Nome: String;
      Impressora: String;
      TipoImpressora: String;
      Status: String;
      NomeFila: String;
      ExportacaoPDF: Boolean;
      ExibirSomenteMaquinaServico: Boolean;
      Existe: Boolean;
    end;
  private
    class function fGravarArquivoBD(const AFileName, AText: String): String;
    class function fExportarParaArquivo(AReport: TfrxReport): String; overload;
    class function fExportarParaArquivo(AArquivo: String): String; overload;
    class function fExportarParaPDF(const ADescricao: String; AReport: TfrxReport): String;
    class function fAdicionarFilaImpressao(const APrograma, ADescricao, ANomeFila, AArquivo: String): Boolean;  public
    class function fGetPontoImpressao(const ANomeFila: String): TPontoImpressao;
    class function fGetPontosImpressao(): TArray<TPontoImpressao>;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String; AReport: TfrxReport): Boolean; overload;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila, AArquivo: String): Boolean; overload;
  end;

implementation

uses Uni, SysUtils, System.Classes, System.IOUtils, Soap.EncdDecd, {System.NetEncoding,}
  untUtil;

const
  LOG_ADM = '999';

function fGetInfo(const AField, ANomPon, ANomImp: String): String;
Var
  LQry: TUniQuery;
begin
  Result := '';
  LQry := fCriaQuery(nil);
  Try
    LQry.SQL.Text :=
      ' SELECT * FROM CADPON A ' +
      ' JOIN CADPON_IMP B ON A.PON_CODPON = B.PON_CODPON ' +
      ' WHERE A.PON_NOMPON = :NOMPON' +
      '   AND B.PON_NOMIMP = :NOMIMP';

    LQry.ParamByName('NOMPON').AsString := ANomPon;
    LQry.ParamByName('NOMIMP').AsString := ANomImp;

    LQry.Open;
    if LQry.FindField(AField) <> nil then
      Result := LQry.FieldByName(AField).AsString;
  Finally
    FreeAndNil(LQry);
  End;
end;

class function TSpoolImpressaoCitel.fAdicionarFilaImpressao(const APrograma, ADescricao, ANomeFila,
  AArquivo: String): Boolean;
Var
  LQuery: TUniQuery;
  LPontoImp: TPontoImpressao;
begin
  pLogImp('ADICIONANDO ARQUIVO NA FILA DE IMPRESSAO: ' + ADescricao + '/' + AArquivo);
  LPontoImp := fGetPontoImpressao(ANomeFila);
  LQuery := fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT * FROM SPOIMP WHERE FALSE');
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SPOIMP', VS_strCodEmp);
    LQuery.FieldByName('SPO_CODEMP').AsString := VS_strCodEmp;
    LQuery.FieldByName('SPO_CODOPE').AsString := LOG_ADM;
    LQuery.FieldByName('SPO_NOMPRO').AsString := APrograma;
    LQuery.FieldByName('SPO_DESPRO').AsString := ADescricao;
    LQuery.FieldByName('SPO_PONIMP').AsString := LPontoImp.Nome;
    LQuery.FieldByName('SPO_NOMIMP').AsString := LPontoImp.Impressora;
    LQuery.FieldByName('SPO_ARQIMP').AsString := AArquivo;
    LQuery.FieldByName('SPO_DTAINC').AsDateTime := fNow;
    LQuery.Post;
    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TSpoolImpressaoCitel.fGetPontoImpressao(const ANomeFila: String): TPontoImpressao;
var
  LArray: TArray<String>;
begin
  if SameText(fTiraCaracEspeciais(ANomeFila), fTiraCaracEspeciais(PontoNaoImprimir)) then
  Begin
    Result.Nome := PontoNaoImprimir;
    Result.Impressora := PontoNaoImprimir;
    Result.TipoImpressora := 'J';
    Result.Status := 'ONLINE';
    Result.NomeFila := PontoNaoImprimir;
    Result.ExportacaoPDF := False;
    Result.ExibirSomenteMaquinaServico := False;
    Result.Existe := True;
    Exit;
  End;

  If ANomeFila.EQuals(PontoExportarPDF) Then
  Begin
    Result.Nome := PontoExportarPDF;
    Result.Impressora := PontoExportarPDF;
    Result.TipoImpressora := 'J';
    Result.Status := 'ONLINE';
    Result.NomeFila := PontoExportarPDF;
    Result.ExportacaoPDF := True;
    Result.ExibirSomenteMaquinaServico := False;
    Result.Existe := True;
    Exit;
  End;

  If Not ANomeFila.Contains(NomeFilaSeparator) Then
  Begin
    Result.Existe := False;
    Exit;
  End;

  {$IFDEF VER270}
  LArray := ANomeFila.Split([NomeFilaSeparator], TStringSplitOptions.None);
  {$ELSE}
  LArray := ANomeFila.Split([NomeFilaSeparator]);
  {$ENDIF}

  Result.Nome := LArray[0];
  Result.Impressora := LArray[1];
  Result.TipoImpressora := fGetInfo('PON_TIPIMP', Result.Nome, Result.Impressora);
  Result.Status := fGetInfo('PON_STAIMP', Result.Nome, Result.Impressora);
  Result.ExportacaoPDF := fGetInfo('PON_EXPPDF', Result.Nome, Result.Impressora) = 'S';
  Result.ExibirSomenteMaquinaServico := fGetInfo('PON_SOMMAQ', Result.Nome, Result.Impressora) = 'S';
  Result.NomeFila := Result.Nome + NomeFilaSeparator + Result.Impressora;
  Result.Existe := Not Result.Status.IsEmpty;
end;

class function TSpoolImpressaoCitel.fGetPontosImpressao: TArray<TPontoImpressao>;
Var
  LCadPon: TUniQuery;
  LPonto: TPontoImpressao;
begin
  inherited;
  LCadPon := fCriaQuery(nil);
  Try
    LCadPon.SQL.Add(' SELECT ');
    LCadPon.SQL.Add('   PON_NOMMAQ AS NOMMAQ, ');
    LCadPon.SQL.Add('   CONCAT(PON_NOMPON, "' + NomeFilaSeparator + '", PON_NOMIMP) AS NOMFIL ');
    LCadPon.SQL.Add(' FROM ');
    LCadPon.SQL.Add('   CADPON A ');
    LCadPon.SQL.Add('   JOIN CADPON_IMP B ');
    LCadPon.SQL.Add('     ON A.PON_CODPON = B.PON_CODPON ');
    LCadPon.SQL.Add(' WHERE PON_CODEMP = :CODEMP ');
    LCadPon.ParamByName('CODEMP').AsString := VS_strCodEmp;

    if fCampoExiste('CADPON', 'PON_EMPDIS') then
    begin
      LCadPon.SQL.Add(' UNION ');
      LCadPon.SQL.Add(' SELECT ');
      LCadPon.SQL.Add('   PON_NOMMAQ AS NOMMAQ, ');
      LCadPon.SQL.Add('   CONCAT(PON_NOMPON, "' + NomeFilaSeparator + '", PON_NOMIMP) AS NOMFIL ');
      LCadPon.SQL.Add(' FROM ');
      LCadPon.SQL.Add('   CADPON A ');
      LCadPon.SQL.Add('   JOIN CADPON_IMP B ');
      LCadPon.SQL.Add('     ON A.PON_CODPON = B.PON_CODPON    ');
      LCadPon.SQL.Add(' WHERE LOCATE(:EMPDIS, PON_EMPDIS) > 0 ');
      LCadPon.ParamByName('EMPDIS').AsString := VS_strCodEmp;
    end;
    LCadPon.SQL.Add(' ORDER BY 2 ');
    LCadPon.Open;

    SetLength(Result, 0);

    While Not LCadPon.Eof Do
    Begin
      LPonto := fGetPontoImpressao(LCadPon.FieldByName('NOMFIL').AsString);
    {$IF Defined(LINUX)}
      If (Not LPonto.ExibirSomenteMaquinaServico) Or
         (LCadPon.FieldByName('NOMMAQ').AsString = GetComputerNetName) Then
    {$ELSE}
      If (Not LPonto.ExibirSomenteMaquinaServico) Or
         (LCadPon.FieldByName('NOMMAQ').AsString = TWorkStationInfo.fGetWorkstationID) Then
    {$IFEND}
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1] := LPonto;
      End;
      LCadPon.Next;
    End;
  Finally
    LCadPon.Free;
  End;
end;

class function TSpoolImpressaoCitel.fGravarArquivoBD(const AFileName, AText: String): String;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT * FROM SPOARQ WHERE FALSE');
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SPOARQ', VS_strCodEmp);
    LQuery.FieldByName('SPO_NOMARQ').AsString := ExtractFileName(AFileName);
    LQuery.FieldByName('SPO_ARQB64').AsString := AText;
    LQuery.Post;
    Result := ExtractFileName(AFileName);
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AReport: TfrxReport): String;
Var
  LPath: String;
  LFile: String;
  LText: String;
  LPrintOptions: TStringList;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'tmp\';

  If Not DirectoryExists(LPath) Then
    CreateDir(LPath);

  LFile := LOG_ADM + VS_strCodEmp + FormatDateTime('yyyyMMddhhmmss', Date + Time) + IntToStr(Random(99999));

  LFile := LPath + fGetMD5(LFile) + '.fp3';

  If AReport.PreviewPages.Count = 0 Then
    AReport.PrepareReport;

  AReport.PreviewPages.SaveToFile(LFile);

  LText := TFile.ReadAllText(LFile, TEncoding.ANSI);

  LPrintOptions := TStringList.Create;
  Try
    LPrintOptions.Delimiter := '|';
    LPrintOptions.StrictDelimiter := True;
    LPrintOptions.Values['Copies'] := AReport.PrintOptions.Copies.ToString;
    LPrintOptions.Values['Collate'] := AReport.PrintOptions.Collate.ToString;
    LPrintOptions.Values['PageNumbers'] := AReport.PrintOptions.PageNumbers;
    LPrintOptions.Values['PrintMode'] := Ord(AReport.PrintOptions.PrintMode).ToString;
    LPrintOptions.Values['PrintOnSheet'] := AReport.PrintOptions.PrintOnSheet.ToString;
    LPrintOptions.Values['PrintPages'] := Ord(AReport.PrintOptions.PrintPages).ToString;
    LText := LText + '<PrintOptions>' + LPrintOptions.DelimitedText + '</PrintOptions>';
  Finally
    FreeAndNil(LPrintOptions);
  End;

  Result := fGravarArquivoBD(LFile, LText);

  SysUtils.DeleteFile(LFile);
end;

{$IFDEF LINUX}
class function TSpoolImpressaoCitel.fExportarParaPDF(const ADescricao: String; AReport: TfrxReport): String;
Var
  LExpPDF : TfrxPDFExport;
Begin
  Result := fGetUniqueTempPath('.pdf');
  try
    LExpPDF := TfrxPDFExport.Create(nil);
    try
      AReport.ShowProgress  := False;
      LExpPDF.PageNumbers   := AReport.PrintOptions.PageNumbers;
      LExpPDF.ShowDialog    := False;
      LExpPDF.EmbeddedFonts := True;
      LExpPDF.DefaultPath   := ExtractFilePath(Result);
      LExpPDF.FileName      := Result;
      AReport.Export(LExpPDF);
    finally
      FreeAndNil(LExpPDF);
    end;
  except
    on E: exception do
    begin
      pLogImp('TSpoolImpressaoCitel.fExportarParaPDF: ' + E.Message);
      Result := EmptyStr;
    end;
  end;
End;
{$ELSE}
class function TSpoolImpressaoCitel.fExportarParaPDF(const ADescricao: String; AReport: TfrxReport): String;
Var
  LExpPDF : TfrxPDFExport;
Begin
  Result := '';
  try
    LExpPDF := TfrxPDFExport.Create(nil);
    try
      LExpPDF.DefaultPath := ExtractFilePath(ParamStr(0)) + '\DANFE\';
      LExpPDF.FileName := ADescricao + '.pdf';
      LExpPDF.PageNumbers := AReport.PrintOptions.PageNumbers;
      LExpPDF.ShowDialog  := False;
      LExpPDF.PrintOptimized := True;

      if not DirectoryExists(LExpPDF.DefaultPath) then
        ForceDirectories(LExpPDF.DefaultPath);

      if assigned(AReport.PreviewForm) then
        TfrxPreviewForm(AReport.PreviewForm).Preview.Export(LExpPDF)
      else
        AReport.Export(LExpPDF);

      Result := LExpPDF.FileName;
    finally
      FreeAndNil(LExpPDF);
    end;

    ShellExecute(0, nil, PChar(Result), nil, nil, SW_SHOWNORMAL);
  finally
  end;
end;
{$ENDIF}

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String; AReport: TfrxReport): Boolean;
{$IFDEF LINUX}
var
  LPdfFile: string;
begin
  if SameText(fTiraCaracEspeciais(ANomeFila), fTiraCaracEspeciais(PontoNaoImprimir)) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
    Exit(True);

  LPdfFile := fExportarParaPDF(ADescricao, AReport);

  if not FileExists(LPdfFile) then
    Exit(False);

  try
    Result := TSpoolImpressaoCitel.fEnviarParaImpressao(APrograma, ADescricao, ANomeFila, LPdfFile);
  finally
    DeleteFile(LPdfFile);
  end;
end;
{$ELSE}
begin
  if SameText(fTiraCaracEspeciais(ANomeFila), fTiraCaracEspeciais(PontoNaoImprimir)) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
  begin
    fExportarParaPDF(ADescricao, AReport);
    Exit(True);
  end;
  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila, fExportarParaArquivo(AReport));
end;
{$ENDIF}

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma, ADescricao,
  ANomeFila, AArquivo: String): Boolean;
begin
  if SameText(fTiraCaracEspeciais(ANomeFila), fTiraCaracEspeciais(PontoNaoImprimir)) then
    Exit(True);

  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila,
    fExportarParaArquivo(AArquivo));
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AArquivo: String): String;
Var
  LFile: String;
  LText: String;
begin
  LFile  := LOG_ADM + VS_strCodEmp + FormatDateTime('yyyyMMddhhmmss', Date + Time) + IntToStr(Random(99999));

  LFile  := fGetMD5(LFile + AArquivo) + '.pdf';

 {$IFDEF LINUX}
  LText  := fRetornarArquivoBase64(AArquivo);
 {$ELSE}
  LText := TFile.ReadAllText(AArquivo, TEncoding.ANSI);
 {$ENDIF}

  Result := fGravarArquivoBD(LFile, LText);
end;

end.
