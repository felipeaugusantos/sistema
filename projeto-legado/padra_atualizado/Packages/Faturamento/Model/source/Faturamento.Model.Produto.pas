unit Faturamento.Model.Produto;

interface

uses Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Tipos.Model,
  Shared.Functions.Core, Shared.Functions.DataSet, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Types, System.StrUtils, System.SysUtils,
  Shared.Functions.SQL, Shared.Functions.Interfaces, Shared.Functions.Tipos, Shared.Functions.Configuracoes;

type
  TFaturamentoImpostosModelProduto = class sealed(TInterfacedObject, IFaturamentoImpostosModelProduto)
  private
    function CodigoDaAbreviacaoFiscal(const AResultadoCampoTabela: IMyCampoTabela; const ACodigoDaEmpresa, ACodigoDaEmpresaTE: String): String;
    function ImportacaoDiretaDoItem(const AResultadoCampoTabela: IMyCampoTabela): String;
    function DefinirCodigoDoFornecedorDoItem(
      const ACodigoDoFornecedorDoCadastro, ACodigoDoFornecedor: String): String;
    function IndustrializacaoOuRevenda(const AResultadoCampoTabela: IMyCampoTabela): TOpcIndustrializacaoOuRevenda;
    function RetornarCampoITEGER_ITE_INDREV(const AGerandoCasosTestes: boolean): string;

    function RetornarListaFornecedorFilial : String;
    function RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery) : IResultadoDecodificaChaveNota;
    function UtilizaFornecedorDaUltimaNotaDeCompra: Boolean;
    function RetornaFornecedorDaUltimaNotaDeCompra(ACodigoDoProduto, ACodigoDaEmpresa: String) : String;
    function RetornaTipoDoFornecedorDaUltimaNotaDeCompra(ACodigoDoFornecedorDaUltimaCompra: String): String;

  public
    function Consultar(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String;
      const ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
      const AGerandoCasosTestes: Boolean; const ACodigoDaEmpresaAbf: String = ''): IResultadoFaturamentoImpostosModelProduto;

    class function New(): IFaturamentoImpostosModelProduto;
  end;

implementation

{ TFaturamentoImpostosModelProduto }

function TFaturamentoImpostosModelProduto.CodigoDaAbreviacaoFiscal(
  const AResultadoCampoTabela: IMyCampoTabela; const ACodigoDaEmpresa,
  ACodigoDaEmpresaTE: String): String;
begin
  If TFunctionFuncoesFaturamento.CadastroDeAbreviacaoFiscalIgualParaTodasAsEmpresas(ACodigoDaEmpresaTE, ACodigoDaEmpresa) Then
  Begin
    Result := AResultadoCampoTabela.FieldByName('CADITE_CODABF');
    Exit;
  End;

  Result := AResultadoCampoTabela.FieldByName('ITEGER_CODABF');
end;

function TFaturamentoImpostosModelProduto.DefinirCodigoDoFornecedorDoItem(const ACodigoDoFornecedorDoCadastro, ACodigoDoFornecedor: String): String;
begin
  Result := ACodigoDoFornecedor;

  If not objCore.fEmptyStr(Result)  Then
    Exit;

  Result := ACodigoDoFornecedorDoCadastro;
end;

function TFaturamentoImpostosModelProduto.RetornarListaFornecedorFilial : String;
var
  LRetornoForncedorFilial : IMyCampoTabela;
begin
  LRetornoForncedorFilial :=
    objCore.fCampoTabelaDados(TFunctionFuncoesFaturamento.GetSelectFornecedorFilial, [], []);

  Result :=
    TFunctionFuncoesFaturamento.
      RetornarListaDeFornecedorFilial(LRetornoForncedorFilial.Fields(0).AsString, true);
end;

function TFaturamentoImpostosModelProduto.RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery) : IResultadoDecodificaChaveNota;
Var
  LParametrosDecodificacao : IParametrosDecodificaChaveNota;
Begin
  result := Nil;

  ADadosUltimasNotas.Open;

  If not objCore.fEmptyStr(ADadosUltimasNotas.FieldByName('ITE_NOTULT').AsString) Then
  Begin
    LParametrosDecodificacao :=
        TParametrosDecodificaChaveNota.New
          .Chave(ADadosUltimasNotas.FieldByName('ITE_NOTULT').AsString)
          .TamanhoCampoDocumento( objCore.RetornarTamanhoDoCampoNumeroDoDocumento);

    result := TFunctionFuncoesFaturamento.DecodificaChaveNota(LParametrosDecodificacao);
  End;

