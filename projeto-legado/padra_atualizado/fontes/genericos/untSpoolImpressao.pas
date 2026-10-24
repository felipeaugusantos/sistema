unit untSpoolImpressao;

interface

uses
  Classes, UniClientDataSet, untWord, frxExportPDF, frxPreview, frxClass, RLReport, untTypesSistema;

Type
  TSpoolImpressaoCitel = class
  public const
    NomeFilaSeparator = ' >> ';
    TokenKey = 'citel13347';
    PontoNaoImprimir = 'NÃO IMPRIMIR';
    PontoExportarPDF = 'EXPORTAR PARA PDF';
    AbrirGavetaDinheiro = 'ABRIR_GAVETA_DINHEIRO';
  private
    class procedure FileToBase64(const AFileName: String; out AText: String);
    class function CryptToken(const AToken: String): String;
  private
    class function fGravarArquivoBD(const AFileName, AText: String): String; overload;
    class function fGravarArquivoBD(const AFileName: String; AStream: TFileStream): String; overload;
    class function fExportarParaArquivo(AText: String): String; overload;
    class function fExportarParaArquivo(AWord: TWord): String; overload;
    class function fExportarParaArquivo(AReport: IReport): String; overload;
    class function fExportarParaArquivo(AReport: TfrxReport; AGrayedScale: Boolean = False): String; overload;
    class function fExportarParaArquivo(AReport: TRLReport): String; overload;
    class function fExportarParaPDF(const ADescricao: String; AReport: TfrxReport): String; overload;
    class function fExportarParaPDF(const ADescricao: String; AWord: TWord): String; overload;
    class function fAdicionarFilaImpressao(const APrograma, ADescricao, ANomeFila,
      AArquivo: String): Boolean;
  public
    class function fGetPontoImpressao(const ANomeFila: String): TPontoImpressao;
    class function fGetPontosImpressao(): TArray<TPontoImpressao>;
    class function fEnviarTextoParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AText: String): Boolean;
    class function fEnviarESCParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AArqESC: String): Boolean;
    class function fEnviarPDFParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AArqPDF: String): Boolean;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AWord: TWord): Boolean; overload;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AReport: IReport): Boolean; overload;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AReport: TfrxReport; AGrayedScale: Boolean = False): Boolean; overload;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String;
      AReport: TRLReport): Boolean; overload;
    class function fGerarToken(const ASpooler: String): String;
  end;

implementation

uses Uni, SysUtils, untCfgRel, System.IOUtils, Soap.EncdDecd, Data.DB,
  System.NetEncoding, LbClass, LbUtils, LbCipher, Rest.Json, Vcl.Dialogs, Printers,
  ShellApi, Winapi.Windows, untWorkStationInfo;

type
  TSpoolToken = class
  private
    FWSUrl: String;
    FCnpj: String;
    FSpoller: String;
  public
    property WebServiceUrl: String read FWSUrl write FWSUrl;
    property CompanyID: String read FCnpj write FCnpj;
    property Spoller: String read FSpoller write FSpoller;
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSpoolToken;
  end;

function fGetInfo(const AField, ANomPon, ANomImp: String): String;
Var
  LQry: TUniQuery;
