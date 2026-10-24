unit untSQLCommandBatch;

interface

uses System.Generics.Collections;

type
  TSQLCommandBatch = class
  private
    FCommands : TList<String>;
  public
    procedure pAddSQLCommand(const strSQLCommand : String);
    procedure pExecute;
    constructor Create;
    destructor Destroy; override;
  End;

implementation

uses System.SysUtils, untFuncoesSimples;

{ TSQLCommandBatch }

constructor TSQLCommandBatch.Create;
begin
  FCommands := TList<String>.Create;
end;

destructor TSQLCommandBatch.Destroy;
begin
  FreeAndNil(FCommands);
  inherited;
end;

procedure TSQLCommandBatch.pAddSQLCommand(const strSQLCommand: String);
begin
  If fEmptyStr(strSQLCommand) Then
    Exit;
  FCommands.Add(strSQLCommand);
end;

procedure TSQLCommandBatch.pExecute;
  Var
    strSQL : String;
begin
  If (FCommands.Count = 0) Then
    Exit;
  strSQL := fTListStringToStr(FCommands, sLineBreak);
  fExecutaSQL(strSQL, True);
  FCommands.Clear;
end;

end.
