unit untCadIquineGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadIquineGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadIquineGeraNfm: TfrmCadIquineGeraNfm;

implementation

uses untFuncoesSimples, untIquineNova;

{$R *.dfm}

procedure TfrmCadIquineGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    iquine: TIquineDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    iquine := TIquineDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadIquineGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  iquine.RegistraAcao := pRegistrAcao;
  iquine.RegistraProgresso := pRegistraProgresso;

  If iquine.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(iquine);
  btnConfirmaGeracao.Enabled := True;
end;

end.
