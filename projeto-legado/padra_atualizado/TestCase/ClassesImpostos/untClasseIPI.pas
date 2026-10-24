unit untClasseIPI;

interface

uses System.SysUtils, System.Variants, Vcl.Dialogs, System.StrUtils,
  untAbstractConsulta, untIConsulta, untAbstractGerarTeste, untIGerarTeste,
  untFuncoes, UniClientDataSet, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Types, Uni, UniDataSetProvider, untICasosTestesLog,
  untCasosTestesLog, untModulo, Faturamento.Impostos.Interfaces.IPI,
  Faturamento.Impostos.Tipos.IPI, untFatCalcularImpostos,
  Shared.Functions.Constantes, Data.DB,
  untCasosTestesLogImpl,
  untFatCalcularImpostosService,
  Faturamento.Impostos.Calculos.TesteUnitarioLog, untParametrosResultadoIpi,
  untParametrosComparacaoIPI, Shared.Functions.Configuracoes, Vcl.Forms, untTypes;

type
  TConsultaIPI = class(TAbstractConsulta)
  private
    function RetornarColunasSQL: string;
    function RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
    function RetornarFiltrosSQL: string;
    function AjustaTabelasDocumentoConfirmacao(
      const ASQLTabelas: string): string;
  public
    Class function New : IConsulta;
    function fRetornarSQLIpi : String; override;
  end;

type
  TGerarTesteIPI = class(TAbstractGerarTeste)
  private
    Function RetornarOpcoesDeItemNotaEspiritoSanto(AClassificacaoFiscal : String) : TOpcItensNFespTinta;
    Procedure pTesteUnitarioLog(LResultadoServicosClasseIPI: IResultadoServicosClasseIPI; ADados: TUniClientDataSet);
    function ValidarSeDeveAdicionarLog(const AResultadoComparacao: TResultadoComparacao; const ADados: TUniClientDataSet; const AValorZeroComDiferencaSomenteNaAliquota: boolean; const AClassificacaoVenda: boolean): boolean;
    function ValidarSeDeveAdicionarLogInterna(const ADados: TUniClientDataSet; const AValorZeroComDiferencaSomenteNaAliquota: boolean; const AClassificacaoVenda: boolean): boolean;
    function ValidarSeDeveAdicionarLogPorOpcaoDeDocumento(const AOpcaoDocumento: string): boolean;
    function ValidarSeDeveAdicionarLogComDiferencaSomenteNaAliquota(const AValorZeroComDiferencaSomenteNaAliquota: boolean): boolean;
    function ValidarValorZeroComDiferencaSomenteNaAliquota(const AResultadoCalculoIPI: IResultadoCalculoIPI; const ADados: TUniClientDataSet; const AFaturamentoAntesExpedicao: Boolean): boolean;
    function RetornarOpcoesDeDocumentoDiferencaAliquota(const AFaturamentoAntesExpedicao: Boolean): String;
    function ValidarOpcaoDocumentoParaConsiderarDiferencaAliquota(
      const AOpcaoDocumento: string; const AFaturamentoAntesExpedicao: Boolean): boolean;
    function ValidarClassificacaoVenda(const AClassificacaoFiscal: string): boolean;
    function ValidarSeDeveAdicionarLogClassificacaoDeNaoVenda(
      const AClassificacaoVenda: boolean;
      const AOpcaoDocumento: string): boolean;
    function ValidarSeDeveAdicionarLogPorEspecieDeDocumento(
      const AEspecieDeDocumento: string): boolean;
  public
    Class function New : IGerarTeste;
    Constructor Create;
    Destructor Destroy; override;
    function fGerarTesteIpi(const ADados: OleVariant) : Boolean; override;
  end;

implementation

{ TConsultaIPI }

function TConsultaIPI.fRetornarSQLIpi: String;
const
  UNION_ALL = ' UNION ALL ';
begin
  result := EmptyStr;
  Result := result + RetornarColunasSQL;
  Result := result + RetornarTabelasSQL(False);
  Result := result + RetornarFiltrosSQL;
  Result := result + UNION_ALL;
  Result := result + RetornarColunasSQL;
  Result := result + RetornarTabelasSQL(True);
  Result := result + RetornarFiltrosSQL;
end;

class function TConsultaIPI.New: IConsulta;
begin
  Result := Self.Create;
end;

{ TGerarTesteIPI }

