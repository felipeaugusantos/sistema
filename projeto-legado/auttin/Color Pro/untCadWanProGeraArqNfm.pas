unit untCadWanProGeraArqNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadWanProGeraArqNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadWanProGeraArqNfm: TfrmCadWanProGeraArqNfm;

implementation

uses untWandaPro, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadWanProGeraArqNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    wanpro: TWanColorPro;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    wanpro := TWanColorPro.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  wanpro.RegistraAcao := pRegistrAcao;
  wanpro.RegistraProgresso := pRegistraProgresso;

  If wanpro.fGravaNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(wanpro);
  btnConfirmaGeracao.Enabled := False;
end;

end.
