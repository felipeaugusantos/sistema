unit untCFOPRetornoRemessa;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPRetornoRemessa = class(TAbstractClassificacao)
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

{ TCFOPRetornoRemessa }

constructor TCFOPRetornoRemessa.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPRetornoRemessa.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.PrefixoClassificacao := PrefixoClassificacao;
  Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CFOP_REMESSA_ENTRADA, varString);
end;

function TCFOPRetornoRemessa.PrefixoClassificacao: String;
begin
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result := '1'
  Else
    Result := '2';
end;

end.
