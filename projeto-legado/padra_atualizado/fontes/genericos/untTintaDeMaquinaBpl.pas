unit untTintaDeMaquinaBpl;

interface

Uses
  Windows,
  Shared.Functions.Faturamento.TintaDeMaquina,
  untFuncoesTintaDeMaquinaBpl;

type
  TTintaDeMaquinaBpl = class(TInterfacedObject, ITintaDeMaquina)
  public
    function RetornarAutcomTintaDll : THandle;

    function fGetTintaImobiliaria(Const strIdePro : String) : Boolean;
    function fGetTintaAutomotiva(Const strIdePro : String)  : Boolean;
    function fGetTintaIndustrial(Const strIdePro : String)  : Boolean;

    class function New: ITintaDeMaquina;
  end;

implementation

{ TTintaDeMaquinaBpl }

function TTintaDeMaquinaBpl.fGetTintaAutomotiva(
  const strIdePro: String): Boolean;
begin
  Result := untFuncoesTintaDeMaquinaBpl.fGetTintaAutomotiva(strIdePro);
end;

function TTintaDeMaquinaBpl.fGetTintaImobiliaria(
  const strIdePro: String): Boolean;
begin
  Result := untFuncoesTintaDeMaquinaBpl.fGetTintaImobiliaria(strIdePro);
end;

function TTintaDeMaquinaBpl.fGetTintaIndustrial(
  const strIdePro: String): Boolean;
begin
  Result := untFuncoesTintaDeMaquinaBpl.fGetTintaIndustrial(strIdePro);
end;

class function TTintaDeMaquinaBpl.New: ITintaDeMaquina;
begin
  Result := Self.Create;
end;

function TTintaDeMaquinaBpl.RetornarAutcomTintaDll: THandle;
begin
  Result := untFuncoesTintaDeMaquinaBpl.RetornarAutcomTintaDll;
end;

initialization
  SetObjTintaDeMaquina(TTintaDeMaquinaBpl.New());
end.
