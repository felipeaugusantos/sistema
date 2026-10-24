{*********************************************************************************************}
{* Interface que permite que outros sistemas gerencie as dll das tintas sem ter conhecimento *}
{* das implementações                                                                        *}
{******************************************************************************************PH*}
unit untILibTintaFactory;

interface

uses
  untILibTinta, Classes;

type
  ILibTintaFactory = interface
    ['{FFEC4128-BBE7-463C-B7D2-4F801CEAB209}']
    function GetITintadeMaquina(const strIdentificador: string): ILibTinta;
    procedure GetIdentificadores(const stlIdentificadores: TStrings);
    procedure GetTintaDLLDiretorio(const stlTintaDLLDiretorio: TStrings);
  end;

implementation

end.
