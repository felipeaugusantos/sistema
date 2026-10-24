{*************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta QualyVinil *}
{**********************************************************************PH*}
unit untConsultaCompQualyVinil;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompQualyVinil = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompQualyVinil }

procedure TConsultaCompQualyVinil.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadQUANovasFormulas');
end;

end.
