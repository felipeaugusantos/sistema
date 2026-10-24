{**************************************************************************************}
{* TCriadorTabelas: Classe que cria várias tabelas e mostra o progresso em um objeto  *}
{* IGravando                                                                          *}
{**********************************************************************************PH**}
unit untCriadorTabelas;

interface

uses
  untAbstractCriadorTabela, untIGravando, untIGravandoExecucao, untStatusGravando;

type
  TCriadorTabelas = class(TInterfacedObject)
  public
    class procedure CriarTabelas(const criadores: array of TAbstractCriadorTabela; const gravando: IGravando);
  end;

implementation

{ TCriadorTabelas }

class procedure TCriadorTabelas.CriarTabelas(const criadores: array of TAbstractCriadorTabela; const gravando: IGravando);
var
  gravandoExecucao: IGravandoExecucao;
  intCont: Integer;
begin
  for intCont := 0 to Length(criadores) - 1 do
  begin
    if gravando.Status <> sgGravando then
      Exit;

    gravandoExecucao := criadores[intCont] as IGravandoExecucao;
    gravando.Texto := 'Criando tabela ' + criadores[intCont].GetNomeTabela;
    gravandoExecucao.Executar(gravando);
    gravando.Texto := 'Tabela ' + criadores[intCont].GetNomeTabela + ' criada com sucesso!';
  end;
end;

end.
