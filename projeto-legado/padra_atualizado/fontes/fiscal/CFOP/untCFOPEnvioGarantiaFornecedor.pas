unit untCFOPEnvioGarantiaFornecedor;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPEnvioGarantiaFornecedor = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.StrUtils;

{ TCFOPEnvioGarantiaFornecedor }

constructor TCFOPEnvioGarantiaFornecedor.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPEnvioGarantiaFornecedor.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If FInputDefine.ItemSubstituido Then
    Result.Classificacao := Result.PrefixoClassificacao + RightStr(FInputDefine.ClassificacaoFiscalEnvioGarantiaST, 3)
  Else
    Result.Classificacao := Result.PrefixoClassificacao + RightStr(FInputDefine.ClassificacaoFiscalEnvioGarantia, 3);
end;

end.