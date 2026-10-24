{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta BellaCorTintavel *}
{*******************************************************************************AC*}
unit untConsultaCompBellaCorTintavel;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompBellaCorTintavel = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompBellaCorTintavel }

procedure TConsultaCompBellaCorTintavel.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadBLTNovasFormulas');
end;

end.
