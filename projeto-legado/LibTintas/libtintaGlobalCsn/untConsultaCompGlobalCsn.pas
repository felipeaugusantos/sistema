{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta GlobalCsn *}
{*******************************************************************************AC*}
unit untConsultaCompGlobalCsn;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompGlobalCsn = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompGlobalCsn }

procedure TConsultaCompGlobalCsn.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadCSNNovasFormulas');
end;

end.
