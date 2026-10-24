unit untCadStandoxGerNfm;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Gauges,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadStandoxGerNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadStandoxGerNfm: TfrmCadStandoxGerNfm;

implementation

uses untStandox, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadStandoxGerNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Standox: TStandoxAutomotiva;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Standox := TStandoxAutomotiva.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Standox.RegistraAcao := pRegistrAcao;
  Standox.RegistraProgresso := pRegistraProgresso;

  If Standox.fGravaNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(Standox);
  btnConfirmaGeracao.Enabled := True;
end;

end.
