unit untTTodasClassificacoesFiscaisMySQLLfe;

interface

uses System.Generics.Collections,
     untTClassificacaoFiscal,
     untTRepositorioBasico,
     Classes;

type
  TTodasClassificacoesFiscaisMySQL = class
  private
    FRepositorio: TRepositorioBasico;
  public
    function fRetTodasClassificaoesFiscais(stlCfops: TStringList): TObjectList<TClassificacaoFiscal>;

    constructor create;
    Destructor Destroy; override;
  end;

implementation

{ TTodasClassificacoesFiscaisMySQL }

constructor TTodasClassificacoesFiscaisMySQL.create;
begin
  FRepositorio := TRepositorioBasico.Create;
end;

destructor TTodasClassificacoesFiscaisMySQL.Destroy;
begin
  FRepositorio.Free;
  inherited;
end;

function TTodasClassificacoesFiscaisMySQL.fRetTodasClassificaoesFiscais(stlCfops: TStringList): TObjectList<TClassificacaoFiscal>;
begin
  Result := FRepositorio.fRetTodasClassificacoesFiscais(stlCfops);
end;

end.
