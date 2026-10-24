unit DominioSistemas.Service.Autenticacao;

interface

uses
  DominioSistemas.Core.AutenticacaoInterface ;

type
  TAutenticacao = class(TInterfacedObject, IAutenticacao)
  public
    function fGetAccessToken(const ACodEmp: String): String ;
    function fGetXIntegrationKey(const ACodEmp: String): String ;
  end ;

implementation

uses
  DominioSistemas.Infra.APIClient, DominioSistemas.Infra.Repository ;

{ TAutenticacao }

function TAutenticacao.fGetAccessToken(const ACodEmp: String): String;
begin
  Result := TApiTokenClient.fGerarToken(ACodEmp) ;
end;

function TAutenticacao.fGetXIntegrationKey(const ACodEmp: String): String;
begin
  Result := TMySQLRepository.fGetXIntegrationKey(ACodEmp) ;
end;

end.
