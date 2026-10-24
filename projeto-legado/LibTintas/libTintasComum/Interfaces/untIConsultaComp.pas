{**************************************************************************************}
{* Interface que representa as implementações dos botões da tela de consulta da tinta *}
{***********************************************************************************PH*}
unit untIConsultaComp;

interface

uses
  untIConsultaCompTintaNovaConfigurador, untIDicionario;

type
  IConsultaComp = interface
  ['{99114889-FB55-4706-A8B4-FB428701BB6D}']
    procedure pTarefaFormulacao(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador; dicRetorno: IDicionario);
    procedure pTarefaPrecos(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador; dicRetorno: IDicionario);
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
  end;

implementation

end.
