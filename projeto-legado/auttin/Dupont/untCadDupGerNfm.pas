unit untCadDupGerNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadDupGerNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDupGerNfm: TfrmCadDupGerNfm;

implementation

uses untDupont, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadDupGerNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    dupon: TDuponAutomotiva;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    dupon := TDuponAutomotiva.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  dupon.RegistraAcao := pRegistrAcao;
  dupon.RegistraProgresso := pRegistraProgresso;

  If dupon.fGravaNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(dupon);
  btnConfirmaGeracao.Enabled := True;
end;

end.
