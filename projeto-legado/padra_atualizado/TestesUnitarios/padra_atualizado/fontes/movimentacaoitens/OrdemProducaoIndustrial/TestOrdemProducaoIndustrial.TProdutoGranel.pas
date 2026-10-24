unit TestOrdemProducaoIndustrial.TProdutoGranel;

interface

uses
  TestFramework,
  untFuncoes,

  OrdemProducaoIndustrial.TProdutoGranel;

type
  TestTProdutoGranel = class(TTestCase)
  strict private
    FProdutoGranel: TProdutoGranel;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClear;
    function fCfgComponente: Boolean;
    function fUsaComponenteAB: Boolean;
    function fUsaComponenteA: Boolean;
    function fUsaComponenteB: Boolean;
    function fRetornaCodigoItemPrincipal: Boolean;
    function fRetornaCodigoItemSecundario: Boolean;


  end;

implementation

uses
  OrdemProducaoIndustrial.Tipos;

{ TestTProdutoGranel }

function TestTProdutoGranel.fCfgComponente: Boolean;
begin
  FProdutoGranel.blnCfgUsaComponente:= True;
  Result:= FProdutoGranel.fCfgComponente;
  CheckTrue(Result);
end;

function TestTProdutoGranel.fUsaComponenteAB: Boolean;
begin
  FProdutoGranel.strComponenteA:= 'S';
  FProdutoGranel.strComponenteB:= 'S';
  Result:= FProdutoGranel.fUsaComponenteAB;
  CheckTrue(Result);
end;

function TestTProdutoGranel.fUsaComponenteA: Boolean;
begin
  FProdutoGranel.strComponenteA:= 'S';
  FProdutoGranel.strComponenteB:= 'N';
  Result:= FProdutoGranel.fUsaComponenteAB;
  CheckTrue(Result);
end;

function TestTProdutoGranel.fUsaComponenteB: Boolean;
begin
  FProdutoGranel.strComponenteA:= 'N';
  FProdutoGranel.strComponenteB:= 'S';
  Result:= FProdutoGranel.fUsaComponenteAB;
  CheckTrue(Result);
end;

function TestTProdutoGranel.fRetornaCodigoItemPrincipal: Boolean;
begin
  FProdutoGranel.strCodigoItemPrincipal := '00002';
  Result:= (FProdutoGranel.fRetornaCodigoItem = FProdutoGranel.strCodigoItemPrincipal);
  CheckTrue(Result);
end;


function TestTProdutoGranel.fRetornaCodigoItemSecundario: Boolean;
begin
  FProdutoGranel.strCodigoItemSecundario := '00001';
  Result:= (FProdutoGranel.fRetornaCodigoItem = FProdutoGranel.strCodigoItemSecundario);
  CheckTrue(Result);
end;


procedure TestTProdutoGranel.SetUp;
begin
  FProdutoGranel := TProdutoGranel.Create;
end;

procedure TestTProdutoGranel.TearDown;
begin
  FProdutoGranel.Free;
  FProdutoGranel := nil;
end;

procedure TestTProdutoGranel.TestClear;
var
  blnResultado : boolean;
begin
  FProdutoGranel.strCodigo    := '00001';
  FProdutoGranel.strDescricao := 'Teste';
  FProdutoGranel.enuMedidaUnidade := tmKilo;

  FProdutoGranel.Clear;
  blnResultado := (FProdutoGranel.strCodigo = '') and (FProdutoGranel.strDescricao = '');

  CheckTrue(blnResultado);
end;



initialization
  RegisterTest(TestTProdutoGranel.Suite);

end.
