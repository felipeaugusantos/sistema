{**************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Salcomix	 *}
{***********************************************************************AC*}
unit untConsultaCompSalcomix	;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper;

type
  TConsultaCompSalcomix	 = class(TAbstractConsultaComp)
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompSalcomix	 }

procedure TConsultaCompSalcomix	.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
begin
  TAutcomTintaFactory.Get.fCriarProcesso('AutTin\AutTin.exe nfm ' +
    TAutcomTintaFactory.Get.GetUsuarioLogado + ' ' +
    TAutcomTintaFactory.Get.GetCodEmp +
    ' mnuCadSALNovasFormulas',
    False);
end;

end.
