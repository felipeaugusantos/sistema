{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Luztol *}
{*******************************************************************************AC*}
unit untConsultaCompLuztol;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompLuztol = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompLuztol }

procedure TConsultaCompLuztol.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadLUZNovasFormulas');
end;

end.
