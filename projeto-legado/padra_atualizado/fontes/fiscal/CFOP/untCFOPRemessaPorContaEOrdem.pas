unit untCFOPRemessaPorContaEOrdem;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPRemessaPorContaEOrdem = class(TAbstractClassificacao)
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

{ TCFOPRemessaPorContaEOrdem }

constructor TCFOPRemessaPorContaEOrdem.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPRemessaPorContaEOrdem.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_NOTA_REMESSA_CONTRA_ORDEM) = EmptyStr) Then
    Result.Classificacao := Result.PrefixoClassificacao + '923'
  Else
    Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_NOTA_REMESSA_CONTRA_ORDEM);
end;

end.
