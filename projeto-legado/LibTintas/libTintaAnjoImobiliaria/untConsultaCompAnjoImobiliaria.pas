{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta AnjoImobiliaria *}
{**********************************************************************PH*}
unit untConsultaCompAnjoImobiliaria;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompAnjoImobiliaria = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompAnjoImobiliaria }

procedure TConsultaCompAnjoImobiliaria.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadAnjNovasFormulas');
end;

end.
