unit untAuditoriaLog;

interface

type

  IAuditoriaLog = interface
    ['{362C63B0-7797-4910-B933-3D0593B789E0}']
    function setAuditoria(AValue : String) : IAuditoriaLog;
    function setParametro(AValue : String) : IAuditoriaLog;
    function setResultado(AValue : String) : IAuditoriaLog;
    function setOpeLogado(AValue : String) : IAuditoriaLog;
    procedure Gravar;
  end;

  TAuditoriaLog = class(TInterfacedObject, IAuditoriaLog)
  private
    FAuditoria : String;
    FParametro : String;
    FResultado : String;
    FOpeLogado : String;
  public
    function setAuditoria(AValue : String) : IAuditoriaLog;
    function setParametro(AValue : String) : IAuditoriaLog;
    function setResultado(AValue : String) : IAuditoriaLog;
    function setOpeLogado(AValue : String) : IAuditoriaLog;

    procedure Gravar;

    constructor Create;
    destructor  Destroy(); Override;

    class function New() : IAuditoriaLog;

  end;

implementation

Uses
  SysUtils, Uni, untFuncoesSimples;

{ TAuditoriaLog }

constructor TAuditoriaLog.Create;
begin
  FAuditoria := '';
  FParametro := '';
  FResultado := '';
  FOpeLogado := '';
end;

destructor TAuditoriaLog.Destroy;
begin
  inherited;
end;

procedure TAuditoriaLog.Gravar;
  var
    LLog : TUniQuery;
begin

  LLog := fCriaQuery();

  Try

    LLog.Close;
    LLog.SQL.Clear;
    LLog.SQL.Add('INSERT INTO AUDLOG (');
    LLog.SQL.Add('  LOG_DTALOG, ');
    LLog.SQL.Add('  LOG_HRALOG, ');
    LLog.SQL.Add('  LOG_AUDEXE, ');
    LLog.SQL.Add('  LOG_AUDPAR, ');
    LLog.SQL.Add('  LOG_AUDRES, ');
    LLog.SQL.Add('  LOG_OPELOG) VALUES (');
    LLog.SQL.Add('  CURRENT_DATE, ');
    LLog.SQL.Add('  CURRENT_TIME, ');
    LLog.SQL.Add('  :AUDEXE, ');
    LLog.SQL.Add('  :AUDPAR, ');
    LLog.SQL.Add('  :AUDRES, ');
    LLog.SQL.Add('  :OPELOG) ');

    LLog.ParamByName('AUDEXE').AsString := FAuditoria;
    LLog.ParamByName('AUDPAR').AsString := FParametro;
    LLog.ParamByName('AUDRES').AsString := FResultado;
    LLog.ParamByName('OPELOG').AsString := FOpeLogado;
    LLog.ExecSQL;

  Finally
    FreeAndNil(LLog);
  End;

end;

class function TAuditoriaLog.New: IAuditoriaLog;
begin
  Result := Self.Create;
end;

function TAuditoriaLog.setAuditoria(AValue: String): IAuditoriaLog;
begin
  Result := Self;
  FAuditoria := AValue;
end;

function TAuditoriaLog.setOpeLogado(AValue: String): IAuditoriaLog;
begin
  Result := Self;
  FOpeLogado := AValue;
end;

function TAuditoriaLog.setParametro(AValue: String): IAuditoriaLog;
begin
  Result := Self;
  FParametro := AValue;
end;

function TAuditoriaLog.setResultado(AValue: String): IAuditoriaLog;
begin
  Result := Self;
  FResultado := AValue;
end;

end.
