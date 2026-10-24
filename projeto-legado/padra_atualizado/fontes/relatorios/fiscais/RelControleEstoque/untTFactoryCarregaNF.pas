unit untTFactoryCarregaNF;

interface

uses untTCarregaNFCompra, untTCarregaNFVenda, untTDadosAbertura, untICarregaNF, SysUtils;

type
  TFactoryCarregaNF = class
  private
    class var FInstance: TFactoryCarregaNF;
    constructor create;
  public
    class function fGetInstance: TFactoryCarregaNF;
    function fRetCarregador(strTipo: string; dadosAbertura: TDadosAbertura): ICarregaNF;
  end;

implementation

{ TFactoryCarregaNF }

constructor TFactoryCarregaNF.create;
begin
  inherited create;
end;

class function TFactoryCarregaNF.fGetInstance: TFactoryCarregaNF;
begin
  if not Assigned(FInstance) then
    FInstance := create;

  Result := FInstance;
end;

function TFactoryCarregaNF.fRetCarregador(strTipo: string; dadosAbertura: TDadosAbertura): ICarregaNF;
begin
  Result := nil;

  if UpperCase(strTipo) = 'ENTRADA' then
    Result := TCarregaNFCompra.Create(dadosAbertura)
  else if UpperCase(strTipo) = 'SAIDA' then
    Result := TCarregaNFVenda.Create(dadosAbertura);
end;

end.
