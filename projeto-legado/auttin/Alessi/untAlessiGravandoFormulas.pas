unit untAlessiGravandoFormulas;

interface

uses
  untIGravandoExecucao, untIGravando;

type
  TAbstractAlessiGravando = class(TInterfacedObject, IGravandoExecucao)
  public
    procedure Executar(gravando: IGravando);
  end;

implementation

{ TAlessiGravandoFormulas }

procedure TAbstractAlessiGravando.Executar(gravando: IGravando);
begin

end;

end.
