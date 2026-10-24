{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta BrasimixImobiliaria *}
{**********************************************************************PH*}
unit untConsultaCompBrasimixImobiliaria;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompBrasimixImobiliaria = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompBrasimixImobiliaria }

procedure TConsultaCompBrasimixImobiliaria.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadBziNovasFormulas');
end;

end.
