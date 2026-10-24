unit untCadAnnettaGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAnnettaGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAnnettaGeraNfm: TfrmCadAnnettaGeraNfm;

implementation

uses untFuncoesSimples, untAnnettaNova;

{$R *.dfm}

procedure TfrmCadAnnettaGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Annetta: TAnnettaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Annetta := TAnnettaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possível gerar novas fórmulas', 'TfrmCadAnnettaGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Annetta.RegistraAcao := pRegistrAcao;
  Annetta.RegistraProgresso := pRegistraProgresso;

  If Annetta.fGravarNovasFormulas Then
    fMensagem('', 'Novas fórmulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(Annetta);
  btnConfirmaGeracao.Enabled := True;
end;

end.
