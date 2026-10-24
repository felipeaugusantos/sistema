unit untQckOrdProducaoImp;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, Forms;

type
  TfrmQckOrdProducaoImp = class(TForm)
    frxImpressaoJ: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxImpressaoM: TfrxReport;
    function frxReportJUserFunction(const MethodName: string;
                                      var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQckOrdProducaoImp: TfrmQckOrdProducaoImp;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmQckOrdProducaoImp.frxReportJUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fRetNomProduto') Then
    Result := fRetNomProduto(Params[0])
  Else If SameText(MethodName, 'fFloatToStrF') Then
    Result := FloatToStrF(Params[0], ffFixed, 12, fCfgSis('DECQTD', varInteger))
  Else If SameText(MethodName, 'fRetReferenciaProd') Then
    Result := fRetReferenciaProd(Params[0])

end;

end.
