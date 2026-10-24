unit untCFOPConfirmacaoAjustes;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes,
  Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa;

type
  TCFOPConfirmacaoAjustes = class(TAbstractClassificacao)
  private
    const
      ENTRADA = 'E';
      SAIDA = 'S';
      VENDA = '1';
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;

    FMensagem: String;
    FAbortarProcedimento: Boolean;

    FGrupo: String;
    FSubGrupo: String;
    FCampo: String;

    function fSQLTransferenciaEstoqueEmpresa: String;
    procedure SetaMensagem(const ACodigoDaEmpresa: String);
    function fClassificacoesDeSaida(AResultadoClassificacaoItemTransferenciaEstoqueEmpresa: IResultadoClassificacaoItemTransferenciaEstoqueEmpresa): String;
    function fClassificacoesDeEntrada(AResultadoClassificacaoItemTransferenciaEstoqueEmpresa: IResultadoClassificacaoItemTransferenciaEstoqueEmpresa): String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

procedure SetObjTransferenciaEstoqueEmpresaDadosDB(AValue: ITransferenciaEstoqueEmpresaDadosDB);

Var
  objTransferenciaEstoqueEmpresa: ITransferenciaEstoqueEmpresaDadosDB;

implementation

uses System.SysUtils, Shared.Functions.Constantes, System.StrUtils;

{ TCFOPConfirmacaoAjustes }

constructor TCFOPConfirmacaoAjustes.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPConfirmacaoAjustes.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    LResultadoClassificacaoItemTransferenciaEstoqueEmpresa: IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := FInputOutputClassificacao;

  LResultadoClassificacaoItemTransferenciaEstoqueEmpresa :=
    objTransferenciaEstoqueEmpresa.TransferenciaEstoqueEmpresa(
      fSQLTransferenciaEstoqueEmpresa, FInputDefine.ClienteCodigo, FInputDefine.CodigoDaEmpresa);

  If LResultadoClassificacaoItemTransferenciaEstoqueEmpresa.RetornouInformacoes Then
  Begin
    If (FInputDefine.EntradaOuSaidaDoItem = SAIDA) Then
    Begin
      Result.Classificacao := fClassificacoesDeSaida(LResultadoClassificacaoItemTransferenciaEstoqueEmpresa);
    End
    Else If FInputDefine.EntradaOuSaidaDoItem = ENTRADA Then
    begin
      Result.Classificacao := fClassificacoesDeEntrada(LResultadoClassificacaoItemTransferenciaEstoqueEmpresa);
    End;

    If (Result.Classificacao = EmptyStr) Then
    Begin
      SetaMensagem(LResultadoClassificacaoItemTransferenciaEstoqueEmpresa.CodigoDaEmpresa);
      FAbortarProcedimento := True;
    End;
  End
  Else
  Begin
    Result.Classificacao := EmptyStr;

    If (Not ((FInputDefine.ClienteFilial) And (FInputDefine.RetornaClienteFilial <> FInputDefine.ClienteCodigo) And (FInputDefine.EntradaOuSaidaDoItem = 'S'))) Then
    Begin
      If (FInputDefine.EntradaOuSaidaDoItem = 'E') Then
      Begin
        If (FInputDefine.DentroDoEstadoCFOP) Then
          Result.Classificacao := '1' + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_ENTRADA)
        Else
          Result.Classificacao := '2' + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_ENTRADA);
      End
      Else
      Begin
        If (FInputDefine.DentroDoEstadoCFOP) Then
          Result.Classificacao := '5' + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_SAIDA)
        Else
          Result.Classificacao := '6' + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_SAIDA);
      End;
    End;
  End;
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
  Result.MensagemRetorno := FMensagem;
  Result.AbortarProcedimento := FAbortarProcedimento;
end;

function TCFOPConfirmacaoAjustes.fClassificacoesDeEntrada(
  AResultadoClassificacaoItemTransferenciaEstoqueEmpresa: IResultadoClassificacaoItemTransferenciaEstoqueEmpresa): String;
begin
  FGrupo := 'Classificações de Entrada';

  If (AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.TipoDeOperacao = VENDA) Then
  begin
    FSubGrupo := 'Classificações de Compra';
    If (Pos(FInputDefine.SituacaoTributaria, objConstantes.fGetCstSubstituicao) > 0) Then
    Begin
      FCampo := 'Subst. Demais Produtos';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeCompraSubstDemaisProdutosEntrada;
    End
    Else
    Begin
      FCampo := 'Tributado';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeCompraTributadoEntrada;
    End;
  End
  Else
  begin
    FSubGrupo := 'Classificações de Transferência';
    If (Pos(FInputDefine.SituacaoTributaria, objConstantes.fGetCstSubstituicao) > 0) Then
    Begin
      FCampo := 'Subst. Demais Produtos';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada;
    End
    Else
    Begin
      FCampo := 'Tributado';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaTributadoEntrada;
    End;
  End;
