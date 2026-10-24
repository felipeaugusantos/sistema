unit api.core.authentication;

interface

uses
  MVCFramework,
  System.Generics.Collections,
  Services.core.Settings,
  MVCFramework.Middleware.authentication.RoleBasedAuthHandler;

type
  TServerApiAuthenticationMiddlewareSetup = class sealed(TObject)
  public
    class function CreateMiddleware: IMVCMiddleware;
  end;

  TServerApiAuthenticationHandler = class(TRoleBasedAuthHandler)
  private
    function ValidAuthentication(const pLogin, pPassword: string): boolean;
  public
    procedure OnAuthentication(const AContext: TWebContext;
      const UserName: string; const Password: string; UserRoles: TList<string>;
      var IsValid: boolean;
      const SessionData: TDictionary<string, string>); override;
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  MVCFramework.JWT,
  MVCFramework.Middleware.JWT;

{ TServerApiAuthenticationMiddlewareSetup }

class function TServerApiAuthenticationMiddlewareSetup.CreateMiddleware
  : IMVCMiddleware;
const
  URI_AUTHENTICATION = '/api/login';
  JWT_SECRET_KEY = 'senha-secreta-jwt';
  LOGIN_FIELDNAME = 'jwtusername';
  PASSWORD_FIELDNAME = 'jwtpassword';
  LEEWAY_SECONDS = 300;
var
  vClaimsSetup: TJWTClaimsSetup;
begin
  vClaimsSetup := procedure(const JWT: TJWT)
    begin
      JWT.Claims.Issuer := 'Server API';
      JWT.Claims.ExpirationTime := IncHour(Now, 24);
      JWT.Claims.NotBefore := Now - OneMinute * 5;
      JWT.Claims.IssuedAt := Now - OneMinute * 5;
    end;

  Result := TMVCJWTAuthenticationMiddleware.Create
    (TServerApiAuthenticationHandler.Create, vClaimsSetup, JWT_SECRET_KEY,
    URI_AUTHENTICATION, [TJWTCheckableClaim.ExpirationTime,
    TJWTCheckableClaim.NotBefore, TJWTCheckableClaim.IssuedAt], LEEWAY_SECONDS,
    TMVCJWTDefaults.AUTHORIZATION_HEADER, LOGIN_FIELDNAME, PASSWORD_FIELDNAME);
end;

{ TServerApiAuthenticationHandler }

procedure TServerApiAuthenticationHandler.OnAuthentication(const AContext
  : TWebContext; const UserName, Password: string; UserRoles: TList<string>;
  var IsValid: boolean; const SessionData: TDictionary<string, string>);
begin
  IsValid := ValidAuthentication(UserName, Password);
end;

function TServerApiAuthenticationHandler.ValidAuthentication(const pLogin,
  pPassword: string): boolean;
begin
  Result := (pLogin = fCfgSis('LOGFSA')) and (pPassword = fCfgSis('SENFSA'));
end;

end.
