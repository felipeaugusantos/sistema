unit untCFOPBaixaEntregaFutura;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPBaixaEntregaFutura = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function BaixandoEntregaFuturaEmitindoEntradaEstoqueItemEstrutura : Boolean;
    function MantemClassificacaoFiscal: Boolean;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils, System.StrUtils, Shared.Functions.Constantes;

{ TCFOPBaixaEntregaFutura }

constructor TCFOPBaixaEntregaFutura.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPBaixaEntregaFutura.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    LCfgClaFis : String;
begin
  Result := FInputOutputClassificacao;
  Result.ClassificacaoDeServico := EmptyStr;

  If MantemClassificacaoFiscal Then
  Begin
    If Not FInputDefine.ClassificacaoDoItem.IsEmpty Then
    Begin
      Result.Classificacao := FInputDefine.ClassificacaoDoItem;
      Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
      Exit;
    End;
  End;

  If (FInputDefine.IndustrializacaoOuRevenda = 'R') Or (FInputDefine.IndustrializacaoOuRevenda = EmptyStr) Then
    LCfgClaFis := CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_REVENDA
  Else If (FInputDefine.IndustrializacaoOuRevenda = 'I') Then
    LCfgClaFis := CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_INDUSTRIALIZACAO;

  If (FInputDefine.DentroDoEstadoCFOP Or FInputDefine.VendaPresencial) Then
    Result.Classificacao := '5' + FConfiguracoes.fGetValorConfiguracao(LCfgClaFis)
  Else
    Result.Classificacao := '6' + FConfiguracoes.fGetValorConfiguracao(LCfgClaFis);

  If FInputDefine.ClienteEstado = CLIENTE_EXTERIOR Then
    Result.Classificacao := '7117';

  If BaixandoEntregaFuturaEmitindoEntradaEstoqueItemEstrutura Then
    Result.Classificacao := '1999';

  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

function TCFOPBaixaEntregaFutura.BaixandoEntregaFuturaEmitindoEntradaEstoqueItemEstrutura: Boolean;
  Const
    EMITIR_DOCUMENTO_COM_SUBITENS = '2';
    EXIBIR_PRODUTO_ESTRUTURA = '1';
    ENTRADA_ESTOQUE = 'E';
begin
  Result := False;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_BAIXA_ENTREGA_FUTURA_DE_ITEM_ESTRUTURA_EMITIR_DOCUMENTO_COM_ITEM) <> EMITIR_DOCUMENTO_COM_SUBITENS) Then
    Exit;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_BAIXA_ENTREGA_FUTURA_DE_ITEM_ESTRUTURA_EXIBIR_ITEM) <> EXIBIR_PRODUTO_ESTRUTURA) Then
    Exit;

  If (FInputDefine.EntradaOuSaidaDoItem <> ENTRADA_ESTOQUE) Then
    Exit;

  If (Not FInputDefine.ProdutoEmbalagem) Then
    Exit;

  Result := True;
end;

function TCFOPBaixaEntregaFutura.MantemClassificacaoFiscal: Boolean;
begin
  Result := False;

  If Not FConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean) Then
    Exit;

  If FConfiguracoes.fGetValorConfiguracao(CFG_OPC_TIPODOC_BAIXA_ENTREGA_FUTURA) = BFUTTP_EMITIR_FF Then
    Exit;

  Result := True;
end;

end.