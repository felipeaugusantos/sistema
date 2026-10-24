unit TestFaturamento.Impostos.Calculos.Icms.MAGIC_CAR_OURIN_Lj002_20191212;

{--------------------------------------------------------------------------
                    RESUMO ICMS                 
--------------------------------------------------------------------------
Empresa            : 002 - MAGIC CAR OURINHOS 
Período Selecionado: 12/12/2019 até 12/12/2019
Data do Processo   : 13/12/2019 
Hora Inicio        : 14:40:11
Hora Fim           : 14:45:10
Tempo Total        : 00:04:58
                                           
Total Registros    : 297
Total Processados  : 297
Total de Acertos   : 98
Total de Erros     : 0
Total Ignorados    : 81
Total Duplicados   : 118
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.Icms,
Faturamento.Impostos.Tipos.Icms,
Faturamento.Impostos.Interfaces.Icms;

type
TestMAGICCAROURIN = class(TTestCase)
strict private
private

  FMetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;



published

Procedure REGRA_ICMS_MAGICCAROURIN_000001;
Procedure REGRA_ICMS_MAGICCAROURIN_000002;
Procedure REGRA_ICMS_MAGICCAROURIN_000003;
Procedure REGRA_ICMS_MAGICCAROURIN_000004;
Procedure REGRA_ICMS_MAGICCAROURIN_000005;
Procedure REGRA_ICMS_MAGICCAROURIN_000006;
Procedure REGRA_ICMS_MAGICCAROURIN_000007;
Procedure REGRA_ICMS_MAGICCAROURIN_000008;
Procedure REGRA_ICMS_MAGICCAROURIN_000009;
Procedure REGRA_ICMS_MAGICCAROURIN_000010;
Procedure REGRA_ICMS_MAGICCAROURIN_000011;
Procedure REGRA_ICMS_MAGICCAROURIN_000012;
Procedure REGRA_ICMS_MAGICCAROURIN_000013;
Procedure REGRA_ICMS_MAGICCAROURIN_000014;
Procedure REGRA_ICMS_MAGICCAROURIN_000015;
Procedure REGRA_ICMS_MAGICCAROURIN_000016;
Procedure REGRA_ICMS_MAGICCAROURIN_000017;
Procedure REGRA_ICMS_MAGICCAROURIN_000018;
Procedure REGRA_ICMS_MAGICCAROURIN_000019;
Procedure REGRA_ICMS_MAGICCAROURIN_000020;
Procedure REGRA_ICMS_MAGICCAROURIN_000021;
Procedure REGRA_ICMS_MAGICCAROURIN_000022;
Procedure REGRA_ICMS_MAGICCAROURIN_000023;
Procedure REGRA_ICMS_MAGICCAROURIN_000024;
Procedure REGRA_ICMS_MAGICCAROURIN_000025;
Procedure REGRA_ICMS_MAGICCAROURIN_000026;
Procedure REGRA_ICMS_MAGICCAROURIN_000027;
Procedure REGRA_ICMS_MAGICCAROURIN_000028;
Procedure REGRA_ICMS_MAGICCAROURIN_000029;
Procedure REGRA_ICMS_MAGICCAROURIN_000030;
Procedure REGRA_ICMS_MAGICCAROURIN_000031;
Procedure REGRA_ICMS_MAGICCAROURIN_000032;
Procedure REGRA_ICMS_MAGICCAROURIN_000033;
Procedure REGRA_ICMS_MAGICCAROURIN_000034;
Procedure REGRA_ICMS_MAGICCAROURIN_000035;
Procedure REGRA_ICMS_MAGICCAROURIN_000036;
Procedure REGRA_ICMS_MAGICCAROURIN_000037;
Procedure REGRA_ICMS_MAGICCAROURIN_000038;
Procedure REGRA_ICMS_MAGICCAROURIN_000039;
Procedure REGRA_ICMS_MAGICCAROURIN_000040;
Procedure REGRA_ICMS_MAGICCAROURIN_000041;
Procedure REGRA_ICMS_MAGICCAROURIN_000042;
Procedure REGRA_ICMS_MAGICCAROURIN_000043;
Procedure REGRA_ICMS_MAGICCAROURIN_000044;
Procedure REGRA_ICMS_MAGICCAROURIN_000045;
Procedure REGRA_ICMS_MAGICCAROURIN_000046;
Procedure REGRA_ICMS_MAGICCAROURIN_000047;
Procedure REGRA_ICMS_MAGICCAROURIN_000048;
Procedure REGRA_ICMS_MAGICCAROURIN_000049;
Procedure REGRA_ICMS_MAGICCAROURIN_000050;
Procedure REGRA_ICMS_MAGICCAROURIN_000051;
Procedure REGRA_ICMS_MAGICCAROURIN_000052;
Procedure REGRA_ICMS_MAGICCAROURIN_000053;
Procedure REGRA_ICMS_MAGICCAROURIN_000054;
Procedure REGRA_ICMS_MAGICCAROURIN_000055;
Procedure REGRA_ICMS_MAGICCAROURIN_000056;
Procedure REGRA_ICMS_MAGICCAROURIN_000057;
Procedure REGRA_ICMS_MAGICCAROURIN_000058;
Procedure REGRA_ICMS_MAGICCAROURIN_000059;
Procedure REGRA_ICMS_MAGICCAROURIN_000060;
Procedure REGRA_ICMS_MAGICCAROURIN_000061;
Procedure REGRA_ICMS_MAGICCAROURIN_000062;
Procedure REGRA_ICMS_MAGICCAROURIN_000063;
Procedure REGRA_ICMS_MAGICCAROURIN_000064;
Procedure REGRA_ICMS_MAGICCAROURIN_000065;
Procedure REGRA_ICMS_MAGICCAROURIN_000066;
Procedure REGRA_ICMS_MAGICCAROURIN_000067;
Procedure REGRA_ICMS_MAGICCAROURIN_000068;
Procedure REGRA_ICMS_MAGICCAROURIN_000069;
Procedure REGRA_ICMS_MAGICCAROURIN_000070;
Procedure REGRA_ICMS_MAGICCAROURIN_000071;
Procedure REGRA_ICMS_MAGICCAROURIN_000072;
Procedure REGRA_ICMS_MAGICCAROURIN_000073;
Procedure REGRA_ICMS_MAGICCAROURIN_000074;
Procedure REGRA_ICMS_MAGICCAROURIN_000075;
Procedure REGRA_ICMS_MAGICCAROURIN_000076;
Procedure REGRA_ICMS_MAGICCAROURIN_000077;
Procedure REGRA_ICMS_MAGICCAROURIN_000078;
Procedure REGRA_ICMS_MAGICCAROURIN_000079;
Procedure REGRA_ICMS_MAGICCAROURIN_000080;
Procedure REGRA_ICMS_MAGICCAROURIN_000081;
Procedure REGRA_ICMS_MAGICCAROURIN_000082;
Procedure REGRA_ICMS_MAGICCAROURIN_000083;
Procedure REGRA_ICMS_MAGICCAROURIN_000084;
Procedure REGRA_ICMS_MAGICCAROURIN_000085;
Procedure REGRA_ICMS_MAGICCAROURIN_000086;
Procedure REGRA_ICMS_MAGICCAROURIN_000087;
Procedure REGRA_ICMS_MAGICCAROURIN_000088;
Procedure REGRA_ICMS_MAGICCAROURIN_000089;
Procedure REGRA_ICMS_MAGICCAROURIN_000090;
Procedure REGRA_ICMS_MAGICCAROURIN_000091;
Procedure REGRA_ICMS_MAGICCAROURIN_000092;
Procedure REGRA_ICMS_MAGICCAROURIN_000093;
Procedure REGRA_ICMS_MAGICCAROURIN_000094;
Procedure REGRA_ICMS_MAGICCAROURIN_000095;
Procedure REGRA_ICMS_MAGICCAROURIN_000096;
Procedure REGRA_ICMS_MAGICCAROURIN_000097;
Procedure REGRA_ICMS_MAGICCAROURIN_000098;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestMAGICCAROURIN.SetUp;
begin
end;

procedure TestMAGICCAROURIN.TearDown;
begin
end;

Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231993" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23799" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000231993
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23799
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(30)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231994" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45239" AND DET_CODCLI = "20000829";
    DOCUMENTO: 000000231994
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000829
       ESTADO: SP
         ITEM: 45239
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(131.2)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231994" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45564" AND DET_CODCLI = "20000829";
    DOCUMENTO: 000000231994
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000829
       ESTADO: SP
         ITEM: 45564
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(51.55)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{51,55}, objFloatUtils.fStrToFloat('51,55')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,58}, objFloatUtils.fStrToFloat('1,58')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231994" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "44156" AND DET_CODCLI = "20000829";
    DOCUMENTO: 000000231994
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000829
       ESTADO: SP
         ITEM: 44156
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(71.36)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231996" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22731" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000231996
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 22731
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(10)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{10}, objFloatUtils.fStrToFloat('10')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,31}, objFloatUtils.fStrToFloat('0,31')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231996" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22719" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000231996
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 22719
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(8)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{8}, objFloatUtils.fStrToFloat('8')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,25}, objFloatUtils.fStrToFloat('0,25')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231996" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23953" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000231996
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23953
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(21)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{21}, objFloatUtils.fStrToFloat('21')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,64}, objFloatUtils.fStrToFloat('0,64')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23595" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 23595
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(29.81)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23596" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 23596
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(8.49)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{8,49}, objFloatUtils.fStrToFloat('8,49')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,26}, objFloatUtils.fStrToFloat('0,26')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45565" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 45565
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(20)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{20}, objFloatUtils.fStrToFloat('20')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,61}, objFloatUtils.fStrToFloat('0,61')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23434" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 23434
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(12.89)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{12,89}, objFloatUtils.fStrToFloat('12,89')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,4}, objFloatUtils.fStrToFloat('0,4')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22901" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 22901
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(3.16)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{3,16}, objFloatUtils.fStrToFloat('3,16')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,1}, objFloatUtils.fStrToFloat('0,1')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22740" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 22740
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(2.56)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{2,56}, objFloatUtils.fStrToFloat('2,56')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,08}, objFloatUtils.fStrToFloat('0,08')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231997" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22737" AND DET_CODCLI = "20000835";
    DOCUMENTO: 000000231997
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000835
       ESTADO: SP
         ITEM: 22737
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(7.68)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{7,68}, objFloatUtils.fStrToFloat('7,68')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,24}, objFloatUtils.fStrToFloat('0,24')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231998" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23832" AND DET_CODCLI = "20000535";
    DOCUMENTO: 000000231998
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000535
       ESTADO: SP
         ITEM: 23832
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(28)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231998" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22726" AND DET_CODCLI = "20000535";
    DOCUMENTO: 000000231998
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000535
       ESTADO: SP
         ITEM: 22726
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(11.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{11,5}, objFloatUtils.fStrToFloat('11,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,35}, objFloatUtils.fStrToFloat('0,35')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000231999" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43596" AND DET_CODCLI = "20000021";
    DOCUMENTO: 000000231999
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000021
       ESTADO: SP
         ITEM: 43596
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(130.8)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{130,8}, objFloatUtils.fStrToFloat('130,8')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{4,02}, objFloatUtils.fStrToFloat('4,02')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232000" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23912" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232000
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(25)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{25}, objFloatUtils.fStrToFloat('25')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,77}, objFloatUtils.fStrToFloat('0,77')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232000" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45336" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232000
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 45336
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(3)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{3}, objFloatUtils.fStrToFloat('3')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,09}, objFloatUtils.fStrToFloat('0,09')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232001" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "24472" AND DET_CODCLI = "20000054";
    DOCUMENTO: 000000232001
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000054
       ESTADO: SP
         ITEM: 24472
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(37)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232001" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46743" AND DET_CODCLI = "20000054";
    DOCUMENTO: 000000232001
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000054
       ESTADO: SP
         ITEM: 46743
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(29)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232001" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "47670" AND DET_CODCLI = "20000054";
    DOCUMENTO: 000000232001
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000054
       ESTADO: SP
         ITEM: 47670
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(13)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{13}, objFloatUtils.fStrToFloat('13')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,4}, objFloatUtils.fStrToFloat('0,4')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232001" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "47671" AND DET_CODCLI = "20000054";
    DOCUMENTO: 000000232001
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000054
       ESTADO: SP
         ITEM: 47671
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(26)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{26}, objFloatUtils.fStrToFloat('26')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,8}, objFloatUtils.fStrToFloat('0,8')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232002" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46332" AND DET_CODCLI = "20000021";
    DOCUMENTO: 000000232002
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000021
       ESTADO: SP
         ITEM: 46332
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(100)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232003" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43596" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232003
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 43596
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(12.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{12,5}, objFloatUtils.fStrToFloat('12,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,38}, objFloatUtils.fStrToFloat('0,38')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207193" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "44577" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000207193
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 44577
 ITEM SERVIÇO: NÃO
         CFOP: 2999
CODIGO FISCAL: 060
       IDEPRO: SHE
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(220)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232005" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23434" AND DET_CODCLI = "20000012";
    DOCUMENTO: 000000232005
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000012
       ESTADO: SP
         ITEM: 23434
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(12)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{12}, objFloatUtils.fStrToFloat('12')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,37}, objFloatUtils.fStrToFloat('0,37')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232006" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43796" AND DET_CODCLI = "20000693";
    DOCUMENTO: 000000232006
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000693
       ESTADO: MS
         ITEM: 43796
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(32)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{32}, objFloatUtils.fStrToFloat('32')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,98}, objFloatUtils.fStrToFloat('0,98')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232006" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23225" AND DET_CODCLI = "20000693";
    DOCUMENTO: 000000232006
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000693
       ESTADO: MS
         ITEM: 23225
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(15)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{15}, objFloatUtils.fStrToFloat('15')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,46}, objFloatUtils.fStrToFloat('0,46')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232007" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43898" AND DET_CODCLI = "20000105";
    DOCUMENTO: 000000232007
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000105
       ESTADO: SP
         ITEM: 43898
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(90)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{90}, objFloatUtils.fStrToFloat('90')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{2,76}, objFloatUtils.fStrToFloat('2,76')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232007" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23329" AND DET_CODCLI = "20000105";
    DOCUMENTO: 000000232007
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000105
       ESTADO: SP
         ITEM: 23329
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(45)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232008" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23998" AND DET_CODCLI = "20000055";
    DOCUMENTO: 000000232008
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000055
       ESTADO: SP
         ITEM: 23998
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(35)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232008" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23346" AND DET_CODCLI = "20000055";
    DOCUMENTO: 000000232008
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000055
       ESTADO: SP
         ITEM: 23346
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(35)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{35}, objFloatUtils.fStrToFloat('35')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,07}, objFloatUtils.fStrToFloat('1,07')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232008" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23629" AND DET_CODCLI = "20000055";
    DOCUMENTO: 000000232008
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000055
       ESTADO: SP
         ITEM: 23629
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(20)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{20}, objFloatUtils.fStrToFloat('20')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,61}, objFloatUtils.fStrToFloat('0,61')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232008" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22886" AND DET_CODCLI = "20000055";
    DOCUMENTO: 000000232008
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000055
       ESTADO: SP
         ITEM: 22886
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(14)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{14}, objFloatUtils.fStrToFloat('14')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,43}, objFloatUtils.fStrToFloat('0,43')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232010" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23364" AND DET_CODCLI = "20000371";
    DOCUMENTO: 000000232010
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000371
       ESTADO: SP
         ITEM: 23364
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(35)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232010" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23879" AND DET_CODCLI = "20000371";
    DOCUMENTO: 000000232010
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000371
       ESTADO: SP
         ITEM: 23879
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(42)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232010" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43503" AND DET_CODCLI = "20000371";
    DOCUMENTO: 000000232010
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000371
       ESTADO: SP
         ITEM: 43503
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(27.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{27,5}, objFloatUtils.fStrToFloat('27,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,84}, objFloatUtils.fStrToFloat('0,84')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232011" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46048" AND DET_CODCLI = "20000025";
    DOCUMENTO: 000000232011
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000025
       ESTADO: SP
         ITEM: 46048
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(22)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207196" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000076";
    DOCUMENTO: 000000207196
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000076
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(90)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232012" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "47705" AND DET_CODCLI = "20000076";
    DOCUMENTO: 000000232012
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000076
       ESTADO: SP
         ITEM: 47705
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(59)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{59}, objFloatUtils.fStrToFloat('59')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,81}, objFloatUtils.fStrToFloat('1,81')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207197" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000012";
    DOCUMENTO: 000000207197
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000012
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(39)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232013" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43596" AND DET_CODCLI = "20000012";
    DOCUMENTO: 000000232013
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000012
       ESTADO: SP
         ITEM: 43596
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(25.6)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{25,6}, objFloatUtils.fStrToFloat('25,6')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,79}, objFloatUtils.fStrToFloat('0,79')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232013" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23710" AND DET_CODCLI = "20000012";
    DOCUMENTO: 000000232013
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000012
       ESTADO: SP
         ITEM: 23710
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(3.3)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{3,3}, objFloatUtils.fStrToFloat('3,3')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,1}, objFloatUtils.fStrToFloat('0,1')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232014" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43622" AND DET_CODCLI = "20000002";
    DOCUMENTO: 000000232014
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000002
       ESTADO: SP
         ITEM: 43622
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(102)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232014" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "44324" AND DET_CODCLI = "20000002";
    DOCUMENTO: 000000232014
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000002
       ESTADO: SP
         ITEM: 44324
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(50)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{50}, objFloatUtils.fStrToFloat('50')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,54}, objFloatUtils.fStrToFloat('1,54')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232015" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46206" AND DET_CODCLI = "20000526";
    DOCUMENTO: 000000232015
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000526
       ESTADO: SP
         ITEM: 46206
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(1.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{1,5}, objFloatUtils.fStrToFloat('1,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,05}, objFloatUtils.fStrToFloat('0,05')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232016" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23912" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232016
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23912
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(27)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{27}, objFloatUtils.fStrToFloat('27')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,83}, objFloatUtils.fStrToFloat('0,83')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207198" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000088";
    DOCUMENTO: 000000207198
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000088
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(33)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232017" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23952" AND DET_CODCLI = "20000088";
    DOCUMENTO: 000000232017
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000088
       ESTADO: SP
         ITEM: 23952
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(10.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{10,5}, objFloatUtils.fStrToFloat('10,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,32}, objFloatUtils.fStrToFloat('0,32')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232017" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23699" AND DET_CODCLI = "20000088";
    DOCUMENTO: 000000232017
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000088
       ESTADO: SP
         ITEM: 23699
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(2.4)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{2,4}, objFloatUtils.fStrToFloat('2,4')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,07}, objFloatUtils.fStrToFloat('0,07')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232017" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23969" AND DET_CODCLI = "20000088";
    DOCUMENTO: 000000232017
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000088
       ESTADO: SP
         ITEM: 23969
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(6)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232018" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46458" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232018
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 46458
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(48)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232019" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23581" AND DET_CODCLI = "20000025";
    DOCUMENTO: 000000232019
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000025
       ESTADO: SP
         ITEM: 23581
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(32)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232020" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46979" AND DET_CODCLI = "20000829";
    DOCUMENTO: 000000232020
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000829
       ESTADO: SP
         ITEM: 46979
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(100)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232021" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "44730" AND DET_CODCLI = "20000535";
    DOCUMENTO: 000000232021
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000535
       ESTADO: SP
         ITEM: 44730
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(35)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{35}, objFloatUtils.fStrToFloat('35')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,07}, objFloatUtils.fStrToFloat('1,07')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232022" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23829" AND DET_CODCLI = "20000437";
    DOCUMENTO: 000000232022
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000437
       ESTADO: SP
         ITEM: 23829
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(100)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207200" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000207200
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(57)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207201" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000203";
    DOCUMENTO: 000000207201
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000203
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(23)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207201" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000203";
    DOCUMENTO: 000000207201
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000203
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(88)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232024" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23346" AND DET_CODCLI = "20000203";
    DOCUMENTO: 000000232024
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000203
       ESTADO: SP
         ITEM: 23346
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(30)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{30}, objFloatUtils.fStrToFloat('30')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,92}, objFloatUtils.fStrToFloat('0,92')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232024" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "44041" AND DET_CODCLI = "20000203";
    DOCUMENTO: 000000232024
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000203
       ESTADO: SP
         ITEM: 44041
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(75)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{75}, objFloatUtils.fStrToFloat('75')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{2,3}, objFloatUtils.fStrToFloat('2,3')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232025" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "42982" AND DET_CODCLI = "20000025";
    DOCUMENTO: 000000232025
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000025
       ESTADO: SP
         ITEM: 42982
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(9)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{9}, objFloatUtils.fStrToFloat('9')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,28}, objFloatUtils.fStrToFloat('0,28')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207202" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000105";
    DOCUMENTO: 000000207202
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000105
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(30)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000207203" AND DET_ESPDOC = "PR" AND DET_CODEMP = "002" AND DET_CODITE = "24518" AND DET_CODCLI = "20000352";
    DOCUMENTO: 000000207203
      ESPECIE: PR
      EMPRESA: 002
      CLIENTE: 20000352
       ESTADO: SP
         ITEM: 24518
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(59)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232030" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22882" AND DET_CODCLI = "20000002";
    DOCUMENTO: 000000232030
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000002
       ESTADO: SP
         ITEM: 22882
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(58)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232031" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "47438" AND DET_CODCLI = "20000535";
    DOCUMENTO: 000000232031
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000535
       ESTADO: SP
         ITEM: 47438
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(18)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{18}, objFloatUtils.fStrToFloat('18')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,55}, objFloatUtils.fStrToFloat('0,55')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232032" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "24020" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232032
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 24020
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(20)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232032" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46738" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232032
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 46738
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(26)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232034" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23814" AND DET_CODCLI = "20000012";
    DOCUMENTO: 000000232034
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000012
       ESTADO: SP
         ITEM: 23814
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(14)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{14}, objFloatUtils.fStrToFloat('14')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,43}, objFloatUtils.fStrToFloat('0,43')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232034" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23799" AND DET_CODCLI = "20000012";
    DOCUMENTO: 000000232034
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000012
       ESTADO: SP
         ITEM: 23799
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(40)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232035" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45336" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232035
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 45336
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{5}, objFloatUtils.fStrToFloat('5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,15}, objFloatUtils.fStrToFloat('0,15')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232035" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23699" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232035
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23699
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(1.2)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{1,2}, objFloatUtils.fStrToFloat('1,2')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,04}, objFloatUtils.fStrToFloat('0,04')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232037" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45733" AND DET_CODCLI = "20000270";
    DOCUMENTO: 000000232037
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000270
       ESTADO: SP
         ITEM: 45733
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(114)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232038" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46178" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232038
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 46178
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(34.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{34,5}, objFloatUtils.fStrToFloat('34,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,06}, objFloatUtils.fStrToFloat('1,06')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232038" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43413" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232038
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 43413
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(36)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{36}, objFloatUtils.fStrToFloat('36')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,11}, objFloatUtils.fStrToFloat('1,11')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232039" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46586" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000232039
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 46586
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(719.6)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232040" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23714" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232040
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23714
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(2.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{2,5}, objFloatUtils.fStrToFloat('2,5')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,08}, objFloatUtils.fStrToFloat('0,08')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232041" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "47589" AND DET_CODCLI = "20000021";
    DOCUMENTO: 000000232041
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000021
       ESTADO: SP
         ITEM: 47589
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(125)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{125}, objFloatUtils.fStrToFloat('125')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{3,84}, objFloatUtils.fStrToFloat('3,84')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000232042" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "47536" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000232042
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 47536
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(15)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_NCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005449" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43368" AND DET_CODCLI = "20000031";
    DOCUMENTO: 000000005449
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000031
       ESTADO: SP
         ITEM: 43368
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(50)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{50}, objFloatUtils.fStrToFloat('50')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,54}, objFloatUtils.fStrToFloat('1,54')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "46586" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 46586
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(1079.4)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45564" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 45564
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(196)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{196}, objFloatUtils.fStrToFloat('196')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{6,02}, objFloatUtils.fStrToFloat('6,02')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "22742" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 22742
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(22)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{22}, objFloatUtils.fStrToFloat('22')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,68}, objFloatUtils.fStrToFloat('0,68')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "23628" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 23628
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(207.8)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{207,8}, objFloatUtils.fStrToFloat('207,8')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{6,38}, objFloatUtils.fStrToFloat('6,38')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45597" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 45597
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(80)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{80}, objFloatUtils.fStrToFloat('80')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{2,46}, objFloatUtils.fStrToFloat('2,46')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "22882" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 22882
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(140)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005451" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "22886" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005451
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 22886
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(14.75)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{14,75}, objFloatUtils.fStrToFloat('14,75')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,45}, objFloatUtils.fStrToFloat('0,45')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005452" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "46586" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005452
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 46586
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(899.5)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005452" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45597" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005452
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 45597
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(64)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{64}, objFloatUtils.fStrToFloat('64')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,96}, objFloatUtils.fStrToFloat('1,96')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005452" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "23360" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005452
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 23360
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(188)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "46199" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 46199
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(18)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{18}, objFloatUtils.fStrToFloat('18')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,55}, objFloatUtils.fStrToFloat('0,55')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45894" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 45894
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(10)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{10}, objFloatUtils.fStrToFloat('10')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{0,31}, objFloatUtils.fStrToFloat('0,31')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43676" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 43676
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(39.6)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{39,6}, objFloatUtils.fStrToFloat('39,6')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,22}, objFloatUtils.fStrToFloat('1,22')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "45597" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 45597
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(320)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{320}, objFloatUtils.fStrToFloat('320')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{9,82}, objFloatUtils.fStrToFloat('9,82')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43503" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 43503
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(55)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{55}, objFloatUtils.fStrToFloat('55')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,69}, objFloatUtils.fStrToFloat('1,69')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "22742" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 22742
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(33)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{33}, objFloatUtils.fStrToFloat('33')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,01}, objFloatUtils.fStrToFloat('1,01')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestMAGICCAROURIN.REGRA_ICMS_MAGICCAROURIN_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005453" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "23551" AND DET_CODCLI = "20000014";
    DOCUMENTO: 000000005453
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000014
       ESTADO: SP
         ITEM: 23551
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 12/12/2019
   AUX_OPCDOC: CF}

Var
  ReturnValue: IResultadoCalculoIcms;
  AParametros: IParametrosCalculoIcms;
Begin

  AParametros :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .UtilizaImportacaoDireta(False)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(True)
      .TotalGeralDoItem(45)
      .EntraIPINaBaseIcms(False)
      .AliquotaDeIcmsDoItem(3.07)
      .ValorDoIpiDoItem(0)
      .PercentualDaBaseDeIcmsDoItem(100)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(False)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .PercentualDeReducaoDaBaseDeIcms(0)
      .TipoDaAbreviacaoFiscal('_SAI_CCO');

  ReturnValue := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.AliquotaDoIcms{3,07}, objFloatUtils.fStrToFloat('3,07')) And
           CompararValores(ReturnValue.BaseDeCalculoDoIcms{45}, objFloatUtils.fStrToFloat('45')) And
           CompararValores(ReturnValue.ValorCalculadoDoIcms{1,38}, objFloatUtils.fStrToFloat('1,38')) And
           CompararValores(ReturnValue.PercentualDaBaseDeIcms{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestMAGICCAROURIN.Suite);
end.

