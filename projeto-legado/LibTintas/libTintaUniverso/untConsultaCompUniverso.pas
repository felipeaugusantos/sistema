{*************************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Universo Imobiliaria *}
{**********************************************************************************PH*}
unit untConsultaCompUniverso;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompUniverso = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompUniverso }

procedure TConsultaCompUniverso.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadUniNovasFormulas');
end;

end.
