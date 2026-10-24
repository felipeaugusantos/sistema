unit TestFaturamento.Impostos.Calculos.IPI.TECHGEL_COMERCI_20191024;

{--------------------------------------------------------------------------
                    RESUMO IPI                 
--------------------------------------------------------------------------
Empresa            : 002 - TECHGEL COMERCIAL EIRELI - EPP
Período Selecionado: 24/10/2019 até 24/10/2019
Data do Processo   : 24/10/2019 
Hora Inicio        : 19:44:26
Hora Fim           : 19:44:40
Tempo Total        : 00:00:13
                                           
Total Registros    : 66
Total Processados  : 66
Total de Acertos   : 7
Total de Erros     : 0
Total Ignorados    : 2
Total Duplicados   : 57
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.IPI,
Faturamento.Impostos.Tipos.IPI,
Faturamento.Impostos.Interfaces.IPI;

type
TestTECHGELCOMERCI = class(TTestCase)
strict private
private




published

Procedure CALCULO_IPI__TECHGELCOMERCI_000001;
Procedure CALCULO_IPI__TECHGELCOMERCI_000002;
Procedure CALCULO_IPI__TECHGELCOMERCI_000003;
Procedure CALCULO_IPI__TECHGELCOMERCI_000004;
Procedure CALCULO_IPI__TECHGELCOMERCI_000005;
Procedure CALCULO_IPI__TECHGELCOMERCI_000006;
Procedure CALCULO_IPI__TECHGELCOMERCI_000007;


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

Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025392" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06993" AND DET_CODCLI = "00005938";
    DOCUMENTO: 000000025392
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005938
       ESTADO: SP
         ITEM: 06993
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(True)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(0)
      .AliquotaDeCalculoIPI(0);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01543" AND DET_CODCLI = "00006850";
    DOCUMENTO: 000000025396
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006850
       ESTADO: SP
         ITEM: 01543
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(True)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(365)
      .AliquotaDeCalculoIPI(10);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{36,5}, objFloatUtils.fStrToFloat('36,5')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{365}, objFloatUtils.fStrToFloat('365')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{10}, objFloatUtils.fStrToFloat('10')));
end;


Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04272" AND DET_CODCLI = "00006850";
    DOCUMENTO: 000000025396
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006850
       ESTADO: SP
         ITEM: 04272
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(True)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(427.4)
      .AliquotaDeCalculoIPI(5);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{21,37}, objFloatUtils.fStrToFloat('21,37')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{427,4}, objFloatUtils.fStrToFloat('427,4')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{5}, objFloatUtils.fStrToFloat('5')));
end;


Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01870" AND DET_CODCLI = "00006850";
    DOCUMENTO: 000000025396
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006850
       ESTADO: SP
         ITEM: 01870
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(True)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(276)
      .AliquotaDeCalculoIPI(5);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{13,8}, objFloatUtils.fStrToFloat('13,8')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{276}, objFloatUtils.fStrToFloat('276')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{5}, objFloatUtils.fStrToFloat('5')));
end;


Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025396" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06578" AND DET_CODCLI = "00006850";
    DOCUMENTO: 000000025396
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006850
       ESTADO: SP
         ITEM: 06578
         CFOP: 5101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(True)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(95)
      .AliquotaDeCalculoIPI(5);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{4,75}, objFloatUtils.fStrToFloat('4,75')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{95}, objFloatUtils.fStrToFloat('95')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{5}, objFloatUtils.fStrToFloat('5')));
end;


Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025398" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00871" AND DET_CODCLI = "00006825";
    DOCUMENTO: 000000025398
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006825
       ESTADO: MG
         ITEM: 00871
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(False)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(0)
      .AliquotaDeCalculoIPI(0);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTECHGELCOMERCI.CALCULO_IPI__TECHGELCOMERCI_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025407" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00216" AND DET_CODCLI = "00006462";
    DOCUMENTO: 000000025407
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006462
       ESTADO: RO
         ITEM: 00216
         CFOP: 6110
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 24/10/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(True)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(False)
      .ClienteDoExterior(False)
      .SituacaoTributariaIPI('S')
      .BaseDoIpi(0)
      .AliquotaDeCalculoIPI(0);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')));
end;




initialization
  RegisterTest(TestTECHGELCOMERCI.Suite);
end.

