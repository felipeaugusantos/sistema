{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Ciacollor*}
{**********************************************************************PH*}
unit untConsultaCompCiacollor;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompCiacollor = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompCiacollor }

procedure TConsultaCompCiacollor.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadCIANovasFormulas');
end;

end.
