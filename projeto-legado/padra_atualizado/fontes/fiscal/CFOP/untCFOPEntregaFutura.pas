unit untCFOPEntregaFutura;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPEntregaFutura = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Constantes, System.StrUtils;

{ TCFOPEntregaFutura }

constructor TCFOPEntregaFutura.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPEntregaFutura.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If (FInputDefine.ClienteEstado = CLIENTE_EXTERIOR) Then
    Result.ClassificacaoDeServico := '7922';
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result.Classificacao := '5922'
  Else
    Result.Classificacao := '6922';
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

end.