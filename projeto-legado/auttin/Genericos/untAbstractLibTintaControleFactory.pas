{********************************************************************************************}
{* TAbstractLibTintaControleFactory: Classe abstrata contendo todos os metodos necessários  *}
{* para construir um objeto de um determinado tipo                                          *}
{****************************************************************************************PH**}
unit untAbstractLibTintaControleFactory;

interface

uses
  untILibTintaControleFactory, untILibTintaControleVisual, Controls, TypInfo, Classes,
  SysUtils, Variants, StrUtils;

type
  TAbstractLibTintaControleFactory = class abstract (TInterfacedObject, ILibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; virtual; abstract;
    procedure PreencherPropriedades(const libTintaControleVisual: ILibTintaControleVisual; const controle: TControl);
    procedure PreencherEventos(const libTintaControleVisual: ILibTintaControleVisual; const controle: TControl;
      const telaCadLibTintas: ITelaCadLibTintas);
  public
    function GetControle(const libTintaControleVisual: ILibTintaControleVisual; const parent: TControl;
      const telaCadLibTintas: ITelaCadLibTintas): TControl;
  end;

implementation

uses
  untLibTintaControleFactory, untLibTintaControleVisualEventosFactory;

{ TAbstractLibTintaControleFactory }

function TAbstractLibTintaControleFactory.GetControle(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl; const telaCadLibTintas: ITelaCadLibTintas): TControl;
var
  intCont: Integer;
begin
  Result := GetControleClasse(libTintaControleVisual, parent);
  if parent is TWinControl then
    Result.Parent := parent as TWinControl;

  if libTintaControleVisual.Nome <> '' then
    Result.Name := libTintaControleVisual.Nome;

  for intCont := 0 to libTintaControleVisual.ControlesCont - 1 do
  begin
    TLibTintaControleFactory.GetControl(libTintaControleVisual.Controle[intCont], Result, telaCadLibTintas);
  end;

  PreencherPropriedades(libTintaControleVisual, Result);
  PreencherEventos(libTintaControleVisual, Result, telaCadLibTintas);    
end;

procedure TAbstractLibTintaControleFactory.PreencherEventos(const libTintaControleVisual: ILibTintaControleVisual;
  const controle: TControl; const telaCadLibTintas: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  for intCont := 0 to libTintaControleVisual.EventosCont - 1 do
  begin
    Try
      TLibTintaControleVisualEventosFactory.RegistrarEvento(
        libTintaControleVisual.EventoIndex[intCont],
        libTintaControleVisual,
        telaCadLibTintas,
        controle);
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('[%s] %s: %s [%s.%s]', [
          'TAbstractLibTintaControleFactory.PreencherEventos',
          E.ClassName,
          E.Message,
          controle.Name,
          libTintaControleVisual.EventoIndex[intCont].Nome
        ]);

      end;
    End;

  end;
end;

procedure TAbstractLibTintaControleFactory.PreencherPropriedades(const libTintaControleVisual: ILibTintaControleVisual;
  const controle: TControl);
var
  intCont: Integer;
begin
  for intCont := 0 to libTintaControleVisual.PropriedadesCont - 1 do
  begin
    Try
      SetPropValue(controle, libTintaControleVisual.PropriedadeIndex[intCont].Nome,
        libTintaControleVisual.PropriedadeIndex[intCont].Value);
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('%s: %s [%s.%s = %s]', [
          E.ClassName,
          E.Message,
          libTintaControleVisual.Nome,
          libTintaControleVisual.PropriedadeIndex[intCont].Nome,
          VarToStr(libTintaControleVisual.PropriedadeIndex[intCont].Value)
        ]);
      end;
    End;
  end;
end;

end.
