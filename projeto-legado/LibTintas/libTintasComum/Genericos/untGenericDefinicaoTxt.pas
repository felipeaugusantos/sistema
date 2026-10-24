unit untGenericDefinicaoTxt;

interface

uses
  untIDefinicaoTxt, untDefinicaoTxtCharacterSet, untDefinicaoTxtCurrencyNegFormat,
  untDefinicaoTxtCurrencyPosFormat, untIDefinicaoTxtCampo, untDefinicaoTxtFormato,
  SysUtils, Windows;

type
  TGenericDefinicaoTxt = class(TInterfacedObject, IDefinicaoTxt)
  private
    strNomeArquivo: string;
    dtfFormat: TDefinicaoTxtFormato.Tipo;
    chaSeparador: Char;
    blnColNameHeader: Boolean;
    intMaxScanRows: Integer;
    dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo;
    strDateTimeFormat: string;
    chaDecimalSymbol: Char;
    intNumberDigits: Integer;
    blnNumberLeadingZeros: Boolean;
    strCurrencySymbol: string;
    dtcpfcurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo;
    intCurrencyDigits: Integer;
    dtcnfCurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo;
    chaCurrencyThousandSymbol: Char;
    chaCurrencyDecimalSymbol: Char;
    arrCampos: TArrayIDefinicaoTxtCampo;
    function GetNomeArquivo(const strNomeArquivo: string): string; overload;
  public
    function GetCampo(const index: Integer): IDefinicaoTxtCampo;
    function GetCamposCount: Integer;
    function GetCharacterSet: TDefinicaoTxtCharacterSet.Tipo;
    function GetColNameHeader: Boolean;
    function GetCurrencyDecimalSymbol: Char;
    function GetCurrencyDigits: Integer;
    function GetCurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo;
    function GetCurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo;
    function GetCurrencySymbol: string;
    function GetCurrencyThousandSymbol: Char;
    function GetDateTimeFormat: string;
    function GetDecimalSymbol: Char;
    function GetFormat: TDefinicaoTxtFormato.Tipo;
    function GetMaxScanRows: Integer;
    function GetNomeArquivo: string; overload;
    function GetNumberDigits: Integer;
    function GetNumberLeadingZeros: Boolean;
    function GetSeparador: Char;
  public
    constructor Create(const strNomeArquivo: string; const dtfFormat: TDefinicaoTxtFormato.Tipo; const chaSeparador: Char;
      const blnColNameHeader: Boolean; const intMaxScanRows: Integer; const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo;
      const strDateTimeFormat: string; const chaDecimalSymbol: Char; const intNumberDigits: Integer; const blnNumberLeadingZeros: Boolean;
      const strCurrencySymbol: string; const dtcpfCurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo; const intCurrencyDigits: Integer;
      const dtcnfCurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo; const chaCurrencyThousandSymbol: Char; const chaCurrencyDecimalSymbol: Char;
      const arrCampos: TArrayIDefinicaoTxtCampo); overload;

    constructor Create(const strNomeArquivo: string; const dtfFormat: TDefinicaoTxtFormato.Tipo; const chaSeparador: Char;
      const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol: Char;
      const arrCampos: TArrayIDefinicaoTxtCampo); overload;

    constructor Create(const strNomeArquivo: string; const dtfFormat: TDefinicaoTxtFormato.Tipo; const chaSeparador: Char;
      const arrCampos: TArrayIDefinicaoTxtCampo); overload;

    constructor Create(const strNomeArquivo: string; const blnColNameHeader: Boolean;
      const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol: Char;
      const chaCurrencyDecimalSymbol: Char; const arrCampos: TArrayIDefinicaoTxtCampo); overload;
      
    constructor Create(const strNomeArquivo: string; const blnColNameHeader: Boolean; const chaSeparador: Char;
      const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol: Char;
      const chaCurrencyDecimalSymbol: Char; const arrCampos: TArrayIDefinicaoTxtCampo); overload;

    constructor Create(const strNomeArquivo: string; const blnColNameHeader: Boolean; const chaSeparador: Char;
      const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol: Char;
      const chaCurrencyDecimalSymbol: Char; const strDateTimeFormat: string;
      const arrCampos: TArrayIDefinicaoTxtCampo); overload;

  end;

