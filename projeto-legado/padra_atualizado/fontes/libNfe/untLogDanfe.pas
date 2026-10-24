unit untLogDanfe;

interface

uses
{$IFDEF LINUX}
  Posix.Unistd,
{$ELSE}
  Windows,
{$ENDIF}
{$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)}
  Uni,
{$ELSE}
  ZDataset, ZConnection,
{$IFEND}
  Classes, DB, SysUtils;

type
  TLogDanfe = class sealed
  private
    FTableExists: Boolean;
    FConn: {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FNumDoc: string;
    FEspDoc: string;
    FCodEmp: string;
    FCodCli: string;
    FSerie_: string;
    procedure SetChaAce(const Value: String);
    procedure SetObjConexao(const Value: {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)} TUniConnection {$ELSE} TZConnection {$IFEND});
  public
    constructor Create;
    procedure AddLog(const AText: string);
    property strNumDoc: string read FNumDoc write FNumDoc;
    property strEspDoc: string read FEspDoc write FEspDoc;
    property strCodEmp: string read FCodEmp write FCodEmp;
    property strCodCli: string read FCodCli write FCodCli;
    property strSerie_: string read FSerie_ write FSerie_;
    property strChaAce: String write SetChaAce;
    property objConexao: {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)} TUniConnection {$ELSE} TZConnection {$IFEND} read FConn write SetObjConexao;
  end;

{* Para habilitar este log basta criar a tabela LOG_DANFE, segue script:

******** NAO ESQUECER DE DELETAR ESTA TABELA APOS PEGAR OS LOGS ********

DROP TABLE LOG_DANFE;

CREATE TABLE LOG_DANFE (
  AUTOINCREM BIGINT AUTO_INCREMENT,
  LOG_DTALOG TIMESTAMP(3),
  LOG_NUMDOC VARCHAR (12),
  LOG_ESPDOC CHAR(2),
  LOG_CODEMP CHAR(3),
  LOG_CODCLI VARCHAR (8),
  NFE_SERIE_ CHAR(3),
  LOG_PATEXE VARCHAR(255),
  LOG_PARAMS VARCHAR(255),
  LOG_MENSAG TEXT,
  LOG_PROCID VARCHAR(10),
  PRIMARY KEY(AUTOINCREM)
) ENGINE = MYISAM;

ALTER TABLE LOG_DANFE ADD KEY LOG_DANFE_IDX_001(LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP);
ALTER TABLE LOG_DANFE ADD KEY LOG_DANFE_IDX_002(LOG_CODCLI);
ALTER TABLE LOG_DANFE ADD KEY LOG_DANFE_IDX_003(LOG_DTALOG);

*}

var
  objLogDanfe: TLogDanfe;

implementation

var
  FProcID: string;

{ TLogDanfe }

procedure TLogDanfe.AddLog(const AText: string);
Var
 {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)}
  LQuery: TUniQuery;
 {$ELSE}
  LQuery: TZQuery;
 {$IFEND}
  LParams: String;
  LIndex: Integer;
begin
  if not FTableExists then
    Exit;
  if strNumDoc = EmptyStr then
    Exit;
  try
    if not assigned(objConexao) then
      Exit;
    if not objConexao.Connected then
      Exit;
  except
    objLogDanfe.objConexao := Nil;
    exit;
  end;
 {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)}
  LQuery := TUniQuery.Create(nil);
 {$ELSE}
  LQuery := TZQuery.Create(nil);
 {$IFEND}
  try
    LQuery.Connection := objConexao;
    LQuery.Tag := objConexao.Tag;

    try
      LQuery.SQL.Text := 'DESC LOG_DANFE';
      LQuery.Open;
    except
      FTableExists := False;
      Exit;
    end;

    LQuery.SQL.Text :=
      'INSERT INTO LOG_DANFE ( ' +
      '  LOG_DTALOG, ' +
      '  LOG_NUMDOC, ' +
      '  LOG_ESPDOC, ' +
      '  LOG_CODEMP, ' +
      '  LOG_CODCLI, ' +
      '  NFE_SERIE_, ' +
      '  LOG_PATEXE, ' +
      '  LOG_PARAMS, ' +
      '  LOG_PROCID, ' +
      '  LOG_MENSAG  ' +
      ') ' +
      'VALUES ' +
      '  ( ' +
      '    CURRENT_TIMESTAMP(3), ' +
      '    :NUMDOC, :ESPDOC, :CODEMP, :CODCLI, :SERIE_, :PATEXE, :PARAMS, :PROCID, :MENSAG ' +
      '  ) ';

    LParams := '';

    For LIndex := 1 To ParamCount Do
      LParams := LParams + ' ' + ParamStr(LIndex);

    LParams := Trim(LParams);

    LQuery.ParamByName('NUMDOC').AsString := FNumDoc;
    LQuery.ParamByName('ESPDOC').AsString := FEspDoc;
    LQuery.ParamByName('CODEMP').AsString := FCodEmp;
    LQuery.ParamByName('CODCLI').AsString := FCodCli;
    LQuery.ParamByName('SERIE_').AsString := FSerie_;
    LQuery.ParamByName('PATEXE').AsString := ParamStr(0);
    LQuery.ParamByName('PARAMS').AsString := LParams;
    LQuery.ParamByName('PROCID').AsString := FProcID;
    LQuery.ParamByName('MENSAG').AsString := AText;

    try
      LQuery.ExecSQL;
    except
      //do nothing
    end;
  finally
    LQuery.Free;
  end;
