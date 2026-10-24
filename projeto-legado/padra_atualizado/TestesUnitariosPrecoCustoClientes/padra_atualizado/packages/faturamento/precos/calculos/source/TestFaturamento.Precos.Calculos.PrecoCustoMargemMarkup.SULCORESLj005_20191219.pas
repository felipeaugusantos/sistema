unit TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SULCORESLj005_20191219;

{--------------------------------------------------------------------------
                    RESUMO PRECOCUSTO\PRECOCUSTOMARGEMMARKUP                 
--------------------------------------------------------------------------
Empresa            : 005 - SUL CORES-GSM DIST. TINTAS LTDA 005 SCS
Período Selecionado: 19/12/2019 até 19/12/2019
Data do Processo   : 20/12/2019 
Hora Inicio        : 15:34:15
Hora Fim           : 15:34:21
Tempo Total        : 00:00:05
                                           
Total Registros    : 659
Total Processados  : 659
Total de Acertos   : 188
Total de Erros     : 88
Total Ignorados    : 0
Total Duplicados   : 383
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Precos.Calculos.PrecoCusto,
Faturamento.Precos.Tipos.PrecoCusto,
Faturamento.Precos.Interfaces.PrecoCusto;

type
TestSULCORESGSMD = class(TTestCase)
strict private
private





published

Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000001;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000002;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000003;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000004;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000005;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000006;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000007;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000008;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000009;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000010;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000011;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000012;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000013;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000014;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000015;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000016;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000017;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000018;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000019;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000020;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000021;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000022;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000023;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000024;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000025;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000026;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000027;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000028;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000029;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000030;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000031;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000032;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000033;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000034;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000035;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000036;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000037;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000038;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000039;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000040;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000041;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000042;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000043;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000044;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000045;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000046;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000047;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000048;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000049;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000050;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000051;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000052;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000053;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000054;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000055;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000056;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000057;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000058;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000059;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000060;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000061;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000062;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000063;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000064;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000065;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000066;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000067;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000068;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000069;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000070;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000071;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000072;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000073;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000074;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000075;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000076;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000077;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000078;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000079;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000080;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000081;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000082;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000083;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000084;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000085;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000086;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000087;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000088;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000089;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000090;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000091;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000092;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000093;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000094;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000095;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000096;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000097;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000098;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000099;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000100;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000101;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000102;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000103;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000104;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000105;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000106;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000107;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000108;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000109;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000110;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000111;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000112;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000113;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000114;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000115;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000116;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000117;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000118;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000119;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000120;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000121;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000122;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000123;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000124;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000125;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000126;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000127;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000128;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000129;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000130;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000131;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000132;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000133;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000134;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000135;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000136;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000137;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000138;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000139;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000140;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000141;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000142;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000143;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000144;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000145;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000146;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000147;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000148;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000149;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000150;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000151;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000152;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000153;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000154;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000155;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000156;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000157;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000158;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000159;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000160;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000161;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000162;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000163;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000164;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000165;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000166;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000167;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000168;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000169;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000170;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000171;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000172;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000173;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000174;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000175;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000176;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000177;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000178;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000179;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000180;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000181;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000182;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000183;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000184;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000185;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000186;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000187;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000188;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestSULCORESGSMD.SetUp;
begin
end;

procedure TestSULCORESGSMD.TearDown;
begin
end;

Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000564138" AND DET_ESPDOC = "ML" AND DET_CODEMP = "005" AND DET_CODITE = "08718" AND DET_CODCLI = "00060614";
    DOCUMENTO: 000000564138
      ESPECIE: ML
      EMPRESA: 005
      CLIENTE: 00060614
       ESTADO: RS
         ITEM: 08718
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: SUV
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoMargemMarkup;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoMargemMarkup.New()
      .PrecoDeVenda(0)
      .Margem(25)
      .MargemMarkup('1');

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058079" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "02890" AND DET_CODCLI = "00060614";
    DOCUMENTO: 000000058079
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00060614
       ESTADO: RS
         ITEM: 02890
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(97.04)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{81,23}, objFloatUtils.fStrToFloat('81,23')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058079" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04242" AND DET_CODCLI = "00060614";
    DOCUMENTO: 000000058079
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00060614
       ESTADO: RS
         ITEM: 04242
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(44.35)
      .Desconto01(20)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{31,48}, objFloatUtils.fStrToFloat('31,48')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108771" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09419" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108771
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 09419
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(10.56)
      .Desconto01(47)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,37}, objFloatUtils.fStrToFloat('5,37')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108771" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03751" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108771
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03751
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.3)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,57}, objFloatUtils.fStrToFloat('3,57')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108771" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10476" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108771
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10476
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,4}, objFloatUtils.fStrToFloat('3,4')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108772" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05239" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108772
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05239
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(107.54)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{95,61}, objFloatUtils.fStrToFloat('95,61')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108773" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03978" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108773
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03978
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(0.87)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{0,75}, objFloatUtils.fStrToFloat('0,75')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108774" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09237" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108774
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 09237
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(66.24)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(11.86)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{61,27}, objFloatUtils.fStrToFloat('61,27')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108774" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09249" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108774
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 09249
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(69.55)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(11.86)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{64,33}, objFloatUtils.fStrToFloat('64,33')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108775" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03237" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108775
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03237
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 500
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(8.86)
      .Desconto01(42.99)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,36}, objFloatUtils.fStrToFloat('5,36')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108775" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00801" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108775
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00801
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.73)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(25)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,84}, objFloatUtils.fStrToFloat('1,84')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108775" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04010" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108775
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04010
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.55)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,39}, objFloatUtils.fStrToFloat('1,39')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108775" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05250" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108775
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05250
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(20.68)
      .Desconto01(42.99)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(3)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{15,21}, objFloatUtils.fStrToFloat('15,21')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058080" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "03519" AND DET_CODCLI = "00026379";
    DOCUMENTO: 000000058080
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00026379
       ESTADO: RS
         ITEM: 03519
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(78.31)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{64,75}, objFloatUtils.fStrToFloat('64,75')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058080" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04027" AND DET_CODCLI = "00026379";
    DOCUMENTO: 000000058080
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00026379
       ESTADO: RS
         ITEM: 04027
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.4)
      .Desconto01(50)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(35)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,48}, objFloatUtils.fStrToFloat('2,48')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058080" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04030" AND DET_CODCLI = "00026379";
    DOCUMENTO: 000000058080
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00026379
       ESTADO: RS
         ITEM: 04030
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.87)
      .Desconto01(50)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(45)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,25}, objFloatUtils.fStrToFloat('2,25')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058081" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07700" AND DET_CODCLI = "50002477";
    DOCUMENTO: 000000058081
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50002477
       ESTADO: RS
         ITEM: 07700
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(343.44)
      .Desconto01(50)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{228,84}, objFloatUtils.fStrToFloat('228,84')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058081" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05839" AND DET_CODCLI = "50002477";
    DOCUMENTO: 000000058081
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50002477
       ESTADO: RS
         ITEM: 05839
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(55.55)
      .Desconto01(55)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{26,95}, objFloatUtils.fStrToFloat('26,95')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108776" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10289" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108776
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10289
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(12)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(15)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{17,34}, objFloatUtils.fStrToFloat('17,34')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108777" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00079" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108777
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00079
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(20)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{24,12}, objFloatUtils.fStrToFloat('24,12')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108778" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01018" AND DET_CODCLI = "00044368";
    DOCUMENTO: 000000108778
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00044368
       ESTADO: RS
         ITEM: 01018
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(3)
      .SubstituicaoTributaria(20)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,68}, objFloatUtils.fStrToFloat('2,68')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108778" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03980" AND DET_CODCLI = "00044368";
    DOCUMENTO: 000000108778
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00044368
       ESTADO: RS
         ITEM: 03980
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.11)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{0,99}, objFloatUtils.fStrToFloat('0,99')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108778" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04034" AND DET_CODCLI = "00044368";
    DOCUMENTO: 000000108778
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00044368
       ESTADO: RS
         ITEM: 04034
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.34)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,71}, objFloatUtils.fStrToFloat('1,71')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108778" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00820" AND DET_CODCLI = "00044368";
    DOCUMENTO: 000000108778
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00044368
       ESTADO: RS
         ITEM: 00820
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.1)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,59}, objFloatUtils.fStrToFloat('1,59')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058084" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "06280" AND DET_CODCLI = "00052924";
    DOCUMENTO: 000000058084
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00052924
       ESTADO: RS
         ITEM: 06280
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(51.42)
      .Desconto01(42.99)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{31,12}, objFloatUtils.fStrToFloat('31,12')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058084" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05838" AND DET_CODCLI = "00052924";
    DOCUMENTO: 000000058084
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00052924
       ESTADO: RS
         ITEM: 05838
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(189.42)
      .Desconto01(55)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{91,89}, objFloatUtils.fStrToFloat('91,89')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058085" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "08126" AND DET_CODCLI = "50001872";
    DOCUMENTO: 000000058085
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50001872
       ESTADO: RS
         ITEM: 08126
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(16.56)
      .Desconto01(26)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{16,33}, objFloatUtils.fStrToFloat('16,33')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058086" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05417" AND DET_CODCLI = "00029917";
    DOCUMENTO: 000000058086
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00029917
       ESTADO: RS
         ITEM: 05417
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(11.74)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{10,22}, objFloatUtils.fStrToFloat('10,22')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058086" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "03509" AND DET_CODCLI = "00029917";
    DOCUMENTO: 000000058086
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00029917
       ESTADO: RS
         ITEM: 03509
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(74.19)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{61,34}, objFloatUtils.fStrToFloat('61,34')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108779" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00084" AND DET_CODCLI = "50004905";
    DOCUMENTO: 000000108779
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004905
       ESTADO: RS
         ITEM: 00084
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(30)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(15)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{43,36}, objFloatUtils.fStrToFloat('43,36')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058087" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05422" AND DET_CODCLI = "50004987";
    DOCUMENTO: 000000058087
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004987
       ESTADO: RS
         ITEM: 05422
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(202.09)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{167,1}, objFloatUtils.fStrToFloat('167,1')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108780" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07354" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108780
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07354
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(221.39)
      .Desconto01(26.5)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{181,62}, objFloatUtils.fStrToFloat('181,62')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108780" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04237" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108780
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04237
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(13.82)
      .Desconto01(20)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,81}, objFloatUtils.fStrToFloat('9,81')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108780" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "08298" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108780
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 08298
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.88)
      .Desconto01(15)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,66}, objFloatUtils.fStrToFloat('9,66')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108781" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03642" AND DET_CODCLI = "50002359";
    DOCUMENTO: 000000108781
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50002359
       ESTADO: RS
         ITEM: 03642
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(76.5)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{68,01}, objFloatUtils.fStrToFloat('68,01')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108782" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05180" AND DET_CODCLI = "50004987";
    DOCUMENTO: 000000108782
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004987
       ESTADO: RS
         ITEM: 05180
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(189.72)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{156,87}, objFloatUtils.fStrToFloat('156,87')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108783" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03679" AND DET_CODCLI = "00027953";
    DOCUMENTO: 000000108783
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00027953
       ESTADO: RS
         ITEM: 03679
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(8.12)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(8)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(9.6)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,07}, objFloatUtils.fStrToFloat('7,07')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108783" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07565" AND DET_CODCLI = "00027953";
    DOCUMENTO: 000000108783
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00027953
       ESTADO: RS
         ITEM: 07565
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(15)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{18,77}, objFloatUtils.fStrToFloat('18,77')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108784" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01791" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108784
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 01791
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.32)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(4)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,28}, objFloatUtils.fStrToFloat('1,28')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108784" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06253" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108784
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 06253
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(11.16)
      .Desconto01(55)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,3}, objFloatUtils.fStrToFloat('5,3')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108785" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04848" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108785
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04848
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(206.96)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{173,25}, objFloatUtils.fStrToFloat('173,25')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108786" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06297" AND DET_CODCLI = "50002262";
    DOCUMENTO: 000000108786
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50002262
       ESTADO: RS
         ITEM: 06297
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(29.15)
      .Desconto01(40)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{23,31}, objFloatUtils.fStrToFloat('23,31')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108786" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03974" AND DET_CODCLI = "50002262";
    DOCUMENTO: 000000108786
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50002262
       ESTADO: RS
         ITEM: 03974
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(0.83)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{0,72}, objFloatUtils.fStrToFloat('0,72')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108787" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "02847" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108787
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 02847
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(30)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{25,78}, objFloatUtils.fStrToFloat('25,78')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108787" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05132" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108787
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05132
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.65)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,1}, objFloatUtils.fStrToFloat('7,1')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108788" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05430" AND DET_CODCLI = "50002246";
    DOCUMENTO: 000000108788
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50002246
       ESTADO: RS
         ITEM: 05430
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(85.19)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{70,44}, objFloatUtils.fStrToFloat('70,44')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058088" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04649" AND DET_CODCLI = "00035524";
    DOCUMENTO: 000000058088
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00035524
       ESTADO: RS
         ITEM: 04649
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(12.7)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{10,52}, objFloatUtils.fStrToFloat('10,52')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058088" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "09706" AND DET_CODCLI = "00035524";
    DOCUMENTO: 000000058088
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00035524
       ESTADO: RS
         ITEM: 09706
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.14)
      .Desconto01(20)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,57}, objFloatUtils.fStrToFloat('6,57')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058088" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04849" AND DET_CODCLI = "00035524";
    DOCUMENTO: 000000058088
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00035524
       ESTADO: RS
         ITEM: 04849
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(54.07)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{46,47}, objFloatUtils.fStrToFloat('46,47')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058088" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "00800" AND DET_CODCLI = "00035524";
    DOCUMENTO: 000000058088
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00035524
       ESTADO: RS
         ITEM: 00800
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(7)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(15)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,83}, objFloatUtils.fStrToFloat('2,83')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058088" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04862" AND DET_CODCLI = "00035524";
    DOCUMENTO: 000000058088
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00035524
       ESTADO: RS
         ITEM: 04862
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(30.63)
      .Desconto01(32)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{24,95}, objFloatUtils.fStrToFloat('24,95')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108790" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05750" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108790
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05750
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(40)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,75}, objFloatUtils.fStrToFloat('4,75')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108791" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03983" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108791
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03983
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.09)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,27}, objFloatUtils.fStrToFloat('1,27')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108791" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00817" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108791
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00817
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.22)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,16}, objFloatUtils.fStrToFloat('2,16')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108792" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00434" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108792
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00434
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(50)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{60,3}, objFloatUtils.fStrToFloat('60,3')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108792" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04660" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108792
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04660
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(15.42)
      .Desconto01(20)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{14,19}, objFloatUtils.fStrToFloat('14,19')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108794" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05681" AND DET_CODCLI = "00065894";
    DOCUMENTO: 000000108794
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00065894
       ESTADO: RS
         ITEM: 05681
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.42)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,62}, objFloatUtils.fStrToFloat('2,62')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "09655" AND DET_CODCLI = "50004201";
    DOCUMENTO: 000000058089
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004201
       ESTADO: RS
         ITEM: 09655
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(11)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{11,2}, objFloatUtils.fStrToFloat('11,2')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058089" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "09952" AND DET_CODCLI = "50004201";
    DOCUMENTO: 000000058089
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004201
       ESTADO: RS
         ITEM: 09952
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.9)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,66}, objFloatUtils.fStrToFloat('7,66')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108795" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10059" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108795
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10059
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.99)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,83}, objFloatUtils.fStrToFloat('1,83')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108795" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10050" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108795
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10050
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.04)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,8}, objFloatUtils.fStrToFloat('2,8')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108797" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00868" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108797
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00868
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(5.56)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.97)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,83}, objFloatUtils.fStrToFloat('2,83')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108797" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00792" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108797
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00792
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(11.31)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{12,19}, objFloatUtils.fStrToFloat('12,19')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108798" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03354" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108798
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03354
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.24)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(25)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,6}, objFloatUtils.fStrToFloat('1,6')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108799" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "02865" AND DET_CODCLI = "00035738";
    DOCUMENTO: 000000108799
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00035738
       ESTADO: RS
         ITEM: 02865
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(57.33)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{47,99}, objFloatUtils.fStrToFloat('47,99')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058090" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05449" AND DET_CODCLI = "00058340";
    DOCUMENTO: 000000058090
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00058340
       ESTADO: RS
         ITEM: 05449
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.67)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,08}, objFloatUtils.fStrToFloat('9,08')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108800" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06984" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108800
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 06984
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(40)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{48,37}, objFloatUtils.fStrToFloat('48,37')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10176" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10176
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(49.84)
      .Desconto01(45)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{29,1}, objFloatUtils.fStrToFloat('29,1')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03582" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03582
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(20.86)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(11.86)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{19,81}, objFloatUtils.fStrToFloat('19,81')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07533" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07533
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(13.96)
      .Desconto01(20)
      .Desconto02(5)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{12,2}, objFloatUtils.fStrToFloat('12,2')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07137" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07137
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(17.09)
      .Desconto01(20)
      .Desconto02(15)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{13,36}, objFloatUtils.fStrToFloat('13,36')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07532" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07532
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.1)
      .Desconto01(20)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{8,37}, objFloatUtils.fStrToFloat('8,37')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04878" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04878
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(17.32)
      .Desconto01(45.37)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{10,04}, objFloatUtils.fStrToFloat('10,04')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05104" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05104
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.67)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,04}, objFloatUtils.fStrToFloat('3,04')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108801" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05103" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108801
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05103
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.51)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,73}, objFloatUtils.fStrToFloat('3,73')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108802" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01722" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108802
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 01722
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.7)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,55}, objFloatUtils.fStrToFloat('7,55')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058091" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05418" AND DET_CODCLI = "50002341";
    DOCUMENTO: 000000058091
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50002341
       ESTADO: RS
         ITEM: 05418
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(55.86)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{48,65}, objFloatUtils.fStrToFloat('48,65')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058091" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "06855" AND DET_CODCLI = "50002341";
    DOCUMENTO: 000000058091
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50002341
       ESTADO: RS
         ITEM: 06855
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(74.67)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(10.44)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{64,94}, objFloatUtils.fStrToFloat('64,94')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108804" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01841" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108804
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 01841
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(33)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(15.05)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{42,26}, objFloatUtils.fStrToFloat('42,26')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108806" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07701" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108806
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07701
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(76.95)
      .Desconto01(45)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{56,4}, objFloatUtils.fStrToFloat('56,4')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108808" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09950" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108808
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 09950
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(35.48)
      .Desconto01(45)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{25,65}, objFloatUtils.fStrToFloat('25,65')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108809" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03275" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108809
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03275
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.71)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(15)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(6.25)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,7}, objFloatUtils.fStrToFloat('2,7')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108809" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03753" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108809
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03753
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6.6)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,14}, objFloatUtils.fStrToFloat('7,14')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058092" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07692" AND DET_CODCLI = "00059155";
    DOCUMENTO: 000000058092
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00059155
       ESTADO: RS
         ITEM: 07692
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(95.2)
      .Desconto01(50)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{63,43}, objFloatUtils.fStrToFloat('63,43')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108813" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04822" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108813
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04822
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(13.74)
      .Desconto01(26)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{13,55}, objFloatUtils.fStrToFloat('13,55')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108814" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10471" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108814
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10471
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.55)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,41}, objFloatUtils.fStrToFloat('4,41')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108814" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10455" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108814
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10455
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.66)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,58}, objFloatUtils.fStrToFloat('2,58')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108815" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05741" AND DET_CODCLI = "50002535";
    DOCUMENTO: 000000108815
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50002535
       ESTADO: RS
         ITEM: 05741
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.79)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,77}, objFloatUtils.fStrToFloat('6,77')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108816" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "08325" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108816
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 08325
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(42)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{52,16}, objFloatUtils.fStrToFloat('52,16')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108818" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10158" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108818
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10158
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(0.8)
      .Desconto01(10)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(7.58)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{0,89}, objFloatUtils.fStrToFloat('0,89')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108818" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04236" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108818
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04236
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(12.56)
      .Desconto01(20)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,63}, objFloatUtils.fStrToFloat('9,63')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108820" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10468" AND DET_CODCLI = "00014671";
    DOCUMENTO: 000000108820
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00014671
       ESTADO: RS
         ITEM: 10468
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(5.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,33}, objFloatUtils.fStrToFloat('5,33')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108820" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10457" AND DET_CODCLI = "00014671";
    DOCUMENTO: 000000108820
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00014671
       ESTADO: RS
         ITEM: 10457
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.48)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,35}, objFloatUtils.fStrToFloat('4,35')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058095" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04907" AND DET_CODCLI = "00044860";
    DOCUMENTO: 000000058095
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00044860
       ESTADO: RS
         ITEM: 04907
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(71.06)
      .Desconto01(55)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{40,13}, objFloatUtils.fStrToFloat('40,13')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058096" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "02352" AND DET_CODCLI = "50001267";
    DOCUMENTO: 000000058096
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50001267
       ESTADO: RS
         ITEM: 02352
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(61.59)
      .Desconto01(45)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{44,53}, objFloatUtils.fStrToFloat('44,53')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108824" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09232" AND DET_CODCLI = "00021600";
    DOCUMENTO: 000000108824
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00021600
       ESTADO: RS
         ITEM: 09232
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(20.06)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(11.86)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{19,05}, objFloatUtils.fStrToFloat('19,05')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108825" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04929" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108825
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04929
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(16.48)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{14,65}, objFloatUtils.fStrToFloat('14,65')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108825" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05130" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108825
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05130
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6.31)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,64}, objFloatUtils.fStrToFloat('4,64')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108826" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03502" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108826
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03502
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(5.98)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(11.86)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,68}, objFloatUtils.fStrToFloat('5,68')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108827" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "02789" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108827
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 02789
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(85.17)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{71,3}, objFloatUtils.fStrToFloat('71,3')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108827" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10485" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108827
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10485
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.7)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(8.06)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,83}, objFloatUtils.fStrToFloat('4,83')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108827" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10465" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108827
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10465
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(10)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,7}, objFloatUtils.fStrToFloat('9,7')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108827" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "02188" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108827
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 02188
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.64)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,01}, objFloatUtils.fStrToFloat('3,01')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058097" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "11021" AND DET_CODCLI = "50004988";
    DOCUMENTO: 000000058097
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004988
       ESTADO: RS
         ITEM: 11021
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(296.15)
      .Desconto01(30)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{231,38}, objFloatUtils.fStrToFloat('231,38')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058097" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07089" AND DET_CODCLI = "50004988";
    DOCUMENTO: 000000058097
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004988
       ESTADO: RS
         ITEM: 07089
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.96)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(15)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,65}, objFloatUtils.fStrToFloat('4,65')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108828" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03447" AND DET_CODCLI = "00041797";
    DOCUMENTO: 000000108828
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00041797
       ESTADO: RS
         ITEM: 03447
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(96.69)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{79,95}, objFloatUtils.fStrToFloat('79,95')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058099" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "09740" AND DET_CODCLI = "50004989";
    DOCUMENTO: 000000058099
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004989
       ESTADO: RS
         ITEM: 09740
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(210)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{258,73}, objFloatUtils.fStrToFloat('258,73')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108831" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05425" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108831
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05425
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(16.88)
      .Desconto01(30)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{10,99}, objFloatUtils.fStrToFloat('10,99')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108831" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07531" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108831
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07531
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6.09)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,04}, objFloatUtils.fStrToFloat('5,04')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108831" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10446" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108831
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10446
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.35)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,31}, objFloatUtils.fStrToFloat('1,31')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108831" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10445" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108831
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10445
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.1)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,07}, objFloatUtils.fStrToFloat('1,07')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108832" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10714" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108832
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10714
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(78.92)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(11.86)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{73}, objFloatUtils.fStrToFloat('73')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058100" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07564" AND DET_CODCLI = "50004092";
    DOCUMENTO: 000000058100
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004092
       ESTADO: RS
         ITEM: 07564
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,51}, objFloatUtils.fStrToFloat('7,51')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058101" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05264" AND DET_CODCLI = "00028758";
    DOCUMENTO: 000000058101
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00028758
       ESTADO: RS
         ITEM: 05264
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(21.73)
      .Desconto01(42.99)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(3)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{15,98}, objFloatUtils.fStrToFloat('15,98')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108834" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09514" AND DET_CODCLI = "50000605";
    DOCUMENTO: 000000108834
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50000605
       ESTADO: RS
         ITEM: 09514
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.81)
      .Desconto01(49)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,31}, objFloatUtils.fStrToFloat('5,31')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108834" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04032" AND DET_CODCLI = "50000605";
    DOCUMENTO: 000000108834
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50000605
       ESTADO: RS
         ITEM: 04032
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.83)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(30)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,96}, objFloatUtils.fStrToFloat('1,96')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108834" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04255" AND DET_CODCLI = "50000605";
    DOCUMENTO: 000000108834
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50000605
       ESTADO: RS
         ITEM: 04255
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(10.95)
      .Desconto01(42.99)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,14}, objFloatUtils.fStrToFloat('6,14')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108834" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09421" AND DET_CODCLI = "50000605";
    DOCUMENTO: 000000108834
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50000605
       ESTADO: RS
         ITEM: 09421
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(10.49)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{10,49}, objFloatUtils.fStrToFloat('10,49')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108835" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03245" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108835
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03245
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(8)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(10)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{8,64}, objFloatUtils.fStrToFloat('8,64')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108837" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04599" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108837
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04599
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(24.85)
      .Desconto01(30)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{20,84}, objFloatUtils.fStrToFloat('20,84')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108837" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05124" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108837
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05124
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.67)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,12}, objFloatUtils.fStrToFloat('7,12')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058102" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "01994" AND DET_CODCLI = "50004912";
    DOCUMENTO: 000000058102
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004912
       ESTADO: RS
         ITEM: 01994
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(125.736)
      .Desconto01(12)
      .Desconto02(7)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{95,7}, objFloatUtils.fStrToFloat('95,7')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108839" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03678" AND DET_CODCLI = "50004912";
    DOCUMENTO: 000000108839
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004912
       ESTADO: RS
         ITEM: 03678
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.75)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(8)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(9.6)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,75}, objFloatUtils.fStrToFloat('6,75')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108839" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05003" AND DET_CODCLI = "50004912";
    DOCUMENTO: 000000108839
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004912
       ESTADO: RS
         ITEM: 05003
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(211.15)
      .Desconto01(30)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{164,97}, objFloatUtils.fStrToFloat('164,97')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058103" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05826" AND DET_CODCLI = "00025743";
    DOCUMENTO: 000000058103
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00025743
       ESTADO: RS
         ITEM: 05826
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.74)
      .Desconto01(6.8)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,32}, objFloatUtils.fStrToFloat('2,32')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058104" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05372" AND DET_CODCLI = "50004540";
    DOCUMENTO: 000000058104
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004540
       ESTADO: RS
         ITEM: 05372
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6.98)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,84}, objFloatUtils.fStrToFloat('6,84')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108844" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03417" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108844
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03417
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(30.36)
      .Desconto01(42.99)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{22,75}, objFloatUtils.fStrToFloat('22,75')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108845" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04665" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108845
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04665
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(19.52)
      .Desconto01(20)
      .Desconto02(15)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{15,26}, objFloatUtils.fStrToFloat('15,26')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108846" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07407" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108846
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07407
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(15)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(15.05)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{19,21}, objFloatUtils.fStrToFloat('19,21')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108847" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05238" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108847
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05238
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(32.57)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{29,73}, objFloatUtils.fStrToFloat('29,73')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058105" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07811" AND DET_CODCLI = "50004477";
    DOCUMENTO: 000000058105
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004477
       ESTADO: RS
         ITEM: 07811
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(377.07)
      .Desconto01(34)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{277,77}, objFloatUtils.fStrToFloat('277,77')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058105" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "03796" AND DET_CODCLI = "50004477";
    DOCUMENTO: 000000058105
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004477
       ESTADO: RS
         ITEM: 03796
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.91)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,27}, objFloatUtils.fStrToFloat('4,27')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058105" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04692" AND DET_CODCLI = "50004477";
    DOCUMENTO: 000000058105
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004477
       ESTADO: RS
         ITEM: 04692
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(100.69)
      .Desconto01(32)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{76,42}, objFloatUtils.fStrToFloat('76,42')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058105" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "10447" AND DET_CODCLI = "50004477";
    DOCUMENTO: 000000058105
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004477
       ESTADO: RS
         ITEM: 10447
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.95)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,89}, objFloatUtils.fStrToFloat('1,89')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058105" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "10448" AND DET_CODCLI = "50004477";
    DOCUMENTO: 000000058105
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004477
       ESTADO: RS
         ITEM: 10448
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,42}, objFloatUtils.fStrToFloat('2,42')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058106" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "06606" AND DET_CODCLI = "50004990";
    DOCUMENTO: 000000058106
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004990
       ESTADO: RS
         ITEM: 06606
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.91)
      .Desconto01(28)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(3.5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,14}, objFloatUtils.fStrToFloat('7,14')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058106" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "06614" AND DET_CODCLI = "50004990";
    DOCUMENTO: 000000058106
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004990
       ESTADO: RS
         ITEM: 06614
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(5.52)
      .Desconto01(28)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(3.5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,98}, objFloatUtils.fStrToFloat('4,98')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108850" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10493" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108850
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10493
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,94}, objFloatUtils.fStrToFloat('1,94')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108852" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10240" AND DET_CODCLI = "50001884";
    DOCUMENTO: 000000108852
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50001884
       ESTADO: RS
         ITEM: 10240
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(12)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{12,8}, objFloatUtils.fStrToFloat('12,8')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108852" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07688" AND DET_CODCLI = "50001884";
    DOCUMENTO: 000000108852
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50001884
       ESTADO: RS
         ITEM: 07688
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(4)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,65}, objFloatUtils.fStrToFloat('2,65')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108852" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10474" AND DET_CODCLI = "50001884";
    DOCUMENTO: 000000108852
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50001884
       ESTADO: RS
         ITEM: 10474
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.5)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,46}, objFloatUtils.fStrToFloat('1,46')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108852" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01871" AND DET_CODCLI = "50001884";
    DOCUMENTO: 000000108852
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50001884
       ESTADO: RS
         ITEM: 01871
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(25.82)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{23,57}, objFloatUtils.fStrToFloat('23,57')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108853" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01808" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108853
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 01808
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(62.28)
      .Desconto01(30)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{52,22}, objFloatUtils.fStrToFloat('52,22')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108856" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05742" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108856
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05742
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.42)
      .Desconto01(20)
      .Desconto02(27)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,23}, objFloatUtils.fStrToFloat('5,23')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108857" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10639" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108857
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10639
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(8.13)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(8.62)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,74}, objFloatUtils.fStrToFloat('9,74')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108858" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03381" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108858
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03381
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(28.03)
      .Desconto01(45)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{16,36}, objFloatUtils.fStrToFloat('16,36')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058107" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07702" AND DET_CODCLI = "50004918";
    DOCUMENTO: 000000058107
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004918
       ESTADO: RS
         ITEM: 07702
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(447.84)
      .Desconto01(50)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{298,4}, objFloatUtils.fStrToFloat('298,4')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058108" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "03173" AND DET_CODCLI = "00029875";
    DOCUMENTO: 000000058108
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00029875
       ESTADO: RS
         ITEM: 03173
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(70.86)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{64,49}, objFloatUtils.fStrToFloat('64,49')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058109" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "07782" AND DET_CODCLI = "50004979";
    DOCUMENTO: 000000058109
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004979
       ESTADO: RS
         ITEM: 07782
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(19.77)
      .Desconto01(20)
      .Desconto02(15)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{16,23}, objFloatUtils.fStrToFloat('16,23')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058109" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "08318" AND DET_CODCLI = "50004979";
    DOCUMENTO: 000000058109
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004979
       ESTADO: RS
         ITEM: 08318
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(200)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{233,86}, objFloatUtils.fStrToFloat('233,86')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058109" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "08320" AND DET_CODCLI = "50004979";
    DOCUMENTO: 000000058109
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004979
       ESTADO: RS
         ITEM: 08320
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(200)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{245,55}, objFloatUtils.fStrToFloat('245,55')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058109" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05106" AND DET_CODCLI = "50004979";
    DOCUMENTO: 000000058109
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004979
       ESTADO: RS
         ITEM: 05106
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.76)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,43}, objFloatUtils.fStrToFloat('6,43')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108859" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03628" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108859
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03628
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(23.1)
      .Desconto01(28)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{21,16}, objFloatUtils.fStrToFloat('21,16')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108861" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "07180" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108861
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 07180
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(66.6)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{55,75}, objFloatUtils.fStrToFloat('55,75')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108862" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04999" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108862
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04999
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(15)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{18,09}, objFloatUtils.fStrToFloat('18,09')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108862" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05133" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108862
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05133
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.12)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,56}, objFloatUtils.fStrToFloat('1,56')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108863" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00803" AND DET_CODCLI = "00017162";
    DOCUMENTO: 000000108863
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00017162
       ESTADO: RS
         ITEM: 00803
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.59)
      .Desconto01(54.64)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(25)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,77}, objFloatUtils.fStrToFloat('1,77')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108863" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06671" AND DET_CODCLI = "00017162";
    DOCUMENTO: 000000108863
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00017162
       ESTADO: RS
         ITEM: 06671
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(8.1)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,94}, objFloatUtils.fStrToFloat('7,94')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108864" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "04258" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108864
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 04258
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(27)
      .Desconto01(55)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{12,15}, objFloatUtils.fStrToFloat('12,15')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058110" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05127" AND DET_CODCLI = "00020681";
    DOCUMENTO: 000000058110
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00020681
       ESTADO: RS
         ITEM: 05127
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.88)
      .Desconto01(20)
      .Desconto02(20)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,86}, objFloatUtils.fStrToFloat('2,86')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108865" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "11014" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108865
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 11014
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.43)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(8.15)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{8,86}, objFloatUtils.fStrToFloat('8,86')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108866" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09420" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108866
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 09420
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(53.04)
      .Desconto01(47)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{27,55}, objFloatUtils.fStrToFloat('27,55')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108866" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "00633" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108866
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 00633
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(38)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(15.05)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{48,66}, objFloatUtils.fStrToFloat('48,66')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108867" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06983" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108867
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 06983
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(45)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{54,27}, objFloatUtils.fStrToFloat('54,27')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108868" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10484" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108868
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10484
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.7)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(8.06)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,22}, objFloatUtils.fStrToFloat('2,22')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000167;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108868" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10464" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108868
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10464
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{5,82}, objFloatUtils.fStrToFloat('5,82')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000168;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058113" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "05840" AND DET_CODCLI = "50004979";
    DOCUMENTO: 000000058113
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004979
       ESTADO: RS
         ITEM: 05840
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(72.85)
      .Desconto01(55)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{35,34}, objFloatUtils.fStrToFloat('35,34')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000169;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108870" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01869" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108870
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 01869
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(85.26)
      .Desconto01(25)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(7.52)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{75,8}, objFloatUtils.fStrToFloat('75,8')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000170;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108874" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10453" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108874
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10453
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.6)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,55}, objFloatUtils.fStrToFloat('1,55')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000171;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058114" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "09285" AND DET_CODCLI = "50001407";
    DOCUMENTO: 000000058114
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50001407
       ESTADO: RS
         ITEM: 09285
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(368.85)
      .Desconto01(38.9)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{269,95}, objFloatUtils.fStrToFloat('269,95')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000172;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108876" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10500" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108876
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 10500
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(12)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(18)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{11,64}, objFloatUtils.fStrToFloat('11,64')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000173;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108879" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "02305" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108879
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 02305
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(41.288)
      .Desconto01(12)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{33,79}, objFloatUtils.fStrToFloat('33,79')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000174;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108880" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05913" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108880
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05913
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(27.94)
      .Desconto01(40)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{22,34}, objFloatUtils.fStrToFloat('22,34')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000175;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108880" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06299" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108880
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 06299
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(28.51)
      .Desconto01(40)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{22,8}, objFloatUtils.fStrToFloat('22,8')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000176;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108880" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "09949" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108880
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 09949
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(35.19)
      .Desconto01(45)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(3.5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{25,44}, objFloatUtils.fStrToFloat('25,44')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000177;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108881" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "06568" AND DET_CODCLI = "50004991";
    DOCUMENTO: 000000108881
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004991
       ESTADO: RS
         ITEM: 06568
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(30)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(13.77)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{36,18}, objFloatUtils.fStrToFloat('36,18')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000178;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108882" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05365" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108882
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05365
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.78)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(14.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,76}, objFloatUtils.fStrToFloat('9,76')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000179;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108882" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "05129" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108882
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 05129
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.86)
      .Desconto01(20)
      .Desconto02(27)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,25}, objFloatUtils.fStrToFloat('1,25')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000180;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108884" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03971" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108884
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03971
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.03)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,53}, objFloatUtils.fStrToFloat('3,53')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000181;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108884" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03973" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108884
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03973
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.13)
      .Desconto01(6.8)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(4)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(8)
      .ValorDoFrete(0)
      .AcrescimoFinal(6)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,18}, objFloatUtils.fStrToFloat('2,18')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000182;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058116" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "02848" AND DET_CODCLI = "50004913";
    DOCUMENTO: 000000058116
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004913
       ESTADO: RS
         ITEM: 02848
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(375.34)
      .Desconto01(26.5)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{307,92}, objFloatUtils.fStrToFloat('307,92')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000183;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058117" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "04695" AND DET_CODCLI = "00020681";
    DOCUMENTO: 000000058117
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 00020681
       ESTADO: RS
         ITEM: 04695
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(26.18)
      .Desconto01(28)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(6.3)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{21,04}, objFloatUtils.fStrToFloat('21,04')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000184;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108885" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "03579" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108885
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 03579
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(8.71)
      .Desconto01(28)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(3.5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,86}, objFloatUtils.fStrToFloat('7,86')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000185;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108888" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "10350" AND DET_CODCLI = "50004746";
    DOCUMENTO: 000000108888
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004746
       ESTADO: RS
         ITEM: 10350
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(125.5)
      .Desconto01(40)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(5)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(15.38)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{100,35}, objFloatUtils.fStrToFloat('100,35')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000186;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108888" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "01074" AND DET_CODCLI = "50004746";
    DOCUMENTO: 000000108888
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 50004746
       ESTADO: RS
         ITEM: 01074
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(19.22)
      .Desconto01(35)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{12,24}, objFloatUtils.fStrToFloat('12,24')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000187;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058118" AND DET_ESPDOC = "NF" AND DET_CODEMP = "005" AND DET_CODITE = "06854" AND DET_CODCLI = "50004807";
    DOCUMENTO: 000000058118
      ESPECIE: NF
      EMPRESA: 005
      CLIENTE: 50004807
       ESTADO: RS
         ITEM: 06854
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(22.61)
      .Desconto01(23)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(5)
      .SubstituicaoTributaria(10.44)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{20,19}, objFloatUtils.fStrToFloat('20,19')));
end;


Procedure TestSULCORESGSMD.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_SULCORESGSMD_000188;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000108890" AND DET_ESPDOC = "IF" AND DET_CODEMP = "005" AND DET_CODITE = "02191" AND DET_CODCLI = "00005002";
    DOCUMENTO: 000000108890
      ESPECIE: IF
      EMPRESA: 005
      CLIENTE: 00005002
       ESTADO: RS
         ITEM: 02191
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 19/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(7.41)
      .Desconto01(20)
      .Desconto02(10)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(0)
      .PercentualFreteDeEntrada(5)
      .ValorDoFrete(0)
      .AcrescimoFinal(10)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('1')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{6,14}, objFloatUtils.fStrToFloat('6,14')));
end;




initialization
  RegisterTest(TestSULCORESGSMD.Suite);
end.

