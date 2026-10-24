unit Contabilidade.TSQLTrace;

interface

uses Windows, Forms, Classes, SysUtils, StrUtils, Uni, Contabilidade.InterfaceTrace,
  StdCtrls, Buttons, Dialogs, Controls, Messages, ExtCtrls, Shlobj, Types;

Type
  TSQLTrace = class(TInterfacedObject, ISQLTraceContabilidade)
  {$T+}
  private
    FPasta: String;
    ListaLabel: TList;
    ListaBotao: TList;

    FStackTrace: Boolean;
    FCabecalho: Boolean;
    FAutenticado: Boolean;
    FCountSQL: Integer;
    FStatus: TStatusSQLTrace;
    FTipo: TTipoSQLTrace;
    FTempFile: String;

    function GetStackTrace: Boolean;
    function GetCabecalho: Boolean;
    function GetCountSQL: Integer;
    function GetStatus: TStatusSQLTrace;
    function GetTipo: TTipoSQLTrace;
    function GetTempFile: String;
    function GetAutenticado: Boolean;

    procedure SetStackTrace(const Value: Boolean);
    procedure SetCabecalho(const Value: Boolean);
    procedure SetCountSQL(const Value: Integer);
    procedure SetStatus(const Value: TStatusSQLTrace);
    procedure SetTipo(const Value: TTipoSQLTrace);
    procedure SetTempFile(const Value: String);
    procedure SetAutenticado(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pIniciaTrace;
    procedure pPausaTrace;
    procedure pSalvaTrace;
    procedure pIncCountSQL();

    procedure pWrite(AText: String);

    property StackTrace: Boolean read GetStackTrace write SetStackTrace;
    property Cabecalho: Boolean read GetCabecalho write SetCabecalho;
    property CountSQL: Integer read GetCountSQL write SetCountSQL;
    property Status: TStatusSQLTrace read GetStatus write SetStatus;
    property Tipo: TTipoSQLTrace read GetTipo write SetTipo;
    property TempFile: String read GetTempFile write SetTempFile;
    property Autenticado: Boolean read GetAutenticado write SetAutenticado;
  end;

implementation

uses
  untFuncoesSimples, untConstantes, untModulo ;

{ TSQLTrace }

constructor TSQLTrace.Create;
begin
  ListaLabel := TList.Create;
  ListaBotao := TList.Create;
  FPasta     := ExtractFilePath(Application.ExeName) + '\SQLTrace\';

  If (Not DirectoryExists(FPasta)) Then
    MkDir(FPasta);

  Self.SetAutenticado(False);
  Self.SetTempFile(FPasta + 'sqltrace_' + Random(99999999).ToString() + '.tmp');

  Self.SetCountSQL(0);
  Self.SetStatus(stPausado);

  If (FileExists(FTempFile)) Then
    DeleteFile(FTempFile);

  pWrite('...');
end;

destructor TSQLTrace.Destroy;
begin
  ListaLabel.Free;
  ListaBotao.Free;

  inherited;
end;

procedure TSQLTrace.pIncCountSQL;
begin
  Self.SetCountSQL(Self.GetCountSQL() + 1);
end;

procedure TSQLTrace.pIniciaTrace;
begin
  if (Self.GetStatus() = stPausado) and (not Self.GetAutenticado()) then
  begin
    FTipo := ttCompleto;
    FCabecalho := True;
    FStackTrace := False;
  end;

  Self.SetStatus(stIniciado);
  Self.SetAutenticado(True);
end;

procedure TSQLTrace.pPausaTrace;
begin
  FStatus := stPausado;
end;

procedure TSQLTrace.SetAutenticado(const Value: Boolean);
begin
  Self.FAutenticado := Value;
end;

procedure TSQLTrace.SetCabecalho(const Value: Boolean);
begin
  Self.FCabecalho := Value;
end;

procedure TSQLTrace.SetCountSQL(const Value: Integer);
begin
  Self.FCountSQL := Value;
end;

procedure TSQLTrace.SetStackTrace(const Value: Boolean);
begin
  Self.FStackTrace := Value;
end;

procedure TSQLTrace.SetStatus(const Value: TStatusSQLTrace);
begin
  Self.FStatus := Value;
end;

procedure TSQLTrace.SetTempFile(const Value: String);
begin
  Self.FTempFile := Value;
end;

procedure TSQLTrace.SetTipo(const Value: TTipoSQLTrace);
begin
  Self.FTipo := Value;
end;

procedure TSQLTrace.pWrite(AText: String);
Var
  LFile: TextFile;
begin
  AssignFile(LFile, GetTempFile());
  If FileExists(GetTempFile) Then
  Begin
    Reset(LFile);
    Append(LFile)
  End
  Else
    Rewrite(LFile);
  WriteLn(LFile, AText);
  CloseFile(LFile);
end;

function TSQLTrace.GetStackTrace: Boolean;
begin
  Result := Self.FStackTrace;
end;

function TSQLTrace.GetAutenticado: Boolean;
begin
  Result := Self.FAutenticado;
end;

function TSQLTrace.GetCabecalho: Boolean;
begin
  Result := Self.FCabecalho;
end;

function TSQLTrace.GetCountSQL: Integer;
begin
  Result := Self.FCountSQL;
end;

function TSQLTrace.GetStatus: TStatusSQLTrace;
begin
  Result := Self.FStatus;
end;

function TSQLTrace.GetTempFile: String;
begin
  Result := Self.FTempFile;
end;

function TSQLTrace.GetTipo: TTipoSQLTrace;
begin
  Result := Self.FTipo;
end;

procedure TSQLTrace.pSalvaTrace;
Var
  strFile: String;
begin
  strFile := FPasta + 'sqltrace_' + Random(99999999).ToString() + '.txt';

  If FileExists(strFile) Then
    DeleteFile(pChar(strFile));

  RenameFile(FTempFile, strFile);

  Self.SetTempFile(FPasta + 'sqltrace_' + Random(99999999).ToString() + '.tmp');

  pWrite('...');

  FCountSQL := 0;

  pExecArquivo(strFile, 0);
end;

end.
