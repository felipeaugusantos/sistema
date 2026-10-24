unit TestFaturamento.Impostos.Calculos.PrecoCusto.ANDRESA_EMP_01_Lj012_20191220;

{--------------------------------------------------------------------------
                    RESUMO PRECOCUSTO                 
--------------------------------------------------------------------------
Empresa            : 012 - ANDRESA- EMP 012 - FANT - SP
Período Selecionado: 20/12/2019 até 20/12/2019
Data do Processo   : 20/12/2019 
Hora Inicio        : 09:23:49
Hora Fim           : 09:23:49
Tempo Total        : 00:00:00
                                           
Total Registros    : 1
Total Processados  : 1
Total de Acertos   : 1
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 0
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

Procedure REGRA_PRECOCUSTOREALVENDA_ANDRESAEMP01_000001;


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

Procedure TestANDRESAEMP01.REGRA_PRECOCUSTOREALVENDA_ANDRESAEMP01_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000012978843" AND DET_ESPDOC = "NF" AND DET_CODEMP = "012" AND DET_CODITE = "40294" AND DET_CODCLI = "99990203";
    DOCUMENTO: 000012978843
      ESPECIE: NF
      EMPRESA: 012
      CLIENTE: 99990203
       ESTADO: MS
         ITEM: 40294
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: 
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoPrecoCusto;
  AParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin

  AParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(111.2)
      .PrecoDeCusto(44.13)
      .OutrosValores(1)
      .IcmsDeSaida(7)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .AliquotaDoDifal(10)
      .AliquotaDoFcp(2)
      .TaxaDeJuros(0);

  ReturnValue := TCalculoPrecosPrecoCusto.New.CalculaPrecoCustoRealVenda(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{71,818}, objFloatUtils.fStrToFloat('71,82')));
end;




initialization
  RegisterTest(TestANDRESAEMP01.Suite);
end.

