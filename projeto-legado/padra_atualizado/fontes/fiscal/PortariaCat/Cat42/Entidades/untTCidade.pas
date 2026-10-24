unit untTCidade;

interface

Type
  TCidade = class
    private
      FCodigo: String;
      FNome: String;
      FEstado: String;
      FCodigoIbge: String;
      FCodPai: string;
      FCodCid: string;
    public
      property strCodigo: String read FCodigo write FCodigo;
      property strNome: String read FNome write FNome;
      property strEstado: String read FEstado write FEstado;
      property strCodigoIbge: String read FCodigoIbge write FCodigoIbge;
      property strCodPai: string read FCodPai write FCodPai;
      property strCodCid: string read FCodCid write FCodCid;

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
  FCodCid := '';
end;

end.
