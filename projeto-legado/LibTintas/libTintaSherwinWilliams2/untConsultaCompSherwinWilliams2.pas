{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta SherwinWilliams2*}
{**********************************************************************PH*}
unit untConsultaCompSherwinWilliams2;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompSherwinWilliams2 = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompSherwinWilliams2 }

procedure TConsultaCompSherwinWilliams2.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadSHWNovasFormulas');
end;

end.
