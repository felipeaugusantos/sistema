unit TestFaturamento.Impostos.Calculos.St.TITANIUM_DO_BRA_20191021;

{--------------------------------------------------------------------------
                    RESUMO ST                 
--------------------------------------------------------------------------
Empresa            : 001 - TITANIUM DO BRASIL
Período Selecionado: 21/10/2019 até 21/10/2019
Data do Processo   : 22/10/2019 
Hora Inicio        : 11:31:01
Hora Fim           : 11:32:52
Tempo Total        : 00:01:50
                                           
Total Registros    : 171
Total Processados  : 171
Total de Acertos   : 166
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 5
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
TestTITANIUMDOBRA = class(TTestCase)
strict private
private




published

Procedure REGRA_ST_TITANIUMDOBRA_000001;
Procedure REGRA_ST_TITANIUMDOBRA_000002;
Procedure REGRA_ST_TITANIUMDOBRA_000003;
Procedure REGRA_ST_TITANIUMDOBRA_000004;
Procedure REGRA_ST_TITANIUMDOBRA_000005;
Procedure REGRA_ST_TITANIUMDOBRA_000006;
Procedure REGRA_ST_TITANIUMDOBRA_000007;
Procedure REGRA_ST_TITANIUMDOBRA_000008;
Procedure REGRA_ST_TITANIUMDOBRA_000009;
Procedure REGRA_ST_TITANIUMDOBRA_000010;
Procedure REGRA_ST_TITANIUMDOBRA_000011;
Procedure REGRA_ST_TITANIUMDOBRA_000012;
Procedure REGRA_ST_TITANIUMDOBRA_000013;
Procedure REGRA_ST_TITANIUMDOBRA_000014;
Procedure REGRA_ST_TITANIUMDOBRA_000015;
Procedure REGRA_ST_TITANIUMDOBRA_000016;
Procedure REGRA_ST_TITANIUMDOBRA_000017;
Procedure REGRA_ST_TITANIUMDOBRA_000018;
Procedure REGRA_ST_TITANIUMDOBRA_000019;
Procedure REGRA_ST_TITANIUMDOBRA_000020;
Procedure REGRA_ST_TITANIUMDOBRA_000021;
Procedure REGRA_ST_TITANIUMDOBRA_000022;
Procedure REGRA_ST_TITANIUMDOBRA_000023;
Procedure REGRA_ST_TITANIUMDOBRA_000024;
Procedure REGRA_ST_TITANIUMDOBRA_000025;
Procedure REGRA_ST_TITANIUMDOBRA_000026;
Procedure REGRA_ST_TITANIUMDOBRA_000027;
Procedure REGRA_ST_TITANIUMDOBRA_000028;
Procedure REGRA_ST_TITANIUMDOBRA_000029;
Procedure REGRA_ST_TITANIUMDOBRA_000030;
Procedure REGRA_ST_TITANIUMDOBRA_000031;
Procedure REGRA_ST_TITANIUMDOBRA_000032;
Procedure REGRA_ST_TITANIUMDOBRA_000033;
Procedure REGRA_ST_TITANIUMDOBRA_000034;
Procedure REGRA_ST_TITANIUMDOBRA_000035;
Procedure REGRA_ST_TITANIUMDOBRA_000036;
Procedure REGRA_ST_TITANIUMDOBRA_000037;
Procedure REGRA_ST_TITANIUMDOBRA_000038;
Procedure REGRA_ST_TITANIUMDOBRA_000039;
Procedure REGRA_ST_TITANIUMDOBRA_000040;
Procedure REGRA_ST_TITANIUMDOBRA_000041;
Procedure REGRA_ST_TITANIUMDOBRA_000042;
Procedure REGRA_ST_TITANIUMDOBRA_000043;
Procedure REGRA_ST_TITANIUMDOBRA_000044;
Procedure REGRA_ST_TITANIUMDOBRA_000045;
Procedure REGRA_ST_TITANIUMDOBRA_000046;
Procedure REGRA_ST_TITANIUMDOBRA_000047;
Procedure REGRA_ST_TITANIUMDOBRA_000048;
Procedure REGRA_ST_TITANIUMDOBRA_000049;
Procedure REGRA_ST_TITANIUMDOBRA_000050;
Procedure REGRA_ST_TITANIUMDOBRA_000051;
Procedure REGRA_ST_TITANIUMDOBRA_000052;
Procedure REGRA_ST_TITANIUMDOBRA_000053;
Procedure REGRA_ST_TITANIUMDOBRA_000054;
Procedure REGRA_ST_TITANIUMDOBRA_000055;
Procedure REGRA_ST_TITANIUMDOBRA_000056;
Procedure REGRA_ST_TITANIUMDOBRA_000057;
Procedure REGRA_ST_TITANIUMDOBRA_000058;
Procedure REGRA_ST_TITANIUMDOBRA_000059;
Procedure REGRA_ST_TITANIUMDOBRA_000060;
Procedure REGRA_ST_TITANIUMDOBRA_000061;
Procedure REGRA_ST_TITANIUMDOBRA_000062;
Procedure REGRA_ST_TITANIUMDOBRA_000063;
Procedure REGRA_ST_TITANIUMDOBRA_000064;
Procedure REGRA_ST_TITANIUMDOBRA_000065;
Procedure REGRA_ST_TITANIUMDOBRA_000066;
Procedure REGRA_ST_TITANIUMDOBRA_000067;
Procedure REGRA_ST_TITANIUMDOBRA_000068;
Procedure REGRA_ST_TITANIUMDOBRA_000069;
Procedure REGRA_ST_TITANIUMDOBRA_000070;
Procedure REGRA_ST_TITANIUMDOBRA_000071;
Procedure REGRA_ST_TITANIUMDOBRA_000072;
Procedure REGRA_ST_TITANIUMDOBRA_000073;
Procedure REGRA_ST_TITANIUMDOBRA_000074;
Procedure REGRA_ST_TITANIUMDOBRA_000075;
Procedure REGRA_ST_TITANIUMDOBRA_000076;
Procedure REGRA_ST_TITANIUMDOBRA_000077;
Procedure REGRA_ST_TITANIUMDOBRA_000078;
Procedure REGRA_ST_TITANIUMDOBRA_000079;
Procedure REGRA_ST_TITANIUMDOBRA_000080;
Procedure REGRA_ST_TITANIUMDOBRA_000081;
Procedure REGRA_ST_TITANIUMDOBRA_000082;
Procedure REGRA_ST_TITANIUMDOBRA_000083;
Procedure REGRA_ST_TITANIUMDOBRA_000084;
Procedure REGRA_ST_TITANIUMDOBRA_000085;
Procedure REGRA_ST_TITANIUMDOBRA_000086;
Procedure REGRA_ST_TITANIUMDOBRA_000087;
Procedure REGRA_ST_TITANIUMDOBRA_000088;
Procedure REGRA_ST_TITANIUMDOBRA_000089;
Procedure REGRA_ST_TITANIUMDOBRA_000090;
Procedure REGRA_ST_TITANIUMDOBRA_000091;
Procedure REGRA_ST_TITANIUMDOBRA_000092;
Procedure REGRA_ST_TITANIUMDOBRA_000093;
Procedure REGRA_ST_TITANIUMDOBRA_000094;
Procedure REGRA_ST_TITANIUMDOBRA_000095;
Procedure REGRA_ST_TITANIUMDOBRA_000096;
Procedure REGRA_ST_TITANIUMDOBRA_000097;
Procedure REGRA_ST_TITANIUMDOBRA_000098;
Procedure REGRA_ST_TITANIUMDOBRA_000099;
Procedure REGRA_ST_TITANIUMDOBRA_000100;
Procedure REGRA_ST_TITANIUMDOBRA_000101;
Procedure REGRA_ST_TITANIUMDOBRA_000102;
Procedure REGRA_ST_TITANIUMDOBRA_000103;
Procedure REGRA_ST_TITANIUMDOBRA_000104;
Procedure REGRA_ST_TITANIUMDOBRA_000105;
Procedure REGRA_ST_TITANIUMDOBRA_000106;
Procedure REGRA_ST_TITANIUMDOBRA_000107;
Procedure REGRA_ST_TITANIUMDOBRA_000108;
Procedure REGRA_ST_TITANIUMDOBRA_000109;
Procedure REGRA_ST_TITANIUMDOBRA_000110;
Procedure REGRA_ST_TITANIUMDOBRA_000111;
Procedure REGRA_ST_TITANIUMDOBRA_000112;
Procedure REGRA_ST_TITANIUMDOBRA_000113;
Procedure REGRA_ST_TITANIUMDOBRA_000114;
Procedure REGRA_ST_TITANIUMDOBRA_000115;
Procedure REGRA_ST_TITANIUMDOBRA_000116;
Procedure REGRA_ST_TITANIUMDOBRA_000117;
Procedure REGRA_ST_TITANIUMDOBRA_000118;
Procedure REGRA_ST_TITANIUMDOBRA_000119;
Procedure REGRA_ST_TITANIUMDOBRA_000120;
Procedure REGRA_ST_TITANIUMDOBRA_000121;
Procedure REGRA_ST_TITANIUMDOBRA_000122;
Procedure REGRA_ST_TITANIUMDOBRA_000123;
Procedure REGRA_ST_TITANIUMDOBRA_000124;
Procedure REGRA_ST_TITANIUMDOBRA_000125;
Procedure REGRA_ST_TITANIUMDOBRA_000126;
Procedure REGRA_ST_TITANIUMDOBRA_000127;
Procedure REGRA_ST_TITANIUMDOBRA_000128;
Procedure REGRA_ST_TITANIUMDOBRA_000129;
Procedure REGRA_ST_TITANIUMDOBRA_000130;
Procedure REGRA_ST_TITANIUMDOBRA_000131;
Procedure REGRA_ST_TITANIUMDOBRA_000132;
Procedure REGRA_ST_TITANIUMDOBRA_000133;
Procedure REGRA_ST_TITANIUMDOBRA_000134;
Procedure REGRA_ST_TITANIUMDOBRA_000135;
Procedure REGRA_ST_TITANIUMDOBRA_000136;
Procedure REGRA_ST_TITANIUMDOBRA_000137;
Procedure REGRA_ST_TITANIUMDOBRA_000138;
Procedure REGRA_ST_TITANIUMDOBRA_000139;
Procedure REGRA_ST_TITANIUMDOBRA_000140;
Procedure REGRA_ST_TITANIUMDOBRA_000141;
Procedure REGRA_ST_TITANIUMDOBRA_000142;
Procedure REGRA_ST_TITANIUMDOBRA_000143;
Procedure REGRA_ST_TITANIUMDOBRA_000144;
Procedure REGRA_ST_TITANIUMDOBRA_000145;
Procedure REGRA_ST_TITANIUMDOBRA_000146;
Procedure REGRA_ST_TITANIUMDOBRA_000147;
Procedure REGRA_ST_TITANIUMDOBRA_000148;
Procedure REGRA_ST_TITANIUMDOBRA_000149;
Procedure REGRA_ST_TITANIUMDOBRA_000150;
Procedure REGRA_ST_TITANIUMDOBRA_000151;
Procedure REGRA_ST_TITANIUMDOBRA_000152;
Procedure REGRA_ST_TITANIUMDOBRA_000153;
Procedure REGRA_ST_TITANIUMDOBRA_000154;
Procedure REGRA_ST_TITANIUMDOBRA_000155;
Procedure REGRA_ST_TITANIUMDOBRA_000156;
Procedure REGRA_ST_TITANIUMDOBRA_000157;
Procedure REGRA_ST_TITANIUMDOBRA_000158;
Procedure REGRA_ST_TITANIUMDOBRA_000159;
Procedure REGRA_ST_TITANIUMDOBRA_000160;
Procedure REGRA_ST_TITANIUMDOBRA_000161;
Procedure REGRA_ST_TITANIUMDOBRA_000162;
Procedure REGRA_ST_TITANIUMDOBRA_000163;
Procedure REGRA_ST_TITANIUMDOBRA_000164;
Procedure REGRA_ST_TITANIUMDOBRA_000165;
Procedure REGRA_ST_TITANIUMDOBRA_000166;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestTITANIUMDOBRA.SetUp;
begin
end;

procedure TestTITANIUMDOBRA.TearDown;
begin
end;

Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058551" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00002022";
    DOCUMENTO: 000000058551
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00002022
       ESTADO: SP
         ITEM: 05246
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(153)
      .ValorDoIcmsDoEstado(153)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(411.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(850)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058552" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05236" AND DET_CODCLI = "00006788";
    DOCUMENTO: 000000058552
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006788
       ESTADO: SP
         ITEM: 05236
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.87)
      .ValorDoIcmsDoEstado(11.7)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(40.48)
      .ValorDoIpiDoItem(6.5)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(65)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058552" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05215" AND DET_CODCLI = "00006788";
    DOCUMENTO: 000000058552
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006788
       ESTADO: SP
         ITEM: 05215
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.21)
      .ValorDoIcmsDoEstado(3.06)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(10.55)
      .ValorDoIpiDoItem(0.85)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(17)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_NCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058552" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05375" AND DET_CODCLI = "00006788";
    DOCUMENTO: 000000058552
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006788
       ESTADO: SP
         ITEM: 05375
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.32)
      .ValorDoIcmsDoEstado(4.32)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(14.56)
      .ValorDoIpiDoItem(0)
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
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058553" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04160" AND DET_CODCLI = "00006793";
    DOCUMENTO: 000000058553
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006793
       ESTADO: MA
         ITEM: 04160
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.77)
      .ValorDoIcmsDoEstado(6.77)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(112.9)
      .ValorDoIpiDoItem(13.54)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(169.26)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058553" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05287" AND DET_CODCLI = "00006793";
    DOCUMENTO: 000000058553
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006793
       ESTADO: MA
         ITEM: 05287
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.16)
      .ValorDoIcmsDoEstado(2.16)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(26.31)
      .ValorDoIpiDoItem(4.32)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(53.94)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058553" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05361" AND DET_CODCLI = "00006793";
    DOCUMENTO: 000000058553
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006793
       ESTADO: MA
         ITEM: 05361
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.76)
      .ValorDoIcmsDoEstado(3.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(60.7)
      .ValorDoIpiDoItem(7.52)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(93.99)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058553" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05455" AND DET_CODCLI = "00006793";
    DOCUMENTO: 000000058553
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006793
       ESTADO: MA
         ITEM: 05455
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.55)
      .ValorDoIcmsDoEstado(14.55)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(219.39)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(363.75)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058553" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05242" AND DET_CODCLI = "00006793";
    DOCUMENTO: 000000058553
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006793
       ESTADO: MA
         ITEM: 05242
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.4)
      .ValorDoIcmsDoEstado(12.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(143.15)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(310.01)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04568" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04568
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.75)
      .ValorDoIcmsDoEstado(0.75)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(11.63)
      .ValorDoIpiDoItem(2.83)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(18.85)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04569" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04569
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.72)
      .ValorDoIcmsDoEstado(0.72)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(11.09)
      .ValorDoIpiDoItem(2.69)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(17.95)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04571" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04571
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.53)
      .ValorDoIcmsDoEstado(1.53)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(23.66)
      .ValorDoIpiDoItem(5.75)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04573" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04573
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.44)
      .ValorDoIcmsDoEstado(0.44)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(6.74)
      .ValorDoIpiDoItem(1.64)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(10.92)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04574" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04574
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.07)
      .ValorDoIcmsDoEstado(1.07)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(16.48)
      .ValorDoIpiDoItem(4.01)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(26.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04577" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04577
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.52)
      .ValorDoIcmsDoEstado(1.52)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(23.39)
      .ValorDoIpiDoItem(5.68)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(37.88)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04160" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04160
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.14)
      .ValorDoIcmsDoEstado(3.14)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(56.45)
      .ValorDoIpiDoItem(6.29)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(78.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04235" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04235
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.99)
      .ValorDoIcmsDoEstado(4.99)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(82.31)
      .ValorDoIpiDoItem(9.98)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(124.74)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05155" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 05155
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.88)
      .ValorDoIcmsDoEstado(0.88)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(13.65)
      .ValorDoIpiDoItem(2.21)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(22.1)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05377" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 05377
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.36)
      .ValorDoIcmsDoEstado(4.36)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(65.81)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(109)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05378" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 05378
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.52)
      .ValorDoIcmsDoEstado(10.52)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(142.86)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(263)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04870" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04870
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.14)
      .ValorDoIcmsDoEstado(12.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(217.25)
      .ValorDoIpiDoItem(30.36)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(303.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04442" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04442
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.95)
      .ValorDoIcmsDoEstado(2.95)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(11.37)
      .ValorDoIpiDoItem(5.89)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(73.68)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05455" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 05455
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.22)
      .ValorDoIcmsDoEstado(1.22)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(17.55)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30.48)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05454" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 05454
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.1)
      .ValorDoIcmsDoEstado(6.1)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(87.76)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(152.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04583" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04583
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.46)
      .ValorDoIcmsDoEstado(2.46)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(26.04)
      .ValorDoIpiDoItem(4.92)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61.56)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05297" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 05297
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.2)
      .ValorDoIcmsDoEstado(5.2)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(80.29)
      .ValorDoIpiDoItem(10.4)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(130.02)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04446" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04446
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.16)
      .ValorDoIcmsDoEstado(2.16)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(27.84)
      .ValorDoIpiDoItem(4.32)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(54)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04600" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04600
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(13.13)
      .ValorDoIcmsDoEstado(13.13)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(260.72)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(328.32)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058554" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04750" AND DET_CODCLI = "00005697";
    DOCUMENTO: 000000058554
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005697
       ESTADO: RO
         ITEM: 04750
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.32)
      .ValorDoIcmsDoEstado(4.32)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(62.34)
      .ValorDoIpiDoItem(16.2)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(108)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058555" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05446" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000058555
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: SP
         ITEM: 05446
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(126)
      .ValorDoIcmsDoEstado(126)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(263.74)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(700)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058555" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000058555
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: SP
         ITEM: 05246
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(62.64)
      .ValorDoIcmsDoEstado(62.64)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(164.51)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(348)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058555" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05375" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000058555
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: SP
         ITEM: 05375
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.91)
      .ValorDoIcmsDoEstado(6.91)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(21.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04847" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 04847
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.64)
      .ValorDoIcmsDoEstado(4.64)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(60.6)
      .ValorDoIpiDoItem(5.8)
      .ValorDoIva(1.639)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(116)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{199,63}, objFloatUtils.fStrToFloat('199,63')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{31,29}, objFloatUtils.fStrToFloat('31,29')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05458" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 05458
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.2)
      .ValorDoIcmsDoEstado(6.2)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(84)
      .ValorDoIpiDoItem(12.4)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(155.04)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{284,25}, objFloatUtils.fStrToFloat('284,25')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{44,97}, objFloatUtils.fStrToFloat('44,96')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05459" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 05459
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.8)
      .ValorDoIcmsDoEstado(7.8)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(127.2)
      .ValorDoIpiDoItem(15.6)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(195)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{357,51}, objFloatUtils.fStrToFloat('357,51')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{56,55}, objFloatUtils.fStrToFloat('56,55')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05460" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 05460
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5)
      .ValorDoIcmsDoEstado(5)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(64.64)
      .ValorDoIpiDoItem(10)
      .ValorDoIva(1.6976)
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
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{229,18}, objFloatUtils.fStrToFloat('229,18')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{36,25}, objFloatUtils.fStrToFloat('36,25')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04161" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 04161
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.28)
      .ValorDoIcmsDoEstado(3.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(38.92)
      .ValorDoIpiDoItem(4.1)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(81.91)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04162" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 04162
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.46)
      .ValorDoIcmsDoEstado(3.46)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(42.29)
      .ValorDoIpiDoItem(4.32)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(86.46)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058556" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04603" AND DET_CODCLI = "00000778";
    DOCUMENTO: 000000058556
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000778
       ESTADO: MG
         ITEM: 04603
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.11)
      .ValorDoIcmsDoEstado(3.11)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(38.69)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.639)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(77.82)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{127,55}, objFloatUtils.fStrToFloat('127,55')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{19,85}, objFloatUtils.fStrToFloat('19,85')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058557" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04215" AND DET_CODCLI = "00000074";
    DOCUMENTO: 000000058557
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000074
       ESTADO: SP
         ITEM: 04215
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(54)
      .ValorDoIcmsDoEstado(54)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(158.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.7148)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(300)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{514,44}, objFloatUtils.fStrToFloat('514,44')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{38,6}, objFloatUtils.fStrToFloat('38,6')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058557" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04213" AND DET_CODCLI = "00000074";
    DOCUMENTO: 000000058557
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000074
       ESTADO: SP
         ITEM: 04213
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(85.32)
      .ValorDoIcmsDoEstado(85.32)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(186.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.7148)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(474)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{812,82}, objFloatUtils.fStrToFloat('812,82')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{60,99}, objFloatUtils.fStrToFloat('60,99')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058557" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04325" AND DET_CODCLI = "00000074";
    DOCUMENTO: 000000058557
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000074
       ESTADO: SP
         ITEM: 04325
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(32.29)
      .ValorDoIcmsDoEstado(32.29)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(79.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(179.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058557" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05421" AND DET_CODCLI = "00000074";
    DOCUMENTO: 000000058557
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000074
       ESTADO: SP
         ITEM: 05421
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(35.64)
      .ValorDoIcmsDoEstado(35.64)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(87.91)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(198)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058558" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00001871";
    DOCUMENTO: 000000058558
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001871
       ESTADO: SP
         ITEM: 05246
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(283.68)
      .ValorDoIcmsDoEstado(283.68)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(822.55)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1576)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05377" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05377
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(30.4)
      .ValorDoIcmsDoEstado(30.4)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(526.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(760)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05052" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05052
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(40)
      .ValorDoIcmsDoEstado(40)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(605.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1000)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05446" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05446
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.4)
      .ValorDoIcmsDoEstado(12.4)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(131.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(310)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05447" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05447
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(14.88)
      .ValorDoIcmsDoEstado(14.88)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(158.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(372)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05448" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05448
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(9.92)
      .ValorDoIcmsDoEstado(9.92)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(105.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(248)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04517" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 04517
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.5)
      .ValorDoIcmsDoEstado(8.5)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(108.8)
      .ValorDoIpiDoItem(17)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(212.44)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05241" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05241
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.26)
      .ValorDoIcmsDoEstado(7.26)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(73.4)
      .ValorDoIpiDoItem(14.51)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(181.42)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04579" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 04579
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.76)
      .ValorDoIcmsDoEstado(1.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(25.42)
      .ValorDoIpiDoItem(3.51)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(43.92)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 05246
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(30)
      .ValorDoIcmsDoEstado(30)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(411.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(750)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04590" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 04590
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.53)
      .ValorDoIcmsDoEstado(10.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(164.59)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(263.19)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04227" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 04227
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10)
      .ValorDoIcmsDoEstado(10)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(77.7)
      .ValorDoIpiDoItem(20)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(250)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058559" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04365" AND DET_CODCLI = "00004148";
    DOCUMENTO: 000000058559
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004148
       ESTADO: CE
         ITEM: 04365
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.68)
      .ValorDoIcmsDoEstado(1.68)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(13.48)
      .ValorDoIpiDoItem(3.36)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(42)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058560" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05420" AND DET_CODCLI = "00004319";
    DOCUMENTO: 000000058560
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004319
       ESTADO: RJ
         ITEM: 05420
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(9.6)
      .ValorDoIcmsDoEstado(9.6)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(158.73)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(240)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058560" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05421" AND DET_CODCLI = "00004319";
    DOCUMENTO: 000000058560
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004319
       ESTADO: RJ
         ITEM: 05421
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(19.52)
      .ValorDoIcmsDoEstado(19.52)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(293.04)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(488)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058560" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00004319";
    DOCUMENTO: 000000058560
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004319
       ESTADO: RJ
         ITEM: 05246
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(123.04)
      .ValorDoIcmsDoEstado(123.04)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1645.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3076)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058561" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05225" AND DET_CODCLI = "00004578";
    DOCUMENTO: 000000058561
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004578
       ESTADO: MS
         ITEM: 05225
         CFOP: 6916
