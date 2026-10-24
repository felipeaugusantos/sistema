unit untCadSuvGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadSuvGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadSuvGeraNfm: TfrmCadSuvGeraNfm;

implementation

uses untSuvinilImobiliaria, untFuncoesSimples;



{$R *.dfm}

procedure TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    suvinil: TSuvinilImobiliariaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    suvinil := TSuvinilImobiliariaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  suvinil.RegistraAcao := pRegistrAcao;
  suvinil.RegistraProgresso := pRegistraProgresso;

  If suvinil.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(suvinil);
  btnConfirmaGeracao.Enabled := True;
end;

end.
