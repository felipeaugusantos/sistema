unit TestOrdemProducaoIndustrial.TCor;

interface

uses
  TestFramework,
  untFuncoes,

  OrdemProducaoIndustrial.TCor;

type
  TestTCor = class(TTestCase)
  strict private
    FCor: TCor;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClear;
  end;

implementation

{ TestTCor }

procedure TestTCor.SetUp;
begin
  FCor := TCor.Create;
end;

procedure TestTCor.TearDown;
begin
  FCor.Free;
  FCor := nil;
end;

procedure TestTCor.TestClear;
var
  blnResultado : boolean;
begin

  FCor.strCodigo    := '00001';
  FCor.strDescricao := 'Teste';

  FCor.Clear;
  blnResultado := (FCor.strCodigo = '') and (FCor.strDescricao = '');

  CheckTrue(blnResultado);
end;

initialization
  RegisterTest(TestTCor.Suite);

end.
