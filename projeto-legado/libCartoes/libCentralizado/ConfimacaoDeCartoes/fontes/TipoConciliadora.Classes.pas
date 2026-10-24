unit TipoConciliadora.Classes;

interface

uses System.SysUtils, System.Classes;

type
  TTipoConciliadora = (tcOperadora, tcMarketPlace);

  THelperTipoConciliadora = record helper for TTipoConciliadora
    function FromString(AConciliadora: String): TTipoConciliadora;
    function ToString: String;
  end;

implementation

{ THelperTipoConciliadora }

function THelperTipoConciliadora.FromString(
  AConciliadora: String): TTipoConciliadora;
const
  MARKETPLACE = 'PAGAR.ME_MERCADOLIVRE_SHOPEE';
begin
  if Pos(AConciliadora.ToUpper, MARKETPLACE) > 0 then
    Result := TTipoConciliadora.tcMarketPlace
  else
    Result := TTipoConciliadora.tcOperadora;
end;

function THelperTipoConciliadora.ToString: String;
begin
  case Self of
    tcOperadora: Result   := 'OPERADORA';
    tcMarketPlace: Result := 'MARKETPLACE';
  else
    Result := 'UNKNOW';
  end;
end;

end.
