unit untCFOPDevolucaoOuOutrasEntradas;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPDevolucaoOuOutrasEntradas = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function fEhDevolucaoDeCombustivel: Boolean;
    function RetPreClassificacaoDoItem: String;
    function RetPreClassificacaofSubstituido: String;
    function RetPreClassificacaoTributada: String;
    function RetPreClassificacaoBrinde: String;
    function RetPreClassificacaoCombustivel(AClassificacao: String): String;
    function PreClassificacaoDoItem: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.StrUtils, System.SysUtils, Shared.Functions.Funcoes.Faturamento;

{ TCFOPDevolucaoOuOutrasEntradas }

constructor TCFOPDevolucaoOuOutrasEntradas.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPDevolucaoOuOutrasEntradas.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    strClaFisAux : String;
begin
  Result := FInputOutputClassificacao;

  Result.Classificacao := RetPreClassificacaoDoItem;

  If (FInputDefine.EntregaFuturaDoItem) And (Not FConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean)) Then
    Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + '922';

  If (FInputDefine.EhEspelhoDevolucaoClienteGarantia) and (FInputDefine.ClassificacaoDoItem <> '') Then
    Result.Classificacao := FInputDefine.ClassificacaoDoItem
  Else
  Begin
    strClaFisAux := RightStr(FConfiguracoes.fGetValorConfiguracao(CFG_RECEBIMENTO_GARANTIA_CLIENTE, varString), 3);

    If (FInputDefine.EhEspelhoDevolucaoClienteGarantia) And (Length(strClaFisAux) = 3) Then
      Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + strClaFisAux
  End;

  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

function TCFOPDevolucaoOuOutrasEntradas.fEhDevolucaoDeCombustivel: Boolean;
begin
  Result := False;

  If not (FInputDefine.OpcaoDeDocumento = 'DV') Then
    Exit;

  If not FInputDefine.CombustivelLubrificanteDoItem Then
    Exit;

  Result := True;
end;

function TCFOPDevolucaoOuOutrasEntradas.RetPreClassificacaoDoItem: String;
begin
  If FInputDefine.EhOperacaoDeVendaInternaDeProdutosDoDecretoDoCeara Then
    Result := RetPreClassificacaofSubstituido
  Else If (FInputDefine.ItemSubstituido) Then
    Result := RetPreClassificacaofSubstituido
  Else
    Result := RetPreClassificacaoTributada;

  If (RetPreClassificacaoBrinde <> '') Then
    Result := RetPreClassificacaoBrinde;

  If fEhDevolucaoDeCombustivel Then
    Result := RetPreClassificacaoCombustivel(Result);
end;

function TCFOPDevolucaoOuOutrasEntradas.RetPreClassificacaofSubstituido: String;
begin
  If TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda) Then
    Result := PreClassificacaoDoItem + '410'
  Else
    Result := PreClassificacaoDoItem + '411';
end;

function TCFOPDevolucaoOuOutrasEntradas.RetPreClassificacaoTributada: String;
begin
  If TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda) Then
    Result := PreClassificacaoDoItem + '201'
  Else
    Result := PreClassificacaoDoItem + '202';
end;

function TCFOPDevolucaoOuOutrasEntradas.RetPreClassificacaoBrinde: String;
begin
  Result := '';
  If (FInputDefine.ItemBrinde) Then
  Begin
    If (Pos(FInputDefine.OpcaoDeDocumento, 'DV_PR_') > 0) Then
      Result := PreClassificacaoDoItem + '949';
  End;
end;

function TCFOPDevolucaoOuOutrasEntradas.RetPreClassificacaoCombustivel(AClassificacao: String): String;
begin
  Result := AClassificacao;

  If not (FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_FISCAL_PARA_DEVOLUCAO_COMBUSTIVEL) = EmptyStr) Then
    Result := PreClassificacaoDoItem + FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_FISCAL_PARA_DEVOLUCAO_COMBUSTIVEL);

end;

function TCFOPDevolucaoOuOutrasEntradas.PreClassificacaoDoItem: String;
begin
  Result := '2';
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result := '1';
end;

end.
