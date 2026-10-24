unit untCFOPReposicaoClienteGarantia;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPReposicaoClienteGarantia = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao: TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPReposicaoClienteGarantia }

constructor TCFOPReposicaoClienteGarantia.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPReposicaoClienteGarantia.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    LCfop: String;
begin
  Result := FInputOutputClassificacao;
  If FInputDefine.ReposicaoGarantiaPropriaEmpresa Then
    Result.Classificacao := Result.PrefixoClassificacao + '949'
  Else
  Begin
    LCfop := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIF_REPOSICAO_GARANTIA_CLIENTE);
    Result.Classificacao := Copy(LCfop, 1, 4);
  End;
end;

end.
