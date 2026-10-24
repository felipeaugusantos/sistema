unit untLogSQL;

interface

uses
  SysUtils, Classes, Uni, DateUtils, Dialogs, strUtils, Windows;

type
  TLogSQL = class
  private
    { Private declarations }
    FSelect: String;
    FConexao : TUniConnection;
  private
    procedure pGravaLogSql;
    function fEhInstrucaoSelect: Boolean;
  public
    Constructor Create;
    Destructor Destroy; override;
    procedure pGravarLog(strSelect: String);
    class function fGravaLogPerformance(strSelect: String; conn: TUniConnection): Boolean;
    class function fValidaExplain(strSQL: String; conn: TUniConnection): Boolean;
    class function fEhCreateTable(strSQL: String): Boolean;
  end;

implementation

uses untModulo, untFuncoesSimples;

{ TMonitorReplicacao }

constructor TLogSQL.Create;
begin
  inherited Create;
  FConexao := TUniConnection.Create(nil);
  FConexao.Server   := frmModulo.GetCurrentConnection.Server;
  FConexao.Database := frmModulo.GetCurrentConnection.Database;
  FConexao.Username := frmModulo.GetCurrentConnection.Username;
  FConexao.Password := frmModulo.GetCurrentConnection.Password;
  pAbrirBanco(FConexao);
end;

procedure TLogSQL.pGravarLog(strSelect: String);
begin
  FSelect := strSelect;
  
  If fEhInstrucaoSelect Or fEhCreateTable(strSelect) Then
  Begin
    Case VS_intUsaLogSql Of
      2: If fGravaLogPerformance(strSelect, FConexao) Then
         Begin
           pGravaLogSql;
         End;

      3: Begin
           pGravaLogSql;
         End;
    End;
  End;
end;

procedure TLogSQL.pGravaLogSql;
  Var
    qryLogSql: TUniQuery;
Begin

  Try
    qryLogSql := fCriaQuery(nil, FConexao);

    With qryLogSql Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO LOGSQL (LOG_DTACAD, LOG_HRACAD, LOG_S_Q_L_, LOG_CODOPE) VALUES (:DTACAD, :HRACAD, :S_Q_L_, :CODOPE)');

      ParamByName('DTACAD').AsDateTime := VS_Date;
      ParamByName('HRACAD').AsDateTime := fTime();
      ParamByName('S_Q_L_').AsString   := FSelect;
      ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;

      ExecSQL;

      Close;
    End;

  Except

  End;

  FreeAndNil(qryLogSql);

end;

class function TLogSQL.fValidaExplain(strSQL: String; conn: TUniConnection): Boolean;
  Var
    qryExplain: TUniQuery;
begin
  Result := True;

  Try
    qryExplain := fCriaQuery(nil, conn);

    With qryExplain, SQL Do
    Begin
      Add('EXPLAIN ' + strSQL);
      Open;

      While Not Eof Do
      Begin
        If (FindField('type') <> Nil) And (FindField('rows') <> Nil) Then
        Begin
          If (UpperCase(FindField('type').AsString) = 'ALL') And Not FindField('rows').IsNull Then
            Result := False;

          If (VS_MinRowLogSql > 0) And (FindField('rows').AsInteger > VS_MinRowLogSql) Then
            Result := False;
        End;        
        Next;
      End;

      Close;

    End;

  Except
    Result := True;
  End;

  FreeAndNil(qryExplain);
end;

destructor TLogSQL.Destroy;
begin
  pFecharBanco(FConexao);
  FreeAndNil(FConexao);
end;

function TLogSQL.fEhInstrucaoSelect: Boolean;
begin
  Result := AnsiStartsText('SELECT', UpperCase(Trim(FSelect)));
end;

class function TLogSQL.fGravaLogPerformance(strSelect: String; conn: TUniConnection): Boolean;
begin
  Result := (Pos('CFGSIS', strSelect) <= 0) And
            (Pos('FOR UPDATE', strSelect) <= 0) And ((Pos(' IN ', strSelect) > 0) Or
                                                    (Pos(' IN(', strSelect) > 0) Or
                                                    (fEhCreateTable(strSelect))           Or
                                                    (Not fValidaExplain(strSelect, conn)))
end;

class function TLogSQL.fEhCreateTable(strSQL: String): Boolean;
begin
  Result := (Pos('CREATE', UpperCase(strSQL)) > 0) And
            (Pos('TABLE',  UpperCase(strSQL)) > 0);
end;

end.
