{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta HydronorthImobiliaria *}
{*******************************************************************************AC*}
unit untConsultaCompHydronorthImobiliaria;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompHydronorthImobiliaria = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompHydronorthImobiliaria }

procedure TConsultaCompHydronorthImobiliaria.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadHYDNovasFormulas');
end;

end.