constructor TGerarTesteIPI.Create;
begin

end;

destructor TGerarTesteIPI.Destroy;
begin

  inherited;
end;


function TGerarTesteIPI.fGerarTesteIpi(const ADados: OleVariant): Boolean;
Var
  LDados                     : TUniClientDataSet;
  LCasosTestesLog            : ICasosTestesLog;
  LResultadoCalculoIPI       : IResultadoCalculoIPI;
  LResultadoComparacao       : TResultadoComparacao;
  FParametrosIpi             : IParametrosServicoIPI;
  LResultadoServicosClasseIPI: IResultadoServicosClasseIPI;
  LNotaEEspecialFornecedor   : Boolean;
  LValorZeroComDiferencaSomenteNaAliquota: boolean;
  LFaturamentoAntesExpedicao: Boolean;
  LClassificacaoVenda       : boolean;
begin
  Result := True;

  LCasosTestesLog := TCasosTestesLog.New();

  LDados := TUniClientDataSet.Create(Nil);

  LFaturamentoAntesExpedicao := fGetValorConfiguracao(CFG_FATURAMENTO_ANTES_EXPEDICAO_PEDIR_TELA_DADOS_FISCAIS, varBoolean);

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    Try
      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        LNotaEEspecialFornecedor :=
          ((LDados.FieldByName('AUX_OPCDOC').AsString = 'NE') And
            (LDados.FieldByName('DET_TIP_FC').AsString = 'F'));

        FParametrosIpi :=
          TParametrosServicoIPI.New
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .CodigoDoProduto(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .SequencialEnderecoEntrega(LDados.FieldByName('SEQUENCIAL_ENDERECO').AsString)
            .ClassificacaoFiscalDoItem(LDados.FieldByName('DET_CLAFIS').AsString)
            .VendaPresencial(LDados.FieldByName('AUX_VENPRE').AsString = 'S')
            .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .OpcaoDoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .BaixaDeEntregaFutura(LDados.FieldByName('AUX_OPCDOC').AsString = 'BF')
            .EntregaFutura(LDados.FieldByName('GER_ENTFUT').AsString = 'S')
            .TotalGeralDoItem(LDados.FieldByName('DET_TOTITE').AsFloat)
            .ValorFreteDoItem(LDados.FieldByName('DET_TOTFRE').AsFloat)
            .DespesaAcessoriaDoItem(LDados.FieldByName('DET_DESACE').AsFloat)
            .DescontoEspecial(LDados.FieldByName('DET_DESESP').AsFloat)
            .OpcaoDeItemNfEspiritoSanto(RetornarOpcoesDeItemNotaEspiritoSanto(LDados.FieldByName('DET_CLAFIS').AsString))
            .MeiaNotaFatorExpedicao(LDados.FieldByName('GER_FATNOT').AsFloat > 0)
            .DesmembrarMeiaNotaComNotaNormal(false)
            .DesmembrarNotaProdutosServicos(false)
            .NotaComplementoFornecedor(LDados.FieldByName('AUX_OPCDOC').AsString = 'OF')
            .NotaEspecialFornecedor(LNotaEEspecialFornecedor)
            .CodigoDoFornecedor(LDados.FieldByName('DET_CODFOR').AsString)
            .EspecieDeDevolucao(LDados.FieldByName('DET_ESPDEV').AsString)
            .GerandoCasosTestes(True);

        LResultadoServicosClasseIPI := GetFaturamentoImpostosService.Ipi.CalcularValorIpiFinal(FParametrosIpi);

        LResultadoCalculoIPI := LResultadoServicosClasseIPI.ResultadoCalculoIPI;

        LResultadoComparacao := rcoFalse;

        if (CompararValores(LResultadoCalculoIPI.ValorCalculadoIPI, LDados.FieldByName('DET_VALIPI').AsFloat) And
            CompararValores(LResultadoCalculoIPI.AliquotaDeCalculoIPI, LDados.FieldByName('DET_ALQIPI').AsFloat) And
            CompararValores(LResultadoCalculoIPI.BaseDeCalculoIPI, LDados.FieldByName('DET_BASIPI').AsFloat)) then
        begin
          LResultadoComparacao := rcoTrue;
        end;

        LValorZeroComDiferencaSomenteNaAliquota := False;

        if (LResultadoComparacao = rcoFalse) then
          LValorZeroComDiferencaSomenteNaAliquota := ValidarValorZeroComDiferencaSomenteNaAliquota(LResultadoCalculoIPI, LDados, LFaturamentoAntesExpedicao);

        LClassificacaoVenda := ValidarClassificacaoVenda(LDados.FieldByName('DET_CLAFIS').AsString);

        if not (ValidarSeDeveAdicionarLog(LResultadoComparacao, LDados, LValorZeroComDiferencaSomenteNaAliquota, LClassificacaoVenda)) then
          LResultadoComparacao := rcoIgnorado;

        pTesteUnitarioLog(LResultadoServicosClasseIPI, LDados);

        LCasosTestesLog.Add(TParametrosCasosTestesLog.New()
            .ResultadoComparacao(LResultadoComparacao)
            .RetornarNomeOperacao('CALCULO_IPI_')
            .NumeroDoDocumento(LDados.FieldByName('DET_NUMDOC').AsString)
            .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .CodigoDoItem(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .OpcaoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .DataEntrada(LDados.FieldByName('DET_DTAENT').AsDateTime)
            .ClassificacaoFiscal(LDados.FieldByName('DET_CLAFIS').AsString)
            .CodigoFiscal(LDados.FieldByName('DET_CODFIS').AsString)
            .EstadoDoDocumento(LDados.FieldByName('DET_ESTADO').AsString)
            .IdentificacaoDoProduto(LDados.FieldByName('DET_IDEPRO').AsString)
            .Log(fGetVariavelLogIPI));

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;
      LCasosTestesLog.GerarLog('IPI');

    Except
      On E : Exception do
        pFinalizarProcessamentoComErro(LDados, E.Message);
    End;
  Finally
    FreeAndNil(LDados);
  End;
end;

class function TGerarTesteIPI.New: IGerarTeste;
begin
  Result := Self.Create;
end;

procedure TGerarTesteIPI.pTesteUnitarioLog(
  LResultadoServicosClasseIPI: IResultadoServicosClasseIPI; ADados: TUniClientDataSet);
begin
  SetarResultadosComparacao(LResultadoServicosClasseIPI.ResultadoCalculoIPI);

  SetarParametrosComparacao(
    TParametrosComparacaoIpi.New()
      .ValorCalculadoIPI(ADados.FieldByName('DET_VALIPI').AsFloat)
      .BaseDeCalculoIPI(ADados.FieldByName('DET_BASIPI').AsFloat)
      .AliquotaDeCalculoIPI(ADados.FieldByName('DET_ALQIPI').AsFloat));

  pGerarLogTesteUnitario((LResultadoServicosClasseIPI.ParametrosCalculoIPI as TObject), (LResultadoServicosClasseIPI.ResultadoCalculoIPI as TObject), Nil, 'CalcularValorIPI');
end;

function TConsultaIPI.RetornarColunasSQL: string;
begin
  result := EmptyStr;
  result := result + 'SELECT                                  ';
  result := result + '  D.DET_NUMDOC,                         ';
  result := result + '  D.DET_ESPDOC,                         ';
  result := result + '  D.DET_CODEMP,                         ';
  result := result + '  G.GER_ENTFUT,                         ';
  result := result + '  D.DET_CODITE,                         ';
  result := result + '  D.DET_CODCLI,                         ';
  result := result + '  D.DET_BASIPI,                         ';
  result := result + '  D.DET_VALIPI,                         ';
  result := result + '  D.DET_ALQIPI,                         ';
  result := result + '  D.DET_DTAENT,                         ';
  result := result + '  D.DET_TOTITE,                         ';
  result := result + '  D.DET_TOTFRE,                         ';
  result := result + '  D.DET_DESACE,                         ';
  result := result + '  D.DET_DESESP,                         ';
  result := result + '  D.DET_ESPDEV,                         ';
  result := result + '  D.DET_CODFIS,                         ';
  result := result + '  D.DET_ESTADO,                         ';
  result := result + '  A.AUX_OPCDOC,                       ';
  result := result + '  A.AUX_VENPRE,                         ';
  result := result + '  E.AUTOINCREM AS SEQUENCIAL_ENDERECO,  ';
  result := result + '  D.DET_CLAFIS,                         ';
  result := result + '  D.DET_CODFOR,                         ';
  result := result + '  D.DET_TIP_FC,                         ';
  result := result + '  D.DET_IDEPRO,                         ';
  result := result + '  G.GER_FATNOT                          ';
end;

function TConsultaIPI.RetornarFiltrosSQL: string;
begin
  result := EmptyStr;
  result := result + '  WHERE G.GER_CODEMP = :CODEMP                    ';
  result := result + '    AND G.GER_DTAENT BETWEEN :DTAINI AND :DTAFIM  ';
  result := result + '    AND D.DET_ORIDOC <> "D"                       ';
  result := result + '    AND D.DET_ESPDOC NOT IN("AJ","OI","OP")       ';
end;

function TGerarTesteIPI.RetornarOpcoesDeDocumentoDiferencaAliquota(const AFaturamentoAntesExpedicao: Boolean): String;
begin
  Result := 'VN_';

  if not AFaturamentoAntesExpedicao then
    exit;

  Result := Result + 'EI_DD_BF_CO_DV_';
end;

function TGerarTesteIPI.RetornarOpcoesDeItemNotaEspiritoSanto(
  AClassificacaoFiscal: String): TOpcItensNFespTinta;
begin
  Result := opcProdutoAcabado;

  If AClassificacaoFiscal = '1926' Then
    Exit;

  Result := opcColorantesTributados;

  If AClassificacaoFiscal = '5926' Then
    Exit;

  Result := opcVazio;
end;

function TConsultaIPI.AjustaTabelasDocumentoConfirmacao(const ASQLTabelas: string): string;
begin
  result := ASQLTabelas;
  result := AnsiReplaceStr(result, 'MOVGER', 'NOTGER');
  result := AnsiReplaceStr(result, 'MOVDET', 'NOTDET');
  result := AnsiReplaceStr(result, 'AUXMOV', 'AUXNOT');
end;

function TConsultaIPI.RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
begin
  result := EmptyStr;
  result := result + 'FROM                                                                        ';
  result := result + '  MOVGER G                                                                  ';
  result := result + '  INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM                        ';
  result := result + '  INNER JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE                        ';
  result := result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = D.DET_CODITE AND                    ';
  result := result + '                         I.ITE_CODEMP = D.DET_CODEMP                        ';
  result := result + '  INNER JOIN CADCLI L ON L.CLI_CODCLI = D.DET_CODCLI                        ';
  result := result + '  LEFT  JOIN ENTCLI E ON E.ETC_CODCLI = L.CLI_CODCLI AND                    ';
  result := result + '                         E.ETC_SEQIND = (SELECT MIN(T.ETC_SEQIND)           ';
  result := result + '                                         FROM ENTCLI T                      ';
  result := result + '                                         WHERE T.ETC_CODCLI = L.CLI_CODCLI) ';
  result := result + '  LEFT  JOIN AUXMOV A ON A.AUX_SEQGER = D.DET_SEQGER                        ';

  if (not ADoctosConfirmacao) then
    Exit;

  result := AjustaTabelasDocumentoConfirmacao(Result);
end;

function TGerarTesteIPI.ValidarSeDeveAdicionarLog(
  const AResultadoComparacao: TResultadoComparacao; const ADados: TUniClientDataSet; const AValorZeroComDiferencaSomenteNaAliquota: boolean; const AClassificacaoVenda: boolean): boolean;
begin
  result := True;

  if (AResultadoComparacao = rcoTrue) then
    Exit;

  If ValidarSeDeveAdicionarLogInterna(ADados, AValorZeroComDiferencaSomenteNaAliquota, AClassificacaoVenda) Then
    Exit;

  result := False;
end;

function TGerarTesteIPI.ValidarSeDeveAdicionarLogComDiferencaSomenteNaAliquota(
  const AValorZeroComDiferencaSomenteNaAliquota: boolean): boolean;
begin
  result := not AValorZeroComDiferencaSomenteNaAliquota;
end;

function TGerarTesteIPI.ValidarSeDeveAdicionarLogClassificacaoDeNaoVenda(const AClassificacaoVenda: boolean; const AOpcaoDocumento: string): boolean;
begin
  result := True;

  if (AClassificacaoVenda) then
    Exit;

  if (Pos(AOpcaoDocumento, 'VN_DD_CO_NE_') <= 0) then
    Exit;

  result := False;
end;

function TGerarTesteIPI.ValidarSeDeveAdicionarLogPorEspecieDeDocumento(const AEspecieDeDocumento: string): boolean;
begin
  result := True;

  if (Pos(AEspecieDeDocumento, 'GC_') <= 0) then
    Exit;

  result := False;
end;

function TGerarTesteIPI.ValidarSeDeveAdicionarLogInterna(const ADados: TUniClientDataSet;
  const AValorZeroComDiferencaSomenteNaAliquota: boolean; const AClassificacaoVenda: boolean): boolean;
begin
  result := ValidarSeDeveAdicionarLogPorOpcaoDeDocumento(ADados.FieldByName('AUX_OPCDOC').AsString);
  result := result And ValidarSeDeveAdicionarLogPorEspecieDeDocumento(ADados.FieldByName('DET_ESPDOC').AsString);
  result := result and ValidarSeDeveAdicionarLogComDiferencaSomenteNaAliquota(AValorZeroComDiferencaSomenteNaAliquota);
  result := result And ValidarSeDeveAdicionarLogClassificacaoDeNaoVenda(AClassificacaoVenda, ADados.FieldByName('AUX_OPCDOC').AsString);
  result := result And (not TFunctionFuncoesFaturamento.fEhItemServico(ADados.FieldByName('DET_CODITE').AsString));
end;

function TGerarTesteIPI.ValidarSeDeveAdicionarLogPorOpcaoDeDocumento(
  const AOpcaoDocumento: string): boolean;
begin
  result := True;

  if (Pos(AOpcaoDocumento, 'TE_OU_OE_') <= 0) then
    Exit;

  result := False;
end;

function TGerarTesteIPI.ValidarClassificacaoVenda(
  const AClassificacaoFiscal: string): boolean;
var
  LClassificacaoVenda: string;
begin
  result := False;
  LClassificacaoVenda :=  objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, varString);

  if (Pos(AClassificacaoFiscal, LClassificacaoVenda) <= 0) then
    Exit;

  result := True;
end;

function TGerarTesteIPI.ValidarOpcaoDocumentoParaConsiderarDiferencaAliquota(const AOpcaoDocumento: string; const AFaturamentoAntesExpedicao: Boolean): boolean;
begin
  result := True;

  if (fEmptyStr(AOpcaoDocumento)) then
    Exit;

  if (Pos(AOpcaoDocumento, RetornarOpcoesDeDocumentoDiferencaAliquota(AFaturamentoAntesExpedicao)) > 0) then
    Exit;

  result := False;
end;

// ESTA FUNÇÃO IDENTIFICA AS NOTAS FISCAIS GERADAS PELA FATVENDAS COM BASE, VALOR E ALÍQUOTA DE IPI ZERO
// E QUE O CALCULO DA BPL RETORNA BASE E VALOR ZERO, PORÉM COM A ALÍQUOTA PREENCHIDA.
// QUANDO GERAMOS UMA NOTA PELA FATVENDA SEM BASE DE IPI, O AUTCOM ZERA A ALÍQUOTA, PORÉM O CALCULO DA BPL RETORNA A ALÍQUOTA.
// A IDÉIA É IGNORAR ESSE ERRO CASO OCORRA.
function TGerarTesteIPI.ValidarValorZeroComDiferencaSomenteNaAliquota(
  const AResultadoCalculoIPI: IResultadoCalculoIPI; const ADados: TUniClientDataSet;
  const AFaturamentoAntesExpedicao: Boolean): boolean;
begin
  result := False;

  if (Not ValidarOpcaoDocumentoParaConsiderarDiferencaAliquota(ADados.FieldByName('AUX_OPCDOC').AsString, AFaturamentoAntesExpedicao)) then
    Exit;

  if (Pos(ADados.FieldByName('DET_ESPDOC').AsString, 'NF_GA_') <= 0) then
    Exit;

  if (AResultadoCalculoIPI.BaseDeCalculoIPI <> 0) then
    Exit;

  if (AResultadoCalculoIPI.ValorCalculadoIPI <> 0) then
    Exit;

  if (AResultadoCalculoIPI.AliquotaDeCalculoIPI = 0) then
    Exit;

  if (ADados.FieldByName('DET_BASIPI').AsFloat <> 0) then
    Exit;

  if (ADados.FieldByName('DET_VALIPI').AsFloat <> 0) then
    Exit;

  if (ADados.FieldByName('DET_ALQIPI').AsFloat <> 0) then
    Exit;

  result := True;
end;

end.
