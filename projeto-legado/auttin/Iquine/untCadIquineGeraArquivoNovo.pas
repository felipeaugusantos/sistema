unit untCadIquineGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadIquineGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadIquineGeraArquivoNovo: TfrmCadIquineGeraArquivoNovo;

implementation

uses untIquineNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadIquineGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    iquine: TIquineDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    iquine := TIquineDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadIquineGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  iquine.RegistraAcao := pRegistrAcao;
  iquine.RegistraProgresso := pRegistraProgresso;

  If iquine.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
