{**************************************}
{* INTERFACE DE PERSISTENCIA DE DADOS *}
{*04/05/2015************************AF*}
unit untObjectManager;

interface

uses Aurelius.Drivers.Interfaces, Aurelius.Drivers.UniDac, Aurelius.Engine.ObjectManager,
  untModulo, Aurelius.SQL.MySQL, Classes, TypInfo, System.Generics.Collections,
  Aurelius.Mapping.Metadata, System.SysUtils, Aurelius.Criteria.Base;

Type
  TObjManager = class
  private
    MyConnection: IDBConnection;
    objMgrDba   : TObjectManager;

    function fGetObjManager: TObjectManager;

  public
    Constructor Create;
    Destructor Destroy; Override;

    property objDBManager: TObjectManager Read objMgrDba;
  End;

  function fCriaObjManager(Var blnCriou: Boolean): TObjManager;

  Var
    frwk: TObjManager;

implementation

uses untFuncoesSimples;

constructor TObjManager.Create;
begin
  objMgrDba := fGetObjManager;
end;

destructor TObjManager.Destroy;
begin
  objMgrDba.Free;
  Inherited;
end;

function TObjManager.fGetObjManager: TObjectManager;
Begin
  MyConnection := TUniDacConnectionAdapter.Create(frmModulo.GetCurrentConnection, False);
  Result := TObjectManager.Create(MyConnection);
End;

function fCriaObjManager(Var blnCriou: Boolean): TObjManager;
Begin
  If Not Assigned(frwk) Then
  Begin
    frwk := TObjManager.Create;
    blnCriou := True;
  End;

  Result := frwk;
End;

end.