end;

constructor TLogDanfe.Create;
begin
  objConexao := nil;
end;

procedure TLogDanfe.SetChaAce(const Value: String);
Var
 {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)}
  LQuery: TUniQuery;
 {$ELSE}
  LQuery: TZQuery;
 {$IFEND}
begin
  if not FTableExists then
    Exit;
  if not Assigned(objConexao) then
    Exit;
  if not objConexao.Connected then
    Exit;
 {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)}
  LQuery := TUniQuery.Create(nil);
 {$ELSE}
  LQuery := TZQuery.Create(nil);
 {$IFEND}
  try
    LQuery.Connection := objConexao;
    LQuery.Tag := objConexao.Tag;
    try
      if Value = '' then
        LQuery.SQL.Text := 'SELECT * FROM LOGNFE WHERE FALSE'
      else
        LQuery.SQL.Text := 'SELECT * FROM LOGNFE WHERE NFE_ACESSO = "' + Value + '"';
      LQuery.Open;
      if not LQuery.IsEmpty then
      begin
        strNumDoc := LQuery.FieldByName('NFE_NUMDOC').AsString;
        strEspDoc := LQuery.FieldByName('NFE_ESPDOC').AsString;
        strCodEmp := LQuery.FieldByName('NFE_CODEMP').AsString;
        strCodCli := LQuery.FieldByName('NFE_CODCLI').AsString;
        strSerie_ := LQuery.FieldByName('NFE_SERIE_').AsString;
      end
      else
      begin
        LQuery.Close;
        if Value = '' then
          LQuery.SQL.Text := 'SELECT * FROM CADFIS WHERE FALSE'
        else
          LQuery.SQL.Text := 'SELECT * FROM CADFIS WHERE FIS_ACESSO = "' + Value + '"';
        LQuery.Open;
        if not LQuery.IsEmpty then
        begin
          strNumDoc := LQuery.FieldByName('FIS_NUMDOC').AsString;
          strEspDoc := LQuery.FieldByName('FIS_ESPDOC').AsString;
          strCodEmp := LQuery.FieldByName('FIS_CODEMP').AsString;
          strCodCli := LQuery.FieldByName('FIS_FORCLI').AsString;
          strSerie_ := LQuery.FieldByName('FIS_SERIE_').AsString;
        end
        else
        begin
          strNumDoc := '...';
          strEspDoc := '...';
          strCodEmp := '...';
          strSerie_ := '...';
          strCodCli := '...';
        end;
      end;
    except
      Exit;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TLogDanfe.SetObjConexao(const Value: {$IF Defined(VER270) Or Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX) Or Defined(VER300)} TUniConnection {$ELSE} TZConnection {$IFEND});
begin
  If (Not FTableExists) Then
  Begin
    If (Assigned(FConn) <> Assigned(Value)) Then
      FTableExists := True;
  End;

  FConn := Value;
end;

initialization
  objLogDanfe := TLogDanfe.Create;
  objLogDanfe.FTableExists := True;
 {$IFDEF LINUX}
  FProcID := IntToStr(getpid);
 {$ELSE}
  FProcID := IntToStr(GetCurrentProcessId);
 {$ENDIF}

finalization
  If Assigned(objLogDanfe) then
    FreeAndNil(objLogDanfe);

end.
