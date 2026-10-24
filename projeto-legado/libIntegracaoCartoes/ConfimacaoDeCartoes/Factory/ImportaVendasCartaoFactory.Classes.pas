unit ImportaVendasCartaoFactory.Classes;

interface

uses
  ImportaVendasCartao.Interfaces, ImportaVendasCartaoFactory.Interfaces, VCL.Menus,
  SysUtils, Classes;

type


  TImportacaoVendasCartaoFactory = class(TInterfacedObject, IImportacaoVendasCartaoFactory)
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IImportacaoVendasCartaoFactory;
    function Conciliadora(AConciliadora: String): IImportacaoVendasCartao; overload;
    function Conciliadora(AConciliadora: TConciliadora): IImportacaoVendasCartao; overload;
  end;

implementation

uses
  ImportaVendasPagarMe.Classes, untFuncoesSimples;

constructor TImportacaoVendasCartaoFactory.Create;
begin

end;

destructor TImportacaoVendasCartaoFactory.Destroy;
begin

  inherited;
end;

class function TImportacaoVendasCartaoFactory.New: IImportacaoVendasCartaoFactory;
begin
  Result := Self.Create;
end;

function TImportacaoVendasCartaoFactory.Conciliadora(AConciliadora: String): IImportacaoVendasCartao;
var
  LOperadora: TConciliadora;
begin
  Result := Conciliadora(LOperadora.FromString(AConciliadora));
end;

function TImportacaoVendasCartaoFactory.Conciliadora(
  AConciliadora: TConciliadora): IImportacaoVendasCartao;
begin
  case AConciliadora of
    conPAGARME: Result := TImportaVendasPagarMe.New;
  else
    raise Exception.Create('Ainda não temos suporte para esta conciliadora!');
  end;
end;

end.
