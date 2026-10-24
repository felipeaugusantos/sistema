unit untTRepositorioLfeFactory;

interface

uses untTTodasEmpresasMySQL,
     untTTodasNotasMySQL,
     untTRepositorioLfe,
     untTDadosAbertura;

type
  TRepositorioLfeFactory = class
  public
    class function fRetRepositorio(abertura: TDadosAbertura): TRepositorio;
  end;

implementation

{ TRepositorioLfeFactory }

class function TRepositorioLfeFactory.fRetRepositorio(abertura: TDadosAbertura): TRepositorio;
begin
  Result := TRepositorio.Create(abertura);
end;

end.
