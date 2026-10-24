unit untFrameDirectoryEditFocus;

interface
{$WARNINGS OFF}
{$HINTS OFF}

uses
  StrUtils, Math, Windows, Winapi.Messages, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, System.Classes,
  Vcl.Dialogs, System.SysUtils, Vcl.Forms, Vcl.Controls, EditFocus,
  Vcl.FileCtrl;

type
  TfraDirectoryEditFocus = class(TFrame)
    edtDirectory: TEditFocus;
    btnOpenDirectory: TcxButton;
    procedure btnOpenDirectoryClick(Sender: TObject);
  private
    FDefaultFolder: String;
    FTitle: String;
    FOkButtonLabel: String;
    FOnAccept: TNotifyEvent;
    { Private declarations }
  public
    { Public declarations }
    property Title: String read FTitle write FTitle;
    property OkButtonLabel: string read FOkButtonLabel write FOkButtonLabel;
    property DefaultFolder: String read FDefaultFolder write FDefaultFolder;
    property OnAccept: TNotifyEvent read FOnAccept write FOnAccept;
  end;

implementation

{$R *.dfm}

procedure TfraDirectoryEditFocus.btnOpenDirectoryClick(Sender: TObject);
Var
  LObjFileOpenDialog: TFileOpenDialog;
begin
  If FTitle.IsEmpty Then
    FTitle := 'Selecione o diretório';

  If FOkButtonLabel.IsEmpty Then
    FOkButtonLabel := 'Selecione';

  if Win32MajorVersion >= 6 then
  begin
    try
      LObjFileOpenDialog := TFileOpenDialog.Create(nil);
      try
        LObjFileOpenDialog.Title := FTitle;
        LObjFileOpenDialog.Options := [fdoPickFolders, fdoPathMustExist,
          fdoForceFileSystem];
        LObjFileOpenDialog.OkButtonLabel := FOkButtonLabel;
        LObjFileOpenDialog.DefaultFolder := FDefaultFolder;
        LObjFileOpenDialog.FileName := FDefaultFolder;
        if LObjFileOpenDialog.Execute then
        begin
          edtDirectory.Text := LObjFileOpenDialog.FileName;
          If Assigned(FOnAccept) Then
            FOnAccept(LObjFileOpenDialog);
        end;
      finally
        LObjFileOpenDialog.Free;
      end;
    except
      if SelectDirectory(FTitle, ExtractFileDrive(FDefaultFolder),
        FDefaultFolder, [sdNewUI, sdNewFolder]) then
      begin
        edtDirectory.Text := FDefaultFolder;
        If Assigned(FOnAccept) Then
          FOnAccept(nil);
      end;
    end;
  end
  else if SelectDirectory(FTitle, ExtractFileDrive(FDefaultFolder),
    FDefaultFolder, [sdNewUI, sdNewFolder]) then
  begin
    edtDirectory.Text := FDefaultFolder;
    If Assigned(FOnAccept) Then
      FOnAccept(nil);
  end;

  if edtDirectory.CanFocus then
    edtDirectory.SetFocus;
end;

end.
