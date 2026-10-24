{*****************************************************************************************}
{* Interface que representa a implementação do que vai ser executado, atraves do metodo  *}
{* procedure Executar(const gravando: IGravando), sendo possivle interagir qualquer ação *}
{* com qualquer tela                                                                     *}
{**************************************************************************************PH*}
unit untIGravandoExecucao;

interface

uses
  untIGravando;

type
  IGravandoExecucao = interface
    ['{72B5CDFE-840B-4AB7-8BF1-034B864FEE8A}']
    procedure Executar(const gravando: IGravando);
  end;

implementation

end.
