unit untCFOPEnvioRemessa;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPEnvioRemessa = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPEnvioRemessa }

constructor TCFOPEnvioRemessa.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPEnvioRemessa.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If FInputDefine.ItemSubstituido Then
    Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CFOP_REMESSA_SAIDA_SUBSTITUIDO)
  Else
    Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CFOP_REMESSA_SAIDA_DEMAIS);
end;

end.
