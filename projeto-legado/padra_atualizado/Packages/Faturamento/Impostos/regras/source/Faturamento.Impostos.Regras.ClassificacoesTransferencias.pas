unit Faturamento.Impostos.Regras.ClassificacoesTransferencias;

interface

uses Faturamento.Impostos.Interfaces.ClassificacoesTransferencias,
  Faturamento.Impostos.Tipos.ClassificacoesTransferencias,
  Shared.Functions.Configuracoes, Shared.Functions.Constantes;

type
  TRegraImpostosClassificacoesTransferencias = class(TInterfacedObject, IRegraImpostosClassificacoesTransferencias)
  private
    const
      TRANSFERENCIA_DEPOSITO_FECHADO : String = '3';
  private
    function fResultadoSemTipoDeOperacao: IResultadoRegraClassificacoesTransferencias;
    function fResultadoTipoOperacaoVenda(AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias;
    function fResultadoTipoOperacaoTransferencia(AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias;
  public
    function ClassificacoesTransferenciasRegra(AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias; overload;
    function ClassificacoesTransferenciasSQL: String; overload;

    class function New(): IRegraImpostosClassificacoesTransferencias;
  end;

  function ClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias; StdCall;

implementation

function ClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias; StdCall;
begin
  Result := TRegraImpostosClassificacoesTransferencias.New();
end;

{ TRegraImpostosClassificacoesTransferencias }

function TRegraImpostosClassificacoesTransferencias.ClassificacoesTransferenciasRegra(
  AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias;
begin
  If (Pos(AParametros.TipoDeOperacao, CONEMP_TIPO_OPERACAO_VENDA_TRANSFERENCIA) <= 0) And
     (AParametros.CodigoDaEmpresaTE <> AParametros.CodigoDaEmpresaOrigemTE) Then
  Begin
    Result := fResultadoSemTipoDeOperacao;
    Exit;
  End;

  If (AParametros.TipoDeOperacao = CONEMP_TIPO_OPERACAO_VENDA) Or
     (AParametros.CodigoDaEmpresaTE = AParametros.CodigoDaEmpresaOrigemTE) Then
  Begin
    Result := fResultadoTipoOperacaoVenda(AParametros);
    Exit;
  End;

  Result := fResultadoTipoOperacaoTransferencia(AParametros);
end;

function TRegraImpostosClassificacoesTransferencias.ClassificacoesTransferenciasSQL: String;
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
  Result := Result + '  EMP_CSTT01, ';
  Result := Result + '  EMP_CSTT02, ';
  Result := Result + '  EMP_CSTT03, ';
  Result := Result + '  EMP_CSTTT1, ';
  Result := Result + '  EMP_CSTTT2, ';
  Result := Result + '  EMP_CSTTT3, ';
  Result := Result + '  EMP_CSTDFT, ';
  Result := Result + '  EMP_CSTDFC, ';
  Result := Result + '  EMP_CSTDFS, ';
  Result := Result + '  EMP_CLATI1, ';
  Result := Result + '  EMP_CLATI2, ';
  Result := Result + '  EMP_CLATI3, ';
  Result := Result + '  EMP_CLTDFT, ';
  Result := Result + '  EMP_CLTDFC, ';
  Result := Result + '  EMP_CLTDFS, ';
  Result := Result + '  EMP_CLTTI1, ';
  Result := Result + '  EMP_CLTTI2, ';
  Result := Result + '  EMP_CLTTI3, ';
  Result := Result + '  IFNULL(FIN_GRVCTR, "N") AS FIN_GRVCTR, ';
  Result := Result + '  (SELECT CON_TIPOPE FROM CONEMP                                      ';
  Result := Result + '   WHERE CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :EMPDES) AS TIPOPE, ';
  Result := Result + '  (SELECT CON_PERTRA FROM CONEMP                                      ';
  Result := Result + '   WHERE CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :EMPDES) AS PERTRA  ';
  Result := Result + 'FROM ';
  Result := Result + '  CADEMP ';
  Result := Result + 'LEFT JOIN FINEMP ON FIN_EMPDES = :EMPDES ';
  Result := Result + '                AND FIN_EMPORI = EMP_CODEMP ';
  Result := Result + 'WHERE ';
  Result := Result + '  EMP_CODEMP = :CODEMP ';
end;

function TRegraImpostosClassificacoesTransferencias.fResultadoSemTipoDeOperacao: IResultadoRegraClassificacoesTransferencias;
begin
  Result :=
    TResultadoRegraClassificacoesTransferencias.New()
      .TipoDeEmissaoTE('')

      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado('')
      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante('')
      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos('')

      .TransfDeEstoqueClassifVendaOuTransferenciaTributado('')
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante('')
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos('')

      .TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado('')
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante('')
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos('')

      .TransfDeEstoqueCSTDeVendaOuTransferenciaTributado('')
      .TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante('')
      .TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos('')
      .TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado('')
      .TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante('')
      .TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos('')

      .TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta('');
end;

function TRegraImpostosClassificacoesTransferencias.fResultadoTipoOperacaoTransferencia(
  AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias;
var
  LTransfDeEstoqueCSTDeTransferenciaTributado: String;
  LTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante: String;
  LTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos: String;

  LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado: String;
  LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante: String;
  LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos: String;
begin
  LTransfDeEstoqueCSTDeTransferenciaTributado := '';
  LTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante := '';
  LTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos := '';

  LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado := '';
  LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante := '';
  LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos := '';

  If (AParametros.CstTransfEstoqueEmpresa) Then
  Begin
    If AParametros.TipoDeOperacao = TRANSFERENCIA_DEPOSITO_FECHADO Then
    Begin
      LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado := AParametros.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado;
      LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante := AParametros.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante;
      LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos := AParametros.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos;
    End
    Else
    Begin
      LTransfDeEstoqueCSTDeTransferenciaTributado := AParametros.TransfDeEstoqueCSTDeTransferenciaTributado;
      LTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante := AParametros.TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante;
      LTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos := AParametros.TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos;
    End;
  End;

  Result :=
    TResultadoRegraClassificacoesTransferencias.New()
      .TipoDeEmissaoTE(TIPO_EMISSAO_TE_TRANSFERENCIA)

      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado(AParametros.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado)
      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(AParametros.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante)
      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(AParametros.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos)

      .TransfDeEstoqueClassifVendaOuTransferenciaTributado(AParametros.TransfDeEstoqueClassifTransferenciaTributado)
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante(AParametros.TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante)
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos(AParametros.TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos)
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(AParametros.TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado)
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(AParametros.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante)
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(AParametros.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos)
      .TransfDeEstoqueCSTDeVendaOuTransferenciaTributado(LTransfDeEstoqueCSTDeTransferenciaTributado)
      .TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(LTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante)
      .TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos(LTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos)
      .TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado(LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado)
      .TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante)
      .TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos(LTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos);
end;

function TRegraImpostosClassificacoesTransferencias.fResultadoTipoOperacaoVenda(
  AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias;
var
  LTransfDeEstoqueCSTDeVendaTributado: String;
  LTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante: String;
  LTransfDeEstoqueCSTDeVendaSubstDemaisProdutos: String;
begin
  LTransfDeEstoqueCSTDeVendaTributado := '';
  LTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante := '';
  LTransfDeEstoqueCSTDeVendaSubstDemaisProdutos := '';

  If (AParametros.CstTransfEstoqueEmpresa) Then
  Begin
    LTransfDeEstoqueCSTDeVendaTributado := AParametros.TransfDeEstoqueCSTDeVendaTributado;
    LTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante := AParametros.TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante;
    LTransfDeEstoqueCSTDeVendaSubstDemaisProdutos := AParametros.TransfDeEstoqueCSTDeVendaSubstDemaisProdutos;
  End;

  Result :=
    TResultadoRegraClassificacoesTransferencias.New()
      .TipoDeEmissaoTE(TIPO_EMISSAO_TE_VENDA)

      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado(AParametros.TransfDeEstoqueClassifIndustrializacaoTributado)
      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(AParametros.TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante)
      .TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(AParametros.TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos)

      .TransfDeEstoqueClassifVendaOuTransferenciaTributado(AParametros.TransfDeEstoqueClassifVendaTributado)
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante(AParametros.TransfDeEstoqueClassifVendaSubstCombustivelLubrificante)
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos(AParametros.TransfDeEstoqueClassifVendaSubstDemaisProdutos)
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(AParametros.TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado)
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(AParametros.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante)
      .TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(AParametros.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos)
      .TransfDeEstoqueCSTDeVendaOuTransferenciaTributado(LTransfDeEstoqueCSTDeVendaTributado)
      .TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(LTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante)
      .TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos(LTransfDeEstoqueCSTDeVendaSubstDemaisProdutos)
      .TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta(AParametros.TransfDeEstoqueClassifVendaSubstImpDireta);
end;

class function TRegraImpostosClassificacoesTransferencias.New: IRegraImpostosClassificacoesTransferencias;
begin
  Result := Self.Create;
end;

exports ClassificacoesTransferencias;

end.