implementation

{ TGenericDefinicaoTxt }



constructor TGenericDefinicaoTxt.Create(const strNomeArquivo: string; const dtfFormat: TDefinicaoTxtFormato.Tipo; const chaSeparador: Char;
  const blnColNameHeader: Boolean; const intMaxScanRows: Integer; const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo;
  const strDateTimeFormat: string; const chaDecimalSymbol: Char; const intNumberDigits: Integer; const blnNumberLeadingZeros: Boolean;
  const strCurrencySymbol: string; const dtcpfCurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo; const intCurrencyDigits: Integer;
  const dtcnfCurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo; const chaCurrencyThousandSymbol, chaCurrencyDecimalSymbol: Char;
  const arrCampos: TArrayIDefinicaoTxtCampo);
begin
  inherited Create();
  Self.strNomeArquivo := GetNomeArquivo(strNomeArquivo);
  Self.dtfFormat := dtfFormat;
  Self.chaSeparador := chaSeparador;
  Self.blnColNameHeader := blnColNameHeader;
  Self.intMaxScanRows := intMaxScanRows;
  Self.dtcsCharacterSet := dtcsCharacterSet;
  Self.strDateTimeFormat := strDateTimeFormat;
  Self.chaDecimalSymbol := chaDecimalSymbol;
  Self.intNumberDigits := intNumberDigits;
  Self.blnNumberLeadingZeros := blnNumberLeadingZeros;
  Self.strCurrencySymbol := strCurrencySymbol;
  Self.dtcpfcurrencyPosFormat := dtcpfcurrencyPosFormat;
  Self.intCurrencyDigits := intCurrencyDigits;
  Self.dtcnfCurrencyNegFormat := dtcnfCurrencyNegFormat;
  Self.chaCurrencyThousandSymbol := chaCurrencyThousandSymbol;
  Self.chaCurrencyDecimalSymbol := chaCurrencyDecimalSymbol;
  Self.arrCampos := arrCampos;
end;

constructor TGenericDefinicaoTxt.Create(const strNomeArquivo: string; const dtfFormat: TDefinicaoTxtFormato.Tipo;
  const chaSeparador: Char; const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol: Char;
  const arrCampos: TArrayIDefinicaoTxtCampo);
begin
  Create(strNomeArquivo,
    dtfFormat,
    chaSeparador,
    True,
    -1,
    dtcsCharacterSet,
    '',
    chaDecimalSymbol,
    -1,
    False,
    '',
    dtcpfDefault,
    -1,
    dtcnfDefault,
    #0,
    #0,
    arrCampos);
end;

constructor TGenericDefinicaoTxt.Create(const strNomeArquivo: string; const dtfFormat: TDefinicaoTxtFormato.Tipo; const chaSeparador: Char;
  const arrCampos: TArrayIDefinicaoTxtCampo);
begin
  Create(strNomeArquivo, dtfFormat, chaSeparador, dtcsDefault, chaDecimalSymbol, arrCampos);
end;

constructor TGenericDefinicaoTxt.Create(const strNomeArquivo: string; const blnColNameHeader: Boolean;
  const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol, chaCurrencyDecimalSymbol: Char;
  const arrCampos: TArrayIDefinicaoTxtCampo);
begin
  Create(strNomeArquivo,
    dtfFixed,
    #0,
    blnColNameHeader,
    -1,
    dtcsCharacterSet,
    '',
    chaDecimalSymbol,
    -1,
    False,
    '',
    dtcpfDefault,
    -1,
    dtcnfDefault,
    #0,
    chaCurrencyDecimalSymbol,
    arrCampos);
end;

function TGenericDefinicaoTxt.GetCampo(const index: Integer): IDefinicaoTxtCampo;
begin
  Result := arrCampos[index];
end;

function TGenericDefinicaoTxt.GetCamposCount: Integer;
begin
  Result := Length(arrCampos);
end;

function TGenericDefinicaoTxt.GetCharacterSet: TDefinicaoTxtCharacterSet.Tipo;
begin
  Result := dtcsCharacterSet;
end;

function TGenericDefinicaoTxt.GetColNameHeader: Boolean;
begin
  Result := blnColNameHeader;
end;

function TGenericDefinicaoTxt.GetCurrencyDecimalSymbol: Char;
begin
  Result := chaCurrencyDecimalSymbol;
