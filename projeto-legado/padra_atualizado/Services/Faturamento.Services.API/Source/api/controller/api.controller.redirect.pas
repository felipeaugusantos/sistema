unit api.controller.redirect;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Swagger.Commons,
  MVCFramework.Serializer.Commons;

type
  [MVCPath]
  TRedirectController = class(TMVCController)
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    [MVCSwagIgnorePathAttribute()]
    procedure Index;
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils,
  MVCFramework.Controllers.Register,
  api.core.common;

procedure TRedirectController.Index;
begin
  redirect('/api/help/index.html');
end;

initialization

TControllersRegister.Instance.RegisterController(TRedirectController,
  API_SERVER_NAME);

end.
