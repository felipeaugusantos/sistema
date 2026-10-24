{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta RennerIndustrial *}
{*******************************************************************************AC*}
unit untConsultaCompRennerIndustrial;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompRennerIndustrial = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompRennerIndustrial }

procedure TConsultaCompRennerIndustrial.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadRENNovasFormulas');
end;

end.
