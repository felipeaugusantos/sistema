unit untGravandoVazio;

interface

uses
  untIGravando, untStatusGravando;

type
  TGravandoVazio = class(TInterfacedObject, IGravando)
  public
    procedure Cancelar;
    function GetStatus: TStatusGravando;
    function GetTexto: string;
    procedure RegistrarProgresso(intInicio: Integer; intAtual: Integer;
      intFinal: Integer);
    procedure SetTexto(strTexto: string);
  end;

implementation

{ TGravandoVazio }

procedure TGravandoVazio.Cancelar;
begin
end;

function TGravandoVazio.GetStatus: TStatusGravando;
begin
  Result := sgGravando;
end;

function TGravandoVazio.GetTexto: string;
begin
  Result := '';
end;

procedure TGravandoVazio.RegistrarProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
end;

procedure TGravandoVazio.SetTexto(strTexto: string);
begin
end;

end.
