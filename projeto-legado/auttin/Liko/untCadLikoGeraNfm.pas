unit untCadLikoGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadLikoGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadLikoGeraNfm: TfrmCadLikoGeraNfm;

implementation

uses untFuncoesSimples, untLikoNova;

{$R *.dfm}

procedure TfrmCadLikoGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Liko: TLikoDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Liko := TLikoDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadLikoGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Liko.RegistraAcao := pRegistrAcao;
  Liko.RegistraProgresso := pRegistraProgresso;

  If Liko.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(Liko);
  btnConfirmaGeracao.Enabled := True;
end;

end.
