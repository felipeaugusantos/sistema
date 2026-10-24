unit OrdemProducaoIndustrial.TCor;

interface

uses
  Classes;

Type
  TCor = class
    private
      FCodigo    : String;
      FDescricao : String;
    public
      property strCodigo: String    read FCodigo    write FCodigo;
      property strDescricao: String read FDescricao write FDescricao;

      constructor Create;

      procedure Clear;
  End;

implementation

{ TCor }

procedure TCor.Clear;
begin
  FCodigo    := '';
  FDescricao := '';
end;

constructor TCor.Create;
begin
  Clear;
end;

end.

