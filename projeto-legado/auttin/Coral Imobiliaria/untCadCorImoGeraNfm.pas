unit untCadCorImoGeraNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadCorImoGeraNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCorImoGeraNfm: TfrmCadCorImoGeraNfm;

implementation

uses untCoralImobiliaria, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCorImoGeraNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    coralimobiliaria: TCoralImobiliaria;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    coralimobiliaria := TCoralImobiliaria.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  coralimobiliaria.RegistraAcao := pRegistrAcao;
  coralimobiliaria.RegistraProgresso := pRegistraProgresso;

  If coralimobiliaria.fGravaNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(coralimobiliaria);
  btnConfirmaGeracao.Enabled := True;
end;

end.
