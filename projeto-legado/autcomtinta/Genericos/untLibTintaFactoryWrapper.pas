{*************************************************************************************************}
{* Classe responsável por invovar os metodos da classe TLibTintaFactory, e que implementa a      *}
{* interface ILibTintaFactory, com isso é possivel gerenciar as dll das tintas em outros         *}
{* projetos, pois a função function GetLibTintaFactory(): ILibTintaFactory; stdcall; é exportada *}
{**********************************************************************************************PH*}
unit untLibTintaFactoryWrapper;

interface

uses
  untILibTinta, Classes, untILibTintaFactory, untLibTintaFactory;

type
  TLibTintaFactoryWrapper = class(TInterfacedObject, ILibTintaFactory)
  public
    function GetITintadeMaquina(const strIdentificador: string): ILibTinta;
    procedure GetIdentificadores(const stlIdentificadores: TStrings);
    procedure GetTintaDLLDiretorio(const stlTintaDLLDiretorio: TStrings);
  end;

  function GetLibTintaFactory(): ILibTintaFactory; stdcall;

implementation

{ TLibTintaFactory }

procedure TLibTintaFactoryWrapper.GetIdentificadores(const stlIdentificadores: TStrings);
begin
  TLibTintaFactory.GetIdentificadores(stlIdentificadores);
end;

function TLibTintaFactoryWrapper.GetITintadeMaquina(const strIdentificador: string): ILibTinta;
begin
  Result := TLibTintaFactory.GetITintadeMaquina(strIdentificador);
end;

procedure TLibTintaFactoryWrapper.GetTintaDLLDiretorio(
  const stlTintaDLLDiretorio: TStrings);
begin
  TLibTintaFactory.GetTintaDLLDiretorio(stlTintaDLLDiretorio);
end;

function GetLibTintaFactory(): ILibTintaFactory; stdcall;
begin
  Result := TLibTintaFactoryWrapper.Create;
end;

end.
