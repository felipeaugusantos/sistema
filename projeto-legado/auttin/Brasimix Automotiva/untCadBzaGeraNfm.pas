unit untCadBzaGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadBzaGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadBzaGeraNfm: TfrmCadBzaGeraNfm;

implementation

uses untBrasimixAutomotivaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadBzaGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    brasimix: TBrasimixAutomotivaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;
  Try
    brasimix := TBrasimixAutomotivaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  brasimix.RegistraAcao := pRegistrAcao;
  brasimix.RegistraProgresso := pRegistraProgresso;

  If brasimix.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(brasimix);
  btnConfirmaGeracao.Enabled := True;
end;

end.
