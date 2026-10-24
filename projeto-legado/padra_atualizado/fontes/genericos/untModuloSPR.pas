unit untModuloSPR;

interface

uses
  SysUtils, Classes, DB, Uni, MemDS, DBAccess, frxClass, frxDBSet;

type
  TfrmModuloSPR = class(TDataModule)
    qryRelatorio: TUniQuery;
    dtsRelatorio: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloSPR: TfrmModuloSPR;

implementation

uses untModulo;

{$R *.dfm}

procedure TfrmModuloSPR.DataModuleCreate(Sender: TObject);
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
