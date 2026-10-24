unit TestFaturamento.Impostos.Calculos.STCustoAquisicao.CHUVEIRAO_Lj001_20191101;

{--------------------------------------------------------------------------
                    RESUMO STCUSTOAQUISICAO                 
--------------------------------------------------------------------------
Empresa            : 001 - 001 - CHUVEIRAO DAS TINTAS
Período Selecionado: 01/11/2019 até 01/11/2019
Data do Processo   : 01/11/2019 
Hora Inicio        : 21:05:23
Hora Fim           : 21:17:51
Tempo Total        : 00:12:27
                                           
Total Registros    : 470
Total Processados  : 0
Total de Acertos   : 227
Total de Erros     : 0
Total Ignorados    : 3
Total Duplicados   : 240
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.STCustoAquisicao,
Faturamento.Impostos.Tipos.STCustoAquisicao,
Faturamento.Impostos.Interfaces.STCustoAquisicao;

type
Test001CHUVEIRAO = class(TTestCase)
strict private
private




published

Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000001;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000002;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000003;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000004;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000005;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000006;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000007;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000008;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000009;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000010;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000011;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000012;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000013;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000014;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000015;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000016;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000017;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000018;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000019;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000020;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000021;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000022;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000023;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000024;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000025;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000026;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000027;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000028;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000029;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000030;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000031;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000032;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000033;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000034;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000035;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000036;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000037;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000038;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000039;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000040;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000041;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000042;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000043;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000044;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000045;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000046;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000047;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000048;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000049;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000050;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000051;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000052;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000053;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000054;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000055;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000056;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000057;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000058;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000059;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000060;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000061;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000062;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000063;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000064;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000065;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000066;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000067;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000068;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000069;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000070;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000071;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000072;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000073;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000074;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000075;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000076;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000077;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000078;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000079;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000080;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000081;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000082;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000083;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000084;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000085;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000086;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000087;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000088;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000089;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000090;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000091;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000092;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000093;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000094;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000095;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000096;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000097;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000098;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000099;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000100;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000101;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000102;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000103;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000104;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000105;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000106;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000107;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000108;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000109;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000110;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000111;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000112;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000113;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000114;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000115;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000116;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000117;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000118;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000119;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000120;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000121;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000122;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000123;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000124;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000125;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000126;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000127;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000128;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000129;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000130;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000131;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000132;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000133;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000134;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000135;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000136;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000137;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000138;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000139;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000140;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000141;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000142;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000143;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000144;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000145;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000146;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000147;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000148;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000149;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000150;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000151;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000152;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000153;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000154;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000155;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000156;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000157;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000158;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000159;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000160;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000161;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000162;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000163;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000164;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000165;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000166;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000167;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000168;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000169;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000170;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000171;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000172;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000173;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000174;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000175;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000176;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000177;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000178;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000179;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000180;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000181;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000182;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000183;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000184;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000185;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000186;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000187;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000188;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000189;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000190;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000191;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000192;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000193;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000194;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000195;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000196;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000197;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000198;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000199;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000200;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000201;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000202;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000203;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000204;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000205;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000206;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000207;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000208;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000209;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000210;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000211;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000212;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000213;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000214;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000215;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000216;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000217;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000218;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000219;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000220;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000221;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000222;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000223;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000224;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000225;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000226;
Procedure REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000227;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure Test001CHUVEIRAO.SetUp;
begin
end;

procedure Test001CHUVEIRAO.TearDown;
begin
end;

Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101334" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00840" AND DET_CODCLI = "10024008";
    DOCUMENTO: 000000101334
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10024008
       ESTADO: SP
         ITEM: 00840
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(33.35)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{33,35}, objFloatUtils.fStrToFloat('33,35')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{6}, objFloatUtils.fStrToFloat('6')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101335" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13970" AND DET_CODCLI = "10029825";
    DOCUMENTO: 000000101335
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10029825
       ESTADO: SP
         ITEM: 13970
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(595.66752)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{595,67}, objFloatUtils.fStrToFloat('595,67')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{107,22}, objFloatUtils.fStrToFloat('107,22')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101336" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10460" AND DET_CODCLI = "10031116";
    DOCUMENTO: 000000101336
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031116
       ESTADO: SP
         ITEM: 10460
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(202.8)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101336" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00922" AND DET_CODCLI = "10031116";
    DOCUMENTO: 000000101336
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031116
       ESTADO: SP
         ITEM: 00922
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(132.94)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{132,94}, objFloatUtils.fStrToFloat('132,94')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{23,93}, objFloatUtils.fStrToFloat('23,93')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101336" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03132" AND DET_CODCLI = "10031116";
    DOCUMENTO: 000000101336
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031116
       ESTADO: SP
         ITEM: 03132
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(8.4969232)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101336" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04079" AND DET_CODCLI = "10031116";
    DOCUMENTO: 000000101336
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031116
       ESTADO: SP
         ITEM: 04079
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(12.8691264)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101336" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16261" AND DET_CODCLI = "10031116";
    DOCUMENTO: 000000101336
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031116
       ESTADO: SP
         ITEM: 16261
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(42.4)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101337" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03828" AND DET_CODCLI = "10026928";
    DOCUMENTO: 000000101337
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026928
       ESTADO: SP
         ITEM: 03828
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(162.2302)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{162,23}, objFloatUtils.fStrToFloat('162,23')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{29,2}, objFloatUtils.fStrToFloat('29,2')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101337" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05129" AND DET_CODCLI = "10026928";
    DOCUMENTO: 000000101337
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026928
       ESTADO: SP
         ITEM: 05129
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(52.67)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{52,67}, objFloatUtils.fStrToFloat('52,67')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{9,48}, objFloatUtils.fStrToFloat('9,48')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101337" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11629" AND DET_CODCLI = "10026928";
    DOCUMENTO: 000000101337
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026928
       ESTADO: SP
         ITEM: 11629
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(33.64405)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101337" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03153" AND DET_CODCLI = "10026928";
    DOCUMENTO: 000000101337
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026928
       ESTADO: SP
         ITEM: 03153
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.819)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101337" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06127" AND DET_CODCLI = "10026928";
    DOCUMENTO: 000000101337
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026928
       ESTADO: SP
         ITEM: 06127
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(53.5464)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{53,55}, objFloatUtils.fStrToFloat('53,55')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{9,64}, objFloatUtils.fStrToFloat('9,64')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074846" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01192" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074846
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 01192
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(18.13392)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{19,04}, objFloatUtils.fStrToFloat('19,04')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,26}, objFloatUtils.fStrToFloat('3,26')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074846" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03210" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074846
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03210
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.04)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101338" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11630" AND DET_CODCLI = "10030399";
    DOCUMENTO: 000000101338
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030399
       ESTADO: SP
         ITEM: 11630
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(116.93242)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074847" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13912" AND DET_CODCLI = "10029696";
    DOCUMENTO: 000000074847
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10029696
       ESTADO: SP
         ITEM: 13912
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(37.20864)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{37,21}, objFloatUtils.fStrToFloat('37,21')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{6,7}, objFloatUtils.fStrToFloat('6,7')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101339" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03825" AND DET_CODCLI = "10031117";
    DOCUMENTO: 000000101339
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031117
       ESTADO: SP
         ITEM: 03825
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(324.4604)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{324,46}, objFloatUtils.fStrToFloat('324,46')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{58,4}, objFloatUtils.fStrToFloat('58,4')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101339" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03226" AND DET_CODCLI = "10031117";
    DOCUMENTO: 000000101339
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031117
       ESTADO: SP
         ITEM: 03226
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(15.18)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101340" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03967" AND DET_CODCLI = "10014675";
    DOCUMENTO: 000000101340
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10014675
       ESTADO: SP
         ITEM: 03967
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(7.48)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101341" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05089" AND DET_CODCLI = "10027021";
    DOCUMENTO: 000000101341
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027021
       ESTADO: SP
         ITEM: 05089
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(19.758)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{20,75}, objFloatUtils.fStrToFloat('20,75')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,56}, objFloatUtils.fStrToFloat('3,56')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101341" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05121" AND DET_CODCLI = "10027021";
    DOCUMENTO: 000000101341
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027021
       ESTADO: SP
         ITEM: 05121
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(17.538)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{17,54}, objFloatUtils.fStrToFloat('17,54')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,16}, objFloatUtils.fStrToFloat('3,16')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101341" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03892" AND DET_CODCLI = "10027021";
    DOCUMENTO: 000000101341
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027021
       ESTADO: SP
         ITEM: 03892
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.76)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.75)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(10)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{2,02}, objFloatUtils.fStrToFloat('2,02')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0,35}, objFloatUtils.fStrToFloat('0,35')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101342" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10460" AND DET_CODCLI = "10001217";
    DOCUMENTO: 000000101342
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10001217
       ESTADO: SP
         ITEM: 10460
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(84.5)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101342" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10761" AND DET_CODCLI = "10001217";
    DOCUMENTO: 000000101342
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10001217
       ESTADO: SP
         ITEM: 10761
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(26.95)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{26,95}, objFloatUtils.fStrToFloat('26,95')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{4,85}, objFloatUtils.fStrToFloat('4,85')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101343" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16260" AND DET_CODCLI = "10002074";
    DOCUMENTO: 000000101343
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10002074
       ESTADO: SP
         ITEM: 16260
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(4.18)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101344" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04382" AND DET_CODCLI = "00000096";
    DOCUMENTO: 000000101344
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000096
       ESTADO: SP
         ITEM: 04382
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(109.37483024247)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074848" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02186" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074848
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 02186
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.2839)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074848" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03336" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074848
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03336
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(24.74)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{24,74}, objFloatUtils.fStrToFloat('24,74')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{4,45}, objFloatUtils.fStrToFloat('4,45')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101345" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04907" AND DET_CODCLI = "00006734";
    DOCUMENTO: 000000101345
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006734
       ESTADO: SP
         ITEM: 04907
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(104.24)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{104,24}, objFloatUtils.fStrToFloat('104,24')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{18,76}, objFloatUtils.fStrToFloat('18,76')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101345" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11629" AND DET_CODCLI = "00006734";
    DOCUMENTO: 000000101345
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006734
       ESTADO: SP
         ITEM: 11629
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(67.2881)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000124046" AND DET_ESPDOC = "ML" AND DET_CODEMP = "001" AND DET_CODITE = "04650" AND DET_CODCLI = "00021114";
    DOCUMENTO: 000000124046
      ESPECIE: ML
      EMPRESA: 001
      CLIENTE: 00021114
       ESTADO: SP
         ITEM: 04650
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(0)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(2.18)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117740" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "12534" AND DET_CODCLI = "00021114";
    DOCUMENTO: 000000117740
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00021114
       ESTADO: SP
         ITEM: 12534
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(262.0069)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{262,01}, objFloatUtils.fStrToFloat('262,01')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{47,16}, objFloatUtils.fStrToFloat('47,16')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14635" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 14635
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(537.12)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{563,98}, objFloatUtils.fStrToFloat('563,98')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{96,68}, objFloatUtils.fStrToFloat('96,68')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14634" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 14634
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(167.856)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15709" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 15709
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(85.208)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{89,47}, objFloatUtils.fStrToFloat('89,47')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{15,34}, objFloatUtils.fStrToFloat('15,34')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02199" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 02199
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(83.256)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13425" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 13425
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(69.312)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{72,78}, objFloatUtils.fStrToFloat('72,78')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{12,48}, objFloatUtils.fStrToFloat('12,48')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13423" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 13423
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(66.936)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{70,28}, objFloatUtils.fStrToFloat('70,28')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{12,05}, objFloatUtils.fStrToFloat('12,05')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101347" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04882" AND DET_CODCLI = "10005588";
    DOCUMENTO: 000000101347
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10005588
       ESTADO: SP
         ITEM: 04882
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(129.57)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{129,57}, objFloatUtils.fStrToFloat('129,57')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{23,32}, objFloatUtils.fStrToFloat('23,32')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074849" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10460" AND DET_CODCLI = "10031118";
    DOCUMENTO: 000000074849
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031118
       ESTADO: SP
         ITEM: 10460
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(50.7)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074849" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03133" AND DET_CODCLI = "10031118";
    DOCUMENTO: 000000074849
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031118
       ESTADO: SP
         ITEM: 03133
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(4.2484616)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074849" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03484" AND DET_CODCLI = "10031118";
    DOCUMENTO: 000000074849
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031118
       ESTADO: SP
         ITEM: 03484
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(83.92)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{83,92}, objFloatUtils.fStrToFloat('83,92')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{15,11}, objFloatUtils.fStrToFloat('15,11')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074849" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02185" AND DET_CODCLI = "10031118";
    DOCUMENTO: 000000074849
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031118
       ESTADO: SP
         ITEM: 02185
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(25.992)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101348" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04373" AND DET_CODCLI = "10030783";
    DOCUMENTO: 000000101348
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030783
       ESTADO: SP
         ITEM: 04373
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(32.36050966005)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101348" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03243" AND DET_CODCLI = "10030783";
    DOCUMENTO: 000000101348
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030783
       ESTADO: SP
         ITEM: 03243
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.21)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074850" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04899" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074850
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04899
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(40.56)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{40,56}, objFloatUtils.fStrToFloat('40,56')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{7,3}, objFloatUtils.fStrToFloat('7,3')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074850" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05435" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074850
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 05435
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(7.569832179)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101349" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04345" AND DET_CODCLI = "10021228";
    DOCUMENTO: 000000101349
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10021228
       ESTADO: SP
         ITEM: 04345
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(10.48)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101350" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13943" AND DET_CODCLI = "00000009";
    DOCUMENTO: 000000101350
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000009
       ESTADO: SP
         ITEM: 13943
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(444.82592)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{444,83}, objFloatUtils.fStrToFloat('444,83')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{80,07}, objFloatUtils.fStrToFloat('80,07')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101350" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13940" AND DET_CODCLI = "00000009";
    DOCUMENTO: 000000101350
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000009
       ESTADO: SP
         ITEM: 13940
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3099.4656)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{3099,47}, objFloatUtils.fStrToFloat('3099,47')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{557,9}, objFloatUtils.fStrToFloat('557,9')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101351" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14961" AND DET_CODCLI = "10022568";
    DOCUMENTO: 000000101351
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10022568
       ESTADO: SP
         ITEM: 14961
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(9.66)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101351" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10161" AND DET_CODCLI = "10022568";
    DOCUMENTO: 000000101351
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10022568
       ESTADO: SP
         ITEM: 10161
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.04)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101352" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17265" AND DET_CODCLI = "10031081";
    DOCUMENTO: 000000101352
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031081
       ESTADO: SP
         ITEM: 17265
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.1)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101352" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11352" AND DET_CODCLI = "10031081";
    DOCUMENTO: 000000101352
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031081
       ESTADO: SP
         ITEM: 11352
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(22.0057344)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101352" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16261" AND DET_CODCLI = "10031081";
    DOCUMENTO: 000000101352
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031081
       ESTADO: SP
         ITEM: 16261
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(8.48)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074851" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "17265" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074851
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 17265
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.4)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117741" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04621" AND DET_CODCLI = "10023656";
    DOCUMENTO: 000000117741
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10023656
       ESTADO: SP
         ITEM: 04621
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(211.0848)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{211,08}, objFloatUtils.fStrToFloat('211,08')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{37,99}, objFloatUtils.fStrToFloat('37,99')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101354" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03574" AND DET_CODCLI = "00025006";
    DOCUMENTO: 000000101354
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00025006
       ESTADO: SP
         ITEM: 03574
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(False)
      .PrecoDeCompraComDescontos(151.97)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101355" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04005" AND DET_CODCLI = "10027077";
    DOCUMENTO: 000000101355
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027077
       ESTADO: SP
         ITEM: 04005
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(152.8386)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(0)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(0)
      .AliquotaDeOperacoesProprias(0)
      .IpiDeEntrada(5)
      .FreteDeEntrada(5)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101355" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02517" AND DET_CODCLI = "10027077";
    DOCUMENTO: 000000101355
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027077
       ESTADO: SP
         ITEM: 02517
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(113.91165)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101355" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06071" AND DET_CODCLI = "10027077";
    DOCUMENTO: 000000101355
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027077
       ESTADO: SP
         ITEM: 06071
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(191.528)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{201,1}, objFloatUtils.fStrToFloat('201,1')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{34,48}, objFloatUtils.fStrToFloat('34,48')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074853" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05536" AND DET_CODCLI = "10021677";
    DOCUMENTO: 000000074853
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10021677
       ESTADO: SP
         ITEM: 05536
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(39.88)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{41,87}, objFloatUtils.fStrToFloat('41,87')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{7,18}, objFloatUtils.fStrToFloat('7,18')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074853" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11628" AND DET_CODCLI = "10021677";
    DOCUMENTO: 000000074853
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10021677
       ESTADO: SP
         ITEM: 11628
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.77303)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074853" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03132" AND DET_CODCLI = "10021677";
    DOCUMENTO: 000000074853
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10021677
       ESTADO: SP
         ITEM: 03132
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.69938464)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074853" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04079" AND DET_CODCLI = "10021677";
    DOCUMENTO: 000000074853
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10021677
       ESTADO: SP
         ITEM: 04079
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.28691264)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074854" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03428" AND DET_CODCLI = "10020807";
    DOCUMENTO: 000000074854
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10020807
       ESTADO: SP
         ITEM: 03428
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(19.499)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{19,5}, objFloatUtils.fStrToFloat('19,5')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,51}, objFloatUtils.fStrToFloat('3,51')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101356" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02613" AND DET_CODCLI = "00012276";
    DOCUMENTO: 000000101356
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00012276
       ESTADO: SP
         ITEM: 02613
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(135.5175)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101357" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03474" AND DET_CODCLI = "00012276";
    DOCUMENTO: 000000101357
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00012276
       ESTADO: SP
         ITEM: 03474
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(21.5)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101358" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11192" AND DET_CODCLI = "00023711";
    DOCUMENTO: 000000101358
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00023711
       ESTADO: MG
         ITEM: 11192
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(539.0814)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101358" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11352" AND DET_CODCLI = "00023711";
    DOCUMENTO: 000000101358
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00023711
       ESTADO: MG
         ITEM: 11352
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(220.057344)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101358" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16144" AND DET_CODCLI = "00023711";
    DOCUMENTO: 000000101358
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00023711
       ESTADO: MG
         ITEM: 16144
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(72.81792)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15839" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 15839
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(193.17)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{193,17}, objFloatUtils.fStrToFloat('193,17')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{34,77}, objFloatUtils.fStrToFloat('34,77')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15352" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 15352
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(17.28864)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04507" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 04507
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(90.592)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{95,12}, objFloatUtils.fStrToFloat('95,12')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{16,31}, objFloatUtils.fStrToFloat('16,31')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11628" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 11628
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(13.54606)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12540" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 12540
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(27.89865)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(25)
      .AliquotaDeOperacoesProprias(25)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03484" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 03484
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(41.96)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{41,96}, objFloatUtils.fStrToFloat('41,96')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{7,55}, objFloatUtils.fStrToFloat('7,55')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10460" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 10460
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(16.9)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11579" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 11579
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(32.5)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{32,5}, objFloatUtils.fStrToFloat('32,5')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{5,85}, objFloatUtils.fStrToFloat('5,85')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11477" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 11477
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(65)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{65}, objFloatUtils.fStrToFloat('65')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{11,7}, objFloatUtils.fStrToFloat('11,7')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06132" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 06132
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(212.1654)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{212,17}, objFloatUtils.fStrToFloat('212,17')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{38,19}, objFloatUtils.fStrToFloat('38,19')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03155" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 03155
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.4125)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03153" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 03153
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.365)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15027" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 15027
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(11.57328)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16260" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 16260
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(8.36)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10161" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 10161
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(12.08)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06826" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 06826
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(46.64)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{46,64}, objFloatUtils.fStrToFloat('46,64')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{8,4}, objFloatUtils.fStrToFloat('8,4')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101359" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12248" AND DET_CODCLI = "10018487";
    DOCUMENTO: 000000101359
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018487
       ESTADO: SP
         ITEM: 12248
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(183.81)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{183,81}, objFloatUtils.fStrToFloat('183,81')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{33,09}, objFloatUtils.fStrToFloat('33,09')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101360" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04889" AND DET_CODCLI = "10028318";
    DOCUMENTO: 000000101360
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10028318
       ESTADO: PR
         ITEM: 04889
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(17.51)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{17,51}, objFloatUtils.fStrToFloat('17,51')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,15}, objFloatUtils.fStrToFloat('3,15')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101360" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03154" AND DET_CODCLI = "10028318";
    DOCUMENTO: 000000101360
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10028318
       ESTADO: PR
         ITEM: 03154
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.565)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117742" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "05729" AND DET_CODCLI = "10031121";
    DOCUMENTO: 000000117742
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10031121
       ESTADO: SP
         ITEM: 05729
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(70.2822)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{70,28}, objFloatUtils.fStrToFloat('70,28')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{12,65}, objFloatUtils.fStrToFloat('12,65')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074856" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "16076" AND DET_CODCLI = "10031121";
    DOCUMENTO: 000000074856
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031121
       ESTADO: SP
         ITEM: 16076
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(14.37)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{14,37}, objFloatUtils.fStrToFloat('14,37')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,59}, objFloatUtils.fStrToFloat('2,59')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074858" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03223" AND DET_CODCLI = "10031104";
    DOCUMENTO: 000000074858
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031104
       ESTADO: SP
         ITEM: 03223
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(19.69)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074858" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03967" AND DET_CODCLI = "10031104";
    DOCUMENTO: 000000074858
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031104
       ESTADO: SP
         ITEM: 03967
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.74)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101361" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13971" AND DET_CODCLI = "00014527";
    DOCUMENTO: 000000101361
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00014527
       ESTADO: SP
         ITEM: 13971
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(77.04368)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{77,04}, objFloatUtils.fStrToFloat('77,04')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{13,87}, objFloatUtils.fStrToFloat('13,87')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000124050" AND DET_ESPDOC = "ML" AND DET_CODEMP = "001" AND DET_CODITE = "13514" AND DET_CODCLI = "00023711";
    DOCUMENTO: 000000124050
      ESPECIE: ML
      EMPRESA: 001
      CLIENTE: 00023711
       ESTADO: MG
         ITEM: 13514
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: SUV
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(0)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(2.18)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117743" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "13971" AND DET_CODCLI = "00023711";
    DOCUMENTO: 000000117743
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00023711
       ESTADO: MG
         ITEM: 13971
         CFOP: 2999
