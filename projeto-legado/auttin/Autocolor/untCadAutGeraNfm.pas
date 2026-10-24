unit untCadAutGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadAutGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAutGeraNfm: TfrmCadAutGeraNfm;

implementation

uses untAutocolorDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadAutGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    autocolor: TAutoColorDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    autocolor := TAutoColorDinamica.CreateNovasFormulas();
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadAutGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  autocolor.RegistraAcao := pRegistrAcao;
  autocolor.RegistraProgresso := pRegistraProgresso;

  If autocolor.fGravaCadNfms Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(autocolor);
  btnConfirmaGeracao.Enabled := True;

end;

end.
