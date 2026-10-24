unit Shared.Functions.Faturamento.TintaDeMaquina;

interface


Type
  ITintaDeMaquina = Interface
  ['{4F9EE893-522A-4606-B957-48BBB497D70E}']
    function RetornarAutcomTintaDll : THandle;

    function fGetTintaImobiliaria(Const strIdePro : String) : Boolean;
    function fGetTintaAutomotiva(Const strIdePro : String)  : Boolean;
    function fGetTintaIndustrial(Const strIdePro : String)  : Boolean;
  End;

  procedure SetObjTintaDeMaquina(AValue : ITintaDeMaquina);

  Var
    ObjTintaDeMaquina : ITintaDeMaquina;

implementation

procedure SetObjTintaDeMaquina(AValue: ITintaDeMaquina);
begin
  ObjTintaDeMaquina := AValue;
end;


end.
