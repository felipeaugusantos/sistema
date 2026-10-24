unit untModuloRelEstGirEstVendaR2;

interface

uses
  System.SysUtils, System.Classes, frxClass, Math;

type
  TfrmModuloRelEstGirEstVendaR2 = class(TDataModule)
    frxReportR2M: TfrxReport;
    frxReportR2J: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloRelEstGirEstVendaR2: TfrmModuloRelEstGirEstVendaR2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmModuloRelEstGirEstVendaR2.DataModuleCreate(Sender: TObject);
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
