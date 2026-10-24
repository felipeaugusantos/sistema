{*************************************************************************************}
{* Interface que extende a interface IGravandoExecucao colocando mais um metodo para *}
{* obter o nome do processo que está sendo executado                                 *}
{**********************************************************************************PH*}
unit untIGravandoExecucaoNome;

interface

uses
  untIGravandoExecucao;

type
  IGravandoExecucaoNome = interface(IGravandoExecucao)
    ['{AC8E0731-9FB9-4590-99AF-15C7FE5CF936}']
    function fGetNomeGravacao(): string;
    function fHabilitaOpcao(): Boolean;
  end; 

implementation

end.
