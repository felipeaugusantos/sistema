{***************************************************************************************}
{* TLibTintaControleVisualEventosFactory: Classe responsável por interligar um evento  *}
{* dinamico ILibTintaControleVisualEvento a um controle visual ILibTintaControleVisual *}
{***********************************************************************************PH**}
unit untLibTintaControleVisualEventosFactory;

interface

uses
  untILibTintaControleVisual, SysUtils, Classes, Controls, TypInfo, Dialogs, ObjAuto;

type
  TLibTintaControleVisualEventosFactory = class(TInterfacedObject)
  public
    class procedure RegistrarEvento(const evento: ILibTintaControleVisualEvento; const libTintaControleVisual: ILibTintaControleVisual;
      const telaCadLibTintas: ITelaCadLibTintas; const controle: TControl);
  end;


implementation

uses
  untControlILibTintaControleVisualWrapper;

class procedure TLibTintaControleVisualEventosFactory.RegistrarEvento(const evento: ILibTintaControleVisualEvento;
  const libTintaControleVisual: ILibTintaControleVisual; const telaCadLibTintas: ITelaCadLibTintas; const controle: TControl);
var
  metodo: TMethod;
begin
  Try
    Try
      if not Assigned(evento) then
        Exit;

      if Assigned(evento.GetMethodAddress) then
      begin
        evento.TelaCadLibTintas := telaCadLibTintas;
        evento.LibTintaControleVisual := TControlILibTintaControleVisualWrapper.Create(controle, telaCadLibTintas);

        metodo := GetMethodProp(controle, evento.Nome);
        metodo.Data := evento.GetImplementator;
        metodo.Code := evento.GetMethodAddress;
        SetMethodProp(controle, evento.Nome, metodo);
      end
      else
        raise Exception.CreateFmt('O evento %s.%s não está associado!', [libTintaControleVisual.Nome, evento.Nome]);

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;



end.