CODIGO FISCAL: 000
       IDEPRO: SUV
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(79.8331)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074859" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03466" AND DET_CODCLI = "10029988";
    DOCUMENTO: 000000074859
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10029988
       ESTADO: SP
         ITEM: 03466
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.393)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(66.67)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(66.67)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074860" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "06828" AND DET_CODCLI = "10005572";
    DOCUMENTO: 000000074860
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10005572
       ESTADO: SP
         ITEM: 06828
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(13.96)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{13,96}, objFloatUtils.fStrToFloat('13,96')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,51}, objFloatUtils.fStrToFloat('2,51')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101365" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11647" AND DET_CODCLI = "10030965";
    DOCUMENTO: 000000101365
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030965
       ESTADO: SP
         ITEM: 11647
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(243.1122)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{243,11}, objFloatUtils.fStrToFloat('243,11')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{43,76}, objFloatUtils.fStrToFloat('43,76')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101366" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03257" AND DET_CODCLI = "10015607";
    DOCUMENTO: 000000101366
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10015607
       ESTADO: SP
         ITEM: 03257
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.41)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117744" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15882" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000117744
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15882
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(74.9167)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{74,92}, objFloatUtils.fStrToFloat('74,92')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{13,49}, objFloatUtils.fStrToFloat('13,49')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074861" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "16260" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074861
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 16260
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.09)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074861" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03214" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074861
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03214
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.72)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101367" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10460" AND DET_CODCLI = "10029531";
    DOCUMENTO: 000000101367
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10029531
       ESTADO: SP
         ITEM: 10460
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(33.8)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117745" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04619" AND DET_CODCLI = "00012579";
    DOCUMENTO: 000000117745
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00012579
       ESTADO: SP
         ITEM: 04619
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(52.8288)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{52,83}, objFloatUtils.fStrToFloat('52,83')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{9,51}, objFloatUtils.fStrToFloat('9,51')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074863" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15597" AND DET_CODCLI = "10022223";
    DOCUMENTO: 000000074863
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10022223
       ESTADO: SP
         ITEM: 15597
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(37.37)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{37,37}, objFloatUtils.fStrToFloat('37,37')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{6,73}, objFloatUtils.fStrToFloat('6,73')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101369" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03968" AND DET_CODCLI = "10018387";
    DOCUMENTO: 000000101369
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018387
       ESTADO: SP
         ITEM: 03968
         CFOP: 5910
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(8.75)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(7)
      .AliquotaDeOperacoesProprias(7)
      .IpiDeEntrada(8)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{9,45}, objFloatUtils.fStrToFloat('9,45')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0,61}, objFloatUtils.fStrToFloat('0,61')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101369" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03214" AND DET_CODCLI = "10018387";
    DOCUMENTO: 000000101369
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018387
       ESTADO: SP
         ITEM: 03214
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.44)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117746" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15878" AND DET_CODCLI = "10031122";
    DOCUMENTO: 000000117746
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10031122
       ESTADO: SP
         ITEM: 15878
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(48.9919)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{48,99}, objFloatUtils.fStrToFloat('48,99')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{8,82}, objFloatUtils.fStrToFloat('8,82')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074864" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04876" AND DET_CODCLI = "10031122";
    DOCUMENTO: 000000074864
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031122
       ESTADO: SP
         ITEM: 04876
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(24.12)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{24,12}, objFloatUtils.fStrToFloat('24,12')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{4,34}, objFloatUtils.fStrToFloat('4,34')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074864" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02652" AND DET_CODCLI = "10031122";
    DOCUMENTO: 000000074864
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031122
       ESTADO: SP
         ITEM: 02652
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.66)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(30)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074864" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03216" AND DET_CODCLI = "10031122";
    DOCUMENTO: 000000074864
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031122
       ESTADO: SP
         ITEM: 03216
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(10.78)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074864" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11664" AND DET_CODCLI = "10031122";
    DOCUMENTO: 000000074864
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031122
       ESTADO: SP
         ITEM: 11664
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(120.9)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{120,9}, objFloatUtils.fStrToFloat('120,9')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{21,76}, objFloatUtils.fStrToFloat('21,76')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074864" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04864" AND DET_CODCLI = "10031122";
    DOCUMENTO: 000000074864
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031122
       ESTADO: SP
         ITEM: 04864
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(83.04)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{83,04}, objFloatUtils.fStrToFloat('83,04')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{14,95}, objFloatUtils.fStrToFloat('14,95')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074866" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04990" AND DET_CODCLI = "10014533";
    DOCUMENTO: 000000074866
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10014533
       ESTADO: SP
         ITEM: 04990
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(11.95)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{11,95}, objFloatUtils.fStrToFloat('11,95')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,15}, objFloatUtils.fStrToFloat('2,15')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074867" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04883" AND DET_CODCLI = "00015233";
    DOCUMENTO: 000000074867
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00015233
       ESTADO: SP
         ITEM: 04883
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(32.52)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{32,52}, objFloatUtils.fStrToFloat('32,52')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{5,85}, objFloatUtils.fStrToFloat('5,85')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074867" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04885" AND DET_CODCLI = "00015233";
    DOCUMENTO: 000000074867
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00015233
       ESTADO: SP
         ITEM: 04885
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(15.48)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{15,48}, objFloatUtils.fStrToFloat('15,48')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,79}, objFloatUtils.fStrToFloat('2,79')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074868" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05095" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074868
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 05095
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(9.879)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{10,37}, objFloatUtils.fStrToFloat('10,37')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{1,78}, objFloatUtils.fStrToFloat('1,78')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074871" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01110" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074871
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 01110
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(271.88336)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{271,88}, objFloatUtils.fStrToFloat('271,88')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{48,94}, objFloatUtils.fStrToFloat('48,94')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074871" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05989" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074871
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 05989
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(4.92)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074871" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05530" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074871
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 05530
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(12.976)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{13,62}, objFloatUtils.fStrToFloat('13,62')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,34}, objFloatUtils.fStrToFloat('2,34')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074871" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13569" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074871
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 13569
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.59615)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(25)
      .AliquotaDeOperacoesProprias(25)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074872" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10160" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074872
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 10160
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.6259)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(25)
      .AliquotaDeOperacoesProprias(25)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074873" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03331" AND DET_CODCLI = "10031123";
    DOCUMENTO: 000000074873
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031123
       ESTADO: SP
         ITEM: 03331
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(15.3624)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{16,13}, objFloatUtils.fStrToFloat('16,13')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,76}, objFloatUtils.fStrToFloat('2,76')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074875" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15351" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074875
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15351
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(11.11968)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101372" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03256" AND DET_CODCLI = "10031010";
    DOCUMENTO: 000000101372
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031010
       ESTADO: SP
         ITEM: 03256
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(7.88)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101372" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15812" AND DET_CODCLI = "10031010";
    DOCUMENTO: 000000101372
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031010
       ESTADO: SP
         ITEM: 15812
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(4.33)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101373" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03217" AND DET_CODCLI = "10021228";
    DOCUMENTO: 000000101373
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10021228
       ESTADO: SP
         ITEM: 03217
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.18)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101373" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03215" AND DET_CODCLI = "10021228";
    DOCUMENTO: 000000101373
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10021228
       ESTADO: SP
         ITEM: 03215
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.52)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101374" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03704" AND DET_CODCLI = "10001638";
    DOCUMENTO: 000000101374
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10001638
       ESTADO: SP
         ITEM: 03704
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(57.8754)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{57,88}, objFloatUtils.fStrToFloat('57,88')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{10,42}, objFloatUtils.fStrToFloat('10,42')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117747" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04623" AND DET_CODCLI = "10029443";
    DOCUMENTO: 000000117747
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10029443
       ESTADO: SP
         ITEM: 04623
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(116.2818)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{116,28}, objFloatUtils.fStrToFloat('116,28')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{20,93}, objFloatUtils.fStrToFloat('20,93')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101377" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16261" AND DET_CODCLI = "10006671";
    DOCUMENTO: 000000101377
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10006671
       ESTADO: SP
         ITEM: 16261
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(25.44)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101377" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04079" AND DET_CODCLI = "10006671";
    DOCUMENTO: 000000101377
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10006671
       ESTADO: SP
         ITEM: 04079
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.4345632)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074876" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10460" AND DET_CODCLI = "10031124";
    DOCUMENTO: 000000074876
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031124
       ESTADO: SP
         ITEM: 10460
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(101.4)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074876" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04079" AND DET_CODCLI = "10031124";
    DOCUMENTO: 000000074876
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031124
       ESTADO: SP
         ITEM: 04079
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.2172816)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074876" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15557" AND DET_CODCLI = "10031124";
    DOCUMENTO: 000000074876
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031124
       ESTADO: SP
         ITEM: 15557
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(23.7)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074876" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "16261" AND DET_CODCLI = "10031124";
    DOCUMENTO: 000000074876
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031124
       ESTADO: SP
         ITEM: 16261
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(4.24)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101378" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03466" AND DET_CODCLI = "10015607";
    DOCUMENTO: 000000101378
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10015607
       ESTADO: SP
         ITEM: 03466
         CFOP: 5910
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.786)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(66.67)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(66.67)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101379" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03212" AND DET_CODCLI = "10013901";
    DOCUMENTO: 000000101379
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10013901
       ESTADO: SP
         ITEM: 03212
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.22)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074877" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03259" AND DET_CODCLI = "10031125";
    DOCUMENTO: 000000074877
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031125
       ESTADO: SP
         ITEM: 03259
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.51)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074878" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "12528" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074878
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 12528
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(27.2168)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{28,58}, objFloatUtils.fStrToFloat('28,58')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{4,9}, objFloatUtils.fStrToFloat('4,9')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074880" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03136" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074880
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03136
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.54907696)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101380" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05501" AND DET_CODCLI = "00027209";
    DOCUMENTO: 000000101380
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00027209
       ESTADO: SP
         ITEM: 05501
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(12.7391810013)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074883" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03150" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074883
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03150
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.548)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074883" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03147" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074883
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03147
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.325)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074884" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05072" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074884
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 05072
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(15.92818823752)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074884" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04433" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074884
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04433
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(38.22359402589)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074885" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10268" AND DET_CODCLI = "10022128";
    DOCUMENTO: 000000074885
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10022128
       ESTADO: SP
         ITEM: 10268
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.61)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101381" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13909" AND DET_CODCLI = "10031010";
    DOCUMENTO: 000000101381
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031010
       ESTADO: SP
         ITEM: 13909
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(45.00944)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{45,01}, objFloatUtils.fStrToFloat('45,01')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{8,1}, objFloatUtils.fStrToFloat('8,1')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101381" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13905" AND DET_CODCLI = "10031010";
    DOCUMENTO: 000000101381
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031010
       ESTADO: SP
         ITEM: 13905
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(52.332)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{52,33}, objFloatUtils.fStrToFloat('52,33')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{9,42}, objFloatUtils.fStrToFloat('9,42')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101382" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06911" AND DET_CODCLI = "00000009";
    DOCUMENTO: 000000101382
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000009
       ESTADO: SP
         ITEM: 06911
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(175.64736)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{175,65}, objFloatUtils.fStrToFloat('175,65')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{31,62}, objFloatUtils.fStrToFloat('31,62')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117748" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04623" AND DET_CODCLI = "10022226";
    DOCUMENTO: 000000117748
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10022226
       ESTADO: SP
         ITEM: 04623
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(133.4822)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{133,48}, objFloatUtils.fStrToFloat('133,48')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{24,03}, objFloatUtils.fStrToFloat('24,03')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074886" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "14776" AND DET_CODCLI = "10022226";
    DOCUMENTO: 000000074886
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10022226
       ESTADO: SP
         ITEM: 14776
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(26.8)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.6956)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(8.5)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{29,08}, objFloatUtils.fStrToFloat('29,08')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,49}, objFloatUtils.fStrToFloat('3,49')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074886" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03139" AND DET_CODCLI = "10022226";
    DOCUMENTO: 000000074886
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10022226
       ESTADO: SP
         ITEM: 03139
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.3822704)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074887" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01996" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074887
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 01996
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.69)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{5,69}, objFloatUtils.fStrToFloat('5,69')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{1,02}, objFloatUtils.fStrToFloat('1,02')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074888" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03851" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074888
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03851
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(19.462)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{20,44}, objFloatUtils.fStrToFloat('20,44')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{3,5}, objFloatUtils.fStrToFloat('3,5')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074890" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04945" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074890
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04945
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(121.68)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{121,68}, objFloatUtils.fStrToFloat('121,68')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{21,9}, objFloatUtils.fStrToFloat('21,9')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074891" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15811" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074891
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15811
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.57)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117749" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15864" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000117749
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15864
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(48.4904)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{48,49}, objFloatUtils.fStrToFloat('48,49')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{8,73}, objFloatUtils.fStrToFloat('8,73')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117749" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15878" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000117749
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15878
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(49.9847)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{49,98}, objFloatUtils.fStrToFloat('49,98')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{9}, objFloatUtils.fStrToFloat('9')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074892" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15877" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074892
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15877
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(248.08)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{248,08}, objFloatUtils.fStrToFloat('248,08')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{44,65}, objFloatUtils.fStrToFloat('44,65')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074893" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15840" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074893
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 15840
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(45.17)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{45,17}, objFloatUtils.fStrToFloat('45,17')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{8,13}, objFloatUtils.fStrToFloat('8,13')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101384" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05000" AND DET_CODCLI = "10031129";
    DOCUMENTO: 000000101384
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031129
       ESTADO: SP
         ITEM: 05000
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(105.34)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{105,34}, objFloatUtils.fStrToFloat('105,34')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{18,96}, objFloatUtils.fStrToFloat('18,96')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101384" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11229" AND DET_CODCLI = "10031129";
    DOCUMENTO: 000000101384
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031129
       ESTADO: SP
         ITEM: 11229
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(32)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101384" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11202" AND DET_CODCLI = "10031129";
    DOCUMENTO: 000000101384
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031129
       ESTADO: SP
         ITEM: 11202
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(99.2)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{99,2}, objFloatUtils.fStrToFloat('99,2')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{17,86}, objFloatUtils.fStrToFloat('17,86')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000167;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101384" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17043" AND DET_CODCLI = "10031129";
    DOCUMENTO: 000000101384
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031129
       ESTADO: SP
         ITEM: 17043
         CFOP: 5405
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(11.36)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(0)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(0)
      .AliquotaDeOperacoesProprias(0)
      .IpiDeEntrada(0)
      .FreteDeEntrada(5)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000168;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117750" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "13899" AND DET_CODCLI = "00024305";
    DOCUMENTO: 000000117750
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00024305
       ESTADO: SP
         ITEM: 13899
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1420.7175)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{1420,72}, objFloatUtils.fStrToFloat('1420,72')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{255,73}, objFloatUtils.fStrToFloat('255,73')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000169;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101385" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11229" AND DET_CODCLI = "00024305";
    DOCUMENTO: 000000101385
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00024305
       ESTADO: SP
         ITEM: 11229
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(96)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000170;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101386" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04442" AND DET_CODCLI = "10027029";
    DOCUMENTO: 000000101386
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027029
       ESTADO: SP
         ITEM: 04442
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(243.93734108016)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(0)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(0)
      .AliquotaDeOperacoesProprias(0)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000171;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101386" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03984" AND DET_CODCLI = "10027029";
    DOCUMENTO: 000000101386
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10027029
       ESTADO: SP
         ITEM: 03984
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(189.28)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{198,74}, objFloatUtils.fStrToFloat('198,74')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{34,07}, objFloatUtils.fStrToFloat('34,07')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000172;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101387" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16702" AND DET_CODCLI = "10030613";
    DOCUMENTO: 000000101387
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030613
       ESTADO: SP
         ITEM: 16702
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(76)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{76}, objFloatUtils.fStrToFloat('76')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{13,68}, objFloatUtils.fStrToFloat('13,68')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000173;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074894" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05325" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074894
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 05325
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.7)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000174;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101388" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00295" AND DET_CODCLI = "10031131";
    DOCUMENTO: 000000101388
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031131
       ESTADO: SP
         ITEM: 00295
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(555.44)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(5)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000175;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101389" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17046" AND DET_CODCLI = "00043358";
    DOCUMENTO: 000000101389
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00043358
       ESTADO: SP
         ITEM: 17046
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.976)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(2)
      .FreteDeEntrada(5)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000176;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117751" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15863" AND DET_CODCLI = "10031130";
    DOCUMENTO: 000000117751
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10031130
       ESTADO: SP
         ITEM: 15863
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(193.8671)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{193,87}, objFloatUtils.fStrToFloat('193,87')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{34,9}, objFloatUtils.fStrToFloat('34,9')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000177;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117751" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15880" AND DET_CODCLI = "10031130";
    DOCUMENTO: 000000117751
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10031130
       ESTADO: SP
         ITEM: 15880
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(58.7486)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{58,75}, objFloatUtils.fStrToFloat('58,75')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{10,58}, objFloatUtils.fStrToFloat('10,58')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000178;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101390" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13915" AND DET_CODCLI = "00000009";
    DOCUMENTO: 000000101390
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000009
       ESTADO: SP
         ITEM: 13915
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(120.62624)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{120,63}, objFloatUtils.fStrToFloat('120,63')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{21,71}, objFloatUtils.fStrToFloat('21,71')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000179;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074896" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "17042" AND DET_CODCLI = "10031131";
    DOCUMENTO: 000000074896
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10031131
       ESTADO: SP
         ITEM: 17042
         CFOP: 5405
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(34.08)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(0)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(0)
      .AliquotaDeOperacoesProprias(0)
      .IpiDeEntrada(0)
      .FreteDeEntrada(5)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000180;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101392" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13940" AND DET_CODCLI = "10008361";
    DOCUMENTO: 000000101392
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10008361
       ESTADO: SP
         ITEM: 13940
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(258.2888)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{258,29}, objFloatUtils.fStrToFloat('258,29')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{46,49}, objFloatUtils.fStrToFloat('46,49')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000181;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074898" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04365" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074898
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04365
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(10.8169456395)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000182;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074899" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03212" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074899
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03212
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.61)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000183;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101394" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05852" AND DET_CODCLI = "10000676";
    DOCUMENTO: 000000101394
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10000676
       ESTADO: SP
         ITEM: 05852
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(7.0690174542)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000184;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074900" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03817" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074900
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03817
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(40.7)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{40,7}, objFloatUtils.fStrToFloat('40,7')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{7,33}, objFloatUtils.fStrToFloat('7,33')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000185;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101395" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03771" AND DET_CODCLI = "10031134";
    DOCUMENTO: 000000101395
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10031134
       ESTADO: SP
         ITEM: 03771
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(59.7698)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{59,77}, objFloatUtils.fStrToFloat('59,77')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{10,76}, objFloatUtils.fStrToFloat('10,76')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000186;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074901" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04874" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074901
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04874
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.74976)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000187;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01245" AND DET_CODCLI = "10018555";
    DOCUMENTO: 000000101396
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018555
       ESTADO: SP
         ITEM: 01245
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(29.17264)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(2)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000188;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01248" AND DET_CODCLI = "10018555";
    DOCUMENTO: 000000101396
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018555
       ESTADO: SP
         ITEM: 01248
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(16.02496)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(2)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000189;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16260" AND DET_CODCLI = "10018555";
    DOCUMENTO: 000000101396
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018555
       ESTADO: SP
         ITEM: 16260
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(16.72)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000190;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03132" AND DET_CODCLI = "10018555";
    DOCUMENTO: 000000101396
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018555
       ESTADO: SP
         ITEM: 03132
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.09815392)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000191;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01243" AND DET_CODCLI = "10018555";
    DOCUMENTO: 000000101396
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10018555
       ESTADO: SP
         ITEM: 01243
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(43.33952)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{43,34}, objFloatUtils.fStrToFloat('43,34')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{7,8}, objFloatUtils.fStrToFloat('7,8')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000192;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101397" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01587" AND DET_CODCLI = "10029035";
    DOCUMENTO: 000000101397
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10029035
       ESTADO: SP
         ITEM: 01587
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(265.88)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{265,88}, objFloatUtils.fStrToFloat('265,88')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{47,86}, objFloatUtils.fStrToFloat('47,86')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000193;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101397" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12350" AND DET_CODCLI = "10029035";
    DOCUMENTO: 000000101397
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10029035
       ESTADO: SP
         ITEM: 12350
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(33.384)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{35,05}, objFloatUtils.fStrToFloat('35,05')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{6,01}, objFloatUtils.fStrToFloat('6,01')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000194;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101397" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03150" AND DET_CODCLI = "10029035";
    DOCUMENTO: 000000101397
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10029035
       ESTADO: SP
         ITEM: 03150
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.387)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000195;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101402" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04882" AND DET_CODCLI = "10011731";
    DOCUMENTO: 000000101402
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10011731
       ESTADO: SP
         ITEM: 04882
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(388.71)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{388,71}, objFloatUtils.fStrToFloat('388,71')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{69,97}, objFloatUtils.fStrToFloat('69,97')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000196;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101402" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10678" AND DET_CODCLI = "10011731";
    DOCUMENTO: 000000101402
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10011731
       ESTADO: SP
         ITEM: 10678
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(90.32)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{94,84}, objFloatUtils.fStrToFloat('94,84')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{16,26}, objFloatUtils.fStrToFloat('16,26')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000197;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101402" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14634" AND DET_CODCLI = "10011731";
    DOCUMENTO: 000000101402
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10011731
       ESTADO: SP
         ITEM: 14634
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(27.976)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000198;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101402" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00107" AND DET_CODCLI = "10011731";
    DOCUMENTO: 000000101402
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10011731
       ESTADO: SP
         ITEM: 00107
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(13.0152)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(10)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000199;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101403" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11477" AND DET_CODCLI = "10026926";
    DOCUMENTO: 000000101403
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026926
       ESTADO: SP
         ITEM: 11477
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(162.5)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{162,5}, objFloatUtils.fStrToFloat('162,5')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{29,25}, objFloatUtils.fStrToFloat('29,25')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000200;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101405" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02231" AND DET_CODCLI = "00014216";
    DOCUMENTO: 000000101405
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00014216
       ESTADO: SP
         ITEM: 02231
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(322.63168)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{322,63}, objFloatUtils.fStrToFloat('322,63')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{58,07}, objFloatUtils.fStrToFloat('58,07')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000201;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101406" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01183" AND DET_CODCLI = "10015849";
    DOCUMENTO: 000000101406
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10015849
       ESTADO: SP
         ITEM: 01183
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(57.53776)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{60,41}, objFloatUtils.fStrToFloat('60,41')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{10,36}, objFloatUtils.fStrToFloat('10,36')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000202;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074906" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10725" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074906
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 10725
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(8.94)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000203;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074908" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03213" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074908
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03213
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.13)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000204;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074908" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03256" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074908
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03256
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.97)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000205;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074909" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "06226" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074909
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 06226
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(6.18)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{6,18}, objFloatUtils.fStrToFloat('6,18')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{1,11}, objFloatUtils.fStrToFloat('1,11')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000206;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101407" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03853" AND DET_CODCLI = "10001429";
    DOCUMENTO: 000000101407
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10001429
       ESTADO: MS
         ITEM: 03853
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(57.4)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000207;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101408" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03466" AND DET_CODCLI = "10015607";
    DOCUMENTO: 000000101408
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10015607
       ESTADO: SP
         ITEM: 03466
         CFOP: 5910
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.262)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(66.67)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(66.67)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000208;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101408" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06439" AND DET_CODCLI = "10015607";
    DOCUMENTO: 000000101408
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10015607
       ESTADO: SP
         ITEM: 06439
         CFOP: 5910
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: BR}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(4.99)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(12)
      .AliquotaDeOperacoesProprias(12)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000209;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074911" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10160" AND DET_CODCLI = "10030057";
    DOCUMENTO: 000000074911
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10030057
       ESTADO: SP
         ITEM: 10160
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(11.2518)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(25)
      .AliquotaDeOperacoesProprias(25)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000210;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074911" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03164" AND DET_CODCLI = "10030057";
    DOCUMENTO: 000000074911
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10030057
       ESTADO: SP
         ITEM: 03164
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.28164)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000211;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074911" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03166" AND DET_CODCLI = "10030057";
    DOCUMENTO: 000000074911
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10030057
       ESTADO: SP
         ITEM: 03166
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.208)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000212;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117752" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04619" AND DET_CODCLI = "10025203";
    DOCUMENTO: 000000117752
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10025203
       ESTADO: SP
         ITEM: 04619
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(115.0424)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{115,04}, objFloatUtils.fStrToFloat('115,04')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{20,71}, objFloatUtils.fStrToFloat('20,71')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000213;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101411" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10393" AND DET_CODCLI = "10025203";
    DOCUMENTO: 000000101411
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10025203
       ESTADO: SP
         ITEM: 10393
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(24.94)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(2)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000214;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101411" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16261" AND DET_CODCLI = "10025203";
    DOCUMENTO: 000000101411
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10025203
       ESTADO: SP
         ITEM: 16261
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(12.72)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000215;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117753" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04626" AND DET_CODCLI = "10031048";
    DOCUMENTO: 000000117753
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10031048
       ESTADO: SP
         ITEM: 04626
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(706.68)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{706,68}, objFloatUtils.fStrToFloat('706,68')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{127,2}, objFloatUtils.fStrToFloat('127,2')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000216;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074913" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04871" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074913
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04871
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(5.43456)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(6)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000217;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101413" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01129" AND DET_CODCLI = "10011253";
    DOCUMENTO: 000000101413
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10011253
       ESTADO: SP
         ITEM: 01129
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(75.09936)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{75,1}, objFloatUtils.fStrToFloat('75,1')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{13,52}, objFloatUtils.fStrToFloat('13,52')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000218;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101413" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04079" AND DET_CODCLI = "10011253";
    DOCUMENTO: 000000101413
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10011253
       ESTADO: SP
         ITEM: 04079
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(3.86073792)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000219;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074914" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13907" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074914
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 13907
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(13.88464)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{13,88}, objFloatUtils.fStrToFloat('13,88')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{2,5}, objFloatUtils.fStrToFloat('2,5')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000220;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074915" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "17320" AND DET_CODCLI = "10029804";
    DOCUMENTO: 000000074915
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10029804
       ESTADO: SP
         ITEM: 17320
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(59)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{59}, objFloatUtils.fStrToFloat('59')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{10,62}, objFloatUtils.fStrToFloat('10,62')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000221;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074916" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03751" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074916
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03751
         CFOP: 5405
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(2.072)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(2.18)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{2,07}, objFloatUtils.fStrToFloat('2,07')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0,37}, objFloatUtils.fStrToFloat('0,37')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000222;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117754" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "16154" AND DET_CODCLI = "00037136";
    DOCUMENTO: 000000117754
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00037136
       ESTADO: SP
         ITEM: 16154
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(222.9879)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{222,99}, objFloatUtils.fStrToFloat('222,99')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{40,14}, objFloatUtils.fStrToFloat('40,14')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000223;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000101414" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11229" AND DET_CODCLI = "00037136";
    DOCUMENTO: 000000101414
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037136
       ESTADO: SP
         ITEM: 11229
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(64)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(0)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000224;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074917" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03984" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074917
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 03984
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(47.32)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(5)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{49,69}, objFloatUtils.fStrToFloat('49,69')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{8,52}, objFloatUtils.fStrToFloat('8,52')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000225;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074919" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04898" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074919
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 04898
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(23.9)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{23,9}, objFloatUtils.fStrToFloat('23,9')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{4,3}, objFloatUtils.fStrToFloat('4,3')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000226;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000074921" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "17265" AND DET_CODCLI = "00007800";
    DOCUMENTO: 000000074921
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00007800
       ESTADO: SP
         ITEM: 17265
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(False)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(1.7)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(0)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(18)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure Test001CHUVEIRAO.REGRA_STCUSTOAQUISICAO_001CHUVEIRAO_000227;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000117755" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "15878" AND DET_CODCLI = "10014807";
    DOCUMENTO: 000000117755
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 10014807
       ESTADO: SP
         ITEM: 15878
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: EUC
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoSTCustoAquisicao;
  AParametros: IParametrosCalculoSTCustoAquisicao;
Begin

  AParametros :=
    TParametrosCalculoSTCustoAquisicao.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributaria(True)
      .ClienteConsumidorFinal(True)
      .PrecoDeCompraComDescontos(53.9376)
      .ModeloCalculoSubstituicaoDeOperacoesProprias('1')
      .PercetualBaseIcmsDoFornecedor(100)
      .IvaDoFornecedor(1.58)
      .PercetualBaseSTDoFornecedor(100)
      .AliquotaDeSubstituicaoTributaria(0)
      .AliquotaDeIcms(18)
      .AliquotaDeOperacoesProprias(18)
      .IpiDeEntrada(0)
      .FreteDeEntrada(0)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(False);

  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.CalcularValorSTCustoAquisicao(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{53,94}, objFloatUtils.fStrToFloat('53,94')) And
           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{9,71}, objFloatUtils.fStrToFloat('9,71')));
end;




initialization
  RegisterTest(Test001CHUVEIRAO.Suite);
end.

