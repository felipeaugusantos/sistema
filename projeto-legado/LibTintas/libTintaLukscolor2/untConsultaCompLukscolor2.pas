{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Lukscolor2 *}
{**********************************************************************PH*}
unit untConsultaCompLukscolor2;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompLukscolor2 = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompLukscolor2 }

procedure TConsultaCompLukscolor2.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadLKCNovasFormulas');
end;

end.
