unit TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.TINTAS_MC_Lj002_20191223;

{--------------------------------------------------------------------------
                    RESUMO PRECOCUSTO\PRECOCUSTOMARGEMMARKUP                 
--------------------------------------------------------------------------
Empresa            : 002 - TINTAS MC
Período Selecionado: 23/12/2019 até 23/12/2019
Data do Processo   : 26/12/2019 
Hora Inicio        : 10:02:06
Hora Fim           : 10:02:07
Tempo Total        : 00:00:01
                                           
Total Registros    : 26
Total Processados  : 26
Total de Acertos   : 18
Total de Erros     : 1
Total Ignorados    : 0
Total Duplicados   : 7
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

Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000001;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000002;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000003;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000004;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000005;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000006;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000007;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000008;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000009;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000010;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000011;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000012;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000013;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000014;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000015;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000016;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000017;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000018;


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

Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000001;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.41)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(8.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{10,64}, objFloatUtils.fStrToFloat('10,64')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000002;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6.68)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,35}, objFloatUtils.fStrToFloat('7,35')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000003;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(72.02)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{72,02}, objFloatUtils.fStrToFloat('72,02')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000004;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.44)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,44}, objFloatUtils.fStrToFloat('1,44')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000005;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(31.38)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(10.44)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{34,66}, objFloatUtils.fStrToFloat('34,66')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000006;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(6.97)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(6)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{7,39}, objFloatUtils.fStrToFloat('7,39')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000201590" AND DET_ESPDOC = "ML" AND DET_CODEMP = "002" AND DET_CODITE = "10717" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000201590
      ESPECIE: ML
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 10717
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: CIM
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
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


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000008;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.9)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(15)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(16.99)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{13,07}, objFloatUtils.fStrToFloat('13,07')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000009;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.57)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,75}, objFloatUtils.fStrToFloat('3,75')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000010;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(3.55)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{3,73}, objFloatUtils.fStrToFloat('3,73')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04136" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 04136
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(9.7)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{9,7}, objFloatUtils.fStrToFloat('9,7')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002746" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10573" AND DET_CODCLI = "00000808";
    DOCUMENTO: 000000002746
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00000808
       ESTADO: SP
         ITEM: 10573
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 23/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(2.51)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{2,51}, objFloatUtils.fStrToFloat('2,51')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000013;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(94.53)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(10.44)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{104,4}, objFloatUtils.fStrToFloat('104,4')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000014;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(52.91)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(8.08)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{59,83}, objFloatUtils.fStrToFloat('59,83')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000015;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(1.68)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{1,68}, objFloatUtils.fStrToFloat('1,68')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000016;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(39.96)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(10)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{43,96}, objFloatUtils.fStrToFloat('43,96')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000017;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(4.18)
      .Desconto01(0)
      .Desconto02(0)
      .Desconto03(0)
      .Desconto04(0)
      .Desconto05(0)
      .Desconto06(0)
      .Desconto07(0)
      .IcmsDeEntrada(0)
      .ImpostoFederal(0)
      .IpiDeEntrada(8)
      .PercentualFreteDeEntrada(0)
      .ValorDoFrete(0)
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{4,51}, objFloatUtils.fStrToFloat('4,51')));
end;


Procedure TestTINTASMC.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_TINTASMC_000018;
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
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(12.05)
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
      .AcrescimoFinal(0)
      .SubstituicaoTributaria(0)
      .DescontosAdicionais(0)
      .FormulaParaCalculo('2')
      .OperadorAdicaoDescontosAdicionais(True)
      .QuantidadeCasasDecimais(2);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{12,05}, objFloatUtils.fStrToFloat('12,05')));
end;




initialization
  RegisterTest(TestTINTASMC.Suite);
end.

