{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Sayerlack *}
{*******************************************************************************AC*}
unit untConsultaCompSayerlack;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompSayerlack = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompSayerlack }

procedure TConsultaCompSayerlack.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadSAYNovasFormulas');
end;

end.
