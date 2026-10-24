library api.client;

uses
  ShareMem,
  System.SysUtils,
  System.Classes,

  OpenSSL.Core in 'OpenSSL.Core.pas',
  OpenSSL.libeay32 in 'OpenSSL.libeay32.pas',
  OpenSSL.RSAUtils in 'OpenSSL.RSAUtils.pas',
  api.client.main in 'api.client.main.pas',
  api.client.core in 'api.client.core.pas',
  api.client.json in 'api.client.json.pas';

{$R *.res}

exports
  Execute,
  ExecuteAuth,
  ExecuteAuth2,
  GetJsonValue,
  GetJsonArrayCount,
  GetJsonArrayValue,
  GetToken,
  GetTokenPrefix;

begin

end.
