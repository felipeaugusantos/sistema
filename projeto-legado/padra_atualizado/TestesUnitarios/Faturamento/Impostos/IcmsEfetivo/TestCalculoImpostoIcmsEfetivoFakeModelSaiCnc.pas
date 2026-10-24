unit TestCalculoImpostoIcmsEfetivoFakeModelSaiCnc;

interface

uses
  TestFramework, Shared.Functions.Configuracoes, Shared.Functions.Core,
  UniClientDataSet, untConsultaModelFaturamento, Faturamento.Impostos.Interfaces.Model;

type
  TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc = class(TTestCase)
  strict private
    FConsultaModel: IConsultaModelFaturamento;
  private
    procedure SetarConfiguracoes;
    procedure SetarListaFornecedores;
    procedure DadosDocumentoApenasUmItem_Open;
    procedure CriarDataSetDocumentos;
    function ModelCliente: IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    function ModelFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ModelProduto: IResultadoFaturamentoImpostosModelProduto;
    function ModelAbreviacaoIcms(const ATipoDaAbreviacaoFiscal: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    procedure ZerarValoresMatriz;
    procedure SetarDataSetDocumentos;

    Const LISTA_FORNECEDORES_FILIAL = '00000001,00000009,00000011,00000014,00000015,00000020,'+
                                      '00000030,00000033,00000035,00000036,00000040,00000045,'+
                                      '00000070,00000083,00000137,00000141,00000153,00000221,'+
                                      '00000239,00000310,00000454,00000455,00000520,00000524,'+
                                      '00000529,00000529,00000551,00000588,00000736,00000781,'+
                                      '00000844,00001016,00008171,00008174,00008228,00008231,'+
                                      '00008236,00008504,00008505,00009817,00009819,00009841,'+
                                      '00009849,00009852,00009894,03333333,04444444,15315315,'+
                                      '15415415,50000000,90690600,99992433';

    var
     FDadosDocumentos : TUniClientDataSet;

    FUltNfCodIte : Array of String;
    FUltNfCodEmp : Array of String;
    FUltNfDtaUlt : Array of String;
    FUltNfNotUlt : Array of String;

    FDocNumDoc : Array of String;
    FDocEspDoc : Array of String;
    FDocCodEmp : Array of String;
    FDocSerie_ : Array of String;
    FDocCodFor : Array of String;
    FDocQtdIte : Array of String;
    FDocDtaEnt : Array of String;
    FDocBaeRet : Array of String;
    FDocVaeRet : Array of String;
    FDocPerRde : Array of String;
    FDocValIcm : Array of String;

    FDocComLiqIpiFreteIvaAbf :Array of String;
    FDocComLiqIpiFreteIva    : Array of String;

    FSemUltNfComLiqIpiFreteIvaAbf : Array of Double;
    FSemUltNfComLiqIpiFreteIva    : Array of Double;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularValorIcmsEfetivoFakeModelSaiCnc;
  end;

implementation

uses untTypesIcmsEfetivo, Shared.Functions.Types, untCalculoImpostoIcmsEfetivo,
  Shared.Functions.DataSet, Shared.Functions.Faturamento.TintaDeMaquina,
  Shared.Functions.Constantes, System.SysUtils, untTestObjMyCampoTabela,
  Data.DB, TestShared.Functions.Conexao.ClientDataSet, untConsultaModelFaturamentoMemory,
  untConsultaModelClienteFornecedorMemory, untTypesIPI, untFactoryClienteMemory,
  untFactoryEmpresaMemory, untConsultaModelEmpresaMemory, untFactoryProdutoMemory,
  untConsultaModelProdutoMemory, untFactoryFornecedorMemory, untConsultaModelAbreviacaoIcmsMemory,
  untFactoryAbreviacaoIcmsMemory;

{ TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc }

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.CriarDataSetDocumentos;
begin
  FDadosDocumentos := TUniClientDataSet.Create(Nil);
  FDadosDocumentos.Close;

  FDadosDocumentos.FieldDefs.Clear;
  FDadosDocumentos.FieldDefs.add('DET_NUMDOC',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_ESPDOC',ftString,100);

  FDadosDocumentos.FieldDefs.add('DET_CODEMP',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_SERIE_',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_CODFOR',ftString,100);

  FDadosDocumentos.FieldDefs.add('DET_QTDITE',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_DTAENT',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_BAERET',ftFloat);

  FDadosDocumentos.FieldDefs.add('DET_VAERET',ftFloat);
  FDadosDocumentos.FieldDefs.add('DET_PERRED',ftFloat);
  FDadosDocumentos.FieldDefs.add('DET_VALICM',ftFloat);

  FDadosDocumentos.FieldDefs.add('COMLIQ_IPI_FRETE_IVA_ABF',ftFloat);
  FDadosDocumentos.FieldDefs.add('COMLIQ_IPI_FRETE_IVA',ftFloat);

  FDadosDocumentos.FieldDefs.add('ITE_CODITE', ftString,100);
  FDadosDocumentos.FieldDefs.add('ITE_CODEMP', ftString,100);
  FDadosDocumentos.FieldDefs.add('ITE_DTAULT', ftString,100);
  FDadosDocumentos.FieldDefs.add('ITE_NOTULT', ftString,100);

  FDadosDocumentos.FieldDefs.add('BASE'    , ftFloat);
  FDadosDocumentos.FieldDefs.add('ALIQUOTA', ftFloat);
  FDadosDocumentos.FieldDefs.add('VALOR'   , ftFloat);

  FDadosDocumentos.Params.CreateParam(ftstring,'NUMDOC',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'ESPDOC',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'CODEMP',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'SERIE_',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'CODFOR',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'CODITE',ptinput);
  FDadosDocumentos.Params.CreateParam(ftFloat ,'COMLIQ',ptinput);

  FDadosDocumentos.CreateDataSet;
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.DadosDocumentoApenasUmItem_Open;
begin
  CriarDataSetDocumentos;

  SetLength(FUltNfCodIte, 1);
  SetLength(FUltNfCodEmp, 1);
  SetLength(FUltNfDtaUlt, 1);
  SetLength(FUltNfNotUlt, 1);

  FUltNfCodIte[0] := '40304';
  FUltNfCodEmp[0] := '112';
  FUltNfDtaUlt[0] := '2019-04-09';
  FUltNfNotUlt[0] := '000000303030NF0121  00000003';

  SetLength(FSemUltNfComLiqIpiFreteIva, 1);
  SetLength(FSemUltNfComLiqIpiFreteIvaAbf, 1);

  FSemUltNfComLiqIpiFreteIva[0]    := 27;
  FSemUltNfComLiqIpiFreteIvaAbf[0] := 150;

  SetLength(FDocNumDoc,1);
  SetLength(FDocEspDoc,1);
  SetLength(FDocCodEmp,1);
  SetLength(FDocSerie_,1);
  SetLength(FDocCodFor,1);
  SetLength(FDocQtdIte,1);
  SetLength(FDocDtaEnt,1);
  SetLength(FDocBaeRet,1);
  SetLength(FDocVaeRet,1);
  SetLength(FDocPerRde,1);
  SetLength(FDocValIcm,1);
  SetLength(FDocComLiqIpiFreteIvaAbf,1);
  SetLength(FDocComLiqIpiFreteIva,1);

  FDocNumDoc[0] := '000011200876';
  FDocEspDoc[0] := 'NF';
  FDocCodEmp[0] := '112';
  FDocSerie_[0] := '001';
  FDocCodFor[0] := '';
  FDocQtdIte[0] := '1';
  FDocDtaEnt[0] := '2019-11-06';
  FDocBaeRet[0] := '0';
  FDocVaeRet[0] := '0';
  FDocPerRde[0] := '0';
  FDocValIcm[0] := '0';
  FDocComLiqIpiFreteIvaAbf[0]:='27';
  FDocComLiqIpiFreteIva[0]   :='150';

  ZerarValoresMatriz;

  SetarDataSetDocumentos;
end;

function TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.ModelAbreviacaoIcms(
  const ATipoDaAbreviacaoFiscal: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := TConsultaModelAbreviacaoIcmsMemory.New
              .AliquotaDeIcms(18) // objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
              .AliquotaDeSt(18) // objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
              .PercentualDaBaseDeIcms(100) // objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
              .CodigoDaSituacaoTributaria('000') // objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');
              .CalcularSTSaiCCO('666') // objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO','666');
              .PercentualDeIva(15) // objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, '15');
              .PercentualDaBaseDeSt(60) // objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, '060');
              .CodigoDaAbreviacaoFiscal('040') // objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
              .AliquotaDeFcp(90) // objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, '090');
              ;
//  objMyCampoTabelaAdd.Add('ABF_CAL_ST', '666');
end;

function TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.ModelCliente: IResultadoFaturamentoImpostosModelClienteFornecedor;
CONST
  EMPCLI_FIL = '00000002,00000003,00000007,00000010,00000014,00000048,'+
               '00000112,00000153,00000229,00000268,00000333,00000612,'+
               '00000777,00000938,00000950,00002510,00002817,00002818,'+
               '00003119,00003244,00006465,00007812,00008011,00008800,'+
               '00008801,00023603,00023613,00023614,00044444,00222222,'+
               '04444444,10152708,12345678,12345678,15315315,15415415,'+
               '50000001,90090005,98991177,99990008,99990031,99990036,'+
               '99990049';
begin
  Result := TConsultaClienteFornecedorMemory.New
                  .SituacaoDoIpi(IPITributado)// objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
                  .ZonaFranca(False)// objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
                  .ClienteZonaFrancaComDescontoEspecial(False)// objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
                  .OrgaoPublico(False)// objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
                  .ClienteEstado('SP')// objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
                  .ConsumidorFinal(False)// objMyCampoTabelaAdd.Add('CLI_CONSUM', 'N');
                  .ClienteAtividade('002')// objMyCampoTabelaAdd.Add('CLI_CODATI', '002');
                  .ClienteRegraFiscal('1')// objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
                  .ClienteInscricaoEstadual('105006071117')// objMyCampoTabelaAdd.Add('CLI_I_E_S_', '105006071117');
                  .ClienteMicroEmpreendedor(False)// objMyCampoTabelaAdd.Add('CLI_MICEMP', 'N');
                  .CalcularDescontoIcmsOrgaoPublico(False) // objMyCampoTabelaAdd.Add('CLI_CALICM', 'N');
                  .ValorIVAEspecialClienteMT(0) // objMyCampoTabelaAdd.Add('CLI_IVAESP', 0);
                  .ValorIVASimClienteMT(0) // objMyCampoTabelaAdd.Add('CLI_IVASIM', 0);
                  .ValorIVANacClienteMT(0) // objMyCampoTabelaAdd.Add('CLI_IVANAC', 0);
                  .AplicarDescontoPisCofinsOrgaoPublico(False) // objMyCampoTabelaAdd.Add('CLI_DESPIS', 'N');
                  .ClienteEstadoEntrega('SP')// objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
                  .SomarIpiBaseIcms(False)// objMyCampoTabelaAdd.Add('CLI_SIBICM', 'N');
                  .SujeitoPassivoSTRegimeEspecial(False)// objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
                  .ReducaoDeBaseDeIcmsTributados(0)// objMyCampoTabelaAdd.Add('CLI_REDICM', 0);
                  .UtilizarDiferimetoST(False)// objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'N');
                  .TipoDeDescontoRateioDescEspecial('N')// objMyCampoTabelaAdd.Add('CLI_ORPURD', 'N');
                  ;

  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'P');
  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', EMPCLI_FIL);

//*** Não passa pelo MODEL ***
//  objMyCampoTabelaAdd.Add('CLI_INDCOM', 'C');
//  objMyCampoTabelaAdd.Add('ATI_CODATI', '004');
//  objMyCampoTabelaAdd.Add('COUNT(*)', 0);
//  objMyCampoTabelaAdd.Add('CONSUM', 'N');
//  objMyCampoTabelaAdd.Add('INDUST','N');
end;

function TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := TConsultaModelEmpresaMemory.New
              .EmpresaEstado('SP'); // objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
end;

function TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.ModelFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := TConsultaClienteFornecedorMemory.New
              .ClienteEstado('SP') // objMyCampoTabelaAdd.Add('FOR_ESTADO', 'SP');
              .ClienteInscricaoEstadual(''); // objMyCampoTabelaAdd.Add('FOR_I_E_S_', '');
end;

function TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.ModelProduto: IResultadoFaturamentoImpostosModelProduto;
begin
  Result := TConsultaModelProdutoMemory.New
              .IpiDeSaida(0) // objMyCampoTabelaAdd.Add('ITE_IPISAI', 0);
              .ItemConcreto('N') // objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
              .UtilizaAmpara('S') // objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');
              .ImportacaoDireta('N') // objMyCampoTabelaAdd.Add('ITEGER_IMPDIR', 'N');  objMyCampoTabelaAdd.Add('CADITE_IMPDIR', 'N');
              .CodigoDaAbreviacaoFiscal('004') // objMyCampoTabelaAdd.Add('ITEGER_CODABF', '004');  objMyCampoTabelaAdd.Add('CADITE_CODABF', '002');
              .IndustrializacaoOuRevenda(OpcRevenda) // objMyCampoTabelaAdd.Add('CADITE_INDREV','R');    objMyCampoTabelaAdd.Add('ITEGER_INDREV','R');
              ;
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.SetarConfiguracoes;
  Const
    CLASSIFICACAO_VENDA = '110121011403240311022102141'+
                          '124112103291123531353590919'+
                          '09193219112401111719212921';
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ESTORNO_ICMS, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ICMS_EFETIVO, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_PRESENCIAL_UTILIZAR_CFOP, 'D');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_COMPRA, CLASSIFICACAO_VENDA);
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.SetarDataSetDocumentos;
Var
  LContador : Integer;
