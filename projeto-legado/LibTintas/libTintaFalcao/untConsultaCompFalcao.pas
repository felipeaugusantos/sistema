{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Falcao*}
{**********************************************************************PH*}
unit untConsultaCompFalcao;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompFalcao = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompFalcao }

procedure TConsultaCompFalcao.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadFALNovasFormulas');
end;

end.
