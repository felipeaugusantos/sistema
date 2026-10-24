unit untCadAnjoGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAnjoGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAnjoGeraNfm: TfrmCadAnjoGeraNfm;

implementation

uses untFuncoesSimples, untAnjoDinamica;

{$R *.dfm}

procedure TfrmCadAnjoGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Anjo: TAnjoDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Anjo := TAnjoDinamica .CreateNfm(false);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadAnjoGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Anjo.RegistraAcao      := pRegistrAcao;
  Anjo.RegistraProgresso := pRegistraProgresso;

  If Anjo.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK'])
  else
    fMensagem('', 'Não foi possível processar o cadsatro de novas fórmulas corretamente, verifique!', ['OK']);

  FreeAndNil(Anjo);
  btnConfirmaGeracao.Enabled := True;
end;

end.
