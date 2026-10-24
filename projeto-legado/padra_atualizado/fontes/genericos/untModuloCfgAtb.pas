unit untModuloCfgAtb;

interface

uses
  SysUtils, Classes, DB, Uni, MemDS, DBAccess, frxClass;

type
  TfrmModuloCfgAtb = class(TDataModule)
    qryCfgAtb: TUniQuery;
    dtsCfgAtb: TDataSource;
    qryCfgAtbATB_NOMFOR: TStringField;
    qryCfgAtbATB_NOMCAM: TStringField;
    qryCfgAtbAUTOINCREM: TStringField;
    qryCfgAtbATB_DESCAM: TMemoField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloCfgAtb: TfrmModuloCfgAtb;

implementation


{$R *.dfm}

procedure TfrmModuloCfgAtb.DataModuleCreate(Sender: TObject);
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
