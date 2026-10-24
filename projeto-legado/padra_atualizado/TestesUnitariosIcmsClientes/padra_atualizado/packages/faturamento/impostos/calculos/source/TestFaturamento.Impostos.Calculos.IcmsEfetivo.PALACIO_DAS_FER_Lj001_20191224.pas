unit TestFaturamento.Impostos.Calculos.IcmsEfetivo.PALACIO_DAS_FER_Lj001_20191224;

{--------------------------------------------------------------------------
                    RESUMO ICMSEFETIVO                 
--------------------------------------------------------------------------
Empresa            : 001 - PALÁCIO DAS FERRAMENTAS E PARAFUSOS LTDA
Período Selecionado: 24/12/2019 até 24/12/2019
Data do Processo   : 24/12/2019 
Hora Inicio        : 20:35:09
Hora Fim           : 20:49:54
Tempo Total        : 00:14:45
                                           
Total Registros    : 1382
Total Processados  : 1382
Total de Acertos   : 360
Total de Erros     : 0
Total Ignorados    : 971
Total Duplicados   : 51
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.IcmsEfetivo,
Faturamento.Impostos.Tipos.IcmsEfetivo,
Faturamento.Impostos.Interfaces.IcmsEfetivo;

type
TestPALACIODASFER = class(TTestCase)
strict private
private





published

Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000001;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000002;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000003;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000004;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000005;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000006;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000007;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000008;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000009;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000010;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000011;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000012;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000013;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000014;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000015;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000016;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000017;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000018;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000019;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000020;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000021;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000022;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000023;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000024;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000025;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000026;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000027;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000028;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000029;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000030;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000031;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000032;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000033;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000034;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000035;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000036;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000037;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000038;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000039;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000040;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000041;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000042;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000043;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000044;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000045;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000046;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000047;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000048;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000049;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000050;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000051;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000052;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000053;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000054;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000055;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000056;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000057;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000058;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000059;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000060;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000061;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000062;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000063;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000064;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000065;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000066;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000067;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000068;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000069;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000070;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000071;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000072;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000073;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000074;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000075;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000076;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000077;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000078;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000079;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000080;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000081;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000082;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000083;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000084;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000085;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000086;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000087;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000088;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000089;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000090;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000091;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000092;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000093;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000094;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000095;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000096;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000097;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000098;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000099;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000100;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000101;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000102;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000103;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000104;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000105;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000106;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000107;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000108;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000109;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000110;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000111;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000112;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000113;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000114;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000115;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000116;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000117;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000118;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000119;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000120;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000121;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000122;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000123;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000124;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000125;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000126;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000127;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000128;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000129;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000130;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000131;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000132;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000133;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000134;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000135;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000136;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000137;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000138;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000139;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000140;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000141;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000142;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000143;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000144;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000145;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000146;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000147;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000148;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000149;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000150;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000151;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000152;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000153;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000154;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000155;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000156;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000157;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000158;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000159;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000160;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000161;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000162;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000163;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000164;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000165;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000166;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000167;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000168;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000169;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000170;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000171;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000172;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000173;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000174;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000175;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000176;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000177;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000178;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000179;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000180;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000181;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000182;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000183;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000184;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000185;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000186;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000187;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000188;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000189;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000190;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000191;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000192;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000193;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000194;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000195;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000196;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000197;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000198;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000199;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000200;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000201;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000202;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000203;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000204;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000205;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000206;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000207;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000208;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000209;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000210;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000211;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000212;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000213;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000214;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000215;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000216;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000217;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000218;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000219;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000220;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000221;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000222;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000223;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000224;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000225;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000226;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000227;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000228;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000229;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000230;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000231;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000232;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000233;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000234;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000235;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000236;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000237;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000238;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000239;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000240;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000241;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000242;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000243;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000244;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000245;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000246;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000247;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000248;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000249;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000250;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000251;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000252;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000253;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000254;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000255;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000256;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000257;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000258;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000259;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000260;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000261;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000262;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000263;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000264;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000265;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000266;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000267;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000268;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000269;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000270;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000271;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000272;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000273;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000274;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000275;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000276;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000277;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000278;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000279;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000280;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000281;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000282;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000283;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000284;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000285;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000286;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000287;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000288;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000289;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000290;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000291;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000292;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000293;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000294;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000295;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000296;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000297;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000298;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000299;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000300;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000301;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000302;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000303;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000304;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000305;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000306;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000307;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000308;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000309;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000310;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000311;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000312;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000313;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000314;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000315;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000316;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000317;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000318;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000319;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000320;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000321;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000322;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000323;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000324;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000325;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000326;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000327;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000328;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000329;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000330;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000331;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000332;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000333;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000334;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000335;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000336;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000337;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000338;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000339;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000340;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000341;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000342;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000343;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000344;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000345;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000346;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000347;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000348;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000349;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000350;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000351;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000352;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000353;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000354;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000355;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000356;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000357;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000358;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000359;
Procedure CALCULO_ICMS_EFETIVO__PALACIODASFER_000360;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestPALACIODASFER.SetUp;
begin
end;

procedure TestPALACIODASFER.TearDown;
begin
end;

Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240612" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01165" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240612
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01165
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.37)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(157.32)
      .ValorRetido(9.44)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,37}, objFloatUtils.fStrToFloat('0,37')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143829" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01144" AND DET_CODCLI = "10843121";
    DOCUMENTO: 000001143829
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843121
       ESTADO: SP
         ITEM: 01144
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2750)
      .QuantidadeItem(100)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(29.78)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(572.7)
      .ValorRetido(34.37)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{29,78}, objFloatUtils.fStrToFloat('29,78')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240666" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01111" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240666
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3402)
      .QuantidadeItem(50)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.91)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.57)
      .ValorRetido(5.61)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,91}, objFloatUtils.fStrToFloat('1,91')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240723" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01166" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240723
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01166
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(990)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(199.75)
      .ValorRetido(11.99)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,6}, objFloatUtils.fStrToFloat('0,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01165" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 01165
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(24)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.16)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(157.32)
      .ValorRetido(9.44)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,16}, objFloatUtils.fStrToFloat('2,16')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240629" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01162" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240629
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01162
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2673)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.79)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(58.78)
      .ValorRetido(3.53)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,79}, objFloatUtils.fStrToFloat('0,79')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240691" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01111" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240691
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3402)
      .QuantidadeItem(50)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.89)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.57)
      .ValorRetido(5.61)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,89}, objFloatUtils.fStrToFloat('1,89')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240700" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01164" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240700
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01164
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2898)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.72)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(116.88)
      .ValorRetido(7.01)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,72}, objFloatUtils.fStrToFloat('0,72')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240669" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01111" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240669
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3402)
      .QuantidadeItem(16)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.42)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.57)
      .ValorRetido(5.61)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,42}, objFloatUtils.fStrToFloat('0,42')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240624" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01162" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240624
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01162
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2673)
      .QuantidadeItem(12)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(58.78)
      .ValorRetido(3.53)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,43}, objFloatUtils.fStrToFloat('0,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240695" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01111" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240695
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3402)
      .QuantidadeItem(18)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.76)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.57)
      .ValorRetido(5.61)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,76}, objFloatUtils.fStrToFloat('0,76')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240668" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01164" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240668
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01164
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2898)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(116.88)
      .ValorRetido(7.01)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,39}, objFloatUtils.fStrToFloat('0,39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240636" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01111" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240636
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3402)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.3)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.57)
      .ValorRetido(5.61)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,3}, objFloatUtils.fStrToFloat('0,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01164" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 01164
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2898)
      .QuantidadeItem(24)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.16)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(116.88)
      .ValorRetido(7.01)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,16}, objFloatUtils.fStrToFloat('2,16')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277218" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "19235" AND DET_CODCLI = "10014341";
    DOCUMENTO: 000000277218
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10014341
       ESTADO: SP
         ITEM: 19235
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6000)
      .QuantidadeItem(40)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.61)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(101.52)
      .ValorRetido(6.07)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,61}, objFloatUtils.fStrToFloat('0,61')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240721" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01130" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240721
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01130
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.82)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(38.07)
      .ValorRetido(2.29)
      .ValorIcmsSubstitutoItem(4.56);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,82}, objFloatUtils.fStrToFloat('1,82')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240631" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "42921" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240631
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 42921
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3080)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(601.68)
      .ValorRetido(36.1)
      .ValorIcmsSubstitutoItem(72.2);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,4}, objFloatUtils.fStrToFloat('5,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240695" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04292" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240695
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 04292
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(34)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(219.62)
      .ValorRetido(19.27)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{34}, objFloatUtils.fStrToFloat('34')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240649" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05370" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240649
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05370
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.17)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(11.096785033776)
      .ValorRetido(1.99742130607968)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,17}, objFloatUtils.fStrToFloat('9,17')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240655" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "63302" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240655
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 63302
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(28)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(34.0197)
      .ValorRetido(6.123546)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{28}, objFloatUtils.fStrToFloat('28')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144074" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "52440" AND DET_CODCLI = "10843008";
    DOCUMENTO: 000001144074
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843008
       ESTADO: SP
         ITEM: 52440
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(79.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(77.3849537)
      .ValorRetido(13.929291666)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{79,4}, objFloatUtils.fStrToFloat('79,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143991" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "52875" AND DET_CODCLI = "10842929";
    DOCUMENTO: 000001143991
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842929
       ESTADO: SP
         ITEM: 52875
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(130)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(462.26)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(31220.65)
      .ValorRetido(4111.72)
      .ValorIcmsSubstitutoItem(1508);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{462,26}, objFloatUtils.fStrToFloat('462,26')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240620" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "42166" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240620
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 42166
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9.33587895)
      .ValorRetido(1.680458211)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,9}, objFloatUtils.fStrToFloat('8,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143846" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "42166" AND DET_CODCLI = "10834581";
    DOCUMENTO: 000001143846
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10834581
       ESTADO: SP
         ITEM: 42166
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(25.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9.33587895)
      .ValorRetido(1.680458211)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{25,9}, objFloatUtils.fStrToFloat('25,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240643" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03504" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240643
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03504
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(12)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(37.25)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(360.36)
      .ValorRetido(22.74)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{37,25}, objFloatUtils.fStrToFloat('37,25')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240688" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "60994" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240688
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 60994
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.85)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18.2443643)
      .ValorRetido(3.283985574)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,85}, objFloatUtils.fStrToFloat('17,85')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277225" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "60994" AND DET_CODCLI = "10458685";
    DOCUMENTO: 000000277225
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10458685
       ESTADO: SP
         ITEM: 60994
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(34)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18.2443643)
      .ValorRetido(3.283985574)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{34}, objFloatUtils.fStrToFloat('34')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240716" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "60994" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240716
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 60994
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18.2443643)
      .ValorRetido(3.283985574)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,8}, objFloatUtils.fStrToFloat('17,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143550" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "52876" AND DET_CODCLI = "10842677";
    DOCUMENTO: 000001143550
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842677
       ESTADO: SP
         ITEM: 52876
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(25)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(441.56)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6003.97)
      .ValorRetido(790.71)
      .ValorIcmsSubstitutoItem(290);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{441,56}, objFloatUtils.fStrToFloat('441,56')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277218" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "19238" AND DET_CODCLI = "10014341";
    DOCUMENTO: 000000277218
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10014341
       ESTADO: SP
         ITEM: 19238
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5000)
      .QuantidadeItem(40)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(38.64)
      .ValorRetido(2.32)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,36}, objFloatUtils.fStrToFloat('0,36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240650" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "07734" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240650
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 07734
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(201.19)
      .ValorRetido(32.05)
      .ValorIcmsSubstitutoItem(4.16);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,4}, objFloatUtils.fStrToFloat('9,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277214" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "08233" AND DET_CODCLI = "10001332";
    DOCUMENTO: 000000277214
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10001332
       ESTADO: SP
         ITEM: 08233
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.62)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(231.33)
      .ValorRetido(20.21)
      .ValorIcmsSubstitutoItem(21.43);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,62}, objFloatUtils.fStrToFloat('1,62')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277223" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "13818" AND DET_CODCLI = "10157304";
    DOCUMENTO: 000000277223
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10157304
       ESTADO: SP
         ITEM: 13818
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2100)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.41)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(953.01)
      .ValorRetido(83.28)
      .ValorIcmsSubstitutoItem(88.26);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,41}, objFloatUtils.fStrToFloat('7,41')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13818" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 13818
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2100)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(953.01)
      .ValorRetido(83.28)
      .ValorIcmsSubstitutoItem(88.26);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,8}, objFloatUtils.fStrToFloat('1,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240733" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "42184" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240733
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 42184
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.65)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(630.07)
      .ValorRetido(55.06)
      .ValorIcmsSubstitutoItem(58.35);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,65}, objFloatUtils.fStrToFloat('1,65')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143529" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62401" AND DET_CODCLI = "10842921";
    DOCUMENTO: 000001143529
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842921
       ESTADO: SP
         ITEM: 62401
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(13.03)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1299.69)
      .ValorRetido(94.19)
      .ValorIcmsSubstitutoItem(139.75);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{13,03}, objFloatUtils.fStrToFloat('13,03')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240675" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "62401" AND DET_CODCLI = "10843121";
    DOCUMENTO: 000000240675
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10843121
       ESTADO: SP
         ITEM: 62401
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(12)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1299.69)
      .ValorRetido(94.19)
      .ValorIcmsSubstitutoItem(139.75);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143631" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62400" AND DET_CODCLI = "10842830";
    DOCUMENTO: 000001143631
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842830
       ESTADO: SP
         ITEM: 62400
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.84)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1671.32)
      .ValorRetido(121.13)
      .ValorIcmsSubstitutoItem(179.71);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,84}, objFloatUtils.fStrToFloat('16,84')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240639" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13816" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240639
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 13816
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.18)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(770.27)
      .ValorRetido(67.31)
      .ValorIcmsSubstitutoItem(71.34);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,18}, objFloatUtils.fStrToFloat('16,18')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "30497" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 30497
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(44.7)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(50.4279945)
      .ValorRetido(9.07703901)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{44,7}, objFloatUtils.fStrToFloat('44,7')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240705" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05319" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240705
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05319
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.77)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3.6356012784)
      .ValorRetido(0.654408230112)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,77}, objFloatUtils.fStrToFloat('2,77')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240722" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05319" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240722
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05319
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.02)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3.6356012784)
      .ValorRetido(0.654408230112)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,02}, objFloatUtils.fStrToFloat('3,02')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240664" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "16180" AND DET_CODCLI = "10015072";
    DOCUMENTO: 000000240664
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10015072
       ESTADO: SP
         ITEM: 16180
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(41)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(19.30608)
      .ValorRetido(3.4750944)
      .ValorIcmsSubstitutoItem(130.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{41}, objFloatUtils.fStrToFloat('41')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143766" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16732" AND DET_CODCLI = "10015072";
    DOCUMENTO: 000001143766
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10015072
       ESTADO: SP
         ITEM: 16732
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(54)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(26.355456)
      .ValorRetido(4.74398208)
      .ValorIcmsSubstitutoItem(178.56);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{54}, objFloatUtils.fStrToFloat('54')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143745" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54223" AND DET_CODCLI = "10711398";
    DOCUMENTO: 000001143745
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10711398
       ESTADO: SP
         ITEM: 54223
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(54.96)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(53.383968)
      .ValorRetido(9.60911424)
      .ValorIcmsSubstitutoItem(108.5);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{54,96}, objFloatUtils.fStrToFloat('54,96')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240640" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03719" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240640
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03719
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(40)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(200)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(197.9687952)
      .ValorRetido(35.634383136)
      .ValorIcmsSubstitutoItem(531.98);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{200}, objFloatUtils.fStrToFloat('200')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240615" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "59584" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240615
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 59584
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(27.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1626.24)
      .ValorRetido(102.64)
      .ValorIcmsSubstitutoItem(190.08);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{27,5}, objFloatUtils.fStrToFloat('27,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54712" AND DET_CODCLI = "10798437";
    DOCUMENTO: 000001144030
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10798437
       ESTADO: SP
         ITEM: 54712
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(23.81)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(564.88)
      .ValorRetido(40.94)
      .ValorIcmsSubstitutoItem(60.74);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{23,81}, objFloatUtils.fStrToFloat('23,81')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240660" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "59585" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240660
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 59585
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.47)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(160.62)
      .ValorRetido(10.14)
      .ValorIcmsSubstitutoItem(18.77);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,47}, objFloatUtils.fStrToFloat('17,47')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143958" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33126" AND DET_CODCLI = "10819693";
    DOCUMENTO: 000001143958
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10819693
       ESTADO: SP
         ITEM: 33126
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(76.46)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(82.3446)
      .ValorRetido(14.822028)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{76,46}, objFloatUtils.fStrToFloat('76,46')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "37393" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 37393
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(116.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(147.66912)
      .ValorRetido(26.5804416)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{116,9}, objFloatUtils.fStrToFloat('116,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240721" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05257" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240721
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05257
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.82)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9.248945472)
      .ValorRetido(1.66481018496)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,82}, objFloatUtils.fStrToFloat('7,82')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277213" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05471" AND DET_CODCLI = "10005980";
    DOCUMENTO: 000000277213
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10005980
       ESTADO: SP
         ITEM: 05471
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(27.18)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(32.571481878)
      .ValorRetido(5.86286673804)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{27,18}, objFloatUtils.fStrToFloat('27,18')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "64282" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 64282
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(20)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(530.94)
      .ValorRetido(59.64)
      .ValorIcmsSubstitutoItem(35.93);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{20}, objFloatUtils.fStrToFloat('20')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240684" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "51260" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240684
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 51260
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(38.21)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(41.671998)
      .ValorRetido(7.50095964)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{38,21}, objFloatUtils.fStrToFloat('38,21')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240735" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "27684" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240735
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 27684
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(54.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(59.889861)
      .ValorRetido(10.78017498)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{54,9}, objFloatUtils.fStrToFloat('54,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30500" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 30500
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(40)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(48.51252)
      .ValorRetido(8.7322536)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{40}, objFloatUtils.fStrToFloat('40')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240704" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "51260" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240704
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 51260
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(38.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(41.671998)
      .ValorRetido(7.50095964)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{38,4}, objFloatUtils.fStrToFloat('38,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143619" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "44993" AND DET_CODCLI = "10265697";
    DOCUMENTO: 000001143619
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10265697
       ESTADO: SP
         ITEM: 44993
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(297)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(327.8)
      .ValorRetido(59.004)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{297}, objFloatUtils.fStrToFloat('297')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144026" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56036" AND DET_CODCLI = "10843362";
    DOCUMENTO: 000001144026
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843362
       ESTADO: SP
         ITEM: 56036
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(314)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(312.9)
      .ValorRetido(56.322)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{314}, objFloatUtils.fStrToFloat('314')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143614" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59058" AND DET_CODCLI = "10030080";
    DOCUMENTO: 000001143614
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030080
       ESTADO: SP
         ITEM: 59058
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(444.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(490.21)
      .ValorRetido(88.2378)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{444,2}, objFloatUtils.fStrToFloat('444,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59058" AND DET_CODCLI = "10842919";
    DOCUMENTO: 000001143483
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842919
       ESTADO: SP
         ITEM: 59058
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(442.17)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(490.21)
      .ValorRetido(88.2378)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{442,17}, objFloatUtils.fStrToFloat('442,17')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143605" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58733" AND DET_CODCLI = "10221087";
    DOCUMENTO: 000001143605
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10221087
       ESTADO: SP
         ITEM: 58733
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(557.03)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(640.7)
      .ValorRetido(115.326)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{557,03}, objFloatUtils.fStrToFloat('557,03')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144024" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "64223" AND DET_CODCLI = "10843036";
    DOCUMENTO: 000001144024
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843036
       ESTADO: SP
         ITEM: 64223
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.92)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(227.5)
      .ValorRetido(36.25)
      .ValorIcmsSubstitutoItem(4.7);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,92}, objFloatUtils.fStrToFloat('9,92')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144071" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59059" AND DET_CODCLI = "10331545";
    DOCUMENTO: 000001144071
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10331545
       ESTADO: SP
         ITEM: 59059
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(476.05)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(490.21)
      .ValorRetido(88.2378)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{476,05}, objFloatUtils.fStrToFloat('476,05')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30515" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 30515
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(74.62)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(90.1107225)
      .ValorRetido(16.21993005)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{74,62}, objFloatUtils.fStrToFloat('74,62')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143814" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59207" AND DET_CODCLI = "10007134";
    DOCUMENTO: 000001143814
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10007134
       ESTADO: SP
         ITEM: 59207
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(504)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(305.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(347.8)
      .ValorRetido(62.604)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{305,5}, objFloatUtils.fStrToFloat('305,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240673" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "59207" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240673
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 59207
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(504)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(299.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(347.8)
      .ValorRetido(62.604)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{299,9}, objFloatUtils.fStrToFloat('299,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "59207" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 59207
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(504)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(319.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(347.8)
      .ValorRetido(62.604)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{319,9}, objFloatUtils.fStrToFloat('319,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143817" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58736" AND DET_CODCLI = "10008524";
    DOCUMENTO: 000001143817
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10008524
       ESTADO: SP
         ITEM: 58736
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(508.08)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(557.7964)
      .ValorRetido(100.403352)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{508,08}, objFloatUtils.fStrToFloat('508,08')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240705" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "55981" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240705
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 55981
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14.09)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18.084)
      .ValorRetido(3.25512)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14,09}, objFloatUtils.fStrToFloat('14,09')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143584" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56540" AND DET_CODCLI = "10825958";
    DOCUMENTO: 000001143584
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10825958
       ESTADO: SP
         ITEM: 56540
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(599.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(639.21)
      .ValorRetido(115.0578)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{599,43}, objFloatUtils.fStrToFloat('599,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144131" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56540" AND DET_CODCLI = "10843409";
    DOCUMENTO: 000001144131
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843409
       ESTADO: SP
         ITEM: 56540
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(625.98)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(639.21)
      .ValorRetido(115.0578)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{625,98}, objFloatUtils.fStrToFloat('625,98')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240705" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05247" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240705
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05247
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.88)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3.717713376)
      .ValorRetido(0.66918840768)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,88}, objFloatUtils.fStrToFloat('2,88')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05459" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05459
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.1)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10.873276128)
      .ValorRetido(1.95718970304)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,1}, objFloatUtils.fStrToFloat('9,1')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143603" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05457" AND DET_CODCLI = "10084846";
    DOCUMENTO: 000001143603
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10084846
       ESTADO: SP
         ITEM: 05457
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(90)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.31)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6.364317258)
      .ValorRetido(1.14557710644)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,31}, objFloatUtils.fStrToFloat('5,31')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277214" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05459" AND DET_CODCLI = "10001332";
    DOCUMENTO: 000000277214
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10001332
       ESTADO: SP
         ITEM: 05459
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.18)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10.873276128)
      .ValorRetido(1.95718970304)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,18}, objFloatUtils.fStrToFloat('9,18')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240722" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05324" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240722
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05324
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.02)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3.581699472)
      .ValorRetido(0.64470590496)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,02}, objFloatUtils.fStrToFloat('3,02')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13182" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 13182
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(250)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7.299972576)
      .ValorRetido(1.31399506368)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,2}, objFloatUtils.fStrToFloat('6,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240741" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05472" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240741
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05472
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(28)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(33.563529792)
      .ValorRetido(6.04143536256)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{28}, objFloatUtils.fStrToFloat('28')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240705" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05253" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240705
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05253
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(320)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6.9457766976)
      .ValorRetido(1.250239805568)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,36}, objFloatUtils.fStrToFloat('5,36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "05461" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 05461
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(12.7)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(15.10810821)
      .ValorRetido(2.7194594778)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{12,7}, objFloatUtils.fStrToFloat('12,7')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240642" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "22606" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240642
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 22606
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.74)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1187.62)
      .ValorRetido(189.53)
      .ValorIcmsSubstitutoItem(24.24);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,74}, objFloatUtils.fStrToFloat('16,74')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240637" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "22604" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240637
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 22604
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3884.26)
      .ValorRetido(619.89)
      .ValorIcmsSubstitutoItem(79.28);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,9}, objFloatUtils.fStrToFloat('16,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240642" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "22604" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240642
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 22604
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.92)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3884.26)
      .ValorRetido(619.89)
      .ValorIcmsSubstitutoItem(79.28);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,92}, objFloatUtils.fStrToFloat('16,92')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240615" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "41130" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240615
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 41130
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(40)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(12.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12.55323762)
      .ValorRetido(2.2595827716)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{12,5}, objFloatUtils.fStrToFloat('12,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240621" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08120" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240621
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 08120
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(11.7)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(230.35)
      .ValorRetido(12.5)
      .ValorIcmsSubstitutoItem(15.14);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{11,7}, objFloatUtils.fStrToFloat('11,7')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240642" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11262" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240642
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 11262
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14.05)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(270.39)
      .ValorRetido(14.68)
      .ValorIcmsSubstitutoItem(17.77);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14,05}, objFloatUtils.fStrToFloat('14,05')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240674" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02633" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240674
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 02633
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(40)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(11)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(531.75)
      .ValorRetido(28.88)
      .ValorIcmsSubstitutoItem(34.93);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277216" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "41686" AND DET_CODCLI = "10033154";
    DOCUMENTO: 000000277216
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10033154
       ESTADO: SP
         ITEM: 41686
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.54)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1138.29)
      .ValorRetido(57.27)
      .ValorIcmsSubstitutoItem(79.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,54}, objFloatUtils.fStrToFloat('9,54')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240713" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "40911" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240713
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 40911
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(10)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(740.6)
      .ValorRetido(67.07)
      .ValorIcmsSubstitutoItem(66.24);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143959" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "63209" AND DET_CODCLI = "10139988";
    DOCUMENTO: 000001143959
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10139988
       ESTADO: SP
         ITEM: 63209
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(40)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(180.32)
      .ValorRetido(15)
      .ValorIcmsSubstitutoItem(17.46);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{40}, objFloatUtils.fStrToFloat('40')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240667" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "57793" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240667
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 57793
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(30.59)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(350.69)
      .ValorRetido(27.49)
      .ValorIcmsSubstitutoItem(35.64);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{30,59}, objFloatUtils.fStrToFloat('30,59')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240721" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01326" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240721
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01326
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.64)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(179.78)
      .ValorRetido(15.55)
      .ValorIcmsSubstitutoItem(16.81);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,64}, objFloatUtils.fStrToFloat('3,64')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143885" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59830" AND DET_CODCLI = "10842793";
    DOCUMENTO: 000001143885
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842793
       ESTADO: SP
         ITEM: 59830
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(53.33)
      .ValorBaseCalculoEfetiva(80.38)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(375.14)
      .ValorRetido(13.97)
      .ValorIcmsSubstitutoItem(31.05);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{53,33}, objFloatUtils.fStrToFloat('53,33')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{80,38}, objFloatUtils.fStrToFloat('80,38')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277224" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "59837" AND DET_CODCLI = "10006546";
    DOCUMENTO: 000000277224
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10006546
       ESTADO: SP
         ITEM: 59837
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(218)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(296.88)
      .ValorRetido(21.83)
      .ValorIcmsSubstitutoItem(31.61);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{218}, objFloatUtils.fStrToFloat('218')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277228" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "60274" AND DET_CODCLI = "10026129";
    DOCUMENTO: 000000277228
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10026129
       ESTADO: SP
         ITEM: 60274
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.96)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1.2506)
      .ValorRetido(0.225108)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,96}, objFloatUtils.fStrToFloat('1,96')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240721" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "60274" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240721
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 60274
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.51)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1.2506)
      .ValorRetido(0.225108)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,51}, objFloatUtils.fStrToFloat('2,51')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240694" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "59617" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240694
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 59617
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14.61)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12.590154)
      .ValorRetido(2.26622772)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14,61}, objFloatUtils.fStrToFloat('14,61')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143758" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55500" AND DET_CODCLI = "10842939";
    DOCUMENTO: 000001143758
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842939
       ESTADO: SP
         ITEM: 55500
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(25.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(475.03)
      .ValorRetido(37.24)
      .ValorIcmsSubstitutoItem(48.27);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{25,8}, objFloatUtils.fStrToFloat('25,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240624" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "38128" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240624
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 38128
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(36)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(12.96)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12.5304)
      .ValorRetido(2.255472)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{12,96}, objFloatUtils.fStrToFloat('12,96')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144090" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "42729" AND DET_CODCLI = "10080146";
    DOCUMENTO: 000001144090
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10080146
       ESTADO: SP
         ITEM: 42729
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(5)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(221.01)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(504.36)
      .ValorRetido(39.53)
      .ValorIcmsSubstitutoItem(51.26);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{221,01}, objFloatUtils.fStrToFloat('221,01')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240725" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "60269" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240725
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 60269
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(40)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(18.02)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(764.18)
      .ValorRetido(66.77)
      .ValorIcmsSubstitutoItem(70.78);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{18,02}, objFloatUtils.fStrToFloat('18,02')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31785" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 31785
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(4)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(359.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(764.97)
      .ValorRetido(49.68)
      .ValorIcmsSubstitutoItem(88.01);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{359,9}, objFloatUtils.fStrToFloat('359,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143651" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59559" AND DET_CODCLI = "10842663";
    DOCUMENTO: 000001143651
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842663
       ESTADO: SP
         ITEM: 59559
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(401.83)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6988.87)
      .ValorRetido(920.42)
      .ValorIcmsSubstitutoItem(337.58);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{401,83}, objFloatUtils.fStrToFloat('401,83')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143662" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "59559" AND DET_CODCLI = "10842744";
    DOCUMENTO: 000001143662
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842744
       ESTADO: SP
         ITEM: 59559
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(404.07)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6988.87)
      .ValorRetido(920.42)
      .ValorIcmsSubstitutoItem(337.58);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{404,07}, objFloatUtils.fStrToFloat('404,07')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143997" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "60839" AND DET_CODCLI = "10842923";
    DOCUMENTO: 000001143997
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842923
       ESTADO: SP
         ITEM: 60839
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(343.19)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(26763.04)
      .ValorRetido(1823.72)
      .ValorIcmsSubstitutoItem(2993.63);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{343,19}, objFloatUtils.fStrToFloat('343,19')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143467" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "60839" AND DET_CODCLI = "10842684";
    DOCUMENTO: 000001143467
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842684
       ESTADO: SP
         ITEM: 60839
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(349.62)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(26763.04)
      .ValorRetido(1823.72)
      .ValorIcmsSubstitutoItem(2993.63);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{349,62}, objFloatUtils.fStrToFloat('349,62')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240675" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "61569" AND DET_CODCLI = "10843121";
    DOCUMENTO: 000000240675
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10843121
       ESTADO: SP
         ITEM: 61569
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.24)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(827.75)
      .ValorRetido(60)
      .ValorIcmsSubstitutoItem(89);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,24}, objFloatUtils.fStrToFloat('16,24')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240616" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10299" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240616
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 10299
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.59)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2112.66)
      .ValorRetido(240.96)
      .ValorIcmsSubstitutoItem(139.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,59}, objFloatUtils.fStrToFloat('17,59')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240702" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10299" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240702
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 10299
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(21)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2112.66)
      .ValorRetido(240.96)
      .ValorIcmsSubstitutoItem(139.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{21}, objFloatUtils.fStrToFloat('21')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277221" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "24707" AND DET_CODCLI = "10094914";
    DOCUMENTO: 000000277221
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10094914
       ESTADO: SP
         ITEM: 24707
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(42.12)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2988.11)
      .ValorRetido(261.11)
      .ValorIcmsSubstitutoItem(276.75);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{42,12}, objFloatUtils.fStrToFloat('42,12')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143734" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16113" AND DET_CODCLI = "10842969";
    DOCUMENTO: 000001143734
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842969
       ESTADO: SP
         ITEM: 16113
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(15.47)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1281.72)
      .ValorRetido(109.12)
      .ValorIcmsSubstitutoItem(121.59);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{15,47}, objFloatUtils.fStrToFloat('15,47')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58916" AND DET_CODCLI = "10843065";
    DOCUMENTO: 000001144018
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843065
       ESTADO: SP
         ITEM: 58916
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(27.09)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(379.09)
      .ValorRetido(26.75)
      .ValorIcmsSubstitutoItem(41.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{27,09}, objFloatUtils.fStrToFloat('27,09')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240672" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "57903" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240672
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 57903
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(97.59)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(486.36)
      .ValorRetido(35.24)
      .ValorIcmsSubstitutoItem(52.3);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{97,59}, objFloatUtils.fStrToFloat('97,59')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240623" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "58916" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240623
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 58916
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(23)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(379.09)
      .ValorRetido(26.75)
      .ValorIcmsSubstitutoItem(41.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{23}, objFloatUtils.fStrToFloat('23')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277216" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02625" AND DET_CODCLI = "10033154";
    DOCUMENTO: 000000277216
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10033154
       ESTADO: SP
         ITEM: 02625
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(48)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(10.98)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(519.27)
      .ValorRetido(40.7)
      .ValorIcmsSubstitutoItem(52.77);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{10,98}, objFloatUtils.fStrToFloat('10,98')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144076" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "57905" AND DET_CODCLI = "10737971";
    DOCUMENTO: 000001144076
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10737971
       ESTADO: SP
         ITEM: 57905
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(240)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(26.39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(968.79)
      .ValorRetido(84.65)
      .ValorIcmsSubstitutoItem(89.73);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{26,39}, objFloatUtils.fStrToFloat('26,39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143734" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "57905" AND DET_CODCLI = "10842969";
    DOCUMENTO: 000001143734
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842969
       ESTADO: SP
         ITEM: 57905
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(240)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.71)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(968.79)
      .ValorRetido(84.65)
      .ValorIcmsSubstitutoItem(89.73);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,71}, objFloatUtils.fStrToFloat('9,71')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143551" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "63586" AND DET_CODCLI = "10441570";
    DOCUMENTO: 000001143551
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10441570
       ESTADO: SP
         ITEM: 63586
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1066)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(109.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(57007.93)
      .ValorRetido(3092.89)
      .ValorIcmsSubstitutoItem(3748.06);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{109,8}, objFloatUtils.fStrToFloat('109,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143974" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "65174" AND DET_CODCLI = "10009090";
    DOCUMENTO: 000001143974
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10009090
       ESTADO: SP
         ITEM: 65174
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(25)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8.5316)
      .ValorRetido(1.535688)
      .ValorIcmsSubstitutoItem(5.65);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,9}, objFloatUtils.fStrToFloat('8,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143592" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "64356" AND DET_CODCLI = "10842824";
    DOCUMENTO: 000001143592
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842824
       ESTADO: SP
         ITEM: 64356
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(65.78)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18028.98)
      .ValorRetido(1306.62)
      .ValorIcmsSubstitutoItem(1938.6);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{65,78}, objFloatUtils.fStrToFloat('65,78')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143645" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54688" AND DET_CODCLI = "10842962";
    DOCUMENTO: 000001143645
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842962
       ESTADO: SP
         ITEM: 54688
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(79.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(693.7)
      .ValorRetido(50.28)
      .ValorIcmsSubstitutoItem(74.59);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{79,9}, objFloatUtils.fStrToFloat('79,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143615" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "64356" AND DET_CODCLI = "10381738";
    DOCUMENTO: 000001143615
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10381738
       ESTADO: SP
         ITEM: 64356
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(74.18)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18028.98)
      .ValorRetido(1306.62)
      .ValorIcmsSubstitutoItem(1938.6);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{74,18}, objFloatUtils.fStrToFloat('74,18')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143628" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55170" AND DET_CODCLI = "10842837";
    DOCUMENTO: 000001143628
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842837
       ESTADO: SP
         ITEM: 55170
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(59.23)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(51015.3)
      .ValorRetido(3827.75)
      .ValorIcmsSubstitutoItem(5355);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{59,23}, objFloatUtils.fStrToFloat('59,23')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144076" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54635" AND DET_CODCLI = "10737971";
    DOCUMENTO: 000001144076
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10737971
       ESTADO: SP
         ITEM: 54635
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(400)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.26)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(5958.32)
      .ValorRetido(466.98)
      .ValorIcmsSubstitutoItem(605.52);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,26}, objFloatUtils.fStrToFloat('17,26')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55182" AND DET_CODCLI = "10823518";
    DOCUMENTO: 000001143888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10823518
       ESTADO: SP
         ITEM: 55182
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.26)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(188)
      .ValorRetido(15.3)
      .ValorIcmsSubstitutoItem(18.54);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,26}, objFloatUtils.fStrToFloat('6,26')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143743" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55170" AND DET_CODCLI = "10037923";
    DOCUMENTO: 000001143743
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10037923
       ESTADO: SP
         ITEM: 55170
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(54.63)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(51015.3)
      .ValorRetido(3827.75)
      .ValorIcmsSubstitutoItem(5355);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{54,63}, objFloatUtils.fStrToFloat('54,63')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144024" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55170" AND DET_CODCLI = "10843036";
    DOCUMENTO: 000001144024
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843036
       ESTADO: SP
         ITEM: 55170
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(54.97)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(51015.3)
      .ValorRetido(3827.75)
      .ValorIcmsSubstitutoItem(5355);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{54,97}, objFloatUtils.fStrToFloat('54,97')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143734" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55657" AND DET_CODCLI = "10842969";
    DOCUMENTO: 000001143734
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842969
       ESTADO: SP
         ITEM: 55657
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(600)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14.05)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6259.42)
      .ValorRetido(490.58)
      .ValorIcmsSubstitutoItem(636.12);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14,05}, objFloatUtils.fStrToFloat('14,05')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143818" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55171" AND DET_CODCLI = "10746031";
    DOCUMENTO: 000001143818
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10746031
       ESTADO: SP
         ITEM: 55171
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(450)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(60)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(20163.48)
      .ValorRetido(1512.9)
      .ValorIcmsSubstitutoItem(2116.53);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{60}, objFloatUtils.fStrToFloat('60')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144043" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55182" AND DET_CODCLI = "10843035";
    DOCUMENTO: 000001144043
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843035
       ESTADO: SP
         ITEM: 55182
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.17)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(188)
      .ValorRetido(15.3)
      .ValorIcmsSubstitutoItem(18.54);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,17}, objFloatUtils.fStrToFloat('7,17')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143815" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55170" AND DET_CODCLI = "10843083";
    DOCUMENTO: 000001143815
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843083
       ESTADO: SP
         ITEM: 55170
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(65.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(51015.3)
      .ValorRetido(3827.75)
      .ValorIcmsSubstitutoItem(5355);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{65,43}, objFloatUtils.fStrToFloat('65,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240740" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "54655" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240740
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 54655
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(53.33)
      .ValorBaseCalculoEfetiva(18.16)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(471.4)
      .ValorRetido(17.56)
      .ValorIcmsSubstitutoItem(39.01);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{53,33}, objFloatUtils.fStrToFloat('53,33')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{18,16}, objFloatUtils.fStrToFloat('18,16')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240667" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "54718" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240667
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 54718
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(240)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.01)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3254.26)
      .ValorRetido(235.85)
      .ValorIcmsSubstitutoItem(349.92);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,01}, objFloatUtils.fStrToFloat('16,01')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000013742" AND DET_ESPDOC = "UC" AND DET_CODEMP = "001" AND DET_CODITE = "64661" AND DET_CODCLI = "10005994";
    DOCUMENTO: 000000013742
      ESPECIE: UC
      EMPRESA: 001
      CLIENTE: 10005994
       ESTADO: SP
         ITEM: 64661
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: UC}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(False)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(62.77)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1094.6)
      .ValorRetido(85.79)
      .ValorIcmsSubstitutoItem(111.24);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{91,22}, objFloatUtils.fStrToFloat('91,22')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{7,14}, objFloatUtils.fStrToFloat('7,14')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240709" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "54718" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240709
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 54718
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(240)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(42)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3254.26)
      .ValorRetido(235.85)
      .ValorIcmsSubstitutoItem(349.92);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{42}, objFloatUtils.fStrToFloat('42')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143814" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54717" AND DET_CODCLI = "10007134";
    DOCUMENTO: 000001143814
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10007134
       ESTADO: SP
         ITEM: 54717
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(740)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(26)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12020.77)
      .ValorRetido(978.26)
      .ValorIcmsSubstitutoItem(1185.48);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{26}, objFloatUtils.fStrToFloat('26')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240730" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "59042" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240730
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 59042
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(114)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(125.567)
      .ValorRetido(22.60206)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{114}, objFloatUtils.fStrToFloat('114')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143486" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55085" AND DET_CODCLI = "10842707";
    DOCUMENTO: 000001143486
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842707
       ESTADO: SP
         ITEM: 55085
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(44.56)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(45276)
      .ValorRetido(2140.32)
      .ValorIcmsSubstitutoItem(3292.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{44,56}, objFloatUtils.fStrToFloat('44,56')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55085" AND DET_CODCLI = "10798437";
    DOCUMENTO: 000001144030
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10798437
       ESTADO: SP
         ITEM: 55085
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(39.28)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(45276)
      .ValorRetido(2140.32)
      .ValorIcmsSubstitutoItem(3292.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{39,28}, objFloatUtils.fStrToFloat('39,28')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144043" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55164" AND DET_CODCLI = "10843035";
    DOCUMENTO: 000001144043
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843035
       ESTADO: SP
         ITEM: 55164
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.13)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(65.71)
      .ValorRetido(5.35)
      .ValorIcmsSubstitutoItem(6.48);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,13}, objFloatUtils.fStrToFloat('8,13')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143501" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62742" AND DET_CODCLI = "10234392";
    DOCUMENTO: 000001143501
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10234392
       ESTADO: SP
         ITEM: 62742
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(47.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(516.34)
      .ValorRetido(36.69)
      .ValorIcmsSubstitutoItem(56.25);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{47,6}, objFloatUtils.fStrToFloat('47,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143633" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56111" AND DET_CODCLI = "10842769";
    DOCUMENTO: 000001143633
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842769
       ESTADO: SP
         ITEM: 56111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(37.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(148.47)
      .ValorRetido(10.55)
      .ValorIcmsSubstitutoItem(16.17);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{37,2}, objFloatUtils.fStrToFloat('37,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143801" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55922" AND DET_CODCLI = "10842857";
    DOCUMENTO: 000001143801
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842857
       ESTADO: SP
         ITEM: 55922
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(500)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(30.66)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12770.35)
      .ValorRetido(1000.86)
      .ValorIcmsSubstitutoItem(1297.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{30,66}, objFloatUtils.fStrToFloat('30,66')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55164" AND DET_CODCLI = "10823518";
    DOCUMENTO: 000001143888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10823518
       ESTADO: SP
         ITEM: 55164
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.08)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(65.71)
      .ValorRetido(5.35)
      .ValorIcmsSubstitutoItem(6.48);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,08}, objFloatUtils.fStrToFloat('7,08')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240729" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "55085" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240729
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 55085
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(45276)
      .ValorRetido(2140.32)
      .ValorIcmsSubstitutoItem(3292.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{36}, objFloatUtils.fStrToFloat('36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144009" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62740" AND DET_CODCLI = "10695081";
    DOCUMENTO: 000001144009
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10695081
       ESTADO: SP
         ITEM: 62740
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(101.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2219.39)
      .ValorRetido(144.14)
      .ValorIcmsSubstitutoItem(255.35);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{101,4}, objFloatUtils.fStrToFloat('101,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240659" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "55085" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240659
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 55085
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(53)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(45276)
      .ValorRetido(2140.32)
      .ValorIcmsSubstitutoItem(3292.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{53}, objFloatUtils.fStrToFloat('53')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "55183" AND DET_CODCLI = "10823518";
    DOCUMENTO: 000001143888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10823518
       ESTADO: SP
         ITEM: 55183
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.06)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(171.94)
      .ValorRetido(13.99)
      .ValorIcmsSubstitutoItem(16.96);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,06}, objFloatUtils.fStrToFloat('4,06')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143519" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11501" AND DET_CODCLI = "10009072";
    DOCUMENTO: 000001143519
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10009072
       ESTADO: SP
         ITEM: 11501
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(435)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(209.96)
      .ValorRetido(14.3)
      .ValorIcmsSubstitutoItem(23.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{435}, objFloatUtils.fStrToFloat('435')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143508" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "57562" AND DET_CODCLI = "10842657";
    DOCUMENTO: 000001143508
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842657
       ESTADO: SP
         ITEM: 57562
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.61)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2679.6)
      .ValorRetido(169.13)
      .ValorIcmsSubstitutoItem(313.2);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,61}, objFloatUtils.fStrToFloat('5,61')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "57562" AND DET_CODCLI = "10823518";
    DOCUMENTO: 000001143888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10823518
       ESTADO: SP
         ITEM: 57562
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.09)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2679.6)
      .ValorRetido(169.13)
      .ValorIcmsSubstitutoItem(313.2);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,09}, objFloatUtils.fStrToFloat('5,09')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240738" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "54631" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240738
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 54631
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(36)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.27)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(568.77)
      .ValorRetido(44.58)
      .ValorIcmsSubstitutoItem(57.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,27}, objFloatUtils.fStrToFloat('17,27')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143636" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62933" AND DET_CODCLI = "10842719";
    DOCUMENTO: 000001143636
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842719
       ESTADO: SP
         ITEM: 62933
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(38.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(905.98)
      .ValorRetido(65.66)
      .ValorIcmsSubstitutoItem(97.42);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{38,9}, objFloatUtils.fStrToFloat('38,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240669" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01791" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240669
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01791
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.55)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(216.71)
      .ValorRetido(18.03)
      .ValorIcmsSubstitutoItem(20.98);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,55}, objFloatUtils.fStrToFloat('1,55')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240731" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01794" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240731
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01794
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(600)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.52)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(167.12)
      .ValorRetido(13.9)
      .ValorIcmsSubstitutoItem(16.18);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,52}, objFloatUtils.fStrToFloat('0,52')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54687" AND DET_CODCLI = "10842919";
    DOCUMENTO: 000001143483
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842919
       ESTADO: SP
         ITEM: 54687
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(400)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(23.89)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8574.72)
      .ValorRetido(749.29)
      .ValorIcmsSubstitutoItem(794.16);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{23,89}, objFloatUtils.fStrToFloat('23,89')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143783" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62765" AND DET_CODCLI = "10833901";
    DOCUMENTO: 000001143783
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10833901
       ESTADO: SP
         ITEM: 62765
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(25.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2110.85)
      .ValorRetido(113.05)
      .ValorIcmsSubstitutoItem(140.26);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{25,8}, objFloatUtils.fStrToFloat('25,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240681" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "30032" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240681
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 30032
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(25)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(46.45)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1382.5)
      .ValorRetido(74.04)
      .ValorIcmsSubstitutoItem(91.86);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{46,45}, objFloatUtils.fStrToFloat('46,45')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143561" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28770" AND DET_CODCLI = "10116173";
    DOCUMENTO: 000001143561
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10116173
       ESTADO: SP
         ITEM: 28770
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(54.63)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9007.43)
      .ValorRetido(482.39)
      .ValorIcmsSubstitutoItem(598.5);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{54,63}, objFloatUtils.fStrToFloat('54,63')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143744" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28770" AND DET_CODCLI = "10842816";
    DOCUMENTO: 000001143744
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842816
       ESTADO: SP
         ITEM: 28770
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(57.93)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9007.43)
      .ValorRetido(482.39)
      .ValorIcmsSubstitutoItem(598.5);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{57,93}, objFloatUtils.fStrToFloat('57,93')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240705" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01024" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240705
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01024
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(15)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.45)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(66.06)
      .ValorRetido(5.49)
      .ValorIcmsSubstitutoItem(6.4);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,45}, objFloatUtils.fStrToFloat('0,45')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277218" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01024" AND DET_CODCLI = "10014341";
    DOCUMENTO: 000000277218
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10014341
       ESTADO: SP
         ITEM: 01024
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.7)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(66.06)
      .ValorRetido(5.49)
      .ValorIcmsSubstitutoItem(6.4);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,7}, objFloatUtils.fStrToFloat('0,7')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240689" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "12753" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240689
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 12753
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.71)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(27.94)
      .ValorRetido(2.32)
      .ValorIcmsSubstitutoItem(2.71);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,71}, objFloatUtils.fStrToFloat('0,71')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240624" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01174" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240624
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01174
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(12)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(63.49)
      .ValorRetido(5.28)
      .ValorIcmsSubstitutoItem(6.15);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,39}, objFloatUtils.fStrToFloat('0,39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000167;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240669" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "50426" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240669
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 50426
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(500)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.17)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(152.73)
      .ValorRetido(12.7)
      .ValorIcmsSubstitutoItem(14.79);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,17}, objFloatUtils.fStrToFloat('2,17')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000168;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143603" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01174" AND DET_CODCLI = "10084846";
    DOCUMENTO: 000001143603
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10084846
       ESTADO: SP
         ITEM: 01174
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(16)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.53)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(63.49)
      .ValorRetido(5.28)
      .ValorIcmsSubstitutoItem(6.15);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,53}, objFloatUtils.fStrToFloat('0,53')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000169;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "09806" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 09806
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(25.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(173.23)
      .ValorRetido(14.41)
      .ValorIcmsSubstitutoItem(16.77);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{25,2}, objFloatUtils.fStrToFloat('25,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000170;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240666" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01190" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240666
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01190
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(50)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.99)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(42.69)
      .ValorRetido(3.55)
      .ValorIcmsSubstitutoItem(4.13);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,99}, objFloatUtils.fStrToFloat('8,99')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000171;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240641" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01003" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240641
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01003
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.32)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(52.86)
      .ValorRetido(4.4)
      .ValorIcmsSubstitutoItem(5.12);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,32}, objFloatUtils.fStrToFloat('0,32')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000172;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144039" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03687" AND DET_CODCLI = "10843000";
    DOCUMENTO: 000001144039
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843000
       ESTADO: SP
         ITEM: 03687
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(39.39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(726.62)
      .ValorRetido(117.44)
      .ValorIcmsSubstitutoItem(13.35);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{39,39}, objFloatUtils.fStrToFloat('39,39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000173;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143996" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05231" AND DET_CODCLI = "10017753";
    DOCUMENTO: 000001143996
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10017753
       ESTADO: SP
         ITEM: 05231
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(144)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(17.3390886102184)
      .ValorRetido(3.12103594983931)
      .ValorIcmsSubstitutoItem(240.95);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{144}, objFloatUtils.fStrToFloat('144')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000174;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143829" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10914" AND DET_CODCLI = "10843121";
    DOCUMENTO: 000001143829
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843121
       ESTADO: SP
         ITEM: 10914
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(28)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(13.12)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3.95)
      .ValorRetido(0.33)
      .ValorIcmsSubstitutoItem(0.38);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{13,12}, objFloatUtils.fStrToFloat('13,12')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000175;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01084" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 01084
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(12)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.18)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(794.01)
      .ValorRetido(66.04)
      .ValorIcmsSubstitutoItem(76.88);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,18}, objFloatUtils.fStrToFloat('5,18')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000176;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143829" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "08190" AND DET_CODCLI = "10843121";
    DOCUMENTO: 000001143829
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843121
       ESTADO: SP
         ITEM: 08190
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(24.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(455.4)
      .ValorRetido(37.88)
      .ValorIcmsSubstitutoItem(44.09);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{24,9}, objFloatUtils.fStrToFloat('24,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000177;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240691" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01175" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240691
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01175
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5000)
      .QuantidadeItem(35)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.51)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(299.47)
      .ValorRetido(24.9)
      .ValorIcmsSubstitutoItem(29);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,51}, objFloatUtils.fStrToFloat('2,51')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000178;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240700" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11118" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240700
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 11118
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.71)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(188.98)
      .ValorRetido(15.72)
      .ValorIcmsSubstitutoItem(18.3);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,71}, objFloatUtils.fStrToFloat('0,71')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000179;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277214" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01763" AND DET_CODCLI = "10001332";
    DOCUMENTO: 000000277214
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10001332
       ESTADO: SP
         ITEM: 01763
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.37)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(33.28)
      .ValorRetido(2.77)
      .ValorIcmsSubstitutoItem(3.22);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,37}, objFloatUtils.fStrToFloat('2,37')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000180;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240721" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01005" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240721
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01005
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.47)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(69.78)
      .ValorRetido(5.8)
      .ValorIcmsSubstitutoItem(6.76);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,47}, objFloatUtils.fStrToFloat('1,47')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000181;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "09898" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 09898
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(15.66)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(679.95)
      .ValorRetido(56.55)
      .ValorIcmsSubstitutoItem(65.84);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{15,66}, objFloatUtils.fStrToFloat('15,66')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000182;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240668" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01176" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240668
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01176
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5000)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(418.88)
      .ValorRetido(34.84)
      .ValorIcmsSubstitutoItem(40.56);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,43}, objFloatUtils.fStrToFloat('0,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000183;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240636" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01004" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240636
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01004
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(99.78)
      .ValorRetido(8.3)
      .ValorIcmsSubstitutoItem(9.66);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,4}, objFloatUtils.fStrToFloat('0,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000184;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01082" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 01082
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(12)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.16)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(665.86)
      .ValorRetido(55.38)
      .ValorIcmsSubstitutoItem(64.47);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,16}, objFloatUtils.fStrToFloat('4,16')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000185;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240731" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01004" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240731
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01004
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.09)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(99.78)
      .ValorRetido(8.3)
      .ValorIcmsSubstitutoItem(9.66);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,09}, objFloatUtils.fStrToFloat('0,09')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000186;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240631" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11452" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240631
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 11452
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(28.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1433.69)
      .ValorRetido(119.25)
      .ValorIcmsSubstitutoItem(138.82);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{28,6}, objFloatUtils.fStrToFloat('28,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000187;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240689" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "10432" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240689
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 10432
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(500)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.58)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(81.34)
      .ValorRetido(6.76)
      .ValorIcmsSubstitutoItem(7.88);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,58}, objFloatUtils.fStrToFloat('0,58')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000188;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240695" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01004" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240695
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01004
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.35)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(99.78)
      .ValorRetido(8.3)
      .ValorIcmsSubstitutoItem(9.66);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,35}, objFloatUtils.fStrToFloat('0,35')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000189;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240669" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01004" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240669
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01004
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(99.78)
      .ValorRetido(8.3)
      .ValorIcmsSubstitutoItem(9.66);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,36}, objFloatUtils.fStrToFloat('0,36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000190;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240731" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01005" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240731
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01005
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.14)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(69.78)
      .ValorRetido(5.8)
      .ValorIcmsSubstitutoItem(6.76);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,14}, objFloatUtils.fStrToFloat('0,14')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000191;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240700" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01176" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240700
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01176
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5000)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(418.88)
      .ValorRetido(34.84)
      .ValorIcmsSubstitutoItem(40.56);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,39}, objFloatUtils.fStrToFloat('0,39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000192;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240731" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01807" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240731
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01807
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.85)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(386.96)
      .ValorRetido(32.18)
      .ValorIcmsSubstitutoItem(37.47);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,85}, objFloatUtils.fStrToFloat('0,85')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000193;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143603" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "43270" AND DET_CODCLI = "10084846";
    DOCUMENTO: 000001143603
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10084846
       ESTADO: SP
         ITEM: 43270
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.67)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(68.36)
      .ValorRetido(5.68)
      .ValorIcmsSubstitutoItem(6.62);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,67}, objFloatUtils.fStrToFloat('4,67')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000194;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240624" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "43270" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240624
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 43270
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.34)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(68.36)
      .ValorRetido(5.68)
      .ValorIcmsSubstitutoItem(6.62);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,34}, objFloatUtils.fStrToFloat('2,34')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000195;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240636" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08146" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240636
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 08146
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(117.46)
      .ValorRetido(9.77)
      .ValorIcmsSubstitutoItem(11.37);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000196;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240733" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "41299" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240733
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 41299
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.74)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(481.14)
      .ValorRetido(34.12)
      .ValorIcmsSubstitutoItem(52.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,74}, objFloatUtils.fStrToFloat('0,74')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000197;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277213" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "08142" AND DET_CODCLI = "10005980";
    DOCUMENTO: 000000277213
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10005980
       ESTADO: SP
         ITEM: 08142
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(34.7)
      .ValorRetido(2.89)
      .ValorIcmsSubstitutoItem(3.36);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,9}, objFloatUtils.fStrToFloat('0,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000198;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277213" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06806" AND DET_CODCLI = "10005980";
    DOCUMENTO: 000000277213
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10005980
       ESTADO: SP
         ITEM: 06806
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(400)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.31)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(46.26)
      .ValorRetido(3.85)
      .ValorIcmsSubstitutoItem(4.48);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,31}, objFloatUtils.fStrToFloat('1,31')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000199;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277214" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "09063" AND DET_CODCLI = "10001332";
    DOCUMENTO: 000000277214
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10001332
       ESTADO: SP
         ITEM: 09063
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.81)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(67.31)
      .ValorRetido(5.6)
      .ValorIcmsSubstitutoItem(6.52);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,81}, objFloatUtils.fStrToFloat('0,81')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000200;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143579" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61279" AND DET_CODCLI = "10843031";
    DOCUMENTO: 000001143579
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843031
       ESTADO: SP
         ITEM: 61279
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(14.326308)
      .ValorRetido(2.57873544)
      .ValorIcmsSubstitutoItem(3.47);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,4}, objFloatUtils.fStrToFloat('17,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000201;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240663" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "42549" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240663
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 42549
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(298)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(15.680304)
      .ValorRetido(2.82245472)
      .ValorIcmsSubstitutoItem(107.28);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,8}, objFloatUtils.fStrToFloat('16,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000202;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143779" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "42549" AND DET_CODCLI = "10842850";
    DOCUMENTO: 000001143779
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842850
       ESTADO: SP
         ITEM: 42549
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(298)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(38.59)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(15.680304)
      .ValorRetido(2.82245472)
      .ValorIcmsSubstitutoItem(107.28);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{38,59}, objFloatUtils.fStrToFloat('38,59')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000203;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240684" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "06489" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240684
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 06489
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(600)
      .QuantidadeItem(5)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.79)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(173.22)
      .ValorRetido(13.68)
      .ValorIcmsSubstitutoItem(17.5);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,79}, objFloatUtils.fStrToFloat('1,79')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000204;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143579" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62634" AND DET_CODCLI = "10843031";
    DOCUMENTO: 000001143579
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843031
       ESTADO: SP
         ITEM: 62634
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(25.89)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(140.81)
      .ValorRetido(11.04)
      .ValorIcmsSubstitutoItem(14.31);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{25,89}, objFloatUtils.fStrToFloat('25,89')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000205;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144119" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62274" AND DET_CODCLI = "10843359";
    DOCUMENTO: 000001144119
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843359
       ESTADO: SP
         ITEM: 62274
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(15)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(56.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(49.398768)
      .ValorRetido(8.89177824)
      .ValorIcmsSubstitutoItem(16.73);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{56,9}, objFloatUtils.fStrToFloat('56,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000206;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143597" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "52526" AND DET_CODCLI = "10842802";
    DOCUMENTO: 000001143597
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842802
       ESTADO: SP
         ITEM: 52526
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(484.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9584.79)
      .ValorRetido(1521.76)
      .ValorIcmsSubstitutoItem(203.5);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{484,9}, objFloatUtils.fStrToFloat('484,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000207;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143730" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06641" AND DET_CODCLI = "10372930";
    DOCUMENTO: 000001143730
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10372930
       ESTADO: SP
         ITEM: 06641
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(45)
      .QuantidadeItem(0.5)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(20.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1558.44)
      .ValorRetido(109.37)
      .ValorIcmsSubstitutoItem(171.15);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{20,5}, objFloatUtils.fStrToFloat('20,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000208;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240686" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "44887" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240686
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 44887
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(25)
      .QuantidadeItem(0.042)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(10)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6254.83)
      .ValorRetido(438.95)
      .ValorIcmsSubstitutoItem(686.93);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000209;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143670" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58297" AND DET_CODCLI = "10132854";
    DOCUMENTO: 000001143670
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10132854
       ESTADO: SP
         ITEM: 58297
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(7)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(70)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(391.19)
      .ValorRetido(27.8)
      .ValorIcmsSubstitutoItem(42.61);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{70}, objFloatUtils.fStrToFloat('70')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000210;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143480" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58920" AND DET_CODCLI = "10841042";
    DOCUMENTO: 000001143480
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10841042
       ESTADO: SP
         ITEM: 58920
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(246.23)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1108.37)
      .ValorRetido(145.97)
      .ValorIcmsSubstitutoItem(53.54);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{246,23}, objFloatUtils.fStrToFloat('246,23')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000211;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61861" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 61861
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(695.21)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2581.87)
      .ValorRetido(340.03)
      .ValorIcmsSubstitutoItem(124.71);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{695,21}, objFloatUtils.fStrToFloat('695,21')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000212;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240690" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "06531" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240690
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 06531
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(34.96)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3044.19)
      .ValorRetido(159.33)
      .ValorIcmsSubstitutoItem(388.62);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{34,96}, objFloatUtils.fStrToFloat('34,96')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000213;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143976" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33818" AND DET_CODCLI = "10843095";
    DOCUMENTO: 000001143976
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843095
       ESTADO: SP
         ITEM: 33818
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(219.78)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10703.63)
      .ValorRetido(1409.65)
      .ValorIcmsSubstitutoItem(517);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{219,78}, objFloatUtils.fStrToFloat('219,78')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000214;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143995" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "37667" AND DET_CODCLI = "10842160";
    DOCUMENTO: 000001143995
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842160
       ESTADO: SP
         ITEM: 37667
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1160)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2003.36)
      .ValorRetido(318.07)
      .ValorIcmsSubstitutoItem(42.54);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1160}, objFloatUtils.fStrToFloat('1160')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000215;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143858" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "43139" AND DET_CODCLI = "10842796";
    DOCUMENTO: 000001143858
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842796
       ESTADO: SP
         ITEM: 43139
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(107.25)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(22320.1)
      .ValorRetido(2230.01)
      .ValorIcmsSubstitutoItem(448.4);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{107,25}, objFloatUtils.fStrToFloat('107,25')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000216;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143591" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "54110" AND DET_CODCLI = "10842674";
    DOCUMENTO: 000001143591
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842674
       ESTADO: SP
         ITEM: 54110
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(699.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(37935.41)
      .ValorRetido(4409.29)
      .ValorIcmsSubstitutoItem(2419.08);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{699,9}, objFloatUtils.fStrToFloat('699,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000217;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143654" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "43139" AND DET_CODCLI = "10030329";
    DOCUMENTO: 000001143654
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030329
       ESTADO: SP
         ITEM: 43139
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(100.06)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(22320.1)
      .ValorRetido(2230.01)
      .ValorIcmsSubstitutoItem(448.4);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{100,06}, objFloatUtils.fStrToFloat('100,06')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000218;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144071" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34585" AND DET_CODCLI = "10331545";
    DOCUMENTO: 000001144071
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10331545
       ESTADO: SP
         ITEM: 34585
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(199.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7591.09)
      .ValorRetido(999.74)
      .ValorIcmsSubstitutoItem(366.66);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{199,8}, objFloatUtils.fStrToFloat('199,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000219;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143792" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "37837" AND DET_CODCLI = "10843054";
    DOCUMENTO: 000001143792
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843054
       ESTADO: SP
         ITEM: 37837
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(72)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7296.55)
      .ValorRetido(1158.46)
      .ValorIcmsSubstitutoItem(154.92);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{72}, objFloatUtils.fStrToFloat('72')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000220;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144096" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61946" AND DET_CODCLI = "10843317";
    DOCUMENTO: 000001144096
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843317
       ESTADO: SP
         ITEM: 61946
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(228.84)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9414.23)
      .ValorRetido(1239.84)
      .ValorIcmsSubstitutoItem(454.72);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{228,84}, objFloatUtils.fStrToFloat('228,84')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000221;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240687" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "50124" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240687
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 50124
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(10)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(258.12)
      .ValorRetido(41.63)
      .ValorIcmsSubstitutoItem(4.83);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000222;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240642" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "53082" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240642
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 53082
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.85)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(221.8)
      .ValorRetido(35.77)
      .ValorIcmsSubstitutoItem(4.15);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,85}, objFloatUtils.fStrToFloat('5,85')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000223;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "50113" AND DET_CODCLI = "10842919";
    DOCUMENTO: 000001143483
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842919
       ESTADO: SP
         ITEM: 50113
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.37)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(409.19)
      .ValorRetido(65.99)
      .ValorIcmsSubstitutoItem(7.66);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,37}, objFloatUtils.fStrToFloat('6,37')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000224;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "50987" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 50987
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(486.69)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2336.58)
      .ValorRetido(372.27)
      .ValorIcmsSubstitutoItem(48.31);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{486,69}, objFloatUtils.fStrToFloat('486,69')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000225;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "50116" AND DET_CODCLI = "10842919";
    DOCUMENTO: 000001143483
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842919
       ESTADO: SP
         ITEM: 50116
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.57)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(488.25)
      .ValorRetido(78.75)
      .ValorIcmsSubstitutoItem(9.14);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,57}, objFloatUtils.fStrToFloat('7,57')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000226;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277217" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "62830" AND DET_CODCLI = "10019542";
    DOCUMENTO: 000000277217
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10019542
       ESTADO: SP
         ITEM: 62830
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(5)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(78)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3017.85)
      .ValorRetido(264.21)
      .ValorIcmsSubstitutoItem(279);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{78}, objFloatUtils.fStrToFloat('78')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000227;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143603" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62831" AND DET_CODCLI = "10084846";
    DOCUMENTO: 000001143603
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10084846
       ESTADO: SP
         ITEM: 62831
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(62.62)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(5256.9)
      .ValorRetido(460.25)
      .ValorIcmsSubstitutoItem(486);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{62,62}, objFloatUtils.fStrToFloat('62,62')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000228;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240727" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "62829" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240727
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 62829
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(12)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1714.92)
      .ValorRetido(150.14)
      .ValorIcmsSubstitutoItem(158.54);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000229;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277227" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "62828" AND DET_CODCLI = "10312726";
    DOCUMENTO: 000000277227
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10312726
       ESTADO: SP
         ITEM: 62828
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(391.34)
      .ValorRetido(34.26)
      .ValorIcmsSubstitutoItem(36.18);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000230;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277226" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "62830" AND DET_CODCLI = "10043788";
    DOCUMENTO: 000000277226
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10043788
       ESTADO: SP
         ITEM: 62830
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(32)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3017.85)
      .ValorRetido(264.21)
      .ValorIcmsSubstitutoItem(279);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{32}, objFloatUtils.fStrToFloat('32')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000231;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143528" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61859" AND DET_CODCLI = "10842934";
    DOCUMENTO: 000001143528
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842934
       ESTADO: SP
         ITEM: 61859
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(518.86)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9562.22)
      .ValorRetido(1259.33)
      .ValorIcmsSubstitutoItem(461.87);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{518,86}, objFloatUtils.fStrToFloat('518,86')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000232;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61865" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 61865
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(484.51)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1149.84)
      .ValorRetido(180.71)
      .ValorIcmsSubstitutoItem(26.26);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{484,51}, objFloatUtils.fStrToFloat('484,51')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000233;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143528" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61866" AND DET_CODCLI = "10842934";
    DOCUMENTO: 000001143528
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842934
       ESTADO: SP
         ITEM: 61866
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(752.02)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3230.96)
      .ValorRetido(425.51)
      .ValorIcmsSubstitutoItem(156.06);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{752,02}, objFloatUtils.fStrToFloat('752,02')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000234;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144078" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "37453" AND DET_CODCLI = "10842981";
    DOCUMENTO: 000001144078
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842981
       ESTADO: SP
         ITEM: 37453
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(53.33)
      .ValorBaseCalculoEfetiva(99.95)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(914.86)
      .ValorRetido(56.61)
      .ValorIcmsSubstitutoItem(53.17);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{53,33}, objFloatUtils.fStrToFloat('53,33')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{99,95}, objFloatUtils.fStrToFloat('99,95')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000235;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240740" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "36026" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240740
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 36026
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(53.33)
      .ValorBaseCalculoEfetiva(59.57)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(129.08)
      .ValorRetido(7.99)
      .ValorIcmsSubstitutoItem(7.5);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{53,33}, objFloatUtils.fStrToFloat('53,33')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{59,57}, objFloatUtils.fStrToFloat('59,57')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000236;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143890" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56135" AND DET_CODCLI = "10842915";
    DOCUMENTO: 000001143890
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842915
       ESTADO: SP
         ITEM: 56135
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(227.51)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10783.81)
      .ValorRetido(296.25)
      .ValorIcmsSubstitutoItem(1644.84);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{227,51}, objFloatUtils.fStrToFloat('227,51')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000237;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144121" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34642" AND DET_CODCLI = "10843127";
    DOCUMENTO: 000001144121
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843127
       ESTADO: SP
         ITEM: 34642
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(180.73)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8957.8)
      .ValorRetido(246.08)
      .ValorIcmsSubstitutoItem(1366.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{180,73}, objFloatUtils.fStrToFloat('180,73')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000238;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144063" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "53508" AND DET_CODCLI = "10166362";
    DOCUMENTO: 000001144063
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10166362
       ESTADO: SP
         ITEM: 53508
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(189.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10783.81)
      .ValorRetido(296.25)
      .ValorIcmsSubstitutoItem(1644.84);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{189,9}, objFloatUtils.fStrToFloat('189,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000239;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143472" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56135" AND DET_CODCLI = "10796324";
    DOCUMENTO: 000001143472
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10796324
       ESTADO: SP
         ITEM: 56135
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(254.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10783.81)
      .ValorRetido(296.25)
      .ValorIcmsSubstitutoItem(1644.84);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{254,8}, objFloatUtils.fStrToFloat('254,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000240;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143665" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34642" AND DET_CODCLI = "10842963";
    DOCUMENTO: 000001143665
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842963
       ESTADO: SP
         ITEM: 34642
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(217.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8957.8)
      .ValorRetido(246.08)
      .ValorIcmsSubstitutoItem(1366.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{217,9}, objFloatUtils.fStrToFloat('217,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000241;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277223" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "42942" AND DET_CODCLI = "10157304";
    DOCUMENTO: 000000277223
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10157304
       ESTADO: SP
         ITEM: 42942
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(800)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.87)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2019.25)
      .ValorRetido(318.67)
      .ValorIcmsSubstitutoItem(44.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,87}, objFloatUtils.fStrToFloat('4,87')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000242;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240632" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "42943" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240632
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 42943
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3200)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(11.37)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(11480.87)
      .ValorRetido(1811.84)
      .ValorIcmsSubstitutoItem(254.72);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{11,37}, objFloatUtils.fStrToFloat('11,37')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000243;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "42944" AND DET_CODCLI = "10059494";
    DOCUMENTO: 000001143564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10059494
       ESTADO: SP
         ITEM: 42944
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1500)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9952.01)
      .ValorRetido(1570.56)
      .ValorIcmsSubstitutoItem(220.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,4}, objFloatUtils.fStrToFloat('6,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000244;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143802" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "64305" AND DET_CODCLI = "10842971";
    DOCUMENTO: 000001143802
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842971
       ESTADO: SP
         ITEM: 64305
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(319.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(16146.22)
      .ValorRetido(1100.38)
      .ValorIcmsSubstitutoItem(1805.94);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{319,9}, objFloatUtils.fStrToFloat('319,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000245;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144071" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "38402" AND DET_CODCLI = "10331545";
    DOCUMENTO: 000001144071
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10331545
       ESTADO: SP
         ITEM: 38402
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(114.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(573.5)
      .ValorRetido(90.51)
      .ValorIcmsSubstitutoItem(12.72);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{114,6}, objFloatUtils.fStrToFloat('114,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000246;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240712" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "36972" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240712
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 36972
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(50)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(151.58)
      .ValorRetido(1.85)
      .ValorIcmsSubstitutoItem(25.44);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{50}, objFloatUtils.fStrToFloat('50')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000247;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240738" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "20427" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240738
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 20427
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.95)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.05)
      .ValorRetido(2.73)
      .ValorIcmsSubstitutoItem(14.02);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,95}, objFloatUtils.fStrToFloat('1,95')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000248;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240656" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "20427" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240656
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 20427
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.05)
      .ValorRetido(2.73)
      .ValorIcmsSubstitutoItem(14.02);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,36}, objFloatUtils.fStrToFloat('0,36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000249;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240671" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "20427" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240671
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 20427
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(16)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(93.05)
      .ValorRetido(2.73)
      .ValorIcmsSubstitutoItem(14.02);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,6}, objFloatUtils.fStrToFloat('1,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000250;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240622" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08099" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240622
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 08099
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(8)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.75)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(72.19)
      .ValorRetido(2.12)
      .ValorIcmsSubstitutoItem(10.87);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,75}, objFloatUtils.fStrToFloat('0,75')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000251;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240639" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08099" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240639
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 08099
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(72.19)
      .ValorRetido(2.12)
      .ValorIcmsSubstitutoItem(10.87);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,8}, objFloatUtils.fStrToFloat('1,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000252;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240693" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03193" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240693
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03193
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(21)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(0)
      .ValorRetido(0)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{21}, objFloatUtils.fStrToFloat('21')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000253;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143733" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02544" AND DET_CODCLI = "10026715";
    DOCUMENTO: 000001143733
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10026715
       ESTADO: SP
         ITEM: 02544
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(500)
      .QuantidadeItem(350)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(210)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(208.07)
      .ValorRetido(9.99)
      .ValorIcmsSubstitutoItem(27.46);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{210}, objFloatUtils.fStrToFloat('210')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000254;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277213" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "10946" AND DET_CODCLI = "10005980";
    DOCUMENTO: 000000277213
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10005980
       ESTADO: SP
         ITEM: 10946
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.42)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(15.03)
      .ValorRetido(0.44)
      .ValorIcmsSubstitutoItem(2.27);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,42}, objFloatUtils.fStrToFloat('0,42')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000255;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240738" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "11433" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240738
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 11433
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.66)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(21.97)
      .ValorRetido(0.64)
      .ValorIcmsSubstitutoItem(3.31);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,66}, objFloatUtils.fStrToFloat('0,66')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000256;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143603" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "08096" AND DET_CODCLI = "10084846";
    DOCUMENTO: 000001143603
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10084846
       ESTADO: SP
         ITEM: 08096
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.09)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(10.04)
      .ValorRetido(0.29)
      .ValorIcmsSubstitutoItem(1.51);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,09}, objFloatUtils.fStrToFloat('0,09')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000257;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03216" AND DET_CODCLI = "10798437";
    DOCUMENTO: 000001144030
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10798437
       ESTADO: SP
         ITEM: 03216
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.44)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(49.17)
      .ValorRetido(1.11)
      .ValorIcmsSubstitutoItem(7.75);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,44}, objFloatUtils.fStrToFloat('8,44')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000258;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144131" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10946" AND DET_CODCLI = "10843409";
    DOCUMENTO: 000001144131
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843409
       ESTADO: SP
         ITEM: 10946
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(5)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.1)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(15.03)
      .ValorRetido(0.44)
      .ValorIcmsSubstitutoItem(2.27);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,1}, objFloatUtils.fStrToFloat('0,1')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000259;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240739" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02264" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240739
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 02264
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1.958107008)
      .ValorRetido(0.35245926144)
      .ValorIcmsSubstitutoItem(2.54);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,2}, objFloatUtils.fStrToFloat('2,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000260;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240672" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "60782" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240672
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 60782
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(204)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(32.52)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6961.36)
      .ValorRetido(504.51)
      .ValorIcmsSubstitutoItem(748.53);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{32,52}, objFloatUtils.fStrToFloat('32,52')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000261;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240651" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "31089" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240651
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 31089
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(18.36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(492.8)
      .ValorRetido(36.21)
      .ValorIcmsSubstitutoItem(52.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{18,36}, objFloatUtils.fStrToFloat('18,36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000262;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240724" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "17977" AND DET_CODCLI = "10021274";
    DOCUMENTO: 000000240724
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10021274
       ESTADO: SP
         ITEM: 17977
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(13.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(655.18)
      .ValorRetido(46.56)
      .ValorIcmsSubstitutoItem(71.37);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{13,43}, objFloatUtils.fStrToFloat('13,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000263;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240724" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "06606" AND DET_CODCLI = "10021274";
    DOCUMENTO: 000000240724
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10021274
       ESTADO: SP
         ITEM: 06606
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.57)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(330.51)
      .ValorRetido(23.49)
      .ValorIcmsSubstitutoItem(36);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,57}, objFloatUtils.fStrToFloat('6,57')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000264;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143720" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "44711" AND DET_CODCLI = "10842966";
    DOCUMENTO: 000001143720
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842966
       ESTADO: SP
         ITEM: 44711
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(7)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(83.64)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(209.9)
      .ValorRetido(15.49)
      .ValorIcmsSubstitutoItem(22.29);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{83,64}, objFloatUtils.fStrToFloat('83,64')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000265;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240656" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03416" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240656
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03416
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(12.44)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(38450.22)
      .ValorRetido(2786.61)
      .ValorIcmsSubstitutoItem(4134.43);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{12,44}, objFloatUtils.fStrToFloat('12,44')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000266;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240664" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03416" AND DET_CODCLI = "10015072";
    DOCUMENTO: 000000240664
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10015072
       ESTADO: SP
         ITEM: 03416
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(3000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(13)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(38450.22)
      .ValorRetido(2786.61)
      .ValorIcmsSubstitutoItem(4134.43);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000267;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143806" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10943" AND DET_CODCLI = "10181345";
    DOCUMENTO: 000001143806
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10181345
       ESTADO: SP
         ITEM: 10943
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_PRU
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(300)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.03)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1776.4)
      .ValorRetido(128.74)
      .ValorIcmsSubstitutoItem(191.01);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,03}, objFloatUtils.fStrToFloat('6,03')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000268;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144130" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "38584" AND DET_CODCLI = "10061389";
    DOCUMENTO: 000001144130
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10061389
       ESTADO: SP
         ITEM: 38584
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.76)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(63.3)
      .ValorRetido(4.96)
      .ValorIcmsSubstitutoItem(6.43);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,76}, objFloatUtils.fStrToFloat('5,76')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000269;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240699" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "38581" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240699
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 38581
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(168)
      .ValorRetido(13.17)
      .ValorIcmsSubstitutoItem(17.07);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000270;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240626" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "53238" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240626
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 53238
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(519.46)
      .ValorRetido(40.71)
      .ValorIcmsSubstitutoItem(52.79);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{43}, objFloatUtils.fStrToFloat('43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000271;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "50553" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 50553
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(63.7)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(5649.5)
      .ValorRetido(409.44)
      .ValorIcmsSubstitutoItem(607.47);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{63,7}, objFloatUtils.fStrToFloat('63,7')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000272;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144029" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "51508" AND DET_CODCLI = "10843110";
    DOCUMENTO: 000001144029
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843110
       ESTADO: SP
         ITEM: 51508
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(46.87)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1104.36)
      .ValorRetido(86.55)
      .ValorIcmsSubstitutoItem(112.23);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{46,87}, objFloatUtils.fStrToFloat('46,87')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000273;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240710" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "04306" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240710
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 04306
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(118)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(614.88)
      .ValorRetido(52.35)
      .ValorIcmsSubstitutoItem(58.33);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{118}, objFloatUtils.fStrToFloat('118')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000274;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05580" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 05580
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(69.3)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(814.02)
      .ValorRetido(58.99)
      .ValorIcmsSubstitutoItem(87.53);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{69,3}, objFloatUtils.fStrToFloat('69,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000275;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143640" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11862" AND DET_CODCLI = "10475094";
    DOCUMENTO: 000001143640
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10475094
       ESTADO: SP
         ITEM: 11862
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(4)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(225)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(693.3)
      .ValorRetido(49.27)
      .ValorIcmsSubstitutoItem(75.52);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{225}, objFloatUtils.fStrToFloat('225')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000276;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277228" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04301" AND DET_CODCLI = "10026129";
    DOCUMENTO: 000000277228
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10026129
       ESTADO: SP
         ITEM: 04301
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2880)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(10.76)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(35004.78)
      .ValorRetido(2980.25)
      .ValorIcmsSubstitutoItem(3320.61);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{10,76}, objFloatUtils.fStrToFloat('10,76')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000277;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143579" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "40342" AND DET_CODCLI = "10843031";
    DOCUMENTO: 000001143579
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843031
       ESTADO: SP
         ITEM: 40342
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1056)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(200.73)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(191882.81)
      .ValorRetido(13636.64)
      .ValorIcmsSubstitutoItem(20902.27);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{200,73}, objFloatUtils.fStrToFloat('200,73')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000278;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240708" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "40342" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240708
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 40342
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1056)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(162)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(191882.81)
      .ValorRetido(13636.64)
      .ValorIcmsSubstitutoItem(20902.27);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{162}, objFloatUtils.fStrToFloat('162')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000279;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240720" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13738" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240720
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 13738
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(70.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(326.05)
      .ValorRetido(23.17)
      .ValorIcmsSubstitutoItem(35.52);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{70,9}, objFloatUtils.fStrToFloat('70,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000280;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240654" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02980" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240654
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 02980
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(120)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14.48)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1737.76)
      .ValorRetido(118.89)
      .ValorIcmsSubstitutoItem(193.91);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14,48}, objFloatUtils.fStrToFloat('14,48')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000281;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144040" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "64127" AND DET_CODCLI = "10842948";
    DOCUMENTO: 000001144040
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842948
       ESTADO: SP
         ITEM: 64127
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(77.1)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(707.46)
      .ValorRetido(53.51)
      .ValorIcmsSubstitutoItem(73.83);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{77,1}, objFloatUtils.fStrToFloat('77,1')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000282;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143947" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "64109" AND DET_CODCLI = "10843163";
    DOCUMENTO: 000001143947
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843163
       ESTADO: MG
         ITEM: 64109
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(15)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(45)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(661.57)
      .ValorRetido(41.76)
      .ValorIcmsSubstitutoItem(77.33);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{45}, objFloatUtils.fStrToFloat('45')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000283;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240703" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "64139" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240703
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 64139
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2016)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.27)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3461.67)
      .ValorRetido(218.49)
      .ValorIcmsSubstitutoItem(404.61);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,27}, objFloatUtils.fStrToFloat('16,27')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000284;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "44619" AND DET_CODCLI = "10798437";
    DOCUMENTO: 000001144030
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10798437
       ESTADO: SP
         ITEM: 44619
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(48)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(40.91)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2770.33)
      .ValorRetido(235.86)
      .ValorIcmsSubstitutoItem(262.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{40,91}, objFloatUtils.fStrToFloat('40,91')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000285;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143603" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06616" AND DET_CODCLI = "10084846";
    DOCUMENTO: 000001143603
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10084846
       ESTADO: SP
         ITEM: 06616
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.71)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(647.77)
      .ValorRetido(46.04)
      .ValorIcmsSubstitutoItem(70.56);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,71}, objFloatUtils.fStrToFloat('6,71')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000286;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240654" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "64135" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240654
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 64135
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(60)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(14.12)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(916.67)
      .ValorRetido(57.86)
      .ValorIcmsSubstitutoItem(107.14);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{14,12}, objFloatUtils.fStrToFloat('14,12')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000287;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "38931" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 38931
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.29)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(89.34)
      .ValorRetido(10.44)
      .ValorIcmsSubstitutoItem(5.64);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,29}, objFloatUtils.fStrToFloat('7,29')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000288;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240672" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "09146" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240672
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 09146
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(5543.06)
      .ValorRetido(300.74)
      .ValorIcmsSubstitutoItem(364.43);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,2}, objFloatUtils.fStrToFloat('6,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000289;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144131" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "22034" AND DET_CODCLI = "10843409";
    DOCUMENTO: 000001144131
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843409
       ESTADO: SP
         ITEM: 22034
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7307.51)
      .ValorRetido(396.45)
      .ValorIcmsSubstitutoItem(480.45);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,9}, objFloatUtils.fStrToFloat('4,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000290;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240672" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "22034" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240672
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 22034
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2000)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(4.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7307.51)
      .ValorRetido(396.45)
      .ValorIcmsSubstitutoItem(480.45);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{4,4}, objFloatUtils.fStrToFloat('4,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000291;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240723" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "31441" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240723
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 31441
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(230)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(644.64)
      .ValorRetido(40.69)
      .ValorIcmsSubstitutoItem(75.35);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,8}, objFloatUtils.fStrToFloat('2,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000292;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143693" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03299" AND DET_CODCLI = "10004875";
    DOCUMENTO: 000001143693
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10004875
       ESTADO: SP
         ITEM: 03299
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(640)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(15.3)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3144.06)
      .ValorRetido(198.44)
      .ValorIcmsSubstitutoItem(367.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{15,3}, objFloatUtils.fStrToFloat('15,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000293;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240733" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03299" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240733
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03299
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(640)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.61)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3144.06)
      .ValorRetido(198.44)
      .ValorIcmsSubstitutoItem(367.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,61}, objFloatUtils.fStrToFloat('5,61')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000294;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240700" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03299" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240700
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03299
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(640)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5.45)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(3144.06)
      .ValorRetido(198.44)
      .ValorIcmsSubstitutoItem(367.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5,45}, objFloatUtils.fStrToFloat('5,45')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000295;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143723" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25646" AND DET_CODCLI = "10410792";
    DOCUMENTO: 000001143723
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10410792
       ESTADO: SP
         ITEM: 25646
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(29.26)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(27.9528728184576)
      .ValorRetido(5.03151710732237)
      .ValorIcmsSubstitutoItem(7.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{29,26}, objFloatUtils.fStrToFloat('29,26')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000296;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143979" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58111" AND DET_CODCLI = "10843138";
    DOCUMENTO: 000001143979
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843138
       ESTADO: SP
         ITEM: 58111
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(493.3)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7883.59)
      .ValorRetido(537.21)
      .ValorIcmsSubstitutoItem(881.83);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{493,3}, objFloatUtils.fStrToFloat('493,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000297;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240614" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "52691" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240614
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 52691
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(180)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(164.4)
      .ValorRetido(13.38)
      .ValorIcmsSubstitutoItem(16.21);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{180}, objFloatUtils.fStrToFloat('180')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000298;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240676" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "61073" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240676
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 61073
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(62)
      .AliquotaIcmsEfetiva(12)
      .ValorBaseRetida(454.2)
      .ValorRetido(61.17)
      .ValorIcmsSubstitutoItem(20.59);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{62}, objFloatUtils.fStrToFloat('62')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{7,44}, objFloatUtils.fStrToFloat('7,44')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000299;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143579" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "60619" AND DET_CODCLI = "10843031";
    DOCUMENTO: 000001143579
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843031
       ESTADO: SP
         ITEM: 60619
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(25.3)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(258.88)
      .ValorRetido(29.08)
      .ValorIcmsSubstitutoItem(17.52);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{25,3}, objFloatUtils.fStrToFloat('25,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000300;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143585" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27260" AND DET_CODCLI = "10805458";
    DOCUMENTO: 000001143585
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10805458
       ESTADO: SP
         ITEM: 27260
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(564.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(29973.93)
      .ValorRetido(2042.52)
      .ValorIcmsSubstitutoItem(3352.79);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{564,5}, objFloatUtils.fStrToFloat('564,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000301;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143935" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58043" AND DET_CODCLI = "10843163";
    DOCUMENTO: 000001143935
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843163
       ESTADO: MG
         ITEM: 58043
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(705.96)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8682.13)
      .ValorRetido(591.63)
      .ValorIcmsSubstitutoItem(971.15);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{705,96}, objFloatUtils.fStrToFloat('705,96')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000302;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143508" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58110" AND DET_CODCLI = "10842657";
    DOCUMENTO: 000001143508
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842657
       ESTADO: SP
         ITEM: 58110
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(246.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(14096.77)
      .ValorRetido(960.6)
      .ValorIcmsSubstitutoItem(1576.82);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{246,43}, objFloatUtils.fStrToFloat('246,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000303;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143473" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "56008" AND DET_CODCLI = "10842650";
    DOCUMENTO: 000001143473
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842650
       ESTADO: SP
         ITEM: 56008
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(35)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(259.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(4754.34)
      .ValorRetido(323.98)
      .ValorIcmsSubstitutoItem(531.81);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{259,9}, objFloatUtils.fStrToFloat('259,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000304;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "58110" AND DET_CODCLI = "10823518";
    DOCUMENTO: 000001143888
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10823518
       ESTADO: SP
         ITEM: 58110
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(224)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(14096.77)
      .ValorRetido(960.6)
      .ValorIcmsSubstitutoItem(1576.82);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{224}, objFloatUtils.fStrToFloat('224')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000305;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240658" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "52682" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240658
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 52682
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(11)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(136.16)
      .ValorRetido(7.39)
      .ValorIcmsSubstitutoItem(8.95);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000306;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240661" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "52679" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240661
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 52679
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(31.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(379.46)
      .ValorRetido(20.58)
      .ValorIcmsSubstitutoItem(24.95);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{31,5}, objFloatUtils.fStrToFloat('31,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000307;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144131" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "52828" AND DET_CODCLI = "10843409";
    DOCUMENTO: 000001144131
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843409
       ESTADO: SP
         ITEM: 52828
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(43.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(228.05)
      .ValorRetido(18.56)
      .ValorIcmsSubstitutoItem(22.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{43,6}, objFloatUtils.fStrToFloat('43,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000308;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143614" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "38951" AND DET_CODCLI = "10030080";
    DOCUMENTO: 000001143614
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030080
       ESTADO: SP
         ITEM: 38951
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.7)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(105.36)
      .ValorRetido(12.31)
      .ValorIcmsSubstitutoItem(6.65);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,7}, objFloatUtils.fStrToFloat('8,7')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000309;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240648" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "15863" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240648
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 15863
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(500)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(0.15205489728)
      .ValorRetido(0.0273698815104)
      .ValorIcmsSubstitutoItem(5.61);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,8}, objFloatUtils.fStrToFloat('1,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000310;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240638" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "42096" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240638
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 42096
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1070.04)
      .ValorRetido(80.29)
      .ValorIcmsSubstitutoItem(112.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000311;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144019" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "38957" AND DET_CODCLI = "10336769";
    DOCUMENTO: 000001144019
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10336769
       ESTADO: SP
         ITEM: 38957
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(49)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(682.46)
      .ValorRetido(79.76)
      .ValorIcmsSubstitutoItem(43.08);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{49}, objFloatUtils.fStrToFloat('49')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000312;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240645" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "07953" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240645
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 07953
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(53.33)
      .ValorBaseCalculoEfetiva(16)
      .AliquotaIcmsEfetiva(12)
      .ValorBaseRetida(68.61)
      .ValorRetido(1.14)
      .ValorIcmsSubstitutoItem(7.1);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{53,33}, objFloatUtils.fStrToFloat('53,33')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16}, objFloatUtils.fStrToFloat('16')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{1,92}, objFloatUtils.fStrToFloat('1,92')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000313;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143614" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "38935" AND DET_CODCLI = "10030080";
    DOCUMENTO: 000001143614
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10030080
       ESTADO: SP
         ITEM: 38935
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(12)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.1)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(98.77)
      .ValorRetido(11.54)
      .ValorIcmsSubstitutoItem(6.24);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,1}, objFloatUtils.fStrToFloat('8,1')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000314;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240704" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "60691" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240704
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 60691
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(40.2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(952.88)
      .ValorRetido(107.87)
      .ValorIcmsSubstitutoItem(63.65);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{40,2}, objFloatUtils.fStrToFloat('40,2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000315;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240647" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "63062" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240647
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 63062
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(53.33)
      .ValorBaseCalculoEfetiva(28.3)
      .AliquotaIcmsEfetiva(12)
      .ValorBaseRetida(71.54)
      .ValorRetido(1.18)
      .ValorIcmsSubstitutoItem(7.4);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{53,33}, objFloatUtils.fStrToFloat('53,33')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{28,3}, objFloatUtils.fStrToFloat('28,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{3,4}, objFloatUtils.fStrToFloat('3,4')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000316;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144105" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61705" AND DET_CODCLI = "10843139";
    DOCUMENTO: 000001144105
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843139
       ESTADO: SP
         ITEM: 61705
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(176.39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12082.79)
      .ValorRetido(331.89)
      .ValorIcmsSubstitutoItem(1843.01);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{176,39}, objFloatUtils.fStrToFloat('176,39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000317;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143944" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61705" AND DET_CODCLI = "10843122";
    DOCUMENTO: 000001143944
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843122
       ESTADO: SP
         ITEM: 61705
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(389.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12082.79)
      .ValorRetido(331.89)
      .ValorIcmsSubstitutoItem(1843.01);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{389,8}, objFloatUtils.fStrToFloat('389,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000318;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143793" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61706" AND DET_CODCLI = "10843027";
    DOCUMENTO: 000001143793
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843027
       ESTADO: SP
         ITEM: 61706
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(186.47)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(13046.49)
      .ValorRetido(358.36)
      .ValorIcmsSubstitutoItem(1990);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{186,47}, objFloatUtils.fStrToFloat('186,47')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000319;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143485" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61706" AND DET_CODCLI = "10842752";
    DOCUMENTO: 000001143485
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842752
       ESTADO: SP
         ITEM: 61706
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(203.6)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(13046.49)
      .ValorRetido(358.36)
      .ValorIcmsSubstitutoItem(1990);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{203,6}, objFloatUtils.fStrToFloat('203,6')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000320;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143939" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61706" AND DET_CODCLI = "10843118";
    DOCUMENTO: 000001143939
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843118
       ESTADO: SP
         ITEM: 61706
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(220.79)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(13046.49)
      .ValorRetido(358.36)
      .ValorIcmsSubstitutoItem(1990);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{220,79}, objFloatUtils.fStrToFloat('220,79')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000321;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143953" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61707" AND DET_CODCLI = "10843107";
    DOCUMENTO: 000001143953
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843107
       ESTADO: SP
         ITEM: 61707
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(96)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(186.47)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8697.66)
      .ValorRetido(238.91)
      .ValorIcmsSubstitutoItem(1326.67);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{186,47}, objFloatUtils.fStrToFloat('186,47')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000322;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143544" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "61706" AND DET_CODCLI = "10842925";
    DOCUMENTO: 000001143544
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842925
       ESTADO: SP
         ITEM: 61706
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(144)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(209.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(13046.49)
      .ValorRetido(358.36)
      .ValorIcmsSubstitutoItem(1990);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{209,9}, objFloatUtils.fStrToFloat('209,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000323;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20428" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 20428
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.82)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(108.35)
      .ValorRetido(12.66)
      .ValorIcmsSubstitutoItem(6.84);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,82}, objFloatUtils.fStrToFloat('17,82')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000324;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07216" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 07216
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.51)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(30.03)
      .ValorRetido(3.51)
      .ValorIcmsSubstitutoItem(1.9);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,51}, objFloatUtils.fStrToFloat('3,51')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000325;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07220" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 07220
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(3)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(10.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(31.36)
      .ValorRetido(3.66)
      .ValorIcmsSubstitutoItem(1.98);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{10,8}, objFloatUtils.fStrToFloat('10,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000326;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "08270" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 08270
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(250)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(38.52)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9615.62)
      .ValorRetido(1088.51)
      .ValorIcmsSubstitutoItem(642.3);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{38,52}, objFloatUtils.fStrToFloat('38,52')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000327;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07217" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 07217
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.51)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(28.51)
      .ValorRetido(3.33)
      .ValorIcmsSubstitutoItem(1.8);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,51}, objFloatUtils.fStrToFloat('3,51')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000328;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07219" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 07219
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(30)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(21.06)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(85.54)
      .ValorRetido(10)
      .ValorIcmsSubstitutoItem(5.4);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{21,06}, objFloatUtils.fStrToFloat('21,06')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000329;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240717" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08271" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240717
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 08271
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(39)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(6995.46)
      .ValorRetido(791.9)
      .ValorIcmsSubstitutoItem(467.28);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{39}, objFloatUtils.fStrToFloat('39')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000330;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240701" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "07822" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240701
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 07822
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(6)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(323.64)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1836.49)
      .ValorRetido(206.3)
      .ValorIcmsSubstitutoItem(124.27);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{323,64}, objFloatUtils.fStrToFloat('323,64')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000331;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240701" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "17211" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240701
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 17211
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(80)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(33.36)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(2937.88)
      .ValorRetido(343.35)
      .ValorIcmsSubstitutoItem(185.47);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{33,36}, objFloatUtils.fStrToFloat('33,36')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000332;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "07229" AND DET_CODCLI = "10019243";
    DOCUMENTO: 000001144113
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019243
       ESTADO: SP
         ITEM: 07229
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(20)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(22.68)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(62.34)
      .ValorRetido(7.28)
      .ValorIcmsSubstitutoItem(3.94);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{22,68}, objFloatUtils.fStrToFloat('22,68')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000333;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143723" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11626" AND DET_CODCLI = "10410792";
    DOCUMENTO: 000001143723
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10410792
       ESTADO: SP
         ITEM: 11626
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(29.26)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(263.37)
      .ValorRetido(14.28)
      .ValorIcmsSubstitutoItem(17.32);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{29,26}, objFloatUtils.fStrToFloat('29,26')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000334;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240624" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "03088" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240624
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 03088
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(108)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.88)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1.89696)
      .ValorRetido(0.3414528)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,88}, objFloatUtils.fStrToFloat('2,88')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000335;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143685" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62793" AND DET_CODCLI = "10843064";
    DOCUMENTO: 000001143685
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843064
       ESTADO: SP
         ITEM: 62793
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(220)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(600)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(64998.45)
      .ValorRetido(3342.78)
      .ValorIcmsSubstitutoItem(8356.94);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{600}, objFloatUtils.fStrToFloat('600')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000336;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143676" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "62793" AND DET_CODCLI = "10842771";
    DOCUMENTO: 000001143676
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10842771
       ESTADO: SP
         ITEM: 62793
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(220)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(51.11)
      .ValorBaseCalculoEfetiva(662.53)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(64998.45)
      .ValorRetido(3342.78)
      .ValorIcmsSubstitutoItem(8356.94);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{51,11}, objFloatUtils.fStrToFloat('51,11')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{662,53}, objFloatUtils.fStrToFloat('662,53')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000337;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001144030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03678" AND DET_CODCLI = "10798437";
    DOCUMENTO: 000001144030
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10798437
       ESTADO: SP
         ITEM: 03678
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(24)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.82)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(8.0685)
      .ValorRetido(1.45233)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,82}, objFloatUtils.fStrToFloat('6,82')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000338;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240736" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02524" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240736
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 02524
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(400)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1.28296)
      .ValorRetido(0.2309328)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000339;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143579" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31428" AND DET_CODCLI = "10843031";
    DOCUMENTO: 000001143579
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10843031
       ESTADO: SP
         ITEM: 31428
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(2)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(35.5)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(35.998)
      .ValorRetido(6.47964)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{35,5}, objFloatUtils.fStrToFloat('35,5')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000340;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277218" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02066" AND DET_CODCLI = "10014341";
    DOCUMENTO: 000000277218
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10014341
       ESTADO: SP
         ITEM: 02066
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(62.49)
      .ValorRetido(7.01)
      .ValorIcmsSubstitutoItem(4.23);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,8}, objFloatUtils.fStrToFloat('1,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000341;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240641" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "09374" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240641
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 09374
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(0.48)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(32.55)
      .ValorRetido(2.31)
      .ValorIcmsSubstitutoItem(3.55);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{0,48}, objFloatUtils.fStrToFloat('0,48')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000342;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240611" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "26901" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240611
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 26901
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(10)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.9)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(9.11)
      .ValorRetido(0.65)
      .ValorIcmsSubstitutoItem(0.99);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,9}, objFloatUtils.fStrToFloat('2,9')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000343;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240705" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "02455" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240705
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 02455
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(15)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.49)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(24.78)
      .ValorRetido(1.76)
      .ValorIcmsSubstitutoItem(2.7);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,49}, objFloatUtils.fStrToFloat('1,49')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000344;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277218" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02068" AND DET_CODCLI = "10014341";
    DOCUMENTO: 000000277218
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10014341
       ESTADO: SP
         ITEM: 02068
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(20)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(89.55)
      .ValorRetido(6.35)
      .ValorIcmsSubstitutoItem(9.77);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,8}, objFloatUtils.fStrToFloat('1,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000345;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240612" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "33369" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240612
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 33369
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.57)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(50.31)
      .ValorRetido(3.56)
      .ValorIcmsSubstitutoItem(5.49);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,57}, objFloatUtils.fStrToFloat('2,57')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000346;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240690" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "43754" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240690
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 43754
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.35)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(197.06)
      .ValorRetido(14.05)
      .ValorIcmsSubstitutoItem(21.42);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,35}, objFloatUtils.fStrToFloat('7,35')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000347;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240697" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "43754" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240697
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 43754
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(6.8)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(197.06)
      .ValorRetido(14.05)
      .ValorIcmsSubstitutoItem(21.42);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{6,8}, objFloatUtils.fStrToFloat('6,8')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000348;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240690" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "43759" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240690
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 43759
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(50)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(8.69)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(357.7)
      .ValorRetido(25.51)
      .ValorIcmsSubstitutoItem(38.88);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{8,69}, objFloatUtils.fStrToFloat('8,69')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000349;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240689" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "09880" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240689
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 09880
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(600)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.25)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(296.2)
      .ValorRetido(21.01)
      .ValorIcmsSubstitutoItem(32.31);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,25}, objFloatUtils.fStrToFloat('1,25')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000350;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240695" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "01788" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240695
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 01788
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(600)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(1.13)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(74.64)
      .ValorRetido(5.29)
      .ValorIcmsSubstitutoItem(8.14);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1,13}, objFloatUtils.fStrToFloat('1,13')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000351;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240695" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "13627" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240695
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 13627
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(200)
      .QuantidadeItem(6)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(2.4)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(53.22)
      .ValorRetido(3.77)
      .ValorIcmsSubstitutoItem(5.81);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{2,4}, objFloatUtils.fStrToFloat('2,4')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000352;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240715" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "23076" AND DET_CODCLI = "10002782";
    DOCUMENTO: 000000240715
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10002782
       ESTADO: SP
         ITEM: 23076
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(100)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(17.3)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1710)
      .ValorRetido(107.93)
      .ValorIcmsSubstitutoItem(199.87);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{17,3}, objFloatUtils.fStrToFloat('17,3')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000353;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240632" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "54150" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240632
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 54150
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1000)
      .QuantidadeItem(4)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(19.55)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(5093.69)
      .ValorRetido(321.5)
      .ValorIcmsSubstitutoItem(595.37);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{19,55}, objFloatUtils.fStrToFloat('19,55')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000354;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240682" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "54903" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240682
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 54903
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(480)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.43)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1722.91)
      .ValorRetido(108.74)
      .ValorIcmsSubstitutoItem(201.38);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,43}, objFloatUtils.fStrToFloat('3,43')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000355;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000277223" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "64784" AND DET_CODCLI = "10157304";
    DOCUMENTO: 000000277223
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 10157304
       ESTADO: SP
         ITEM: 64784
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(10000)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(3.25)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(18029.37)
      .ValorRetido(1137.96)
      .ValorIcmsSubstitutoItem(2107.33);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{3,25}, objFloatUtils.fStrToFloat('3,25')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000356;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240715" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "12313" AND DET_CODCLI = "10002782";
    DOCUMENTO: 000000240715
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10002782
       ESTADO: SP
         ITEM: 12313
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(150)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(7.72)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1145.28)
      .ValorRetido(72.29)
      .ValorIcmsSubstitutoItem(133.86);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{7,72}, objFloatUtils.fStrToFloat('7,72')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000357;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240632" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "12851" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240632
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 12851
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(1250)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(9.08)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(12203.3)
      .ValorRetido(770.23)
      .ValorIcmsSubstitutoItem(1426.36);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{9,08}, objFloatUtils.fStrToFloat('9,08')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000358;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240657" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "57040" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240657
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 57040
 ITEM SERVIÇO: NÃO
         CFOP: 1403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(250)
      .QuantidadeItem(2)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(13)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1787.06)
      .ValorRetido(112.79)
      .ValorIcmsSubstitutoItem(208.88);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000359;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000240616" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "08480" AND DET_CODCLI = "10099999";
    DOCUMENTO: 000000240616
      ESPECIE: IF
      EMPRESA: 001
      CLIENTE: 10099999
       ESTADO: SP
         ITEM: 08480
 ITEM SERVIÇO: NÃO
         CFOP: 2652
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(400)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(0)
      .ValorBaseCalculoEfetiva(16.31)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(7785.96)
      .ValorRetido(1401.47)
      .ValorIcmsSubstitutoItem(0);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{16,31}, objFloatUtils.fStrToFloat('16,31')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestPALACIODASFER.CALCULO_ICMS_EFETIVO__PALACIODASFER_000360;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000001143956" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30930" AND DET_CODCLI = "10019612";
    DOCUMENTO: 000001143956
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 10019612
       ESTADO: SP
         ITEM: 30930
 ITEM SERVIÇO: NÃO
         CFOP: 2403
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 24/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsEfetivo;
  AParametros: IParametrosCalculoIcmsEfetivo;
Begin

  AParametros :=
    TParametrosCalculoIcmsEfetivo.New()
      .EncontrouDocumento(True)
      .Quantidade(5)
      .QuantidadeItem(1)
      .ClienteConsumidorFinal(True)
      .PercentualReducaoBaseCalcEfetiva(68.89)
      .ValorBaseCalculoEfetiva(1098)
      .AliquotaIcmsEfetiva(0)
      .ValorBaseRetida(1694.19)
      .ValorRetido(68.08)
      .ValorIcmsSubstitutoItem(236.88);

  ReturnValue := CalcularValorIcmsEfetivo(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{68,89}, objFloatUtils.fStrToFloat('68,89')) And
            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{1098}, objFloatUtils.fStrToFloat('1098')) And
            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsEfetivaItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorIcmsStRetidoItem{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestPALACIODASFER.Suite);
end.

