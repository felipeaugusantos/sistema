{****************************************************************************************}
{* Factory responsável pela entrega de um objeto TAbstractLibTinta para todo o projeto, *}
{* assim é possivel obter a tinta em qualquer parte do projeto.                         *}
{*************************************************************************************PH*}
unit untLibTintaFactory;

interface

uses
  untAbstractLibTinta;

type
  TLibTintaFactory = class(TInterfacedObject)
  private
    class var libTinta: TAbstractLibTinta;
  public
    class procedure Registrar(const libTinta: TAbstractLibTinta);
    class function GetLibTinta(): TAbstractLibTinta;
  end;

implementation

{ TLibTintaFactory }

class function TLibTintaFactory.GetLibTinta: TAbstractLibTinta;
begin
  Result := libTinta;
end;

class procedure TLibTintaFactory.Registrar(const libTinta: TAbstractLibTinta);
begin
  TLibTintaFactory.libTinta := libTinta;
end;

initialization
  TLibTintaFactory.libTinta := nil;

end.
