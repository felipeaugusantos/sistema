unit untTTransportadora;

interface

uses untTCidade;

type
  TTransportadora = class
    private
      FInscricaoEstadual: string;
      FUFPlaca: string;
      FPlaca: string;
      FCnpj: string;
      FCidade: TCidade;
    public
      constructor Create;
      destructor Destroy; override;

      property strInscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
      property strUFPlaca: string read FUFPlaca write FUFPlaca;
      property strPlaca: string read FPlaca write FPlaca;
      property strCnpj: string read FCnpj write FCnpj;
      property cidade: TCidade read FCidade write FCidade;
  end;


implementation

{ TTransportadora }

constructor TTransportadora.Create;
begin
  inherited;

  FCidade := TCidade.Create;
end;

destructor TTransportadora.Destroy;
begin
  FCidade.Free;

  inherited;
end;

end.