begin
  LQry := TCfgRel.fCriaQuery(nil);
  Try
    LQry.SQL.Text :=
      ' SELECT * FROM CADPON A ' +
      ' JOIN CADPON_IMP B ON A.PON_CODPON = B.PON_CODPON ' +
      ' WHERE A.PON_NOMPON = :NOMPON' +
      '   AND B.PON_NOMIMP = :NOMIMP';

    LQry.ParamByName('NOMPON').AsString := ANomPon;
    LQry.ParamByName('NOMIMP').AsString := ANomImp;
    LQry.Open;

    Result := LQry.FieldByName(AField).AsString;
  Finally
    FreeAndNil(LQry);
  End;
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AWord: TWord): String;
Var
  LPath: String;
  LFile: String;
  LText: String;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'tmp\';

  If Not DirectoryExists(LPath) Then
    CreateDir(LPath);

  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow) + Random(99999).ToString;

  LFile := LPath + TCfgRel.fGetMD5(LFile) + '.pdf';

  AWord.SaveAsPDF(LFile);

  LText := TFile.ReadAllText(LFile, TEncoding.ANSI);

  Result := fGravarArquivoBD(LFile, LText);

  SysUtils.DeleteFile(LFile);
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AReport: IReport): String;
Var
  LPath: String;
  LFile: String;
  LText: String;
  LPrintOptions: TStringList;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'tmp\';

  If Not DirectoryExists(LPath) Then
    CreateDir(LPath);

  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow) + Random(99999).ToString;

  LFile := LPath + TCfgRel.fGetMD5(LFile) + '.fp3';

  AReport.SaveToFile(LFile);

  LText := TFile.ReadAllText(LFile, TEncoding.ANSI);

  LPrintOptions := TStringList.Create;
  Try
    LPrintOptions.Delimiter := '|';
    LPrintOptions.StrictDelimiter := True;
    LPrintOptions.Values['Copies'] := AReport.Copies;
    LPrintOptions.Values['Collate'] := AReport.Collate;
    LPrintOptions.Values['PageNumbers'] := AReport.PageNumbers;
    LPrintOptions.Values['PrintMode'] := AReport.PrintMode;
    LPrintOptions.Values['PrintOnSheet'] := AReport.PrintOnSheet;
    LPrintOptions.Values['PrintPages'] := AReport.PrintPages;
    LText := LText + '<PrintOptions>' + LPrintOptions.DelimitedText + '</PrintOptions>';
  Finally
    FreeAndNil(LPrintOptions);
  End;

  Result := fGravarArquivoBD(LFile, LText);

  SysUtils.DeleteFile(LFile);
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AReport: TRLReport): String;
Var
  LPath: String;
  LFile: String;
  LText: String;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'tmp\';

  If Not DirectoryExists(LPath) Then
    CreateDir(LPath);

  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow()) + Random(99999).ToString;

  LFile := LPath + TCfgRel.fGetMD5(LFile) + '.rtf';

  AReport.Prepare;
  AReport.SaveToFile(LFile);

  Self.FileToBase64(LFile, LText);

  Result := fGravarArquivoBD(LFile, LText);

  SysUtils.DeleteFile(LFile);
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AText: String): String;
Var
  LFile: String;
begin
  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow) + Random(99999).ToString;
  LFile := TCfgRel.fGetMD5(LFile) + '.txt';
  Result := fGravarArquivoBD(LFile, AText);
end;

class function TSpoolImpressaoCitel.fExportarParaPDF(const ADescricao: String; AReport: TfrxReport): String;
Var
  LSavArq : TSaveDialog;
  LExpPDF : TfrxPDFExport;
Begin
  LSavArq := TSaveDialog.Create(nil);
  try
    Result := '';

    LSavArq.Filter     := 'Arquivos PDF|*.pdf';
    LSavArq.DefaultExt := 'pdf';

    if TCfgRel.GetUltimoDiretorioAcessado.IsEmpty then
    begin
      if TCfgRel.VS_TSPlus then
        LSavArq.InitialDir := '\\tsclient\c'
      else
        LSavArq.InitialDir := System.IOUtils.TPath.GetDocumentsPath;
    end;

    LSavArq.FileName := ADescricao.Replace(TCfgRel.fGetTituloVersao(), '') + '.pdf';

    if not LSavArq.Execute then
      Exit;

    TCfgRel.SetUltimoDiretorioAcessado(ExtractFilePath(LSavArq.FileName));

    LExpPDF := TfrxPDFExport.Create(nil);
    try
      LExpPDF.PageNumbers := AReport.PrintOptions.PageNumbers;
      LExpPDF.ShowDialog  := False;
      LExpPDF.DefaultPath := ExtractFilePath(LSavArq.FileName);

      LExpPDF.FileName := LSavArq.FileName;
      if assigned(AReport.PreviewForm) then
        TfrxPreviewForm(AReport.PreviewForm).Preview.Export(LExpPDF)
      else
        AReport.Export(LExpPDF);
    finally
      FreeAndNil(LExpPDF);
    end;

    ShellExecute(0, nil, PChar(LSavArq.FileName), nil, nil, SW_SHOWNORMAL);

    Result := LSavArq.FileName;
  finally
    FreeAndNil(LSavArq);
  end;
end;

class function TSpoolImpressaoCitel.fExportarParaPDF(const ADescricao: String; AWord: TWord): String;
Var
  LSavArq : TSaveDialog;
