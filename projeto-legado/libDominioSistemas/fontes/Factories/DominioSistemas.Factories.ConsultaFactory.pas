unit DominioSistemas.Factories.ConsultaFactory;

interface

uses
  DominioSistemas.Core.ConsultaInterface ;

type
  TConsultaFactory = class(TInterfacedObject, IConsultaFactory)
  public
    function fProtocolo: IConsultaProtocolo;
    function fAtivacao: IConsultaAtivacao;
    class function New: IConsultaFactory ;
  end;

implementation

uses
  DominioSistemas.Service.ConsultasEspecificas ;

{ TConsultaFactory }

function TConsultaFactory.fAtivacao: IConsultaAtivacao;
begin
  Result := TConsultasEspecificas.Create ;
end;

function TConsultaFactory.fProtocolo: IConsultaProtocolo;
begin
  Result := TConsultasEspecificas.Create ;
end;

class function TConsultaFactory.New: IConsultaFactory;
begin
  Result := Self.Create ;
end;

end.
