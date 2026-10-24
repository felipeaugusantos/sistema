unit untDDAApiHelpers;

interface

uses
  System.SysUtils, System.JSON, System.DateUtils;

  function LerTextoJson(const AObjeto: TJSONObject; const ANomeCampo: string): string;
  function LerNumeroJson(const AObjeto: TJSONObject; const ANomeCampo: string): Double;
  function LerDataJson(const AObjeto: TJSONObject; const ANomeCampo: string): TDateTime;

  function SomenteDigitos(const ATexto: string): string;
  function CpfCnpjToCNPCPF(const ADocumento: string): string;

  function BancoDoCodigoBarras(const ACodBarras: string): string;
  function CampoLivreDoCodigoBarras(const ACodBarras: string): string;
  function fCalcularFatorVencimento(const ADataVencimento: TDateTime): string;

implementation


function LerTextoJson(const AObjeto: TJSONObject; const ANomeCampo: string): string;
var
  LValorJson: TJSONValue;
begin
  Result := EmptyStr;
  if AObjeto = nil then
    Exit;

  LValorJson := AObjeto.GetValue(ANomeCampo);
  if LValorJson = nil then
    Exit;

  if LValorJson is TJSONString then
    Result := TJSONString(LValorJson).Value
  else
    Result := LValorJson.Value;
end;

function LerNumeroJson(const AObjeto: TJSONObject; const ANomeCampo: string): Double;
var
  LNumero: Double;
  LInteiro: Integer;
  LTexto: string;
  LAjustes: TFormatSettings;
begin
  if (AObjeto <> nil) and AObjeto.TryGetValue<Double>(ANomeCampo, LNumero) then
    Exit(LNumero);

  if (AObjeto <> nil) and AObjeto.TryGetValue<Integer>(ANomeCampo, LInteiro) then
    Exit(LInteiro);

  LTexto := LerTextoJson(AObjeto, ANomeCampo);
  if LTexto = EmptyStr then
    Exit(0);

  LAjustes := TFormatSettings.Create;
  LAjustes.DecimalSeparator := '.';
  if not TryStrToFloat(LTexto, LNumero, LAjustes) then
  begin
    LAjustes.DecimalSeparator := ',';
    if not TryStrToFloat(LTexto, LNumero, LAjustes) then
      LNumero := 0;
  end;

  Result := LNumero;
end;

function LerDataJson(const AObjeto: TJSONObject; const ANomeCampo: string): TDateTime;
var
  LTextoData: string;
  LAjustes: TFormatSettings;
begin
  Result := 0;
  LTextoData := LerTextoJson(AObjeto, ANomeCampo);
  if LTextoData = '' then
    Exit;

  LTextoData := Copy(LTextoData, 1, 10);

  LAjustes := TFormatSettings.Create;
  LAjustes.ShortDateFormat := 'yyyy-mm-dd';
  LAjustes.DateSeparator   := '-';

  Result := StrToDateDef(LTextoData, 0, LAjustes);
end;

function SomenteDigitos(const ATexto: string): string;
var
  LIndice: Integer;
  LCaractere: Char;
begin
  SetLength(Result, Length(ATexto));
  LIndice := 0;
  for LCaractere in ATexto do
    if (LCaractere >= '0') and (LCaractere <= '9') then
    begin
      Inc(LIndice);
      Result[LIndice] := LCaractere;
    end;
  SetLength(Result, LIndice);
end;

function CpfCnpjToCNPCPF(const ADocumento: string): string;
var
  LDigitos: string;
  LTamanho: Integer;
begin
  LDigitos := SomenteDigitos(ADocumento);
  LTamanho := Length(LDigitos);

  if LTamanho = 11 then
    Result := '1' // CPF
  else if LTamanho = 14 then
    Result := '2' // CNPJ
  else
    if LTamanho <= 11 then
      Result := '1'
    else
      Result := '2';
end;

function BancoDoCodigoBarras(const ACodBarras: string): string;
var
  LDigitos: string;
begin
  LDigitos := SomenteDigitos(ACodBarras);
  if Length(LDigitos) >= 3 then
    Result := Copy(LDigitos, 1, 3)
  else
    Result := EmptyStr;
end;

function CampoLivreDoCodigoBarras(const ACodBarras: string): string;
var
  LDigitos: string;
begin
  Result := EmptyStr;
  LDigitos := SomenteDigitos(ACodBarras);
  if Length(LDigitos) = 44 then
    Result := Copy(LDigitos, 20, 25);
end;

function fCalcularFatorVencimento(const ADataVencimento: TDateTime): string;
Const
  LDataBaseNova = '22/02/2025';
  LDataBaseAntiga = '07/10/1997';
  LFatorBase = 1000;
var
  LDiasCorridos: Integer;
  LDataBaseDate: TDateTime;
begin
  Result := '';

  if (ADataVencimento < StrToDateTime(LDataBaseNova)) then
    Result := FloatToStr(ADataVencimento - StrToDateTime(LDataBaseAntiga))
  else
  begin
    LDataBaseDate := StrToDate(LDataBaseNova);
    LDiasCorridos := DaysBetween(ADataVencimento, LDataBaseDate);
    Result := IntToStr(LFatorBase + LDiasCorridos);
  end;
end;

end.