Begin
  LSavArq := TSaveDialog.Create(nil);
  try
    Result := '';

    LSavArq.Filter     := 'Arquivos PDF|*.pdf';
    LSavArq.DefaultExt := 'pdf';

    if TCfgRel.GetUltimoDiretorioAcessado.IsEmpty then
    begin
      if TCfgRel.VS_TSPlus then
        LSavArq.InitialDir := '\\tsclient\c'
      else
        LSavArq.InitialDir := System.IOUtils.TPath.GetDocumentsPath;
    end;

    LSavArq.FileName := ADescricao.Replace(TCfgRel.fGetTituloVersao(), '') + '.pdf';

    if not LSavArq.Execute then
      Exit;

    TCfgRel.SetUltimoDiretorioAcessado(ExtractFilePath(LSavArq.FileName));

    AWord.SaveAsPDF(LSavArq.FileName);

    ShellExecute(0, nil, PChar(LSavArq.FileName), nil, nil, SW_SHOWNORMAL);

    Result := LSavArq.FileName;
  finally
    FreeAndNil(LSavArq);
  end;
end;

class procedure TSpoolImpressaoCitel.FileToBase64(const AFileName: String; out AText: String);
begin
  AText := Soap.EncdDecd.EncodeString(TFile.ReadAllText(AFileName, TEncoding.ANSI));
end;

class function TSpoolImpressaoCitel.CryptToken(const AToken: String): String;
Var
  LBlowFish: TLbBlowfish;
begin
  LBlowFish := TLbBlowfish.Create(Nil);
  Try
    LBlowFish.GenerateKey(TokenKey);
    Result := String(LBlowFish.EncryptString(AnsiString(AToken)));
  Except
    FreeAndNil(LBlowFish);
  End;
end;

class function TSpoolImpressaoCitel.fAdicionarFilaImpressao(const APrograma, ADescricao, ANomeFila,
  AArquivo: String): Boolean;
Var
  LQuery: TUniQuery;
  LPontoImp: TPontoImpressao;
begin
  LPontoImp := fGetPontoImpressao(ANomeFila);
  LQuery := TCfgRel.fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT * FROM SPOIMP WHERE FALSE');
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString := TCfgRel.fRetAutoIncrem('SPOIMP',
      TCfgRel.fGetEmpresaLogada());
    LQuery.FieldByName('SPO_CODEMP').AsString := TCfgRel.fGetEmpresaLogada();
    LQuery.FieldByName('SPO_CODOPE').AsString := TCfgRel.fGetUsuarioLogado();
    LQuery.FieldByName('SPO_NOMPRO').AsString := APrograma;
    LQuery.FieldByName('SPO_DESPRO').AsString := ADescricao.Replace(TCfgRel.fGetTituloVersao(), '');
    LQuery.FieldByName('SPO_PONIMP').AsString := LPontoImp.Nome;
    LQuery.FieldByName('SPO_NOMIMP').AsString := LPontoImp.Impressora;
    LQuery.FieldByName('SPO_ARQIMP').AsString := AArquivo;
    LQuery.FieldByName('SPO_DTAINC').AsDateTime := TCfgRel.fNow();
    LQuery.Post;
    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma, ADescricao,
  ANomeFila: String; AReport: TRLReport): Boolean;
Var
  LCopy: Integer;
  LNomImp: String;
begin
  Result := True;

  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit;

  if fGetPontoImpressao(ANomeFila).ExportacaoPDF then
  begin
    LNomImp := TCfgRel.fSelecionaFila('', '', False, False, 'Selecione uma impressora PDF', 'PDF|UNIVERSAL PRINTER');
    If Not LNomImp.IsEmpty Then
    Begin
      Printer.PrinterIndex := Printer.Printers.IndexOf(LNomImp);
      AReport.Print;
    End;
    Exit;
  end;

  for LCopy := 1 to Printer.Copies do
    Result := Result and Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila, fExportarParaArquivo(AReport));
end;

class function TSpoolImpressaoCitel.fEnviarESCParaImpressao(const APrograma, ADescricao, ANomeFila: String; AArqESC: String): Boolean;
Var
  LFile: string;
  LStream: TFileStream;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
    Exit(True);

  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow) + Random(99999).ToString;

  LFile := TCfgRel.fGetMD5(LFile) + '.esc';

  LStream := TFileStream.Create(AArqESC, fmOpenRead or fmShareDenyNone);
  try
    Result := fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila, fGravarArquivoBD(LFile, LStream));
  finally
    LStream.Free;
  end;
end;

class function TSpoolImpressaoCitel.fEnviarPDFParaImpressao(const APrograma,
  ADescricao, ANomeFila: String; AArqPDF: String): Boolean;
