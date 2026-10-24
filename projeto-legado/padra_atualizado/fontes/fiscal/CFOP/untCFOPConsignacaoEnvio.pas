unit untCFOPConsignacaoEnvio;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPConsignacaoEnvio = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils;

{ TCFOPConsignacaoEnvio }

constructor TCFOPConsignacaoEnvio.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPConsignacaoEnvio.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := Result.PrefixoClassificacao + Copy(Trim(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_ENVIO_MERCADORIA_CONSIGNACAO)), 2, 3);
end;

end.