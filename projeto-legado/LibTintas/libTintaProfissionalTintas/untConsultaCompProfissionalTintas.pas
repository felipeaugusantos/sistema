{**********************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta ProfissionalTintas *}
{*******************************************************************************AC*}
unit untConsultaCompProfissionalTintas;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompProfissionalTintas = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompProfissionalTintas }

procedure TConsultaCompProfissionalTintas.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadPRTNovasFormulas');
end;

end.
