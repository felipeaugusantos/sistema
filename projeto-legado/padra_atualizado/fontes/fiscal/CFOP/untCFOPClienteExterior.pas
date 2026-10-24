unit untCFOPClienteExterior;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPClienteExterior = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Funcoes.Faturamento, System.StrUtils;

{ TCFOPClienteExterior }

constructor TCFOPClienteExterior.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPClienteExterior.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If TFunctionFuncoesFaturamento.EhDevolucaoOuOutrasEntradas(FInputDefine.OpcaoDeDocumento, FInputDefine.EntradaOuSaidaDoItem) Then
  Begin
    If (FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varString) = 'S') Then
      Result.Classificacao := '3201'
    Else
      Result.Classificacao := '3202';
  End
  Else
  Begin
    If (FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varString) = 'S') And (FInputDefine.IndustrializacaoOuRevenda = 'I') Then
      Result.Classificacao := '7101'
    Else
      Result.Classificacao := '7102';
  End;

  If FInputDefine.ItemDrawback Then
  Begin
    Result.Classificacao := '7127';
  End;

  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

end.
