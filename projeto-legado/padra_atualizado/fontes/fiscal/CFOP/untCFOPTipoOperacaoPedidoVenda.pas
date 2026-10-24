unit untCFOPTipoOperacaoPedidoVenda;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPTipoOperacaoPedidoVenda = class(TAbstractClassificacao)
  private
    const
      BONIFICACAO         = 'B';
      CONTA_E_ORDEM       = 'C';
      DEMONSTRACAO        = 'D';
      REMESSA_CONTA_ORDEM = 'R';
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function RetornaClassificacaoFiscaldeContaOrdem: String;
    function RetornaClassificacaoFiscalDeDemonstracao: String;
    function RetornaClassificacaoFiscalDeRemessaContaOrdem: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPTipoOperacaoPedidoVenda }

constructor TCFOPTipoOperacaoPedidoVenda.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPTipoOperacaoPedidoVenda.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If (FInputDefine.TipoDeOperacaoDoPedidoDeVenda = BONIFICACAO) Then
    Result.Classificacao := Result.PrefixoClassificacao + '910';

  If (FInputDefine.TipoDeOperacaoDoPedidoDeVenda = CONTA_E_ORDEM) Then
    Result.Classificacao := Result.PrefixoClassificacao + RetornaClassificacaoFiscaldeContaOrdem;

  If (FInputDefine.TipoDeOperacaoDoPedidoDeVenda = DEMONSTRACAO) Then
    Result.Classificacao := Result.PrefixoClassificacao + RetornaClassificacaoFiscalDeDemonstracao;

  If (FInputDefine.TipoDeOperacaoDoPedidoDeVenda = REMESSA_CONTA_ORDEM) Then
    Result.Classificacao := Result.PrefixoClassificacao + RetornaClassificacaoFiscalDeRemessaContaOrdem;
end;

function TCFOPTipoOperacaoPedidoVenda.RetornaClassificacaoFiscaldeContaOrdem: String;
  Var
    LClassificacaoFiscalContaOrdem : String;
begin
  LClassificacaoFiscalContaOrdem := FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_CONTA_E_ORDEM, varString);
  If (LClassificacaoFiscalContaOrdem <> '') Then
    Result := LClassificacaoFiscalContaOrdem
  Else
    Result := Copy(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_CONTA_E_ORDEM, varString), 1, 3);
end;

function TCFOPTipoOperacaoPedidoVenda.RetornaClassificacaoFiscalDeDemonstracao: String;
  Var
    LClassificacaoFiscalDemonstracao : String;
begin
  LClassificacaoFiscalDemonstracao := FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_DEMONSTRACAO, varString);
  If (LClassificacaoFiscalDemonstracao <> '') Then
    Result := LClassificacaoFiscalDemonstracao
  Else
    Result := Copy(FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACOES_DE_DEMONSTRACAO, varString), 1, 3);
end;

function TCFOPTipoOperacaoPedidoVenda.RetornaClassificacaoFiscalDeRemessaContaOrdem: String;
  Var
    LClassificacaoFiscalRemessaContaOrdem : String;
begin
  LClassificacaoFiscalRemessaContaOrdem := FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_REMESSA_CONTA_ORDEM, varString);
  If (LClassificacaoFiscalRemessaContaOrdem <> '') Then
    Result := LClassificacaoFiscalRemessaContaOrdem
  Else
    Result := Copy(FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_REMESSA_CONTA_ORDEM, varString), 1, 3);
end;

end.
