unit untCadGlobalColorGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadGlobalColorGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadGlobalColorGeraNfm: TfrmCadGlobalColorGeraNfm;

implementation

uses untFuncoesSimples, untGlobalColorNova;

{$R *.dfm}

procedure TfrmCadGlobalColorGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    GlobalColor: TGlobalColorDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    GlobalColor := TGlobalColorDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadGlobalColorGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  GlobalColor.RegistraAcao := pRegistrAcao;
  GlobalColor.RegistraProgresso := pRegistraProgresso;

  If GlobalColor.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(GlobalColor);
  btnConfirmaGeracao.Enabled := True;
end;

end.