end;

function TFaturamentoImpostosModelProduto.UtilizaFornecedorDaUltimaNotaDeCompra: Boolean;
begin
  Result := False;

  If not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, varBoolean) Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA) <> '2' Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_MODELO_DE_CALCULO_DECRETO_REDUCAO_BASE_IMPOSTOS) <> '2' Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosModelProduto.RetornaFornecedorDaUltimaNotaDeCompra(ACodigoDoProduto, ACodigoDaEmpresa: String) : String;
Var
  FDadosUltNotas: IMyQuery;
  LResultadoUltimaNota : IResultadoDecodificaChaveNota;
begin
  Result := '';

  If UtilizaFornecedorDaUltimaNotaDeCompra Then
  Begin
    FDadosUltNotas := objDataSet.CreateQuery;
    FDadosUltNotas.SQL.Text :=
      TFunctionsSQL.GetSQLUltimasNotas(ACodigoDoProduto,
                                       RetornarListaFornecedorFilial,
                                       ACodigoDaEmpresa);

    LResultadoUltimaNota := RetornarUltimaNotaItem(ACodigoDoProduto, FDadosUltNotas);

    If Assigned(LResultadoUltimaNota) Then
      Result := LResultadoUltimaNota.CodigoDoFornecedor;
  End;
end;

function TFaturamentoImpostosModelProduto.RetornaTipoDoFornecedorDaUltimaNotaDeCompra(ACodigoDoFornecedorDaUltimaCompra: String): String;
var
  LResultadoCampoTabela: IMyCampoTabela;
begin
  Result := '';

  If UtilizaFornecedorDaUltimaNotaDeCompra Then
  Begin
    LResultadoCampoTabela :=  objCore.fCampoTabela(['FOR_MATREV'],'CADFOR',['FOR_CODFOR'],[ACodigoDoFornecedorDaUltimaCompra], False);
    Result := LResultadoCampoTabela.FieldByName('FOR_MATREV').AsString;
  End;
end;

function TFaturamentoImpostosModelProduto.Consultar(const ACodigoDoProduto,
  ACodigoDaEmpresa, ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
  const AGerandoCasosTestes: Boolean; const ACodigoDaEmpresaAbf: String = ''): IResultadoFaturamentoImpostosModelProduto;
var
  LResultadoCampoTabela: IMyCampoTabela;
  LCodigoDaAbreviacaoFiscal: String;
  LImportacaoDireta: String;
  LUtilizaAmpara: String;
  LCodigoDoFornecedor: String;
  LCodigoDoFornecedorDaUltimaCompra: String;
  LTipoDoFornecedorDaUltimaCompra: String;
  LIpiDeEntrada: Double;
  LFreteDeEntrada: Double;
  LIndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda;
  LAtoDeclaratorioDF: Boolean;
