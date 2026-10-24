{**************************************************************************}
{* Classe responsável pela geração do cadastro de Personalizadas da tinta MazaAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoMazaAutomotivaPersonalizadas;

interface

uses
  untAbstractGravandoExecucaoMazaAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, untStrUtils;

type
  TGravandoExecucaoMazaAutomotivaPersonalizadas = class(TAbstractGravandoExecucaoMazaAutomotiva)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untGravandoExecucaoMazaAutomotivaNovasFormulas,
  untGravandoVazio, untIGravandoExecucaoNome, untFuncoesGenerica;

{ TGravandoExecucaoMazaAutomotivaPersonalizadas }


procedure TGravandoExecucaoMazaAutomotivaPersonalizadas.Executar(const gravando: IGravando);
begin
end;

function TGravandoExecucaoMazaAutomotivaPersonalizadas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Fórmulas Personalizadas';
end;

end.
