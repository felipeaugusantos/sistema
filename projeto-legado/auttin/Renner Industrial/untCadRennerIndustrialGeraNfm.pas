unit untCadRennerIndustrialGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadRennerIndustrialGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadRennerIndustrialGeraNfm: TfrmCadRennerIndustrialGeraNfm;

implementation

uses untFuncoesSimples, untRennerIndustrialNova;

{$R *.dfm}

procedure TfrmCadRennerIndustrialGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    RennerIndustrial: TRennerIndustrialDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    RennerIndustrial := TRennerIndustrialDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possível gerar novas fórmulas', 'TfrmCadRennerIndustrialGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  RennerIndustrial.RegistraAcao := pRegistrAcao;
  RennerIndustrial.RegistraProgresso := pRegistraProgresso;

  If RennerIndustrial.fGravarNovasFormulas Then
    fMensagem('', 'Novas fórmulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(RennerIndustrial);
  btnConfirmaGeracao.Enabled := True;
end;

end.
