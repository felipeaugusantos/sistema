unit untTAutCca;

interface

uses
  System.SysUtils, System.Classes, Uni, DBAccess, DB;

type
  TAutCCA = class
  private
    FQuery: TUniQuery;
    FAutoincrem: string;
    FAppKey: string;
    FClientID: string;
    FClientSecret: string;
    FArquivoPfx: string;
    FSenhaCertificado: string;
    FDataValidadeCertificado: TDate;
    FAutenticacaoBasic: string;
  public
    constructor Create;
    destructor Destroy; override;

    // Propriedades
    property Autoincrem: string read FAutoincrem write FAutoincrem;
    property AppKey: string read FAppKey write FAppKey;
    property ClientID: string read FClientID write FClientID;
    property ClientSecret: string read FClientSecret write FClientSecret;
    property ArquivoPfx: string read FArquivoPfx write FArquivoPfx;
    property SenhaCertificado: string read FSenhaCertificado write FSenhaCertificado;
    property DataValidadeCertificado: TDate read FDataValidadeCertificado write FDataValidadeCertificado;
    property AutenticacaoBasic: string read FAutenticacaoBasic write FAutenticacaoBasic;

    function BuscarPorID(const ID: string): Boolean;
  end;

implementation

uses untTLibContasBancariasFuncoes;

{ TAutCCA }

constructor TAutCCA.Create;
begin
  inherited Create;
  FQuery := VS_FuncoesExternas.fICriaQuery;
end;

destructor TAutCCA.Destroy;
begin
  FQuery.Free;
  inherited Destroy;
end;

function TAutCCA.BuscarPorID(const ID: string): Boolean;
begin
  Result := False;
  try
    FQuery.SQL.Text := 'SELECT' +
                       '  AUTOINCREM,' +
                       '  AUT_APPKEY,' +
                       '  AUT_CLI_ID,' +
                       '  AUT_CLISEC,' +
                       '  AUT_ARQPFX,' +
                       '  AUT_SENCER,' +
                       '  AUT_VALCER,' +
                       '  AUT_AUTBAS' +
                       ' FROM AUTCCA' +
                       ' WHERE AUTOINCREM = :AUTOINCREM';
    FQuery.ParamByName('AUTOINCREM').AsString := ID;
    FQuery.Open;

    if not FQuery.IsEmpty then
    begin
      FAutoincrem := FQuery.FieldByName('AUTOINCREM').AsString;
      FAppKey := FQuery.FieldByName('AUT_APPKEY').AsString;
      FClientID := FQuery.FieldByName('AUT_CLI_ID').AsString;
      FClientSecret := FQuery.FieldByName('AUT_CLISEC').AsString;
      FArquivoPfx := FQuery.FieldByName('AUT_ARQPFX').AsString;
      FSenhaCertificado := FQuery.FieldByName('AUT_SENCER').AsString;
      FAutenticacaoBasic := FQuery.FieldByName('AUT_AUTBAS').AsString;

      FDataValidadeCertificado := 0;
      if not FQuery.FieldByName('AUT_VALCER').IsNull then
        FDataValidadeCertificado := FQuery.FieldByName('AUT_VALCER').AsDateTime;
      Result := true;
    end;

    FQuery.Close;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar registro: ' + E.Message);
  end;
end;

end.
