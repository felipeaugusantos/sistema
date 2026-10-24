{**************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta KillingIndustrial *}
{***********************************************************************AC*}
unit untConsultaCompKillingIndustrial;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompKillingIndustrial = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompKillingIndustrial }

procedure TConsultaCompKillingIndustrial.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadKINNovasFormulas');
end;

end.