end;

function TGenericDefinicaoTxt.GetCurrencyDigits: Integer;
begin
  Result := intCurrencyDigits;
end;

function TGenericDefinicaoTxt.GetCurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo;
begin
  Result := dtcnfCurrencyNegFormat;
end;

function TGenericDefinicaoTxt.GetCurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo;
begin
  Result := dtcpfcurrencyPosFormat;
end;

function TGenericDefinicaoTxt.GetCurrencySymbol: string;
begin
  Result := strCurrencySymbol;
end;

function TGenericDefinicaoTxt.GetCurrencyThousandSymbol: Char;
begin
  Result := chaCurrencyThousandSymbol;
end;

function TGenericDefinicaoTxt.GetDateTimeFormat: string;
begin
  Result := strDateTimeFormat;
end;

function TGenericDefinicaoTxt.GetDecimalSymbol: Char;
begin
  Result := chaDecimalSymbol;
end;

function TGenericDefinicaoTxt.GetFormat: TDefinicaoTxtFormato.Tipo;
begin
  Result := dtfFormat;
end;

function TGenericDefinicaoTxt.GetMaxScanRows: Integer;
begin
  Result := intMaxScanRows;
end;

function TGenericDefinicaoTxt.GetNomeArquivo: string;
begin
  Result := strNomeArquivo;
end;

function TGenericDefinicaoTxt.GetNomeArquivo(const strNomeArquivo: string): string;
var
  strDiretorio: string;
  strExtensao: string;
  strNovoNome: string;
begin
  Result := strNomeArquivo;
  strDiretorio := ExtractFilePath(strNomeArquivo);
  strExtensao := ExtractFileExt(strNomeArquivo);
  strNovoNome := Copy(strNomeArquivo, LastDelimiter('\', strNomeArquivo) + 1, Length(strNomeArquivo));
  strNovoNome := Copy(strNovoNome, 1, LastDelimiter('.', strNovoNome) - 1);

  if Pos('.', strNovoNome) > 0 then
  begin
    strNovoNome := StringReplace(strNovoNome, '.', ' ', [rfReplaceAll]);
    strNovoNome := strDiretorio + strNovoNome + strExtensao;
    CopyFile(PWideChar(strNomeArquivo), PWideChar(strNovoNome), False);
    Result := strNovoNome;
  end;  
end;

function TGenericDefinicaoTxt.GetNumberDigits: Integer;
begin
  Result := intNumberDigits;
end;

function TGenericDefinicaoTxt.GetNumberLeadingZeros: Boolean;
begin
  Result := blnNumberLeadingZeros;
end;

function TGenericDefinicaoTxt.GetSeparador: Char;
begin
  Result := chaSeparador;
end;

constructor TGenericDefinicaoTxt.Create(const strNomeArquivo: string; const blnColNameHeader: Boolean; const chaSeparador: Char;
  const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol, chaCurrencyDecimalSymbol: Char;
  const arrCampos: TArrayIDefinicaoTxtCampo);
begin
  Create(strNomeArquivo,
    dtfCustom,
    chaSeparador,
    blnColNameHeader,
    -1,
    dtcsCharacterSet,
    '',
    chaDecimalSymbol,
    -1,
    False,
    '',
    dtcpfDefault,
    -1,
    dtcnfDefault,
    #0,
    chaCurrencyDecimalSymbol,
    arrCampos);
end;

constructor TGenericDefinicaoTxt.Create(const strNomeArquivo: string; const blnColNameHeader: Boolean; const chaSeparador: Char;
  const dtcsCharacterSet: TDefinicaoTxtCharacterSet.Tipo; const chaDecimalSymbol, chaCurrencyDecimalSymbol: Char;
  const strDateTimeFormat: string; const arrCampos: TArrayIDefinicaoTxtCampo);
begin
  Create(strNomeArquivo,
    dtfCustom,
    chaSeparador,
    blnColNameHeader,
    -1,
    dtcsCharacterSet,
    strDateTimeFormat,
    chaDecimalSymbol,
    -1,
    False,
    '',
    dtcpfDefault,
    -1,
    dtcnfDefault,
    #0,
    chaCurrencyDecimalSymbol,
    arrCampos);
end;

end.
