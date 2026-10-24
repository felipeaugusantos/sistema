unit untLogger;

interface

uses Classes, SysUtils, ClipBrd, Forms, Windows;

Type
  TLog = class
    private
      FName: String;
      FLines: TStringList;
      FMaxLines: Integer;
      FAutoSave: Boolean;
      class var FInstance: TLog;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function getInstance(): TLog;
      procedure New(FileName: String);
      procedure Add(Information: String);
      procedure Save;
      procedure Clipboard;
      property MaxLines: Integer Read FMaxLines Write FMaxLines;
      property AutoSave: Boolean Read FAutoSave Write FAutoSave;
  end;

implementation

{ TLog }

procedure TLog.Add(Information: String);
begin
  Try
//    If (FMaxLines > 0) And (FLines.Count >= FMaxLines) Then
//      FLines.Delete(0);
//
//    FLines.Add(FormatDateTime('hh:mm:ss', Now()) + '  - ' +
//      IntToStr(GetCurrentThreadId) + ' - ' + Information);
//
//    If FAutoSave Then
//      Save;
  Except
  End;
end;

procedure TLog.Clipboard;
begin
//  ClipBrd.Clipboard.AsText := FLines.Text;
end;

constructor TLog.Create;
begin
  inherited;
//  FAutoSave := False;
//  FMaxLines := 0;
//  FLines    := TStringList.Create;
end;

destructor TLog.Destroy;
begin
//  FreeAndNil(FLines);
  inherited;
end;

class function TLog.getInstance: TLog;
begin
  If FInstance = nil Then
    FInstance := TLog.Create;
  Result := FInstance;
end;

procedure TLog.New(FileName: String);
begin
//  FName := FileName;
//  FLines.Clear;
end;

procedure TLog.Save;
begin
//  FLines.SaveToFile(ExtractFilePath(Application.ExeName) + '\' + FName + '.txt');
end;

end.
