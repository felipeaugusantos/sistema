unit untIDefinicaoTxt;

interface

uses
  untDefinicaoTxtFormato, untDefinicaoTxtCharacterSet, untDefinicaoTxtCurrencyPosFormat,
  untIDefinicaoTxtCampo, untDefinicaoTxtCurrencyNegFormat;

type
  IDefinicaoTxt = interface
    ['{0A925DFD-5CC4-47F9-ADA4-FA4802A639D8}']
    function GetNomeArquivo: string;
    function GetFormat: TDefinicaoTxtFormato.Tipo;
    function GetSeparador: Char;
    function GetColNameHeader: Boolean;
    function GetMaxScanRows: Integer;
    function GetCharacterSet: TDefinicaoTxtCharacterSet.Tipo;
    function GetDateTimeFormat: string;
    function GetDecimalSymbol: Char;
    function GetNumberDigits: Integer;
    function GetNumberLeadingZeros: Boolean;
    function GetCurrencySymbol: string;
    function GetCurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo;
    function GetCurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo;
    function GetCurrencyDigits: Integer;
    function GetCurrencyThousandSymbol: Char;
    function GetCurrencyDecimalSymbol: Char;
    function GetCamposCount: Integer;
    function GetCampo(const index: Integer): IDefinicaoTxtCampo;

    property NomeArquivo: string read GetNomeArquivo;
    property Format: TDefinicaoTxtFormato.Tipo read GetFormat;
    property Separador: Char read GetSeparador;
    property ColNameHeader: Boolean read GetColNameHeader;
    property MaxScanRows: Integer read GetMaxScanRows;
    property CharacterSet: TDefinicaoTxtCharacterSet.Tipo read GetCharacterSet;
    property DateTimeFormat: string read GetDateTimeFormat;
    property DecimalSymbol: Char read GetDecimalSymbol;
    property NumberDigits: Integer read GetNumberDigits;
    property NumberLeadingZeros: Boolean read GetNumberLeadingZeros;
    property CurrencySymbol: string read GetCurrencySymbol;
    property CurrencyPosFormat: TDefinicaoTxtCurrencyPosFormat.Tipo read GetCurrencyPosFormat;
    property CurrencyDigits: Integer read GetCurrencyDigits;
    property CurrencyNegFormat: TDefinicaoTxtCurrencyNegFormat.Tipo read GetCurrencyNegFormat;
    property CurrencyThousandSymbol: Char read GetCurrencyThousandSymbol;
    property CurrencyDecimalSymbol: Char read GetCurrencyDecimalSymbol;
    property CamposCount: Integer read GetCamposCount;
    property Campo[const index: Integer]: IDefinicaoTxtCampo read GetCampo;
  end;

implementation

end.
