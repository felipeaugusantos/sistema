unit TestFaturamento.Impostos.Calculos.St.CS_FERRAMENTAS_Lj001_20191025;

{--------------------------------------------------------------------------
                    RESUMO ST                 
--------------------------------------------------------------------------
Empresa            : 001 - CS FERRAMENTAS LTDA
Período Selecionado: 25/10/2019 até 25/10/2019
Data do Processo   : 29/10/2019 
Hora Inicio        : 10:03:54
Hora Fim           : 10:10:28
Tempo Total        : 00:06:33
                                           
Total Registros    : 410
Total Processados  : 410
Total de Acertos   : 372
Total de Erros     : 4
Total Ignorados    : 0
Total Duplicados   : 34
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.St,
Faturamento.Impostos.Tipos.St,
Faturamento.Impostos.Interfaces.St;

type
TestCSFERRAMENTAS = class(TTestCase)
strict private
private




published

Procedure REGRA_ST_CSFERRAMENTAS_000001;
Procedure REGRA_ST_CSFERRAMENTAS_000002;
Procedure REGRA_ST_CSFERRAMENTAS_000003;
Procedure REGRA_ST_CSFERRAMENTAS_000004;
Procedure REGRA_ST_CSFERRAMENTAS_000005;
Procedure REGRA_ST_CSFERRAMENTAS_000006;
Procedure REGRA_ST_CSFERRAMENTAS_000007;
Procedure REGRA_ST_CSFERRAMENTAS_000008;
Procedure REGRA_ST_CSFERRAMENTAS_000009;
Procedure REGRA_ST_CSFERRAMENTAS_000010;
Procedure REGRA_ST_CSFERRAMENTAS_000011;
Procedure REGRA_ST_CSFERRAMENTAS_000012;
Procedure REGRA_ST_CSFERRAMENTAS_000013;
Procedure REGRA_ST_CSFERRAMENTAS_000014;
Procedure REGRA_ST_CSFERRAMENTAS_000015;
Procedure REGRA_ST_CSFERRAMENTAS_000016;
Procedure REGRA_ST_CSFERRAMENTAS_000017;
Procedure REGRA_ST_CSFERRAMENTAS_000018;
Procedure REGRA_ST_CSFERRAMENTAS_000019;
Procedure REGRA_ST_CSFERRAMENTAS_000020;
Procedure REGRA_ST_CSFERRAMENTAS_000021;
Procedure REGRA_ST_CSFERRAMENTAS_000022;
Procedure REGRA_ST_CSFERRAMENTAS_000023;
Procedure REGRA_ST_CSFERRAMENTAS_000024;
Procedure REGRA_ST_CSFERRAMENTAS_000025;
Procedure REGRA_ST_CSFERRAMENTAS_000026;
Procedure REGRA_ST_CSFERRAMENTAS_000027;
Procedure REGRA_ST_CSFERRAMENTAS_000028;
Procedure REGRA_ST_CSFERRAMENTAS_000029;
Procedure REGRA_ST_CSFERRAMENTAS_000030;
Procedure REGRA_ST_CSFERRAMENTAS_000031;
Procedure REGRA_ST_CSFERRAMENTAS_000032;
Procedure REGRA_ST_CSFERRAMENTAS_000033;
Procedure REGRA_ST_CSFERRAMENTAS_000034;
Procedure REGRA_ST_CSFERRAMENTAS_000035;
Procedure REGRA_ST_CSFERRAMENTAS_000036;
Procedure REGRA_ST_CSFERRAMENTAS_000037;
Procedure REGRA_ST_CSFERRAMENTAS_000038;
Procedure REGRA_ST_CSFERRAMENTAS_000039;
Procedure REGRA_ST_CSFERRAMENTAS_000040;
Procedure REGRA_ST_CSFERRAMENTAS_000041;
Procedure REGRA_ST_CSFERRAMENTAS_000042;
Procedure REGRA_ST_CSFERRAMENTAS_000043;
Procedure REGRA_ST_CSFERRAMENTAS_000044;
Procedure REGRA_ST_CSFERRAMENTAS_000045;
Procedure REGRA_ST_CSFERRAMENTAS_000046;
Procedure REGRA_ST_CSFERRAMENTAS_000047;
Procedure REGRA_ST_CSFERRAMENTAS_000048;
Procedure REGRA_ST_CSFERRAMENTAS_000049;
Procedure REGRA_ST_CSFERRAMENTAS_000050;
Procedure REGRA_ST_CSFERRAMENTAS_000051;
Procedure REGRA_ST_CSFERRAMENTAS_000052;
Procedure REGRA_ST_CSFERRAMENTAS_000053;
Procedure REGRA_ST_CSFERRAMENTAS_000054;
Procedure REGRA_ST_CSFERRAMENTAS_000055;
Procedure REGRA_ST_CSFERRAMENTAS_000056;
Procedure REGRA_ST_CSFERRAMENTAS_000057;
Procedure REGRA_ST_CSFERRAMENTAS_000058;
Procedure REGRA_ST_CSFERRAMENTAS_000059;
Procedure REGRA_ST_CSFERRAMENTAS_000060;
Procedure REGRA_ST_CSFERRAMENTAS_000061;
Procedure REGRA_ST_CSFERRAMENTAS_000062;
Procedure REGRA_ST_CSFERRAMENTAS_000063;
Procedure REGRA_ST_CSFERRAMENTAS_000064;
Procedure REGRA_ST_CSFERRAMENTAS_000065;
Procedure REGRA_ST_CSFERRAMENTAS_000066;
Procedure REGRA_ST_CSFERRAMENTAS_000067;
Procedure REGRA_ST_CSFERRAMENTAS_000068;
Procedure REGRA_ST_CSFERRAMENTAS_000069;
Procedure REGRA_ST_CSFERRAMENTAS_000070;
Procedure REGRA_ST_CSFERRAMENTAS_000071;
Procedure REGRA_ST_CSFERRAMENTAS_000072;
Procedure REGRA_ST_CSFERRAMENTAS_000073;
Procedure REGRA_ST_CSFERRAMENTAS_000074;
Procedure REGRA_ST_CSFERRAMENTAS_000075;
Procedure REGRA_ST_CSFERRAMENTAS_000076;
Procedure REGRA_ST_CSFERRAMENTAS_000077;
Procedure REGRA_ST_CSFERRAMENTAS_000078;
Procedure REGRA_ST_CSFERRAMENTAS_000079;
Procedure REGRA_ST_CSFERRAMENTAS_000080;
Procedure REGRA_ST_CSFERRAMENTAS_000081;
Procedure REGRA_ST_CSFERRAMENTAS_000082;
Procedure REGRA_ST_CSFERRAMENTAS_000083;
Procedure REGRA_ST_CSFERRAMENTAS_000084;
Procedure REGRA_ST_CSFERRAMENTAS_000085;
Procedure REGRA_ST_CSFERRAMENTAS_000086;
Procedure REGRA_ST_CSFERRAMENTAS_000087;
Procedure REGRA_ST_CSFERRAMENTAS_000088;
Procedure REGRA_ST_CSFERRAMENTAS_000089;
Procedure REGRA_ST_CSFERRAMENTAS_000090;
Procedure REGRA_ST_CSFERRAMENTAS_000091;
Procedure REGRA_ST_CSFERRAMENTAS_000092;
Procedure REGRA_ST_CSFERRAMENTAS_000093;
Procedure REGRA_ST_CSFERRAMENTAS_000094;
Procedure REGRA_ST_CSFERRAMENTAS_000095;
Procedure REGRA_ST_CSFERRAMENTAS_000096;
Procedure REGRA_ST_CSFERRAMENTAS_000097;
Procedure REGRA_ST_CSFERRAMENTAS_000098;
Procedure REGRA_ST_CSFERRAMENTAS_000099;
Procedure REGRA_ST_CSFERRAMENTAS_000100;
Procedure REGRA_ST_CSFERRAMENTAS_000101;
Procedure REGRA_ST_CSFERRAMENTAS_000102;
Procedure REGRA_ST_CSFERRAMENTAS_000103;
Procedure REGRA_ST_CSFERRAMENTAS_000104;
Procedure REGRA_ST_CSFERRAMENTAS_000105;
Procedure REGRA_ST_CSFERRAMENTAS_000106;
Procedure REGRA_ST_CSFERRAMENTAS_000107;
Procedure REGRA_ST_CSFERRAMENTAS_000108;
Procedure REGRA_ST_CSFERRAMENTAS_000109;
Procedure REGRA_ST_CSFERRAMENTAS_000110;
Procedure REGRA_ST_CSFERRAMENTAS_000111;
Procedure REGRA_ST_CSFERRAMENTAS_000112;
Procedure REGRA_ST_CSFERRAMENTAS_000113;
Procedure REGRA_ST_CSFERRAMENTAS_000114;
Procedure REGRA_ST_CSFERRAMENTAS_000115;
Procedure REGRA_ST_CSFERRAMENTAS_000116;
Procedure REGRA_ST_CSFERRAMENTAS_000117;
Procedure REGRA_ST_CSFERRAMENTAS_000118;
Procedure REGRA_ST_CSFERRAMENTAS_000119;
Procedure REGRA_ST_CSFERRAMENTAS_000120;
Procedure REGRA_ST_CSFERRAMENTAS_000121;
Procedure REGRA_ST_CSFERRAMENTAS_000122;
Procedure REGRA_ST_CSFERRAMENTAS_000123;
Procedure REGRA_ST_CSFERRAMENTAS_000124;
Procedure REGRA_ST_CSFERRAMENTAS_000125;
Procedure REGRA_ST_CSFERRAMENTAS_000126;
Procedure REGRA_ST_CSFERRAMENTAS_000127;
Procedure REGRA_ST_CSFERRAMENTAS_000128;
Procedure REGRA_ST_CSFERRAMENTAS_000129;
Procedure REGRA_ST_CSFERRAMENTAS_000130;
Procedure REGRA_ST_CSFERRAMENTAS_000131;
Procedure REGRA_ST_CSFERRAMENTAS_000132;
Procedure REGRA_ST_CSFERRAMENTAS_000133;
Procedure REGRA_ST_CSFERRAMENTAS_000134;
Procedure REGRA_ST_CSFERRAMENTAS_000135;
Procedure REGRA_ST_CSFERRAMENTAS_000136;
Procedure REGRA_ST_CSFERRAMENTAS_000137;
Procedure REGRA_ST_CSFERRAMENTAS_000138;
Procedure REGRA_ST_CSFERRAMENTAS_000139;
Procedure REGRA_ST_CSFERRAMENTAS_000140;
Procedure REGRA_ST_CSFERRAMENTAS_000141;
Procedure REGRA_ST_CSFERRAMENTAS_000142;
Procedure REGRA_ST_CSFERRAMENTAS_000143;
Procedure REGRA_ST_CSFERRAMENTAS_000144;
Procedure REGRA_ST_CSFERRAMENTAS_000145;
Procedure REGRA_ST_CSFERRAMENTAS_000146;
Procedure REGRA_ST_CSFERRAMENTAS_000147;
Procedure REGRA_ST_CSFERRAMENTAS_000148;
Procedure REGRA_ST_CSFERRAMENTAS_000149;
Procedure REGRA_ST_CSFERRAMENTAS_000150;
Procedure REGRA_ST_CSFERRAMENTAS_000151;
Procedure REGRA_ST_CSFERRAMENTAS_000152;
Procedure REGRA_ST_CSFERRAMENTAS_000153;
Procedure REGRA_ST_CSFERRAMENTAS_000154;
Procedure REGRA_ST_CSFERRAMENTAS_000155;
Procedure REGRA_ST_CSFERRAMENTAS_000156;
Procedure REGRA_ST_CSFERRAMENTAS_000157;
Procedure REGRA_ST_CSFERRAMENTAS_000158;
Procedure REGRA_ST_CSFERRAMENTAS_000159;
Procedure REGRA_ST_CSFERRAMENTAS_000160;
Procedure REGRA_ST_CSFERRAMENTAS_000161;
Procedure REGRA_ST_CSFERRAMENTAS_000162;
Procedure REGRA_ST_CSFERRAMENTAS_000163;
Procedure REGRA_ST_CSFERRAMENTAS_000164;
Procedure REGRA_ST_CSFERRAMENTAS_000165;
Procedure REGRA_ST_CSFERRAMENTAS_000166;
Procedure REGRA_ST_CSFERRAMENTAS_000167;
Procedure REGRA_ST_CSFERRAMENTAS_000168;
Procedure REGRA_ST_CSFERRAMENTAS_000169;
Procedure REGRA_ST_CSFERRAMENTAS_000170;
Procedure REGRA_ST_CSFERRAMENTAS_000171;
Procedure REGRA_ST_CSFERRAMENTAS_000172;
Procedure REGRA_ST_CSFERRAMENTAS_000173;
Procedure REGRA_ST_CSFERRAMENTAS_000174;
Procedure REGRA_ST_CSFERRAMENTAS_000175;
Procedure REGRA_ST_CSFERRAMENTAS_000176;
Procedure REGRA_ST_CSFERRAMENTAS_000177;
Procedure REGRA_ST_CSFERRAMENTAS_000178;
Procedure REGRA_ST_CSFERRAMENTAS_000179;
Procedure REGRA_ST_CSFERRAMENTAS_000180;
Procedure REGRA_ST_CSFERRAMENTAS_000181;
Procedure REGRA_ST_CSFERRAMENTAS_000182;
Procedure REGRA_ST_CSFERRAMENTAS_000183;
Procedure REGRA_ST_CSFERRAMENTAS_000184;
Procedure REGRA_ST_CSFERRAMENTAS_000185;
Procedure REGRA_ST_CSFERRAMENTAS_000186;
Procedure REGRA_ST_CSFERRAMENTAS_000187;
Procedure REGRA_ST_CSFERRAMENTAS_000188;
Procedure REGRA_ST_CSFERRAMENTAS_000189;
Procedure REGRA_ST_CSFERRAMENTAS_000190;
Procedure REGRA_ST_CSFERRAMENTAS_000191;
Procedure REGRA_ST_CSFERRAMENTAS_000192;
Procedure REGRA_ST_CSFERRAMENTAS_000193;
Procedure REGRA_ST_CSFERRAMENTAS_000194;
Procedure REGRA_ST_CSFERRAMENTAS_000195;
Procedure REGRA_ST_CSFERRAMENTAS_000196;
Procedure REGRA_ST_CSFERRAMENTAS_000197;
Procedure REGRA_ST_CSFERRAMENTAS_000198;
Procedure REGRA_ST_CSFERRAMENTAS_000199;
Procedure REGRA_ST_CSFERRAMENTAS_000200;
Procedure REGRA_ST_CSFERRAMENTAS_000201;
Procedure REGRA_ST_CSFERRAMENTAS_000202;
Procedure REGRA_ST_CSFERRAMENTAS_000203;
Procedure REGRA_ST_CSFERRAMENTAS_000204;
Procedure REGRA_ST_CSFERRAMENTAS_000205;
Procedure REGRA_ST_CSFERRAMENTAS_000206;
Procedure REGRA_ST_CSFERRAMENTAS_000207;
Procedure REGRA_ST_CSFERRAMENTAS_000208;
Procedure REGRA_ST_CSFERRAMENTAS_000209;
Procedure REGRA_ST_CSFERRAMENTAS_000210;
Procedure REGRA_ST_CSFERRAMENTAS_000211;
Procedure REGRA_ST_CSFERRAMENTAS_000212;
Procedure REGRA_ST_CSFERRAMENTAS_000213;
Procedure REGRA_ST_CSFERRAMENTAS_000214;
Procedure REGRA_ST_CSFERRAMENTAS_000215;
Procedure REGRA_ST_CSFERRAMENTAS_000216;
Procedure REGRA_ST_CSFERRAMENTAS_000217;
Procedure REGRA_ST_CSFERRAMENTAS_000218;
Procedure REGRA_ST_CSFERRAMENTAS_000219;
Procedure REGRA_ST_CSFERRAMENTAS_000220;
Procedure REGRA_ST_CSFERRAMENTAS_000221;
Procedure REGRA_ST_CSFERRAMENTAS_000222;
Procedure REGRA_ST_CSFERRAMENTAS_000223;
Procedure REGRA_ST_CSFERRAMENTAS_000224;
Procedure REGRA_ST_CSFERRAMENTAS_000225;
Procedure REGRA_ST_CSFERRAMENTAS_000226;
Procedure REGRA_ST_CSFERRAMENTAS_000227;
Procedure REGRA_ST_CSFERRAMENTAS_000228;
Procedure REGRA_ST_CSFERRAMENTAS_000229;
Procedure REGRA_ST_CSFERRAMENTAS_000230;
Procedure REGRA_ST_CSFERRAMENTAS_000231;
Procedure REGRA_ST_CSFERRAMENTAS_000232;
Procedure REGRA_ST_CSFERRAMENTAS_000233;
Procedure REGRA_ST_CSFERRAMENTAS_000234;
Procedure REGRA_ST_CSFERRAMENTAS_000235;
Procedure REGRA_ST_CSFERRAMENTAS_000236;
Procedure REGRA_ST_CSFERRAMENTAS_000237;
Procedure REGRA_ST_CSFERRAMENTAS_000238;
Procedure REGRA_ST_CSFERRAMENTAS_000239;
Procedure REGRA_ST_CSFERRAMENTAS_000240;
Procedure REGRA_ST_CSFERRAMENTAS_000241;
Procedure REGRA_ST_CSFERRAMENTAS_000242;
Procedure REGRA_ST_CSFERRAMENTAS_000243;
Procedure REGRA_ST_CSFERRAMENTAS_000244;
Procedure REGRA_ST_CSFERRAMENTAS_000245;
Procedure REGRA_ST_CSFERRAMENTAS_000246;
Procedure REGRA_ST_CSFERRAMENTAS_000247;
Procedure REGRA_ST_CSFERRAMENTAS_000248;
Procedure REGRA_ST_CSFERRAMENTAS_000249;
Procedure REGRA_ST_CSFERRAMENTAS_000250;
Procedure REGRA_ST_CSFERRAMENTAS_000251;
Procedure REGRA_ST_CSFERRAMENTAS_000252;
Procedure REGRA_ST_CSFERRAMENTAS_000253;
Procedure REGRA_ST_CSFERRAMENTAS_000254;
Procedure REGRA_ST_CSFERRAMENTAS_000255;
Procedure REGRA_ST_CSFERRAMENTAS_000256;
Procedure REGRA_ST_CSFERRAMENTAS_000257;
Procedure REGRA_ST_CSFERRAMENTAS_000258;
Procedure REGRA_ST_CSFERRAMENTAS_000259;
Procedure REGRA_ST_CSFERRAMENTAS_000260;
Procedure REGRA_ST_CSFERRAMENTAS_000261;
Procedure REGRA_ST_CSFERRAMENTAS_000262;
Procedure REGRA_ST_CSFERRAMENTAS_000263;
Procedure REGRA_ST_CSFERRAMENTAS_000264;
Procedure REGRA_ST_CSFERRAMENTAS_000265;
Procedure REGRA_ST_CSFERRAMENTAS_000266;
Procedure REGRA_ST_CSFERRAMENTAS_000267;
Procedure REGRA_ST_CSFERRAMENTAS_000268;
Procedure REGRA_ST_CSFERRAMENTAS_000269;
Procedure REGRA_ST_CSFERRAMENTAS_000270;
Procedure REGRA_ST_CSFERRAMENTAS_000271;
Procedure REGRA_ST_CSFERRAMENTAS_000272;
Procedure REGRA_ST_CSFERRAMENTAS_000273;
Procedure REGRA_ST_CSFERRAMENTAS_000274;
Procedure REGRA_ST_CSFERRAMENTAS_000275;
Procedure REGRA_ST_CSFERRAMENTAS_000276;
Procedure REGRA_ST_CSFERRAMENTAS_000277;
Procedure REGRA_ST_CSFERRAMENTAS_000278;
Procedure REGRA_ST_CSFERRAMENTAS_000279;
Procedure REGRA_ST_CSFERRAMENTAS_000280;
Procedure REGRA_ST_CSFERRAMENTAS_000281;
Procedure REGRA_ST_CSFERRAMENTAS_000282;
Procedure REGRA_ST_CSFERRAMENTAS_000283;
Procedure REGRA_ST_CSFERRAMENTAS_000284;
Procedure REGRA_ST_CSFERRAMENTAS_000285;
Procedure REGRA_ST_CSFERRAMENTAS_000286;
Procedure REGRA_ST_CSFERRAMENTAS_000287;
Procedure REGRA_ST_CSFERRAMENTAS_000288;
Procedure REGRA_ST_CSFERRAMENTAS_000289;
Procedure REGRA_ST_CSFERRAMENTAS_000290;
Procedure REGRA_ST_CSFERRAMENTAS_000291;
Procedure REGRA_ST_CSFERRAMENTAS_000292;
Procedure REGRA_ST_CSFERRAMENTAS_000293;
Procedure REGRA_ST_CSFERRAMENTAS_000294;
Procedure REGRA_ST_CSFERRAMENTAS_000295;
Procedure REGRA_ST_CSFERRAMENTAS_000296;
Procedure REGRA_ST_CSFERRAMENTAS_000297;
Procedure REGRA_ST_CSFERRAMENTAS_000298;
Procedure REGRA_ST_CSFERRAMENTAS_000299;
Procedure REGRA_ST_CSFERRAMENTAS_000300;
Procedure REGRA_ST_CSFERRAMENTAS_000301;
Procedure REGRA_ST_CSFERRAMENTAS_000302;
Procedure REGRA_ST_CSFERRAMENTAS_000303;
Procedure REGRA_ST_CSFERRAMENTAS_000304;
Procedure REGRA_ST_CSFERRAMENTAS_000305;
Procedure REGRA_ST_CSFERRAMENTAS_000306;
Procedure REGRA_ST_CSFERRAMENTAS_000307;
Procedure REGRA_ST_CSFERRAMENTAS_000308;
Procedure REGRA_ST_CSFERRAMENTAS_000309;
Procedure REGRA_ST_CSFERRAMENTAS_000310;
Procedure REGRA_ST_CSFERRAMENTAS_000311;
Procedure REGRA_ST_CSFERRAMENTAS_000312;
Procedure REGRA_ST_CSFERRAMENTAS_000313;
Procedure REGRA_ST_CSFERRAMENTAS_000314;
Procedure REGRA_ST_CSFERRAMENTAS_000315;
Procedure REGRA_ST_CSFERRAMENTAS_000316;
Procedure REGRA_ST_CSFERRAMENTAS_000317;
Procedure REGRA_ST_CSFERRAMENTAS_000318;
Procedure REGRA_ST_CSFERRAMENTAS_000319;
Procedure REGRA_ST_CSFERRAMENTAS_000320;
Procedure REGRA_ST_CSFERRAMENTAS_000321;
Procedure REGRA_ST_CSFERRAMENTAS_000322;
Procedure REGRA_ST_CSFERRAMENTAS_000323;
Procedure REGRA_ST_CSFERRAMENTAS_000324;
Procedure REGRA_ST_CSFERRAMENTAS_000325;
Procedure REGRA_ST_CSFERRAMENTAS_000326;
Procedure REGRA_ST_CSFERRAMENTAS_000327;
Procedure REGRA_ST_CSFERRAMENTAS_000328;
Procedure REGRA_ST_CSFERRAMENTAS_000329;
Procedure REGRA_ST_CSFERRAMENTAS_000330;
Procedure REGRA_ST_CSFERRAMENTAS_000331;
Procedure REGRA_ST_CSFERRAMENTAS_000332;
Procedure REGRA_ST_CSFERRAMENTAS_000333;
Procedure REGRA_ST_CSFERRAMENTAS_000334;
Procedure REGRA_ST_CSFERRAMENTAS_000335;
Procedure REGRA_ST_CSFERRAMENTAS_000336;
Procedure REGRA_ST_CSFERRAMENTAS_000337;
Procedure REGRA_ST_CSFERRAMENTAS_000338;
Procedure REGRA_ST_CSFERRAMENTAS_000339;
Procedure REGRA_ST_CSFERRAMENTAS_000340;
Procedure REGRA_ST_CSFERRAMENTAS_000341;
Procedure REGRA_ST_CSFERRAMENTAS_000342;
Procedure REGRA_ST_CSFERRAMENTAS_000343;
Procedure REGRA_ST_CSFERRAMENTAS_000344;
Procedure REGRA_ST_CSFERRAMENTAS_000345;
Procedure REGRA_ST_CSFERRAMENTAS_000346;
Procedure REGRA_ST_CSFERRAMENTAS_000347;
Procedure REGRA_ST_CSFERRAMENTAS_000348;
Procedure REGRA_ST_CSFERRAMENTAS_000349;
Procedure REGRA_ST_CSFERRAMENTAS_000350;
Procedure REGRA_ST_CSFERRAMENTAS_000351;
Procedure REGRA_ST_CSFERRAMENTAS_000352;
Procedure REGRA_ST_CSFERRAMENTAS_000353;
Procedure REGRA_ST_CSFERRAMENTAS_000354;
Procedure REGRA_ST_CSFERRAMENTAS_000355;
Procedure REGRA_ST_CSFERRAMENTAS_000356;
Procedure REGRA_ST_CSFERRAMENTAS_000357;
Procedure REGRA_ST_CSFERRAMENTAS_000358;
Procedure REGRA_ST_CSFERRAMENTAS_000359;
Procedure REGRA_ST_CSFERRAMENTAS_000360;
Procedure REGRA_ST_CSFERRAMENTAS_000361;
Procedure REGRA_ST_CSFERRAMENTAS_000362;
Procedure REGRA_ST_CSFERRAMENTAS_000363;
Procedure REGRA_ST_CSFERRAMENTAS_000364;
Procedure REGRA_ST_CSFERRAMENTAS_000365;
Procedure REGRA_ST_CSFERRAMENTAS_000366;
Procedure REGRA_ST_CSFERRAMENTAS_000367;
Procedure REGRA_ST_CSFERRAMENTAS_000368;
Procedure REGRA_ST_CSFERRAMENTAS_000369;
Procedure REGRA_ST_CSFERRAMENTAS_000370;
Procedure REGRA_ST_CSFERRAMENTAS_000371;
Procedure REGRA_ST_CSFERRAMENTAS_000372;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestCSFERRAMENTAS.SetUp;
begin
end;

procedure TestCSFERRAMENTAS.TearDown;
begin
end;

Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036145" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "18292" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036145
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 18292
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.95)
      .ValorDoIcmsDoEstado(4.95)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(27.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036145" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08502" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036145
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 08502
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.83)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(20)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036146" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "29595" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036146
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 29595
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.05)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.39)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036146" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15579" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036146
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 15579
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.01)
      .ValorDoIcmsDoEstado(10.01)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(23.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(55.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216849" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29447" AND DET_CODCLI = "00045195";
    DOCUMENTO: 000000216849
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00045195
       ESTADO: SP
         ITEM: 29447
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(43.2)
      .ValorDoIcmsDoEstado(43.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(126)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(240)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216850" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31747" AND DET_CODCLI = "00022132";
    DOCUMENTO: 000000216850
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00022132
       ESTADO: SP
         ITEM: 31747
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(28.98)
      .ValorDoIcmsDoEstado(25.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(54.32)
      .ValorDoIpiDoItem(21)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(140)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036147" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "20942" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036147
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 20942
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.51)
      .ValorDoIcmsDoEstado(8.51)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(8.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(47.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036148" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "18501" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036148
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 18501
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(42.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216851" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30782" AND DET_CODCLI = "00043806";
    DOCUMENTO: 000000216851
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00043806
       ESTADO: SP
         ITEM: 30782
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(15.66)
      .ValorDoIcmsDoEstado(15.66)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(44.46)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(87)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19731" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 19731
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(67.17)
      .ValorDoIcmsDoEstado(67.17)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(687.35)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8263)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1679.35)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{3067}, objFloatUtils.fStrToFloat('3067')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{484,89}, objFloatUtils.fStrToFloat('484,89')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19555" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 19555
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(76.7)
      .ValorDoIcmsDoEstado(76.7)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(837.53)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8263)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1917.53)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{3501,99}, objFloatUtils.fStrToFloat('3501,99')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{553,66}, objFloatUtils.fStrToFloat('553,66')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30461" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 30461
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(22.73)
      .ValorDoIcmsDoEstado(22.73)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(212.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8263)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(568.19)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{1037,69}, objFloatUtils.fStrToFloat('1037,69')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{164,05}, objFloatUtils.fStrToFloat('164,05')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19597" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 19597
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.79)
      .ValorDoIcmsDoEstado(4.79)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(42.29)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8263)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(119.69)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{218,59}, objFloatUtils.fStrToFloat('218,59')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{34,56}, objFloatUtils.fStrToFloat('34,56')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20939" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 20939
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(13.12)
      .ValorDoIcmsDoEstado(13.12)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(111.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8263)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(328)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{599,03}, objFloatUtils.fStrToFloat('599,03')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{94,71}, objFloatUtils.fStrToFloat('94,71')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31183" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 31183
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.17)
      .ValorDoIcmsDoEstado(7.17)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(52.54)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(179.14)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27110" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 27110
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.91)
      .ValorDoIcmsDoEstado(4.91)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(37.37)
      .ValorDoIpiDoItem(9.81)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(122.67)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27111" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 27111
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.13)
      .ValorDoIcmsDoEstado(7.13)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(54.38)
      .ValorDoIpiDoItem(14.27)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(178.33)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26334" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 26334
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.27)
      .ValorDoIcmsDoEstado(2.27)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.79)
      .ValorDoIpiDoItem(4.54)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(56.72)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19578" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 19578
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.53)
      .ValorDoIcmsDoEstado(10.53)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(101.41)
      .ValorDoIpiDoItem(21.06)
      .ValorDoIva(1.8029)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(263.21)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{512,51}, objFloatUtils.fStrToFloat('512,51')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{81,72}, objFloatUtils.fStrToFloat('81,72')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26335" AND DET_CODCLI = "00049067";
    DOCUMENTO: 000000216852
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00049067
       ESTADO: PR
         ITEM: 26335
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.27)
      .ValorDoIcmsDoEstado(2.27)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.18)
      .ValorDoIpiDoItem(4.54)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(56.72)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216853" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19731" AND DET_CODCLI = "00069292";
    DOCUMENTO: 000000216853
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00069292
       ESTADO: MG
         ITEM: 19731
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.37)
      .ValorDoIcmsDoEstado(2.37)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(22.71)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59.21)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{100,51}, objFloatUtils.fStrToFloat('100,51')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{15,72}, objFloatUtils.fStrToFloat('15,72')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216853" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20944" AND DET_CODCLI = "00069292";
    DOCUMENTO: 000000216853
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00069292
       ESTADO: MG
         ITEM: 20944
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(66.73)
      .ValorDoIcmsDoEstado(66.73)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(678.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1668.29)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{2832,09}, objFloatUtils.fStrToFloat('2832,09')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{443,05}, objFloatUtils.fStrToFloat('443,05')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036149" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15598" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036149
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 15598
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(5.59)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(20.95)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(31.05)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036149" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02742" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036149
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02742
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.2)
      .ValorDoIcmsDoEstado(1.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.66)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216854" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35072" AND DET_CODCLI = "00074665";
    DOCUMENTO: 000000216854
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074665
       ESTADO: RJ
         ITEM: 35072
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(95.51)
      .ValorDoIcmsDoEstado(95.51)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(326.76)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(795.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216855" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "22430" AND DET_CODCLI = "00074666";
    DOCUMENTO: 000000216855
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074666
       ESTADO: MG
         ITEM: 22430
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(80.15)
      .ValorDoIcmsDoEstado(80.15)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(347.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(667.92)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216856" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21514" AND DET_CODCLI = "00074661";
    DOCUMENTO: 000000216856
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074661
       ESTADO: MS
         ITEM: 21514
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(20.93)
      .ValorDoIcmsDoEstado(20.93)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(141.73)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(299)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216857" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32852" AND DET_CODCLI = "00074662";
    DOCUMENTO: 000000216857
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074662
       ESTADO: RS
         ITEM: 32852
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(129.58)
      .ValorDoIcmsDoEstado(129.58)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(542.38)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1079.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216858" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21619" AND DET_CODCLI = "00074645";
    DOCUMENTO: 000000216858
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074645
       ESTADO: RJ
         ITEM: 21619
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(63.71)
      .ValorDoIcmsDoEstado(63.71)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(271.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(530.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036150" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "27048" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036150
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 27048
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(20.67)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(31.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036150" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "33391" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036150
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 33391
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(9.63)
      .ValorDoIcmsDoEstado(9.63)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(35.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(53.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036150" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04626" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036150
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 04626
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.43)
      .ValorDoIcmsDoEstado(3.43)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(13.2)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(19.05)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216860" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14220" AND DET_CODCLI = "00074684";
    DOCUMENTO: 000000216860
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074684
       ESTADO: SP
         ITEM: 14220
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(334.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(499)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216861" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "22430" AND DET_CODCLI = "00074675";
    DOCUMENTO: 000000216861
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074675
       ESTADO: SP
         ITEM: 22430
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(120.23)
      .ValorDoIcmsDoEstado(120.23)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(347.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(667.92)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036151" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00788" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036151
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00788
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(18.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(29.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036152" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "18593" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036152
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 18593
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(34.56)
      .ValorDoIcmsDoEstado(34.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(101.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(192)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216862" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21505" AND DET_CODCLI = "00074686";
    DOCUMENTO: 000000216862
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074686
       ESTADO: SP
         ITEM: 21505
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(8.27)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(21.08)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(45.96)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216862" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01438" AND DET_CODCLI = "00074686";
    DOCUMENTO: 000000216862
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074686
       ESTADO: SP
         ITEM: 01438
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.38)
      .ValorDoIcmsDoEstado(1.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(7.68)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216862" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07311" AND DET_CODCLI = "00074686";
    DOCUMENTO: 000000216862
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074686
       ESTADO: SP
         ITEM: 07311
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(491.14)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(719)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216862" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27050" AND DET_CODCLI = "00074686";
    DOCUMENTO: 000000216862
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074686
       ESTADO: SP
         ITEM: 27050
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(37.75)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(57.34)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216862" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03305" AND DET_CODCLI = "00074686";
    DOCUMENTO: 000000216862
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074686
       ESTADO: SP
         ITEM: 03305
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.68)
      .ValorDoIcmsDoEstado(4.68)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(18.62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(26)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30786" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216863
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 30786
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(16.16)
      .ValorDoIcmsDoEstado(16.16)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(51.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(89.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30788" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216863
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 30788
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.08)
      .ValorDoIcmsDoEstado(8.08)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(25.59)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(44.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30789" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216863
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 30789
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(24.25)
      .ValorDoIcmsDoEstado(24.25)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(76.77)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(134.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30790" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216863
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 30790
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(48.49)
      .ValorDoIcmsDoEstado(48.49)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(153.54)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(269.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30791" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216863
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 30791
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(40.41)
      .ValorDoIcmsDoEstado(40.41)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(127.95)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(224.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216864" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30790" AND DET_CODCLI = "00052586";
    DOCUMENTO: 000000216864
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00052586
       ESTADO: SP
         ITEM: 30790
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(32.33)
      .ValorDoIcmsDoEstado(32.33)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(102.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(179.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216865" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35138" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216865
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 35138
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(17.28)
      .ValorDoIcmsDoEstado(17.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(41.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(96)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216865" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13255" AND DET_CODCLI = "00041676";
    DOCUMENTO: 000000216865
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041676
       ESTADO: SP
         ITEM: 13255
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.22)
      .ValorDoIcmsDoEstado(2.22)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(7.78)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(18.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216866" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29069" AND DET_CODCLI = "00074688";
    DOCUMENTO: 000000216866
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074688
       ESTADO: SP
         ITEM: 29069
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.67)
      .ValorDoIcmsDoEstado(4.32)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.97)
      .ValorDoIpiDoItem(1.92)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(24)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216867" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29786" AND DET_CODCLI = "00074671";
    DOCUMENTO: 000000216867
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074671
       ESTADO: GO
         ITEM: 29786
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(33.96)
      .ValorDoIcmsDoEstado(33.96)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(586.21)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(849)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036153" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "19555" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036153
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 19555
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.68)
      .ValorDoIcmsDoEstado(1.68)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.05)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.35)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036153" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "20893" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036153
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 20893
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(27.12)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(46.35)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216868" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28397" AND DET_CODCLI = "00074659";
    DOCUMENTO: 000000216868
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074659
       ESTADO: PR
         ITEM: 28397
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.03)
      .ValorDoIcmsDoEstado(3.03)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(48.63)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(75.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216870" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00074663";
    DOCUMENTO: 000000216870
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074663
       ESTADO: MG
         ITEM: 18965
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(44)
      .ValorDoIcmsDoEstado(44)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(662.26)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1099.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216871" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00074668";
    DOCUMENTO: 000000216871
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074668
       ESTADO: GO
         ITEM: 18965
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(40)
      .ValorDoIcmsDoEstado(40)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(561.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(999.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216873" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00074679";
    DOCUMENTO: 000000216873
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074679
       ESTADO: SP
         ITEM: 18965
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(87.99)
      .ValorDoIcmsDoEstado(87.99)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(561.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(999.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216874" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30574" AND DET_CODCLI = "00074676";
    DOCUMENTO: 000000216874
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074676
       ESTADO: SP
         ITEM: 30574
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(57.96)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(96.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216875" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27336" AND DET_CODCLI = "00074669";
    DOCUMENTO: 000000216875
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074669
       ESTADO: SP
         ITEM: 27336
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.3)
      .ValorDoIcmsDoEstado(6.3)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(21.41)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(34.98)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216876" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07621" AND DET_CODCLI = "00074660";
    DOCUMENTO: 000000216876
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074660
       ESTADO: GO
         ITEM: 07621
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.31)
      .ValorDoIcmsDoEstado(3.31)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(56.55)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(82.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216877" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32208" AND DET_CODCLI = "00074673";
    DOCUMENTO: 000000216877
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074673
       ESTADO: SP
         ITEM: 32208
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(43.12)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(78.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216877" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21519" AND DET_CODCLI = "00074673";
    DOCUMENTO: 000000216877
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074673
       ESTADO: SP
         ITEM: 21519
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(199.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(319.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31747" AND DET_CODCLI = "00074670";
    DOCUMENTO: 000000216878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074670
       ESTADO: MS
         ITEM: 31747
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.99)
      .ValorDoIcmsDoEstado(5.21)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(48.22)
      .ValorDoIpiDoItem(19.53)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(130.23)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33189" AND DET_CODCLI = "00000665";
    DOCUMENTO: 000000216879
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000665
       ESTADO: SP
         ITEM: 33189
         CFOP: 5102
CODIGO FISCAL: 120
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(23.61)
      .ValorDoIcmsDoEstado(20.29)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(95.03)
      .ValorDoIpiDoItem(18.44)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(230.56)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03357" AND DET_CODCLI = "00000665";
    DOCUMENTO: 000000216879
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000665
       ESTADO: SP
         ITEM: 03357
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(48.37)
      .ValorDoIcmsDoEstado(48.37)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(126.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(268.74)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036154" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04170" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036154
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 04170
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.62)
      .ValorDoIcmsDoEstado(1.62)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(3.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036154" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "21640" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036154
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 21640
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.31)
      .ValorDoIcmsDoEstado(7.31)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(18.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(40.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216880" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33970" AND DET_CODCLI = "00074681";
    DOCUMENTO: 000000216880
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074681
       ESTADO: SP
         ITEM: 33970
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(22.88)
      .ValorDoIcmsDoEstado(22.88)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(150.79)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(260.03)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216880" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31747" AND DET_CODCLI = "00074681";
    DOCUMENTO: 000000216880
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074681
       ESTADO: SP
         ITEM: 31747
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(17.98)
      .ValorDoIcmsDoEstado(15.63)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(34.32)
      .ValorDoIpiDoItem(13.03)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(86.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036155" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "07797" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036155
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 07797
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.99)
      .ValorDoIcmsDoEstado(0.99)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036156" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00967" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036156
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00967
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.54)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(7.97)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036156" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02601" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036156
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02601
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(13.14)
      .ValorDoIcmsDoEstado(13.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(51.33)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(73)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216881" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20927" AND DET_CODCLI = "00023306";
    DOCUMENTO: 000000216881
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00023306
       ESTADO: SP
         ITEM: 20927
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(148.74)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(300)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216882" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34392" AND DET_CODCLI = "00005701";
    DOCUMENTO: 000000216882
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005701
       ESTADO: SP
         ITEM: 34392
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.56)
      .ValorDoIcmsDoEstado(0.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.63)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036157" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "34455" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036157
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 34455
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(44.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036158" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "31942" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036158
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 31942
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(232.31)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(329)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216883" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30336" AND DET_CODCLI = "00051195";
    DOCUMENTO: 000000216883
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00051195
       ESTADO: SP
         ITEM: 30336
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.18)
      .ValorDoIcmsDoEstado(7.18)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(20.22)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(39.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216884" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04101" AND DET_CODCLI = "00051195";
    DOCUMENTO: 000000216884
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00051195
       ESTADO: SP
         ITEM: 04101
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(21.6)
      .ValorDoIcmsDoEstado(21.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(120)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216884" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06339" AND DET_CODCLI = "00051195";
    DOCUMENTO: 000000216884
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00051195
       ESTADO: SP
         ITEM: 06339
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(62.1)
      .ValorDoIcmsDoEstado(62.1)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(179)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(345)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216884" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10721" AND DET_CODCLI = "00051195";
    DOCUMENTO: 000000216884
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00051195
       ESTADO: SP
         ITEM: 10721
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(26.55)
      .ValorDoIcmsDoEstado(26.55)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(71)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(147.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216884" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28194" AND DET_CODCLI = "00051195";
    DOCUMENTO: 000000216884
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00051195
       ESTADO: SP
         ITEM: 28194
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(25.49)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(88.04)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(141.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216885" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04704" AND DET_CODCLI = "00068931";
    DOCUMENTO: 000000216885
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00068931
       ESTADO: SP
         ITEM: 04704
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(42.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(64)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216886" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34255" AND DET_CODCLI = "00068851";
    DOCUMENTO: 000000216886
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00068851
       ESTADO: MG
         ITEM: 34255
         CFOP: 6404
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.63)
      .ValorDoIcmsDoEstado(14.63)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(117.8)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(365.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{365,8}, objFloatUtils.fStrToFloat('365,8')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{51,21}, objFloatUtils.fStrToFloat('51,21')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216886" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19729" AND DET_CODCLI = "00068851";
    DOCUMENTO: 000000216886
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00068851
       ESTADO: MG
         ITEM: 19729
         CFOP: 6404
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(79.21)
      .ValorDoIcmsDoEstado(79.21)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(701.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1980.18)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{1980,18}, objFloatUtils.fStrToFloat('1980,18')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{277,22}, objFloatUtils.fStrToFloat('277,22')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216886" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18601" AND DET_CODCLI = "00068851";
    DOCUMENTO: 000000216886
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00068851
       ESTADO: MG
         ITEM: 18601
         CFOP: 6404
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(399.05)
      .ValorDoIcmsDoEstado(399.05)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2385.42)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3325.42)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216887" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12965" AND DET_CODCLI = "00020879";
    DOCUMENTO: 000000216887
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00020879
       ESTADO: SP
         ITEM: 12965
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.4)
      .ValorDoIcmsDoEstado(14.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(29)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(80)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06189" AND DET_CODCLI = "00074630";
    DOCUMENTO: 000000216888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074630
       ESTADO: PB
         ITEM: 06189
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.88)
      .ValorDoIcmsDoEstado(7.88)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(113.71)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(196.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06141" AND DET_CODCLI = "00074630";
    DOCUMENTO: 000000216888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074630
       ESTADO: PB
         ITEM: 06141
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.56)
      .ValorDoIcmsDoEstado(8.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(132.54)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(214.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036159" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "30461" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036159
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 30461
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.95)
      .ValorDoIcmsDoEstado(2.95)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.07)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(16.39)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036159" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11085" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036159
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 11085
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.06)
      .ValorDoIcmsDoEstado(1.06)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.17)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036159" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01874" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036159
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01874
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036159" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05548" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036159
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 05548
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.28)
      .ValorDoIcmsDoEstado(0.28)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1.04)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036159" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02545" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036159
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02545
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.72)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(4.95)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036159" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "27011" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036159
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 27011
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(11.47)
      .ValorDoIcmsDoEstado(11.47)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(35.57)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(63.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216889" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11725" AND DET_CODCLI = "00026759";
    DOCUMENTO: 000000216889
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00026759
       ESTADO: SP
         ITEM: 11725
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(205.33)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(300)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216889" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30184" AND DET_CODCLI = "00026759";
    DOCUMENTO: 000000216889
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00026759
       ESTADO: SP
         ITEM: 30184
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.14)
      .ValorDoIcmsDoEstado(4.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.99)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(23)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216889" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29247" AND DET_CODCLI = "00026759";
    DOCUMENTO: 000000216889
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00026759
       ESTADO: SP
         ITEM: 29247
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.63)
      .ValorDoIcmsDoEstado(0.63)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.61)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036160" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00551" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036160
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00551
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.53)
      .ValorDoIcmsDoEstado(1.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.11)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216890" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18591" AND DET_CODCLI = "00061820";
    DOCUMENTO: 000000216890
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00061820
       ESTADO: SP
         ITEM: 18591
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(34.99)
      .ValorDoIcmsDoEstado(34.99)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(113.94)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(194.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216890" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31475" AND DET_CODCLI = "00061820";
    DOCUMENTO: 000000216890
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00061820
       ESTADO: SP
         ITEM: 31475
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.17)
      .ValorDoIcmsDoEstado(1.17)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.22)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216891" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19757" AND DET_CODCLI = "00005392";
    DOCUMENTO: 000000216891
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005392
       ESTADO: SP
         ITEM: 19757
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.49)
      .ValorDoIcmsDoEstado(1.49)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.2)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.25)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216892" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05436" AND DET_CODCLI = "00005392";
    DOCUMENTO: 000000216892
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005392
       ESTADO: SP
         ITEM: 05436
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.69)
      .ValorDoIcmsDoEstado(10.69)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(29.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34751" AND DET_CODCLI = "00033969";
    DOCUMENTO: 000000216893
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00033969
       ESTADO: SP
         ITEM: 34751
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(13.5)
      .ValorDoIcmsDoEstado(13.5)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(20.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(75)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20429" AND DET_CODCLI = "00033969";
    DOCUMENTO: 000000216893
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00033969
       ESTADO: SP
         ITEM: 20429
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(30.42)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(105.53)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(169)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17874" AND DET_CODCLI = "00033969";
    DOCUMENTO: 000000216893
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00033969
       ESTADO: SP
         ITEM: 17874
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(1.58)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(5.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07361" AND DET_CODCLI = "00033969";
    DOCUMENTO: 000000216893
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00033969
       ESTADO: SP
         ITEM: 07361
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(1.85)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(4.95)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(10.25)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06824" AND DET_CODCLI = "00033969";
    DOCUMENTO: 000000216893
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00033969
       ESTADO: SP
         ITEM: 06824
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(5.55)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(20.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31473" AND DET_CODCLI = "00004802";
    DOCUMENTO: 000000216894
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004802
       ESTADO: SP
         ITEM: 31473
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.62)
      .ValorDoIcmsDoEstado(1.62)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30371" AND DET_CODCLI = "00004802";
    DOCUMENTO: 000000216894
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004802
       ESTADO: SP
         ITEM: 30371
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(25.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(45.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17044" AND DET_CODCLI = "00004802";
    DOCUMENTO: 000000216894
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004802
       ESTADO: SP
         ITEM: 17044
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.99)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.44)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04651" AND DET_CODCLI = "00004802";
    DOCUMENTO: 000000216894
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004802
       ESTADO: SP
         ITEM: 04651
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(16.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14808" AND DET_CODCLI = "00004802";
    DOCUMENTO: 000000216894
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004802
       ESTADO: SP
         ITEM: 14808
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.35)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04646" AND DET_CODCLI = "00004802";
    DOCUMENTO: 000000216894
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004802
       ESTADO: SP
         ITEM: 04646
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(10.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(17)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036161" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "06401" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036161
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06401
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(24)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29174" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 29174
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.73)
      .ValorDoIcmsDoEstado(1.73)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.73)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.61)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25654" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 25654
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.07)
      .ValorDoIcmsDoEstado(1)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.74)
      .ValorDoIpiDoItem(0.44)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5.53)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25655" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 25655
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.17)
      .ValorDoIcmsDoEstado(1.08)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.78)
      .ValorDoIpiDoItem(0.48)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.01)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25657" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 25657
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.51)
      .ValorDoIcmsDoEstado(1.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.79)
      .ValorDoIpiDoItem(0.62)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(7.76)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25664" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 25664
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.92)
      .ValorDoIcmsDoEstado(1.77)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.41)
      .ValorDoIpiDoItem(0.79)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30771" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 30771
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.31)
      .ValorDoIcmsDoEstado(2.31)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.29)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(12.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34751" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 34751
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.33)
      .ValorDoIcmsDoEstado(6.33)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.16)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(35.16)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32305" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 32305
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.78)
      .ValorDoIcmsDoEstado(0.78)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.83)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15646" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 15646
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(429.03)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(600.43)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26334" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 26334
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.21)
      .ValorDoIcmsDoEstado(1.12)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.84)
      .ValorDoIpiDoItem(0.74)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.31)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26335" AND DET_CODCLI = "00074592";
    DOCUMENTO: 000000216895
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074592
       ESTADO: SP
         ITEM: 26335
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.21)
      .ValorDoIcmsDoEstado(1.12)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.88)
      .ValorDoIpiDoItem(0.74)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.31)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216896" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31747" AND DET_CODCLI = "00006817";
    DOCUMENTO: 000000216896
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006817
       ESTADO: SP
         ITEM: 31747
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(24.84)
      .ValorDoIcmsDoEstado(21.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(34.32)
      .ValorDoIpiDoItem(18)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(120)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036162" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "19193" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036162
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 19193
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.71)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(15.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216897" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15646" AND DET_CODCLI = "00041469";
    DOCUMENTO: 000000216897
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00041469
       ESTADO: SP
         ITEM: 15646
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(115.02)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(447.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(639)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036163" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "32305" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036163
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 32305
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.8)
      .ValorDoIcmsDoEstado(0.8)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.89)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216898" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14546" AND DET_CODCLI = "00045258";
    DOCUMENTO: 000000216898
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00045258
       ESTADO: SP
         ITEM: 14546
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.71)
      .ValorDoIcmsDoEstado(8.71)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22.85)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(48.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216899" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31303" AND DET_CODCLI = "00030363";
    DOCUMENTO: 000000216899
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00030363
       ESTADO: SP
         ITEM: 31303
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(25.67)
      .ValorDoIcmsDoEstado(25.67)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(103.82)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(142.61)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216900" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17806" AND DET_CODCLI = "00012285";
    DOCUMENTO: 000000216900
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00012285
       ESTADO: SP
         ITEM: 17806
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2601.46)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(29287.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(73.34)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(29559.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{73,34}, objFloatUtils.fStrToFloat('73,34')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216900" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16056" AND DET_CODCLI = "00012285";
    DOCUMENTO: 000000216900
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00012285
       ESTADO: SP
         ITEM: 16056
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2177.44)
      .ValorDoIcmsDoEstado(2177.44)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(34209.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38880)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036164" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "35482" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036164
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 35482
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(19.13)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036165" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04443" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036165
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 04443
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(100.98)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(348.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(561)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216901" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19571" AND DET_CODCLI = "00044629";
    DOCUMENTO: 000000216901
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044629
       ESTADO: SP
         ITEM: 19571
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.04)
      .ValorDoIcmsDoEstado(4.04)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.46)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.46)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216901" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19573" AND DET_CODCLI = "00044629";
    DOCUMENTO: 000000216901
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044629
       ESTADO: SP
         ITEM: 19573
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.04)
      .ValorDoIcmsDoEstado(4.04)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.45)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.46)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216901" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31039" AND DET_CODCLI = "00044629";
    DOCUMENTO: 000000216901
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044629
       ESTADO: SP
         ITEM: 31039
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.53)
      .ValorDoIcmsDoEstado(2.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(14.08)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216902" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16121" AND DET_CODCLI = "00001465";
    DOCUMENTO: 000000216902
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001465
       ESTADO: SP
         ITEM: 16121
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: OE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(9.25)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(44.82)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(51.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216904" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06930" AND DET_CODCLI = "00010966";
    DOCUMENTO: 000000216904
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00010966
       ESTADO: SP
         ITEM: 06930
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(13.75)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(49.97)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(76.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216904" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29238" AND DET_CODCLI = "00010966";
    DOCUMENTO: 000000216904
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00010966
       ESTADO: SP
         ITEM: 29238
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(14.36)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(52.74)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(79.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216904" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18593" AND DET_CODCLI = "00010966";
    DOCUMENTO: 000000216904
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00010966
       ESTADO: SP
         ITEM: 18593
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(32.94)
      .ValorDoIcmsDoEstado(32.94)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(101.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(183)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216904" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32301" AND DET_CODCLI = "00010966";
    DOCUMENTO: 000000216904
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00010966
       ESTADO: SP
         ITEM: 32301
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(8.46)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(39.96)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(70.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216904" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13962" AND DET_CODCLI = "00010966";
    DOCUMENTO: 000000216904
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00010966
       ESTADO: SP
         ITEM: 13962
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(3.55)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(13.29)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(19.74)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00204" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 00204
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.16)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.19)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00214" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 00214
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.67)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5.82)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05212" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 05212
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(13.32)
      .ValorDoIcmsDoEstado(13.32)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(43.39)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(73.99)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27805" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 27805
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.6)
      .ValorDoIcmsDoEstado(3.6)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(8.89)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(20)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07143" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 07143
         CFOP: 5656
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(21.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18214" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 18214
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.23)
      .ValorDoIcmsDoEstado(4.23)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.95)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(23.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05123" AND DET_CODCLI = "00074701";
    DOCUMENTO: 000000216905
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074701
       ESTADO: SP
         ITEM: 05123
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(746.2)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1169)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036166" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "29260" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036166
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 29260
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2.34)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(7.72)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216906" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35454" AND DET_CODCLI = "00058565";
    DOCUMENTO: 000000216906
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00058565
       ESTADO: SP
         ITEM: 35454
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.62)
      .ValorDoIcmsDoEstado(10.62)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(31.27)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000023620" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "001" AND DET_CODITE = "13305" AND DET_CODCLI = "00000674";
    DOCUMENTO: 000000023620
      ESPECIE: AJ
      EMPRESA: 001
      CLIENTE: 00000674
       ESTADO: SP
         ITEM: 13305
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.61)
      .ValorDoIcmsDoEstado(0.61)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.38)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3.38)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216907" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29514" AND DET_CODCLI = "00040605";
    DOCUMENTO: 000000216907
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00040605
       ESTADO: SP
         ITEM: 29514
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(132.3)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(513.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(735)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216907" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01438" AND DET_CODCLI = "00040605";
    DOCUMENTO: 000000216907
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00040605
       ESTADO: SP
         ITEM: 01438
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.35)
      .ValorDoIcmsDoEstado(5.35)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(13.35)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(29.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216907" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29866" AND DET_CODCLI = "00040605";
    DOCUMENTO: 000000216907
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00040605
       ESTADO: SP
         ITEM: 29866
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.87)
      .ValorDoIcmsDoEstado(12.87)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(45.2)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(71.52)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216907" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06824" AND DET_CODCLI = "00040605";
    DOCUMENTO: 000000216907
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00040605
       ESTADO: SP
         ITEM: 06824
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(16.65)
      .ValorDoIcmsDoEstado(16.65)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(60.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(92.52)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216908" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29468" AND DET_CODCLI = "00043346";
    DOCUMENTO: 000000216908
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00043346
       ESTADO: SP
         ITEM: 29468
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(410.4)
      .ValorDoIcmsDoEstado(410.4)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1933.2)
      .ValorDoIpiDoItem(114)
      .ValorDoIva(1.67)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2280)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{3997,98}, objFloatUtils.fStrToFloat('3997,98')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{309,24}, objFloatUtils.fStrToFloat('309,24')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30783" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 30783
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(37.8)
      .ValorDoIcmsDoEstado(37.8)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(111.15)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(210)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35280" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 35280
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(22.68)
      .ValorDoIcmsDoEstado(22.68)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(66.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(126)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05351" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 05351
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.25)
      .ValorDoIcmsDoEstado(2.25)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(12.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05492" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 05492
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.07)
      .ValorDoIcmsDoEstado(2.07)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.76)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(11.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11185" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 11185
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.18)
      .ValorDoIcmsDoEstado(2.18)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.34)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(12.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11085" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 11085
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.16)
      .ValorDoIcmsDoEstado(2.16)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.34)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(12)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05064" AND DET_CODCLI = "00042411";
    DOCUMENTO: 000000216909
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00042411
       ESTADO: SP
         ITEM: 05064
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.84)
      .ValorDoIcmsDoEstado(4.84)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(26.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000167;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216910" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19555" AND DET_CODCLI = "00005801";
    DOCUMENTO: 000000216910
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005801
       ESTADO: SP
         ITEM: 19555
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(18.18)
      .ValorDoIcmsDoEstado(18.18)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22.14)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(100.98)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000168;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216911" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30236" AND DET_CODCLI = "00028840";
    DOCUMENTO: 000000216911
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00028840
       ESTADO: SP
         ITEM: 30236
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(187.38)
      .ValorDoIcmsDoEstado(187.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(598.92)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1041)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000169;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216911" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32572" AND DET_CODCLI = "00028840";
    DOCUMENTO: 000000216911
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00028840
       ESTADO: SP
         ITEM: 32572
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(55.08)
      .ValorDoIcmsDoEstado(55.08)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(163.41)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(306)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000170;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216911" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05212" AND DET_CODCLI = "00028840";
    DOCUMENTO: 000000216911
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00028840
       ESTADO: SP
         ITEM: 05212
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(39.95)
      .ValorDoIcmsDoEstado(39.95)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(130.17)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(221.97)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000171;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216911" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19948" AND DET_CODCLI = "00028840";
    DOCUMENTO: 000000216911
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00028840
       ESTADO: SP
         ITEM: 19948
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(105.46)
      .ValorDoIcmsDoEstado(105.46)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(574.11)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(799)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000172;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216912" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20075" AND DET_CODCLI = "00074503";
    DOCUMENTO: 000000216912
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074503
       ESTADO: SP
         ITEM: 20075
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(40.88)
      .ValorDoIcmsDoEstado(40.88)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(110.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(227.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000173;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216912" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06480" AND DET_CODCLI = "00074503";
    DOCUMENTO: 000000216912
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074503
       ESTADO: SP
         ITEM: 06480
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(114.77)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(159.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000174;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216913" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06481" AND DET_CODCLI = "00074667";
    DOCUMENTO: 000000216913
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074667
       ESTADO: CE
         ITEM: 06481
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(15.66)
      .ValorDoIcmsDoEstado(15.66)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(152.44)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(223.65)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000175;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216914" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27528" AND DET_CODCLI = "00074624";
    DOCUMENTO: 000000216914
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074624
       ESTADO: PE
         ITEM: 27528
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.05)
      .ValorDoIcmsDoEstado(4.05)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(43.55)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(57.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000176;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216915" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32230" AND DET_CODCLI = "00074658";
    DOCUMENTO: 000000216915
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074658
       ESTADO: PR
         ITEM: 32230
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(15.56)
      .ValorDoIcmsDoEstado(15.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(243.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(389)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000177;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216916" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34751" AND DET_CODCLI = "00062447";
    DOCUMENTO: 000000216916
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00062447
       ESTADO: SP
         ITEM: 34751
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.75)
      .ValorDoIcmsDoEstado(6.75)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(10.25)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(37.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000178;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216916" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01117" AND DET_CODCLI = "00062447";
    DOCUMENTO: 000000216916
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00062447
       ESTADO: SP
         ITEM: 01117
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.46)
      .ValorDoIcmsDoEstado(2.46)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.65)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000179;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216917" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00564" AND DET_CODCLI = "00074702";
    DOCUMENTO: 000000216917
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074702
       ESTADO: SP
         ITEM: 00564
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(17.35)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(28.73)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000180;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216918" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19599" AND DET_CODCLI = "00066343";
    DOCUMENTO: 000000216918
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00066343
       ESTADO: SP
         ITEM: 19599
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.53)
      .ValorDoIcmsDoEstado(2.34)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.39)
      .ValorDoIpiDoItem(1.04)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000181;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216919" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33970" AND DET_CODCLI = "00025374";
    DOCUMENTO: 000000216919
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00025374
       ESTADO: SP
         ITEM: 33970
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(25.43)
      .ValorDoIcmsDoEstado(25.43)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(150.79)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(289)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000182;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036167" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04473" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036167
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 04473
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.66)
      .ValorDoIcmsDoEstado(1.66)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.47)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.2)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000183;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216920" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32216" AND DET_CODCLI = "00074265";
    DOCUMENTO: 000000216920
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074265
       ESTADO: SP
         ITEM: 32216
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.23)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(14)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000184;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216920" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35487" AND DET_CODCLI = "00074265";
    DOCUMENTO: 000000216920
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074265
       ESTADO: SP
         ITEM: 35487
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(29.42)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(55.34)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000185;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216921" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18278" AND DET_CODCLI = "00001477";
    DOCUMENTO: 000000216921
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001477
       ESTADO: SP
         ITEM: 18278
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(19.86)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(59.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(110.33)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000186;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216922" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01438" AND DET_CODCLI = "00001477";
    DOCUMENTO: 000000216922
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001477
       ESTADO: SP
         ITEM: 01438
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.78)
      .ValorDoIcmsDoEstado(1.78)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.45)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000187;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216922" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01697" AND DET_CODCLI = "00001477";
    DOCUMENTO: 000000216922
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001477
       ESTADO: SP
         ITEM: 01697
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(11.25)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(39.8)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(62.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000188;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216922" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17044" AND DET_CODCLI = "00001477";
    DOCUMENTO: 000000216922
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001477
       ESTADO: SP
         ITEM: 17044
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(23.96)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(53.74)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000189;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216922" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02553" AND DET_CODCLI = "00001477";
    DOCUMENTO: 000000216922
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001477
       ESTADO: SP
         ITEM: 02553
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(35.94)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(56.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000190;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216922" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30523" AND DET_CODCLI = "00001477";
    DOCUMENTO: 000000216922
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001477
       ESTADO: SP
         ITEM: 30523
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(15.08)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(49.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(83.75)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000191;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216923" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34893" AND DET_CODCLI = "00009859";
    DOCUMENTO: 000000216923
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00009859
       ESTADO: SP
         ITEM: 34893
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.75)
      .ValorDoIcmsDoEstado(2.75)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(15.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000192;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000850" AND DET_ESPDOC = "UC" AND DET_CODEMP = "001" AND DET_CODITE = "02451" AND DET_CODCLI = "00000674";
    DOCUMENTO: 000000000850
      ESPECIE: UC
      EMPRESA: 001
      CLIENTE: 00000674
       ESTADO: SP
         ITEM: 02451
         CFOP: 5556
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: UC}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(1.66)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(9.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.24)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000193;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036168" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00549" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036168
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00549
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.91)
      .ValorDoIcmsDoEstado(1.91)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.54)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(10.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000194;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036168" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "34860" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036168
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 34860
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.41)
      .ValorDoIcmsDoEstado(0.41)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.21)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000195;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036169" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "19828" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036169
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 19828
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.77)
      .ValorDoIcmsDoEstado(1.77)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.98)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.81)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000196;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036169" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "29866" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036169
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 29866
         CFOP: 5102
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.06)
      .ValorDoIcmsDoEstado(6.06)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(33.65)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000197;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216924" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00564" AND DET_CODCLI = "00063731";
    DOCUMENTO: 000000216924
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00063731
       ESTADO: SP
         ITEM: 00564
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(16.49)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(27.87)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000198;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216924" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32890" AND DET_CODCLI = "00063731";
    DOCUMENTO: 000000216924
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00063731
       ESTADO: SP
         ITEM: 32890
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.62)
      .ValorDoIcmsDoEstado(2.42)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.16)
      .ValorDoIpiDoItem(1.08)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.46)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000199;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216925" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14569" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216925
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 14569
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(54.22)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(485.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(73.34)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(616.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{73,34}, objFloatUtils.fStrToFloat('73,34')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000200;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216925" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14571" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216925
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 14571
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(27.92)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(249.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(73.34)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(317.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{73,34}, objFloatUtils.fStrToFloat('73,34')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000201;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216925" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26728" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216925
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 26728
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.05)
      .ValorDoIcmsDoEstado(12.05)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(79.07)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(100.41)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000202;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216925" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03979" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216925
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 03979
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(865.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(953.94)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000203;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216925" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26681" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216925
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 26681
         CFOP: 5409
CODIGO FISCAL: 560
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(52.72)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(398.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(439.32)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000204;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216926" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34751" AND DET_CODCLI = "00024459";
    DOCUMENTO: 000000216926
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00024459
       ESTADO: SP
         ITEM: 34751
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(23.4)
      .ValorDoIcmsDoEstado(23.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(41)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(130)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000205;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216927" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18262" AND DET_CODCLI = "00005392";
    DOCUMENTO: 000000216927
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005392
       ESTADO: SP
         ITEM: 18262
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.62)
      .ValorDoIcmsDoEstado(10.62)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(26.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000206;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216927" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02237" AND DET_CODCLI = "00005392";
    DOCUMENTO: 000000216927
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005392
       ESTADO: SP
         ITEM: 02237
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(22.5)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(72.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(125)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000207;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216927" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02383" AND DET_CODCLI = "00005392";
    DOCUMENTO: 000000216927
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005392
       ESTADO: SP
         ITEM: 02383
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(15.07)
      .ValorDoIcmsDoEstado(15.07)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(45.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(83.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000208;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216927" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06935" AND DET_CODCLI = "00005392";
    DOCUMENTO: 000000216927
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005392
       ESTADO: SP
         ITEM: 06935
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.43)
      .ValorDoIcmsDoEstado(5.43)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(13.46)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30.18)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000209;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036170" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "35111" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036170
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 35111
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(39.65)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000210;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036170" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05971" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036170
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 05971
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(21.64)
      .ValorDoIcmsDoEstado(21.64)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(153.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(245.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000211;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036170" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "35115" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036170
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 35115
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(14.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(21.55)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000212;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036170" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "35113" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036170
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 35113
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(14.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000213;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216928" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06048" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216928
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 06048
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(11.26)
      .ValorDoIcmsDoEstado(11.26)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(73.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(93.84)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000214;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216929" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15646" AND DET_CODCLI = "00074704";
    DOCUMENTO: 000000216929
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074704
       ESTADO: SP
         ITEM: 15646
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(447.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(619)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000215;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216929" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06401" AND DET_CODCLI = "00074704";
    DOCUMENTO: 000000216929
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074704
       ESTADO: SP
         ITEM: 06401
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(23)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000216;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036171" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "23856" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036171
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 23856
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(11.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000217;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216930" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18591" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216930
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 18591
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(56.38)
      .ValorDoIcmsDoEstado(56.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(227.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(313.2)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000218;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216930" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02377" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216930
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 02377
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.74)
      .ValorDoIcmsDoEstado(14.74)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(59.58)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(81.88)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000219;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216930" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02381" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000216930
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: SP
         ITEM: 02381
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: TE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.28)
      .ValorDoIcmsDoEstado(7.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(29.41)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(40.43)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000220;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036172" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "18504" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036172
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 18504
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(45.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(67.98)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000221;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036172" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "18505" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036172
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 18505
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(41.44)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000222;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036172" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04754" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036172
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 04754
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(9.64)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(35.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(53.58)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000223;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036172" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01435" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036172
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01435
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0.72)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1.81)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(4.02)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000224;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216931" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17662" AND DET_CODCLI = "00074680";
    DOCUMENTO: 000000216931
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074680
       ESTADO: MG
         ITEM: 17662
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(26.77)
      .ValorDoIcmsDoEstado(26.77)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(467.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(669.27)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000225;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216932" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14871" AND DET_CODCLI = "00000975";
    DOCUMENTO: 000000216932
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000975
       ESTADO: SP
         ITEM: 14871
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.79)
      .ValorDoIcmsDoEstado(7.79)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(34.41)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(64.95)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000226;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216932" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18593" AND DET_CODCLI = "00000975";
    DOCUMENTO: 000000216932
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000975
       ESTADO: SP
         ITEM: 18593
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(34.56)
      .ValorDoIcmsDoEstado(34.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(101.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(192)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000227;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216933" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28050" AND DET_CODCLI = "00074705";
    DOCUMENTO: 000000216933
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074705
       ESTADO: SP
         ITEM: 28050
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(157.35)
      .ValorDoIcmsDoEstado(157.35)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1225.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1788.05)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000228;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216934" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04461" AND DET_CODCLI = "00074706";
    DOCUMENTO: 000000216934
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074706
       ESTADO: SP
         ITEM: 04461
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(597.85)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(840)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000229;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216935" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00482" AND DET_CODCLI = "00074707";
    DOCUMENTO: 000000216935
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074707
       ESTADO: SP
         ITEM: 00482
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.99)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(26.43)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000230;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216935" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06401" AND DET_CODCLI = "00074707";
    DOCUMENTO: 000000216935
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074707
       ESTADO: SP
         ITEM: 06401
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000231;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036173" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00533" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036173
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00533
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.28)
      .ValorDoIcmsDoEstado(8.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22.94)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(46)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000232;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216936" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35521" AND DET_CODCLI = "00000316";
    DOCUMENTO: 000000216936
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000316
       ESTADO: SP
         ITEM: 35521
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.92)
      .ValorDoIcmsDoEstado(7.92)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(13.31)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(44)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000233;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216936" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16200" AND DET_CODCLI = "00000316";
    DOCUMENTO: 000000216936
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000316
       ESTADO: SP
         ITEM: 16200
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(54.59)
      .ValorDoIcmsDoEstado(54.59)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(143.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(303.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000234;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216936" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07199" AND DET_CODCLI = "00000316";
    DOCUMENTO: 000000216936
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000316
       ESTADO: SP
         ITEM: 07199
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(9.25)
      .ValorDoIcmsDoEstado(9.25)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(38.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(77.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000235;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036174" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "16198" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036174
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 16198
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(9.9)
      .ValorDoIcmsDoEstado(9.9)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(26.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(55)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000236;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216937" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16571" AND DET_CODCLI = "00039316";
    DOCUMENTO: 000000216937
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00039316
       ESTADO: SP
         ITEM: 16571
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(32.4)
      .ValorDoIcmsDoEstado(32.4)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(139.89)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(270)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000237;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216937" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18363" AND DET_CODCLI = "00039316";
    DOCUMENTO: 000000216937
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00039316
       ESTADO: SP
         ITEM: 18363
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.67)
      .ValorDoIcmsDoEstado(5.67)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(20.04)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(47.28)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000238;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036175" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "35138" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036175
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 35138
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.53)
      .ValorDoIcmsDoEstado(1.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.49)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000239;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216938" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30808" AND DET_CODCLI = "00000141";
    DOCUMENTO: 000000216938
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000141
       ESTADO: SP
         ITEM: 30808
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.62)
      .ValorDoIcmsDoEstado(10.62)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(31.27)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000240;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216938" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18500" AND DET_CODCLI = "00000141";
    DOCUMENTO: 000000216938
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000141
       ESTADO: SP
         ITEM: 18500
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(3.2)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(11.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(17.75)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000241;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216938" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30471" AND DET_CODCLI = "00000141";
    DOCUMENTO: 000000216938
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000141
       ESTADO: SP
         ITEM: 30471
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.86)
      .ValorDoIcmsDoEstado(2.86)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.23)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(15.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000242;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216938" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03305" AND DET_CODCLI = "00000141";
    DOCUMENTO: 000000216938
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000141
       ESTADO: SP
         ITEM: 03305
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2.68)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(9.31)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(14.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CTA')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000243;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036176" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00116" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036176
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00116
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.3)
      .ValorDoIcmsDoEstado(10.3)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(67.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(117)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000244;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216939" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04982" AND DET_CODCLI = "00074708";
    DOCUMENTO: 000000216939
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074708
       ESTADO: SP
         ITEM: 04982
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(78)
      .ValorDoIcmsDoEstado(78)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(382.73)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(650)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000245;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216940" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13660" AND DET_CODCLI = "00000581";
    DOCUMENTO: 000000216940
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000581
       ESTADO: SP
         ITEM: 13660
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(30.42)
      .ValorDoIcmsDoEstado(30.42)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(90.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(168.98)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000246;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216941" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27740" AND DET_CODCLI = "00055139";
    DOCUMENTO: 000000216941
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00055139
       ESTADO: SP
         ITEM: 27740
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(7.71)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(27.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(42.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000247;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216941" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12188" AND DET_CODCLI = "00055139";
    DOCUMENTO: 000000216941
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00055139
       ESTADO: SP
         ITEM: 12188
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(3.47)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(10.73)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(19.26)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000248;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216941" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32033" AND DET_CODCLI = "00055139";
    DOCUMENTO: 000000216941
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00055139
       ESTADO: SP
         ITEM: 32033
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(14.13)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(52.42)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(78.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000249;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216941" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28662" AND DET_CODCLI = "00055139";
    DOCUMENTO: 000000216941
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00055139
       ESTADO: SP
         ITEM: 28662
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.22)
      .ValorDoIcmsDoEstado(7.22)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(14.85)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(40.11)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000250;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216941" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07731" AND DET_CODCLI = "00055139";
    DOCUMENTO: 000000216941
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00055139
       ESTADO: SP
         ITEM: 07731
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(4.34)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(16.14)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(24.11)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000251;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "19555" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 19555
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(142.56)
      .ValorDoIcmsDoEstado(142.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(328)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(792)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000252;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "19729" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 19729
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(46.8)
      .ValorDoIcmsDoEstado(46.8)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(125)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(260)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000253;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "28494" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 28494
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(80.46)
      .ValorDoIcmsDoEstado(80.46)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(174.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(447)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000254;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "20939" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 20939
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(86.4)
      .ValorDoIcmsDoEstado(86.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(162.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(480)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000255;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "31338" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 31338
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(112.75)
      .ValorDoIcmsDoEstado(104.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(189)
      .ValorDoIpiDoItem(46.4)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(580)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000256;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "26883" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 26883
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(85.92)
      .ValorDoIcmsDoEstado(79.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(141)
      .ValorDoIpiDoItem(35.36)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(442)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000257;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "19760" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 19760
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(16.2)
      .ValorDoIcmsDoEstado(16.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(32)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(90)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000258;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "19599" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 19599
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(202.95)
      .ValorDoIcmsDoEstado(187.92)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(478)
      .ValorDoIpiDoItem(83.52)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1044)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000259;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000049133" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "27126" AND DET_CODCLI = "00024581";
    DOCUMENTO: 000000049133
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00024581
       ESTADO: SP
         ITEM: 27126
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(50.03)
      .ValorDoIcmsDoEstado(50.03)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(160.08)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(277.92)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000260;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216942" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05746" AND DET_CODCLI = "00023192";
    DOCUMENTO: 000000216942
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00023192
       ESTADO: SP
         ITEM: 05746
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(88.34)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(142)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000261;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036177" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02759" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036177
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02759
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.48)
      .ValorDoIcmsDoEstado(1.48)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.11)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.22)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000262;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036177" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "35406" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036177
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 35406
         CFOP: 5102
CODIGO FISCAL: 220
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.88)
      .ValorDoIcmsDoEstado(7.88)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(53.8)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(89.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000263;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216943" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31324" AND DET_CODCLI = "00000755";
    DOCUMENTO: 000000216943
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000755
       ESTADO: SP
         ITEM: 31324
         CFOP: 1202
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: OE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(24.3)
      .ValorDoIcmsDoEstado(24.3)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(51.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(135)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000264;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036178" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01406" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036178
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01406
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.88)
      .ValorDoIcmsDoEstado(2.88)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(7.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(16)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000265;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036179" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "27989" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036179
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 27989
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(8.82)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(32.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(49)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000266;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216944" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34824" AND DET_CODCLI = "00046643";
    DOCUMENTO: 000000216944
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00046643
       ESTADO: SP
         ITEM: 34824
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.53)
      .ValorDoIcmsDoEstado(1.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.98)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000267;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216944" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03363" AND DET_CODCLI = "00046643";
    DOCUMENTO: 000000216944
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00046643
       ESTADO: SP
         ITEM: 03363
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1)
      .ValorDoIcmsDoEstado(1)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5.53)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000268;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216944" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31020" AND DET_CODCLI = "00046643";
    DOCUMENTO: 000000216944
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00046643
       ESTADO: SP
         ITEM: 31020
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.14)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(7.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000269;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216944" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12489" AND DET_CODCLI = "00046643";
    DOCUMENTO: 000000216944
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00046643
       ESTADO: SP
         ITEM: 12489
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.28)
      .ValorDoIcmsDoEstado(1.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(7.09)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000270;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216944" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15667" AND DET_CODCLI = "00046643";
    DOCUMENTO: 000000216944
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00046643
       ESTADO: SP
         ITEM: 15667
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.16)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.64)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000271;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216945" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14871" AND DET_CODCLI = "00074710";
    DOCUMENTO: 000000216945
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074710
       ESTADO: SP
         ITEM: 14871
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.64)
      .ValorDoIcmsDoEstado(2.64)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.47)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000272;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036180" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "00534" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036180
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00534
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.13)
      .ValorDoIcmsDoEstado(5.13)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(13.51)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(28.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000273;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216946" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15646" AND DET_CODCLI = "00074711";
    DOCUMENTO: 000000216946
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074711
       ESTADO: SP
         ITEM: 15646
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(447.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(619.63)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000274;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216946" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26335" AND DET_CODCLI = "00074711";
    DOCUMENTO: 000000216946
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074711
       ESTADO: SP
         ITEM: 26335
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.24)
      .ValorDoIcmsDoEstado(1.15)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.17)
      .ValorDoIpiDoItem(0.77)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000275;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216947" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19719" AND DET_CODCLI = "00059057";
    DOCUMENTO: 000000216947
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00059057
       ESTADO: SP
         ITEM: 19719
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.61)
      .ValorDoIcmsDoEstado(0.61)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3.41)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000276;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216947" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19739" AND DET_CODCLI = "00059057";
    DOCUMENTO: 000000216947
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00059057
       ESTADO: SP
         ITEM: 19739
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.45)
      .ValorDoIcmsDoEstado(1.45)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.61)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(8.03)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000277;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216947" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07143" AND DET_CODCLI = "00059057";
    DOCUMENTO: 000000216947
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00059057
       ESTADO: SP
         ITEM: 07143
         CFOP: 5656
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(25.76)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(46.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000278;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036182" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "18703" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036182
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 18703
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.09)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000279;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30786" AND DET_CODCLI = "00021201";
    DOCUMENTO: 000000216948
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00021201
       ESTADO: SP
         ITEM: 30786
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.82)
      .ValorDoIcmsDoEstado(8.82)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(25.59)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(49)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000280;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01444" AND DET_CODCLI = "00021201";
    DOCUMENTO: 000000216948
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00021201
       ESTADO: SP
         ITEM: 01444
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.79)
      .ValorDoIcmsDoEstado(2.79)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(15.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000281;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01725" AND DET_CODCLI = "00021201";
    DOCUMENTO: 000000216948
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00021201
       ESTADO: SP
         ITEM: 01725
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(28.26)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(104.64)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(157)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000282;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27939" AND DET_CODCLI = "00021201";
    DOCUMENTO: 000000216948
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00021201
       ESTADO: SP
         ITEM: 27939
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(16.74)
      .ValorDoIcmsDoEstado(16.74)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(40.06)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(93)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000283;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01863" AND DET_CODCLI = "00021201";
    DOCUMENTO: 000000216948
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00021201
       ESTADO: SP
         ITEM: 01863
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(13.77)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(50.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(76.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000284;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02248" AND DET_CODCLI = "00021201";
    DOCUMENTO: 000000216948
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00021201
       ESTADO: SP
         ITEM: 02248
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(15.48)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(55.52)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(86)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000285;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30781" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 30781
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.33)
      .ValorDoIcmsDoEstado(14.33)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(47.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(79.63)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000286;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30782" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 30782
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.34)
      .ValorDoIcmsDoEstado(14.34)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(47.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(79.64)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000287;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30731" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 30731
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(28.67)
      .ValorDoIcmsDoEstado(28.67)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(95.39)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(159.27)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000288;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30784" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 30784
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(21.5)
      .ValorDoIcmsDoEstado(21.5)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(71.54)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(119.45)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000289;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04508" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 04508
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(51.39)
      .ValorDoIcmsDoEstado(51.39)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(134.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(285.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000290;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04508" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 04508
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(44.41)
      .ValorDoIcmsDoEstado(44.41)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(110.31)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(246.72)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000291;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05045" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 05045
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(38.78)
      .ValorDoIcmsDoEstado(38.78)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(158.77)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(323.13)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000292;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216949" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13255" AND DET_CODCLI = "00048731";
    DOCUMENTO: 000000216949
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00048731
       ESTADO: SP
         ITEM: 13255
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.19)
      .ValorDoIcmsDoEstado(2.19)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(8.52)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(18.24)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000293;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216950" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34049" AND DET_CODCLI = "00036921";
    DOCUMENTO: 000000216950
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00036921
       ESTADO: SP
         ITEM: 34049
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(11.7)
      .ValorDoIcmsDoEstado(11.7)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(34.26)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(65)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000294;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216950" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05548" AND DET_CODCLI = "00036921";
    DOCUMENTO: 000000216950
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00036921
       ESTADO: SP
         ITEM: 05548
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.4)
      .ValorDoIcmsDoEstado(14.4)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(51.83)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(120)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000295;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216951" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19558" AND DET_CODCLI = "00030948";
    DOCUMENTO: 000000216951
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00030948
       ESTADO: SP
         ITEM: 19558
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.14)
      .ValorDoIcmsDoEstado(6.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(34.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000296;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216951" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20939" AND DET_CODCLI = "00030948";
    DOCUMENTO: 000000216951
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00030948
       ESTADO: SP
         ITEM: 20939
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(32.4)
      .ValorDoIcmsDoEstado(32.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(32.58)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(180)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000297;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216951" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17008" AND DET_CODCLI = "00030948";
    DOCUMENTO: 000000216951
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00030948
       ESTADO: SP
         ITEM: 17008
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(105.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(165)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000298;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216952" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05924" AND DET_CODCLI = "00067054";
    DOCUMENTO: 000000216952
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00067054
       ESTADO: SP
         ITEM: 05924
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(171.61)
      .ValorDoIcmsDoEstado(171.61)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(902.93)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(66.67)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1430)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{66,67}, objFloatUtils.fStrToFloat('66,67')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000299;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216953" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17681" AND DET_CODCLI = "00000121";
    DOCUMENTO: 000000216953
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000121
       ESTADO: SP
         ITEM: 17681
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(62.64)
      .ValorDoIcmsDoEstado(62.64)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(185.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(348)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000300;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216953" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03259" AND DET_CODCLI = "00000121";
    DOCUMENTO: 000000216953
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000121
       ESTADO: SP
         ITEM: 03259
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(9.36)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(33.8)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(52)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000301;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216953" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03758" AND DET_CODCLI = "00000121";
    DOCUMENTO: 000000216953
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000121
       ESTADO: SP
         ITEM: 03758
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(12.35)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(46.14)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(68.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000302;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216954" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06953" AND DET_CODCLI = "00006000";
    DOCUMENTO: 000000216954
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006000
       ESTADO: SP
         ITEM: 06953
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.14)
      .ValorDoIcmsDoEstado(4.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(27.78)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(47)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000303;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216954" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06953" AND DET_CODCLI = "00006000";
    DOCUMENTO: 000000216954
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006000
       ESTADO: SP
         ITEM: 06953
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.2)
      .ValorDoIcmsDoEstado(6.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(41.67)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(70.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000304;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036183" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "28146" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036183
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 28146
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.04)
      .ValorDoIcmsDoEstado(1.04)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(2.11)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000305;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27616" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 27616
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(6.36)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(32.06)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(35.33)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000306;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00065" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 00065
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2.43)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.26)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000307;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18593" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 18593
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(50.33)
      .ValorDoIcmsDoEstado(50.33)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(203.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(279.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000308;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30871" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30871
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(49.14)
      .ValorDoIcmsDoEstado(49.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(198.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(273)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000309;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07101" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 07101
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.07)
      .ValorDoIcmsDoEstado(4.07)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(16.44)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000310;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28403" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 28403
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(17.17)
      .ValorDoIcmsDoEstado(17.17)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(69.38)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(95.37)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000311;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35294" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 35294
         CFOP: 5152
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(19.36)
      .ValorDoIcmsDoEstado(19.36)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(187.33)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(48.89)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(220)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{48,89}, objFloatUtils.fStrToFloat('48,89')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000312;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35290" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 35290
         CFOP: 5152
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.57)
      .ValorDoIcmsDoEstado(7.57)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(73.23)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(48.89)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(86)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{48,89}, objFloatUtils.fStrToFloat('48,89')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000313;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30731" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30731
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.5)
      .ValorDoIcmsDoEstado(5.5)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22.23)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30.56)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000314;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30785" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30785
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(11)
      .ValorDoIcmsDoEstado(11)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(44.46)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61.12)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000315;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00312" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 00312
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(52.13)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(57.44)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000316;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00390" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 00390
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2.45)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(12.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.62)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000317;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13794" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 13794
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.38)
      .ValorDoIcmsDoEstado(4.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(17.71)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(24.34)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000318;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30754" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30754
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(25.32)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(261.09)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(73.34)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(287.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{73,34}, objFloatUtils.fStrToFloat('73,34')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000319;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04508" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 04508
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.36)
      .ValorDoIcmsDoEstado(4.36)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(16.72)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(24.21)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000320;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16618" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 16618
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(37.63)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(189.72)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(209.06)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000321;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05878" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 05878
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(9.6)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(48.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(53.31)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000322;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29029" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 29029
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.68)
      .ValorDoIcmsDoEstado(1.68)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(6.77)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.31)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000323;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31605" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 31605
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(26.96)
      .ValorDoIcmsDoEstado(26.96)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(168.34)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(224.68)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000324;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30483" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30483
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.76)
      .ValorDoIcmsDoEstado(1.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(10.67)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(14.67)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000325;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18927" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 18927
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(8.42)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(42.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(46.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000326;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19564" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 19564
         CFOP: 5152
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.15)
      .ValorDoIcmsDoEstado(1.15)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000327;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30724" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30724
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(6.84)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(34.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000328;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30725" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30725
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(4.94)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(24.92)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(27.46)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000329;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01258" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01258
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(10.88)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000330;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32527" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 32527
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(268.52)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(295.88)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000331;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04305" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 04305
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(222.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(245.18)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000332;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04043" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 04043
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(79.21)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(399.33)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(440.03)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000333;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01276" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01276
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(4.25)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000334;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03895" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 03895
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(29.94)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(33)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000335;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05212" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 05212
         CFOP: 5152
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.61)
      .ValorDoIcmsDoEstado(8.61)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(43.39)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(47.81)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000336;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30410" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 30410
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.93)
      .ValorDoIcmsDoEstado(2.93)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(16.27)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000337;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32211" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 32211
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.74)
      .ValorDoIcmsDoEstado(12.74)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(51.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(70.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000338;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11725" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 11725
         CFOP: 5409
CODIGO FISCAL: 560
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(54.3)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(410.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(452.52)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000339;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01409" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01409
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2.41)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(11.89)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000340;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29249" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 29249
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(54.52)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(60.08)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000341;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01432" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01432
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.19)
      .ValorDoIcmsDoEstado(1.19)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.8)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.61)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000342;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32221" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 32221
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(24.32)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(122.61)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(135.11)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000343;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29527" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 29527
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(10.82)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(54.55)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(60.12)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000344;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33416" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 33416
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(5.5)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(22.21)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30.53)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000345;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01458" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01458
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.45)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(4.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000346;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32714" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 32714
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(11.1)
      .ValorDoIcmsDoEstado(11.1)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(44.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61.68)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000347;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16106" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 16106
         CFOP: 5152
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.54)
      .ValorDoIcmsDoEstado(2.54)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(23.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(48.89)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(28.9)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{48,89}, objFloatUtils.fStrToFloat('48,89')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000348;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01588" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01588
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(20.04)
      .ValorDoIcmsDoEstado(20.04)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(81.01)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(111.35)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000349;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "24158" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 24158
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.4)
      .ValorDoIcmsDoEstado(12.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(50.11)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(68.88)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000350;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01723" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 01723
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.15)
      .ValorDoIcmsDoEstado(3.15)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(15.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(17.52)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000351;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05045" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 05045
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.69)
      .ValorDoIcmsDoEstado(2.69)
      .AliquotaDaSubstituicaoTributariaDoItem(12)
      .TotalGeralDoItemPreUlt(14.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.39)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000352;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27068" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 27068
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(47.55)
      .ValorDoIcmsDoEstado(47.55)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(312.03)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(396.23)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000353;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "22304" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 22304
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(97.92)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(493.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(544.01)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000354;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33189" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 33189
         CFOP: 5409
CODIGO FISCAL: 170
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(22.99)
      .ValorDoIcmsDoEstado(22.99)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(190.06)
      .ValorDoIpiDoItem(20.9)
      .ValorDoIva(1.49)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(48.89)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(261.26)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{205,54}, objFloatUtils.fStrToFloat('205,54')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{14,01}, objFloatUtils.fStrToFloat('14,01')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{48,89}, objFloatUtils.fStrToFloat('48,89')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000355;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33349" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 33349
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.71)
      .ValorDoIcmsDoEstado(2.71)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(10.94)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(15.04)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000356;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15210" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 15210
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.38)
      .ValorDoIcmsDoEstado(1.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(5.58)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(7.68)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000357;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27405" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 27405
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.07)
      .ValorDoIcmsDoEstado(2.07)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(8.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(11.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000358;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29758" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 29758
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.78)
      .ValorDoIcmsDoEstado(12.78)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(51.63)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(70.98)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000359;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05064" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 05064
         CFOP: 5152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.6)
      .ValorDoIcmsDoEstado(4.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(25.54)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000360;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00779" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 00779
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(2.02)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(10.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(11.22)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000361;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "22252" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 22252
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(1.2)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(6.05)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(6.67)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000362;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02590" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 02590
         CFOP: 5409
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(35.39)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(39.01)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000363;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02601" AND DET_CODCLI = "00044663";
    DOCUMENTO: 000000216955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044663
       ESTADO: SP
         ITEM: 02601
         CFOP: 5409
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(20.36)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(102.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(113.12)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000364;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216956" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01701" AND DET_CODCLI = "00074311";
    DOCUMENTO: 000000216956
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074311
       ESTADO: SP
         ITEM: 01701
         CFOP: 1202
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: OE}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(39.51)
      .ValorDoIcmsDoEstado(39.51)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(237.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(449)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000365;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216958" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21615" AND DET_CODCLI = "00074695";
    DOCUMENTO: 000000216958
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074695
       ESTADO: SP
         ITEM: 21615
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(592.33)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(669)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000366;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216959" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31371" AND DET_CODCLI = "00074713";
    DOCUMENTO: 000000216959
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074713
       ESTADO: SP
         ITEM: 31371
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(104.38)
      .ValorDoIcmsDoEstado(104.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(271.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(579.87)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000367;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216961" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32852" AND DET_CODCLI = "00074714";
    DOCUMENTO: 000000216961
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074714
       ESTADO: SC
         ITEM: 32852
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(68.28)
      .ValorDoIcmsDoEstado(68.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(271.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(569)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000368;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000036184" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "07143" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000036184
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 07143
         CFOP: 5656
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000369;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216964" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00528" AND DET_CODCLI = "00000145";
    DOCUMENTO: 000000216964
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000145
       ESTADO: SP
         ITEM: 00528
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(555.98)
      .ValorDoIcmsDoEstado(555.98)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1621.62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3088.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000370;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216964" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19415" AND DET_CODCLI = "00000145";
    DOCUMENTO: 000000216964
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000145
       ESTADO: SP
         ITEM: 19415
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(115.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(180)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000371;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216964" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12339" AND DET_CODCLI = "00000145";
    DOCUMENTO: 000000216964
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000145
       ESTADO: SP
         ITEM: 12339
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(122.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(187.96)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestCSFERRAMENTAS.REGRA_ST_CSFERRAMENTAS_000372;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000216965" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27741" AND DET_CODCLI = "00050744";
    DOCUMENTO: 000000216965
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00050744
       ESTADO: SP
         ITEM: 27741
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 25/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(False)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(37.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(58)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(False)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestCSFERRAMENTAS.Suite);
end.

