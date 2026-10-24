unit TestFaturamento.Precos.Calculos.PrecoCustoRealVenda.TINTAS_MC_Lj002_20191223;

{--------------------------------------------------------------------------
                    RESUMO PRECOCUSTO\PRECOCUSTOREALVENDA                 
--------------------------------------------------------------------------
Empresa            : 002 - TINTAS MC
Período Selecionado: 23/12/2019 até 23/12/2019
Data do Processo   : 26/12/2019 
Hora Inicio        : 10:02:06
Hora Fim           : 10:02:07
Tempo Total        : 00:00:01
                                           
Total Registros    : 26
Total Processados  : 26
Total de Acertos   : 16
Total de Erros     : 8
Total Ignorados    : 0
Total Duplicados   : 2
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
TestTINTASMC = class(TTestCase)
strict private
private





published

Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000001;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000002;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000003;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000004;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000005;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000006;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000007;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000008;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000009;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000010;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000011;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000012;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000013;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000014;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000015;
Procedure REGRA_PRECOCUSTOREALVENDA_TINTASMC_000016;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestTINTASMC.SetUp;
begin
end;

procedure TestTINTASMC.TearDown;
begin
end;

Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206603" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "01158" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206603
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01158
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(18)
      .PrecoDeCusto(10.64)
      .OutrosValores(0.692)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{11,332}, objFloatUtils.fStrToFloat('11,33')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206603" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "02182" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206603
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 02182
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(14)
      .PrecoDeCusto(7.35)
      .OutrosValores(0.478)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{8,003}, objFloatUtils.fStrToFloat('8')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206604" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "01921" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206604
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 01921
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(100)
      .PrecoDeCusto(72.02)
      .OutrosValores(4.681)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{76,701}, objFloatUtils.fStrToFloat('76,7')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206604" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "00069" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206604
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00069
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(5)
      .PrecoDeCusto(1.44)
      .OutrosValores(0.094)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,5965}, objFloatUtils.fStrToFloat('1,6')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206605" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "00244" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206605
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00244
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(52.35)
      .PrecoDeCusto(34.66)
      .OutrosValores(2.253)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{36,913}, objFloatUtils.fStrToFloat('36,91')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206606" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "00386" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206606
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00386
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(19)
      .PrecoDeCusto(7.39)
      .OutrosValores(0.453)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{8,0805}, objFloatUtils.fStrToFloat('8,08')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04103" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 04103
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(32)
      .PrecoDeCusto(13.07)
      .OutrosValores(0.849)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{13,919}, objFloatUtils.fStrToFloat('13,92')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10227" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 10227
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(10.2)
      .PrecoDeCusto(3.75)
      .OutrosValores(0.244)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,994}, objFloatUtils.fStrToFloat('3,99')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04353" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 04353
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(10)
      .PrecoDeCusto(3.73)
      .OutrosValores(0.242)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,097}, objFloatUtils.fStrToFloat('4,1')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00224" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 00224
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(179.68)
      .PrecoDeCusto(104.4)
      .OutrosValores(6.786)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{111,186}, objFloatUtils.fStrToFloat('111,19')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00503" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 00503
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(106.67)
      .PrecoDeCusto(59.83)
      .OutrosValores(3.889)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{63,719}, objFloatUtils.fStrToFloat('63,72')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00126" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 00126
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(2.63)
      .PrecoDeCusto(1.68)
      .OutrosValores(0.109)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,821875}, objFloatUtils.fStrToFloat('1,82')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02427" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 02427
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(71)
      .PrecoDeCusto(43.96)
      .OutrosValores(2.857)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{47,7045}, objFloatUtils.fStrToFloat('47,7')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206607" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "00224" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206607
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00224
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(161.71)
      .PrecoDeCusto(104.4)
      .OutrosValores(6.786)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{111,186}, objFloatUtils.fStrToFloat('111,19')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206607" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "00604" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206607
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 00604
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(9.9)
      .PrecoDeCusto(4.51)
      .OutrosValores(0.293)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,803}, objFloatUtils.fStrToFloat('4,8')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOREALVENDA_TINTASMC_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000206607" AND DET_ESPDOC = "IF" AND DET_CODEMP = "002" AND DET_CODITE = "08024" AND DET_CODCLI = "00000001";
    DOCUMENTO: 000000206607
      ESPECIE: IF
      EMPRESA: 002
      CLIENTE: 00000001
       ESTADO: SP
         ITEM: 08024
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(23.94)
      .PrecoDeCusto(12.05)
      .OutrosValores(0.783)
      .IcmsDeSaida(1.25)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .AliquotaDoDifal(0)
      .AliquotaDoFcp(0)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{13,13225}, objFloatUtils.fStrToFloat('13,13')));
end;




initialization
  RegisterTest(TestTINTASMC.Suite);
end.

