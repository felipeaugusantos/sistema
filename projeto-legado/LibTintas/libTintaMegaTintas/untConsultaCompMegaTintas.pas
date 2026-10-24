{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta MegaTintas*}
{**********************************************************************PH*}
unit untConsultaCompMegaTintas;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompMegaTintas = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompMegaTintas }

procedure TConsultaCompMegaTintas.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadMEGNovasFormulas');
end;

end.