begin
  For LContador := Low(FDocNumDoc) To High(FDocNumDoc) Do
  begin
    FDadosDocumentos.Append;
    FDadosDocumentos.FieldByName('DET_NUMDOC').AsString := FDocNumDoc[LContador];
    FDadosDocumentos.FieldByName('DET_ESPDOC').AsString := FDocEspDoc[LContador];
    FDadosDocumentos.FieldByName('DET_CODEMP').AsString := FDocCodEmp[LContador];

    FDadosDocumentos.FieldByName('DET_SERIE_').AsString := FDocSerie_[LContador];
    FDadosDocumentos.FieldByName('DET_CODFOR').AsString := FDocCodFor[LContador];
    FDadosDocumentos.FieldByName('DET_QTDITE').AsString := FDocQtdIte[LContador];
    FDadosDocumentos.FieldByName('DET_DTAENT').AsString := FDocDtaEnt[LContador];

    FDadosDocumentos.FieldByName('DET_BAERET').AsString := FDocBaeRet[LContador];
    FDadosDocumentos.FieldByName('DET_VAERET').AsString := FDocVaeRet[LContador];
    FDadosDocumentos.FieldByName('DET_PERRED').AsString := FDocPerRde[LContador];
    FDadosDocumentos.FieldByName('DET_VALICM').AsString := FDocValIcm[LContador];

    FDadosDocumentos.FieldByName('COMLIQ_IPI_FRETE_IVA_ABF').AsFloat := StrToFloat(FDocComLiqIpiFreteIvaAbf[LContador]);
    FDadosDocumentos.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat     := StrToFloat(FDocComLiqIpiFreteIva[LContador]);

    FDadosDocumentos.FieldByName('ITE_CODITE').AsString := FUltNfCodIte[LContador];
    FDadosDocumentos.FieldByName('ITE_CODEMP').AsString := FUltNfCodEmp[LContador];
    FDadosDocumentos.FieldByName('ITE_DTAULT').AsString := FUltNfDtaUlt[LContador];
    FDadosDocumentos.FieldByName('ITE_NOTULT').AsString := FUltNfNotUlt[LContador];

    FDadosDocumentos.FieldByName('BASE'    ).AsFloat := 100;
    FDadosDocumentos.FieldByName('ALIQUOTA').AsFloat := 18;
    FDadosDocumentos.FieldByName('VALOR'   ).AsFloat := 18;

    FDadosDocumentos.Post;
  end;

  FUQuery := FDadosDocumentos;
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.SetarListaFornecedores;
begin
  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_FORFIL)', LISTA_FORNECEDORES_FILIAL);
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.SetUp;
begin
  inherited;
  FConsultaModel := TConsultaModelFaturamentoMemory.Create;
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.TearDown;
begin
  inherited;

