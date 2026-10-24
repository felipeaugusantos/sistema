{*************************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Eucatex Imobiliaria *}
{**********************************************************************************PH*}
unit untConsultaCompEucatexImobiliaria;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompEucatexImobiliaria = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompEucatexImobiliaria }

procedure TConsultaCompEucatexImobiliaria.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadEucNovasFormulas');
end;

end.
