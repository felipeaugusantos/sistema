unit untCadRecoaGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadRecoaGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadRecoaGeraArquivoNovo: TfrmCadRecoaGeraArquivoNovo;

implementation

uses untRecoaNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadRecoaGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    Recoa: TRecoaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Recoa := TRecoaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadRecoaGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Recoa.RegistraAcao := pRegistrAcao;
  Recoa.RegistraProgresso := pRegistraProgresso;

  If Recoa.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
