unit TestFaturamento.Impostos.Calculos.St.GLOBALCOLOR_20191021;

{--------------------------------------------------------------------------
                    RESUMO ST                 
--------------------------------------------------------------------------
Empresa            : 001 - GLOBALCOLOR
Período Selecionado: 21/10/2019 até 21/10/2019
Data do Processo   : 22/10/2019 
Hora Inicio        : 11:42:38
Hora Fim           : 11:46:25
Tempo Total        : 00:03:46
                                           
Total Registros    : 272
Total Processados  : 272
Total de Acertos   : 81
Total de Erros     : 24
Total Ignorados    : 149
Total Duplicados   : 18
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
TestGLOBALCOLOR = class(TTestCase)
strict private
private




published

Procedure REGRA_ST_GLOBALCOLOR_000001;
Procedure REGRA_ST_GLOBALCOLOR_000002;
Procedure REGRA_ST_GLOBALCOLOR_000003;
Procedure REGRA_ST_GLOBALCOLOR_000004;
Procedure REGRA_ST_GLOBALCOLOR_000005;
Procedure REGRA_ST_GLOBALCOLOR_000006;
Procedure REGRA_ST_GLOBALCOLOR_000007;
Procedure REGRA_ST_GLOBALCOLOR_000008;
Procedure REGRA_ST_GLOBALCOLOR_000009;
Procedure REGRA_ST_GLOBALCOLOR_000010;
Procedure REGRA_ST_GLOBALCOLOR_000011;
Procedure REGRA_ST_GLOBALCOLOR_000012;
Procedure REGRA_ST_GLOBALCOLOR_000013;
Procedure REGRA_ST_GLOBALCOLOR_000014;
Procedure REGRA_ST_GLOBALCOLOR_000015;
Procedure REGRA_ST_GLOBALCOLOR_000016;
Procedure REGRA_ST_GLOBALCOLOR_000017;
Procedure REGRA_ST_GLOBALCOLOR_000018;
Procedure REGRA_ST_GLOBALCOLOR_000019;
Procedure REGRA_ST_GLOBALCOLOR_000020;
Procedure REGRA_ST_GLOBALCOLOR_000021;
Procedure REGRA_ST_GLOBALCOLOR_000022;
Procedure REGRA_ST_GLOBALCOLOR_000023;
Procedure REGRA_ST_GLOBALCOLOR_000024;
Procedure REGRA_ST_GLOBALCOLOR_000025;
Procedure REGRA_ST_GLOBALCOLOR_000026;
Procedure REGRA_ST_GLOBALCOLOR_000027;
Procedure REGRA_ST_GLOBALCOLOR_000028;
Procedure REGRA_ST_GLOBALCOLOR_000029;
Procedure REGRA_ST_GLOBALCOLOR_000030;
Procedure REGRA_ST_GLOBALCOLOR_000031;
Procedure REGRA_ST_GLOBALCOLOR_000032;
Procedure REGRA_ST_GLOBALCOLOR_000033;
Procedure REGRA_ST_GLOBALCOLOR_000034;
Procedure REGRA_ST_GLOBALCOLOR_000035;
Procedure REGRA_ST_GLOBALCOLOR_000036;
Procedure REGRA_ST_GLOBALCOLOR_000037;
Procedure REGRA_ST_GLOBALCOLOR_000038;
Procedure REGRA_ST_GLOBALCOLOR_000039;
Procedure REGRA_ST_GLOBALCOLOR_000040;
Procedure REGRA_ST_GLOBALCOLOR_000041;
Procedure REGRA_ST_GLOBALCOLOR_000042;
Procedure REGRA_ST_GLOBALCOLOR_000043;
Procedure REGRA_ST_GLOBALCOLOR_000044;
Procedure REGRA_ST_GLOBALCOLOR_000045;
Procedure REGRA_ST_GLOBALCOLOR_000046;
Procedure REGRA_ST_GLOBALCOLOR_000047;
Procedure REGRA_ST_GLOBALCOLOR_000048;
Procedure REGRA_ST_GLOBALCOLOR_000049;
Procedure REGRA_ST_GLOBALCOLOR_000050;
Procedure REGRA_ST_GLOBALCOLOR_000051;
Procedure REGRA_ST_GLOBALCOLOR_000052;
Procedure REGRA_ST_GLOBALCOLOR_000053;
Procedure REGRA_ST_GLOBALCOLOR_000054;
Procedure REGRA_ST_GLOBALCOLOR_000055;
Procedure REGRA_ST_GLOBALCOLOR_000056;
Procedure REGRA_ST_GLOBALCOLOR_000057;
Procedure REGRA_ST_GLOBALCOLOR_000058;
Procedure REGRA_ST_GLOBALCOLOR_000059;
Procedure REGRA_ST_GLOBALCOLOR_000060;
Procedure REGRA_ST_GLOBALCOLOR_000061;
Procedure REGRA_ST_GLOBALCOLOR_000062;
Procedure REGRA_ST_GLOBALCOLOR_000063;
Procedure REGRA_ST_GLOBALCOLOR_000064;
Procedure REGRA_ST_GLOBALCOLOR_000065;
Procedure REGRA_ST_GLOBALCOLOR_000066;
Procedure REGRA_ST_GLOBALCOLOR_000067;
Procedure REGRA_ST_GLOBALCOLOR_000068;
Procedure REGRA_ST_GLOBALCOLOR_000069;
Procedure REGRA_ST_GLOBALCOLOR_000070;
Procedure REGRA_ST_GLOBALCOLOR_000071;
Procedure REGRA_ST_GLOBALCOLOR_000072;
Procedure REGRA_ST_GLOBALCOLOR_000073;
Procedure REGRA_ST_GLOBALCOLOR_000074;
Procedure REGRA_ST_GLOBALCOLOR_000075;
Procedure REGRA_ST_GLOBALCOLOR_000076;
Procedure REGRA_ST_GLOBALCOLOR_000077;
Procedure REGRA_ST_GLOBALCOLOR_000078;
Procedure REGRA_ST_GLOBALCOLOR_000079;
Procedure REGRA_ST_GLOBALCOLOR_000080;
Procedure REGRA_ST_GLOBALCOLOR_000081;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestGLOBALCOLOR.SetUp;
begin
end;

procedure TestGLOBALCOLOR.TearDown;
begin
end;

Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038722" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038722
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.67)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038722" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038722
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.36)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038722" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10780" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038722
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10780
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038722" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038722
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.19)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038723" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10276" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038723
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10276
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(3.43)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038723" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10000" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038723
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10000
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(4.48)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038724" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038724
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.18)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038724" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038724
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.14)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038724" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038724
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.08)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038725" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038725
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.25)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038725" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038725
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.2)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038725" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038725
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.11)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038726" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10296" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038726
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10296
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(655.62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038726" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038726
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.9)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038726" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038726
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.72)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038726" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038726
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000005610" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "001" AND DET_CODITE = "14380" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000005610
      ESPECIE: AJ
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 14380
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(64.58)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(64.58)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038727" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10296" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038727
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10296
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(21.06)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038727" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038727
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.12)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038727" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038727
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.15)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038727" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038727
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.03)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038728" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038728
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.05)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038728" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038728
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.02)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038728" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038728
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.01)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038729" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10425" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038729
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10425
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(44.39)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038729" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038729
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.04)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038730" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038730
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.06)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038731" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10296" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038731
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10296
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(131.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038732" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10296" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038732
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10296
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(9.51)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038732" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038732
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038735" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10276" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038735
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10276
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(352.66)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038735" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038735
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038735" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038735
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.12)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038735" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10780" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038735
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10780
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1.68)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038735" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038735
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.62)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038736" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038736
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.75)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038736" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038736
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038736" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "16055" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038736
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 16055
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.33)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038737" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10724" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038737
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10724
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.16)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038739" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10748" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038739
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10748
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.96)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038739" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10757" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038739
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10757
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.5)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038740" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10296" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038740
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10296
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(22)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "038740" AND DET_ESPDOC = "OI" AND DET_CODEMP = "001" AND DET_CODITE = "10776" AND DET_CODCLI = "00000001";
    DOCUMENTO: 038740
      ESPECIE: OI
      EMPRESA: 001
      CLIENTE: 00000001
       ESTADO: 
         ITEM: 10776
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 21/10/2019
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
      .ItemImportacaoDireta(True)
      .CalculaBeneficioReducaoBaseIcmsST(False)
      .SimplesNacional(False)
      .ValorDoIcmsDoItem(0)
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(0.23)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(0)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_TRS')
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035467" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12057" AND DET_CODCLI = "00000739";
    DOCUMENTO: 000000035467
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000739
       ESTADO: SP
         ITEM: 12057
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(29.9)
      .ValorDoIcmsDoEstado(29.9)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(79.04)
      .ValorDoIpiDoItem(16.61)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(166.12)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035467" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12044" AND DET_CODCLI = "00000739";
    DOCUMENTO: 000000035467
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000739
       ESTADO: SP
         ITEM: 12044
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(56.36)
      .ValorDoIcmsDoEstado(56.36)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(180.7)
      .ValorDoIpiDoItem(31.31)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(313.1)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035468" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00144" AND DET_CODCLI = "00001339";
    DOCUMENTO: 000000035468
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001339
       ESTADO: SP
         ITEM: 00144
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(3.24)
      .ValorDoIcmsDoEstado(3.24)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(12.84)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(18)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035468" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01129" AND DET_CODCLI = "00001339";
    DOCUMENTO: 000000035468
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001339
       ESTADO: SP
         ITEM: 01129
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(4.31)
      .ValorDoIcmsDoEstado(4.31)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(17.1)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(23.94)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035468" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00309" AND DET_CODCLI = "00001339";
    DOCUMENTO: 000000035468
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001339
       ESTADO: SP
         ITEM: 00309
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(27.27)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(38.19)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035468" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12042" AND DET_CODCLI = "00001339";
    DOCUMENTO: 000000035468
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001339
       ESTADO: SP
         ITEM: 12042
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(29.76)
      .ValorDoIcmsDoEstado(29.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(83.79)
      .ValorDoIpiDoItem(16.53)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(165.33)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035469" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12051" AND DET_CODCLI = "00000294";
    DOCUMENTO: 000000035469
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000294
       ESTADO: SP
         ITEM: 12051
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(347.03)
      .ValorDoIcmsDoEstado(347.03)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(998.74)
      .ValorDoIpiDoItem(192.8)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1927.97)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035470" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15960" AND DET_CODCLI = "00001378";
    DOCUMENTO: 000000035470
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001378
       ESTADO: SP
         ITEM: 15960
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(22.6)
      .ValorDoIcmsDoEstado(21.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(39.6)
      .ValorDoIpiDoItem(5.98)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(119.59)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035470" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19845" AND DET_CODCLI = "00001378";
    DOCUMENTO: 000000035470
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001378
       ESTADO: SP
         ITEM: 19845
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(40.54)
      .ValorDoIcmsDoEstado(38.61)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(68.32)
      .ValorDoIpiDoItem(10.73)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(214.5)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035470" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00308" AND DET_CODCLI = "00001378";
    DOCUMENTO: 000000035470
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001378
       ESTADO: SP
         ITEM: 00308
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .TotalGeralDoItemPreUlt(109.08)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(152.76)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035471" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12052" AND DET_CODCLI = "00000488";
    DOCUMENTO: 000000035471
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000488
       ESTADO: SP
         ITEM: 12052
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(92.12)
      .ValorDoIcmsDoEstado(92.12)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(300.75)
      .ValorDoIpiDoItem(51.18)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(511.8)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035473" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00740" AND DET_CODCLI = "00001402";
    DOCUMENTO: 000000035473
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00001402
       ESTADO: SP
         ITEM: 00740
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(4.14)
      .ValorDoIcmsDoEstado(4.14)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(14.4)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(23)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035474" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "15478" AND DET_CODCLI = "00002736";
    DOCUMENTO: 000000035474
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00002736
       ESTADO: SP
         ITEM: 15478
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(17.75)
      .ValorDoIcmsDoEstado(16.9)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(31)
      .ValorDoIpiDoItem(4.7)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(93.91)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035475" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13378" AND DET_CODCLI = "00002441";
    DOCUMENTO: 000000035475
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00002441
       ESTADO: SP
         ITEM: 13378
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(73.2)
      .ValorDoIcmsDoEstado(69.71)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(203.52)
      .ValorDoIpiDoItem(19.37)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(387.3)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035476" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14580" AND DET_CODCLI = "00003002";
    DOCUMENTO: 000000035476
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003002
       ESTADO: SP
         ITEM: 14580
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(201.47)
      .ValorDoIcmsDoEstado(191.88)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(597.2)
      .ValorDoIpiDoItem(53.3)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1066)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035476" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19573" AND DET_CODCLI = "00003002";
    DOCUMENTO: 000000035476
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003002
       ESTADO: SP
         ITEM: 19573
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(459.27)
      .ValorDoIcmsDoEstado(437.4)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1068.6)
      .ValorDoIpiDoItem(121.5)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(2430)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035476" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19701" AND DET_CODCLI = "00003002";
    DOCUMENTO: 000000035476
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003002
       ESTADO: SP
         ITEM: 19701
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(211.85)
      .ValorDoIcmsDoEstado(201.76)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(525)
      .ValorDoIpiDoItem(56.05)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1120.9)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035477" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18266" AND DET_CODCLI = "00003609";
    DOCUMENTO: 000000035477
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003609
       ESTADO: SP
         ITEM: 18266
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(711.15)
      .ValorDoIcmsDoEstado(711.15)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(1318.8)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(3950.82)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035477" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14571" AND DET_CODCLI = "00003609";
    DOCUMENTO: 000000035477
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003609
       ESTADO: SP
         ITEM: 14571
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(33.08)
      .ValorDoIcmsDoEstado(33.08)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(96.82)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(183.8)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035477" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13035" AND DET_CODCLI = "00003609";
    DOCUMENTO: 000000035477
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003609
       ESTADO: SP
         ITEM: 13035
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(13.36)
      .ValorDoIcmsDoEstado(12.72)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(33.81)
      .ValorDoIpiDoItem(3.53)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(70.68)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035477" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13082" AND DET_CODCLI = "00003609";
    DOCUMENTO: 000000035477
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003609
       ESTADO: SP
         ITEM: 13082
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(13.99)
      .ValorDoIcmsDoEstado(13.32)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(36.52)
      .ValorDoIpiDoItem(3.7)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(74.01)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035477" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01212" AND DET_CODCLI = "00003609";
    DOCUMENTO: 000000035477
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003609
       ESTADO: SP
         ITEM: 01212
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(5.55)
      .ValorDoIcmsDoEstado(5.55)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(20.56)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(30.84)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035478" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16950" AND DET_CODCLI = "00000638";
    DOCUMENTO: 000000035478
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000638
       ESTADO: SP
         ITEM: 16950
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(231.21)
      .ValorDoIcmsDoEstado(231.21)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(541.23)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1284.48)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035478" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16851" AND DET_CODCLI = "00000638";
    DOCUMENTO: 000000035478
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000638
       ESTADO: SP
         ITEM: 16851
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(262.65)
      .ValorDoIcmsDoEstado(262.65)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(600.24)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1459.16)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035479" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14598" AND DET_CODCLI = "00003605";
    DOCUMENTO: 000000035479
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003605
       ESTADO: SP
         ITEM: 14598
         CFOP: 5401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(69.09)
      .ValorDoIcmsDoEstado(69.09)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(174.45)
      .ValorDoIpiDoItem(19.19)
      .ValorDoIva(1.58)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(383.85)
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
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{636,8}, objFloatUtils.fStrToFloat('636,8')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{45,53}, objFloatUtils.fStrToFloat('45,53')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035479" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12057" AND DET_CODCLI = "00003605";
    DOCUMENTO: 000000035479
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003605
       ESTADO: SP
         ITEM: 12057
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(14.95)
      .ValorDoIcmsDoEstado(14.95)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(39.52)
      .ValorDoIpiDoItem(8.31)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(83.06)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035480" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20159" AND DET_CODCLI = "00003605";
    DOCUMENTO: 000000035480
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003605
       ESTADO: SP
         ITEM: 20159
         CFOP: 5401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(325.51)
      .ValorDoIcmsDoEstado(325.51)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(792.9)
      .ValorDoIpiDoItem(90.42)
      .ValorDoIva(1.58)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(100)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1808.4)
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
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{3000,14}, objFloatUtils.fStrToFloat('3000,14')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{214,52}, objFloatUtils.fStrToFloat('214,51')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{100}, objFloatUtils.fStrToFloat('100')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035481" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16513" AND DET_CODCLI = "00000954";
    DOCUMENTO: 000000035481
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000954
       ESTADO: SP
         ITEM: 16513
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(3.74)
      .ValorDoIcmsDoEstado(3.74)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(11.6)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(20.8)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035481" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00042" AND DET_CODCLI = "00000954";
    DOCUMENTO: 000000035481
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000954
       ESTADO: SP
         ITEM: 00042
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(5.29)
      .ValorDoIcmsDoEstado(5.29)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(21)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(29.4)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035481" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00309" AND DET_CODCLI = "00000954";
    DOCUMENTO: 000000035481
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000954
       ESTADO: SP
         ITEM: 00309
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoEstado(0)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(136.35)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(190.95)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035481" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12052" AND DET_CODCLI = "00000954";
    DOCUMENTO: 000000035481
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000954
       ESTADO: SP
         ITEM: 12052
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(70.53)
      .ValorDoIcmsDoEstado(70.53)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(200.5)
      .ValorDoIpiDoItem(39.18)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(391.84)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14532" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 14532
         CFOP: 6401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: 11}

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
      .ValorDoIcmsDoItem(54.44)
      .ValorDoIcmsDoEstado(54.44)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(136.37)
      .ValorDoIpiDoItem(0)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(121.95)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(453.67)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(True)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{553,25}, objFloatUtils.fStrToFloat('553,25')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{33,2}, objFloatUtils.fStrToFloat('33,2')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{121,95}, objFloatUtils.fStrToFloat('121,95')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14595" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 14595
         CFOP: 6401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: 11}

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
      .ValorDoIcmsDoItem(41.32)
      .ValorDoIcmsDoEstado(39.36)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(117.48)
      .ValorDoIpiDoItem(16.4)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(121.95)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(327.96)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(True)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{419,95}, objFloatUtils.fStrToFloat('419,95')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{25,2}, objFloatUtils.fStrToFloat('25,2')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{121,95}, objFloatUtils.fStrToFloat('121,95')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000077;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18550" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 18550
         CFOP: 6401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: 11}

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
      .ValorDoIcmsDoItem(17.97)
      .ValorDoIcmsDoEstado(17.11)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(51.06)
      .ValorDoIpiDoItem(7.13)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(121.95)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(142.62)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(True)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{182,62}, objFloatUtils.fStrToFloat('182,62')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{10,96}, objFloatUtils.fStrToFloat('10,96')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{121,95}, objFloatUtils.fStrToFloat('121,95')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000078;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12057" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 12057
         CFOP: 6101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
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
      .ValorDoIcmsDoItem(15.13)
      .ValorDoIcmsDoEstado(13.75)
      .AliquotaDaSubstituicaoTributariaDoItem(0)
      .TotalGeralDoItemPreUlt(39.52)
      .ValorDoIpiDoItem(11.46)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(0)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(114.61)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(False)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000079;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11576" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 11576
         CFOP: 6401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: 11}

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
      .ValorDoIcmsDoItem(132.77)
      .ValorDoIcmsDoEstado(126.45)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(424.72)
      .ValorDoIpiDoItem(52.69)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(121.95)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(1053.76)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(True)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{1349,32}, objFloatUtils.fStrToFloat('1349,32')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{80,96}, objFloatUtils.fStrToFloat('80,96')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{121,95}, objFloatUtils.fStrToFloat('121,95')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000080;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11752" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 11752
         CFOP: 6401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: 11}

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
      .ValorDoIcmsDoItem(69.09)
      .ValorDoIcmsDoEstado(65.8)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(225.04)
      .ValorDoIpiDoItem(27.42)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(121.95)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(548.32)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(True)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{702,11}, objFloatUtils.fStrToFloat('702,11')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{42,13}, objFloatUtils.fStrToFloat('42,13')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{121,95}, objFloatUtils.fStrToFloat('121,95')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestGLOBALCOLOR.REGRA_ST_GLOBALCOLOR_000081;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035482" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18547" AND DET_CODCLI = "00003544";
    DOCUMENTO: 000000035482
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003544
       ESTADO: PR
         ITEM: 18547
         CFOP: 6401
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 21/10/2019
   AUX_OPCDOC: 11}

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
      .ValorDoIcmsDoItem(80.82)
      .ValorDoIcmsDoEstado(76.97)
      .AliquotaDaSubstituicaoTributariaDoItem(18)
      .TotalGeralDoItemPreUlt(250.74)
      .ValorDoIpiDoItem(32.07)
      .ValorDoIva(0)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(True)
      .PercentualDaBaseDeCalculoDaSTDoItem(121.95)
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(2)
      .TotalGeralDoItem(641.4)
      .UtilizaAmpara(False)
      .EncontrouAbreviacaoDeIcms(False)
      .AmparaAliquotaFCP(0)
      .TipoDeAbreviacaoFiscal('_SAI_CCO')
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .CalculaSubstituicaoTributariaPorDentro(True)
      .ContribuinteDeIpi(True)
      .ClienteIVAEspecialMT(False)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True);

  ReturnValue := TCalculoImpostosST.New.CalcularValorST(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{821,3}, objFloatUtils.fStrToFloat('821,3')) And
           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{49,28}, objFloatUtils.fStrToFloat('49,28')) And
           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{121,95}, objFloatUtils.fStrToFloat('121,95')) And
           CompararValores(ReturnValue.PercentualDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestGLOBALCOLOR.Suite);
end.

