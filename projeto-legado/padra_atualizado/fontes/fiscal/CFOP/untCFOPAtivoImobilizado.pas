unit untCFOPAtivoImobilizado;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPAtivoImobilizado = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function PrefixoClassificacao: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPAtivoImobilizado }

constructor TCFOPAtivoImobilizado.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPAtivoImobilizado.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.PrefixoClassificacao := PrefixoClassificacao;
  Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_ATIVO_IMOBILIZADO, varString);
end;

function TCFOPAtivoImobilizado.PrefixoClassificacao: String;
begin
  Result := '6';
  If FInputDefine.DentroDoEstadoCFOP Then
    Result := '5';
end;

end.
