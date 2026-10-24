{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta BellaCor *}
{**********************************************************************PH*}
unit untConsultaCompBellaCor;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompBellaCor = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompBellaCor }

procedure TConsultaCompBellaCor.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadBELNovasFormulas');
end;

end.
