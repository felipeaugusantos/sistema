unit untCadBziGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadBziGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadBziGeraNfm: TfrmCadBziGeraNfm;

implementation

uses untBrasimixImobiliaria, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadBziGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    brasimix: TBrasimixImobiliaria;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    brasimix := TBrasimixImobiliaria.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  brasimix.RegistraAcao := pRegistrAcao;
  brasimix.RegistraProgresso := pRegistraProgresso;

  If brasimix.fGravaNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(brasimix);
  btnConfirmaGeracao.Enabled := True;
end;

end.