end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.TestCalcularValorIcmsEfetivoFakeModelSaiCnc;
var
  ReturnValue      : TResultadoServicosClasseIcmsEfetivo;
  LParametros      : TParametrosServicoIcmsEfetivo;
  LarrMatItens     : TMatrizFechamentoIcmsEfetivo;
  LMatrizResultado : TMatrizFechamentoIcmsEfetivo;
  LResultado       : Boolean;
  objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
  LCalculouIcmsEfetivo: Boolean;
  LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
  LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
  LProduto : IResultadoFaturamentoImpostosModelProduto;
  LFornecedor : IResultadoFaturamentoImpostosModelClienteFornecedor;
  LAbreviacaoIcms : IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  LCliente := ModelCliente;
  TFactoryClienteMemory.SetModel(LCliente);

  LEmpresa := ModelEmpresa;
  TFactoryEmpresaMemory.SetModel(LEmpresa);

  LProduto := ModelProduto;
  TFactoryProdutoMemory.SetModel(LProduto);

  LFornecedor := ModelFornecedor;
  TFactoryFornecedorMemory.SetModel(LFornecedor);

  LAbreviacaoIcms := ModelAbreviacaoIcms('_SAI_CNC');
  TFactoryAbreviacaoIcmsMemory.SetModel(LAbreviacaoIcms);

  SetarConfiguracoes;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ESTORNO_ICMS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ICMS_EFETIVO, 'S');

  SetLength(LarrMatItens, 1);
  LarrMatItens[0].strIdePro := 'NOR';
  LarrMatItens[0].strCodFis := '060';
  LarrMatItens[0].strCodSit := '060';
  LarrMatItens[0].strCodIte := '10992';
  LarrMatItens[0].strClaFis := '5405';
  LarrMatItens[0].intOrdem  := 1;
  LarrMatItens[0].strNotUlt := '';
  LarrMatItens[0].fltTotIte := 100.00;
  LarrMatItens[0].fltAlqIcm := 12;
  LarrMatItens[0].fltQtdIte := 1;
  LarrMatItens[0].opcINFesp := opcVazio;

  SetarListaFornecedores;

	DadosDocumentoApenasUmItem_Open;

  FillChar(LParametros, SizeOf(LParametros), #0);
  LParametros.MatItensIcmsEfetivo := LarrMatItens;
  LParametros.VendaPresencial := true;
  LParametros.CodigoDoCliente := '00007083';
  LParametros.OpcaoDoDocumento := 'NF';
  LParametros.CodigoDaEmpresa := '112';
  LParametros.CodigoDaEmpresaTE := '';
  LParametros.CodigoDoFornecedor := '00007083';
  LParametros.ClienteConsumidorFinal := false;
  LParametros.SequencialEnderecoEntrega := '0';
  LParametros.NotaComplementoFornecedor := false;
  LParametros.EspecieDocumento := 'NF';
  LParametros.TipoOperacaoPedidoVenda := '';
  LParametros.CalcularSatEcf := false;
  LParametros.UtilizaSat := false;
  LParametros.NotaEspecialFornecedor := false;
  LParametros.BaixaDeEntregaFutura := false;
  LParametros.GerandoCasosTestes := false;
  LParametros.ClienteIndustria := false;
  LParametros.ClienteComercializacao := false;
  //LParametros.ParametrosClienteConsumidor := Nil;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    LCalculouIcmsEfetivo := False;
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(LParametros, LCalculouIcmsEfetivo);

    SetLength(LMatrizResultado,1);
    LMatrizResultado[0].strNotUlt := '';
    LMatrizResultado[0].fltPICMEF := 0;
    LMatrizResultado[0].fltBICMEF := 0;
    LMatrizResultado[0].fltAICMEF := 0;
    LMatrizResultado[0].fltVICMEF := 0;
    LMatrizResultado[0].fltSICMEF := 0;
    LMatrizResultado[0].fltBSTANT := 150;
    LMatrizResultado[0].fltVSTANT := 27;

    LResultado :=
        ((ReturnValue.ResultadoCalculoIcmsEfetivo[0].strNotUlt = LMatrizResultado[0].strNotUlt )and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltPICMEF = LMatrizResultado[0].fltPICMEF) and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltBICMEF = LMatrizResultado[0].fltBICMEF) and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltAICMEF = LMatrizResultado[0].fltAICMEF) and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltVICMEF = LMatrizResultado[0].fltVICMEF) and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltSICMEF = LMatrizResultado[0].fltSICMEF) and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltBSTANT = LMatrizResultado[0].fltBSTANT) and
         (ReturnValue.ResultadoCalculoIcmsEfetivo[0].fltVSTANT = LMatrizResultado[0].fltVSTANT));

    CheckTrue(LResultado);
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.ZerarValoresMatriz;
begin

end;

initialization
  RegisterTest(TestTCalculoImpostoIcmsEfetivoFakeModelSaiCnc.Suite);

end.
