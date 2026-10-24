unit untCFOPNotaEspecialVendaABaseDeTroca;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPNotaEspecialVendaABaseDeTroca = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    function GetPrefixo: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPNotaEspecialVendaABaseDeTroca }

constructor TCFOPNotaEspecialVendaABaseDeTroca.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPNotaEspecialVendaABaseDeTroca.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    LPrefixo : String;
begin
  Result := FInputOutputClassificacao;
  LPrefixo := GetPrefixo;
  Result.Classificacao := LPrefixo + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA);
  Result.PrefixoClassificacao := LPrefixo;
end;

function TCFOPNotaEspecialVendaABaseDeTroca.GetPrefixo: String;
begin
  Result := '2';
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result := '1';
end;

end.
