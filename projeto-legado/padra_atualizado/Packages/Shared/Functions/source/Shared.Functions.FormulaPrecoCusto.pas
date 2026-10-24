unit Shared.Functions.FormulaPrecoCusto;

interface

Uses Shared.Functions.Interfaces;


type
  IFormulaPrecoCusto = interface
  ['{DBD84573-AB94-440B-B897-198ED5C2F061}']
    procedure SetarValoresFscScript(Var AfsScript: TObject; AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores );

    function RetornarSQLFormulaPrecoCusto(Const AEmpresa : String; Const ANumeroFormula : Integer) : String;

    function RetornarTipoDoCusto : String;

    function RetornarCampoDoCusto : String;

    procedure InicializaFastScript(Var AfsScript: TObject);

    function ValidaCampoPrecoCusto(Var  AZQuery : TObject; Var AIncluirRegistro : Boolean; Const AParametrosValidaCampoPrecoCusto : IParametrosValidaCampoPrecoCusto): Boolean;

    function ValidarMatrizDeRegistrosMarkup(Var AZQuery : TObject): Boolean;

    procedure AlinhaCampoCentro(Var AZQuery : TObject; Const ANomeCampo : String);

    function MontarExpressaoCusto(Var AZQuery : TObject): String;

    function ExecutarExpressao(Var AfsScript: TObject; AExpressao: String): Double;

    function RetonarValorCalculoPrecoCustoOpcao_04(const AParametrosFormulaPrecoCusto: IParametrosFormulaPrecoCustoSetarValores) : Double;
  end;

  procedure SetObjFormulaPrecoCusto(AValue: IFormulaPrecoCusto);

Var
  ObjFormulaPrecoCusto : IFormulaPrecoCusto;

implementation

procedure SetObjFormulaPrecoCusto(AValue: IFormulaPrecoCusto);
begin
  ObjFormulaPrecoCusto := AValue;
end;


End.


