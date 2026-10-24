unit untFormulaPrecoCusto;

interface

Uses Shared.Functions.FormulaPrecoCusto,
     untFuncoesPrecoCusto,
     Shared.Functions.Interfaces,
     Shared.Functions.Tipos,
     untIZClient;

type
  TFormulaPrecoCusto = class(TInterfacedObject, IFormulaPrecoCusto)
  public
    procedure SetarValoresFscScript(Var AfsScript: TObject; AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores );

    function RetornarSQLFormulaPrecoCusto(Const AEmpresa : String; Const ANumeroFormula : Integer) : String;

    function RetornarTipoDoCusto : String;

    function RetornarCampoDoCusto : String;

    procedure InicializaFastScript(Var AfsScript: TObject);

    function ValidaCampoPrecoCusto(Var  AZQuery : TObject ; Var AIncluirRegistro : Boolean;Const AParametrosValidaCampoPrecoCusto: IParametrosValidaCampoPrecoCusto): Boolean;

    function ValidarMatrizDeRegistrosMarkup(Var AZQuery : TObject): Boolean;

    procedure AlinhaCampoCentro(Var AZQuery : TObject; Const ANomeCampo : String);

    function MontarExpressaoCusto(Var AZQuery : TObject): String;

    function ExecutarExpressao(Var AfsScript: TObject; AExpressao: String): Double;

   function RetonarValorCalculoPrecoCustoOpcao_04(Const AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores) : Double;

    class function New: IFormulaPrecoCusto;
  end;

implementation

{ TFormulaPrecoCusto }

procedure TFormulaPrecoCusto.AlinhaCampoCentro(var AZQuery: TObject;
  const ANomeCampo: String);
begin
  untFuncoesPrecoCusto.AlinhaCampoCentro(AZQuery, ANomeCampo);
end;

function TFormulaPrecoCusto.ExecutarExpressao(var AfsScript: TObject;
  AExpressao: String): Double;
begin
  Result := untFuncoesPrecoCusto.ExecutarExpressao(AfsScript, AExpressao);
end;

procedure TFormulaPrecoCusto.InicializaFastScript(var AfsScript: TObject);
begin
  untFuncoesPrecoCusto.InicializaFastScript(AfsScript);
end;

function TFormulaPrecoCusto.MontarExpressaoCusto(var AZQuery: TObject): String;
begin
  Result := untFuncoesPrecoCusto.MontarExpressaoCusto(AZQuery);
end;

class function TFormulaPrecoCusto.New: IFormulaPrecoCusto;
begin
  Result := Self.Create;
end;

function TFormulaPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_04(
  const AParametrosFormulaPrecoCusto: IParametrosFormulaPrecoCustoSetarValores): Double;
begin
  Result := untFuncoesPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_04(AParametrosFormulaPrecoCusto);
end;

function TFormulaPrecoCusto.RetornarCampoDoCusto: String;
begin
  Result := untFuncoesPrecoCusto.RetornarCampoDoCusto;
end;

function TFormulaPrecoCusto.RetornarSQLFormulaPrecoCusto(const AEmpresa: String;
  const ANumeroFormula: Integer): String;
begin
  Result := untFuncoesPrecoCusto.RetornarSQLFormulaPrecoCusto(AEmpresa, ANumeroFormula);
end;

function TFormulaPrecoCusto.RetornarTipoDoCusto: String;
begin
  Result := untFuncoesPrecoCusto.RetornarTipoDoCusto;
end;

procedure TFormulaPrecoCusto.SetarValoresFscScript(var AfsScript: TObject;
  AParametrosFormulaPrecoCusto: IParametrosFormulaPrecoCustoSetarValores);
begin
  untFuncoesPrecoCusto.SetarValoresFscScript(AfsScript, AParametrosFormulaPrecoCusto);
end;

function TFormulaPrecoCusto.ValidaCampoPrecoCusto(Var AZQuery: TObject; Var AIncluirRegistro : Boolean;
  const AParametrosValidaCampoPrecoCusto: IParametrosValidaCampoPrecoCusto): Boolean;
begin
  Result := untFuncoesPrecoCusto.ValidaCampoPrecoCusto(AZQuery, AIncluirRegistro, AParametrosValidaCampoPrecoCusto);
end;

function TFormulaPrecoCusto.ValidarMatrizDeRegistrosMarkup(Var AZQuery: TObject): Boolean;
begin
  Result := untFuncoesPrecoCusto.ValidarMatrizDeRegistrosMarkup(AZQuery);
end;

initialization
  SetObjFormulaPrecoCusto(TFormulaPrecoCusto.New());
end.

