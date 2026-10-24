unit untLogTef;

interface

uses System.Classes ;

type
  TLogTef = Class
  public
    class var blnExcedeuTempoTEF: Boolean;
    class var strNumSer: String;
    class var intNumCoo: Integer; 
    class var blnLogarTEF: Boolean;

    class procedure pCriarTabelaLOGTEF;
    class procedure pLoga(strMetodo, strConteu: String; strConteudoArq: String = '');
    class procedure pLogaBloco(const AlstLog: TStringList) ;
  End;

implementation

uses SysUtils, Uni, untFuncoesSimples, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms, Data.DB;

{ TLogTef }

class procedure TLogTef.pCriarTabelaLOGTEF;
  Var
    qryLogTef : TUniQuery;
begin
  qryLogTef := fCriaQuery(Nil);
  Try
    qryLogTef.SQL.Add('CREATE TABLE LOGTEF( ');
    qryLogTef.SQL.Add('  AUTOINCREM BIGINT(20) NOT NULL AUTO_INCREMENT, ');
    qryLogTef.SQL.Add('  LOG_DTALOG DATE DEFAULT NULL, ');
    qryLogTef.SQL.Add('  LOG_HRALOG TIME DEFAULT NULL, ');
    qryLogTef.SQL.Add('  LOG_METODO VARCHAR(50), ');
    qryLogTef.SQL.Add('  LOG_NUMSER VARCHAR(20) DEFAULT "", ');
    qryLogTef.SQL.Add('  LOG_NUMCOO INT DEFAULT 0, ');
    qryLogTef.SQL.Add('  LOG_CONTEU TEXT, ');

    qryLogTef.SQL.Add('  LOG_CODOPE CHAR(3), ');
    qryLogTef.SQL.Add('  LOG_NUM_IP VARCHAR(20), ');
    qryLogTef.SQL.Add('  LOG_NOMMAQ VARCHAR(20), ');
    qryLogTef.SQL.Add('  LOG_NOMUSU VARCHAR(50), ');
    qryLogTef.SQL.Add('  LOG_CONTXT TEXT, ');

    qryLogTef.SQL.Add('  PRIMARY KEY (AUTOINCREM) ');
    qryLogTef.SQL.Add(' )ENGINE=INNODB ');
    qryLogTef.ExecSQL;
  Finally
    FreeAndNil(qryLogTef);
  End;
end;

class procedure TLogTef.pLoga(strMetodo, strConteu: String; strConteudoArq : String = '');
  Var
    qryLogTef : TUniQuery;
begin
  If (Not TLogTef.blnLogarTEF) Then
    Exit;

  qryLogTef := fCriaQuery(Nil);
  Try
    Try
      With qryLogTef Do
      Begin
        SQL.Text := 'SELECT * FROM LOGTEF WHERE FALSE';
        Open;

        Insert;
        FieldByName('LOG_METODO').AsString   := strMetodo;
        FieldByName('LOG_CONTEU').AsString   := strConteu;
        FieldByName('LOG_DTALOG').AsDateTime := VS_Date;
        FieldByName('LOG_HRALOG').AsDateTime := fTime();
        FieldByName('LOG_NUMSER').AsString   := strNumSer;
        FieldByName('LOG_NUMCOO').AsInteger  := intNumCoo;

        FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
        if not fEmptyStr(VS_strCodigoOperadorLogadoCaixa) then
          FieldByName('LOG_CODOPE').AsString := VS_strCodigoOperadorLogadoCaixa;

        FieldByName('LOG_NUM_IP').AsString   := VS_IPAddressAsString;
        FieldByName('LOG_NOMMAQ').AsString   := VS_ComputerNetName;
        FieldByName('LOG_NOMUSU').AsString   := VS_UserFromWindows;
        FieldByName('LOG_CONTXT').AsString   := strConteudoArq;
        Post;

        Close;
      End;
    Except
    End;
  Finally
    FreeAndNil(qryLogTef);
  End;
end;

class procedure TLogTef.pLogaBloco(const AlstLog: TStringList);
var
  LDDatabase   : TFDConnection;
  LDDriverLink : TFDPhysMySQLDriverLink;
  LDCursor     : TFDGUIxWaitCursor;
  LqryAux      : TUniQuery;
  LqryExec     : TFDQuery;
  LintCnt      : Integer;
begin
  if not fCfgSis('LGTFCT', VarBoolean) then
    Exit ;

  if AlstLog.Count = 0 then
    Exit ;

  LDDatabase   := TFDConnection.Create(Nil);
  LDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  LDCursor     := TFDGUIxWaitCursor.Create(Nil);
  LqryAux      := fCriaQuery();
  LqryExec     := TFDQuery.Create(Nil);
  try

    LDDatabase.Params.Add('Database=' + LqryAux.Connection.Database);
    LDDatabase.Params.Add('User_Name=' + LqryAux.Connection.Username);
    LDDatabase.Params.Add('Password=' + LqryAux.Connection.Password);
    LDDatabase.Params.Add('Port=' + IntToStr(LqryAux.Connection.Port));
    LDDatabase.Params.Add('Server=' + LqryAux.Connection.Server);
    LDDatabase.Params.Add('DriverID=MySQL');

    if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
      LDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
    else
      LDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

    LDDatabase.Connected := True;

    LqryExec.Connection := LDDatabase ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' INSERT INTO LOGTEF (LOG_DTALOG, LOG_HRALOG, LOG_CONTEU, LOG_CODOPE, LOG_NUM_IP, LOG_NOMMAQ, LOG_NOMUSU) VALUES (:DTALOG, :HRALOG, :CONTEU, :CODOPE, :NUM_IP, :NOMMAQ, :NOMUSU) ') ;
    LqryExec.Params.ClearValues();
    LqryExec.Params.ArraySize := AlstLog.Count;
    LqryExec.ParamByName('CONTEU').DataType := ftString;
    LqryExec.ParamByName('DTALOG').DataType := ftdate;
    LqryExec.ParamByName('HRALOG').DataType := ftdatetime;
    for LintCnt := 0 to Pred(AlstLog.Count) do
    begin
      LqryExec.ParamByName('CONTEU').AsStrings[LintCnt] := AlstLog.Strings[LintCnt];
      LqryExec.ParamByName('DTALOG').AsDates[LintCnt] := VS_Date;
      LqryExec.ParamByName('HRALOG').AsDateTimes[LintCnt] := fTime();
      LqryExec.ParamByName('CODOPE').AsStrings[LintCnt] := strLoginUsuarioLogado;
      if not fEmptyStr(VS_strCodigoOperadorLogadoCaixa) then
        LqryExec.ParamByName('CODOPE').AsStrings[LintCnt] := VS_strCodigoOperadorLogadoCaixa;

      LqryExec.ParamByName('NUM_IP').AsStrings[LintCnt]   := VS_IPAddressAsString;
      LqryExec.ParamByName('NOMMAQ').AsStrings[LintCnt]   := VS_ComputerNetName;
      LqryExec.ParamByName('NOMUSU').AsStrings[LintCnt]   := VS_UserFromWindows;
    end ;
    LqryExec.Execute(AlstLog.Count, 0);

  finally
    FreeAndNil(LDDatabase) ;
    FreeAndNil(LDDriverLink) ;
    FreeAndNil(LDCursor) ;
    FreeAndNil(LqryAux) ;
    FreeAndNil(LqryExec) ;
  end ;

end;

end.
