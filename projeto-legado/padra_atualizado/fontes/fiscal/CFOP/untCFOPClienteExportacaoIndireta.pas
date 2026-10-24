unit untCFOPClienteExportacaoIndireta;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPClienteExportacaoIndireta = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Funcoes.Faturamento;

{ TCFOPClienteExportacaoIndireta }

constructor TCFOPClienteExportacaoIndireta.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPClienteExportacaoIndireta.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) And TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda) Then
    Result.Classificacao := Result.PrefixoClassificacao + '501'
  Else
    Result.Classificacao := Result.PrefixoClassificacao + '502';
end;

end.