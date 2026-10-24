unit DominioSistemas.Factories.AutenticacaoFactory;

interface

uses
  DominioSistemas.Core.AutenticacaoInterface ;

type
  TAutenticacaoFactory = class(TInterfacedObject, IAutenticacaoFactory)
  public
    function fCriar: IAutenticacao;
    class function New: IAutenticacaoFactory ;
  end ;

implementation

uses
  DominioSistemas.Service.Autenticacao ;

{ TAutenticacaoFactory }

function TAutenticacaoFactory.fCriar: IAutenticacao;
begin
  Result := TAutenticacao.Create ;
end;

class function TAutenticacaoFactory.New: IAutenticacaoFactory;
begin
  Result := Self.Create ;
end;

end.
