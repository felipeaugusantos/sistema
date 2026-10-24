unit untCadColGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadColGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadColGeraNfm: TfrmCadColGeraNfm;

implementation

uses untFuncoesSimples, untSolBrazDinamica;

{$R *.dfm}

procedure TfrmCadColGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    colorbraz: TSolBrazDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    colorbraz := TSolBrazDinamica.CreateNfm(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  colorbraz.RegistraAcao := pRegistrAcao;
  colorbraz.RegistraProgresso := pRegistraProgresso;

  If colorbraz.fGravaCadNfm Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(colorbraz);
  btnConfirmaGeracao.Enabled := True;
end;

end.
