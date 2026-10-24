unit untCadDacGerNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadDacGerNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDacGerNfm: TfrmCadDacGerNfm;

implementation

uses untDacarImobiliaria, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadDacGerNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    dacar : TDacarImobiliaria;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    dacar := TDacarImobiliaria.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  dacar.RegistraAcao := pRegistrAcao;
  dacar.RegistraProgresso := pRegistraProgresso;

  If dacar.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(dacar);
  btnConfirmaGeracao.Enabled := True;
end;

end.
