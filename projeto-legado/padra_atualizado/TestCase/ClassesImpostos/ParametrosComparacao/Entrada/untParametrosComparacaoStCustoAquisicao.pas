unit untParametrosComparacaoStCustoAquisicao;


interface

Uses
 Shared.Functions.Types;

Type
  IParametrosComparacaoStCustoAquisicao = interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']

    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function ValorDoIcmsOperacoesProprias: Double; overload;
    function ValorDoIcmsOperacoesProprias(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;
	
  end;

Type
  TParametrosComparacaoStCustoAquisicao = Class(TInterfacedObject, IParametrosComparacaoStCustoAquisicao)
  Private
    FBaseDaSTCustoAquisicao: Double; 
    FValorDaSTCustoAquisicao: Double; 
    FValorDoIcmsOperacoesProprias: Double; 
    FFatorPositivo: Double; 
    FFatorNegativo: Double;
  Public
    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function ValorDoIcmsOperacoesProprias: Double; overload;
    function ValorDoIcmsOperacoesProprias(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IParametrosComparacaoStCustoAquisicao; overload;

    Class Function New() : IParametrosComparacaoStCustoAquisicao;
  End;


implementation

{ TParametrosComparacaoStCustoAquisicao }

function TParametrosComparacaoStCustoAquisicao.BaseDaSTCustoAquisicao: Double;
begin
  Result := FBaseDaSTCustoAquisicao;
end;

function TParametrosComparacaoStCustoAquisicao.BaseDaSTCustoAquisicao(
  AValue: Double): IParametrosComparacaoStCustoAquisicao;
begin
  Result := Self;
  FBaseDaSTCustoAquisicao := AValue;
end;

function TParametrosComparacaoStCustoAquisicao.FatorNegativo: Double;
begin
  Result := FFatorNegativo;
end;

function TParametrosComparacaoStCustoAquisicao.FatorNegativo(
  AValue: Double): IParametrosComparacaoStCustoAquisicao;
begin
  Result := Self;
  FFatorNegativo := AValue;
end;

function TParametrosComparacaoStCustoAquisicao.FatorPositivo: Double;
begin
  Result := FFatorPositivo;
end;

function TParametrosComparacaoStCustoAquisicao.FatorPositivo(
  AValue: Double): IParametrosComparacaoStCustoAquisicao;
begin
  Result := Self;
  FFatorPositivo := AValue;
end;

class function TParametrosComparacaoStCustoAquisicao.New: IParametrosComparacaoStCustoAquisicao;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoStCustoAquisicao.ValorDaSTCustoAquisicao(
  AValue: Double): IParametrosComparacaoStCustoAquisicao;
begin
  Result := Self;
  FValorDaSTCustoAquisicao := AValue;
end;

function TParametrosComparacaoStCustoAquisicao.ValorDaSTCustoAquisicao: Double;
begin
  Result := FValorDaSTCustoAquisicao;
end;

function TParametrosComparacaoStCustoAquisicao.ValorDoIcmsOperacoesProprias(
  AValue: Double): IParametrosComparacaoStCustoAquisicao;
begin
  Result := Self;
  FValorDoIcmsOperacoesProprias := AValue;
end;

function TParametrosComparacaoStCustoAquisicao.ValorDoIcmsOperacoesProprias: Double;
begin
  Result := FValorDoIcmsOperacoesProprias;
end;

end.

