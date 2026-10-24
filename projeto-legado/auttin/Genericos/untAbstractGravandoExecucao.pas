unit untAbstractGravandoExecucao;

interface

uses
  untIGravandoExecucao, untIGravando, untIGravandoExecucaoNome;

type
  TAbstractGravandoExecucao = class abstract (TInterfacedObject, IGravandoExecucao, IGravandoExecucaoNome)
  public
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fGetNomeGravacao(): string; virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual; abstract;
  end;

implementation

end.
