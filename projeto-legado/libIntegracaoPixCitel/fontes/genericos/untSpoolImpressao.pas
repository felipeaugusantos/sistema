unit untSpoolImpressao;

interface

uses
  frxExportPDF, frxPreview, frxClass;

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
    class function fExportarParaArquivo(AReport: TfrxReport): String;
    class function fExportarParaPDF(const ADescricao: String; AReport: TfrxReport): String;
    class function fAdicionarFilaImpressao(const APrograma, ADescricao, ANomeFila,
      AArquivo: String): Boolean;
  public
    class function fGetPontoImpressao(const ANomeFila: String): TPontoImpressao;
    class function fGetPontosImpressao(): TArray<TPontoImpressao>;
    class function fEnviarParaImpressao(const APrograma, ADescricao, ANomeFila: String; AReport: TfrxReport): Boolean;
  end;

implementation

uses SysUtils, System.Classes, System.IOUtils, Soap.EncdDecd, System.NetEncoding,
  untFuncoesSimples, Vcl.Dialogs, Printers, ShellApi, Winapi.Windows, untIDataset,
  untWorkStationInfo;

const
  LOG_ADM = '999';

function fGetInfo(const AField, ANomPon, ANomImp: String): String;
Var
  LQry: IDataset;
begin
  LQry := VS_FuncoesExternas.fGetDataSet;
  Try
    LQry.SQL :=
      ' SELECT * FROM CADPON A ' +
      ' JOIN CADPON_IMP B ON A.PON_CODPON = B.PON_CODPON ' +
      ' WHERE A.PON_NOMPON = :NOMPON' +
      '   AND B.PON_NOMIMP = :NOMIMP';

    LQry.ParamByName('NOMPON').AsString := ANomPon;
    LQry.ParamByName('NOMIMP').AsString := ANomImp;
    LQry.Open;

    Result := LQry.FieldByName(AField).AsString;
  Finally

  End;
end;

class function TSpoolImpressaoCitel.fAdicionarFilaImpressao(const APrograma, ADescricao, ANomeFila,
  AArquivo: String): Boolean;
Var
  LQuery: IDataset;
  LPontoImp: TPontoImpressao;
begin
  LPontoImp := fGetPontoImpressao(ANomeFila);
  LQuery := VS_FuncoesExternas.fGetDataSet;
  Try
    LQuery.SQL := 'SELECT * FROM SPOIMP WHERE FALSE';
    LQuery.Open;
    LQuery.Insert;
    LQuery.FieldByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('SPOIMP', VS_FuncoesExternas.fGetEmpresaLogada);
    LQuery.FieldByName('SPO_CODEMP').AsString := VS_FuncoesExternas.fGetEmpresaLogada;
    LQuery.FieldByName('SPO_CODOPE').AsString := LOG_ADM;
    LQuery.FieldByName('SPO_NOMPRO').AsString := APrograma;
    LQuery.FieldByName('SPO_DESPRO').AsString := ADescricao;
    LQuery.FieldByName('SPO_PONIMP').AsString := LPontoImp.Nome;
    LQuery.FieldByName('SPO_NOMIMP').AsString := LPontoImp.Impressora;
    LQuery.FieldByName('SPO_ARQIMP').AsString := AArquivo;
    LQuery.FieldByName('SPO_DTAINC').AsFloat  := Date + fTime();
    LQuery.Post;
    Result := True;
  Finally

  End;
end;

class function TSpoolImpressaoCitel.fGetPontoImpressao(const ANomeFila: String): TPontoImpressao;
var
  LArray: TArray<String>;
begin
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
  Result.ExportacaoPDF := fGetInfo('PON_EXPPDF', Result.Nome, Result.Impressora) = 'S';
  Result.ExibirSomenteMaquinaServico := fGetInfo('PON_SOMMAQ', Result.Nome, Result.Impressora) = 'S';
  Result.Existe := Not Result.Status.IsEmpty;
end;

class function TSpoolImpressaoCitel.fGetPontosImpressao: TArray<TPontoImpressao>;
Var
  LCadPon: IDataset;
  LPonto: TPontoImpressao;
begin
  inherited;
  LCadPon := VS_FuncoesExternas.fGetDataSet;
  Try
    LCadPon.SQL :=
      ' SELECT ' +
      '   PON_NOMMAQ AS NOMMAQ, ' +
      '   CONCAT(PON_NOMPON, "' + NomeFilaSeparator + '", PON_NOMIMP) AS NOMFIL ' +
      ' FROM ' +
      '   CADPON A ' +
      '   JOIN CADPON_IMP B ' +
      '     ON A.PON_CODPON = B.PON_CODPON ' +
      ' WHERE PON_CODEMP = :CODEMP ' +
      ' UNION ' +
      ' SELECT ' +
      '   PON_NOMMAQ AS NOMMAQ, ' +
      '   CONCAT(PON_NOMPON, "' + NomeFilaSeparator + '", PON_NOMIMP) AS NOMFIL ' +
      ' FROM ' +
      '   CADPON A ' +
      '   JOIN CADPON_IMP B ' +
      '     ON A.PON_CODPON = B.PON_CODPON ' +
      ' WHERE LOCATE(:EMPDIS, PON_EMPDIS) > 0 ' +
      ' ORDER BY 1 ';
    LCadPon.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fGetEmpresaLogada;
    LCadPon.ParamByName('EMPDIS').AsString := VS_FuncoesExternas.fGetEmpresaLogada;
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

  End;
end;

class function TSpoolImpressaoCitel.fGravarArquivoBD(const AFileName, AText: String): String;
Var
  LQuery: IDataset;
begin
  LQuery := VS_FuncoesExternas.fGetDataSet;
  Try
    LQuery.SQL := 'SELECT * FROM SPOARQ WHERE FALSE';
    LQuery.Open;
    LQuery.Insert;
    LQuery.FieldByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('SPOARQ', VS_FuncoesExternas.fGetEmpresaLogada);
    LQuery.FieldByName('SPO_NOMARQ').AsString := ExtractFileName(AFileName);
    LQuery.FieldByName('SPO_ARQB64').AsString := AText;
    LQuery.Post;
    Result := ExtractFileName(AFileName);
  Finally

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

  LFile := LOG_ADM + VS_FuncoesExternas.fGetEmpresaLogada + FormatDateTime('yyyyMMddhhmmss', Date + fTime());

  LFile := LPath + GetMD5(LFile) + '.fp3';

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

    LSavArq.FileName := ADescricao + '.pdf';

    if not LSavArq.Execute then
      Exit;

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

class function TSpoolImpressaoCitel.fEnviarParaImpressao(const APrograma, ADescricao,
  ANomeFila: String; AReport: TfrxReport): Boolean;
begin
  if ANomeFila.Equals(PontoNaoImprimir) then
    Exit(True);

  if ANomeFila.Equals(PontoExportarPDF) then
  begin
    fExportarParaPDF(ADescricao, AReport);
    Exit(True);
  end;

  Result := Self.fAdicionarFilaImpressao(APrograma, ADescricao, ANomeFila,
    fExportarParaArquivo(AReport));
end;

end.
