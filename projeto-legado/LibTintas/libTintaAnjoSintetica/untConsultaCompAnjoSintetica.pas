{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta AnjoSintetica *}
{*******************************************************************************AC*}
unit untConsultaCompAnjoSintetica;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompAnjoSintetica = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompAnjoSintetica }

procedure TConsultaCompAnjoSintetica.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadAJANovasFormulas');
end;

end.
