unit PitStop.classe.log;

interface

uses System.SysUtils, uni, madStackTrace;
Type

  TPitStopLog = class
  private
    qry: TUniQuery;
    FIdCon: String;
  public
    constructor Create(AIdCon: String);
    destructor Destroy; override;
    procedure RegistraLog(AMessage: String; ALocal: String; blnTrace: Boolean = False);
    class procedure RegistraLogExt(AIdCon: String; AMessage: String; ALocal: String; blnTrace: Boolean = False);

  End;


implementation

uses
  untFuncoesSimples;

{ TBuscaCotacaoPitStop }

constructor TPitStopLog.Create(AIdCon: String);
begin
  FIdCon := AidCon;
  qry:= fCriaQuery;
  qry.SQL.Add('INSERT INTO LOG_PITSTOP(LOG_ID_CON, LOG_RETAPI, LOG_LOCAL_) VALUES (:LOG_ID_CON, :LOG_RETAPI, :LOG_LOCAL_)');
end;

destructor TPitStopLog.Destroy;
begin
  FreeAndNil(qry);
end;

procedure TPitStopLog.RegistraLog(AMessage: String; ALocal: String; blnTrace: Boolean = False);
begin
  qry.paramByName('LOG_ID_CON').AsString :=  FIdCon;
  qry.paramByName('LOG_RETAPI').AsString :=  AMessage;
  If blnTrace then
    ALocal := IIF(ALocal <> '',ALocal +':' + #13, '') + StackTrace;
  qry.paramByName('LOG_LOCAL_').AsString :=  ALocal;
  qry.ExecSQL;
end;

class procedure TPitStopLog.RegistraLogExt(AIdCon, AMessage, ALocal: String; blnTrace: Boolean);
var lQry: TUniQuery;
begin
  lQry:= fCriaQuery;
  Try
    lQry.SQL.Add('INSERT INTO LOG_PITSTOP(LOG_ID_CON, LOG_RETAPI, LOG_LOCAL_) VALUES (:LOG_ID_CON, :LOG_RETAPI, :LOG_LOCAL_)');
    lQry.paramByName('LOG_ID_CON').AsString :=  AIdCon;
    lQry.paramByName('LOG_RETAPI').AsString :=  AMessage;
    If blnTrace then
      ALocal := IIF(ALocal <> '',ALocal +':' + #13, '') + StackTrace;
    lQry.paramByName('LOG_LOCAL_').AsString :=  ALocal;
    lQry.ExecSQL;
  Finally
    FreeAndNil(lQry);
  End;

end;

end.
