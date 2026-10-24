{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta GlobalCc11 *}
{*******************************************************************************AC*}
unit untConsultaCompGlobalCc11;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompGlobalCc11 = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompGlobalCc11 }

procedure TConsultaCompGlobalCc11.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadC11NovasFormulas');
end;

end.
