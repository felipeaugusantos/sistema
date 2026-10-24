{*************************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Velutex Imobiliaria *}
{**********************************************************************************PH*}
unit untConsultaCompVelutexImobiliaria;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompVelutexImobiliaria = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompVelutexImobiliaria }

procedure TConsultaCompVelutexImobiliaria.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadVelNovasFormulas');
end;

end.
