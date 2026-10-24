{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta RennerPerformance *}
{*******************************************************************************AC*}
unit untConsultaCompRennerPerformance;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompRennerPerformance = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompRennerPerformance }

procedure TConsultaCompRennerPerformance.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadREPNovasFormulas');
end;

end.
