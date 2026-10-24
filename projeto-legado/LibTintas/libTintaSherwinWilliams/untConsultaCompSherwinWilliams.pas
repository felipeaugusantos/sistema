{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta SherwinWilliams  *}
{*******************************************************************************AC*}
unit untConsultaCompSherwinWilliams;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompSherwinWilliams = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompSherwinWilliams }

procedure TConsultaCompSherwinWilliams.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadSHENovasFormulas');
end;

end.
