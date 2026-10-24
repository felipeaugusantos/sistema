{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta AdvanceTintoSystem *}
{*******************************************************************************AC*}
unit untConsultaCompAdvanceTintoSystem;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompAdvanceTintoSystem = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompAdvanceTintoSystem }

procedure TConsultaCompAdvanceTintoSystem.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadADTNovasFormulas');
end;

end.
