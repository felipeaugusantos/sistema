unit untCFOPOrdemDeProducaoAvulsaTintometrico;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPOrdemDeProducaoAvulsaTintometrico = class(TAbstractClassificacao)
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

{ TCFOPOrdemDeProducaoAvulsaTintometrico }

constructor TCFOPOrdemDeProducaoAvulsaTintometrico.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPOrdemDeProducaoAvulsaTintometrico.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If (FInputDefine.TipoDeEmprestimo = 'E') Then
    Result.Classificacao := '1888'
  Else
    Result.Classificacao := '5888';
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

end.
