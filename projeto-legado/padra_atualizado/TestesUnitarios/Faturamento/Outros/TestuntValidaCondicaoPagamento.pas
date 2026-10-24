unit TestuntValidaCondicaoPagamento;                        //untValidaCondicaoPagamento

interface

uses
  TestFramework,
  untValidaCondicaoPagamento;

type
  TTestTValidaCondicaoPagamento = class(TTestCase)
  private
  published
    procedure TestfValidaConPagMaiorPrazo();

  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation

{ TTestTValidaCondicaoPagamento }

procedure TTestTValidaCondicaoPagamento.SetUp;
begin
  inherited;

end;

procedure TTestTValidaCondicaoPagamento.TearDown;
begin
  inherited;

end;


procedure TTestTValidaCondicaoPagamento.TestfValidaConPagMaiorPrazo;
begin
  CheckFalse(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('01.120', '02.005.010'));
  CheckTrue(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('02.005.010', '01.120'));
  CheckFalse(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('01.120', '01.120'));
  CheckTrue(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('01.120', '05.030.060.090.120.150'));
  CheckFalse(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('05.030.060.090.120.150', '01.120'));
  CheckTrue(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('01.030', '01.060'));
  CheckFalse(TValidaCondicaoPagamento.fValidaConPagMaiorPrazo('01.060', '01.030'));
end;

initialization
  RegisterTest(TTestTValidaCondicaoPagamento.Suite);

end.
