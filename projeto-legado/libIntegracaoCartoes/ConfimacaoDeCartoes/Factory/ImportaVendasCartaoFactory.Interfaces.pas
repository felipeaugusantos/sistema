unit ImportaVendasCartaoFactory.Interfaces;

interface

uses
  SysUtils, ImportaVendasCartao.Interfaces, Vcl.Menus, untFuncoesSimples;

type
  TConciliadora = (conREDECARD, conPAGARME);

  TConciliadoraHelper = record helper for TConciliadora
  public
    function FromString(AValue: String): TConciliadora;
    function ToString: String;
  end;

  IImportacaoVendasCartaoFactory = interface
  ['{2D3272C3-6FC9-4DF1-A973-47757F80E7C2}']
    function Conciliadora(AConciliadora: String): IImportacaoVendasCartao; overload;
    function Conciliadora(AConciliadora: TConciliadora): IImportacaoVendasCartao; overload;
  end;

implementation

{ TConciliadoraHelper }

function TConciliadoraHelper.FromString(AValue: String): TConciliadora;
begin
  Result := TConciliadora.conPAGARME;
  if fTiraCaracEspeciais(AValue.ToUpper) = 'PAGARME' then
    Result := TConciliadora.conPAGARME
  else if fTiraCaracEspeciais(AValue.ToUpper) = 'REDECARD' then
    Result := TConciliadora.conREDECARD;
end;

function TConciliadoraHelper.ToString: String;
begin
  case Self of
    conREDECARD: Result := 'REDECARD';
    conPAGARME:  Result := 'PAGAR.ME';
  else
    Result := 'UNKNOW';
  end;
end;

end.
