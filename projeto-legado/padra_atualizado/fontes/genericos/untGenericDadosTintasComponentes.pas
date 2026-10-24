unit untGenericDadosTintasComponentes;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, untIDadosTintasComponentes;

type
  TGenericDadosTintasComponentes = class(TInterfacedObject,
      IDadosTintasComponentes)
  private
    fltQuantidade: Double;
    strComponente: string;
  public
    constructor Create(const strComponente: string; const fltQuantidade:
        Double);
    function GetComponente: string;
    function GetQuantidade: Double;
    property Componente: string read GetComponente;
    property Quantidade: Double read GetQuantidade;
  end;


implementation

{
************************ TGenericDadosTintasComponentes ************************
}
constructor TGenericDadosTintasComponentes.Create(const strComponente: string;
    const fltQuantidade: Double);
begin
  inherited Create();
  Self.strComponente := strComponente;
  Self.fltQuantidade := fltQuantidade;
end;

function TGenericDadosTintasComponentes.GetComponente: string;
begin
  Result := strComponente;
end;

function TGenericDadosTintasComponentes.GetQuantidade: Double;
begin
  Result := fltQuantidade;
end;



end.