Var
  LFile: String;
  LPath: String;
  LText: String;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
  begin
    ShellExecute(0, nil, PChar(AArqPDF), nil, nil, SW_SHOWNORMAL);
    Exit(True);
  end;

  LPath := ExtractFilePath(ParamStr(0)) + 'tmp\';

  if not DirectoryExists(LPath) then
    CreateDir(LPath);

  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow) + Random(99999).ToString;

  LFile := LPath + TCfgRel.fGetMD5(LFile) + '.pdf';

  TFile.Copy(AArqPDF, LFile);

  LText := TFile.ReadAllText(LFile, TEncoding.ANSI);

  Result := fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila, fGravarArquivoBD(LFile, LText));

  SysUtils.DeleteFile(LFile);
end;

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma,
  ADescricao, ANomeFila: String; AWord: TWord): Boolean;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
  begin
    fExportarParaPDF(ADescricao, AWord);
    Exit(True);
  end;

  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila,
    fExportarParaArquivo(AWord));
end;

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma, ADescricao,
  ANomeFila: String; AReport: IReport): Boolean;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
  begin
    AReport.ExportarParaPDF(ADescricao.Replace(TCfgRel.fGetTituloVersao(), ''));
    Exit(True);
  end;

  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila,
    fExportarParaArquivo(AReport));
end;

class function TSpoolImpressaoCitel.fEnviarTextoParaImpressao(const APrograma,
  ADescricao, ANomeFila: String; AText: String): Boolean;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
    Raise Exception.Create('"'+ADescricao+'" não possui exportação para pdf.');

  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila,
    fExportarParaArquivo(AText));
end;

class function TSpoolImpressaoCitel.fGerarToken(const ASpooler: String): String;
var
  LToken: TSpoolToken;
begin
  If Trim(TCfgRel.fCfgSis('SPOURL')).Equals(EmptyStr) Then
    Raise Exception.Create('Favor configurar corretamente a URL do WebService Spool de Impressão Citel.');

  LToken := TSpoolToken.Create;
  Try
    LToken.Spoller := ASpooler;
    LToken.WebServiceUrl := TCfgRel.fCfgSis('SPOURL');
    LToken.CompanyID := TCfgRel.fCnpjEmpresaFisica;
    Result := CryptToken(LToken.ToJsonString);
  Finally
    FreeAndNil(LToken);
  End;
end;

class function TSpoolImpressaoCitel.fGetPontoImpressao(const ANomeFila: String): TPontoImpressao;
var
  LArray: TArray<String>;
begin
  If ANomeFila.EQuals(PontoNaoImprimir) Then
  Begin
    Result.Nome := PontoNaoImprimir;
    Result.Impressora := PontoNaoImprimir;
    Result.TipoImpressora := 'J';
    Result.Status := 'ONLINE';
    Result.NomeFila := PontoNaoImprimir;
    Result.ExportacaoPDF := False;
    Result.ImprimirParaArquivo := False;
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
    Result.ImprimirParaArquivo := False;
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
    Result.ImprimirParaArquivo := False;
    Result.ExibirSomenteMaquinaServico := False;
    Result.Existe := True;
    Exit;
  End;

  If Not ANomeFila.Contains(NomeFilaSeparator) Then
  Begin
    Result.Existe := False;
    Exit;
  End;

  LArray := ANomeFila.Split([NomeFilaSeparator]);

  Result.Nome := LArray[0];
  Result.Impressora := LArray[1];
  Result.TipoImpressora := fGetInfo('PON_TIPIMP', Result.Nome, Result.Impressora);
  Result.Status := fGetInfo('PON_STAIMP', Result.Nome, Result.Impressora);
  Result.NomeFila := Result.Nome + NomeFilaSeparator + Result.Impressora;
  Result.ImprimirParaArquivo := fGetInfo('PON_IMPARQ', Result.Nome, Result.Impressora) = 'S';
  Result.ExportacaoPDF := fGetInfo('PON_EXPPDF', Result.Nome, Result.Impressora) = 'S';
  Result.ExibirSomenteMaquinaServico := fGetInfo('PON_SOMMAQ', Result.Nome, Result.Impressora) = 'S';
  Result.Existe := Not Result.Status.IsEmpty;
end;

class function TSpoolImpressaoCitel.fGetPontosImpressao: TArray<TPontoImpressao>;
Var
  LCadPon: TUniQuery;
  LPonto: TPontoImpressao;
