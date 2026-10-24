unit TestFaturamento.Impostos.Calculos.IPI.REFRIGAS__SAO_20191017;

{--------------------------------------------------------------------------
                    RESUMO IPI                 
--------------------------------------------------------------------------
Empresa            : 002 - REFRIGÁS - SÃO CARLOS
Período Selecionado: 17/10/2019 até 17/10/2019
Data do Processo   : 18/10/2019 
Hora Inicio        : 16:30:14
Hora Fim           : 16:31:20
Tempo Total        : 00:01:06
                                           
Total Registros    : 248
Total Processados  : 248
Total de Acertos   : 10
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 238
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
TestREFRIGASSAO = class(TTestCase)
strict private
private




published

Procedure CALCULO_IPI__REFRIGASSAO_000001;
Procedure CALCULO_IPI__REFRIGASSAO_000002;
Procedure CALCULO_IPI__REFRIGASSAO_000003;
Procedure CALCULO_IPI__REFRIGASSAO_000004;
Procedure CALCULO_IPI__REFRIGASSAO_000005;
Procedure CALCULO_IPI__REFRIGASSAO_000006;
Procedure CALCULO_IPI__REFRIGASSAO_000007;
Procedure CALCULO_IPI__REFRIGASSAO_000008;
Procedure CALCULO_IPI__REFRIGASSAO_000009;
Procedure CALCULO_IPI__REFRIGASSAO_000010;
Procedure CALCULO_IPI__REFRIGASSAO_000011_FEITO_MANUALMENTE;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestREFRIGASSAO.SetUp;
begin
end;

procedure TestREFRIGASSAO.TearDown;
begin
end;

Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000019163" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "11198" AND DET_CODCLI = "00010378";
    DOCUMENTO: 000000019163
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00010378
       ESTADO: SP
         ITEM: 11198
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000230606" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "08947" AND DET_CODCLI = "00008377";
    DOCUMENTO: 000000230606
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 00008377
       ESTADO: SP
         ITEM: 08947
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .AliquotaDeCalculoIPI(8);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{8}, objFloatUtils.fStrToFloat('8')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034883" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "08995" AND DET_CODCLI = "00008824";
    DOCUMENTO: 000000034883
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00008824
       ESTADO: SP
         ITEM: 08995
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .BaseDoIpi(20)
      .AliquotaDeCalculoIPI(20);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{20}, objFloatUtils.fStrToFloat('20')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{20}, objFloatUtils.fStrToFloat('20')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034883" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "11292" AND DET_CODCLI = "00008824";
    DOCUMENTO: 000000034883
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00008824
       ESTADO: SP
         ITEM: 11292
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .BaseDoIpi(10)
      .AliquotaDeCalculoIPI(10);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{1}, objFloatUtils.fStrToFloat('1')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{10}, objFloatUtils.fStrToFloat('10')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034888" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04834" AND DET_CODCLI = "20000051";
    DOCUMENTO: 000000034888
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20000051
       ESTADO: SP
         ITEM: 04834
         CFOP: 5102
CODIGO FISCAL: 540
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(True)
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


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034891" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10138" AND DET_CODCLI = "00018785";
    DOCUMENTO: 000000034891
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00018785
       ESTADO: SP
         ITEM: 10138
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .BaseDoIpi(21.85)
      .AliquotaDeCalculoIPI(15);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{3,28}, objFloatUtils.fStrToFloat('3,28')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{21,85}, objFloatUtils.fStrToFloat('21,85')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{15}, objFloatUtils.fStrToFloat('15')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034893" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "08959" AND DET_CODCLI = "00015339";
    DOCUMENTO: 000000034893
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00015339
       ESTADO: SP
         ITEM: 08959
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .BaseDoIpi(128.7)
      .AliquotaDeCalculoIPI(8);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{10,3}, objFloatUtils.fStrToFloat('10,3')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{128,7}, objFloatUtils.fStrToFloat('128,7')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{8}, objFloatUtils.fStrToFloat('8')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034902" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10288" AND DET_CODCLI = "20001171";
    DOCUMENTO: 000000034902
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20001171
       ESTADO: SP
         ITEM: 10288
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .BaseDoIpi(4)
      .AliquotaDeCalculoIPI(10);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{0,4}, objFloatUtils.fStrToFloat('0,4')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{10}, objFloatUtils.fStrToFloat('10')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034902" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "11292" AND DET_CODCLI = "20001171";
    DOCUMENTO: 000000034902
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 20001171
       ESTADO: SP
         ITEM: 11292
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: 11}

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
      .BaseDoIpi(20)
      .AliquotaDeCalculoIPI(10);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorCalculadoIPI{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{20}, objFloatUtils.fStrToFloat('20')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{10}, objFloatUtils.fStrToFloat('10')));
end;


Procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000034880" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "08947" AND DET_CODCLI = "00008377";
    DOCUMENTO: 000000034880
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00008377
       ESTADO: SP
         ITEM: 08947
         CFOP: 5102
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV:
 DATA ENTRADA: 17/10/2019
   AUX_OPCDOC: CF}

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
      .BaseDoIpi(26.85)
      .AliquotaDeCalculoIPI(8);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue(
            CompararValores(ReturnValue.ValorCalculadoIPI{2,15}, objFloatUtils.fStrToFloat('2,15')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{26,85}, objFloatUtils.fStrToFloat('26,85')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{8}, objFloatUtils.fStrToFloat('8')));
end;




procedure TestREFRIGASSAO.CALCULO_IPI__REFRIGASSAO_000011_FEITO_MANUALMENTE;
Var
  ReturnValue: IResultadoCalculoIPI;
  AParametros: IParametrosCalculoIPI;
Begin

  AParametros :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(False)
      .ClienteOrgaoPublico(False)
      .VendaDentroDoEstado(True)
      .ClienteDoExterior(True)
      .SituacaoTributariaIPI('T')
      .BaseDoIpi(26.85)
      .AliquotaDeCalculoIPI(8);

  ReturnValue := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);

  CheckTrue(
            CompararValores(ReturnValue.ValorCalculadoIPI{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseDeCalculoIPI{26,85}, objFloatUtils.fStrToFloat('26,85')) And
            CompararValores(ReturnValue.AliquotaDeCalculoIPI{8}, objFloatUtils.fStrToFloat('8')));
end;

initialization
  RegisterTest(TestREFRIGASSAO.Suite);
end.