begin
  LResultadoCampoTabela :=
    objCore.fCampoTabela(['ITE_IPISAI', 'ITE_ITECCR', 'I.ITE_CODABF AS ITEGER_CODABF', 'C.ITE_CODABF AS CADITE_CODABF',
                          'I.ITE_IMPDIR AS ITEGER_IMPDIR', 'C.ITE_IMPDIR AS CADITE_IMPDIR', 'C.ITE_UTIAMP',
                          'C.ITE_CODFOR', 'I.ITE_IPIENT', 'I.ITE_FREENT', 'I.ITE_ATODDF',
                          RetornarCampoITEGER_ITE_INDREV(AGerandoCasosTestes), 'C.ITE_INDREV AS CADITE_INDREV'],
                         'ITEGER I INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE',
                         ['I.ITE_CODITE', 'I.ITE_CODEMP'],
                         [ACodigoDoProduto, IfThen(ACodigoDaEmpresaAbf.IsEmpty, IfThen(ACodigoDaEmpresaTE.IsEmpty, ACodigoDaEmpresa, ACodigoDaEmpresaTE), ACodigoDaEmpresaAbf)], False);

  LCodigoDaAbreviacaoFiscal := CodigoDaAbreviacaoFiscal(LResultadoCampoTabela,
                                                        IfThen(ACodigoDaEmpresaAbf.IsEmpty, ACodigoDaEmpresa, ACodigoDaEmpresaAbf),
                                                        ACodigoDaEmpresaTE);
  LImportacaoDireta := ImportacaoDiretaDoItem(LResultadoCampoTabela);
  LUtilizaAmpara := LResultadoCampoTabela.FieldByName('ITE_UTIAMP').AsString;
  LCodigoDoFornecedor := DefinirCodigoDoFornecedorDoItem( LResultadoCampoTabela.FieldByName('ITE_CODFOR').AsString, ACodigoDoFornecedorDoItem);
  LIpiDeEntrada := LResultadoCampoTabela.FieldByName('ITE_IPIENT').AsFloat;
  LFreteDeEntrada := LResultadoCampoTabela.FieldByName('ITE_FREENT').AsFloat;

  LIndustrializacaoOuRevenda := IndustrializacaoOuRevenda(LResultadoCampoTabela);

  LCodigoDoFornecedorDaUltimaCompra := RetornaFornecedorDaUltimaNotaDeCompra(ACodigoDoProduto, ACodigoDaEmpresa);
  LTipoDoFornecedorDaUltimaCompra   := RetornaTipoDoFornecedorDaUltimaNotaDeCompra(LCodigoDoFornecedorDaUltimaCompra);
  LAtoDeclaratorioDF := LResultadoCampoTabela.FieldByName('ITE_ATODDF').AsString = 'S';

  Result :=
    TResultadoFaturamentoImpostosModelProduto.New
      .IpiDeSaida(LResultadoCampoTabela.FieldByName('ITE_IPISAI'))
      .ItemConcreto(LResultadoCampoTabela.FieldByName('ITE_ITECCR'))
      .CodigoDaAbreviacaoFiscal(LCodigoDaAbreviacaoFiscal)
      .ImportacaoDireta(LImportacaoDireta)
      .UtilizaAmpara(LUtilizaAmpara)
      .CodigoDoFornecedor(LCodigoDoFornecedor)
      .IpiDeEntrada(LIpiDeEntrada)
      .FreteDeEntrada(LFreteDeEntrada)
      .IndustrializacaoOuRevenda(LIndustrializacaoOuRevenda)
      .CodigoDoFornecedorDaUltimaCompra(LCodigoDoFornecedorDaUltimaCompra)
      .TipoDoFornecedorDaUltimaCompra(LTipoDoFornecedorDaUltimaCompra)
      .AtoDeclaratorioDF(LAtoDeclaratorioDF)
end;

function TFaturamentoImpostosModelProduto.ImportacaoDiretaDoItem(
  const AResultadoCampoTabela: IMyCampoTabela): String;
begin
  Result :=
    TFunctionFuncoesFaturamento.ImportacaoDiretaDoItem(AResultadoCampoTabela.FieldByName('CADITE_IMPDIR'), AResultadoCampoTabela.FieldByName('ITEGER_IMPDIR'));
end;

function TFaturamentoImpostosModelProduto.IndustrializacaoOuRevenda(
  const AResultadoCampoTabela: IMyCampoTabela): TOpcIndustrializacaoOuRevenda;
var
  LIndustrializacaoOuRevenda: String;
begin
  LIndustrializacaoOuRevenda :=
    TFunctionFuncoesFaturamento
      .fItemRevInd(AResultadoCampoTabela.FieldByName('CADITE_INDREV').AsString,
                   AResultadoCampoTabela.FieldByName('ITEGER_INDREV').AsString);

  Result := OpcRevenda;

  Case AnsiIndexStr(UpperCase(LIndustrializacaoOuRevenda), ['I', 'R']) Of
    0 : Result := OpcIndustrializacao;
    1 : Result := OpcRevenda;
  End;
end;

class function TFaturamentoImpostosModelProduto.New(): IFaturamentoImpostosModelProduto;
begin
  Result := Self.Create;
end;

function TFaturamentoImpostosModelProduto.RetornarCampoITEGER_ITE_INDREV(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'I.ITE_INDREV AS ITEGER_INDREV';

  if (not AGerandoCasosTestes) then
    Exit;

  if not objCore.fCampoExiste('ITEGER','ITE_INDREV') then
    result := '"" AS ITEGER_INDREV';
end;

end.
