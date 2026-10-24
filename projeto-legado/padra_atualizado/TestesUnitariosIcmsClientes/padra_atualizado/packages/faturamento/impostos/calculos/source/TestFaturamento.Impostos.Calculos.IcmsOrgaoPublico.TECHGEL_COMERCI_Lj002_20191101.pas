unit TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TECHGEL_COMERCI_Lj002_20191101;

{--------------------------------------------------------------------------
                    RESUMO ICMSORGAOPUBLICO                 
--------------------------------------------------------------------------
Empresa            : 002 - TECHGEL COMERCIAL EIRELI - EPP
Período Selecionado: 01/11/2019 até 01/11/2019
Data do Processo   : 01/11/2019 
Hora Inicio        : 19:51:06
Hora Fim           : 19:52:32
Tempo Total        : 00:01:26
                                           
Total Registros    : 82
Total Processados  : 82
Total de Acertos   : 76
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 6
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
TestTECHGELCOMERCI = class(TTestCase)
strict private
private




published

Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000001;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000002;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000003;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000004;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000005;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000006;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000007;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000008;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000009;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000010;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000011;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000012;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000013;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000014;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000015;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000016;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000017;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000018;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000019;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000020;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000021;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000022;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000023;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000024;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000025;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000026;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000027;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000028;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000029;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000030;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000031;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000032;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000033;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000034;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000035;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000036;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000037;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000038;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000039;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000040;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000041;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000042;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000043;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000044;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000045;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000046;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000047;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000048;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000049;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000050;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000051;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000052;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000053;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000054;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000055;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000056;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000057;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000058;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000059;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000060;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000061;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000062;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000063;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000064;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000065;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000066;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000067;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000068;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000069;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000070;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000071;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000072;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000073;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000074;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000075;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000076;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestTECHGELCOMERCI.SetUp;
begin
end;

procedure TestTECHGELCOMERCI.TearDown;
begin
end;

Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02599" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 02599
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(583.6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02592" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 02592
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(875.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02596" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 02596
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(600)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03407" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 03407
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(389.2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04298" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 04298
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(4560)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00001" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 00001
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(291.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09088" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 09088
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1537)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025495" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00765" AND DET_CODCLI = "00005803";
    DOCUMENTO: 000000025495
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005803
       ESTADO: BA
         ITEM: 00765
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(2475)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025496" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00879" AND DET_CODCLI = "00004907";
    DOCUMENTO: 000000025496
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004907
       ESTADO: PR
         ITEM: 00879
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(76)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025496" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01543" AND DET_CODCLI = "00004907";
    DOCUMENTO: 000000025496
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004907
       ESTADO: PR
         ITEM: 01543
         CFOP: 6101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(312)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025497" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01336" AND DET_CODCLI = "00006829";
    DOCUMENTO: 000000025497
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006829
       ESTADO: SP
         ITEM: 01336
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(583.34)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000301" AND DET_ESPDOC = "NS" AND DET_CODEMP = "002" AND DET_CODITE = "10337" AND DET_CODCLI = "00003973";
    DOCUMENTO: 000000000301
      ESPECIE: NS
      EMPRESA: 002
      CLIENTE: 00003973
       ESTADO: PR
         ITEM: 10337
         CFOP: 6933
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VS}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VS')
      .ValorTotalDoItem(2500)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025498" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10124" AND DET_CODCLI = "00006094";
    DOCUMENTO: 000000025498
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006094
       ESTADO: SP
         ITEM: 10124
         CFOP: 5102
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(213.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(38.43)
      .AliquotaDeIcmsDoItem(18)
      .ClienteOrgaoPublico(True)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(True);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{213,5}, objFloatUtils.fStrToFloat('213,5')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{38,43}, objFloatUtils.fStrToFloat('38,43')));
end;


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002250" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "00639" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002250
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 00639
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
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
      .ValorTotalDoItem(35)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025499" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06073" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025499
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 06073
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(315)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025499" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06654" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025499
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 06654
         CFOP: 6102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(98.4)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('020')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(73.43)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025500" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01519" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025500
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 01519
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(220)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025500" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10445" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025500
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 10445
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(135)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025500" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02923" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025500
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 02923
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(360)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025501" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02430" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025501
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 02430
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(43)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025501" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06575" AND DET_CODCLI = "00004284";
    DOCUMENTO: 000000025501
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004284
       ESTADO: BA
         ITEM: 06575
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(132.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025502" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01543" AND DET_CODCLI = "00006801";
    DOCUMENTO: 000000025502
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006801
       ESTADO: SP
         ITEM: 01543
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(936)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025503" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01929" AND DET_CODCLI = "00006599";
    DOCUMENTO: 000000025503
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006599
       ESTADO: SP
         ITEM: 01929
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(52)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025503" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05466" AND DET_CODCLI = "00006599";
    DOCUMENTO: 000000025503
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006599
       ESTADO: SP
         ITEM: 05466
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(379)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025503" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06429" AND DET_CODCLI = "00006599";
    DOCUMENTO: 000000025503
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006599
       ESTADO: SP
         ITEM: 06429
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(868.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('020')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025503" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06658" AND DET_CODCLI = "00006599";
    DOCUMENTO: 000000025503
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006599
       ESTADO: SP
         ITEM: 06658
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(19.95)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025503" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09562" AND DET_CODCLI = "00006599";
    DOCUMENTO: 000000025503
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006599
       ESTADO: SP
         ITEM: 09562
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(18.25)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002251" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "02430" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002251
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 02430
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(25.4)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025504" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00216" AND DET_CODCLI = "00006920";
    DOCUMENTO: 000000025504
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006920
       ESTADO: SP
         ITEM: 00216
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(308.75)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025505" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10332" AND DET_CODCLI = "00001182";
    DOCUMENTO: 000000025505
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00001182
       ESTADO: SP
         ITEM: 10332
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1170)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025506" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05542" AND DET_CODCLI = "00004532";
    DOCUMENTO: 000000025506
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004532
       ESTADO: SP
         ITEM: 05542
         CFOP: 5102
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(278)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('020')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(66.67)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025507" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03849" AND DET_CODCLI = "00006659";
    DOCUMENTO: 000000025507
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006659
       ESTADO: SP
         ITEM: 03849
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
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
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025507" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04690" AND DET_CODCLI = "00006659";
    DOCUMENTO: 000000025507
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006659
       ESTADO: SP
         ITEM: 04690
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
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
      .ValorTotalDoItem(120)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025508" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09356" AND DET_CODCLI = "00006430";
    DOCUMENTO: 000000025508
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006430
       ESTADO: SP
         ITEM: 09356
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(420)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025508" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00764" AND DET_CODCLI = "00006430";
    DOCUMENTO: 000000025508
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006430
       ESTADO: SP
         ITEM: 00764
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(510)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025509" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01870" AND DET_CODCLI = "00000551";
    DOCUMENTO: 000000025509
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000551
       ESTADO: MG
         ITEM: 01870
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(640)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025509" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06578" AND DET_CODCLI = "00000551";
    DOCUMENTO: 000000025509
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000551
       ESTADO: MG
         ITEM: 06578
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(228)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025510" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09640" AND DET_CODCLI = "00003238";
    DOCUMENTO: 000000025510
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003238
       ESTADO: SP
         ITEM: 09640
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1060)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002252" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "01412" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002252
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 01412
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
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
      .ValorTotalDoItem(12.26)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002252" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "01827" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002252
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 01827
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(8.01)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002252" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "08036" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002252
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 08036
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(1.91)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002252" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "08508" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002252
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 08508
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(43.24)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002252" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "04794" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002252
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 04794
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
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
      .ValorTotalDoItem(29.7)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025511" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00871" AND DET_CODCLI = "00003979";
    DOCUMENTO: 000000025511
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003979
       ESTADO: RJ
         ITEM: 00871
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(95)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025511" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10118" AND DET_CODCLI = "00003979";
    DOCUMENTO: 000000025511
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003979
       ESTADO: RJ
         ITEM: 10118
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(85)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002253" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "10001" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002253
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 10001
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(19.5)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002253" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "09335" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002253
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 09335
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
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
      .ValorTotalDoItem(48.61)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002253" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "10726" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002253
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 10726
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 01/11/2019
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
      .ValorTotalDoItem(8)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025513" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00216" AND DET_CODCLI = "00006507";
    DOCUMENTO: 000000025513
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006507
       ESTADO: SP
         ITEM: 00216
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1000)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025514" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03849" AND DET_CODCLI = "00006924";
    DOCUMENTO: 000000025514
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006924
       ESTADO: SP
         ITEM: 03849
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(70)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000302" AND DET_ESPDOC = "NS" AND DET_CODEMP = "002" AND DET_CODITE = "10337" AND DET_CODCLI = "00005129";
    DOCUMENTO: 000000000302
      ESPECIE: NS
      EMPRESA: 002
      CLIENTE: 00005129
       ESTADO: SP
         ITEM: 10337
         CFOP: 5933
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: VS}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('VS')
      .ValorTotalDoItem(392)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025515" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09742" AND DET_CODCLI = "00003084";
    DOCUMENTO: 000000025515
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003084
       ESTADO: SP
         ITEM: 09742
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1800)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025515" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09742" AND DET_CODCLI = "00003084";
    DOCUMENTO: 000000025515
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003084
       ESTADO: SP
         ITEM: 09742
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1350)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025516" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01711" AND DET_CODCLI = "00004368";
    DOCUMENTO: 000000025516
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004368
       ESTADO: SP
         ITEM: 01711
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(264.6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000055;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025516" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06459" AND DET_CODCLI = "00004368";
    DOCUMENTO: 000000025516
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004368
       ESTADO: SP
         ITEM: 06459
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(22.2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000056;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025516" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "07627" AND DET_CODCLI = "00004368";
    DOCUMENTO: 000000025516
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004368
       ESTADO: SP
         ITEM: 07627
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(86.7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000057;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025517" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00417" AND DET_CODCLI = "00003750";
    DOCUMENTO: 000000025517
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003750
       ESTADO: ES
         ITEM: 00417
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(288.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000058;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025517" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00674" AND DET_CODCLI = "00003750";
    DOCUMENTO: 000000025517
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003750
       ESTADO: ES
         ITEM: 00674
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(355.79)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000059;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025517" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02599" AND DET_CODCLI = "00003750";
    DOCUMENTO: 000000025517
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003750
       ESTADO: ES
         ITEM: 02599
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(596.74)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000060;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025517" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03325" AND DET_CODCLI = "00003750";
    DOCUMENTO: 000000025517
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003750
       ESTADO: ES
         ITEM: 03325
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(155.2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000061;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025517" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03326" AND DET_CODCLI = "00003750";
    DOCUMENTO: 000000025517
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003750
       ESTADO: ES
         ITEM: 03326
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(106.7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000062;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025517" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00767" AND DET_CODCLI = "00003750";
    DOCUMENTO: 000000025517
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003750
       ESTADO: ES
         ITEM: 00767
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(911.8)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000063;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025518" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02592" AND DET_CODCLI = "00006091";
    DOCUMENTO: 000000025518
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006091
       ESTADO: RJ
         ITEM: 02592
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(140)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000064;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025518" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04298" AND DET_CODCLI = "00006091";
    DOCUMENTO: 000000025518
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006091
       ESTADO: RJ
         ITEM: 04298
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1180)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000065;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025519" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03849" AND DET_CODCLI = "00003546";
    DOCUMENTO: 000000025519
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003546
       ESTADO: SP
         ITEM: 03849
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(35)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000066;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025519" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05109" AND DET_CODCLI = "00003546";
    DOCUMENTO: 000000025519
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00003546
       ESTADO: SP
         ITEM: 05109
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(84.5)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000067;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025520" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00879" AND DET_CODCLI = "00004281";
    DOCUMENTO: 000000025520
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004281
       ESTADO: SP
         ITEM: 00879
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(79.59)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000068;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025520" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10118" AND DET_CODCLI = "00004281";
    DOCUMENTO: 000000025520
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004281
       ESTADO: SP
         ITEM: 10118
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(79.43)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000069;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025520" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09994" AND DET_CODCLI = "00004281";
    DOCUMENTO: 000000025520
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004281
       ESTADO: SP
         ITEM: 09994
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(78.63)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000070;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025520" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01543" AND DET_CODCLI = "00004281";
    DOCUMENTO: 000000025520
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004281
       ESTADO: SP
         ITEM: 01543
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(312)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000071;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025521" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02599" AND DET_CODCLI = "00004446";
    DOCUMENTO: 000000025521
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004446
       ESTADO: PR
         ITEM: 02599
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(132)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000072;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025521" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03407" AND DET_CODCLI = "00004446";
    DOCUMENTO: 000000025521
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004446
       ESTADO: PR
         ITEM: 03407
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(25)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000073;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025521" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10635" AND DET_CODCLI = "00004446";
    DOCUMENTO: 000000025521
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004446
       ESTADO: PR
         ITEM: 10635
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1560)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000074;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025521" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06274" AND DET_CODCLI = "00004446";
    DOCUMENTO: 000000025521
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004446
       ESTADO: PR
         ITEM: 06274
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(144)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000075;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025521" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "09088" AND DET_CODCLI = "00004446";
    DOCUMENTO: 000000025521
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004446
       ESTADO: PR
         ITEM: 09088
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(180)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000076;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025522" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10101" AND DET_CODCLI = "00006500";
    DOCUMENTO: 000000025522
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006500
       ESTADO: SP
         ITEM: 10101
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 01/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(856)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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
  RegisterTest(TestTECHGELCOMERCI.Suite);
end.

