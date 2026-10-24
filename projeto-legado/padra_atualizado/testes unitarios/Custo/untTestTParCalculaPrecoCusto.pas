unit untTestTParCalculaPrecoCusto;

interface

uses
  TestFramework, Windows, Forms, Dialogs, Controls, StrUtils, Classes, SysUtils, Variants,
  Graphics, Messages, untParCalculaPrecoCusto, untIConfiguracao, untConfiguracoesStub;

type
  // Test methods for class TParCalculaPrecoCusto

  TestTParCalculaPrecoCusto = class(TTestCase)
  strict private
    FConfig: TConfiguracaoStub;
    FParCalculaPrecoCusto: TParCalculaPrecoCusto;

    fltDesOpe: Double;
    fltImpFed: Double;
    fltICMSai: Double;
    fltOutVal: Double;
    fltPreCus: Double;
    fltPreVen: Double;

    const PRECO_CUSTO_VENDA_IMPOSTOS = 2147.85;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestpLimparCampos;
    procedure TestfCalculaPrecoCusto;
    procedure TestfCalculaPrecoCustoAPartirDoPrecoDeVendaMarkup;
    procedure TestfCalculaPrecoCustoAPartirDoPrecoDeVendaMargem;
    procedure TestfCalculaPrecoCustoPreCuv;
    procedure TestfCalculaPrecoCustoPreCuvComImpostos;
    procedure TestfCalculaPrecoCustoVenda;
  end;

implementation

uses untFuncoesLibFuncoes;

procedure TestTParCalculaPrecoCusto.SetUp;
begin
  FConfig := TConfiguracaoStub.Create;
  FParCalculaPrecoCusto := TParCalculaPrecoCusto.Create(Nil, FConfig);
  
  FParCalculaPrecoCusto.curPreCom  := 1000;
  FParCalculaPrecoCusto.curDesF01  := 1;
  FParCalculaPrecoCusto.curDesF02  := 2;
  FParCalculaPrecoCusto.curDesF03  := 3;
  FParCalculaPrecoCusto.curDesF04  := 4;
  FParCalculaPrecoCusto.curDesF05  := 5;
  FParCalculaPrecoCusto.curDesF06  := 6;
  FParCalculaPrecoCusto.curICMSEnt := 7;
  FParCalculaPrecoCusto.curSubFed  := 8;
  FParCalculaPrecoCusto.curIPIEnt  := 9;
  FParCalculaPrecoCusto.curFrete   := 10;
  FParCalculaPrecoCusto.curValFre  := 11;
  FParCalculaPrecoCusto.curAcrFin  := 12;
  FParCalculaPrecoCusto.curSubsti  := 13;
  FParCalculaPrecoCusto.curDesAdb  := 14;

  fltDesOpe := 18;
  fltImpFed := 17;
  fltICMSai := 16;
  fltOutVal := 15;
  fltPreCus := 923.87;
  fltPreVen := 2370.55;
end;

procedure TestTParCalculaPrecoCusto.TearDown;
begin
  FParCalculaPrecoCusto.Free;
  FParCalculaPrecoCusto := nil;
end;

procedure TestTParCalculaPrecoCusto.TestpLimparCampos;
begin
  FParCalculaPrecoCusto.pLimparCampos;
  CheckEquals(0, FParCalculaPrecoCusto.curPreCom, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesF01, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesF02, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesF03, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesF04, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesF05, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesF06, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curICMSEnt, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curSubFed, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curIPIEnt, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curFrete, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curValFre, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curAcrFin, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curSubsti, 'Deveria zerar o valor.');
  CheckEquals(0, FParCalculaPrecoCusto.curDesAdb, 'Deveria zerar o valor.');
end;

procedure TestTParCalculaPrecoCusto.TestfCalculaPrecoCusto;
var
  ReturnValue: Double;
  objConversorMoeda: IConversorMoedaCusto;
begin
  ReturnValue := FParCalculaPrecoCusto.fCalculaPrecoCusto(objConversorMoeda);

  CheckEquals(fFormataFloat(923.87, 2), ReturnValue, 'Preço de custo incorreto.');
end;

procedure TestTParCalculaPrecoCusto.TestfCalculaPrecoCustoAPartirDoPrecoDeVendaMarkup;
var
  ReturnValue: Double;
  fltMargem: Double;
begin
  fltMargem := 23.72;

  ReturnValue := FParCalculaPrecoCusto.fCalculaPrecoCusto(fltPreVen, fltMargem);

  CheckEquals(fFormataFLoat(1916.06, 2), ReturnValue, 'Preço de custo incorreto');
end;

procedure TestTParCalculaPrecoCusto.TestfCalculaPrecoCustoAPartirDoPrecoDeVendaMargem;
var
  ReturnValue: Double;
  fltMargem: Double;
begin
  fltMargem := 23.72;
  FConfig.fAddConfig('MARMKP', '1');

  ReturnValue := FParCalculaPrecoCusto.fCalculaPrecoCusto(fltPreVen, fltMargem);

  CheckEquals(fFormataFloat(1808.26, 2), ReturnValue, 'Preço de custo incorreto');
end;

procedure TestTParCalculaPrecoCusto.TestfCalculaPrecoCustoPreCuv;
var
  ReturnValue: Double;
begin
  ReturnValue := FParCalculaPrecoCusto.fCalculaPrecoCustoPreCuv(fltPreVen, fltPreCus,
      fltOutVal, fltICMSai, fltImpFed, fltDesOpe);

  CheckEquals(fFormataFloat(923.87, 2), ReturnValue, 'Preço de custo incorreto.');
end;

procedure TestTParCalculaPrecoCusto.TestfCalculaPrecoCustoPreCuvComImpostos;
var
  ReturnValue: Double;
begin
  FConfig.fAddConfig('PRECUV', '2');

  ReturnValue := FParCalculaPrecoCusto.fCalculaPrecoCustoPreCuv(fltPreVen, fltPreCus,
      fltOutVal, fltICMSai, fltImpFed, fltDesOpe);

  CheckEquals(fFormataFloat(PRECO_CUSTO_VENDA_IMPOSTOS, 2), ReturnValue, 'Preço de custo incorreto.');
end;

procedure TestTParCalculaPrecoCusto.TestfCalculaPrecoCustoVenda;
var
  ReturnValue: Double;
  strPreCuv: string;
begin
  strPreCuv := '2';

  ReturnValue := FParCalculaPrecoCusto.fCalculaPrecoCustoVenda(fltPreVen, fltPreCus,
      fltOutVal, fltICMSai, fltImpFed, fltDesOpe, strPreCuv);

  CheckEquals(fFormataFloat(PRECO_CUSTO_VENDA_IMPOSTOS, 2), ReturnValue, 'Preço de custo incorreto.');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTParCalculaPrecoCusto.Suite);
end.

