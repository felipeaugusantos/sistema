{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Resicolor *}
{*******************************************************************************AC*}
unit untConsultaCompResicolor;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompResicolor = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompResicolor }

procedure TConsultaCompResicolor.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadRSINovasFormulas');
end;

end.
