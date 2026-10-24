unit Contabilidade.Classes.TParametrosFormContasPorEmpresa;

interface

uses Contabilidade.Interfaces, UniClientDataSet;

type
  TParametrosFormContasPorEmpresa = Class(TInterfacedObject, IParametrosFormContasPorEmpresa)
  private
    FTabela: String;
    FCampoChave: string;
    FCriaDataSet: boolean;
    FCdsDados: TUniClientDataSet;
    FCreditoDebito: string;
    FValorChave: string;
    FReadOnly: Boolean;
  public
    function Tabela: String; overload;
    function Tabela(AValue: String): IParametrosFormContasPorEmpresa; overload;
    function CampoChave: string; overload;
    function CampoChave(AValue: string): IParametrosFormContasPorEmpresa; overload;
    function CriaDataSet: boolean; overload;
    function CriaDataSet(AValue: boolean): IParametrosFormContasPorEmpresa; overload;
    function CdsDados: TUniClientDataSet; overload;
    function CdsDados(AValue: TUniClientDataSet): IParametrosFormContasPorEmpresa; overload;
    function CreditoDebito: string; overload;
    function CreditoDebito(AValue: string): IParametrosFormContasPorEmpresa; overload;
    function ValorChave: string; overload;
    function ValorChave(AValue: string): IParametrosFormContasPorEmpresa; overload;
    function ReadOnly: Boolean; overload;
    function ReadOnly(AValue: Boolean): IParametrosFormContasPorEmpresa; overload;
    constructor Create;
    class function New: IParametrosFormContasPorEmpresa;
  end;

implementation

{ TParametrosFormContasPorEmpresa }

function TParametrosFormContasPorEmpresa.CampoChave(
  AValue: string): IParametrosFormContasPorEmpresa;
begin
  Result := Self;
  FCampoChave := AValue;
end;

function TParametrosFormContasPorEmpresa.CampoChave: string;
begin
  Result := FCampoChave;
end;

function TParametrosFormContasPorEmpresa.CdsDados: TUniClientDataSet;
begin
  Result := FCdsDados;
end;

function TParametrosFormContasPorEmpresa.CdsDados(
  AValue: TUniClientDataSet): IParametrosFormContasPorEmpresa;
begin
  Result := Self;
  FcdsDados := AValue;
end;

constructor TParametrosFormContasPorEmpresa.Create;
begin
  inherited;

  FTabela := '';
  FValorChave := '';
  FCampoChave := '';
  FCriaDataSet := True;
  FcdsDados := Nil;
  FCreditoDebito := '';
  FReadOnly := False;
end;

function TParametrosFormContasPorEmpresa.CreditoDebito(
  AValue: string): IParametrosFormContasPorEmpresa;
begin
  Result := Self;
  FCreditoDebito := AValue;
end;

function TParametrosFormContasPorEmpresa.CreditoDebito: string;
begin
  Result := FCreditoDebito;
end;

function TParametrosFormContasPorEmpresa.CriaDataSet: boolean;
begin
  Result := FCriaDataSet;
end;

function TParametrosFormContasPorEmpresa.CriaDataSet(
  AValue: boolean): IParametrosFormContasPorEmpresa;
begin
  Result := Self;
  FCriaDataSet := AValue;
end;

class function TParametrosFormContasPorEmpresa.New: IParametrosFormContasPorEmpresa;
begin
  Result := Self.Create;
end;

function TParametrosFormContasPorEmpresa.ReadOnly: Boolean;
begin
  Result := FReadOnly ;
end;

function TParametrosFormContasPorEmpresa.ReadOnly(
  AValue: Boolean): IParametrosFormContasPorEmpresa;
begin
  Result := Self ;
  FReadOnly := AValue ;
end;

function TParametrosFormContasPorEmpresa.Tabela(
  AValue: String): IParametrosFormContasPorEmpresa;
begin
  Result := Self;
  FTabela := AValue;
end;

function TParametrosFormContasPorEmpresa.Tabela: String;
begin
  Result := FTabela;
end;

function TParametrosFormContasPorEmpresa.ValorChave(
  AValue: string): IParametrosFormContasPorEmpresa;
begin
  Result := Self;
  FValorChave := AValue;
end;

function TParametrosFormContasPorEmpresa.ValorChave: string;
begin
  Result := FValorChave;
end;

end.
