{*********************************************************************}
{* Interface que representa a implementação de um menu no Auttin.exe *}
{******************************************************************PH*}
unit untIAuttinMenuItem;

interface

uses
  untIAuttinWrapper;

type
  IAuttinMenuItem = interface
    ['{D582FD93-4838-4D72-92A4-5D3133F9BF7A}']
    function GetCaption: string;
    function GetHint: string;
    function GetCont: Integer;
    function GetSubMenu(const index: Integer): IAuttinMenuItem;

    procedure Executar(const auttinWrapper: IAuttinWrapper);

    property Caption: string read GetCaption;
    property Hint: string read GetHint;
    property Cont: Integer read GetCont;
    property SubMenu[const index: Integer]: IAuttinMenuItem read GetSubMenu; default;
  end;

implementation

end.
