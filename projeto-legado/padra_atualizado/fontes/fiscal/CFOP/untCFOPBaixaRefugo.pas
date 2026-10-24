unit untCFOPBaixaRefugo;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPBaixaRefugo = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPBaixaRefugo }

constructor TCFOPBaixaRefugo.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPBaixaRefugo.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_BAIXA_PRODUTOS_REFUGADOS);
end;

end.
