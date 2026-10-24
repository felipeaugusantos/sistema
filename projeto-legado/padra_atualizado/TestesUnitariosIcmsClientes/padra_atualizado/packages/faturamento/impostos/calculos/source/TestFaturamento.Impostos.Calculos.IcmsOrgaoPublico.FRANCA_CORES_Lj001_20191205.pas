unit TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.FRANCA_CORES_Lj001_20191205;

{--------------------------------------------------------------------------
                    RESUMO ICMSORGAOPUBLICO                 
--------------------------------------------------------------------------
Empresa            : 001 - FRANCA CORES
Período Selecionado: 05/12/2019 até 05/12/2019
Data do Processo   : 16/12/2019 
Hora Inicio        : 15:10:37
Hora Fim           : 15:15:26
Tempo Total        : 00:04:48
                                           
Total Registros    : 283
Total Processados  : 283
Total de Acertos   : 171
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 112
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.IcmsOrgaoPublico,
Faturamento.Impostos.Tipos.IcmsOrgaoPublico,
Faturamento.Impostos.Interfaces.IcmsOrgaoPublico;

type
TestFRANCACORES = class(TTestCase)
strict private
private





published

Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000001;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000002;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000003;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000004;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000005;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000006;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000007;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000008;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000009;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000010;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000011;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000012;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000013;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000014;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000015;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000016;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000017;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000018;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000019;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000020;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000021;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000022;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000023;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000024;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000025;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000026;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000027;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000028;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000029;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000030;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000031;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000032;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000033;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000034;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000035;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000036;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000037;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000038;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000039;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000040;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000041;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000042;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000043;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000044;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000045;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000046;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000047;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000048;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000049;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000050;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000051;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000052;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000053;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000054;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000055;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000056;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000057;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000058;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000059;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000060;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000061;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000062;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000063;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000064;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000065;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000066;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000067;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000068;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000069;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000070;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000071;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000072;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000073;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000074;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000075;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000076;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000077;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000078;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000079;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000080;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000081;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000082;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000083;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000084;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000085;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000086;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000087;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000088;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000089;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000090;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000091;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000092;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000093;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000094;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000095;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000096;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000097;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000098;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000099;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000100;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000101;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000102;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000103;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000104;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000105;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000106;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000107;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000108;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000109;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000110;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000111;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000112;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000113;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000114;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000115;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000116;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000117;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000118;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000119;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000120;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000121;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000122;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000123;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000124;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000125;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000126;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000127;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000128;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000129;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000130;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000131;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000132;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000133;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000134;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000135;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000136;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000137;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000138;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000139;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000140;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000141;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000142;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000143;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000144;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000145;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000146;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000147;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000148;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000149;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000150;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000151;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000152;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000153;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000154;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000155;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000156;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000157;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000158;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000159;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000160;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000161;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000162;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000163;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000164;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000165;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000166;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000167;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000168;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000169;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000170;
Procedure REGRA_ICMSORGAOPUBLICO_FRANCACORES_000171;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestFRANCACORES.SetUp;
begin
end;

procedure TestFRANCACORES.TearDown;
begin
end;

Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009492" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06401" AND DET_CODCLI = "20008867";
    DOCUMENTO: 000000009492
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20008867
       ESTADO: SP
         ITEM: 06401
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(55)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009493" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00898" AND DET_CODCLI = "20010093";
    DOCUMENTO: 000000009493
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20010093
       ESTADO: SP
         ITEM: 00898
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(25)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009493" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01746" AND DET_CODCLI = "20010093";
    DOCUMENTO: 000000009493
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20010093
       ESTADO: SP
         ITEM: 01746
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(22)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009493" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01747" AND DET_CODCLI = "20010093";
    DOCUMENTO: 000000009493
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20010093
       ESTADO: SP
         ITEM: 01747
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(32)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009493" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00190" AND DET_CODCLI = "20010093";
    DOCUMENTO: 000000009493
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20010093
       ESTADO: SP
         ITEM: 00190
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(6.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009494" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00191" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009494
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00191
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000436" AND DET_ESPDOC = "TR" AND DET_CODEMP = "001" AND DET_CODITE = "05884" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000000436
      ESPECIE: TR
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 05884
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: TR}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('TR')
      .ValorTotalDoItem(131.95)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009495" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06084" AND DET_CODCLI = "20010093";
    DOCUMENTO: 000000009495
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20010093
       ESTADO: SP
         ITEM: 06084
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(17)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009496" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02845" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009496
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 02845
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(15.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009496" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04010" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009496
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 04010
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(5.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009496" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02799" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009496
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 02799
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(27.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009496" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06623" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009496
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 06623
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(16)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009496" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06072" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009496
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 06072
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(4.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009496" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00806" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009496
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 00806
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(28.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009497" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05987" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009497
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 05987
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(12)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009498" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06299" AND DET_CODCLI = "20005891";
    DOCUMENTO: 000000009498
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005891
       ESTADO: SP
         ITEM: 06299
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(49)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009498" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04949" AND DET_CODCLI = "20005891";
    DOCUMENTO: 000000009498
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005891
       ESTADO: SP
         ITEM: 04949
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(111)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000618" AND DET_ESPDOC = "DV" AND DET_CODEMP = "001" AND DET_CODITE = "06600" AND DET_CODCLI = "20012936";
    DOCUMENTO: 000000000618
      ESPECIE: DV
      EMPRESA: 001
      CLIENTE: 20012936
       ESTADO: SP
         ITEM: 06600
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('DV')
      .ValorTotalDoItem(64.74)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000618" AND DET_ESPDOC = "DV" AND DET_CODEMP = "001" AND DET_CODITE = "00734" AND DET_CODCLI = "20012936";
    DOCUMENTO: 000000000618
      ESPECIE: DV
      EMPRESA: 001
      CLIENTE: 20012936
       ESTADO: SP
         ITEM: 00734
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('DV')
      .ValorTotalDoItem(90)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009499" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04920" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000009499
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 04920
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(35)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009500" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04951" AND DET_CODCLI = "00000837";
    DOCUMENTO: 000000009500
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000837
       ESTADO: SP
         ITEM: 04951
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(58)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009501" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01030" AND DET_CODCLI = "00003948";
    DOCUMENTO: 000000009501
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00003948
       ESTADO: SP
         ITEM: 01030
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(28)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009502" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00629" AND DET_CODCLI = "20012414";
    DOCUMENTO: 000000009502
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012414
       ESTADO: SP
         ITEM: 00629
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(5.95)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009502" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00842" AND DET_CODCLI = "20012414";
    DOCUMENTO: 000000009502
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012414
       ESTADO: SP
         ITEM: 00842
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(13.2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009502" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "20012414";
    DOCUMENTO: 000000009502
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012414
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(14.25)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009503" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04950" AND DET_CODCLI = "20012739";
    DOCUMENTO: 000000009503
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012739
       ESTADO: SP
         ITEM: 04950
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(205)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009503" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05887" AND DET_CODCLI = "20012739";
    DOCUMENTO: 000000009503
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012739
       ESTADO: SP
         ITEM: 05887
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(78)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009503" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05678" AND DET_CODCLI = "20012739";
    DOCUMENTO: 000000009503
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012739
       ESTADO: SP
         ITEM: 05678
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(60)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009504" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "00006682";
    DOCUMENTO: 000000009504
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006682
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(22.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009505" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04948" AND DET_CODCLI = "20005230";
    DOCUMENTO: 000000009505
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005230
       ESTADO: SP
         ITEM: 04948
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(195)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009505" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "20005230";
    DOCUMENTO: 000000009505
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005230
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(21)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009505" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00842" AND DET_CODCLI = "20005230";
    DOCUMENTO: 000000009505
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005230
       ESTADO: SP
         ITEM: 00842
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(11.7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009505" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "20005230";
    DOCUMENTO: 000000009505
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005230
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(10)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009505" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00144" AND DET_CODCLI = "20005230";
    DOCUMENTO: 000000009505
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005230
       ESTADO: SP
         ITEM: 00144
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(15)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009507" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04950" AND DET_CODCLI = "00009859";
    DOCUMENTO: 000000009507
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00009859
       ESTADO: SP
         ITEM: 04950
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(208)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009507" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04949" AND DET_CODCLI = "00009859";
    DOCUMENTO: 000000009507
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00009859
       ESTADO: SP
         ITEM: 04949
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(58)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009507" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00842" AND DET_CODCLI = "00009859";
    DOCUMENTO: 000000009507
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00009859
       ESTADO: SP
         ITEM: 00842
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009507" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "00009859";
    DOCUMENTO: 000000009507
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00009859
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(14)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000619" AND DET_ESPDOC = "DV" AND DET_CODEMP = "001" AND DET_CODITE = "01710" AND DET_CODCLI = "20012739";
    DOCUMENTO: 000000000619
      ESPECIE: DV
      EMPRESA: 001
      CLIENTE: 20012739
       ESTADO: SP
         ITEM: 01710
 ITEM SERVIÇO: NÃO
         CFOP: 1202
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('DV')
      .ValorTotalDoItem(32)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002016" AND DET_ESPDOC = "ML" AND DET_CODEMP = "001" AND DET_CODITE = "02393" AND DET_CODCLI = "00004214";
    DOCUMENTO: 000000002016
      ESPECIE: ML
      EMPRESA: 001
      CLIENTE: 00004214
       ESTADO: SP
         ITEM: 02393
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(0)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001982" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02420" AND DET_CODCLI = "00004214";
    DOCUMENTO: 000000001982
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00004214
       ESTADO: SP
         ITEM: 02420
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(385)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009509" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02706" AND DET_CODCLI = "50000334";
    DOCUMENTO: 000000009509
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 50000334
       ESTADO: SP
         ITEM: 02706
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(25)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009510" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00757" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009510
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00757
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(29)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009511" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00898" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009511
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00898
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009512" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06113" AND DET_CODCLI = "20011486";
    DOCUMENTO: 000000009512
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011486
       ESTADO: SP
         ITEM: 06113
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(310)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009512" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06615" AND DET_CODCLI = "20011486";
    DOCUMENTO: 000000009512
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011486
       ESTADO: SP
         ITEM: 06615
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(52)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009513" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02885" AND DET_CODCLI = "20012289";
    DOCUMENTO: 000000009513
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012289
       ESTADO: SP
         ITEM: 02885
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(23.6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009513" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06693" AND DET_CODCLI = "20012289";
    DOCUMENTO: 000000009513
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012289
       ESTADO: SP
         ITEM: 06693
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(11)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002017" AND DET_ESPDOC = "ML" AND DET_CODEMP = "001" AND DET_CODITE = "02392" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000002017
      ESPECIE: ML
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02392
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(0)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001983" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02418" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000001983
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02418
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(32)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009515" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00755" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009515
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00755
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(45)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009515" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02893" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009515
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02893
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(22)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009515" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00181" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009515
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00181
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(3)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009516" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00185" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009516
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00185
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.38)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009516" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06620" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009516
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06620
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(13)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.62)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009517" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06099" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009517
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06099
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(24)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000620" AND DET_ESPDOC = "DV" AND DET_CODEMP = "001" AND DET_CODITE = "06096" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000000620
      ESPECIE: DV
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 06096
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('DV')
      .ValorTotalDoItem(150)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000620" AND DET_ESPDOC = "DV" AND DET_CODEMP = "001" AND DET_CODITE = "00040" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000000620
      ESPECIE: DV
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 00040
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('DV')
      .ValorTotalDoItem(25)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009518" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02660" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009518
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02660
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009520" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00629" AND DET_CODCLI = "50002619";
    DOCUMENTO: 000000009520
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 50002619
       ESTADO: SP
         ITEM: 00629
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009520" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02722" AND DET_CODCLI = "50002619";
    DOCUMENTO: 000000009520
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 50002619
       ESTADO: SP
         ITEM: 02722
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(29)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001984" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02415" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000001984
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02415
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(184)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001984" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02416" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000001984
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02416
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(445)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001984" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02420" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000001984
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02420
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(410)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001984" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02422" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000001984
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02422
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(1095)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001984" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02449" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000001984
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02449
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(285)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06531" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06531
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(32)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(1.54)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00200" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00200
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(18)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.87)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02316" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02316
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.19)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(21)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(1.01)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00629" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00629
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(1.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.09)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00898" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00898
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(7.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.36)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009522" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06451" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009522
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06451
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.24)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009523" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06295" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000009523
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 06295
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(235)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001985" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "05089" AND DET_CODCLI = "20005126";
    DOCUMENTO: 000000001985
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20005126
       ESTADO: SP
         ITEM: 05089
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(71)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001986" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02420" AND DET_CODCLI = "00007121";
    DOCUMENTO: 000000001986
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00007121
       ESTADO: SP
         ITEM: 02420
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(710)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009526" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02273" AND DET_CODCLI = "00007121";
    DOCUMENTO: 000000009526
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00007121
       ESTADO: SP
         ITEM: 02273
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(333)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009526" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00898" AND DET_CODCLI = "00007121";
    DOCUMENTO: 000000009526
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00007121
       ESTADO: SP
         ITEM: 00898
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(2.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000275" AND DET_ESPDOC = "TM" AND DET_CODEMP = "001" AND DET_CODITE = "02393" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000000275
      ESPECIE: TM
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 02393
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(0)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009528" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00785" AND DET_CODCLI = "20005891";
    DOCUMENTO: 000000009528
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005891
       ESTADO: SP
         ITEM: 00785
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(15)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009529" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06620" AND DET_CODCLI = "50001398";
    DOCUMENTO: 000000009529
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 50001398
       ESTADO: SP
         ITEM: 06620
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(13)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009529" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06088" AND DET_CODCLI = "50001398";
    DOCUMENTO: 000000009529
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 50001398
       ESTADO: SP
         ITEM: 06088
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(10)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009531" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04958" AND DET_CODCLI = "20005986";
    DOCUMENTO: 000000009531
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005986
       ESTADO: SP
         ITEM: 04958
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(405)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009532" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02643" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009532
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02643
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(10)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.17)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009532" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00870" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009532
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00870
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(2.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.04)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009532" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01202" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009532
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01202
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(10)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.17)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009532" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00630" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009532
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00630
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(0.9)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.02)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009533" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "03396" AND DET_CODCLI = "20005096";
    DOCUMENTO: 000000009533
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005096
       ESTADO: SP
         ITEM: 03396
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(7.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009534" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02445" AND DET_CODCLI = "00001688";
    DOCUMENTO: 000000009534
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00001688
       ESTADO: SP
         ITEM: 02445
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(148)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009535" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00200" AND DET_CODCLI = "20010093";
    DOCUMENTO: 000000009535
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20010093
       ESTADO: SP
         ITEM: 00200
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(30)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009536" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02273" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000009536
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02273
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(335)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001988" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "05088" AND DET_CODCLI = "20011359";
    DOCUMENTO: 000000001988
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20011359
       ESTADO: SP
         ITEM: 05088
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(198)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009537" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "20011359";
    DOCUMENTO: 000000009537
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011359
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009537" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00616" AND DET_CODCLI = "20011359";
    DOCUMENTO: 000000009537
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011359
       ESTADO: SP
         ITEM: 00616
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(3.2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009537" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00629" AND DET_CODCLI = "20011359";
    DOCUMENTO: 000000009537
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011359
       ESTADO: SP
         ITEM: 00629
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(0.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001989" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02791" AND DET_CODCLI = "20012927";
    DOCUMENTO: 000000001989
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012927
       ESTADO: SP
         ITEM: 02791
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(72)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001989" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "05089" AND DET_CODCLI = "20012927";
    DOCUMENTO: 000000001989
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012927
       ESTADO: SP
         ITEM: 05089
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(70)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009538" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04958" AND DET_CODCLI = "20012927";
    DOCUMENTO: 000000009538
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012927
       ESTADO: SP
         ITEM: 04958
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(220)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009539" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02887" AND DET_CODCLI = "00006682";
    DOCUMENTO: 000000009539
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006682
       ESTADO: SP
         ITEM: 02887
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(73)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009539" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04996" AND DET_CODCLI = "00006682";
    DOCUMENTO: 000000009539
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006682
       ESTADO: SP
         ITEM: 04996
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(120)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009539" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "00006682";
    DOCUMENTO: 000000009539
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006682
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(27)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009540" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00612" AND DET_CODCLI = "00004618";
    DOCUMENTO: 000000009540
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00004618
       ESTADO: SP
         ITEM: 00612
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(57.6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(9.6)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009542" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06607" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009542
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06607
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(53)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001991" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02419" AND DET_CODCLI = "50001510";
    DOCUMENTO: 000000001991
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 50001510
       ESTADO: SP
         ITEM: 02419
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(93)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009544" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00734" AND DET_CODCLI = "00006401";
    DOCUMENTO: 000000009544
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006401
       ESTADO: SP
         ITEM: 00734
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(98)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009544" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02722" AND DET_CODCLI = "00006401";
    DOCUMENTO: 000000009544
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006401
       ESTADO: SP
         ITEM: 02722
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(18)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009544" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00193" AND DET_CODCLI = "00006401";
    DOCUMENTO: 000000009544
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00006401
       ESTADO: SP
         ITEM: 00193
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001992" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02422" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000001992
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 02422
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 030
       IDEPRO: SHE
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(1470)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5110
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(52)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02273" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 02273
 ITEM SERVIÇO: NÃO
         CFOP: 5403
CODIGO FISCAL: 030
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(325)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5110
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(78)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06532" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 06532
 ITEM SERVIÇO: NÃO
         CFOP: 5403
CODIGO FISCAL: 030
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(162.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06411" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 06411
 ITEM SERVIÇO: NÃO
         CFOP: 5403
CODIGO FISCAL: 030
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(22.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02292" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 02292
 ITEM SERVIÇO: NÃO
         CFOP: 5403
CODIGO FISCAL: 030
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(896)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009545" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05470" AND DET_CODCLI = "40001453";
    DOCUMENTO: 000000009545
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 40001453
       ESTADO: SP
         ITEM: 05470
 ITEM SERVIÇO: NÃO
         CFOP: 5403
CODIGO FISCAL: 030
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(346)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001993" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "02419" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000001993
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 02419
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(91)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009548" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "00005491";
    DOCUMENTO: 000000009548
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00005491
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(9.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000621" AND DET_ESPDOC = "DV" AND DET_CODEMP = "001" AND DET_CODITE = "02338" AND DET_CODCLI = "20012951";
    DOCUMENTO: 000000000621
      ESPECIE: DV
      EMPRESA: 001
      CLIENTE: 20012951
       ESTADO: SP
         ITEM: 02338
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('DV')
      .ValorTotalDoItem(520)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009550" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06505" AND DET_CODCLI = "00007184";
    DOCUMENTO: 000000009550
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00007184
       ESTADO: SP
         ITEM: 06505
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(340)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009550" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06114" AND DET_CODCLI = "00007184";
    DOCUMENTO: 000000009550
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00007184
       ESTADO: SP
         ITEM: 06114
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(298)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009551" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06393" AND DET_CODCLI = "20009282";
    DOCUMENTO: 000000009551
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20009282
       ESTADO: SP
         ITEM: 06393
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(155)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009553" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009553
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(9.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001994" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "04967" AND DET_CODCLI = "20012400";
    DOCUMENTO: 000000001994
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012400
       ESTADO: SP
         ITEM: 04967
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(348.75)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009555" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06691" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009555
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06691
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(42)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009555" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02321" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009555
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02321
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(3)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009555" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "05425" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009555
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 05425
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(14)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009556" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06385" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009556
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06385
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(24)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.42)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009556" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00923" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009556
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00923
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(4.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.08)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009557" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00779" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000009557
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00779
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(20)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000001995" AND DET_ESPDOC = "PR" AND DET_CODEMP = "001" AND DET_CODITE = "05088" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000001995
      ESPECIE: PR
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 05088
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(248.02)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(46.25)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00912" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00912
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 090
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(93.45)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(17.44)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 090
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(138)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(25.73)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00842" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00842
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 090
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(45.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(8.47)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00193" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00193
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 090
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(14.58)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(2.72)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00192" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00192
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 090
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(11.34)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(2.11)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "04010" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 04010
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(19.68)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(3.67)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06531" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06531
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(33.33)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(6.22)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02791" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 02791
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(156.46)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(29.18)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02866" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 02866
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(146.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(27.3)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06607" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06607
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(75.62)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(14.1)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06615" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06615
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(152.82)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(28.5)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00898" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00898
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 090
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(5.52)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(1.03)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01574" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 01574
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(710.58)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(132.51)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00050" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00050
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(356.52)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(66.48)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00012" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 00012
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(616.74)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(115.01)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06612" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06612
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(283.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(52.92)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06471" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06471
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(774)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(144.34)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06608" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06608
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(25.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(4.81)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06608" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06608
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(77.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(14.43)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009558" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "06411" AND DET_CODCLI = "20012954";
    DOCUMENTO: 000000009558
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20012954
       ESTADO: SP
         ITEM: 06411
 ITEM SERVIÇO: NÃO
         CFOP: 5922
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(9.54)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(1.78)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009559" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "00204" AND DET_CODCLI = "20011359";
    DOCUMENTO: 000000009559
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011359
       ESTADO: SP
         ITEM: 00204
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(56)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009559" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01746" AND DET_CODCLI = "20011359";
    DOCUMENTO: 000000009559
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011359
       ESTADO: SP
         ITEM: 01746
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(17)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000498" AND DET_ESPDOC = "EP" AND DET_CODEMP = "001" AND DET_CODITE = "06096" AND DET_CODCLI = "00011623";
    DOCUMENTO: 000000000498
      ESPECIE: EP
      EMPRESA: 001
      CLIENTE: 00011623
       ESTADO: SP
         ITEM: 06096
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: EP}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EP')
      .ValorTotalDoItem(216.02)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009560" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "01877" AND DET_CODCLI = "20011023";
    DOCUMENTO: 000000009560
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011023
       ESTADO: SP
         ITEM: 01877
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(32)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(2.37)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009560" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02719" AND DET_CODCLI = "20011023";
    DOCUMENTO: 000000009560
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011023
       ESTADO: SP
         ITEM: 02719
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(12)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.89)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009560" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "03628" AND DET_CODCLI = "20011023";
    DOCUMENTO: 000000009560
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20011023
       ESTADO: SP
         ITEM: 03628
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(10)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.74)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000437" AND DET_ESPDOC = "TR" AND DET_CODEMP = "001" AND DET_CODITE = "00123" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000000437
      ESPECIE: TR
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00123
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: TR}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('TR')
      .ValorTotalDoItem(29)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000437" AND DET_ESPDOC = "TR" AND DET_CODEMP = "001" AND DET_CODITE = "06379" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000000437
      ESPECIE: TR
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 06379
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: TR}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('TR')
      .ValorTotalDoItem(15)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000437" AND DET_ESPDOC = "TR" AND DET_CODEMP = "001" AND DET_CODITE = "01853" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000000437
      ESPECIE: TR
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01853
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: TR}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('TR')
      .ValorTotalDoItem(39)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000437" AND DET_ESPDOC = "TR" AND DET_CODEMP = "001" AND DET_CODITE = "00192" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000000437
      ESPECIE: TR
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00192
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: TR}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('TR')
      .ValorTotalDoItem(5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000009563" AND DET_ESPDOC = "FF" AND DET_CODEMP = "001" AND DET_CODITE = "02477" AND DET_CODCLI = "20005900";
    DOCUMENTO: 000000009563
      ESPECIE: FF
      EMPRESA: 001
      CLIENTE: 20005900
       ESTADO: SP
         ITEM: 02477
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('VN')
      .ValorTotalDoItem(80)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00842" AND DET_CODCLI = "00000396";
    DOCUMENTO: 000000000878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000396
       ESTADO: SP
         ITEM: 00842
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(58.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.36)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00608" AND DET_CODCLI = "00000396";
    DOCUMENTO: 000000000878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000396
       ESTADO: SP
         ITEM: 00608
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(30)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.18)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00618" AND DET_CODCLI = "00000396";
    DOCUMENTO: 000000000878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000396
       ESTADO: SP
         ITEM: 00618
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(72)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.43)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01710" AND DET_CODCLI = "00000396";
    DOCUMENTO: 000000000878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000396
       ESTADO: SP
         ITEM: 01710
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(128)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.77)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00194" AND DET_CODCLI = "00000396";
    DOCUMENTO: 000000000878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000396
       ESTADO: SP
         ITEM: 00194
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(40)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0.24)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000167;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000878" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06520" AND DET_CODCLI = "00000396";
    DOCUMENTO: 000000000878
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000396
       ESTADO: SP
         ITEM: 06520
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(1080)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(6.52)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000168;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06505" AND DET_CODCLI = "20005425";
    DOCUMENTO: 000000000879
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 20005425
       ESTADO: SP
         ITEM: 06505
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(175)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000169;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00629" AND DET_CODCLI = "20005425";
    DOCUMENTO: 000000000879
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 20005425
       ESTADO: SP
         ITEM: 00629
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000170;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01386" AND DET_CODCLI = "20005425";
    DOCUMENTO: 000000000879
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 20005425
       ESTADO: SP
         ITEM: 01386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(7.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestFRANCACORES.REGRA_ICMSORGAOPUBLICO_FRANCACORES_000171;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000879" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06596" AND DET_CODCLI = "20005425";
    DOCUMENTO: 000000000879
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 20005425
       ESTADO: SP
         ITEM: 06596
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 05/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('CF')
      .ValorTotalDoItem(21)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(1.25)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestFRANCACORES.Suite);
end.

