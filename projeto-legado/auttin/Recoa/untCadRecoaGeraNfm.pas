unit untCadRecoaGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadRecoaGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadRecoaGeraNfm: TfrmCadRecoaGeraNfm;

implementation

uses untFuncoesSimples, untRecoaNova;

{$R *.dfm}

procedure TfrmCadRecoaGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Recoa: TRecoaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Recoa := TRecoaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadRecoaGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Recoa.RegistraAcao := pRegistrAcao;
  Recoa.RegistraProgresso := pRegistraProgresso;

  If Recoa.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(Recoa);
  btnConfirmaGeracao.Enabled := True;
end;

end.
