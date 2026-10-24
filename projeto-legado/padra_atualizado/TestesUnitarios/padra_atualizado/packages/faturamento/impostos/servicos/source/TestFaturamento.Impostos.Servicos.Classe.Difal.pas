unit TestFaturamento.Impostos.Servicos.Classe.Difal;

interface

uses
  TestFramework, Faturamento.Impostos.Interfaces.Servicos.Classe.Difal,
  Faturamento.Impostos.Servicos.Classe.Difal,
  Faturamento.Impostos.Tipos.Servicos.Classe.Difal,
  Faturamento.Impostos.Interfaces.Difal,
  Faturamento.Impostos.Tipos.Difal,
  Faturamento.Impostos.Interfaces.Fcp, Faturamento.Impostos.Calculos.Fcp,
  Shared.Functions.Types, Faturamento.Impostos.Tipos.Fcp;

type

  TestTServicosClasseDifal = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularDifal;
  end;

implementation

procedure TestTServicosClasseDifal.SetUp;
begin
end;

procedure TestTServicosClasseDifal.TearDown;
begin
end;

procedure TestTServicosClasseDifal.TestCalcularDifaL;
 Var
   LParametrosCalculoDifal: IParametrosCalculoDifal;
   LParametrosClasseDifal : IParametrosClasseDifal;
   ReturnValue            : IResultadoCalculoDifal;
   LRecDifalFCP           : TRecDifalFCP;
begin
  LRecDifalFCP.fltAlDifa := 10;
  LRecDifalFCP.fltDifDes := 11;
  LRecDifalFCP.fltDifOri := 12;
  LRecDifalFCP.fltValFcp := 13;
  LRecDifalFCP.fltPerFcp := 14;
  LRecDifalFCP.fltAlqIne := 15;
  LRecDifalFCP.fltAlqUfd := 16;
  LRecDifalFCP.fltBcuFde := 17;
  LRecDifalFCP.fltPerPar := 18;
  LRecDifalFCP.fltBasFcp := 19;
  LRecDifalFCP.blnGrvInf := True;

  LParametrosCalculoDifal  :=
    TParametrosCalculoDifal.New
      .ValorIpiDoItem(10)
      .ValorFreteDoItem(10)
      .AliquotaInterestadualCalc(10)
      .ValorIcmsBase(10)
      .TotalDoItem(10)
      .DescontoEspecialDoItem(10)
      .PercentualProvisorioPartilha(10)
      .DespesaAcessoriaDoItem(10)
      .PercentualBaseOrigem(10)
      .PercentualBaseDestino(10)
      .PercentualBaseDifalOrigem(10)
      .PercentualBaseDifalDestino(10)
      .CalculaAliquotaInterestadual(10)
      .CalculaAliquotaEfetivaOrigem(10)
      .AliquotaInternaEstadoDestino(10)
      .SituacaoReducaoBaseCalculo(false)
      .CodigoSituacaoTributaria('00')
      .ProdutoSt(false)
      .SimplesNacional(false)
      .AbreviacaoIcmsProduto(false)
      .AbreviacaoIcmsProdutoUfEmpresa(false)
      .HabilitarPercentualBase(false)
      .CalculaTipoDeAbreviacaoFiscal(false)
      .CalculaBaseReduzidaAliquotaEfetiva(false)
      .CalculaDiferencialAliquotaProdutosSt(false)
      .RecordDifalFCP(LRecDifalFCP)
      .ProdutoDeOrigemEstrangeira(false)
      .ConsiderarAliquotaEfetivaProdutosImportados(false);

  LParametrosClasseDifal :=
    TParametrosClasseDifal.New
      .ParametrosCalculoDifal(LParametrosCalculoDifal);

  ReturnValue :=
    TServicosClasseDifal.New(LParametrosClasseDifal)
      .CalcularDifalFinal.ResultadoCalculoDifal;

  CheckTrue
  ( ( ReturnValue.ValorBaseDestino = 10 ) And
    ( ReturnValue.ValorIcmsDestino = 0)   And
    ( ReturnValue.ValorIcmsOrigem = 0)    And
    ( ReturnValue.AliquotaInterestadualCalc = 10) And
    ( ReturnValue.RecordDifalFCP.fltAlDifa = 10)  And
    ( ReturnValue.RecordDifalFCP.fltDifDes = 11)  And
    ( ReturnValue.RecordDifalFCP.fltDifOri = 12)  And
    ( ReturnValue.RecordDifalFCP.fltValFcp = 13)  And
    ( ReturnValue.RecordDifalFCP.fltPerFcp = 14)  And
    ( ReturnValue.RecordDifalFCP.fltAlqIne = 15)  And
    ( ReturnValue.RecordDifalFCP.fltAlqUfd = 16 ) And
    ( ReturnValue.RecordDifalFCP.fltBcuFde = 17 ) And
    ( ReturnValue.RecordDifalFCP.fltPerPar = 18 ) And
    ( ReturnValue.RecordDifalFCP.fltBasFcp = 19 ) And
    ( ReturnValue.RecordDifalFCP.blnGrvInf = true));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTServicosClasseDifal.Suite);
end.

