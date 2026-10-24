unit untCFOPOutrasSaidasParaConserto;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPOutrasSaidasParaConserto = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils, System.StrUtils;

{ TCFOPOutrasSaidasParaConserto }

constructor TCFOPOutrasSaidasParaConserto.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPOutrasSaidasParaConserto.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result.Classificacao := '5' + Copy(Trim(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_SAIDA_PARA_CONSERTO)), 2, 3)
  Else
    Result.Classificacao := '6' + Copy(Trim(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_SAIDA_PARA_CONSERTO)), 2, 3);
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

end.
