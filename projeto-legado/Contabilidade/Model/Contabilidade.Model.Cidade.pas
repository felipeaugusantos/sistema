unit Contabilidade.Model.Cidade;

interface

Type
  TCidade = class
    private
      FCodigo: String;
      FNome: String;
      FEstado: String;
      FCodigoIbge: String;
    public
      property strCodigo: String read FCodigo write FCodigo;
      property strNome: String read FNome write FNome;
      property strEstado: String read FEstado write FEstado;
      property strCodigoIbge: String read FCodigoIbge write FCodigoIbge;

      constructor Create;
  End;

implementation

{ TCidade }

constructor TCidade.Create;
begin
  inherited;

  FCodigo := '';
  FNome := '';
  FEstado := '';
  FCodigoIbge := '';
end;

end.
