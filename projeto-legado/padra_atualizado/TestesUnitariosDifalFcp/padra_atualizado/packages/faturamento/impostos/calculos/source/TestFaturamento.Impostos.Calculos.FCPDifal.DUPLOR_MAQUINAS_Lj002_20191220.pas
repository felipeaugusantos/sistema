unit TestFaturamento.Impostos.Calculos.FCPDifal.DUPLOR_MAQUINAS_Lj002_20191220;

{--------------------------------------------------------------------------
                    RESUMO FCPDIFAL                 
--------------------------------------------------------------------------
Empresa            : 002 - DUPLOR MAQUINAS
Período Selecionado: 20/12/2019 até 20/12/2019
Data do Processo   : 30/12/2019 
Hora Inicio        : 08:56:29
Hora Fim           : 09:06:49
Tempo Total        : 00:10:20
                                           
Total Registros    : 1089
Total Processados  : 1089
Total de Acertos   : 387
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 155
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.FCP,
Faturamento.Impostos.Tipos.FCP,
Faturamento.Impostos.Interfaces.FCP;

type
TestDUPLORMAQUINAS = class(TTestCase)
strict private
private





published

Procedure DifalFCP_DUPLORMAQUINAS_000001;
Procedure DifalFCP_DUPLORMAQUINAS_000002;
Procedure DifalFCP_DUPLORMAQUINAS_000003;
Procedure DifalFCP_DUPLORMAQUINAS_000004;
Procedure DifalFCP_DUPLORMAQUINAS_000005;
Procedure DifalFCP_DUPLORMAQUINAS_000006;
Procedure DifalFCP_DUPLORMAQUINAS_000007;
Procedure DifalFCP_DUPLORMAQUINAS_000008;
Procedure DifalFCP_DUPLORMAQUINAS_000009;
Procedure DifalFCP_DUPLORMAQUINAS_000010;
Procedure DifalFCP_DUPLORMAQUINAS_000011;
Procedure DifalFCP_DUPLORMAQUINAS_000012;
Procedure DifalFCP_DUPLORMAQUINAS_000013;
Procedure DifalFCP_DUPLORMAQUINAS_000014;
Procedure DifalFCP_DUPLORMAQUINAS_000015;
Procedure DifalFCP_DUPLORMAQUINAS_000016;
Procedure DifalFCP_DUPLORMAQUINAS_000017;
Procedure DifalFCP_DUPLORMAQUINAS_000018;
Procedure DifalFCP_DUPLORMAQUINAS_000019;
Procedure DifalFCP_DUPLORMAQUINAS_000020;
Procedure DifalFCP_DUPLORMAQUINAS_000021;
Procedure DifalFCP_DUPLORMAQUINAS_000022;
Procedure DifalFCP_DUPLORMAQUINAS_000023;
Procedure DifalFCP_DUPLORMAQUINAS_000024;
Procedure DifalFCP_DUPLORMAQUINAS_000025;
Procedure DifalFCP_DUPLORMAQUINAS_000026;
Procedure DifalFCP_DUPLORMAQUINAS_000027;
Procedure DifalFCP_DUPLORMAQUINAS_000028;
Procedure DifalFCP_DUPLORMAQUINAS_000029;
Procedure DifalFCP_DUPLORMAQUINAS_000030;
Procedure DifalFCP_DUPLORMAQUINAS_000031;
Procedure DifalFCP_DUPLORMAQUINAS_000032;
Procedure DifalFCP_DUPLORMAQUINAS_000033;
Procedure DifalFCP_DUPLORMAQUINAS_000034;
Procedure DifalFCP_DUPLORMAQUINAS_000035;
Procedure DifalFCP_DUPLORMAQUINAS_000036;
Procedure DifalFCP_DUPLORMAQUINAS_000037;
Procedure DifalFCP_DUPLORMAQUINAS_000038;
Procedure DifalFCP_DUPLORMAQUINAS_000039;
Procedure DifalFCP_DUPLORMAQUINAS_000040;
Procedure DifalFCP_DUPLORMAQUINAS_000041;
Procedure DifalFCP_DUPLORMAQUINAS_000042;
Procedure DifalFCP_DUPLORMAQUINAS_000043;
Procedure DifalFCP_DUPLORMAQUINAS_000044;
Procedure DifalFCP_DUPLORMAQUINAS_000045;
Procedure DifalFCP_DUPLORMAQUINAS_000046;
Procedure DifalFCP_DUPLORMAQUINAS_000047;
Procedure DifalFCP_DUPLORMAQUINAS_000048;
Procedure DifalFCP_DUPLORMAQUINAS_000049;
Procedure DifalFCP_DUPLORMAQUINAS_000050;
Procedure DifalFCP_DUPLORMAQUINAS_000051;
Procedure DifalFCP_DUPLORMAQUINAS_000052;
Procedure DifalFCP_DUPLORMAQUINAS_000053;
Procedure DifalFCP_DUPLORMAQUINAS_000054;
Procedure DifalFCP_DUPLORMAQUINAS_000055;
Procedure DifalFCP_DUPLORMAQUINAS_000056;
Procedure DifalFCP_DUPLORMAQUINAS_000057;
Procedure DifalFCP_DUPLORMAQUINAS_000058;
Procedure DifalFCP_DUPLORMAQUINAS_000059;
Procedure DifalFCP_DUPLORMAQUINAS_000060;
Procedure DifalFCP_DUPLORMAQUINAS_000061;
Procedure DifalFCP_DUPLORMAQUINAS_000062;
Procedure DifalFCP_DUPLORMAQUINAS_000063;
Procedure DifalFCP_DUPLORMAQUINAS_000064;
Procedure DifalFCP_DUPLORMAQUINAS_000065;
Procedure DifalFCP_DUPLORMAQUINAS_000066;
Procedure DifalFCP_DUPLORMAQUINAS_000067;
Procedure DifalFCP_DUPLORMAQUINAS_000068;
Procedure DifalFCP_DUPLORMAQUINAS_000069;
Procedure DifalFCP_DUPLORMAQUINAS_000070;
Procedure DifalFCP_DUPLORMAQUINAS_000071;
Procedure DifalFCP_DUPLORMAQUINAS_000072;
Procedure DifalFCP_DUPLORMAQUINAS_000073;
Procedure DifalFCP_DUPLORMAQUINAS_000074;
Procedure DifalFCP_DUPLORMAQUINAS_000075;
Procedure DifalFCP_DUPLORMAQUINAS_000076;
Procedure DifalFCP_DUPLORMAQUINAS_000077;
Procedure DifalFCP_DUPLORMAQUINAS_000078;
Procedure DifalFCP_DUPLORMAQUINAS_000079;
Procedure DifalFCP_DUPLORMAQUINAS_000080;
Procedure DifalFCP_DUPLORMAQUINAS_000081;
Procedure DifalFCP_DUPLORMAQUINAS_000082;
Procedure DifalFCP_DUPLORMAQUINAS_000083;
Procedure DifalFCP_DUPLORMAQUINAS_000084;
Procedure DifalFCP_DUPLORMAQUINAS_000085;
Procedure DifalFCP_DUPLORMAQUINAS_000086;
Procedure DifalFCP_DUPLORMAQUINAS_000087;
Procedure DifalFCP_DUPLORMAQUINAS_000088;
Procedure DifalFCP_DUPLORMAQUINAS_000089;
Procedure DifalFCP_DUPLORMAQUINAS_000090;
Procedure DifalFCP_DUPLORMAQUINAS_000091;
Procedure DifalFCP_DUPLORMAQUINAS_000092;
Procedure DifalFCP_DUPLORMAQUINAS_000093;
Procedure DifalFCP_DUPLORMAQUINAS_000094;
Procedure DifalFCP_DUPLORMAQUINAS_000095;
Procedure DifalFCP_DUPLORMAQUINAS_000096;
Procedure DifalFCP_DUPLORMAQUINAS_000097;
Procedure DifalFCP_DUPLORMAQUINAS_000098;
Procedure DifalFCP_DUPLORMAQUINAS_000099;
Procedure DifalFCP_DUPLORMAQUINAS_000100;
Procedure DifalFCP_DUPLORMAQUINAS_000101;
Procedure DifalFCP_DUPLORMAQUINAS_000102;
Procedure DifalFCP_DUPLORMAQUINAS_000103;
Procedure DifalFCP_DUPLORMAQUINAS_000104;
Procedure DifalFCP_DUPLORMAQUINAS_000105;
Procedure DifalFCP_DUPLORMAQUINAS_000106;
Procedure DifalFCP_DUPLORMAQUINAS_000107;
Procedure DifalFCP_DUPLORMAQUINAS_000108;
Procedure DifalFCP_DUPLORMAQUINAS_000109;
Procedure DifalFCP_DUPLORMAQUINAS_000110;
Procedure DifalFCP_DUPLORMAQUINAS_000111;
Procedure DifalFCP_DUPLORMAQUINAS_000112;
Procedure DifalFCP_DUPLORMAQUINAS_000113;
Procedure DifalFCP_DUPLORMAQUINAS_000114;
Procedure DifalFCP_DUPLORMAQUINAS_000115;
Procedure DifalFCP_DUPLORMAQUINAS_000116;
Procedure DifalFCP_DUPLORMAQUINAS_000117;
Procedure DifalFCP_DUPLORMAQUINAS_000118;
Procedure DifalFCP_DUPLORMAQUINAS_000119;
Procedure DifalFCP_DUPLORMAQUINAS_000120;
Procedure DifalFCP_DUPLORMAQUINAS_000121;
Procedure DifalFCP_DUPLORMAQUINAS_000122;
Procedure DifalFCP_DUPLORMAQUINAS_000123;
Procedure DifalFCP_DUPLORMAQUINAS_000124;
Procedure DifalFCP_DUPLORMAQUINAS_000125;
Procedure DifalFCP_DUPLORMAQUINAS_000126;
Procedure DifalFCP_DUPLORMAQUINAS_000127;
Procedure DifalFCP_DUPLORMAQUINAS_000128;
Procedure DifalFCP_DUPLORMAQUINAS_000129;
Procedure DifalFCP_DUPLORMAQUINAS_000130;
Procedure DifalFCP_DUPLORMAQUINAS_000131;
Procedure DifalFCP_DUPLORMAQUINAS_000132;
Procedure DifalFCP_DUPLORMAQUINAS_000133;
Procedure DifalFCP_DUPLORMAQUINAS_000134;
Procedure DifalFCP_DUPLORMAQUINAS_000135;
Procedure DifalFCP_DUPLORMAQUINAS_000136;
Procedure DifalFCP_DUPLORMAQUINAS_000137;
Procedure DifalFCP_DUPLORMAQUINAS_000138;
Procedure DifalFCP_DUPLORMAQUINAS_000139;
Procedure DifalFCP_DUPLORMAQUINAS_000140;
Procedure DifalFCP_DUPLORMAQUINAS_000141;
Procedure DifalFCP_DUPLORMAQUINAS_000142;
Procedure DifalFCP_DUPLORMAQUINAS_000143;
Procedure DifalFCP_DUPLORMAQUINAS_000144;
Procedure DifalFCP_DUPLORMAQUINAS_000145;
Procedure DifalFCP_DUPLORMAQUINAS_000146;
Procedure DifalFCP_DUPLORMAQUINAS_000147;
Procedure DifalFCP_DUPLORMAQUINAS_000148;
Procedure DifalFCP_DUPLORMAQUINAS_000149;
Procedure DifalFCP_DUPLORMAQUINAS_000150;
Procedure DifalFCP_DUPLORMAQUINAS_000151;
Procedure DifalFCP_DUPLORMAQUINAS_000152;
Procedure DifalFCP_DUPLORMAQUINAS_000153;
Procedure DifalFCP_DUPLORMAQUINAS_000154;
Procedure DifalFCP_DUPLORMAQUINAS_000155;
Procedure DifalFCP_DUPLORMAQUINAS_000156;
Procedure DifalFCP_DUPLORMAQUINAS_000157;
Procedure DifalFCP_DUPLORMAQUINAS_000158;
Procedure DifalFCP_DUPLORMAQUINAS_000159;
Procedure DifalFCP_DUPLORMAQUINAS_000160;
Procedure DifalFCP_DUPLORMAQUINAS_000161;
Procedure DifalFCP_DUPLORMAQUINAS_000162;
Procedure DifalFCP_DUPLORMAQUINAS_000163;
Procedure DifalFCP_DUPLORMAQUINAS_000164;
Procedure DifalFCP_DUPLORMAQUINAS_000165;
Procedure DifalFCP_DUPLORMAQUINAS_000166;
Procedure DifalFCP_DUPLORMAQUINAS_000167;
Procedure DifalFCP_DUPLORMAQUINAS_000168;
Procedure DifalFCP_DUPLORMAQUINAS_000169;
Procedure DifalFCP_DUPLORMAQUINAS_000170;
Procedure DifalFCP_DUPLORMAQUINAS_000171;
Procedure DifalFCP_DUPLORMAQUINAS_000172;
Procedure DifalFCP_DUPLORMAQUINAS_000173;
Procedure DifalFCP_DUPLORMAQUINAS_000174;
Procedure DifalFCP_DUPLORMAQUINAS_000175;
Procedure DifalFCP_DUPLORMAQUINAS_000176;
Procedure DifalFCP_DUPLORMAQUINAS_000177;
Procedure DifalFCP_DUPLORMAQUINAS_000178;
Procedure DifalFCP_DUPLORMAQUINAS_000179;
Procedure DifalFCP_DUPLORMAQUINAS_000180;
Procedure DifalFCP_DUPLORMAQUINAS_000181;
Procedure DifalFCP_DUPLORMAQUINAS_000182;
Procedure DifalFCP_DUPLORMAQUINAS_000183;
Procedure DifalFCP_DUPLORMAQUINAS_000184;
Procedure DifalFCP_DUPLORMAQUINAS_000185;
Procedure DifalFCP_DUPLORMAQUINAS_000186;
Procedure DifalFCP_DUPLORMAQUINAS_000187;
Procedure DifalFCP_DUPLORMAQUINAS_000188;
Procedure DifalFCP_DUPLORMAQUINAS_000189;
Procedure DifalFCP_DUPLORMAQUINAS_000190;
Procedure DifalFCP_DUPLORMAQUINAS_000191;
Procedure DifalFCP_DUPLORMAQUINAS_000192;
Procedure DifalFCP_DUPLORMAQUINAS_000193;
Procedure DifalFCP_DUPLORMAQUINAS_000194;
Procedure DifalFCP_DUPLORMAQUINAS_000195;
Procedure DifalFCP_DUPLORMAQUINAS_000196;
Procedure DifalFCP_DUPLORMAQUINAS_000197;
Procedure DifalFCP_DUPLORMAQUINAS_000198;
Procedure DifalFCP_DUPLORMAQUINAS_000199;
Procedure DifalFCP_DUPLORMAQUINAS_000200;
Procedure DifalFCP_DUPLORMAQUINAS_000201;
Procedure DifalFCP_DUPLORMAQUINAS_000202;
Procedure DifalFCP_DUPLORMAQUINAS_000203;
Procedure DifalFCP_DUPLORMAQUINAS_000204;
Procedure DifalFCP_DUPLORMAQUINAS_000205;
Procedure DifalFCP_DUPLORMAQUINAS_000206;
Procedure DifalFCP_DUPLORMAQUINAS_000207;
Procedure DifalFCP_DUPLORMAQUINAS_000208;
Procedure DifalFCP_DUPLORMAQUINAS_000209;
Procedure DifalFCP_DUPLORMAQUINAS_000210;
Procedure DifalFCP_DUPLORMAQUINAS_000211;
Procedure DifalFCP_DUPLORMAQUINAS_000212;
Procedure DifalFCP_DUPLORMAQUINAS_000213;
Procedure DifalFCP_DUPLORMAQUINAS_000214;
Procedure DifalFCP_DUPLORMAQUINAS_000215;
Procedure DifalFCP_DUPLORMAQUINAS_000216;
Procedure DifalFCP_DUPLORMAQUINAS_000217;
Procedure DifalFCP_DUPLORMAQUINAS_000218;
Procedure DifalFCP_DUPLORMAQUINAS_000219;
Procedure DifalFCP_DUPLORMAQUINAS_000220;
Procedure DifalFCP_DUPLORMAQUINAS_000221;
Procedure DifalFCP_DUPLORMAQUINAS_000222;
Procedure DifalFCP_DUPLORMAQUINAS_000223;
Procedure DifalFCP_DUPLORMAQUINAS_000224;
Procedure DifalFCP_DUPLORMAQUINAS_000225;
Procedure DifalFCP_DUPLORMAQUINAS_000226;
Procedure DifalFCP_DUPLORMAQUINAS_000227;
Procedure DifalFCP_DUPLORMAQUINAS_000228;
Procedure DifalFCP_DUPLORMAQUINAS_000229;
Procedure DifalFCP_DUPLORMAQUINAS_000230;
Procedure DifalFCP_DUPLORMAQUINAS_000231;
Procedure DifalFCP_DUPLORMAQUINAS_000232;
Procedure DifalFCP_DUPLORMAQUINAS_000233;
Procedure DifalFCP_DUPLORMAQUINAS_000234;
Procedure DifalFCP_DUPLORMAQUINAS_000235;
Procedure DifalFCP_DUPLORMAQUINAS_000236;
Procedure DifalFCP_DUPLORMAQUINAS_000237;
Procedure DifalFCP_DUPLORMAQUINAS_000238;
Procedure DifalFCP_DUPLORMAQUINAS_000239;
Procedure DifalFCP_DUPLORMAQUINAS_000240;
Procedure DifalFCP_DUPLORMAQUINAS_000241;
Procedure DifalFCP_DUPLORMAQUINAS_000242;
Procedure DifalFCP_DUPLORMAQUINAS_000243;
Procedure DifalFCP_DUPLORMAQUINAS_000244;
Procedure DifalFCP_DUPLORMAQUINAS_000245;
Procedure DifalFCP_DUPLORMAQUINAS_000246;
Procedure DifalFCP_DUPLORMAQUINAS_000247;
Procedure DifalFCP_DUPLORMAQUINAS_000248;
Procedure DifalFCP_DUPLORMAQUINAS_000249;
Procedure DifalFCP_DUPLORMAQUINAS_000250;
Procedure DifalFCP_DUPLORMAQUINAS_000251;
Procedure DifalFCP_DUPLORMAQUINAS_000252;
Procedure DifalFCP_DUPLORMAQUINAS_000253;
Procedure DifalFCP_DUPLORMAQUINAS_000254;
Procedure DifalFCP_DUPLORMAQUINAS_000255;
Procedure DifalFCP_DUPLORMAQUINAS_000256;
Procedure DifalFCP_DUPLORMAQUINAS_000257;
Procedure DifalFCP_DUPLORMAQUINAS_000258;
Procedure DifalFCP_DUPLORMAQUINAS_000259;
Procedure DifalFCP_DUPLORMAQUINAS_000260;
Procedure DifalFCP_DUPLORMAQUINAS_000261;
Procedure DifalFCP_DUPLORMAQUINAS_000262;
Procedure DifalFCP_DUPLORMAQUINAS_000263;
Procedure DifalFCP_DUPLORMAQUINAS_000264;
Procedure DifalFCP_DUPLORMAQUINAS_000265;
Procedure DifalFCP_DUPLORMAQUINAS_000266;
Procedure DifalFCP_DUPLORMAQUINAS_000267;
Procedure DifalFCP_DUPLORMAQUINAS_000268;
Procedure DifalFCP_DUPLORMAQUINAS_000269;
Procedure DifalFCP_DUPLORMAQUINAS_000270;
Procedure DifalFCP_DUPLORMAQUINAS_000271;
Procedure DifalFCP_DUPLORMAQUINAS_000272;
Procedure DifalFCP_DUPLORMAQUINAS_000273;
Procedure DifalFCP_DUPLORMAQUINAS_000274;
Procedure DifalFCP_DUPLORMAQUINAS_000275;
Procedure DifalFCP_DUPLORMAQUINAS_000276;
Procedure DifalFCP_DUPLORMAQUINAS_000277;
Procedure DifalFCP_DUPLORMAQUINAS_000278;
Procedure DifalFCP_DUPLORMAQUINAS_000279;
Procedure DifalFCP_DUPLORMAQUINAS_000280;
Procedure DifalFCP_DUPLORMAQUINAS_000281;
Procedure DifalFCP_DUPLORMAQUINAS_000282;
Procedure DifalFCP_DUPLORMAQUINAS_000283;
Procedure DifalFCP_DUPLORMAQUINAS_000284;
Procedure DifalFCP_DUPLORMAQUINAS_000285;
Procedure DifalFCP_DUPLORMAQUINAS_000286;
Procedure DifalFCP_DUPLORMAQUINAS_000287;
Procedure DifalFCP_DUPLORMAQUINAS_000288;
Procedure DifalFCP_DUPLORMAQUINAS_000289;
Procedure DifalFCP_DUPLORMAQUINAS_000290;
Procedure DifalFCP_DUPLORMAQUINAS_000291;
Procedure DifalFCP_DUPLORMAQUINAS_000292;
Procedure DifalFCP_DUPLORMAQUINAS_000293;
Procedure DifalFCP_DUPLORMAQUINAS_000294;
Procedure DifalFCP_DUPLORMAQUINAS_000295;
Procedure DifalFCP_DUPLORMAQUINAS_000296;
Procedure DifalFCP_DUPLORMAQUINAS_000297;
Procedure DifalFCP_DUPLORMAQUINAS_000298;
Procedure DifalFCP_DUPLORMAQUINAS_000299;
Procedure DifalFCP_DUPLORMAQUINAS_000300;
Procedure DifalFCP_DUPLORMAQUINAS_000301;
Procedure DifalFCP_DUPLORMAQUINAS_000302;
Procedure DifalFCP_DUPLORMAQUINAS_000303;
Procedure DifalFCP_DUPLORMAQUINAS_000304;
Procedure DifalFCP_DUPLORMAQUINAS_000305;
Procedure DifalFCP_DUPLORMAQUINAS_000306;
Procedure DifalFCP_DUPLORMAQUINAS_000307;
Procedure DifalFCP_DUPLORMAQUINAS_000308;
Procedure DifalFCP_DUPLORMAQUINAS_000309;
Procedure DifalFCP_DUPLORMAQUINAS_000310;
Procedure DifalFCP_DUPLORMAQUINAS_000311;
Procedure DifalFCP_DUPLORMAQUINAS_000312;
Procedure DifalFCP_DUPLORMAQUINAS_000313;
Procedure DifalFCP_DUPLORMAQUINAS_000314;
Procedure DifalFCP_DUPLORMAQUINAS_000315;
Procedure DifalFCP_DUPLORMAQUINAS_000316;
Procedure DifalFCP_DUPLORMAQUINAS_000317;
Procedure DifalFCP_DUPLORMAQUINAS_000318;
Procedure DifalFCP_DUPLORMAQUINAS_000319;
Procedure DifalFCP_DUPLORMAQUINAS_000320;
Procedure DifalFCP_DUPLORMAQUINAS_000321;
Procedure DifalFCP_DUPLORMAQUINAS_000322;
Procedure DifalFCP_DUPLORMAQUINAS_000323;
Procedure DifalFCP_DUPLORMAQUINAS_000324;
Procedure DifalFCP_DUPLORMAQUINAS_000325;
Procedure DifalFCP_DUPLORMAQUINAS_000326;
Procedure DifalFCP_DUPLORMAQUINAS_000327;
Procedure DifalFCP_DUPLORMAQUINAS_000328;
Procedure DifalFCP_DUPLORMAQUINAS_000329;
Procedure DifalFCP_DUPLORMAQUINAS_000330;
Procedure DifalFCP_DUPLORMAQUINAS_000331;
Procedure DifalFCP_DUPLORMAQUINAS_000332;
Procedure DifalFCP_DUPLORMAQUINAS_000333;
Procedure DifalFCP_DUPLORMAQUINAS_000334;
Procedure DifalFCP_DUPLORMAQUINAS_000335;
Procedure DifalFCP_DUPLORMAQUINAS_000336;
Procedure DifalFCP_DUPLORMAQUINAS_000337;
Procedure DifalFCP_DUPLORMAQUINAS_000338;
Procedure DifalFCP_DUPLORMAQUINAS_000339;
Procedure DifalFCP_DUPLORMAQUINAS_000340;
Procedure DifalFCP_DUPLORMAQUINAS_000341;
Procedure DifalFCP_DUPLORMAQUINAS_000342;
Procedure DifalFCP_DUPLORMAQUINAS_000343;
Procedure DifalFCP_DUPLORMAQUINAS_000344;
Procedure DifalFCP_DUPLORMAQUINAS_000345;
Procedure DifalFCP_DUPLORMAQUINAS_000346;
Procedure DifalFCP_DUPLORMAQUINAS_000347;
Procedure DifalFCP_DUPLORMAQUINAS_000348;
Procedure DifalFCP_DUPLORMAQUINAS_000349;
Procedure DifalFCP_DUPLORMAQUINAS_000350;
Procedure DifalFCP_DUPLORMAQUINAS_000351;
Procedure DifalFCP_DUPLORMAQUINAS_000352;
Procedure DifalFCP_DUPLORMAQUINAS_000353;
Procedure DifalFCP_DUPLORMAQUINAS_000354;
Procedure DifalFCP_DUPLORMAQUINAS_000355;
Procedure DifalFCP_DUPLORMAQUINAS_000356;
Procedure DifalFCP_DUPLORMAQUINAS_000357;
Procedure DifalFCP_DUPLORMAQUINAS_000358;
Procedure DifalFCP_DUPLORMAQUINAS_000359;
Procedure DifalFCP_DUPLORMAQUINAS_000360;
Procedure DifalFCP_DUPLORMAQUINAS_000361;
Procedure DifalFCP_DUPLORMAQUINAS_000362;
Procedure DifalFCP_DUPLORMAQUINAS_000363;
Procedure DifalFCP_DUPLORMAQUINAS_000364;
Procedure DifalFCP_DUPLORMAQUINAS_000365;
Procedure DifalFCP_DUPLORMAQUINAS_000366;
Procedure DifalFCP_DUPLORMAQUINAS_000367;
Procedure DifalFCP_DUPLORMAQUINAS_000368;
Procedure DifalFCP_DUPLORMAQUINAS_000369;
Procedure DifalFCP_DUPLORMAQUINAS_000370;
Procedure DifalFCP_DUPLORMAQUINAS_000371;
Procedure DifalFCP_DUPLORMAQUINAS_000372;
Procedure DifalFCP_DUPLORMAQUINAS_000373;
Procedure DifalFCP_DUPLORMAQUINAS_000374;
Procedure DifalFCP_DUPLORMAQUINAS_000375;
Procedure DifalFCP_DUPLORMAQUINAS_000376;
Procedure DifalFCP_DUPLORMAQUINAS_000377;
Procedure DifalFCP_DUPLORMAQUINAS_000378;
Procedure DifalFCP_DUPLORMAQUINAS_000379;
Procedure DifalFCP_DUPLORMAQUINAS_000380;
Procedure DifalFCP_DUPLORMAQUINAS_000381;
Procedure DifalFCP_DUPLORMAQUINAS_000382;
Procedure DifalFCP_DUPLORMAQUINAS_000383;
Procedure DifalFCP_DUPLORMAQUINAS_000384;
Procedure DifalFCP_DUPLORMAQUINAS_000385;
Procedure DifalFCP_DUPLORMAQUINAS_000386;
Procedure DifalFCP_DUPLORMAQUINAS_000387;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestDUPLORMAQUINAS.SetUp;
begin
end;

procedure TestDUPLORMAQUINAS.TearDown;
begin
end;

Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301702" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00413567";
    DOCUMENTO: 000000301702
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00413567
       ESTADO: RS
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.8492)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(41.78)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,8492}, objFloatUtils.fStrToFloat('5,8492')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301702" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00413567";
    DOCUMENTO: 000000301702
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00413567
       ESTADO: RS
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.9108)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(92.22)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,9108}, objFloatUtils.fStrToFloat('12,9108')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301709" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418212";
    DOCUMENTO: 000000301709
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418212
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.3092)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(21.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,3092}, objFloatUtils.fStrToFloat('1,3092')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301709" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418212";
    DOCUMENTO: 000000301709
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418212
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.5482)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(39.63)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,5482}, objFloatUtils.fStrToFloat('5,5482')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301710" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68308" AND DET_CODCLI = "00418210";
    DOCUMENTO: 000000301710
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418210
       ESTADO: RJ
         ITEM: 68308
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.854)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(80.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,854}, objFloatUtils.fStrToFloat('4,854')) And
            CompararValores(ReturnValue.BaseFCP{80,9}, objFloatUtils.fStrToFloat('80,9')) And
            CompararValores(ReturnValue.ValorFCP{1,62}, objFloatUtils.fStrToFloat('1,62')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301712" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418395";
    DOCUMENTO: 000000301712
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418395
       ESTADO: ES
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.281)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(22.81)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,281}, objFloatUtils.fStrToFloat('2,281')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301712" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418395";
    DOCUMENTO: 000000301712
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418395
       ESTADO: ES
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.382)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(41.4)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,382}, objFloatUtils.fStrToFloat('5,382')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301716" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58983" AND DET_CODCLI = "00415281";
    DOCUMENTO: 000000301716
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415281
       ESTADO: MG
         ITEM: 58983
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(19.4491)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(405.19)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{19,4491}, objFloatUtils.fStrToFloat('19,4491')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301721" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418401";
    DOCUMENTO: 000000301721
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418401
       ESTADO: MG
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.699)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(47.85)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,699}, objFloatUtils.fStrToFloat('6,699')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301721" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418401";
    DOCUMENTO: 000000301721
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418401
       ESTADO: MG
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.7826)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(105.59)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,7826}, objFloatUtils.fStrToFloat('14,7826')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301725" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418552";
    DOCUMENTO: 000000301725
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418552
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.1508)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,1508}, objFloatUtils.fStrToFloat('1,1508')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301725" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418552";
    DOCUMENTO: 000000301725
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418552
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.8748)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,8748}, objFloatUtils.fStrToFloat('4,8748')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301726" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418204";
    DOCUMENTO: 000000301726
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418204
       ESTADO: CE
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.1098)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,1098}, objFloatUtils.fStrToFloat('2,1098')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301733" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418187";
    DOCUMENTO: 000000301733
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418187
       ESTADO: RJ
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.1508)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,1508}, objFloatUtils.fStrToFloat('1,1508')) And
            CompararValores(ReturnValue.BaseFCP{19,18}, objFloatUtils.fStrToFloat('19,18')) And
            CompararValores(ReturnValue.ValorFCP{0,38}, objFloatUtils.fStrToFloat('0,38')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301733" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418187";
    DOCUMENTO: 000000301733
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418187
       ESTADO: RJ
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.8748)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,8748}, objFloatUtils.fStrToFloat('4,8748')) And
            CompararValores(ReturnValue.BaseFCP{34,82}, objFloatUtils.fStrToFloat('34,82')) And
            CompararValores(ReturnValue.ValorFCP{0,7}, objFloatUtils.fStrToFloat('0,7')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301737" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418530";
    DOCUMENTO: 000000301737
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418530
       ESTADO: ES
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.918)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,918}, objFloatUtils.fStrToFloat('1,918')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301737" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418530";
    DOCUMENTO: 000000301737
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418530
       ESTADO: ES
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.5266)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,5266}, objFloatUtils.fStrToFloat('4,5266')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301739" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418178";
    DOCUMENTO: 000000301739
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418178
       ESTADO: RJ
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.3494)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(22.49)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,3494}, objFloatUtils.fStrToFloat('1,3494')) And
            CompararValores(ReturnValue.BaseFCP{22,49}, objFloatUtils.fStrToFloat('22,49')) And
            CompararValores(ReturnValue.ValorFCP{0,45}, objFloatUtils.fStrToFloat('0,45')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301739" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418178";
    DOCUMENTO: 000000301739
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418178
       ESTADO: RJ
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.7162)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(40.83)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,7162}, objFloatUtils.fStrToFloat('5,7162')) And
            CompararValores(ReturnValue.BaseFCP{40,83}, objFloatUtils.fStrToFloat('40,83')) And
            CompararValores(ReturnValue.ValorFCP{0,82}, objFloatUtils.fStrToFloat('0,82')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301739" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00418178";
    DOCUMENTO: 000000301739
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418178
       ESTADO: RJ
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.5152)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(103.68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,5152}, objFloatUtils.fStrToFloat('14,5152')) And
            CompararValores(ReturnValue.BaseFCP{103,68}, objFloatUtils.fStrToFloat('103,68')) And
            CompararValores(ReturnValue.ValorFCP{2,07}, objFloatUtils.fStrToFloat('2,07')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301742" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418415";
    DOCUMENTO: 000000301742
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418415
       ESTADO: BA
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.9701)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.91)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,9701}, objFloatUtils.fStrToFloat('1,9701')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301742" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418415";
    DOCUMENTO: 000000301742
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418415
       ESTADO: BA
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.5528)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.52)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,5528}, objFloatUtils.fStrToFloat('4,5528')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301742" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00418415";
    DOCUMENTO: 000000301742
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418415
       ESTADO: BA
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.5598)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(82.57)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,5598}, objFloatUtils.fStrToFloat('11,5598')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "42352" AND DET_CODCLI = "00418180";
    DOCUMENTO: 000000301746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418180
       ESTADO: RJ
         ITEM: 42352
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.86)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(49)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,86}, objFloatUtils.fStrToFloat('6,86')) And
            CompararValores(ReturnValue.BaseFCP{49}, objFloatUtils.fStrToFloat('49')) And
            CompararValores(ReturnValue.ValorFCP{0,98}, objFloatUtils.fStrToFloat('0,98')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301750" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "46141" AND DET_CODCLI = "00418206";
    DOCUMENTO: 000000301750
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418206
       ESTADO: MG
         ITEM: 46141
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(26.446)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(188.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{26,446}, objFloatUtils.fStrToFloat('26,446')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301751" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62269" AND DET_CODCLI = "00387782";
    DOCUMENTO: 000000301751
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00387782
       ESTADO: PR
         ITEM: 62269
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1306)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(2.72)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1306}, objFloatUtils.fStrToFloat('0,1306')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301751" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00387782";
    DOCUMENTO: 000000301751
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00387782
       ESTADO: PR
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9142)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.53)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9142}, objFloatUtils.fStrToFloat('0,9142')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301751" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28830" AND DET_CODCLI = "00387782";
    DOCUMENTO: 000000301751
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00387782
       ESTADO: PR
         ITEM: 28830
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.5222)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(10.88)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,5222}, objFloatUtils.fStrToFloat('0,5222')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301751" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "31511" AND DET_CODCLI = "00387782";
    DOCUMENTO: 000000301751
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00387782
       ESTADO: PR
         ITEM: 31511
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(493.701558)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301751" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65022" AND DET_CODCLI = "00387782";
    DOCUMENTO: 000000301751
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00387782
       ESTADO: PR
         ITEM: 65022
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.8988)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.42)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,8988}, objFloatUtils.fStrToFloat('0,8988')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301751" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60369" AND DET_CODCLI = "00387782";
    DOCUMENTO: 000000301751
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00387782
       ESTADO: PR
         ITEM: 60369
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.3786)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.31)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,3786}, objFloatUtils.fStrToFloat('0,3786')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301754" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "51327" AND DET_CODCLI = "00418390";
    DOCUMENTO: 000000301754
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418390
       ESTADO: GO
         ITEM: 51327
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.63)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(126.3)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,63}, objFloatUtils.fStrToFloat('12,63')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301754" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00418390";
    DOCUMENTO: 000000301754
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418390
       ESTADO: GO
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.531)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(88.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,531}, objFloatUtils.fStrToFloat('11,531')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301762" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "40446" AND DET_CODCLI = "00418565";
    DOCUMENTO: 000000301762
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418565
       ESTADO: MS
         ITEM: 40446
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.287)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(109.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,287}, objFloatUtils.fStrToFloat('14,287')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301764" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "41826" AND DET_CODCLI = "00418477";
    DOCUMENTO: 000000301764
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418477
       ESTADO: MG
         ITEM: 41826
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.553)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(103.95)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,553}, objFloatUtils.fStrToFloat('14,553')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301768" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63876" AND DET_CODCLI = "00418384";
    DOCUMENTO: 000000301768
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418384
       ESTADO: RS
         ITEM: 63876
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.9)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(85)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,9}, objFloatUtils.fStrToFloat('11,9')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301769" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60527" AND DET_CODCLI = "00418547";
    DOCUMENTO: 000000301769
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418547
       ESTADO: PR
         ITEM: 60527
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.46)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(89)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,46}, objFloatUtils.fStrToFloat('12,46')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301770" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69694" AND DET_CODCLI = "00418403";
    DOCUMENTO: 000000301770
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418403
       ESTADO: SC
         ITEM: 69694
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.335)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(86.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,335}, objFloatUtils.fStrToFloat('4,335')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301772" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418179";
    DOCUMENTO: 000000301772
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418179
       ESTADO: AM
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.2902)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(44.93)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,2902}, objFloatUtils.fStrToFloat('6,2902')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301772" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69649" AND DET_CODCLI = "00418179";
    DOCUMENTO: 000000301772
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418179
       ESTADO: AM
         ITEM: 69649
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.0952)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(150.68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,0952}, objFloatUtils.fStrToFloat('21,0952')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301774" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64956" AND DET_CODCLI = "00389697";
    DOCUMENTO: 000000301774
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00389697
       ESTADO: GO
         ITEM: 64956
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.0324)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(266)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,0324}, objFloatUtils.fStrToFloat('3,0324')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301775" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "32170" AND DET_CODCLI = "00418574";
    DOCUMENTO: 000000301775
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418574
       ESTADO: MG
         ITEM: 32170
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.0618)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(51.03)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,0618}, objFloatUtils.fStrToFloat('3,0618')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301776" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418541";
    DOCUMENTO: 000000301776
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418541
       ESTADO: BA
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.4672)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(60.48)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,4672}, objFloatUtils.fStrToFloat('8,4672')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301776" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418541";
    DOCUMENTO: 000000301776
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418541
       ESTADO: BA
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(18.69)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(133.5)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{18,69}, objFloatUtils.fStrToFloat('18,69')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301781" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418523";
    DOCUMENTO: 000000301781
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418523
       ESTADO: MS
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.3401)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(48.77)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,3401}, objFloatUtils.fStrToFloat('6,3401')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301781" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418523";
    DOCUMENTO: 000000301781
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418523
       ESTADO: MS
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13.9945)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(107.65)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13,9945}, objFloatUtils.fStrToFloat('13,9945')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301783" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "46141" AND DET_CODCLI = "00418405";
    DOCUMENTO: 000000301783
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418405
       ESTADO: RO
         ITEM: 46141
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13.5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(26.3318)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(195.05)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13,5}, objFloatUtils.fStrToFloat('13,5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{26,3318}, objFloatUtils.fStrToFloat('26,3318')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301784" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418564";
    DOCUMENTO: 000000301784
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418564
       ESTADO: BA
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.5158)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(67.97)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,5158}, objFloatUtils.fStrToFloat('9,5158')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301784" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418564";
    DOCUMENTO: 000000301784
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418564
       ESTADO: BA
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.0056)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(150.04)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,0056}, objFloatUtils.fStrToFloat('21,0056')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301788" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418335";
    DOCUMENTO: 000000301788
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418335
       ESTADO: MG
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.798)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(55.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,798}, objFloatUtils.fStrToFloat('7,798')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301788" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418335";
    DOCUMENTO: 000000301788
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418335
       ESTADO: MG
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(17.2116)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(122.94)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{17,2116}, objFloatUtils.fStrToFloat('17,2116')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301789" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70760" AND DET_CODCLI = "00418202";
    DOCUMENTO: 000000301789
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418202
       ESTADO: MT
         ITEM: 70760
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.9369)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(169.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,9369}, objFloatUtils.fStrToFloat('1,9369')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301790" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418337";
    DOCUMENTO: 000000301790
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418337
       ESTADO: RS
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.8908)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(49.22)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,8908}, objFloatUtils.fStrToFloat('6,8908')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301790" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418337";
    DOCUMENTO: 000000301790
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418337
       ESTADO: RS
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(15.211)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(108.65)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{15,211}, objFloatUtils.fStrToFloat('15,211')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301793" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60982" AND DET_CODCLI = "00418346";
    DOCUMENTO: 000000301793
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418346
       ESTADO: RJ
         ITEM: 60982
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13.9157)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(289.91)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13,9157}, objFloatUtils.fStrToFloat('13,9157')) And
            CompararValores(ReturnValue.BaseFCP{289,91}, objFloatUtils.fStrToFloat('289,91')) And
            CompararValores(ReturnValue.ValorFCP{5,8}, objFloatUtils.fStrToFloat('5,8')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301794" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65328" AND DET_CODCLI = "00418163";
    DOCUMENTO: 000000301794
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418163
       ESTADO: GO
         ITEM: 65328
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(100)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301796" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67867" AND DET_CODCLI = "00418562";
    DOCUMENTO: 000000301796
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418562
       ESTADO: RJ
         ITEM: 67867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(28.7952)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(599.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{28,7952}, objFloatUtils.fStrToFloat('28,7952')) And
            CompararValores(ReturnValue.BaseFCP{599,9}, objFloatUtils.fStrToFloat('599,9')) And
            CompararValores(ReturnValue.ValorFCP{12}, objFloatUtils.fStrToFloat('12')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301798" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "53714" AND DET_CODCLI = "00418529";
    DOCUMENTO: 000000301798
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418529
       ESTADO: MS
         ITEM: 53714
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.985)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(129.85)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,985}, objFloatUtils.fStrToFloat('12,985')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418535";
    DOCUMENTO: 000000301799
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418535
       ESTADO: RS
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.88)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(92)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,88}, objFloatUtils.fStrToFloat('12,88')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301801" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "51328" AND DET_CODCLI = "00418159";
    DOCUMENTO: 000000301801
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418159
       ESTADO: MG
         ITEM: 51328
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.3566)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(122.61)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,3566}, objFloatUtils.fStrToFloat('7,3566')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301801" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418159";
    DOCUMENTO: 000000301801
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418159
       ESTADO: MG
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.923)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(49.45)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,923}, objFloatUtils.fStrToFloat('6,923')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301804" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "40446" AND DET_CODCLI = "00418374";
    DOCUMENTO: 000000301804
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418374
       ESTADO: BA
         ITEM: 40446
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(27.9608)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(199.72)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{27,9608}, objFloatUtils.fStrToFloat('27,9608')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301805" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28371" AND DET_CODCLI = "00418362";
    DOCUMENTO: 000000301805
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418362
       ESTADO: ES
         ITEM: 28371
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(20.1123)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(154.71)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{20,1123}, objFloatUtils.fStrToFloat('20,1123')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301806" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68260" AND DET_CODCLI = "00418412";
    DOCUMENTO: 000000301806
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418412
       ESTADO: PR
         ITEM: 68260
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(66.08)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(472)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{66,08}, objFloatUtils.fStrToFloat('66,08')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301807" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "55883" AND DET_CODCLI = "00418352";
    DOCUMENTO: 000000301807
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418352
       ESTADO: RJ
         ITEM: 55883
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(215.28957)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{215,28957}, objFloatUtils.fStrToFloat('215,29')) And
            CompararValores(ReturnValue.ValorFCP{4,31}, objFloatUtils.fStrToFloat('4,31')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301809" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63897" AND DET_CODCLI = "00418200";
    DOCUMENTO: 000000301809
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418200
       ESTADO: PE
         ITEM: 63897
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(59.92)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(428)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{59,92}, objFloatUtils.fStrToFloat('59,92')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301810" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "42499" AND DET_CODCLI = "00417962";
    DOCUMENTO: 000000301810
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417962
       ESTADO: MG
         ITEM: 42499
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(258.246261)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301812" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "57850" AND DET_CODCLI = "00418536";
    DOCUMENTO: 000000301812
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418536
       ESTADO: RJ
         ITEM: 57850
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.817)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(91.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,817}, objFloatUtils.fStrToFloat('12,817')) And
            CompararValores(ReturnValue.BaseFCP{91,55}, objFloatUtils.fStrToFloat('91,55')) And
            CompararValores(ReturnValue.ValorFCP{1,83}, objFloatUtils.fStrToFloat('1,83')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301813" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67834" AND DET_CODCLI = "00418521";
    DOCUMENTO: 000000301813
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418521
       ESTADO: GO
         ITEM: 67834
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.0017)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(175.59)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,0017}, objFloatUtils.fStrToFloat('2,0017')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301813" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67832" AND DET_CODCLI = "00418521";
    DOCUMENTO: 000000301813
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418521
       ESTADO: GO
         ITEM: 67832
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.5845)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(226.71)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,5845}, objFloatUtils.fStrToFloat('2,5845')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301817" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "57221" AND DET_CODCLI = "00418356";
    DOCUMENTO: 000000301817
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418356
       ESTADO: AL
         ITEM: 57221
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(1)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(10.4723)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(918.62)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{10,4723}, objFloatUtils.fStrToFloat('10,4723')) And
            CompararValores(ReturnValue.BaseFCP{918,62}, objFloatUtils.fStrToFloat('918,62')) And
            CompararValores(ReturnValue.ValorFCP{9,19}, objFloatUtils.fStrToFloat('9,19')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301817" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418356";
    DOCUMENTO: 000000301817
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418356
       ESTADO: AL
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(1)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.0801)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(46.77)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,0801}, objFloatUtils.fStrToFloat('6,0801')) And
            CompararValores(ReturnValue.BaseFCP{46,77}, objFloatUtils.fStrToFloat('46,77')) And
            CompararValores(ReturnValue.ValorFCP{0,47}, objFloatUtils.fStrToFloat('0,47')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301823" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "37616" AND DET_CODCLI = "00418557";
    DOCUMENTO: 000000301823
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418557
       ESTADO: PR
         ITEM: 37616
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.2104)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(44.36)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,2104}, objFloatUtils.fStrToFloat('6,2104')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301825" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63815" AND DET_CODCLI = "00386699";
    DOCUMENTO: 000000301825
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00386699
       ESTADO: MG
         ITEM: 63815
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(68.1969)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301825" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64021" AND DET_CODCLI = "00386699";
    DOCUMENTO: 000000301825
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00386699
       ESTADO: MG
         ITEM: 64021
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(67.83025)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301827" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65638" AND DET_CODCLI = "00418579";
    DOCUMENTO: 000000301827
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418579
       ESTADO: MG
         ITEM: 65638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(42.637)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(304.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{42,637}, objFloatUtils.fStrToFloat('42,637')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301829" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "31142" AND DET_CODCLI = "00344323";
    DOCUMENTO: 000000301829
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00344323
       ESTADO: PR
         ITEM: 31142
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.9024)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(215.04)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,9024}, objFloatUtils.fStrToFloat('12,9024')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301830" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27567" AND DET_CODCLI = "00418519";
    DOCUMENTO: 000000301830
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418519
       ESTADO: RS
         ITEM: 27567
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.0044)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(21.46)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,0044}, objFloatUtils.fStrToFloat('3,0044')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301831" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "55839" AND DET_CODCLI = "00418543";
    DOCUMENTO: 000000301831
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418543
       ESTADO: RS
         ITEM: 55839
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.5904)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(199.8)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,5904}, objFloatUtils.fStrToFloat('9,5904')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301832" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68448" AND DET_CODCLI = "00418590";
    DOCUMENTO: 000000301832
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418590
       ESTADO: RS
         ITEM: 68448
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(15.26)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(109)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{15,26}, objFloatUtils.fStrToFloat('15,26')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301833" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70252" AND DET_CODCLI = "00395945";
    DOCUMENTO: 000000301833
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00395945
       ESTADO: CE
         ITEM: 70252
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.5354)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(661)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,5354}, objFloatUtils.fStrToFloat('7,5354')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301834" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60132" AND DET_CODCLI = "00418451";
    DOCUMENTO: 000000301834
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418451
       ESTADO: MG
         ITEM: 60132
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.7)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(155)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,7}, objFloatUtils.fStrToFloat('21,7')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301835" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29259" AND DET_CODCLI = "00216902";
    DOCUMENTO: 000000301835
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00216902
       ESTADO: MT
         ITEM: 29259
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.8428)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(29.56)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,8428}, objFloatUtils.fStrToFloat('3,8428')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301835" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58603" AND DET_CODCLI = "00216902";
    DOCUMENTO: 000000301835
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00216902
       ESTADO: MT
         ITEM: 58603
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.3149)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(115.34)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,3149}, objFloatUtils.fStrToFloat('1,3149')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301837" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418559";
    DOCUMENTO: 000000301837
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418559
       ESTADO: CE
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.124)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(36.6)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,124}, objFloatUtils.fStrToFloat('5,124')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301837" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36384" AND DET_CODCLI = "00418559";
    DOCUMENTO: 000000301837
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418559
       ESTADO: CE
         ITEM: 36384
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.462)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(53.3)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,462}, objFloatUtils.fStrToFloat('7,462')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301838" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "47539" AND DET_CODCLI = "00418537";
    DOCUMENTO: 000000301838
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418537
       ESTADO: RJ
         ITEM: 47539
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.506)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,506}, objFloatUtils.fStrToFloat('2,506')) And
            CompararValores(ReturnValue.BaseFCP{17,9}, objFloatUtils.fStrToFloat('17,9')) And
            CompararValores(ReturnValue.ValorFCP{0,36}, objFloatUtils.fStrToFloat('0,36')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301839" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65772" AND DET_CODCLI = "00418551";
    DOCUMENTO: 000000301839
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418551
       ESTADO: BA
         ITEM: 65772
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.6302)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(143)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,6302}, objFloatUtils.fStrToFloat('1,6302')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301840" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "35579" AND DET_CODCLI = "00418377";
    DOCUMENTO: 000000301840
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418377
       ESTADO: GO
         ITEM: 35579
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.6237)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.49)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,6237}, objFloatUtils.fStrToFloat('1,6237')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301842" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58685" AND DET_CODCLI = "00418291";
    DOCUMENTO: 000000301842
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418291
       ESTADO: SC
         ITEM: 58685
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.537)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,537}, objFloatUtils.fStrToFloat('4,537')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301844" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "40446" AND DET_CODCLI = "00418334";
    DOCUMENTO: 000000301844
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418334
       ESTADO: MG
         ITEM: 40446
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(18.046)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(128.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{18,046}, objFloatUtils.fStrToFloat('18,046')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301845" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "66277" AND DET_CODCLI = "00418009";
    DOCUMENTO: 000000301845
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418009
       ESTADO: RS
         ITEM: 66277
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.8187)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(162.89)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,8187}, objFloatUtils.fStrToFloat('7,8187')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301846" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68715" AND DET_CODCLI = "00417956";
    DOCUMENTO: 000000301846
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417956
       ESTADO: RJ
         ITEM: 68715
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(27.0186)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(192.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{27,0186}, objFloatUtils.fStrToFloat('27,0186')) And
            CompararValores(ReturnValue.BaseFCP{192,99}, objFloatUtils.fStrToFloat('192,99')) And
            CompararValores(ReturnValue.ValorFCP{3,86}, objFloatUtils.fStrToFloat('3,86')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301847" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63996" AND DET_CODCLI = "00418336";
    DOCUMENTO: 000000301847
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418336
       ESTADO: SC
         ITEM: 63996
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.112)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(162.24)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,112}, objFloatUtils.fStrToFloat('8,112')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301849" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60527" AND DET_CODCLI = "00418522";
    DOCUMENTO: 000000301849
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418522
       ESTADO: RJ
         ITEM: 60527
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.677)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(90.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,677}, objFloatUtils.fStrToFloat('12,677')) And
            CompararValores(ReturnValue.BaseFCP{90,55}, objFloatUtils.fStrToFloat('90,55')) And
            CompararValores(ReturnValue.ValorFCP{1,81}, objFloatUtils.fStrToFloat('1,81')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301850" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69649" AND DET_CODCLI = "00418370";
    DOCUMENTO: 000000301850
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418370
       ESTADO: RN
         ITEM: 69649
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(20.846)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(148.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{20,846}, objFloatUtils.fStrToFloat('20,846')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301852" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68715" AND DET_CODCLI = "00418106";
    DOCUMENTO: 000000301852
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418106
       ESTADO: RS
         ITEM: 68715
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(27.0186)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(192.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{27,0186}, objFloatUtils.fStrToFloat('27,0186')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301853" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64481" AND DET_CODCLI = "00418338";
    DOCUMENTO: 000000301853
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418338
       ESTADO: RS
         ITEM: 64481
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.47)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(249)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,47}, objFloatUtils.fStrToFloat('7,47')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301856" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27887" AND DET_CODCLI = "00418501";
    DOCUMENTO: 000000301856
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418501
       ESTADO: RS
         ITEM: 27887
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.3038)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(43.46)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,3038}, objFloatUtils.fStrToFloat('1,3038')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301858" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "46389" AND DET_CODCLI = "00418542";
    DOCUMENTO: 000000301858
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418542
       ESTADO: PR
         ITEM: 46389
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(15.4378)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(110.27)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{15,4378}, objFloatUtils.fStrToFloat('15,4378')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301859" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64967" AND DET_CODCLI = "00418553";
    DOCUMENTO: 000000301859
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418553
       ESTADO: PE
         ITEM: 64967
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(10.9326)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(959)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{10,9326}, objFloatUtils.fStrToFloat('10,9326')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301861" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64480" AND DET_CODCLI = "00418534";
    DOCUMENTO: 000000301861
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418534
       ESTADO: MS
         ITEM: 64480
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(0.0999999999999996)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.249)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(249)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{0,0999999999999996}, objFloatUtils.fStrToFloat('0,0999999999999996')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,249}, objFloatUtils.fStrToFloat('0,249')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60687" AND DET_CODCLI = "00418340";
    DOCUMENTO: 000000301863
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418340
       ESTADO: RJ
         ITEM: 60687
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.3156)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(5.26)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,3156}, objFloatUtils.fStrToFloat('0,3156')) And
            CompararValores(ReturnValue.BaseFCP{5,26}, objFloatUtils.fStrToFloat('5,26')) And
            CompararValores(ReturnValue.ValorFCP{0,11}, objFloatUtils.fStrToFloat('0,11')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301863" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59035" AND DET_CODCLI = "00418340";
    DOCUMENTO: 000000301863
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418340
       ESTADO: RJ
         ITEM: 59035
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.985)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(42.75)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,985}, objFloatUtils.fStrToFloat('5,985')) And
            CompararValores(ReturnValue.BaseFCP{42,75}, objFloatUtils.fStrToFloat('42,75')) And
            CompararValores(ReturnValue.ValorFCP{0,86}, objFloatUtils.fStrToFloat('0,86')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301867" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60687" AND DET_CODCLI = "00418469";
    DOCUMENTO: 000000301867
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418469
       ESTADO: PE
         ITEM: 60687
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.5775)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(5.25)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,5775}, objFloatUtils.fStrToFloat('0,5775')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301867" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59035" AND DET_CODCLI = "00418469";
    DOCUMENTO: 000000301867
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418469
       ESTADO: PE
         ITEM: 59035
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.985)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(42.75)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,985}, objFloatUtils.fStrToFloat('5,985')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301868" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418494";
    DOCUMENTO: 000000301868
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418494
       ESTADO: SC
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.2725)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(48.25)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,2725}, objFloatUtils.fStrToFloat('6,2725')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301868" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418494";
    DOCUMENTO: 000000301868
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418494
       ESTADO: SC
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13.8463)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(106.51)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13,8463}, objFloatUtils.fStrToFloat('13,8463')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301869" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60687" AND DET_CODCLI = "00091870";
    DOCUMENTO: 000000301869
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00091870
       ESTADO: RS
         ITEM: 60687
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.3156)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(5.26)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,3156}, objFloatUtils.fStrToFloat('0,3156')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301871" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "61893" AND DET_CODCLI = "00418411";
    DOCUMENTO: 000000301871
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418411
       ESTADO: MT
         ITEM: 61893
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.4866)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(569)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,4866}, objFloatUtils.fStrToFloat('6,4866')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301872" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58828" AND DET_CODCLI = "00418526";
    DOCUMENTO: 000000301872
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418526
       ESTADO: RJ
         ITEM: 58828
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.9942)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(124.88)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,9942}, objFloatUtils.fStrToFloat('5,9942')) And
            CompararValores(ReturnValue.BaseFCP{124,88}, objFloatUtils.fStrToFloat('124,88')) And
            CompararValores(ReturnValue.ValorFCP{2,5}, objFloatUtils.fStrToFloat('2,5')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301874" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418440";
    DOCUMENTO: 000000301874
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418440
       ESTADO: PE
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.0317)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(18.47)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,0317}, objFloatUtils.fStrToFloat('2,0317')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301874" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418440";
    DOCUMENTO: 000000301874
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418440
       ESTADO: PE
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.6942)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(33.53)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,6942}, objFloatUtils.fStrToFloat('4,6942')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301875" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67867" AND DET_CODCLI = "00418473";
    DOCUMENTO: 000000301875
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418473
       ESTADO: RN
         ITEM: 67867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.2878)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(727)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,2878}, objFloatUtils.fStrToFloat('8,2878')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301877" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68295" AND DET_CODCLI = "00418358";
    DOCUMENTO: 000000301877
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418358
       ESTADO: RS
         ITEM: 68295
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.8442)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(128.14)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,8442}, objFloatUtils.fStrToFloat('3,8442')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67867" AND DET_CODCLI = "00418353";
    DOCUMENTO: 000000301879
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418353
       ESTADO: RS
         ITEM: 67867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(27.8664)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(580.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{27,8664}, objFloatUtils.fStrToFloat('27,8664')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301882" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67867" AND DET_CODCLI = "00418326";
    DOCUMENTO: 000000301882
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418326
       ESTADO: MG
         ITEM: 67867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(35.6486)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(742.68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{35,6486}, objFloatUtils.fStrToFloat('35,6486')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301883" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418483";
    DOCUMENTO: 000000301883
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418483
       ESTADO: MG
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.7962)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(62.83)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,7962}, objFloatUtils.fStrToFloat('8,7962')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301883" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418483";
    DOCUMENTO: 000000301883
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418483
       ESTADO: MG
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(19.4166)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(138.69)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{19,4166}, objFloatUtils.fStrToFloat('19,4166')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301884" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69554" AND DET_CODCLI = "00418389";
    DOCUMENTO: 000000301884
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418389
       ESTADO: MG
         ITEM: 69554
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(81.186)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(579.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{81,186}, objFloatUtils.fStrToFloat('81,186')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301887" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62725" AND DET_CODCLI = "00418568";
    DOCUMENTO: 000000301887
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418568
       ESTADO: MG
         ITEM: 62725
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(30.624)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(638)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{30,624}, objFloatUtils.fStrToFloat('30,624')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301891" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68719" AND DET_CODCLI = "00418583";
    DOCUMENTO: 000000301891
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418583
       ESTADO: MG
         ITEM: 68719
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.06)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(151)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,06}, objFloatUtils.fStrToFloat('9,06')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301892" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "57977" AND DET_CODCLI = "00418348";
    DOCUMENTO: 000000301892
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418348
       ESTADO: MT
         ITEM: 57977
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.3772)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(998)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,3772}, objFloatUtils.fStrToFloat('11,3772')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64967" AND DET_CODCLI = "00011935";
    DOCUMENTO: 000000301893
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00011935
       ESTADO: DF
         ITEM: 64967
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.6153)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1018.89)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,6153}, objFloatUtils.fStrToFloat('11,6153')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301894" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62463" AND DET_CODCLI = "00418592";
    DOCUMENTO: 000000301894
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418592
       ESTADO: MG
         ITEM: 62463
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(37.2005)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(775.01)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{37,2005}, objFloatUtils.fStrToFloat('37,2005')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301895" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65825" AND DET_CODCLI = "00418207";
    DOCUMENTO: 000000301895
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418207
       ESTADO: GO
         ITEM: 65825
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(60.5)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(605)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{60,5}, objFloatUtils.fStrToFloat('60,5')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301899" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69120" AND DET_CODCLI = "00418558";
    DOCUMENTO: 000000301899
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418558
       ESTADO: MA
         ITEM: 69120
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.0658)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(100.47)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,0658}, objFloatUtils.fStrToFloat('14,0658')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301899" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00418558";
    DOCUMENTO: 000000301899
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418558
       ESTADO: MA
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.008)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.2)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,008}, objFloatUtils.fStrToFloat('1,008')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301899" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418558";
    DOCUMENTO: 000000301899
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418558
       ESTADO: MA
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.4842)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.03)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,4842}, objFloatUtils.fStrToFloat('4,4842')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301900" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59004" AND DET_CODCLI = "00417723";
    DOCUMENTO: 000000301900
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417723
       ESTADO: MG
         ITEM: 59004
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1494)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(2.49)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1494}, objFloatUtils.fStrToFloat('0,1494')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301900" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63549" AND DET_CODCLI = "00417723";
    DOCUMENTO: 000000301900
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417723
       ESTADO: MG
         ITEM: 63549
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(23.8147)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(496.14)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{23,8147}, objFloatUtils.fStrToFloat('23,8147')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301900" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63876" AND DET_CODCLI = "00417723";
    DOCUMENTO: 000000301900
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417723
       ESTADO: MG
         ITEM: 63876
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.7372)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(90.98)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,7372}, objFloatUtils.fStrToFloat('12,7372')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301900" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45522" AND DET_CODCLI = "00417723";
    DOCUMENTO: 000000301900
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417723
       ESTADO: MG
         ITEM: 45522
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.7302)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.17)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,7302}, objFloatUtils.fStrToFloat('0,7302')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301904" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43408" AND DET_CODCLI = "00418347";
    DOCUMENTO: 000000301904
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418347
       ESTADO: RS
         ITEM: 43408
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(28)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(200)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{28}, objFloatUtils.fStrToFloat('28')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301905" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65593" AND DET_CODCLI = "00418463";
    DOCUMENTO: 000000301905
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418463
       ESTADO: RS
         ITEM: 65593
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.432)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(134)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,432}, objFloatUtils.fStrToFloat('6,432')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301906" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69913" AND DET_CODCLI = "00415384";
    DOCUMENTO: 000000301906
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415384
       ESTADO: RJ
         ITEM: 69913
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.2954)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(21.59)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,2954}, objFloatUtils.fStrToFloat('1,2954')) And
            CompararValores(ReturnValue.BaseFCP{21,59}, objFloatUtils.fStrToFloat('21,59')) And
            CompararValores(ReturnValue.ValorFCP{0,43}, objFloatUtils.fStrToFloat('0,43')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301906" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "51328" AND DET_CODCLI = "00415384";
    DOCUMENTO: 000000301906
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415384
       ESTADO: RJ
         ITEM: 51328
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.5584)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(142.64)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,5584}, objFloatUtils.fStrToFloat('8,5584')) And
            CompararValores(ReturnValue.BaseFCP{142,64}, objFloatUtils.fStrToFloat('142,64')) And
            CompararValores(ReturnValue.ValorFCP{2,85}, objFloatUtils.fStrToFloat('2,85')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301906" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00415384";
    DOCUMENTO: 000000301906
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415384
       ESTADO: RJ
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.966)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,966}, objFloatUtils.fStrToFloat('0,966')) And
            CompararValores(ReturnValue.BaseFCP{6,9}, objFloatUtils.fStrToFloat('6,9')) And
            CompararValores(ReturnValue.ValorFCP{0,14}, objFloatUtils.fStrToFloat('0,14')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301906" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58119" AND DET_CODCLI = "00415384";
    DOCUMENTO: 000000301906
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415384
       ESTADO: RJ
         ITEM: 58119
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1518)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(2.53)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1518}, objFloatUtils.fStrToFloat('0,1518')) And
            CompararValores(ReturnValue.BaseFCP{2,53}, objFloatUtils.fStrToFloat('2,53')) And
            CompararValores(ReturnValue.ValorFCP{0,05}, objFloatUtils.fStrToFloat('0,05')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301906" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69871" AND DET_CODCLI = "00415384";
    DOCUMENTO: 000000301906
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415384
       ESTADO: RJ
         ITEM: 69871
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.183)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.05)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,183}, objFloatUtils.fStrToFloat('0,183')) And
            CompararValores(ReturnValue.BaseFCP{3,05}, objFloatUtils.fStrToFloat('3,05')) And
            CompararValores(ReturnValue.ValorFCP{0,06}, objFloatUtils.fStrToFloat('0,06')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301907" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418511";
    DOCUMENTO: 000000301907
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418511
       ESTADO: BA
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.793)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(16.3)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,793}, objFloatUtils.fStrToFloat('1,793')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301907" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418511";
    DOCUMENTO: 000000301907
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418511
       ESTADO: BA
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.144)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(29.6)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,144}, objFloatUtils.fStrToFloat('4,144')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301908" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "34525" AND DET_CODCLI = "00418201";
    DOCUMENTO: 000000301908
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418201
       ESTADO: RJ
         ITEM: 34525
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(17.1)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(285)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{17,1}, objFloatUtils.fStrToFloat('17,1')) And
            CompararValores(ReturnValue.BaseFCP{285}, objFloatUtils.fStrToFloat('285')) And
            CompararValores(ReturnValue.ValorFCP{5,7}, objFloatUtils.fStrToFloat('5,7')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301909" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "37616" AND DET_CODCLI = "00418507";
    DOCUMENTO: 000000301909
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418507
       ESTADO: RS
         ITEM: 37616
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.6874)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(54.91)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,6874}, objFloatUtils.fStrToFloat('7,6874')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301910" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70916" AND DET_CODCLI = "00415296";
    DOCUMENTO: 000000301910
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415296
       ESTADO: RJ
         ITEM: 70916
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(34.8586)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(248.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{34,8586}, objFloatUtils.fStrToFloat('34,8586')) And
            CompararValores(ReturnValue.BaseFCP{248,99}, objFloatUtils.fStrToFloat('248,99')) And
            CompararValores(ReturnValue.ValorFCP{4,98}, objFloatUtils.fStrToFloat('4,98')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301911" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67234" AND DET_CODCLI = "00418351";
    DOCUMENTO: 000000301911
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418351
       ESTADO: PR
         ITEM: 67234
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9276)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(15.46)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9276}, objFloatUtils.fStrToFloat('0,9276')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301911" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "55693" AND DET_CODCLI = "00418351";
    DOCUMENTO: 000000301911
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418351
       ESTADO: PR
         ITEM: 55693
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(537.904882)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301912" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64545" AND DET_CODCLI = "00416199";
    DOCUMENTO: 000000301912
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00416199
       ESTADO: CE
         ITEM: 64545
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.1)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(65)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,1}, objFloatUtils.fStrToFloat('9,1')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301913" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63785" AND DET_CODCLI = "00418432";
    DOCUMENTO: 000000301913
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418432
       ESTADO: RS
         ITEM: 63785
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(16.3195)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(339.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{16,3195}, objFloatUtils.fStrToFloat('16,3195')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301918" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62664" AND DET_CODCLI = "00418379";
    DOCUMENTO: 000000301918
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418379
       ESTADO: DF
         ITEM: 62664
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.5056)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(25.04)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,5056}, objFloatUtils.fStrToFloat('3,5056')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301921" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "53809" AND DET_CODCLI = "00418027";
    DOCUMENTO: 000000301921
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418027
       ESTADO: MT
         ITEM: 53809
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(4548.70771)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301924" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "66471" AND DET_CODCLI = "00417415";
    DOCUMENTO: 000000301924
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417415
       ESTADO: MT
         ITEM: 66471
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(17.4907)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1534.27)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{17,4907}, objFloatUtils.fStrToFloat('17,4907')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301925" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60312" AND DET_CODCLI = "00418055";
    DOCUMENTO: 000000301925
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418055
       ESTADO: RJ
         ITEM: 60312
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.0232)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(292.15)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,0232}, objFloatUtils.fStrToFloat('14,0232')) And
            CompararValores(ReturnValue.BaseFCP{292,15}, objFloatUtils.fStrToFloat('292,15')) And
            CompararValores(ReturnValue.ValorFCP{5,84}, objFloatUtils.fStrToFloat('5,84')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301927" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418575";
    DOCUMENTO: 000000301927
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418575
       ESTADO: MG
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9534)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(15.89)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9534}, objFloatUtils.fStrToFloat('0,9534')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301927" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418575";
    DOCUMENTO: 000000301927
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418575
       ESTADO: MG
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.039)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(28.85)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,039}, objFloatUtils.fStrToFloat('4,039')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301933" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418020";
    DOCUMENTO: 000000301933
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418020
       ESTADO: RS
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.6952)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(40.68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,6952}, objFloatUtils.fStrToFloat('5,6952')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301933" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418020";
    DOCUMENTO: 000000301933
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418020
       ESTADO: RS
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.565)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(89.75)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,565}, objFloatUtils.fStrToFloat('12,565')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301935" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00382173";
    DOCUMENTO: 000000301935
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00382173
       ESTADO: RJ
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.7638)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(41.17)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,7638}, objFloatUtils.fStrToFloat('5,7638')) And
            CompararValores(ReturnValue.BaseFCP{41,17}, objFloatUtils.fStrToFloat('41,17')) And
            CompararValores(ReturnValue.ValorFCP{0,82}, objFloatUtils.fStrToFloat('0,82')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301935" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00382173";
    DOCUMENTO: 000000301935
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00382173
       ESTADO: RJ
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.7176)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(90.84)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,7176}, objFloatUtils.fStrToFloat('12,7176')) And
            CompararValores(ReturnValue.BaseFCP{90,84}, objFloatUtils.fStrToFloat('90,84')) And
            CompararValores(ReturnValue.ValorFCP{1,82}, objFloatUtils.fStrToFloat('1,82')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301938" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65772" AND DET_CODCLI = "00418513";
    DOCUMENTO: 000000301938
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418513
       ESTADO: RS
         ITEM: 65772
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.0824)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(147.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,0824}, objFloatUtils.fStrToFloat('7,0824')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301947" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418584";
    DOCUMENTO: 000000301947
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418584
       ESTADO: GO
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.2884)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(40.68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,2884}, objFloatUtils.fStrToFloat('5,2884')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301947" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418584";
    DOCUMENTO: 000000301947
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418584
       ESTADO: GO
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.6675)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(89.75)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,6675}, objFloatUtils.fStrToFloat('11,6675')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418461";
    DOCUMENTO: 000000301948
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418461
       ESTADO: RO
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10.5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.0139)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10,5}, objFloatUtils.fStrToFloat('10,5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,0139}, objFloatUtils.fStrToFloat('2,0139')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301948" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418461";
    DOCUMENTO: 000000301948
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418461
       ESTADO: RO
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13.5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.7007)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13,5}, objFloatUtils.fStrToFloat('13,5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,7007}, objFloatUtils.fStrToFloat('4,7007')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301952" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418449";
    DOCUMENTO: 000000301952
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418449
       ESTADO: AL
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(1)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.918)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,918}, objFloatUtils.fStrToFloat('1,918')) And
            CompararValores(ReturnValue.BaseFCP{19,18}, objFloatUtils.fStrToFloat('19,18')) And
            CompararValores(ReturnValue.ValorFCP{0,19}, objFloatUtils.fStrToFloat('0,19')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301952" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418449";
    DOCUMENTO: 000000301952
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418449
       ESTADO: AL
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(1)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.5266)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,5266}, objFloatUtils.fStrToFloat('4,5266')) And
            CompararValores(ReturnValue.BaseFCP{34,82}, objFloatUtils.fStrToFloat('34,82')) And
            CompararValores(ReturnValue.ValorFCP{0,35}, objFloatUtils.fStrToFloat('0,35')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000167;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301957" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418424";
    DOCUMENTO: 000000301957
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418424
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0632)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.72)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0632}, objFloatUtils.fStrToFloat('1,0632')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000168;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301957" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418424";
    DOCUMENTO: 000000301957
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418424
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.5052)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,5052}, objFloatUtils.fStrToFloat('4,5052')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000169;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301958" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00394043";
    DOCUMENTO: 000000301958
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00394043
       ESTADO: MG
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.7638)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(41.17)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,7638}, objFloatUtils.fStrToFloat('5,7638')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000170;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301958" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00394043";
    DOCUMENTO: 000000301958
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00394043
       ESTADO: MG
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.7176)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(90.84)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,7176}, objFloatUtils.fStrToFloat('12,7176')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000171;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301960" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418426";
    DOCUMENTO: 000000301960
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418426
       ESTADO: MG
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0662)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.77)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0662}, objFloatUtils.fStrToFloat('1,0662')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000172;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301960" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418426";
    DOCUMENTO: 000000301960
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418426
       ESTADO: MG
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.515)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.25)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,515}, objFloatUtils.fStrToFloat('4,515')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000173;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301961" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418428";
    DOCUMENTO: 000000301961
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418428
       ESTADO: RJ
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0632)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.72)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0632}, objFloatUtils.fStrToFloat('1,0632')) And
            CompararValores(ReturnValue.BaseFCP{17,72}, objFloatUtils.fStrToFloat('17,72')) And
            CompararValores(ReturnValue.ValorFCP{0,35}, objFloatUtils.fStrToFloat('0,35')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000174;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301961" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418428";
    DOCUMENTO: 000000301961
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418428
       ESTADO: RJ
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.5052)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,5052}, objFloatUtils.fStrToFloat('4,5052')) And
            CompararValores(ReturnValue.BaseFCP{32,18}, objFloatUtils.fStrToFloat('32,18')) And
            CompararValores(ReturnValue.ValorFCP{0,64}, objFloatUtils.fStrToFloat('0,64')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000175;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301962" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418456";
    DOCUMENTO: 000000301962
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418456
       ESTADO: GO
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.772)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.72)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,772}, objFloatUtils.fStrToFloat('1,772')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000176;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301962" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418456";
    DOCUMENTO: 000000301962
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418456
       ESTADO: GO
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.1834)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,1834}, objFloatUtils.fStrToFloat('4,1834')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000177;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301971" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418492";
    DOCUMENTO: 000000301971
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418492
       ESTADO: SC
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.7414)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(28.78)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,7414}, objFloatUtils.fStrToFloat('3,7414')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000178;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301971" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70307" AND DET_CODCLI = "00418492";
    DOCUMENTO: 000000301971
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418492
       ESTADO: SC
         ITEM: 70307
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.1186)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(93.22)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,1186}, objFloatUtils.fStrToFloat('12,1186')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000179;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301973" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418437";
    DOCUMENTO: 000000301973
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418437
       ESTADO: BA
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.9547)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.77)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,9547}, objFloatUtils.fStrToFloat('1,9547')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000180;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301974" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60782" AND DET_CODCLI = "00418520";
    DOCUMENTO: 000000301974
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418520
       ESTADO: MG
         ITEM: 60782
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.1862)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(128.88)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,1862}, objFloatUtils.fStrToFloat('6,1862')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000181;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301974" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64965" AND DET_CODCLI = "00418520";
    DOCUMENTO: 000000301974
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418520
       ESTADO: MG
         ITEM: 64965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(19.0524)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(635.08)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{19,0524}, objFloatUtils.fStrToFloat('19,0524')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000182;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301975" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418443";
    DOCUMENTO: 000000301975
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418443
       ESTADO: PA
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.777)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.77)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,777}, objFloatUtils.fStrToFloat('1,777')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000183;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301975" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418443";
    DOCUMENTO: 000000301975
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418443
       ESTADO: PA
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.1925)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.25)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,1925}, objFloatUtils.fStrToFloat('4,1925')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000184;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301977" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418419";
    DOCUMENTO: 000000301977
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418419
       ESTADO: RO
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10.5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.8659)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.77)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10,5}, objFloatUtils.fStrToFloat('10,5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,8659}, objFloatUtils.fStrToFloat('1,8659')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000185;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301977" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418419";
    DOCUMENTO: 000000301977
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418419
       ESTADO: RO
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13.5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.3538)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.25)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13,5}, objFloatUtils.fStrToFloat('13,5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,3538}, objFloatUtils.fStrToFloat('4,3538')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000186;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301980" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418459";
    DOCUMENTO: 000000301980
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418459
       ESTADO: SC
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.959)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(19.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,959}, objFloatUtils.fStrToFloat('0,959')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000187;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301983" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418425";
    DOCUMENTO: 000000301983
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418425
       ESTADO: TO
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.9492)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.72)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,9492}, objFloatUtils.fStrToFloat('1,9492')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000188;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301984" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67881" AND DET_CODCLI = "00418025";
    DOCUMENTO: 000000301984
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418025
       ESTADO: GO
         ITEM: 67881
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0898)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(95.6)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0898}, objFloatUtils.fStrToFloat('1,0898')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000189;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301985" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418436";
    DOCUMENTO: 000000301985
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418436
       ESTADO: BA
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.9558)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.78)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,9558}, objFloatUtils.fStrToFloat('1,9558')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000190;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301987" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60982" AND DET_CODCLI = "00418208";
    DOCUMENTO: 000000301987
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418208
       ESTADO: RS
         ITEM: 60982
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(24.768)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(516)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{24,768}, objFloatUtils.fStrToFloat('24,768')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000191;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302005" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "35268" AND DET_CODCLI = "00372880";
    DOCUMENTO: 000000302005
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00372880
       ESTADO: PE
         ITEM: 35268
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.52)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,52}, objFloatUtils.fStrToFloat('2,52')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000192;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302005" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00372880";
    DOCUMENTO: 000000302005
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00372880
       ESTADO: PE
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.48)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,48}, objFloatUtils.fStrToFloat('4,48')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000193;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302005" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "38851" AND DET_CODCLI = "00372880";
    DOCUMENTO: 000000302005
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00372880
       ESTADO: PE
         ITEM: 38851
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.28)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(102)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,28}, objFloatUtils.fStrToFloat('14,28')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000194;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302007" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45789" AND DET_CODCLI = "00418394";
    DOCUMENTO: 000000302007
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418394
       ESTADO: DF
         ITEM: 45789
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.7255)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(151.36)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,7255}, objFloatUtils.fStrToFloat('1,7255')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000195;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302008" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "40693" AND DET_CODCLI = "00395818";
    DOCUMENTO: 000000302008
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00395818
       ESTADO: MG
         ITEM: 40693
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.4875)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(155.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,4875}, objFloatUtils.fStrToFloat('7,4875')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000196;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302009" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62675" AND DET_CODCLI = "00415051";
    DOCUMENTO: 000000302009
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415051
       ESTADO: PR
         ITEM: 62675
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.0128)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(21.52)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,0128}, objFloatUtils.fStrToFloat('3,0128')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000197;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302009" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70969" AND DET_CODCLI = "00415051";
    DOCUMENTO: 000000302009
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415051
       ESTADO: PR
         ITEM: 70969
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.7938)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(5.67)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,7938}, objFloatUtils.fStrToFloat('0,7938')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000198;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302009" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64487" AND DET_CODCLI = "00415051";
    DOCUMENTO: 000000302009
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415051
       ESTADO: PR
         ITEM: 64487
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(18.8594)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(134.71)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{18,8594}, objFloatUtils.fStrToFloat('18,8594')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000199;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302015" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62470" AND DET_CODCLI = "00418508";
    DOCUMENTO: 000000302015
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418508
       ESTADO: RS
         ITEM: 62470
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(22.96)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(164)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{22,96}, objFloatUtils.fStrToFloat('22,96')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000200;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62269" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 62269
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1507)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.14)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1507}, objFloatUtils.fStrToFloat('0,1507')) And
            CompararValores(ReturnValue.BaseFCP{3,14}, objFloatUtils.fStrToFloat('3,14')) And
            CompararValores(ReturnValue.ValorFCP{0,06}, objFloatUtils.fStrToFloat('0,06')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000201;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62270" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 62270
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1646)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.43)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1646}, objFloatUtils.fStrToFloat('0,1646')) And
            CompararValores(ReturnValue.BaseFCP{3,43}, objFloatUtils.fStrToFloat('3,43')) And
            CompararValores(ReturnValue.ValorFCP{0,07}, objFloatUtils.fStrToFloat('0,07')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000202;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.8568)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.12)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,8568}, objFloatUtils.fStrToFloat('0,8568')) And
            CompararValores(ReturnValue.BaseFCP{6,12}, objFloatUtils.fStrToFloat('6,12')) And
            CompararValores(ReturnValue.ValorFCP{0,12}, objFloatUtils.fStrToFloat('0,12')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000203;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28830" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 28830
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.5246)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(10.93)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,5246}, objFloatUtils.fStrToFloat('0,5246')) And
            CompararValores(ReturnValue.BaseFCP{10,93}, objFloatUtils.fStrToFloat('10,93')) And
            CompararValores(ReturnValue.ValorFCP{0,22}, objFloatUtils.fStrToFloat('0,22')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000204;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "31511" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 31511
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(446.486586)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{446,486586}, objFloatUtils.fStrToFloat('446,49')) And
            CompararValores(ReturnValue.ValorFCP{8,93}, objFloatUtils.fStrToFloat('8,93')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000205;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65022" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 65022
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.9726)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(14.09)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,9726}, objFloatUtils.fStrToFloat('1,9726')) And
            CompararValores(ReturnValue.BaseFCP{14,09}, objFloatUtils.fStrToFloat('14,09')) And
            CompararValores(ReturnValue.ValorFCP{0,28}, objFloatUtils.fStrToFloat('0,28')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000206;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302018" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60369" AND DET_CODCLI = "00418580";
    DOCUMENTO: 000000302018
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418580
       ESTADO: RJ
         ITEM: 60369
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.633)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(10.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,633}, objFloatUtils.fStrToFloat('0,633')) And
            CompararValores(ReturnValue.BaseFCP{10,55}, objFloatUtils.fStrToFloat('10,55')) And
            CompararValores(ReturnValue.ValorFCP{0,21}, objFloatUtils.fStrToFloat('0,21')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000207;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62269" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 62269
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.0416)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.65)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,0416}, objFloatUtils.fStrToFloat('0,0416')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000208;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62270" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 62270
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.0454)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.98)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,0454}, objFloatUtils.fStrToFloat('0,0454')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000209;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.994)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.1)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,994}, objFloatUtils.fStrToFloat('0,994')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000210;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28830" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 28830
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1447)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.69)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1447}, objFloatUtils.fStrToFloat('0,1447')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000211;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "31511" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 31511
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.07)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(518.201111)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,07}, objFloatUtils.fStrToFloat('0,07')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000212;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65022" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 65022
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.289)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(16.35)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,289}, objFloatUtils.fStrToFloat('2,289')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000213;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302021" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60369" AND DET_CODCLI = "00418033";
    DOCUMENTO: 000000302021
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418033
       ESTADO: BA
         ITEM: 60369
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.3464)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.24)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,3464}, objFloatUtils.fStrToFloat('1,3464')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000214;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302022" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59728" AND DET_CODCLI = "00417979";
    DOCUMENTO: 000000302022
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417979
       ESTADO: PR
         ITEM: 59728
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.7677)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(182.66)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,7677}, objFloatUtils.fStrToFloat('8,7677')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000215;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302022" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36321" AND DET_CODCLI = "00417979";
    DOCUMENTO: 000000302022
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417979
       ESTADO: PR
         ITEM: 36321
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.2172)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.62)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,2172}, objFloatUtils.fStrToFloat('0,2172')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000216;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302022" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68975" AND DET_CODCLI = "00417979";
    DOCUMENTO: 000000302022
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417979
       ESTADO: PR
         ITEM: 68975
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.2508)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(4.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,2508}, objFloatUtils.fStrToFloat('0,2508')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000217;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302022" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43863" AND DET_CODCLI = "00417979";
    DOCUMENTO: 000000302022
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417979
       ESTADO: PR
         ITEM: 43863
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.8226)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(13.71)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,8226}, objFloatUtils.fStrToFloat('0,8226')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000218;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302022" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43866" AND DET_CODCLI = "00417979";
    DOCUMENTO: 000000302022
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417979
       ESTADO: PR
         ITEM: 43866
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.933)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(15.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,933}, objFloatUtils.fStrToFloat('0,933')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000219;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302024" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28361" AND DET_CODCLI = "00418447";
    DOCUMENTO: 000000302024
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418447
       ESTADO: AC
         ITEM: 28361
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(135.624)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1356.24)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{135,624}, objFloatUtils.fStrToFloat('135,624')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000220;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302029" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418762";
    DOCUMENTO: 000000302029
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418762
       ESTADO: MG
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.5144)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(25.24)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,5144}, objFloatUtils.fStrToFloat('1,5144')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000221;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302029" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418762";
    DOCUMENTO: 000000302029
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418762
       ESTADO: MG
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.4162)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(45.83)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,4162}, objFloatUtils.fStrToFloat('6,4162')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000222;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70336" AND DET_CODCLI = "00378933";
    DOCUMENTO: 000000302030
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00378933
       ESTADO: GO
         ITEM: 70336
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.3748)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(25.96)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,3748}, objFloatUtils.fStrToFloat('3,3748')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000223;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00378933";
    DOCUMENTO: 000000302030
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00378933
       ESTADO: GO
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.5452)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(58.04)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,5452}, objFloatUtils.fStrToFloat('7,5452')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000224;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302030" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "38851" AND DET_CODCLI = "00378933";
    DOCUMENTO: 000000302030
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00378933
       ESTADO: GO
         ITEM: 38851
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.58)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(166)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,58}, objFloatUtils.fStrToFloat('21,58')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000225;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302031" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418010";
    DOCUMENTO: 000000302031
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418010
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0692)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0692}, objFloatUtils.fStrToFloat('1,0692')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000226;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302031" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418010";
    DOCUMENTO: 000000302031
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418010
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.1828)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(37.02)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,1828}, objFloatUtils.fStrToFloat('5,1828')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000227;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302031" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00418010";
    DOCUMENTO: 000000302031
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418010
       ESTADO: RS
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13.1572)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(93.98)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13,1572}, objFloatUtils.fStrToFloat('13,1572')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000228;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302032" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28361" AND DET_CODCLI = "00418447";
    DOCUMENTO: 000000302032
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418447
       ESTADO: AC
         ITEM: 28361
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(101.718)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1017.18)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{101,718}, objFloatUtils.fStrToFloat('101,718')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000229;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302038" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69650" AND DET_CODCLI = "00418752";
    DOCUMENTO: 000000302038
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418752
       ESTADO: PR
         ITEM: 69650
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.8778)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(156.27)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,8778}, objFloatUtils.fStrToFloat('21,8778')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000230;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302040" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00418051";
    DOCUMENTO: 000000302040
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418051
       ESTADO: RS
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0542)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.53)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0542}, objFloatUtils.fStrToFloat('1,0542')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000231;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302040" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418051";
    DOCUMENTO: 000000302040
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418051
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.077)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.95)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,077}, objFloatUtils.fStrToFloat('1,077')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000232;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302040" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418051";
    DOCUMENTO: 000000302040
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418051
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.6928)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(33.52)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,6928}, objFloatUtils.fStrToFloat('4,6928')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000233;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302050" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58685" AND DET_CODCLI = "00418479";
    DOCUMENTO: 000000302050
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418479
       ESTADO: RJ
         ITEM: 58685
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.886)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,886}, objFloatUtils.fStrToFloat('4,886')) And
            CompararValores(ReturnValue.BaseFCP{34,9}, objFloatUtils.fStrToFloat('34,9')) And
            CompararValores(ReturnValue.ValorFCP{0,7}, objFloatUtils.fStrToFloat('0,7')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000234;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302056" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418441";
    DOCUMENTO: 000000302056
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418441
       ESTADO: PR
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.256)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(30.4)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,256}, objFloatUtils.fStrToFloat('4,256')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000235;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302056" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59057" AND DET_CODCLI = "00418441";
    DOCUMENTO: 000000302056
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418441
       ESTADO: PR
         ITEM: 59057
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.3426)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(59.59)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,3426}, objFloatUtils.fStrToFloat('8,3426')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000236;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302070" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69649" AND DET_CODCLI = "00418444";
    DOCUMENTO: 000000302070
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418444
       ESTADO: PI
         ITEM: 69649
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(19.357)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(148.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{19,357}, objFloatUtils.fStrToFloat('19,357')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000237;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302071" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418517";
    DOCUMENTO: 000000302071
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418517
       ESTADO: MG
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.3016)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(38.36)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,3016}, objFloatUtils.fStrToFloat('2,3016')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000238;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302071" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418517";
    DOCUMENTO: 000000302071
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418517
       ESTADO: MG
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.7496)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(69.64)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,7496}, objFloatUtils.fStrToFloat('9,7496')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000239;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302082" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36294" AND DET_CODCLI = "00418457";
    DOCUMENTO: 000000302082
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418457
       ESTADO: PR
         ITEM: 36294
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(28.0056)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(200.04)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{28,0056}, objFloatUtils.fStrToFloat('28,0056')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000240;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302083" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00380380";
    DOCUMENTO: 000000302083
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00380380
       ESTADO: CE
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 2202
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.9186)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(27.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,92}, objFloatUtils.fStrToFloat('3,92')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000241;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302083" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00380380";
    DOCUMENTO: 000000302083
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00380380
       ESTADO: CE
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 2202
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(10.899)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(77.85)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{10,9}, objFloatUtils.fStrToFloat('10,9')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000242;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302083" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70336" AND DET_CODCLI = "00380380";
    DOCUMENTO: 000000302083
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00380380
       ESTADO: CE
         ITEM: 70336
 ITEM SERVIÇO: NÃO
         CFOP: 2202
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.7178)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.27)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,72}, objFloatUtils.fStrToFloat('1,72')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000243;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302088" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68715" AND DET_CODCLI = "00418427";
    DOCUMENTO: 000000302088
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418427
       ESTADO: PR
         ITEM: 68715
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(27.02)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(193)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{27,02}, objFloatUtils.fStrToFloat('27,02')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000244;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "41311" AND DET_CODCLI = "00417748";
    DOCUMENTO: 000000302089
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417748
       ESTADO: PR
         ITEM: 41311
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9198)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.57)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9198}, objFloatUtils.fStrToFloat('0,9198')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000245;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00417748";
    DOCUMENTO: 000000302089
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417748
       ESTADO: PR
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0682)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.63)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0682}, objFloatUtils.fStrToFloat('1,0682')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000246;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00417748";
    DOCUMENTO: 000000302089
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417748
       ESTADO: PR
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0932)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(18.22)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0932}, objFloatUtils.fStrToFloat('1,0932')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000247;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00417748";
    DOCUMENTO: 000000302089
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417748
       ESTADO: PR
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.7614)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(34.01)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,7614}, objFloatUtils.fStrToFloat('4,7614')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000248;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60247" AND DET_CODCLI = "00417748";
    DOCUMENTO: 000000302089
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417748
       ESTADO: PR
         ITEM: 60247
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9954)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.11)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9954}, objFloatUtils.fStrToFloat('0,9954')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000249;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302090" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "34525" AND DET_CODCLI = "00037333";
    DOCUMENTO: 000000302090
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00037333
       ESTADO: SC
         ITEM: 34525
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.25)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(285)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,25}, objFloatUtils.fStrToFloat('14,25')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000250;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302095" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00392863";
    DOCUMENTO: 000000302095
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00392863
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0344)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.24)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0344}, objFloatUtils.fStrToFloat('1,0344')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000251;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302095" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00392863";
    DOCUMENTO: 000000302095
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00392863
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.3806)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(31.29)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,3806}, objFloatUtils.fStrToFloat('4,3806')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000252;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302095" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00392863";
    DOCUMENTO: 000000302095
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00392863
       ESTADO: RS
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.1258)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(79.47)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,1258}, objFloatUtils.fStrToFloat('11,1258')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000253;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302097" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "32714" AND DET_CODCLI = "00418387";
    DOCUMENTO: 000000302097
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418387
       ESTADO: RJ
         ITEM: 32714
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.4686)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(207.81)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,4686}, objFloatUtils.fStrToFloat('12,4686')) And
            CompararValores(ReturnValue.BaseFCP{207,81}, objFloatUtils.fStrToFloat('207,81')) And
            CompararValores(ReturnValue.ValorFCP{4,16}, objFloatUtils.fStrToFloat('4,16')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000254;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302099" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "41311" AND DET_CODCLI = "00417736";
    DOCUMENTO: 000000302099
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417736
       ESTADO: RS
         ITEM: 41311
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.8624)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.16)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,8624}, objFloatUtils.fStrToFloat('0,8624')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000255;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302099" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00417736";
    DOCUMENTO: 000000302099
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417736
       ESTADO: RS
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0024)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.16)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0024}, objFloatUtils.fStrToFloat('1,0024')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000256;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302099" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00417736";
    DOCUMENTO: 000000302099
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417736
       ESTADO: RS
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0254)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.09)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0254}, objFloatUtils.fStrToFloat('1,0254')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000257;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302099" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00417736";
    DOCUMENTO: 000000302099
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417736
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.4674)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(31.91)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,4674}, objFloatUtils.fStrToFloat('4,4674')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000258;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302099" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60247" AND DET_CODCLI = "00417736";
    DOCUMENTO: 000000302099
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417736
       ESTADO: RS
         ITEM: 60247
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9338)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.67)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9338}, objFloatUtils.fStrToFloat('0,9338')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000259;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302103" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "33902" AND DET_CODCLI = "00407310";
    DOCUMENTO: 000000302103
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00407310
       ESTADO: MG
         ITEM: 33902
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(118.1179)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(2460.79)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{118,1179}, objFloatUtils.fStrToFloat('118,1179')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000260;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302103" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63598" AND DET_CODCLI = "00407310";
    DOCUMENTO: 000000302103
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00407310
       ESTADO: MG
         ITEM: 63598
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.4)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(189.96)
      .BaseDestino(189.96)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,4}, objFloatUtils.fStrToFloat('11,4')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000261;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302106" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "66139" AND DET_CODCLI = "00417959";
    DOCUMENTO: 000000302106
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417959
       ESTADO: BA
         ITEM: 66139
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.5026)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1009)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,5026}, objFloatUtils.fStrToFloat('11,5026')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000262;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302108" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68308" AND DET_CODCLI = "00418515";
    DOCUMENTO: 000000302108
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418515
       ESTADO: PR
         ITEM: 68308
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.2196)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(103.66)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,2196}, objFloatUtils.fStrToFloat('6,2196')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000263;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302109" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63335" AND DET_CODCLI = "00414685";
    DOCUMENTO: 000000302109
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00414685
       ESTADO: RS
         ITEM: 63335
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(29.7806)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(620.43)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{29,7806}, objFloatUtils.fStrToFloat('29,7806')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000264;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302110" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69160" AND DET_CODCLI = "00417727";
    DOCUMENTO: 000000302110
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417727
       ESTADO: MG
         ITEM: 69160
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(90.44)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(646)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{90,44}, objFloatUtils.fStrToFloat('90,44')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000265;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302112" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67867" AND DET_CODCLI = "00418755";
    DOCUMENTO: 000000302112
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418755
       ESTADO: RJ
         ITEM: 67867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(32.903)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(685.48)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{32,903}, objFloatUtils.fStrToFloat('32,903')) And
            CompararValores(ReturnValue.BaseFCP{685,48}, objFloatUtils.fStrToFloat('685,48')) And
            CompararValores(ReturnValue.ValorFCP{13,71}, objFloatUtils.fStrToFloat('13,71')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000266;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302115" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00418491";
    DOCUMENTO: 000000302115
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418491
       ESTADO: RS
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.91)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.5)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,91}, objFloatUtils.fStrToFloat('0,91')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000267;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302115" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64389" AND DET_CODCLI = "00418491";
    DOCUMENTO: 000000302115
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418491
       ESTADO: RS
         ITEM: 64389
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.78)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(27)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,78}, objFloatUtils.fStrToFloat('3,78')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000268;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302115" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418491";
    DOCUMENTO: 000000302115
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418491
       ESTADO: RS
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.06)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(29)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,06}, objFloatUtils.fStrToFloat('4,06')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000269;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302115" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65639" AND DET_CODCLI = "00418491";
    DOCUMENTO: 000000302115
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418491
       ESTADO: RS
         ITEM: 65639
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(42)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(300)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{42}, objFloatUtils.fStrToFloat('42')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000270;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302118" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418524";
    DOCUMENTO: 000000302118
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418524
       ESTADO: GO
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.304)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(23.04)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,304}, objFloatUtils.fStrToFloat('2,304')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000271;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302118" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418524";
    DOCUMENTO: 000000302118
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418524
       ESTADO: GO
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.2218)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(47.86)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,2218}, objFloatUtils.fStrToFloat('6,2218')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000272;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302118" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63339" AND DET_CODCLI = "00418524";
    DOCUMENTO: 000000302118
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418524
       ESTADO: GO
         ITEM: 63339
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(15.7937)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(121.49)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{15,7937}, objFloatUtils.fStrToFloat('15,7937')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000273;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302119" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00377931";
    DOCUMENTO: 000000302119
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00377931
       ESTADO: GO
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.45)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(14.5)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,45}, objFloatUtils.fStrToFloat('1,45')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000274;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302119" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00377931";
    DOCUMENTO: 000000302119
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00377931
       ESTADO: GO
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.692)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(28.4)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,692}, objFloatUtils.fStrToFloat('3,692')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000275;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302119" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "38851" AND DET_CODCLI = "00377931";
    DOCUMENTO: 000000302119
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00377931
       ESTADO: GO
         ITEM: 38851
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(10.673)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(82.1)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{10,673}, objFloatUtils.fStrToFloat('10,673')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000276;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302120" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36311" AND DET_CODCLI = "00414986";
    DOCUMENTO: 000000302120
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00414986
       ESTADO: CE
         ITEM: 36311
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(41.9384)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(299.56)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{41,9384}, objFloatUtils.fStrToFloat('41,9384')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000277;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302120" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "57304" AND DET_CODCLI = "00414986";
    DOCUMENTO: 000000302120
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00414986
       ESTADO: CE
         ITEM: 57304
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.0279)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(177.89)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,0279}, objFloatUtils.fStrToFloat('2,0279')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000278;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302120" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67365" AND DET_CODCLI = "00414986";
    DOCUMENTO: 000000302120
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00414986
       ESTADO: CE
         ITEM: 67365
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(10.0497)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(881.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{10,0497}, objFloatUtils.fStrToFloat('10,0497')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000279;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302122" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36090" AND DET_CODCLI = "00415381";
    DOCUMENTO: 000000302122
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415381
       ESTADO: MG
         ITEM: 36090
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(252.9885)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000280;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302122" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29354" AND DET_CODCLI = "00415381";
    DOCUMENTO: 000000302122
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00415381
       ESTADO: MG
         ITEM: 29354
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(19.32)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(322)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{19,32}, objFloatUtils.fStrToFloat('19,32')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000281;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302127" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64546" AND DET_CODCLI = "00404607";
    DOCUMENTO: 000000302127
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00404607
       ESTADO: MG
         ITEM: 64546
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(17.3012)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(123.58)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{17,3012}, objFloatUtils.fStrToFloat('17,3012')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000282;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302127" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58875" AND DET_CODCLI = "00404607";
    DOCUMENTO: 000000302127
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00404607
       ESTADO: MG
         ITEM: 58875
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.4236)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.06)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,4236}, objFloatUtils.fStrToFloat('0,4236')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000283;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302127" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "37616" AND DET_CODCLI = "00404607";
    DOCUMENTO: 000000302127
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00404607
       ESTADO: MG
         ITEM: 37616
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.094)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(22.1)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,094}, objFloatUtils.fStrToFloat('3,094')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000284;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302128" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62625" AND DET_CODCLI = "00198042";
    DOCUMENTO: 000000302128
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00198042
       ESTADO: GO
         ITEM: 62625
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.9609)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(168.93)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,9609}, objFloatUtils.fStrToFloat('21,9609')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000285;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302129" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29568" AND DET_CODCLI = "00418029";
    DOCUMENTO: 000000302129
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418029
       ESTADO: RS
         ITEM: 29568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.736)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(182)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,736}, objFloatUtils.fStrToFloat('8,736')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000286;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302133" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63351" AND DET_CODCLI = "00239323";
    DOCUMENTO: 000000302133
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00239323
       ESTADO: BA
         ITEM: 63351
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.52)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,52}, objFloatUtils.fStrToFloat('9,52')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000287;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302134" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59649" AND DET_CODCLI = "00418738";
    DOCUMENTO: 000000302134
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418738
       ESTADO: RS
         ITEM: 59649
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13.782)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(229.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13,782}, objFloatUtils.fStrToFloat('13,782')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000288;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302147" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00418840";
    DOCUMENTO: 000000302147
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418840
       ESTADO: MG
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.4524)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(57.54)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,4524}, objFloatUtils.fStrToFloat('3,4524')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000289;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302147" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00418840";
    DOCUMENTO: 000000302147
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418840
       ESTADO: MG
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.6244)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(104.46)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,6244}, objFloatUtils.fStrToFloat('14,6244')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000290;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302154" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62426" AND DET_CODCLI = "00418813";
    DOCUMENTO: 000000302154
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418813
       ESTADO: RJ
         ITEM: 62426
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(31.8915)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1063.05)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{31,8915}, objFloatUtils.fStrToFloat('31,8915')) And
            CompararValores(ReturnValue.BaseFCP{1063,05}, objFloatUtils.fStrToFloat('1063,05')) And
            CompararValores(ReturnValue.ValorFCP{21,26}, objFloatUtils.fStrToFloat('21,26')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000291;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302155" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "32391" AND DET_CODCLI = "00418486";
    DOCUMENTO: 000000302155
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418486
       ESTADO: GO
         ITEM: 32391
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.8266)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(44.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,8266}, objFloatUtils.fStrToFloat('5,8266')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000292;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "41311" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 41311
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.8008)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.16)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,8008}, objFloatUtils.fStrToFloat('0,8008')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000293;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9308)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.16)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9308}, objFloatUtils.fStrToFloat('0,9308')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000294;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.4314)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(41.78)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,4314}, objFloatUtils.fStrToFloat('5,4314')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000295;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.709)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(17.09)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,709}, objFloatUtils.fStrToFloat('1,709')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000296;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.1483)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(31.91)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,1483}, objFloatUtils.fStrToFloat('4,1483')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000297;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.9886)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(92.22)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,9886}, objFloatUtils.fStrToFloat('11,9886')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000298;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302156" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60247" AND DET_CODCLI = "00417761";
    DOCUMENTO: 000000302156
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00417761
       ESTADO: ES
         ITEM: 60247
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.8671)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(6.67)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,8671}, objFloatUtils.fStrToFloat('0,8671')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000299;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302158" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69913" AND DET_CODCLI = "00407759";
    DOCUMENTO: 000000302158
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00407759
       ESTADO: BA
         ITEM: 69913
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(11)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.6945)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(69.95)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,6945}, objFloatUtils.fStrToFloat('7,6945')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000300;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302160" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "42924" AND DET_CODCLI = "00114671";
    DOCUMENTO: 000000302160
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00114671
       ESTADO: MG
         ITEM: 42924
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.603)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(10.05)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,603}, objFloatUtils.fStrToFloat('0,603')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000301;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302160" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60788" AND DET_CODCLI = "00114671";
    DOCUMENTO: 000000302160
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00114671
       ESTADO: MG
         ITEM: 60788
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.986)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(33.1)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,986}, objFloatUtils.fStrToFloat('1,986')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000302;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302161" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "42867" AND DET_CODCLI = "00418790";
    DOCUMENTO: 000000302161
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418790
       ESTADO: SC
         ITEM: 42867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(20.112)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(419)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{20,112}, objFloatUtils.fStrToFloat('20,112')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000303;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302162" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69324" AND DET_CODCLI = "00418763";
    DOCUMENTO: 000000302162
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418763
       ESTADO: PR
         ITEM: 69324
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(427.601896)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000304;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302166" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "41454" AND DET_CODCLI = "00398165";
    DOCUMENTO: 000000302166
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00398165
       ESTADO: MG
         ITEM: 41454
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.2563)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(442.84)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,2563}, objFloatUtils.fStrToFloat('21,2563')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000305;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302167" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65592" AND DET_CODCLI = "00398165";
    DOCUMENTO: 000000302167
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00398165
       ESTADO: MG
         ITEM: 65592
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.1462)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(148.88)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,1462}, objFloatUtils.fStrToFloat('7,1462')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000306;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302167" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "33946" AND DET_CODCLI = "00398165";
    DOCUMENTO: 000000302167
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00398165
       ESTADO: MG
         ITEM: 33946
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.2614)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(59.01)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,2614}, objFloatUtils.fStrToFloat('8,2614')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000307;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302176" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68293" AND DET_CODCLI = "00418430";
    DOCUMENTO: 000000302176
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418430
       ESTADO: BA
         ITEM: 68293
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(0.0999999999999996)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.2656)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(265.6)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{0,0999999999999996}, objFloatUtils.fStrToFloat('0,0999999999999996')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,2656}, objFloatUtils.fStrToFloat('0,2656')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000308;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302179" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60431" AND DET_CODCLI = "00418835";
    DOCUMENTO: 000000302179
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418835
       ESTADO: RJ
         ITEM: 60431
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.2716)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1.94)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,2716}, objFloatUtils.fStrToFloat('0,2716')) And
            CompararValores(ReturnValue.BaseFCP{1,94}, objFloatUtils.fStrToFloat('1,94')) And
            CompararValores(ReturnValue.ValorFCP{0,04}, objFloatUtils.fStrToFloat('0,04')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000309;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302179" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65591" AND DET_CODCLI = "00418835";
    DOCUMENTO: 000000302179
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418835
       ESTADO: RJ
         ITEM: 65591
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.501)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(156.27)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,501}, objFloatUtils.fStrToFloat('7,501')) And
            CompararValores(ReturnValue.BaseFCP{156,27}, objFloatUtils.fStrToFloat('156,27')) And
            CompararValores(ReturnValue.ValorFCP{3,13}, objFloatUtils.fStrToFloat('3,13')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000310;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302180" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29224" AND DET_CODCLI = "00418807";
    DOCUMENTO: 000000302180
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418807
       ESTADO: MT
         ITEM: 29224
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.6887)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,6887}, objFloatUtils.fStrToFloat('1,6887')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000311;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302181" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28954" AND DET_CODCLI = "00268108";
    DOCUMENTO: 000000302181
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00268108
       ESTADO: CE
         ITEM: 28954
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.047)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(355)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,047}, objFloatUtils.fStrToFloat('4,047')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000312;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62269" AND DET_CODCLI = "00418818";
    DOCUMENTO: 000000302182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418818
       ESTADO: MG
         ITEM: 62269
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.179)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(3.73)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,179}, objFloatUtils.fStrToFloat('0,179')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000313;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45885" AND DET_CODCLI = "00418818";
    DOCUMENTO: 000000302182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418818
       ESTADO: MG
         ITEM: 45885
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.3936)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(24.24)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,3936}, objFloatUtils.fStrToFloat('3,3936')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000314;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28830" AND DET_CODCLI = "00418818";
    DOCUMENTO: 000000302182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418818
       ESTADO: MG
         ITEM: 28830
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.623)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(12.98)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,623}, objFloatUtils.fStrToFloat('0,623')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000315;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65022" AND DET_CODCLI = "00418818";
    DOCUMENTO: 000000302182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418818
       ESTADO: MG
         ITEM: 65022
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.0892)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.78)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,0892}, objFloatUtils.fStrToFloat('1,0892')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000316;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60369" AND DET_CODCLI = "00418818";
    DOCUMENTO: 000000302182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418818
       ESTADO: MG
         ITEM: 60369
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.4602)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(7.67)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,4602}, objFloatUtils.fStrToFloat('0,4602')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000317;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302184" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69912" AND DET_CODCLI = "00377822";
    DOCUMENTO: 000000302184
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00377822
       ESTADO: RS
         ITEM: 69912
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.194)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(69.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,194}, objFloatUtils.fStrToFloat('4,194')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000318;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302185" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "37272" AND DET_CODCLI = "00418789";
    DOCUMENTO: 000000302185
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418789
       ESTADO: ES
         ITEM: 37272
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(16.1187)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(123.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{16,1187}, objFloatUtils.fStrToFloat('16,1187')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000319;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302187" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68735" AND DET_CODCLI = "00418839";
    DOCUMENTO: 000000302187
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418839
       ESTADO: MG
         ITEM: 68735
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(20.154)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(335.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{20,154}, objFloatUtils.fStrToFloat('20,154')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000320;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302189" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00412538";
    DOCUMENTO: 000000302189
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00412538
       ESTADO: RJ
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(50)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.BaseFCP{50}, objFloatUtils.fStrToFloat('50')) And
            CompararValores(ReturnValue.ValorFCP{1}, objFloatUtils.fStrToFloat('1')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000321;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302190" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00406153";
    DOCUMENTO: 000000302190
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00406153
       ESTADO: PR
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(50)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000322;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302191" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67832" AND DET_CODCLI = "00418830";
    DOCUMENTO: 000000302191
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418830
       ESTADO: PA
         ITEM: 67832
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.694)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(236.32)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,694}, objFloatUtils.fStrToFloat('2,694')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000323;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302194" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59057" AND DET_CODCLI = "00418808";
    DOCUMENTO: 000000302194
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418808
       ESTADO: MG
         ITEM: 59057
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(9.3548)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(66.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{9,3548}, objFloatUtils.fStrToFloat('9,3548')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000324;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302195" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "66734" AND DET_CODCLI = "00418446";
    DOCUMENTO: 000000302195
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418446
       ESTADO: MT
         ITEM: 66734
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.9066)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(60.82)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,9066}, objFloatUtils.fStrToFloat('7,9066')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000325;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302195" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "67986" AND DET_CODCLI = "00418446";
    DOCUMENTO: 000000302195
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418446
       ESTADO: MT
         ITEM: 67986
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.6895)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(499.08)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,6895}, objFloatUtils.fStrToFloat('5,6895')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000326;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302198" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00383592";
    DOCUMENTO: 000000302198
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00383592
       ESTADO: MG
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.9348)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(15.58)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,9348}, objFloatUtils.fStrToFloat('0,9348')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000327;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302198" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00383592";
    DOCUMENTO: 000000302198
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00383592
       ESTADO: MG
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.27)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(30.5)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,27}, objFloatUtils.fStrToFloat('4,27')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000328;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302198" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "38851" AND DET_CODCLI = "00383592";
    DOCUMENTO: 000000302198
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00383592
       ESTADO: MG
         ITEM: 38851
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.4688)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(81.92)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,4688}, objFloatUtils.fStrToFloat('11,4688')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000329;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302200" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64490" AND DET_CODCLI = "00404591";
    DOCUMENTO: 000000302200
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00404591
       ESTADO: SE
         ITEM: 64490
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(171.7422)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1226.73)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{171,7422}, objFloatUtils.fStrToFloat('171,7422')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000330;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302204" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27887" AND DET_CODCLI = "00418955";
    DOCUMENTO: 000000302204
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418955
       ESTADO: DF
         ITEM: 27887
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(0.0999999999999996)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.0635)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(63.48)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{0,0999999999999996}, objFloatUtils.fStrToFloat('0,0999999999999996')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,0635}, objFloatUtils.fStrToFloat('0,0635')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000331;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302205" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43515" AND DET_CODCLI = "00304040";
    DOCUMENTO: 000000302205
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00304040
       ESTADO: MG
         ITEM: 43515
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(67.482)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1124.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{67,482}, objFloatUtils.fStrToFloat('67,482')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000332;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302206" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69645" AND DET_CODCLI = "00418816";
    DOCUMENTO: 000000302206
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418816
       ESTADO: RJ
         ITEM: 69645
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(23.4374)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(167.41)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{23,4374}, objFloatUtils.fStrToFloat('23,4374')) And
            CompararValores(ReturnValue.BaseFCP{167,41}, objFloatUtils.fStrToFloat('167,41')) And
            CompararValores(ReturnValue.ValorFCP{3,35}, objFloatUtils.fStrToFloat('3,35')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000333;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302206" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418816";
    DOCUMENTO: 000000302206
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418816
       ESTADO: RJ
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.3486)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(52.49)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,3486}, objFloatUtils.fStrToFloat('7,3486')) And
            CompararValores(ReturnValue.BaseFCP{52,49}, objFloatUtils.fStrToFloat('52,49')) And
            CompararValores(ReturnValue.ValorFCP{1,05}, objFloatUtils.fStrToFloat('1,05')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000334;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302208" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36311" AND DET_CODCLI = "00164896";
    DOCUMENTO: 000000302208
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00164896
       ESTADO: RS
         ITEM: 36311
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(36.1494)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(258.21)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{36,1494}, objFloatUtils.fStrToFloat('36,1494')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000335;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302208" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "57304" AND DET_CODCLI = "00164896";
    DOCUMENTO: 000000302208
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00164896
       ESTADO: RS
         ITEM: 57304
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.3598)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(153.33)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,3598}, objFloatUtils.fStrToFloat('7,3598')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000336;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302208" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29769" AND DET_CODCLI = "00164896";
    DOCUMENTO: 000000302208
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00164896
       ESTADO: RS
         ITEM: 29769
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.317)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(16.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,317}, objFloatUtils.fStrToFloat('2,317')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000337;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302208" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58680" AND DET_CODCLI = "00164896";
    DOCUMENTO: 000000302208
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00164896
       ESTADO: RS
         ITEM: 58680
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(101.3432)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(723.88)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{101,3432}, objFloatUtils.fStrToFloat('101,3432')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000338;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302210" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418947";
    DOCUMENTO: 000000302210
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418947
       ESTADO: BA
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.9766)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(42.69)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,9766}, objFloatUtils.fStrToFloat('5,9766')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000339;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302210" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418947";
    DOCUMENTO: 000000302210
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418947
       ESTADO: BA
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(13.1894)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(94.21)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{13,1894}, objFloatUtils.fStrToFloat('13,1894')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000340;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302211" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63791" AND DET_CODCLI = "00418952";
    DOCUMENTO: 000000302211
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418952
       ESTADO: RJ
         ITEM: 63791
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(249.348666)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{249,348666}, objFloatUtils.fStrToFloat('249,35')) And
            CompararValores(ReturnValue.ValorFCP{4,99}, objFloatUtils.fStrToFloat('4,99')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000341;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302212" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "51730" AND DET_CODCLI = "00418964";
    DOCUMENTO: 000000302212
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418964
       ESTADO: RJ
         ITEM: 51730
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.6772)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(61.98)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,6772}, objFloatUtils.fStrToFloat('8,6772')) And
            CompararValores(ReturnValue.BaseFCP{61,98}, objFloatUtils.fStrToFloat('61,98')) And
            CompararValores(ReturnValue.ValorFCP{1,24}, objFloatUtils.fStrToFloat('1,24')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000342;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302214" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65593" AND DET_CODCLI = "00418935";
    DOCUMENTO: 000000302214
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418935
       ESTADO: MA
         ITEM: 65593
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.5493)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(135.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,5493}, objFloatUtils.fStrToFloat('1,5493')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000343;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302215" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "28371" AND DET_CODCLI = "00418961";
    DOCUMENTO: 000000302215
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418961
       ESTADO: RS
         ITEM: 28371
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(29.4)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(210)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{29,4}, objFloatUtils.fStrToFloat('29,4')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000344;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302216" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27462" AND DET_CODCLI = "00169163";
    DOCUMENTO: 000000302216
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00169163
       ESTADO: RS
         ITEM: 27462
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.5006)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(75.01)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,5006}, objFloatUtils.fStrToFloat('4,5006')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000345;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302218" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62852" AND DET_CODCLI = "00418943";
    DOCUMENTO: 000000302218
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418943
       ESTADO: RS
         ITEM: 62852
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(253.817129)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000346;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302221" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "53717" AND DET_CODCLI = "00418967";
    DOCUMENTO: 000000302221
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418967
       ESTADO: MG
         ITEM: 53717
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.7904)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(129.84)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,7904}, objFloatUtils.fStrToFloat('7,7904')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000347;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302224" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27703" AND DET_CODCLI = "00413042";
    DOCUMENTO: 000000302224
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00413042
       ESTADO: MG
         ITEM: 27703
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(31.08)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(222)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{31,08}, objFloatUtils.fStrToFloat('31,08')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000348;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302224" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58680" AND DET_CODCLI = "00413042";
    DOCUMENTO: 000000302224
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00413042
       ESTADO: MG
         ITEM: 58680
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(97.86)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(699)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{97,86}, objFloatUtils.fStrToFloat('97,86')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000349;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302226" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "51328" AND DET_CODCLI = "00418934";
    DOCUMENTO: 000000302226
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418934
       ESTADO: ES
         ITEM: 51328
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(12.261)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(122.61)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{12,261}, objFloatUtils.fStrToFloat('12,261')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000350;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302226" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418934";
    DOCUMENTO: 000000302226
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418934
       ESTADO: ES
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.4285)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(49.45)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,4285}, objFloatUtils.fStrToFloat('6,4285')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000351;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302228" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "63848" AND DET_CODCLI = "00418810";
    DOCUMENTO: 000000302228
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418810
       ESTADO: MG
         ITEM: 63848
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(41.16)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(686)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{41,16}, objFloatUtils.fStrToFloat('41,16')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000352;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302230" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65116" AND DET_CODCLI = "00418963";
    DOCUMENTO: 000000302230
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418963
       ESTADO: RS
         ITEM: 65116
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.65)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(155)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,65}, objFloatUtils.fStrToFloat('4,65')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000353;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302231" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58945" AND DET_CODCLI = "00418940";
    DOCUMENTO: 000000302231
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418940
       ESTADO: MG
         ITEM: 58945
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(11.5584)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(240.8)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{11,5584}, objFloatUtils.fStrToFloat('11,5584')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000354;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302233" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65772" AND DET_CODCLI = "00418951";
    DOCUMENTO: 000000302233
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418951
       ESTADO: RS
         ITEM: 65772
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.1803)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(149.59)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,1803}, objFloatUtils.fStrToFloat('7,1803')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000355;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302233" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "65638" AND DET_CODCLI = "00418951";
    DOCUMENTO: 000000302233
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418951
       ESTADO: RS
         ITEM: 65638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(43.9544)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(313.96)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{43,9544}, objFloatUtils.fStrToFloat('43,9544')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000356;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302234" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "60126" AND DET_CODCLI = "00418923";
    DOCUMENTO: 000000302234
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418923
       ESTADO: RJ
         ITEM: 60126
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(7.308)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(52.2)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{7,308}, objFloatUtils.fStrToFloat('7,308')) And
            CompararValores(ReturnValue.BaseFCP{52,2}, objFloatUtils.fStrToFloat('52,2')) And
            CompararValores(ReturnValue.ValorFCP{1,04}, objFloatUtils.fStrToFloat('1,04')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000357;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302234" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "50212" AND DET_CODCLI = "00418923";
    DOCUMENTO: 000000302234
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418923
       ESTADO: RJ
         ITEM: 50212
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.28)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(102)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,28}, objFloatUtils.fStrToFloat('14,28')) And
            CompararValores(ReturnValue.BaseFCP{102}, objFloatUtils.fStrToFloat('102')) And
            CompararValores(ReturnValue.ValorFCP{2,04}, objFloatUtils.fStrToFloat('2,04')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000358;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302238" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418971";
    DOCUMENTO: 000000302238
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418971
       ESTADO: RJ
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.2902)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(44.93)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,2902}, objFloatUtils.fStrToFloat('6,2902')) And
            CompararValores(ReturnValue.BaseFCP{44,93}, objFloatUtils.fStrToFloat('44,93')) And
            CompararValores(ReturnValue.ValorFCP{0,9}, objFloatUtils.fStrToFloat('0,9')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000359;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302238" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69649" AND DET_CODCLI = "00418971";
    DOCUMENTO: 000000302238
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418971
       ESTADO: RJ
         ITEM: 69649
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(21.0952)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(150.68)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{21,0952}, objFloatUtils.fStrToFloat('21,0952')) And
            CompararValores(ReturnValue.BaseFCP{150,68}, objFloatUtils.fStrToFloat('150,68')) And
            CompararValores(ReturnValue.ValorFCP{3,01}, objFloatUtils.fStrToFloat('3,01')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000360;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302239" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68293" AND DET_CODCLI = "00418939";
    DOCUMENTO: 000000302239
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418939
       ESTADO: BA
         ITEM: 68293
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(0.0999999999999996)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(0.1281)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(128.14)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{0,0999999999999996}, objFloatUtils.fStrToFloat('0,0999999999999996')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{0,1281}, objFloatUtils.fStrToFloat('0,1281')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000361;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302241" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64965" AND DET_CODCLI = "00418944";
    DOCUMENTO: 000000302241
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418944
       ESTADO: RJ
         ITEM: 64965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(3)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(18.7503)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(625.01)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{3}, objFloatUtils.fStrToFloat('3')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{18,7503}, objFloatUtils.fStrToFloat('18,7503')) And
            CompararValores(ReturnValue.BaseFCP{625,01}, objFloatUtils.fStrToFloat('625,01')) And
            CompararValores(ReturnValue.ValorFCP{12,5}, objFloatUtils.fStrToFloat('12,5')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000362;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302245" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58828" AND DET_CODCLI = "00418933";
    DOCUMENTO: 000000302245
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418933
       ESTADO: BA
         ITEM: 58828
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.4236)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(124.88)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,4236}, objFloatUtils.fStrToFloat('1,4236')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000363;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302248" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "68715" AND DET_CODCLI = "00418957";
    DOCUMENTO: 000000302248
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418957
       ESTADO: ES
         ITEM: 68715
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(25.0887)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(192.99)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{25,0887}, objFloatUtils.fStrToFloat('25,0887')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000364;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302252" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "64170" AND DET_CODCLI = "00170579";
    DOCUMENTO: 000000302252
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00170579
       ESTADO: MG
         ITEM: 64170
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.3532)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(45.38)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,3532}, objFloatUtils.fStrToFloat('6,3532')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000365;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302258" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58685" AND DET_CODCLI = "00418945";
    DOCUMENTO: 000000302258
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418945
       ESTADO: PB
         ITEM: 58685
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.6144)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(32.96)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,6144}, objFloatUtils.fStrToFloat('4,6144')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000366;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302259" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70252" AND DET_CODCLI = "00399724";
    DOCUMENTO: 000000302259
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00399724
       ESTADO: GO
         ITEM: 70252
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(8.3779)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(734.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{8,3779}, objFloatUtils.fStrToFloat('8,3779')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000367;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302259" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00399724";
    DOCUMENTO: 000000302259
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00399724
       ESTADO: GO
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(13)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.5)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(50)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,5}, objFloatUtils.fStrToFloat('6,5')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000368;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302262" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00418402";
    DOCUMENTO: 000000302262
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418402
       ESTADO: SE
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(14.84)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(106)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{14,84}, objFloatUtils.fStrToFloat('14,84')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000369;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302264" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69452" AND DET_CODCLI = "00418743";
    DOCUMENTO: 000000302264
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418743
       ESTADO: MS
         ITEM: 69452
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.444)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(64.44)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,444}, objFloatUtils.fStrToFloat('6,444')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000370;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302264" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69454" AND DET_CODCLI = "00418743";
    DOCUMENTO: 000000302264
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418743
       ESTADO: MS
         ITEM: 69454
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(16.989)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(169.89)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{16,989}, objFloatUtils.fStrToFloat('16,989')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000371;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302266" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69452" AND DET_CODCLI = "00418743";
    DOCUMENTO: 000000302266
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418743
       ESTADO: MS
         ITEM: 69452
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(25.776)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(257.76)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{25,776}, objFloatUtils.fStrToFloat('25,776')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000372;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302266" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69454" AND DET_CODCLI = "00418743";
    DOCUMENTO: 000000302266
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418743
       ESTADO: MS
         ITEM: 69454
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(67.956)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(679.56)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{67,956}, objFloatUtils.fStrToFloat('67,956')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000373;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302269" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70761" AND DET_CODCLI = "00418814";
    DOCUMENTO: 000000302269
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418814
       ESTADO: GO
         ITEM: 70761
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.8489)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(249.9)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,8489}, objFloatUtils.fStrToFloat('2,8489')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000374;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302273" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "61670" AND DET_CODCLI = "00418883";
    DOCUMENTO: 000000302273
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418883
       ESTADO: MA
         ITEM: 61670
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.4088)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(299.02)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,4088}, objFloatUtils.fStrToFloat('3,4088')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000375;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302274" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00419038";
    DOCUMENTO: 000000302274
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419038
       ESTADO: RN
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.937)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(49.55)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,937}, objFloatUtils.fStrToFloat('6,937')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000376;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302274" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00419038";
    DOCUMENTO: 000000302274
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419038
       ESTADO: RN
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(15.3104)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(109.36)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{15,3104}, objFloatUtils.fStrToFloat('15,3104')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000377;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302277" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00419045";
    DOCUMENTO: 000000302277
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419045
       ESTADO: PE
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(5.978)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(42.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{5,978}, objFloatUtils.fStrToFloat('5,978')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000378;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302278" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00419031";
    DOCUMENTO: 000000302278
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419031
       ESTADO: RJ
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(26.796)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(191.4)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{26,796}, objFloatUtils.fStrToFloat('26,796')) And
            CompararValores(ReturnValue.BaseFCP{191,4}, objFloatUtils.fStrToFloat('191,4')) And
            CompararValores(ReturnValue.ValorFCP{3,83}, objFloatUtils.fStrToFloat('3,83')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000379;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302278" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69795" AND DET_CODCLI = "00419031";
    DOCUMENTO: 000000302278
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419031
       ESTADO: RJ
         ITEM: 69795
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(2)
      .AliquotaDifalDoItem(14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(59.136)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(422.4)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{59,136}, objFloatUtils.fStrToFloat('59,136')) And
            CompararValores(ReturnValue.BaseFCP{422,4}, objFloatUtils.fStrToFloat('422,4')) And
            CompararValores(ReturnValue.ValorFCP{8,45}, objFloatUtils.fStrToFloat('8,45')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000380;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302282" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "40264" AND DET_CODCLI = "00419039";
    DOCUMENTO: 000000302282
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419039
       ESTADO: MG
         ITEM: 40264
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(6.6828)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(111.38)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{6,6828}, objFloatUtils.fStrToFloat('6,6828')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000381;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302282" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "44460" AND DET_CODCLI = "00419039";
    DOCUMENTO: 000000302282
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419039
       ESTADO: MG
         ITEM: 44460
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.8342)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(30.57)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,8342}, objFloatUtils.fStrToFloat('1,8342')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000382;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302282" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "31142" AND DET_CODCLI = "00419039";
    DOCUMENTO: 000000302282
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419039
       ESTADO: MG
         ITEM: 31142
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.212)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(70.2)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,212}, objFloatUtils.fStrToFloat('4,212')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000383;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302282" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "36210" AND DET_CODCLI = "00419039";
    DOCUMENTO: 000000302282
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419039
       ESTADO: MG
         ITEM: 36210
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(6)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(3.99)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(66.5)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{3,99}, objFloatUtils.fStrToFloat('3,99')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000384;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302283" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "59575" AND DET_CODCLI = "00393003";
    DOCUMENTO: 000000302283
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00393003
       ESTADO: MG
         ITEM: 59575
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(4.8)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(48.5136)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(1010.7)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{4,8}, objFloatUtils.fStrToFloat('4,8')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{48,5136}, objFloatUtils.fStrToFloat('48,5136')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000385;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302285" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "57565" AND DET_CODCLI = "00418900";
    DOCUMENTO: 000000302285
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418900
       ESTADO: GO
         ITEM: 57565
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(1.14)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(1.1033)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(96.78)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{1,14}, objFloatUtils.fStrToFloat('1,14')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{1,1033}, objFloatUtils.fStrToFloat('1,1033')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000386;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302285" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43867" AND DET_CODCLI = "00418900";
    DOCUMENTO: 000000302285
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418900
       ESTADO: GO
         ITEM: 43867
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(2.322)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(23.22)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{2,322}, objFloatUtils.fStrToFloat('2,322')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.DifalFCP_DUPLORMAQUINAS_000387;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302286" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "32170" AND DET_CODCLI = "00419023";
    DOCUMENTO: 000000302286
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00419023
       ESTADO: SC
         ITEM: 32170
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifalFcp;
  AParametros: IParametrosCalculoDifalFcp;
Begin

  AParametros :=
    TParametrosCalculoDifalFcp.New()
      .AliquotaFCPDoItem(0)
      .AliquotaDifalDoItem(5)
      .SimplesNacional(False)
      .EnviarIcmsDifalDoRemetenteNaPartilha(False)
      .EnviarIcmsDifalDoDestinoNaPartilha(True)
      .IcmsDeOrigem(0)
      .IcmsDeDestino(4.2525)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .BaseDestino(85.05)
      .ZerarFCP(False);

  ReturnValue := TCalculoImpostosDifalFCP.New.CalcularValorDifalFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.AliquotaDifalDoItem{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.IcmsDeOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.IcmsDeDestino{4,2525}, objFloatUtils.fStrToFloat('4,2525')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestDUPLORMAQUINAS.Suite);
end.

