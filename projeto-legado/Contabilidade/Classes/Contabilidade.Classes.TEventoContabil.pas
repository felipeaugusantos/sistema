unit Contabilidade.Classes.TEventoContabil;

interface

uses Contabilidade.Interfaces ;

type
  TEventoContabilDefault = class(TInterfacedObject, IEventoContabil)
  private
    FstrCodigoEvento: String ;
  public
    function fConsultaEvento(const AstrCentroCustoDefault: String): String ;
    constructor Create(const AstrCodigoEvento: String); reintroduce;
  end ;

  TEventoContabilPorClaDev = class(TInterfacedObject, IEventoContabil)
  private
    FstrCodigoEvento: String ;
    FstrCfop: String ;
  public
    function fConsultaEvento(const AstrCentroCustoDefault: String): String ;
    constructor Create(const AstrCodigoEvento, AstrCfop: String); reintroduce;
  end ;

  TEventoContabilSaidas = class(TInterfacedObject, IEventoContabil)
  private
    FstrCodigoEvento: String ;
  public
    function fConsultaEvento(const AstrCentroCustoDefault: String): String ;
    constructor Create(const AstrCodigoEvento: string); reintroduce;
  end ;

  TEventoContabilDescontoJurosCtpCtr = class(TInterfacedObject, IEventoContabil)
  private
    FstrCodigoEvento: String ;
  public
    function fConsultaEvento(const AstrCentroCustoDefault: String): String ;
    constructor Create(const AstrCodigoEvento: String); reintroduce;
  end ;

  TFactoryEventoContabil = class(TInterfacedObject, IFactoryMethodEventoContabil)
  public
    function fConfiguraEvento(const AstrCodigoEvento: String;
                              const AstrTipoLancamento: string = '';
                              const AstrCfop: string = '';
                              const AstrDescricaoValor: string = ''): IEventoContabil ;
    class function New(): IFactoryMethodEventoContabil;
  end ;

implementation

uses untFuncoesSimples, Contabilidade.Funcoes, strUtils ;

{ TEventoContabilDefault }

constructor TEventoContabilDefault.Create(const AstrCodigoEvento: String);
begin
  FstrCodigoEvento := AstrCodigoEvento ;
end;

function TEventoContabilDefault.fConsultaEvento(const AstrCentroCustoDefault: String): String;
begin
  Result := FstrCodigoEvento ;
end;

{ TEventoContabilPorClaDev }

constructor TEventoContabilPorClaDev.Create(const AstrCodigoEvento, AstrCfop: String);
begin
  FstrCodigoEvento := AstrCodigoEvento ;
  FstrCfop := AstrCfop ;
end;

function TEventoContabilPorClaDev.fConsultaEvento(const AstrCentroCustoDefault: String): String;
begin
  if Pos(FstrCfop,VS_strClaDev) > 0 then
    Result := fAjustaCentroCustoCntDespRecCus(FstrCodigoEvento, AstrCentroCustoDefault)
  else
    Result := FstrCodigoEvento ;
end;

{ TEventoContabilSaidas }

constructor TEventoContabilSaidas.Create(const AstrCodigoEvento: string);
begin
  FstrCodigoEvento := AstrCodigoEvento ;
end;

function TEventoContabilSaidas.fConsultaEvento(const AstrCentroCustoDefault: String): String;
begin
  Result := fAjustaCentroCustoCntDespRecCus(FstrCodigoEvento, AstrCentroCustoDefault) ;
end;

{ TEventoContabilDescontoJurosCtpCtr }

constructor TEventoContabilDescontoJurosCtpCtr.Create(const AstrCodigoEvento: string);
begin
  FstrCodigoEvento := AstrCodigoEvento ;
end;

function TEventoContabilDescontoJurosCtpCtr.fConsultaEvento(const AstrCentroCustoDefault: String): String;
begin
  Result := fAjustaCentroCustoCntDespRecCus(FstrCodigoEvento, AstrCentroCustoDefault) ;
end;

{ TFactoryEventoContabil }

function TFactoryEventoContabil.fConfiguraEvento(const AstrCodigoEvento,
  AstrTipoLancamento, AstrCfop, AstrDescricaoValor: string): IEventoContabil;
begin
  if AstrTipoLancamento = 'SAI' then
    result := TEventoContabilSaidas.Create(AstrCodigoEvento)
  else if AstrTipoLancamento = 'ENT' then
    result := TEventoContabilPorClaDev.Create(AstrCodigoEvento, AstrCfop)
  else if MatchStr(AstrTipoLancamento, ['CTR', 'CTP']) and MatchStr(AstrDescricaoValor, [DES_VALOR_JUROS, DES_VALOR_DESCONTO]) then
    result := TEventoContabilDescontoJurosCtpCtr.Create(AstrCodigoEvento)
  else
    result := TEventoContabilDefault.Create(AstrCodigoEvento) ;
end;

class function TFactoryEventoContabil.New: IFactoryMethodEventoContabil;
begin
  Result := Self.Create ;
end;

end.
