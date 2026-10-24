{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta AlterPlus*}
{**********************************************************************PH*}
unit untConsultaCompAlterPlus;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompAlterPlus = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompAlterPlus }

procedure TConsultaCompAlterPlus.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadALPNovasFormulas');
end;

end.