end;

function TCFOPConfirmacaoAjustes.fClassificacoesDeSaida(
  AResultadoClassificacaoItemTransferenciaEstoqueEmpresa: IResultadoClassificacaoItemTransferenciaEstoqueEmpresa): String;
begin
  FGrupo := 'Classificações de Saída';

  If (AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.TipoDeOperacao = VENDA) Then
  begin
    FSubGrupo := 'Classificações de Venda';
    If (Not FInputDefine.ItemSubstituido) Then
    Begin
      FCampo := 'Tributado';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaTributadoSaida;
    End
    Else If FInputDefine.CombustivelLubrificanteDoItem Then
    Begin
      FCampo := 'Subst. Comb./Lubrificante';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstCombLubrificanteSaida;
    End
    Else If FInputDefine.ImportacaoDiretaDoItem Then
    Begin
      FCampo := 'Subst. Imp. Direta';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstImpDiretaSaida;
    End
    Else
    Begin
      FCampo := 'Subst. Demais Produtos';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstDemaisProdutosSaida;
    End;
  end
  Else
  begin
    FSubGrupo := 'Classificações de Transferência';
    If (Not FInputDefine.ItemSubstituido) Then
    Begin
      FCampo := 'Tributado';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaTributadoSaida;
    End
    Else If FInputDefine.CombustivelLubrificanteDoItem Then
    Begin
      FCampo := 'Subst. Comb./Lubrificante';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstCombLubrificanteSaida;
    End
    Else
    Begin
      FCampo := 'Subst. Demais Produtos';
      Result := AResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstDemaisProdutosSaida;
    End;
  End;
end;

function TCFOPConfirmacaoAjustes.fSQLTransferenciaEstoqueEmpresa: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  EMP_CODEMP, ';
  Result := Result + '  EMP_FORFIL, ';
  Result := Result + '  EMP_CLAT01, ';
  Result := Result + '  EMP_CLAT02, ';
  Result := Result + '  EMP_CLAT03, ';
  Result := Result + '  EMP_CLAT04, ';
  Result := Result + '  EMP_CLATT1, ';
  Result := Result + '  EMP_CLATT2, ';
  Result := Result + '  EMP_CLATT3, ';
  Result := Result + '  EMP_CLTEV2, ';
  Result := Result + '  EMP_CLTEV1, ';
  Result := Result + '  EMP_CLATE2, ';
  Result := Result + '  EMP_CLATE1, ';
  Result := Result + '  IFNULL(FIN_GRVCTR, "S") AS FIN_GRVCTR, ';
  Result := Result + '  (SELECT CON_TIPOPE FROM CONEMP  ';
  Result := Result + '  WHERE CON_EMPORI = :CODEMP AND CON_EMPDES = EMP_CODEMP) AS TIPOPE ';
  Result := Result + 'FROM  ';
  Result := Result + '  CADEMP ';
  Result := Result + '  LEFT JOIN FINEMP ON FIN_EMPDES = EMP_CODEMP AND ';
  Result := Result + '                      FIN_EMPORI = :CODEMP        ';
  Result := Result + 'WHERE EMP_CODEMP <> :CODEMP ';
  Result := Result + 'AND   EMP_CLIFIL  = :CODCLI ';
end;

procedure TCFOPConfirmacaoAjustes.SetaMensagem(const ACodigoDaEmpresa: String);
begin
  FMensagem := 'A CFOP para emissão da nota está vazia. ' +
               'Antes de continuar, acesse o cadastro da empresa ' + ACodigoDaEmpresa + ', ' +
               'aba "Configuração de Transf. de Estoque" e informe a ' + 'CFOP no campo: "' + FGrupo + '" - "' + FSubGrupo +
               '" - "' + FCampo + '".';
end;

procedure SetObjTransferenciaEstoqueEmpresaDadosDB(AValue: ITransferenciaEstoqueEmpresaDadosDB);
Begin
  objTransferenciaEstoqueEmpresa := AValue;
End;

initialization
  objTransferenciaEstoqueEmpresa := Nil;

end.
