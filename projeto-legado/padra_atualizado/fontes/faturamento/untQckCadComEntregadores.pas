unit untQckCadComEntregadores;

interface

uses
  SysUtils, Classes, frxClass, frxDMPExport, frxDBSet, DB,
    Uni, MemDS, DBAccess, Forms;

type
  TfrmQckCadComEntregadores = class(TForm)
    frxQckEntrega80J: TfrxReport;
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxQckEntrega80M: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxQckEntrega40M: TfrxReport;
    frxQckEntrega40J: TfrxReport;
    frxQckEntrega80JRetrato: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function frxQckEntrega80MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckCadComEntregadores.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  frxQckEntrega80M.AddFunction('function fFormataCondPag(strCond : String): String');
  frxQckEntrega80J.AddFunction('function fFormataCondPag(strCond : String): String');
  frxQckEntrega80JRetrato.AddFunction('function fFormataCondPag(strCond : String): String');
  frxQckEntrega40M.AddFunction('function fFormataCondPag(strCond : String): String');
  frxQckEntrega40J.AddFunction('function fFormataCondPag(strCond : String): String');
end;

function TfrmQckCadComEntregadores.frxQckEntrega80MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := UpperCase(fFormataCondPag(Params[0]));
end;

end.