begin
  inherited;
  LCadPon := TCfgRel.fCriaQuery(nil);
  Try
    LCadPon.SQL.Add(' SELECT ');
    LCadPon.SQL.Add('   PON_NOMMAQ AS NOMMAQ, ');
    LCadPon.SQL.Add('   CONCAT(PON_NOMPON, "' + NomeFilaSeparator + '", PON_NOMIMP) AS NOMFIL ');
    LCadPon.SQL.Add(' FROM ');
    LCadPon.SQL.Add('   CADPON A ');
    LCadPon.SQL.Add('   JOIN CADPON_IMP B ');
    LCadPon.SQL.Add('     ON A.PON_CODPON = B.PON_CODPON ');
    LCadPon.SQL.Add(' WHERE PON_CODEMP = :CODEMP ');
    LCadPon.ParamByName('CODEMP').AsString := TCfgRel.fGetEmpresaLogada();

    if TCfgRel.fCampoExiste('CADPON', 'PON_EMPDIS') then
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
      LCadPon.ParamByName('EMPDIS').AsString := TCfgRel.fGetEmpresaLogada();
    end;
    LCadPon.SQL.Add(' ORDER BY 2 ');
    LCadPon.Open;

    SetLength(Result, 0);

    While Not LCadPon.Eof Do
    Begin
      LPonto := fGetPontoImpressao(LCadPon.FieldByName('NOMFIL').AsString);
      If (Not LPonto.ExibirSomenteMaquinaServico) Or
         (LCadPon.FieldByName('NOMMAQ').AsString = TWorkStationInfo.fGetWorkstationID) Then
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
  LQuery := TCfgRel.fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT * FROM SPOARQ WHERE FALSE');
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString := TCfgRel.fRetAutoIncrem('SPOARQ',
      TCfgRel.fGetEmpresaLogada());
    LQuery.FieldByName('SPO_NOMARQ').AsString := ExtractFileName(AFileName);
    LQuery.FieldByName('SPO_ARQB64').AsString := AText;
    LQuery.Post;
    Result := ExtractFileName(AFileName);
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TSpoolImpressaoCitel.fGravarArquivoBD(const AFileName: String; AStream: TFileStream): String;
Var
  LQuery: TUniQuery;
begin
  LQuery := TCfgRel.fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT * FROM SPOARQ WHERE FALSE');
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString := TCfgRel.fRetAutoIncrem('SPOARQ',
      TCfgRel.fGetEmpresaLogada());
    LQuery.FieldByName('SPO_NOMARQ').AsString := ExtractFileName(AFileName);
    TBlobField(LQuery.FieldByName('SPO_ARQB64')).LoadFromStream(AStream);
    LQuery.Post;
    Result := ExtractFileName(AFileName);
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TSpoolImpressaoCitel.fExportarParaArquivo(AReport: TfrxReport; AGrayedScale: Boolean = False): String;
Var
  LPath: String;
  LFile: String;
  LText: String;
  LPrintOptions: TStringList;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'tmp\';

  If Not DirectoryExists(LPath) Then
    CreateDir(LPath);

  LFile := TCfgRel.fGetUsuarioLogado() + TCfgRel.fGetEmpresaLogada() +
    FormatDateTime('yyyyMMddhhmmss', TCfgRel.fNow) + Random(99999).ToString;

  LFile := LPath + TCfgRel.fGetMD5(LFile) + '.fp3';

  AReport.PreviewPages.SaveToFile(LFile);

  LText := TFile.ReadAllText(LFile, TEncoding.ANSI);

  LPrintOptions := TStringList.Create;
  Try
    LPrintOptions.Delimiter := '|';
    LPrintOptions.StrictDelimiter := True;
    LPrintOptions.Values['Copies'] := AReport.PrintOptions.Copies.ToString;
    LPrintOptions.Values['Collate'] := BoolToStr(AReport.PrintOptions.Collate, True);
    LPrintOptions.Values['GrayedScale'] := BoolToStr(AGrayedScale, True);
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

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma, ADescricao,
  ANomeFila: String; AReport: TfrxReport; AGrayedScale: Boolean = False): Boolean;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
  begin
    fExportarParaPDF(ADescricao, AReport);
    Exit(True);
  end;

  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila,
    fExportarParaArquivo(AReport, AGrayedScale));
end;

{ TSpoolToken }

class function TSpoolToken.FromJsonString(AJsonString: string): TSpoolToken;
begin
  Result := TJson.JsonToObject<TSpoolToken>(AJsonString);
end;

function TSpoolToken.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
