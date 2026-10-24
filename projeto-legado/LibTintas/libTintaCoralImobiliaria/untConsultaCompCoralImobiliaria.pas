{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta CoralImobiliaria *}
{*******************************************************************************AC*}
unit untConsultaCompCoralImobiliaria;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompCoralImobiliaria = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompCoralImobiliaria }

procedure TConsultaCompCoralImobiliaria.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadCIMNovasFormulas');
end;

end.
