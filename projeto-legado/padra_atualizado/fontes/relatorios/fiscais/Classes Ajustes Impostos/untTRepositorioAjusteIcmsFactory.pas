unit untTRepositorioAjusteIcmsFactory;

interface

uses Uni,
     untIRepositorioAjusteIcms, untTRepositorioAjusteIcms, untTRepositorioAjusteIcmsDocumento, untTRepositorioAjusteIcmsProduto;

type
  TRepositorioAjusteIcmsFactory = class
  private
    class var FInstance: TRepositorioAjusteIcmsFactory;
    constructor create;
  public
    function fGetRepositorio(strTipo: string; conexao: TUniConnection): IRepositorioAjusteIcms;

    class function fGetInstance: TRepositorioAjusteIcmsFactory;
  end;

implementation

{ TRepositorioAjusteIcmsFactory }

constructor TRepositorioAjusteIcmsFactory.create;
begin
  inherited create;
end;

class function TRepositorioAjusteIcmsFactory.fGetInstance: TRepositorioAjusteIcmsFactory;
begin
  if not Assigned(FInstance) then
    FInstance := create;

  Result := FInstance;
end;

function TRepositorioAjusteIcmsFactory.fGetRepositorio(strTipo: string; conexao: TUniConnection): IRepositorioAjusteIcms;
begin
  Result := nil;

  if strTipo = 'GERAL' then
    Result := TRepositorioAjusteIcms.Create(conexao)
  else if strTipo = 'DOCUMENTO' then
    Result := TRepositorioAjusteIcmsDocumento.Create(conexao)
  else if strTipo = 'PRODUTO' then
    Result := TRepositorioAjusteIcmsProduto.Create(conexao);
end;

end.
