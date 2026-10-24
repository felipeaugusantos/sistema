{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta TexturaCia *}
{*******************************************************************************AC*}
unit untConsultaCompTexturaCia;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompTexturaCia = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompTexturaCia }

procedure TConsultaCompTexturaCia.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadTEXNovasFormulas');
end;

end.
