unit untCFOPRetornoConsignacao;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPRetornoConsignacao = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function PreClassificacaoDoItem: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils;

{ TCFOPRetornoConsignacao }

constructor TCFOPRetornoConsignacao.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPRetornoConsignacao.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.PrefixoClassificacao := PreClassificacaoDoItem;
  Result.Classificacao := Result.PrefixoClassificacao + Copy(Trim(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO, varString)), 2, 3);
end;

function TCFOPRetornoConsignacao.PreClassificacaoDoItem: String;
begin
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result := '1'
  Else
    Result := '2';
end;

end.
