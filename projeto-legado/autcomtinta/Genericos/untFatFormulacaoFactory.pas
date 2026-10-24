unit untFatFormulacaoFactory;

interface

uses
   untIFatFormulacao, StrUtils;

type
  TFatFormulacaoFactory = class(TInterfacedObject)
  public
    class function GetIFatFormulacao(const strIdePro: string): IFatFormulacao;
  end;

implementation

uses
  untGenericFatFormulacao;

{ TFatFormulacaoFactory }

class function TFatFormulacaoFactory.GetIFatFormulacao(const strIdePro: string): IFatFormulacao;
begin
  Result := nil;

  if MatchText(strIdePro, ['VEL', 'BZC', 'SAY', 'HYD', 'INT', 'CAL']) then
    Result := TGenericFatFormulacao.Create(strIdePro);
end;

end.
