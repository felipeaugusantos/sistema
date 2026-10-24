unit untQckRelOcorrenciasCRM;

interface

uses
  System.SysUtils, System.Classes, frxClass, Forms;

type
  TfrmQckRelOcorrenciasCRM = class(TForm)
    frxAnaliticoJ: TfrxReport;
    frxSinteticoJ: TfrxReport;
    frxSinteticoJ_Situacao: TfrxReport;
    function frxAnaliticoJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  frmQckRelOcorrenciasCRM: TfrmQckRelOcorrenciasCRM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckRelOcorrenciasCRM.DataModuleCreate(Sender: TObject);
begin
  frxAnaliticoJ.AddFunction('function fSegToTempoStr(intSegundos: Integer): String;');
  frxSinteticoJ.AddFunction('function fSegToTempoStr(intSegundos: Integer): String;');
  frxSinteticoJ_Situacao.AddFunction('function fSegToTempoStr(intSegundos: Integer): String;');
end;

function TfrmQckRelOcorrenciasCRM.frxAnaliticoJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If UpperCase(MethodName) = UpperCase('fSegToTempoStr') Then
    Result := fSegToTempoStr( Params[0] );
end;

end.
