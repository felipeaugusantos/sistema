{***************************************}
{* CLASSE DESENVOLVIDA PARA GRAVAÇÃO   *}
{* DO INNODB STATUS.                   *}
{***************************************}
{* OBS: UTILIZA O FIREDAC PARA CONEXÃO *}
{* POIS O UNIDAC CORTA O STATUS        *}
{************************************AF*}
unit untGravaINNODBStatus;

interface

uses Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

Type
  TINNODBStatus = Class(TComponent)
  private
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;

    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    FDCursor    : TFDGUIxWaitCursor;
    qryDados    : TFDQuery;

    procedure pConfiguraConexao;
  public
    Constructor Create(Owner: TComponent; strDatabaseName, strUserName, strPassword, strPort, strIPServer: String); Reintroduce;
    Destructor Destroy; Override;

    function fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String;
  End;

implementation

uses System.SysUtils, VCL.Forms, System.StrUtils ;

{ TINNODBStatus }

constructor TINNODBStatus.Create(Owner: TComponent; strDatabaseName,
  strUserName, strPassword, strPort, strIPServer: String);
begin
  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + strDatabaseName;
  FUser_Name := 'User_Name=' + strUserName;
  FPassword  := 'Password=' + strPassword;
  FPort      := 'Port=' + strPort;
  FServer    := 'Server=' + strIPServer;

  FDDatabase   := TFDConnection.Create(Self);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Self);
  FDCursor     := TFDGUIxWaitCursor.Create(Self);
  qryDados     := TFDQuery.Create(Self);

  pConfiguraConexao;
end;

procedure TINNODBStatus.pConfiguraConexao;
begin
  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  FDDatabase.Connected := True;

  qryDados.Connection := FDDatabase;
end;

destructor TINNODBStatus.Destroy;
begin
  FDDatabase.Connected := False;
  inherited;
end;

function TINNODBStatus.fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String;
  Var
    stlInnoDB      : TStringList;
    strInnoDBLine  : String;
    intInnoDBLine  : Integer;
    intIndex       : Integer;
    intNumberFields: Integer;
    intLatestForeignKey: Integer;
Begin
  intNumberFields := 0;
  Result := '';

  qryDados.SQL.Add('SHOW ENGINE INNODB STATUS');
  qryDados.Open;

  stlInnoDB := TStringList.Create;

  If qryDados.FindField('Status') <> Nil Then
  Begin
    stlInnoDB.Text := qryDados.FieldByName('Status').AsString;
    strRetInnoDB   := qryDados.FieldByName('Status').AsString;
  End;

  { ------------------------ }
  { LATEST FOREIGN KEY ERROR }
  { ------------------------ }
  intLatestForeignKey := stlInnoDB.IndexOf('LATEST FOREIGN KEY ERROR');

  If intLatestForeignKey <> -1 Then
  Begin
    For intInnoDBLine := (intLatestForeignKey + 2) To stlInnoDB.Count -1 Do
    Begin
      strInnoDBLine := Trim(stlInnoDB[intInnoDBLine]);

      If AnsiStartsStr('Foreign key constraint fails for table', strInnoDBLine) Then
      Begin
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, '`', '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, '/', '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, ':', '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, FDatabase, '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'Foreign key constraint fails for table', 'Tabela de Gravação:');

        Result := Result + ' ' + strInnoDBLine;
      End;

      If AnsiStartsStr('CONSTRAINT ', strInnoDBLine) Then
      Begin
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'FOREIGN KEY', #13#10 + 'Campos de Gravação:');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'CONSTRAINT',  #13#10 + 'Foreign Key:');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'REFERENCES',  #13#10 + 'Tabela de Referência:');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'ON DELETE',   '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'ON UPDATE',   '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'NO ACTION',   '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'CASCADE',     '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, '`',           '');

        Result := Result + ' ' + strInnoDBLine;

        strInnoDBLine := Copy(strInnoDBLine, Pos('(', strInnoDBLine), Pos(')', strInnoDBLine) - Pos('(', strInnoDBLine));
        intNumberFields := Length(strInnoDBLine) - Length(AnsiReplaceStr(strInnoDBLine, ',', '')) + 1;
      End;

      If AnsiStartsStr('0: ', strInnoDBLine) Then
      Begin
        Result := Result + #13#10 + 'Valores Gravados: (';

        For intIndex := 0 To intNumberFields -1 Do
        Begin
          Delete(strInnoDBLine, 1, Pos('asc', strInnoDBLine) + 3);

          If Copy(strInnoDBLine, 1, Pos(';', strInnoDBLine)) = ';' Then
            Result := Result + 'EM BRANCO;'
          Else
            Result := Result + Copy(strInnoDBLine, 1, Pos(';', strInnoDBLine));
        End;

        If RightStr(Result, 1) = ';' Then
          Result := LeftStr(Result, Length(Result) - 1);

        Result := Result + ')';

        Break;
      End;

      If Pos('------------', strInnoDBLine) > 0 Then
        Break;
    End;
  End;

  Result := Trim(Result);
  FreeAndNil(stlInnoDB);
End;

end.
