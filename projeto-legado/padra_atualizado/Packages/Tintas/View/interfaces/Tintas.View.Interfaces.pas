unit Tintas.View.Interfaces;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.UITypes;

type
  ISelecionaTinta = interface
    ['{6B263317-F99F-405B-BC05-EED914EA3B2D}']
    function SetListaTintas(ALista: TStringList):ISelecionaTinta;
    function GetListaTintas: TStringList;
    function EscolheTintaNovo: ShortString;
  end;


implementation

end.
