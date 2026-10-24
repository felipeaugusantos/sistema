unit TestOrdemProducaoIndustrial.TFiltroProduto;

interface

uses
  TestFramework,
  untFuncoes,
  TypeInfo,

  OrdemProducaoIndustrial.TCor;

type
  TestTFiltroProduto = class(TTestCase)
  strict private
    FFiltroProduto: TFiltroProduto;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestpClone;
  end;

implementation

{ TestTFiltroProduto }

procedure TestTFiltroProduto.SetUp;
begin
  FFiltroProduto := TFiltroProduto.Create;
end;

procedure TestTFiltroProduto.TearDown;
begin
  FFiltroProduto.Free;
  FFiltroProduto := nil;
end;

procedure TestTFiltroProduto.TestpClone;
var
  context : TRttiContext;
  blnResultado : boolean;
begin

  FFiltroProduto.strCodigo    := '00001';
  FFiltroProduto.strDescricao := '';

  FFiltroProduto.Clear;
  blnResultado := (FFiltroProduto.strCodigo = '') and (FFiltroProduto.strDescricao = '');

  CheckTrue(blnResultado);
end;

initialization
  RegisterTest(TestTFiltroProduto.Suite);

end.
