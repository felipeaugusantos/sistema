unit untADOTxtFactory;

interface

uses
  DB, ADODB, untIDefinicaoTxt, IniFiles, SysUtils;

type
  TADOTxtFactory = class(TInterfacedObject)
  public
    class procedure Registrar(const definicaoTxt: IDefinicaoTxt);
    class function GetTxtQuery(const strDiretorio: string): TADOQuery;
    class function GetTxt12Query(const strDiretorio: string): TADOQuery;
    class function GetTxt12DataSet(const definicaoTxt: IDefinicaoTxt): TADODataSet;
    //
  end;

  ExceptionNaoSchemaIni = class(Exception);

implementation

uses
  untDefinicaoTxtFormato, untDefinicaoTxtCharacterSet, untDefinicaoTxtCurrencyPosFormat, untDefinicaoTxtCampoTipo,
  untDefinicaoTxtCurrencyNegFormat;

{ TADOFactory }

class procedure TADOTxtFactory.Registrar(const definicaoTxt: IDefinicaoTxt);
var
  iniSchema: TIniFile;
  strNomeArquivoIni: string;
  strNomeArquivo: string;
  intCont: Integer;
  strCampo: string;
begin
  iniSchema := nil;
  Try
    Try
      strNomeArquivoIni := ExtractFilePath(definicaoTxt.NomeArquivo) + 'schema.ini';
      strNomeArquivo := ExtractFileName(definicaoTxt.NomeArquivo);
      iniSchema := TIniFile.Create(strNomeArquivoIni);

      iniSchema.WriteString(strNomeArquivo, 'Format',
        StringReplace(TDefinicaoTxtFormato.GetAsString(definicaoTxt.Format), '%c', definicaoTxt.Separador, [rfReplaceAll]));

      if definicaoTxt.MaxScanRows >= 0 then
        iniSchema.WriteInteger(strNomeArquivo, 'MaxScanRows', definicaoTxt.MaxScanRows);

      if TDefinicaoTxtCharacterSet.GetAsString(definicaoTxt.CharacterSet) <> '' then
        iniSchema.WriteString(strNomeArquivo, 'CharacterSet',
          TDefinicaoTxtCharacterSet.GetAsString(definicaoTxt.CharacterSet));

      if definicaoTxt.DateTimeFormat <> '' then
        iniSchema.WriteString(strNomeArquivo, 'DateTimeFormat', definicaoTxt.DateTimeFormat);

      if definicaoTxt.DecimalSymbol <> '' then
        iniSchema.WriteString(strNomeArquivo, 'DecimalSymbol', definicaoTxt.DecimalSymbol);

      if definicaoTxt.NumberDigits >= 0 then
        iniSchema.WriteInteger(strNomeArquivo, 'NumberDigits', definicaoTxt.NumberDigits);

      iniSchema.WriteString(strNomeArquivo, 'NumberLeadingZeros', BoolToStr(definicaoTxt.NumberLeadingZeros, True));

      if definicaoTxt.CurrencySymbol <> '' then
        iniSchema.WriteString(strNomeArquivo, 'CurrencySymbol', definicaoTxt.CurrencySymbol);

      if TDefinicaoTxtCurrencyPosFormat.GetAsInteger(definicaoTxt.CurrencyPosFormat) >= 0 then
        iniSchema.WriteInteger(strNomeArquivo, 'CurrencyPosFormat',
          TDefinicaoTxtCurrencyPosFormat.GetAsInteger(definicaoTxt.CurrencyPosFormat));

      if definicaoTxt.CurrencyDigits >= 0 then
        iniSchema.WriteInteger(strNomeArquivo, 'CurrencyDigits', definicaoTxt.CurrencyDigits);

      if TDefinicaoTxtCurrencyNegFormat.GetAsInteger(definicaoTxt.CurrencyNegFormat) >= 0 then
        iniSchema.WriteInteger(strNomeArquivo, 'CurrencyNegFormat',
          TDefinicaoTxtCurrencyNegFormat.GetAsInteger(definicaoTxt.CurrencyNegFormat));

      if definicaoTxt.CurrencyThousandSymbol <> '' then
        iniSchema.WriteString(strNomeArquivo, 'CurrencyThousandSymbol', definicaoTxt.CurrencyThousandSymbol);

      if definicaoTxt.CurrencyDecimalSymbol <> '' then
        iniSchema.WriteString(strNomeArquivo, 'CurrencyDecimalSymbol', definicaoTxt.CurrencyDecimalSymbol);

      iniSchema.WriteString(strNomeArquivo, 'ColNameHeader', BoolToStr(definicaoTxt.ColNameHeader, True));

      for intCont := 0 to definicaoTxt.CamposCount - 1 do
      begin
        strCampo := AnsiQuotedStr(definicaoTxt.Campo[intCont].Nome, '"');
        strCampo := strCampo + ' ' + TDefinicaoTxtCampoTipo.GetAsString(definicaoTxt.Campo[intCont].Tipo);

        if definicaoTxt.Campo[intCont].Largura >= 0 then
        begin
          strCampo := strCampo + ' ' + 'Width';
          strCampo := strCampo + ' ' + IntToStr(definicaoTxt.Campo[intCont].Largura);
        end;

        iniSchema.WriteString(strNomeArquivo, 'Col' + IntToStr(intCont + 1), strCampo);
      end;
    Except
      on E: Exception do
      begin
        raise ExceptionNaoSchemaIni.CreateFmt('Não foi possivel Criar/Alterar o arquivo [%s]',
         [strNomeArquivoIni]);
      end;
    End;
  Finally
    if Assigned(iniSchema) then FreeAndNil(iniSchema);
  End;
end;

class function TADOTxtFactory.GetTxt12DataSet(const definicaoTxt: IDefinicaoTxt): TADODataSet;
begin
  Try
    Result := TADODataSet.Create(nil);
    Result.ConnectionString := Format('Provider=Microsoft.ACE.OLEDB.12.0;Data Source=%s;' +
      'Extended Properties=Text;Persist Security Info=False',
      [ExtractFileDir(definicaoTxt.NomeArquivo)]);
  Except
    on E: Exception do
    begin
      raise;
    end;  
  End;
end;

class function TADOTxtFactory.GetTxt12Query(const strDiretorio: string): TADOQuery;
begin
  Try
    Result := TADOQuery.Create(nil);
    Result.ConnectionString := Format('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;' +
      'Extended Properties=text;Persist Security Info=False',
      [strDiretorio]);
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

class function TADOTxtFactory.GetTxtQuery(const strDiretorio: string): TADOQuery;
begin
  Try
    Result := TADOQuery.Create(nil);
    Result.ConnectionString := Format('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;' +
      'Extended Properties=text;Persist Security Info=False',
      [strDiretorio]);
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

end.


