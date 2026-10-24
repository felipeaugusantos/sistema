unit untCFOPFaturamentoConsignacao;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPFaturamentoConsignacao = class(TAbstractClassificacao)
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

{ TCFOPFaturamentoConsignacao }

constructor TCFOPFaturamentoConsignacao.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPFaturamentoConsignacao.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.PrefixoClassificacao := PreClassificacaoDoItem;
  Result.Classificacao := Result.PrefixoClassificacao + Copy(Trim(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO, varString)), 2, 3);
end;

function TCFOPFaturamentoConsignacao.PreClassificacaoDoItem: String;
begin
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result := '5'
  Else
    Result := '6';
end;

end.
