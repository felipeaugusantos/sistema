{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Resicolor2 *}
{*******************************************************************************AC*}
unit untConsultaCompResicolor2;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompResicolor2 = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompResicolor2 }

procedure TConsultaCompResicolor2.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadRS2NovasFormulas');
end;

end.
