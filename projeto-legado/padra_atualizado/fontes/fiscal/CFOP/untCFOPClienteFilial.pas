unit untCFOPClienteFilial;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPClienteFilial = class(TAbstractClassificacao)
  private
    const
      INDUSTRIALIZACAO : String = 'I';
      TRANSFERENCIA_DEPOSITO_FECHADO : String = '3';
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function CodigoDaSituacaoTributariaDoItem: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.StrUtils, System.SysUtils;

{ TCFOPClienteFilial }

constructor TCFOPClienteFilial.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPClienteFilial.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.SituacaoTributaria := CodigoDaSituacaoTributariaDoItem;

  If (FInputDefine.ConfirmacaoDevolucaoRegimeEspecial) Then
  Begin
    If (FInputDefine.ItemSubstituido) Then
      Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + '411'
    Else
      Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + '202';
  End
  Else If (FInputDefine.CombustivelLubrificanteDoItem) Then
  Begin
    Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia, 3);

    If FInputDefine.TipoDeOperacaoTE = TRANSFERENCIA_DEPOSITO_FECHADO Then
      Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeTransferenciaDepositoFechadoCombustivelELubrificanteTransferencia, 3)
    Else If FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
      If (FInputDefine.IndustrializacaoOuRevenda = INDUSTRIALIZACAO) Then
        Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeIndustrializacaoSubstCombustivelELubrificanteTransferencia, 3);
  End
  Else If (Not FInputDefine.ItemSubstituido) Then
  Begin
    Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeVendaTributadoTransferencia, 3);

    If FInputDefine.TipoDeOperacaoTE = TRANSFERENCIA_DEPOSITO_FECHADO Then
      Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeTransferenciaDepositoFechadoTributado, 3)
    Else If FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
      If (FInputDefine.IndustrializacaoOuRevenda = INDUSTRIALIZACAO) Then
        Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeIndustrializacaoTributadoTransferencia, 3);
  End
  Else If (FInputDefine.ImportacaoDiretaDoItem) And (FInputDefine.TipoDeOperacaoDoPedidoDeVenda = 'V') And (FInputDefine.TipoDeEmissaoTE = 'V') Then
    Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeVendaSubstImportacaoDireta, 3)
  Else
  Begin
    Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia, 3);

    If FInputDefine.TipoDeOperacaoTE = TRANSFERENCIA_DEPOSITO_FECHADO Then
      Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeTransferenciaDepositoFechadoDemaisProdutosTransferencia, 3)
    Else If FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
      If (FInputDefine.IndustrializacaoOuRevenda = INDUSTRIALIZACAO) Then
        Result.Classificacao := LeftStr(FInputDefine.ClassificacaoFiscalDoItem, 1) + RightStr(FInputDefine.ClassificacaoDeIndustrializacaoSubstDemaisProdutosTransferencia, 3);
  End;

  If (SameText(Result.Classificacao, '6405')) Then
  Begin
    If (FInputDefine.ClienteConsumidorFinal) Then
      Result.Classificacao := '6404'
    Else
      Result.Classificacao := '6403';
  End;

  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

function TCFOPClienteFilial.CodigoDaSituacaoTributariaDoItem: String;
begin
  Result := FInputDefine.SituacaoTributaria;

  If FInputDefine.TipoDeOperacaoTE = TRANSFERENCIA_DEPOSITO_FECHADO Then
  Begin
    If (Not FInputDefine.ItemSubstituido) Then
    Begin
      If (Not (FInputDefine.CSTDeVendaTributadoTransferenciaDepositoFechado = EmptyStr)) And (Length(FInputDefine.CSTDeVendaTributadoTransferenciaDepositoFechado) = 2) And (Not (Result = EmptyStr)) Then
        Result := LeftStr(Result, 1) + FInputDefine.CSTDeVendaTributadoTransferenciaDepositoFechado;
    End
    Else If (FInputDefine.CombustivelLubrificanteDoItem) Then
    Begin
      If (Not (FInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferenciaDepositoFechado = EmptyStr)) And (Length(FInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferenciaDepositoFechado) = 2) And (Not (Result = EmptyStr)) Then
        Result := LeftStr(Result, 1) + FInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferenciaDepositoFechado;
    End
    Else
    Begin
      If (Not (FInputDefine.CSTDeVendaSubstDemaisTransferenciaDepositoFechado = EmptyStr)) And (Length(FInputDefine.CSTDeVendaSubstDemaisTransferenciaDepositoFechado) = 2) And (Not (Result = EmptyStr)) Then
        Result := LeftStr(Result, 1) + FInputDefine.CSTDeVendaSubstDemaisTransferenciaDepositoFechado;
    End;
  End
  else
  Begin
    If (Not FInputDefine.ItemSubstituido) Then
    Begin
      If (Not (FInputDefine.CSTDeVendaTributadoTransferencia = EmptyStr)) And (Length(FInputDefine.CSTDeVendaTributadoTransferencia) = 2) And (Not (Result = EmptyStr)) Then
        Result := LeftStr(Result, 1) + FInputDefine.CSTDeVendaTributadoTransferencia;
    End
    Else If (FInputDefine.CombustivelLubrificanteDoItem) Then
    Begin
      If (Not (FInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferencia = EmptyStr)) And (Length(FInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferencia) = 2) And (Not (Result = EmptyStr)) Then
        Result := LeftStr(Result, 1) + FInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferencia;
    End
    Else
    Begin
      If (Not (FInputDefine.CSTDeVendaSubstDemaisTransferencia = EmptyStr)) And (Length(FInputDefine.CSTDeVendaSubstDemaisTransferencia) = 2) And (Not (Result = EmptyStr)) Then
        Result := LeftStr(Result, 1) + FInputDefine.CSTDeVendaSubstDemaisTransferencia;
    End;
  End;
end;

end.
