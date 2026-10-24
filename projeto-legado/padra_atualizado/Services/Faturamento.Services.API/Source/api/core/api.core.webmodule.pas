unit api.core.webmodule;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  Data.DB,
  MVCFramework;

type
  TApiWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FMVC: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TApiWebModule;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  MVCFramework.Commons,
  MVCFramework.Middleware.CORS,
  MVCFramework.Middleware.StaticFiles,
  MVCFramework.Middleware.Compression,
  MVCFramework.Middleware.Swagger,
  MVCFramework.Controllers.Register,
  api.core.common,
  api.core.authentication,
  api.core.documentation,
  api.core.connection;

procedure TApiWebModule.WebModuleCreate(Sender: TObject);
begin
  FMVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      // session timeout (0 means session cookie)
      Config[TMVCConfigKey.SessionTimeout] := '0';
      // default content-type
      Config[TMVCConfigKey.DefaultContentType] :=
        TMVCConstants.DEFAULT_CONTENT_TYPE;
      // default content charset
      Config[TMVCConfigKey.DefaultContentCharset] :=
        TMVCConstants.DEFAULT_CONTENT_CHARSET;
      // unhandled actions are permitted?
      Config[TMVCConfigKey.AllowUnhandledAction] := 'false';
      // default view file extension
      Config[TMVCConfigKey.DefaultViewFileExtension] := 'html';
      // view path
      Config[TMVCConfigKey.ViewPath] := 'templates';
      // Max Record Count for automatic Entities CRUD
      Config[TMVCConfigKey.MaxEntitiesRecordCount] := '20';
      // Enable Server Signature in response
      Config[TMVCConfigKey.ExposeServerSignature] := 'true';
      // Max request size in bytes
      Config[TMVCConfigKey.MaxRequestSize] :=
        IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE);

      Config[TMVCConfigKey.PathPrefix] := '/api';
      // disable MVC system API available in MVCFramework.SysControllers
      Config[TMVCConfigKey.LoadSystemControllers] := 'false';
    end);

  // Adds support to database connection
  FMVC.AddMiddleware(TConnectionMiddleware.Create);

  // Adds support to CORS (Cross-Origin Resource Sharing)
  FMVC.AddMiddleware(TCORSMiddleware.Create);

  // Adds support to JWT authentication
  FMVC.AddMiddleware(TServerApiAuthenticationMiddlewareSetup.CreateMiddleware);

  // Adds support to swagger REST API documentation
  FMVC.AddMiddleware(TMVCSwaggerMiddleware.Create(FMVC,
    TApiDocumentation.GetHeaderInformation('v1.0.0'),
    '/api/help/swagger.json',
    'Authentication JWT',
    False));

  // Adds support to static files
  FMVC.AddMiddleware(TMVCStaticFilesMiddleware.Create('/',
    // enable static files
    ExtractFilePath(GetModuleName(HInstance)) + 'www', { DocumentRoot }
    '/api/help/index.html'));
  // Define a default URL for requests that don't map to a route or a file (useful for client side web app)

  // To enable compression (deflate, gzip) just add this middleware as the last one
  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);

  // Adds your registered controllers to engine.
  TControllersRegister.Instance.AddControllersInEngine(FMVC, API_SERVER_NAME);
end;

procedure TApiWebModule.WebModuleDestroy(Sender: TObject);
begin
  FMVC.Free;
end;

end.
