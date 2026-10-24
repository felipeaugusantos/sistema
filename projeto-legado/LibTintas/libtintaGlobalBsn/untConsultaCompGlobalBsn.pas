{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta GlobalBsn *}
{*******************************************************************************AC*}
unit untConsultaCompGlobalBsn;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompGlobalBsn = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompGlobalBsn }

procedure TConsultaCompGlobalBsn.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadBSNNovasFormulas');
end;

end.
