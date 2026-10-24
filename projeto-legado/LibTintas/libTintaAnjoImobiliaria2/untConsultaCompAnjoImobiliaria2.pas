{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta AnjoImobiliaria2 *}
{*******************************************************************************AC*}
unit untConsultaCompAnjoImobiliaria2;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompAnjoImobiliaria2 = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompAnjoImobiliaria2 }

procedure TConsultaCompAnjoImobiliaria2.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadAN2NovasFormulas');
end;

end.
