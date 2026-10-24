{**********************************************************************************}
{* Classe responsável pela implementação de um item de menu que aparece no Auttin *}
{*******************************************************************************PH*}
unit untGenericAuttinMenuItem;

interface

uses
  untIAuttinMenuItem, Classes, untIAuttinWrapper;

type
  TGenericAuttinMenuItem = class(TInterfacedObject, IAuttinMenuItem)
  protected
    strCaption: string;
    strHint: string;
    lstMenus: IInterfaceList;
  public
    constructor Create(const strCaption: string; const strHint: string);
    procedure Adicionar(const auttinMenuItem: IAuttinMenuItem);
    procedure Executar(const auttinWrapper: IAuttinWrapper); virtual; 
    function GetCaption: string;
    function GetCont: Integer;
    function GetHint: string;
    function GetSubMenu(const index: Integer): IAuttinMenuItem;
  end;

implementation

{ TAbstractAuttinMenuItem }

procedure TGenericAuttinMenuItem.Adicionar(const auttinMenuItem: IAuttinMenuItem);
begin
  lstMenus.Add(auttinMenuItem);
end;

constructor TGenericAuttinMenuItem.Create(const strCaption, strHint: string);
begin
  inherited Create();
  Self.strCaption := strCaption;
  Self.strHint := strHint;
  Self.lstMenus := TInterfaceList.Create;
end;

procedure TGenericAuttinMenuItem.Executar(const auttinWrapper: IAuttinWrapper);
begin
end;

function TGenericAuttinMenuItem.GetCaption: string;
begin
  Result := strCaption;
end;

function TGenericAuttinMenuItem.GetCont: Integer;
begin
  Result := lstMenus.Count;
end;

function TGenericAuttinMenuItem.GetHint: string;
begin
  Result := strHint;
end;

function TGenericAuttinMenuItem.GetSubMenu(const index: Integer): IAuttinMenuItem;
begin
  Result := lstMenus[index] as IAuttinMenuItem;
end;

end.
