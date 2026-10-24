unit untCadAnjoSinteticaGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadAnjoSinteticaGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAnjoSinteticaGeraNfm: TfrmCadAnjoSinteticaGeraNfm;

implementation

uses untFuncoesSimples, untAnjoSinteticaDinamica;

{$R *.dfm}

procedure TfrmCadAnjoSinteticaGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    AnjoSintetica: TAnjoSinteticaDinamicaNfm;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    AnjoSintetica := TAnjoSinteticaDinamicaNfm.Create(Self);
  Except
    pMensagensErro('Não foi possível gerar novas fórmulas', 'TfrmCadAnjoSinteticaGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  AnjoSintetica.RegistraAcao := pRegistrAcao;
  AnjoSintetica.RegistraProgresso := pRegistraProgresso;

  If AnjoSintetica.fGravarNovasFormulas Then
    fMensagem('', 'Novas fórmulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(AnjoSintetica);
  btnConfirmaGeracao.Enabled := True;
end;

end.
