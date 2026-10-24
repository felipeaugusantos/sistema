unit untModuloOrdemCarreg;

interface

uses
  SysUtils, Classes, frxClass, frxDMPExport, frxDBSet, DB, Forms;

type
  TfrmModuloOrdemCarreg = class(TForm)
    frxDocCar80J: TfrxReport;
    frxItens: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    frxCadEmp: TfrxDBDataset;
    dtsOrdCar: TDataSource;
    frxCadSep: TfrxDBDataset;
    frxDocCar80M: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloOrdemCarreg: TfrmModuloOrdemCarreg;

implementation

{$R *.dfm}

procedure TfrmModuloOrdemCarreg.DataModuleCreate(Sender: TObject);
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

end;

end.
