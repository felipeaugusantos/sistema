unit untParametrosResultadoStCustoAquisicao;

interface

Uses
 Shared.Functions.Types;

type
  IParametrosResultadoStCustoAquisicao = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']
    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function ValorDoIcmsOperacoesProprias: Double; overload;
    function ValorDoIcmsOperacoesProprias(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;	
  end;

type
  TParametrosResultadoStCustoAquisicao = class(TInterfacedObject, IParametrosResultadoStCustoAquisicao)
  private
    FBaseDaSTCustoAquisicao: Double;
    FValorDaSTCustoAquisicao: Double;
    FValorDoIcmsOperacoesProprias: Double;
    FFatorPositivo: Double; 
    FFatorNegativo: Double; 
  public
    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function ValorDoIcmsOperacoesProprias: Double; overload;
    function ValorDoIcmsOperacoesProprias(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IParametrosResultadoStCustoAquisicao; overload;		
	

    class function New(): IParametrosResultadoStCustoAquisicao;
  end;

implementation

{ TParametrosResultadoStCustoAquisicao }

function TParametrosResultadoStCustoAquisicao.BaseDaSTCustoAquisicao: Double;
begin
  Result := FBaseDaSTCustoAquisicao;
end;

function TParametrosResultadoStCustoAquisicao.BaseDaSTCustoAquisicao(
  AValue: Double): IParametrosResultadoStCustoAquisicao;
begin
  Result := Self;
  FBaseDaSTCustoAquisicao := AValue;
end;

function TParametrosResultadoStCustoAquisicao.FatorNegativo: Double;
begin
  Result := FFatorNegativo;
end;

function TParametrosResultadoStCustoAquisicao.FatorNegativo(
  AValue: Double): IParametrosResultadoStCustoAquisicao;
begin
  Result := Self;
  FFatorNegativo := AValue;
end;

function TParametrosResultadoStCustoAquisicao.FatorPositivo: Double;
begin
  Result := FFatorPositivo;
end;

function TParametrosResultadoStCustoAquisicao.FatorPositivo(
  AValue: Double): IParametrosResultadoStCustoAquisicao;
begin
  Result := Self;
  FFatorPositivo := AValue;
end;

class function TParametrosResultadoStCustoAquisicao.New: IParametrosResultadoStCustoAquisicao;
begin
  Result := Self.Create;
end;

function TParametrosResultadoStCustoAquisicao.ValorDaSTCustoAquisicao(
  AValue: Double): IParametrosResultadoStCustoAquisicao;
begin
  Result := Self;
  FValorDaSTCustoAquisicao := AValue;
end;

function TParametrosResultadoStCustoAquisicao.ValorDaSTCustoAquisicao: Double;
begin
  Result := FValorDaSTCustoAquisicao;
end;

function TParametrosResultadoStCustoAquisicao.ValorDoIcmsOperacoesProprias(
  AValue: Double): IParametrosResultadoStCustoAquisicao;
begin
  Result := Self;
  FValorDoIcmsOperacoesProprias := AValue;
end;

function TParametrosResultadoStCustoAquisicao.ValorDoIcmsOperacoesProprias: Double;
begin
  Result := FValorDoIcmsOperacoesProprias;
end;

end.
