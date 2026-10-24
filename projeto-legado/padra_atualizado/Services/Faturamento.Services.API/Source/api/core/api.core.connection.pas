unit api.core.connection;

interface

uses
  System.Classes, Data.DB, System.Generics.Collections, MVCFramework;

type
  TConnectionMiddleware = class(TInterfacedObject, IMVCMiddleware)
  protected
    procedure OnBeforeRouting(AContext: TWebContext; var AHandled: Boolean);

    procedure OnBeforeControllerAction(AContext: TWebContext;
      const AControllerQualifiedClassName: string; const AActionName: string;
      var AHandled: Boolean);

    procedure OnAfterControllerAction(AContext: TWebContext;
      const AActionName: string; const AHandled: Boolean);

    procedure OnAfterRouting(AContext: TWebContext; const AHandled: Boolean);
  end;

implementation

uses
  System.SysUtils, Services.Core.Connection.Manager;

{ TConnectionMiddleware }

procedure TConnectionMiddleware.OnAfterControllerAction(AContext: TWebContext;
  const AActionName: string; const AHandled: Boolean);
begin
  // do nothing
end;

procedure TConnectionMiddleware.OnAfterRouting(AContext: TWebContext;
  const AHandled: Boolean);
begin
  objConnectionsManager.EndConnection;
end;

procedure TConnectionMiddleware.OnBeforeControllerAction(AContext: TWebContext;
  const AControllerQualifiedClassName, AActionName: string;
  var AHandled: Boolean);
begin
  // do nothing
end;

procedure TConnectionMiddleware.OnBeforeRouting(AContext: TWebContext;
  var AHandled: Boolean);
begin
  objConnectionsManager.BeginConnection;
  AHandled := False;
end;

end.
