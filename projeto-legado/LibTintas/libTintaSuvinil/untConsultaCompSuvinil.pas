{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta suvinil *}
{**********************************************************************PH*}
unit untConsultaCompSuvinil;

interface

uses
  untIConsultaCompTintaNovaConfigurador, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompSuvinil = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompSuvinil }

procedure TConsultaCompSuvinil.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadSuvNovasFormulas');
end;

end.
