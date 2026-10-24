unit TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.ANDRESA_Lj012_20191220;

{--------------------------------------------------------------------------
                    RESUMO PRECOCUSTO\PRECOCUSTOMARGEMMARKUP                 
--------------------------------------------------------------------------
Empresa            : 012 - ANDRESA- EMP 012 - FANT - SP
Período Selecionado: 20/12/2019 até 20/12/2019
Data do Processo   : 20/12/2019 
Hora Inicio        : 15:53:29
Hora Fim           : 15:53:29
Tempo Total        : 00:00:00
                                           
Total Registros    : 6
Total Processados  : 6
Total de Acertos   : 2
Total de Erros     : 3
Total Ignorados    : 0
Total Duplicados   : 1
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
TestANDRESAEMP01 = class(TTestCase)
strict private
private





published

Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_ANDRESAEMP01_000001;
Procedure REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_ANDRESAEMP01_000002;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestANDRESAEMP01.SetUp;
begin
end;

procedure TestANDRESAEMP01.TearDown;
begin
end;

Procedure TestANDRESAEMP01.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_ANDRESAEMP01_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000012978849" AND DET_ESPDOC = "NF" AND DET_CODEMP = "012" AND DET_CODITE = "40294" AND DET_CODCLI = "00008001";
    DOCUMENTO: 000012978849
      ESPECIE: NF
      EMPRESA: 012
      CLIENTE: 00008001
       ESTADO: SP
         ITEM: 40294
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(50)
      .Desconto01(1)
      .Desconto02(1.5)
      .Desconto03(2)
      .Desconto04(2.5)
      .Desconto05(3)
      .Desconto06(3.5)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(1)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(4)
      .AcrescimoFinal(1)
      .SubstituicaoTributaria(2)
      .DescontosAdicionais(3)
      .FormulaParaCalculo('3')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(3);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{44,108}, objFloatUtils.fStrToFloat('44,11')));
end;


Procedure TestANDRESAEMP01.REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO_ANDRESAEMP01_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000012978849" AND DET_ESPDOC = "NF" AND DET_CODEMP = "012" AND DET_CODITE = "40304" AND DET_CODCLI = "00008001";
    DOCUMENTO: 000012978849
      ESPECIE: NF
      EMPRESA: 012
      CLIENTE: 00008001
       ESTADO: SP
         ITEM: 40304
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCusto;
Begin

  AParametros :=
    TParametrosCalculoPrecoCusto.New()
      .PrecoDeCompra(59.4)
      .Desconto01(1)
      .Desconto02(1.5)
      .Desconto03(2)
      .Desconto04(2.5)
      .Desconto05(3)
      .Desconto06(3.5)
      .Desconto07(0)
      .IcmsDeEntrada(12)
      .ImpostoFederal(1)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(4)
      .AcrescimoFinal(1)
      .SubstituicaoTributaria(2)
      .DescontosAdicionais(3)
      .FormulaParaCalculo('3')
      .OperadorAdicaoDescontosAdicionais(False)
      .QuantidadeCasasDecimais(3);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCusto(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{51,67}, objFloatUtils.fStrToFloat('51,67')));
end;




initialization
  RegisterTest(TestANDRESAEMP01.Suite);
end.

