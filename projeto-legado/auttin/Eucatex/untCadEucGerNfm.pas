unit untCadEucGerNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadEucGerNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadEucGerNfm: TfrmCadEucGerNfm;

implementation

uses untEucatexImobiliariaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadEucGerNfm.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    eucatex: TEucatexImobiliariaDinamica;
begin
  btnConfirmaGeracao.Enabled := false;

  Try
    eucatex := TEucatexImobiliariaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmCadSuvGeraNfm.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  eucatex.RegistraAcao := pRegistrAcao;
  eucatex.RegistraProgresso := pRegistraProgresso;

  If eucatex.fGravaCadNfms Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  FreeAndNil(eucatex);
  btnConfirmaGeracao.Enabled := True;
end;

end.