CODIGO FISCAL: 041
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.91)
      .ValorDoIcmsDoEstado(12.91)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(302.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(322.66)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04742" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04742
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(30.06)
      .ValorDoIcmsDoEstado(30.06)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(531)
      .ValorDoIpiDoItem(37.58)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(751.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04744" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04744
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(10.61)
      .ValorDoIcmsDoEstado(10.61)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(168)
      .ValorDoIpiDoItem(13.26)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(265.2)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04235" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04235
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.56)
      .ValorDoIcmsDoEstado(4.56)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(82.31)
      .ValorDoIpiDoItem(9.12)
      .ValorDoIva(1.3)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(114)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{160,06}, objFloatUtils.fStrToFloat('160,06')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{24,25}, objFloatUtils.fStrToFloat('24,25')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05210" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05210
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.38)
      .ValorDoIcmsDoEstado(1.38)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(18.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(34.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04949" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04949
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.56)
      .ValorDoIcmsDoEstado(4.56)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(63.27)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(114)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05390" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05390
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.08)
      .ValorDoIcmsDoEstado(2.08)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(31.17)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(52)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05421" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05421
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(11.2)
      .ValorDoIcmsDoEstado(11.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(146.52)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(280)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05412" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05412
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(27.96)
      .ValorDoIcmsDoEstado(27.96)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(432.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6507)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(699)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{1153,84}, objFloatUtils.fStrToFloat('1153,84')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{179,73}, objFloatUtils.fStrToFloat('179,73')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05236" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05236
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3)
      .ValorDoIcmsDoEstado(3)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(40.48)
      .ValorDoIpiDoItem(7.5)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(75)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04442" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04442
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8)
      .ValorDoIcmsDoEstado(8)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(37.9)
      .ValorDoIpiDoItem(16)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(200)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04620" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04620
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.16)
      .ValorDoIcmsDoEstado(8.16)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(131.94)
      .ValorDoIpiDoItem(16.32)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(204)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04590" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04590
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.6)
      .ValorDoIcmsDoEstado(2.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(41.15)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(65)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05375" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05375
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.52)
      .ValorDoIcmsDoEstado(0.52)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(7.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05441" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05441
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.04)
      .ValorDoIcmsDoEstado(1.04)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(19.54)
      .ValorDoIpiDoItem(3.12)
      .ValorDoIva(2.0111)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(26)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{58,56}, objFloatUtils.fStrToFloat('58,56')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{9,5}, objFloatUtils.fStrToFloat('9,5')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05442" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05442
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.56)
      .ValorDoIcmsDoEstado(2.56)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(47.95)
      .ValorDoIpiDoItem(7.68)
      .ValorDoIva(2.0111)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(64)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{144,16}, objFloatUtils.fStrToFloat('144,16')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{23,39}, objFloatUtils.fStrToFloat('23,39')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04227" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04227
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6)
      .ValorDoIcmsDoEstado(6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(46.62)
      .ValorDoIpiDoItem(12)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(150)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05144" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 05144
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1)
      .ValorDoIcmsDoEstado(1)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.51)
      .ValorDoIpiDoItem(2)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(25)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058562" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04750" AND DET_CODCLI = "00004321";
    DOCUMENTO: 000000058562
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004321
       ESTADO: DF
         ITEM: 04750
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.64)
      .ValorDoIcmsDoEstado(8.64)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(124.69)
      .ValorDoIpiDoItem(32.4)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(216)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058563" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05377" AND DET_CODCLI = "00006086";
    DOCUMENTO: 000000058563
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006086
       ESTADO: BA
         ITEM: 05377
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.92)
      .ValorDoIcmsDoEstado(7.92)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(131.62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(198)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058563" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04870" AND DET_CODCLI = "00006086";
    DOCUMENTO: 000000058563
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006086
       ESTADO: BA
         ITEM: 04870
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(63.2)
      .ValorDoIcmsDoEstado(63.2)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1086.24)
      .ValorDoIpiDoItem(158)
      .ValorDoIva(1.9317)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1580)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{3357,29}, objFloatUtils.fStrToFloat('3357,29')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{541,11}, objFloatUtils.fStrToFloat('541,11')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04511" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04511
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.16)
      .ValorDoIcmsDoEstado(6.16)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(73.2)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(154.08)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000082;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04489" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04489
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.62)
      .ValorDoIcmsDoEstado(3.62)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(49.71)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(90.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000083;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04452" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04452
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.27)
      .ValorDoIcmsDoEstado(1.27)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(17.46)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(31.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000084;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04454" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04454
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.82)
      .ValorDoIcmsDoEstado(1.82)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(25.03)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(45.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000085;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04847" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04847
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.66)
      .ValorDoIcmsDoEstado(3.66)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(45.45)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(91.59)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000086;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04654" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04654
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.36)
      .ValorDoIcmsDoEstado(2.36)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(35.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(59.04)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000087;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04655" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04655
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.46)
      .ValorDoIcmsDoEstado(2.46)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(37.16)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61.44)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000088;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04159" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04159
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.29)
      .ValorDoIcmsDoEstado(2.29)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(33.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(57.36)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000089;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04517" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04517
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.25)
      .ValorDoIcmsDoEstado(6.25)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(65.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(156.36)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000090;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05241" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 05241
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.34)
      .ValorDoIcmsDoEstado(8.34)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(88.08)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(208.44)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000091;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05215" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 05215
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.96)
      .ValorDoIcmsDoEstado(1.96)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(21.09)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(48.88)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000092;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05375" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 05375
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.93)
      .ValorDoIcmsDoEstado(3.93)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(58.25)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(98.24)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000093;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04755" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04755
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.71)
      .ValorDoIcmsDoEstado(2.71)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(41.03)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(67.86)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000094;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058564" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04750" AND DET_CODCLI = "00004595";
    DOCUMENTO: 000000058564
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004595
       ESTADO: RO
         ITEM: 04750
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.29)
      .ValorDoIcmsDoEstado(4.29)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(62.34)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(107.28)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000095;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058565" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00000446";
    DOCUMENTO: 000000058565
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000446
       ESTADO: SP
         ITEM: 05246
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(71.28)
      .ValorDoIcmsDoEstado(71.28)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(164.51)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(396)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000096;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058566" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05420" AND DET_CODCLI = "00004797";
    DOCUMENTO: 000000058566
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004797
       ESTADO: MG
         ITEM: 05420
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.48)
      .ValorDoIcmsDoEstado(4.48)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(55.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(112)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000097;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058566" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05421" AND DET_CODCLI = "00004797";
    DOCUMENTO: 000000058566
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004797
       ESTADO: MG
         ITEM: 05421
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.8)
      .ValorDoIcmsDoEstado(4.8)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(58.61)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(120)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000098;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058566" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05457" AND DET_CODCLI = "00004797";
    DOCUMENTO: 000000058566
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004797
       ESTADO: MG
         ITEM: 05457
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(17.4)
      .ValorDoIcmsDoEstado(17.4)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(138.75)
      .ValorDoIpiDoItem(21.75)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(435)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000099;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058566" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05246" AND DET_CODCLI = "00004797";
    DOCUMENTO: 000000058566
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004797
       ESTADO: MG
         ITEM: 05246
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(23.8)
      .ValorDoIcmsDoEstado(23.8)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(287.89)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(595)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000100;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058567" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05417" AND DET_CODCLI = "00005459";
    DOCUMENTO: 000000058567
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005459
       ESTADO: MT
         ITEM: 05417
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(20.4)
      .ValorDoIcmsDoEstado(20.4)
      .AliquotaDaSubstituicaoTributariaDoItem(17)
      .TotalGeralDoItemPreUlt(299.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0.8323)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(510)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(True)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{424,47}, objFloatUtils.fStrToFloat('424,47')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{51,76}, objFloatUtils.fStrToFloat('51,76')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000101;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058567" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05422" AND DET_CODCLI = "00005459";
    DOCUMENTO: 000000058567
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005459
       ESTADO: MT
         ITEM: 05422
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8.6)
      .ValorDoIcmsDoEstado(8.6)
      .AliquotaDaSubstituicaoTributariaDoItem(17)
      .TotalGeralDoItemPreUlt(111)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0.8323)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(215)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(True)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{178,94}, objFloatUtils.fStrToFloat('178,94')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{21,82}, objFloatUtils.fStrToFloat('21,82')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000102;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058567" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04503" AND DET_CODCLI = "00005459";
    DOCUMENTO: 000000058567
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005459
       ESTADO: MT
         ITEM: 04503
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.56)
      .ValorDoIcmsDoEstado(4.34)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(61.56)
      .ValorDoIpiDoItem(5.43)
      .ValorDoIva(0.8323)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(108.56)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(True)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000103;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058567" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05245" AND DET_CODCLI = "00005459";
    DOCUMENTO: 000000058567
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005459
       ESTADO: MT
         ITEM: 05245
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(21.98)
      .ValorDoIcmsDoEstado(21.98)
      .AliquotaDaSubstituicaoTributariaDoItem(17)
      .TotalGeralDoItemPreUlt(247.86)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0.8323)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(549.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(True)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{457,35}, objFloatUtils.fStrToFloat('457,35')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{55,77}, objFloatUtils.fStrToFloat('55,77')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000104;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05377" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 05377
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.8)
      .ValorDoIcmsDoEstado(3.8)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(65.81)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(95)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000105;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04217" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 04217
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.59)
      .ValorDoIcmsDoEstado(2.59)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(31.97)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(64.71)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{117,42}, objFloatUtils.fStrToFloat('117,42')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{18,55}, objFloatUtils.fStrToFloat('18,55')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000106;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04159" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 04159
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.56)
      .ValorDoIcmsDoEstado(2.56)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(33.3)
      .ValorDoIpiDoItem(9.61)
      .ValorDoIva(2.0546)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(64.04)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{151,32}, objFloatUtils.fStrToFloat('151,32')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{24,68}, objFloatUtils.fStrToFloat('24,68')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000107;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04158" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 04158
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.81)
      .ValorDoIcmsDoEstado(2.81)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(38.23)
      .ValorDoIpiDoItem(10.54)
      .ValorDoIva(2.0546)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(70.27)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{166,03}, objFloatUtils.fStrToFloat('166,03')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{27,08}, objFloatUtils.fStrToFloat('27,08')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000108;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05421" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 05421
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.76)
      .ValorDoIcmsDoEstado(6.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(87.91)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(169.06)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000109;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05412" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 05412
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(16.78)
      .ValorDoIcmsDoEstado(16.78)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(259.74)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8164)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(419.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{761,8}, objFloatUtils.fStrToFloat('761,8')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{120,34}, objFloatUtils.fStrToFloat('120,34')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000110;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058568" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05404" AND DET_CODCLI = "00007089";
    DOCUMENTO: 000000058568
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007089
       ESTADO: BA
         ITEM: 05404
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(28.72)
      .ValorDoIcmsDoEstado(28.72)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(430.35)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(718)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000111;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058569" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04509" AND DET_CODCLI = "00005641";
    DOCUMENTO: 000000058569
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005641
       ESTADO: GO
         ITEM: 04509
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(17.44)
      .ValorDoIcmsDoEstado(17.44)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(251.3)
      .ValorDoIpiDoItem(34.88)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(436)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000112;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058569" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05047" AND DET_CODCLI = "00005641";
    DOCUMENTO: 000000058569
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005641
       ESTADO: GO
         ITEM: 05047
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(96)
      .ValorDoIcmsDoEstado(96)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(2055.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2400)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000113;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058569" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05052" AND DET_CODCLI = "00005641";
    DOCUMENTO: 000000058569
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005641
       ESTADO: GO
         ITEM: 05052
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(104)
      .ValorDoIcmsDoEstado(104)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1514)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2600)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000114;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058569" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05241" AND DET_CODCLI = "00005641";
    DOCUMENTO: 000000058569
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005641
       ESTADO: GO
         ITEM: 05241
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(201.6)
      .ValorDoIcmsDoEstado(201.6)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(2642.4)
      .ValorDoIpiDoItem(403.2)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(5040)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000115;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058569" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05454" AND DET_CODCLI = "00005641";
    DOCUMENTO: 000000058569
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005641
       ESTADO: GO
         ITEM: 05454
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(57.6)
      .ValorDoIcmsDoEstado(57.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(877.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1440)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000116;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058570" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04511" AND DET_CODCLI = "00001447";
    DOCUMENTO: 000000058570
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001447
       ESTADO: SP
         ITEM: 04511
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(15.81)
      .ValorDoIcmsDoEstado(15.81)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(36.6)
      .ValorDoIpiDoItem(7.03)
      .ValorDoIva(1.55)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(87.84)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{147,05}, objFloatUtils.fStrToFloat('147,05')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{10,66}, objFloatUtils.fStrToFloat('10,66')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000117;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058570" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05047" AND DET_CODCLI = "00001447";
    DOCUMENTO: 000000058570
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001447
       ESTADO: SP
         ITEM: 05047
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(27)
      .ValorDoIcmsDoEstado(27)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(85.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.54)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(150)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{231}, objFloatUtils.fStrToFloat('231')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{14,58}, objFloatUtils.fStrToFloat('14,58')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000118;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058570" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05052" AND DET_CODCLI = "00001447";
    DOCUMENTO: 000000058570
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001447
       ESTADO: SP
         ITEM: 05052
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(63)
      .ValorDoIcmsDoEstado(63)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(151.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.54)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(350)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{539}, objFloatUtils.fStrToFloat('539')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{34,02}, objFloatUtils.fStrToFloat('34,02')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000119;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058570" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05446" AND DET_CODCLI = "00001447";
    DOCUMENTO: 000000058570
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001447
       ESTADO: SP
         ITEM: 05446
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(15.12)
      .ValorDoIcmsDoEstado(15.12)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(26.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(84)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000120;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058570" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05447" AND DET_CODCLI = "00001447";
    DOCUMENTO: 000000058570
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001447
       ESTADO: SP
         ITEM: 05447
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(30.24)
      .ValorDoIcmsDoEstado(30.24)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(52.75)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(168)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000121;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058571" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02444" AND DET_CODCLI = "00005712";
    DOCUMENTO: 000000058571
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005712
       ESTADO: AP
         ITEM: 02444
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(151.83)
      .ValorDoIcmsDoEstado(151.83)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1447.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2169)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000122;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058571" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05422" AND DET_CODCLI = "00005712";
    DOCUMENTO: 000000058571
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005712
       ESTADO: AP
         ITEM: 05422
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(54)
      .ValorDoIcmsDoEstado(54)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(666)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1350)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000123;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058572" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05047" AND DET_CODCLI = "00007090";
    DOCUMENTO: 000000058572
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007090
       ESTADO: SC
         ITEM: 05047
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(25)
      .ValorDoIcmsDoEstado(25)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(428.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(625)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000124;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058572" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05447" AND DET_CODCLI = "00007090";
    DOCUMENTO: 000000058572
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007090
       ESTADO: SC
         ITEM: 05447
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.6)
      .ValorDoIcmsDoEstado(5.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(52.75)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(140)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000125;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058572" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04870" AND DET_CODCLI = "00007090";
    DOCUMENTO: 000000058572
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007090
       ESTADO: SC
         ITEM: 04870
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.12)
      .ValorDoIcmsDoEstado(7.12)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(108.62)
      .ValorDoIpiDoItem(17.8)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(178)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000126;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058572" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05423" AND DET_CODCLI = "00007090";
    DOCUMENTO: 000000058572
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007090
       ESTADO: SC
         ITEM: 05423
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.41)
      .ValorDoIcmsDoEstado(5.41)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(36.41)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(135.3)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000127;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058573" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05047" AND DET_CODCLI = "00005572";
    DOCUMENTO: 000000058573
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005572
       ESTADO: MG
         ITEM: 05047
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(24)
      .ValorDoIcmsDoEstado(24)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(513.96)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(600)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{1018,56}, objFloatUtils.fStrToFloat('1018,56')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{159,34}, objFloatUtils.fStrToFloat('159,34')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000128;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058573" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05446" AND DET_CODCLI = "00005572";
    DOCUMENTO: 000000058573
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005572
       ESTADO: MG
         ITEM: 05446
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(7.68)
      .ValorDoIcmsDoEstado(7.68)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(79.12)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(192)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000129;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058573" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05447" AND DET_CODCLI = "00005572";
    DOCUMENTO: 000000058573
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005572
       ESTADO: MG
         ITEM: 05447
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(51.2)
      .ValorDoIcmsDoEstado(51.2)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(527.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1280)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000130;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058573" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05448" AND DET_CODCLI = "00005572";
    DOCUMENTO: 000000058573
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005572
       ESTADO: MG
         ITEM: 05448
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12.8)
      .ValorDoIcmsDoEstado(12.8)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(131.87)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(320)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000131;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058574" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04745" AND DET_CODCLI = "00007023";
    DOCUMENTO: 000000058574
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007023
       ESTADO: SP
         ITEM: 04745
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(230.77)
      .ValorDoIcmsDoEstado(219.78)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(810)
      .ValorDoIpiDoItem(61.05)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1221)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000132;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058574" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05052" AND DET_CODCLI = "00007023";
    DOCUMENTO: 000000058574
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007023
       ESTADO: SP
         ITEM: 05052
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(83.52)
      .ValorDoIcmsDoEstado(83.52)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(151.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(464)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000133;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058574" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02009" AND DET_CODCLI = "00007023";
    DOCUMENTO: 000000058574
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007023
       ESTADO: SP
         ITEM: 02009
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(97.49)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(114)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000134;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058574" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01930" AND DET_CODCLI = "00007023";
    DOCUMENTO: 000000058574
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007023
       ESTADO: SP
         ITEM: 01930
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(True)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(209.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(297)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000135;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058575" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03096" AND DET_CODCLI = "00004918";
    DOCUMENTO: 000000058575
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004918
       ESTADO: SP
         ITEM: 03096
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(297)
      .ValorDoIcmsDoEstado(297)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1170)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1650)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000136;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04744" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04744
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.27)
      .ValorDoIcmsDoEstado(5.27)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(84)
      .ValorDoIpiDoItem(6.59)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(131.7)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000137;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04858" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04858
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.84)
      .ValorDoIcmsDoEstado(2.84)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(42.2)
      .ValorDoIpiDoItem(3.55)
      .ValorDoIva(2.0111)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(71.05)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{150,03}, objFloatUtils.fStrToFloat('150,03')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{24,17}, objFloatUtils.fStrToFloat('24,17')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000138;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04859" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04859
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.54)
      .ValorDoIcmsDoEstado(1.54)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(28.62)
      .ValorDoIpiDoItem(1.92)
      .ValorDoIva(2.0111)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38.47)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{81,23}, objFloatUtils.fStrToFloat('81,23')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{13,08}, objFloatUtils.fStrToFloat('13,08')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000139;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05047" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05047
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(8)
      .ValorDoIcmsDoEstado(8)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(171.32)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(200)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{339,52}, objFloatUtils.fStrToFloat('339,52')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{53,11}, objFloatUtils.fStrToFloat('53,11')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000140;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05052" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05052
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(5.78)
      .ValorDoIcmsDoEstado(5.78)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(75.7)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(144.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{245,3}, objFloatUtils.fStrToFloat('245,3')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{38,37}, objFloatUtils.fStrToFloat('38,37')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000141;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04239" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04239
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.37)
      .ValorDoIcmsDoEstado(0.37)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(7.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9.36)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{16,98}, objFloatUtils.fStrToFloat('16,98')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{2,69}, objFloatUtils.fStrToFloat('2,69')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000142;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04216" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04216
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.54)
      .ValorDoIcmsDoEstado(0.54)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(6.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(13.48)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{24,46}, objFloatUtils.fStrToFloat('24,46')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{3,86}, objFloatUtils.fStrToFloat('3,86')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000143;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04217" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04217
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0.86)
      .ValorDoIcmsDoEstado(0.86)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(10.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(21.57)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{39,14}, objFloatUtils.fStrToFloat('39,14')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{6,19}, objFloatUtils.fStrToFloat('6,19')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000144;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04214" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04214
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.9)
      .ValorDoIcmsDoEstado(1.9)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(28.28)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(47.61)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{86,39}, objFloatUtils.fStrToFloat('86,39')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{13,65}, objFloatUtils.fStrToFloat('13,65')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000145;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04215" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04215
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.13)
      .ValorDoIcmsDoEstado(2.13)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(31.65)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(53.28)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{96,68}, objFloatUtils.fStrToFloat('96,68')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{15,27}, objFloatUtils.fStrToFloat('15,27')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000146;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04213" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04213
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.02)
      .ValorDoIcmsDoEstado(3.02)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(37.3)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.8146)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(75.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{137,18}, objFloatUtils.fStrToFloat('137,18')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{21,67}, objFloatUtils.fStrToFloat('21,67')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000147;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05054" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05054
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.93)
      .ValorDoIcmsDoEstado(4.93)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(62.68)
      .ValorDoIpiDoItem(9.85)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(123.15)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{225,78}, objFloatUtils.fStrToFloat('225,78')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{35,71}, objFloatUtils.fStrToFloat('35,71')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000148;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05454" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05454
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.05)
      .ValorDoIcmsDoEstado(3.05)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(43.88)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(76.2)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000149;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05242" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05242
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(6.74)
      .ValorDoIcmsDoEstado(6.74)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(71.58)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(168.49)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000150;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05375" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05375
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(12)
      .ValorDoIcmsDoEstado(12)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(145.63)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(300)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000151;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05304" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 05304
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1.54)
      .ValorDoIcmsDoEstado(1.54)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(19.05)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38.56)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{65,46}, objFloatUtils.fStrToFloat('65,46')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{10,24}, objFloatUtils.fStrToFloat('10,24')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000152;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058576" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04750" AND DET_CODCLI = "00006279";
    DOCUMENTO: 000000058576
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006279
       ESTADO: MG
         ITEM: 04750
         CFOP: 6403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(4.56)
      .ValorDoIcmsDoEstado(4.56)
      .AliquotaDaSubstituicaoTributariaDoItem(17)
      .TotalGeralDoItemPreUlt(62.34)
      .ValorDoIpiDoItem(17.1)
      .ValorDoIva(1.6976)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(114)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{222,56}, objFloatUtils.fStrToFloat('222,56')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{33,28}, objFloatUtils.fStrToFloat('33,27')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000153;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058577" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04513" AND DET_CODCLI = "00006936";
    DOCUMENTO: 000000058577
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006936
       ESTADO: MA
         ITEM: 04513
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.52)
      .ValorDoIcmsDoEstado(2.52)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(27.37)
      .ValorDoIpiDoItem(5.04)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(62.94)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000154;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058577" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04512" AND DET_CODCLI = "00006936";
    DOCUMENTO: 000000058577
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006936
       ESTADO: MA
         ITEM: 04512
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.76)
      .ValorDoIcmsDoEstado(2.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(28.77)
      .ValorDoIpiDoItem(5.52)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(68.94)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000155;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058577" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05377" AND DET_CODCLI = "00006936";
    DOCUMENTO: 000000058577
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006936
       ESTADO: MA
         ITEM: 05377
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(3.6)
      .ValorDoIcmsDoEstado(3.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(65.81)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(90)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000156;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058577" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05404" AND DET_CODCLI = "00006936";
    DOCUMENTO: 000000058577
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006936
       ESTADO: MA
         ITEM: 05404
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(43.08)
      .ValorDoIcmsDoEstado(43.08)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(645.52)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1077)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000157;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058577" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05459" AND DET_CODCLI = "00006936";
    DOCUMENTO: 000000058577
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006936
       ESTADO: MA
         ITEM: 05459
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.74)
      .ValorDoIcmsDoEstado(2.74)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(42.4)
      .ValorDoIpiDoItem(5.47)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(68.42)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000158;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058577" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04169" AND DET_CODCLI = "00006936";
    DOCUMENTO: 000000058577
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006936
       ESTADO: MA
         ITEM: 04169
         CFOP: 6102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(2.44)
      .ValorDoIcmsDoEstado(2.44)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(32.97)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(61.06)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000159;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058578" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05422" AND DET_CODCLI = "00005419";
    DOCUMENTO: 000000058578
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005419
       ESTADO: SP
         ITEM: 05422
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(45.09)
      .ValorDoIcmsDoEstado(45.09)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(111)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.54)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(250.5)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{385,77}, objFloatUtils.fStrToFloat('385,77')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{24,35}, objFloatUtils.fStrToFloat('24,35')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000160;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058578" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04214" AND DET_CODCLI = "00005419";
    DOCUMENTO: 000000058578
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00005419
       ESTADO: SP
         ITEM: 04214
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(57.02)
      .ValorDoIcmsDoEstado(57.02)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(169.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(1.7148)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(316.8)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{543,25}, objFloatUtils.fStrToFloat('543,25')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{40,77}, objFloatUtils.fStrToFloat('40,76')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000161;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058579" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05404" AND DET_CODCLI = "00004419";
    DOCUMENTO: 000000058579
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004419
       ESTADO: RO
         ITEM: 05404
         CFOP: 6910
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(13.2)
      .ValorDoIcmsDoEstado(13.2)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(215.17)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(330)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000162;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058580" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "04742" AND DET_CODCLI = "00006299";
    DOCUMENTO: 000000058580
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00006299
       ESTADO: SP
         ITEM: 04742
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(312.66)
      .ValorDoIcmsDoEstado(312.66)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(1062)
      .ValorDoIpiDoItem(86.85)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1737)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000163;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058581" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03096" AND DET_CODCLI = "00007084";
    DOCUMENTO: 000000058581
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007084
       ESTADO: SP
         ITEM: 03096
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(165.6)
      .ValorDoIcmsDoEstado(165.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(585)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(920)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000164;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058581" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05054" AND DET_CODCLI = "00007084";
    DOCUMENTO: 000000058581
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00007084
       ESTADO: SP
         ITEM: 05054
         CFOP: 5403
CODIGO FISCAL: 110
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(28.19)
      .ValorDoIcmsDoEstado(28.19)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(62.68)
      .ValorDoIpiDoItem(12.53)
      .ValorDoIva(1.53)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(156.6)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{258,77}, objFloatUtils.fStrToFloat('258,77')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{18,39}, objFloatUtils.fStrToFloat('18,39')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000165;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058582" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05443" AND DET_CODCLI = "00004917";
    DOCUMENTO: 000000058582
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00004917
       ESTADO: SP
         ITEM: 05443
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(1791)
      .ValorDoIcmsDoEstado(1791)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(5897.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(9950)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTITANIUMDOBRA.REGRA_ST_TITANIUMDOBRA_000166;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000058583" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03096" AND DET_CODCLI = "00000539";
    DOCUMENTO: 000000058583
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000539
       ESTADO: SP
         ITEM: 03096
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoST;
  AParametros: IParametrosCalculoST;
Begin

  AParametros :=
    TParametrosCalculoST.New()
      .VendaDentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .CalculaSubstituicaoTributariaSimples(True)
      .CalcularSTSomenteParaNaoConsumidorFinal(True)
      .ClienteConsumidorFinal(False)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(False)
      .UtilizaImportacaoDireta(True)
      .ItemImportacaoDireta(False)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(480.6)
      .ValorDoIcmsDoEstado(480.6)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1755)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2670)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CNC')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestTITANIUMDOBRA.Suite);
end.

