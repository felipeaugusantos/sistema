unit LalaMove.Authentication;

interface

uses System.SysUtils;

type
  TLalaMoveAuthentication = class
  private
    function RetornaTimeStampEmMilisegundos: Int64;
    function GetUTC(const ADateTime : TDateTime) : TDateTime;
  public
    type
      TInput = record
        secretKey: string;
        method: string;
        path: string;
        body: string;
        apiKey: string;
      End;
  public
    function getToken(const AInput : TLalaMoveAuthentication.TInput) : string;
  End;

implementation

uses System.Hash, System.DateUtils;

{ TLalaMoveAuthentication }

function TLalaMoveAuthentication.getToken(const AInput : TLalaMoveAuthentication.TInput): string;
  Var
    signature : string;
    rawSignature : String;
    TimeStampStr: string;
begin
  TimeStampStr := IntToStr(RetornaTimeStampEmMilisegundos);
  rawSignature := TimeStampStr + #13#10 + AInput.method + #13#10 + AInput.path + #13#10 + #13#10 + AInput.body;
  signature := THashSHA2.GetHMAC(rawSignature, AInput.secretKey, SHA256);
  Result := AInput.apiKey + ':' + TimeStampStr + ':' + signature;
end;

function TLalaMoveAuthentication.RetornaTimeStampEmMilisegundos: Int64;
begin
  Result := MilliSecondsBetween(GetUTC(System.SysUtils.nOw), UnixDateDelta);
End;

function TLalaMoveAuthentication.GetUTC(const ADateTime : TDateTime) : TDateTime;
begin
  Result := TTimeZone.Local.ToUniversalTime(ADateTime);
end;

end.
