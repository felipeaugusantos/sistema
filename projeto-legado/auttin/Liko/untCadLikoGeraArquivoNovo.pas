unit untCadLikoGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadLikoGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadLikoGeraArquivoNovo: TfrmCadLikoGeraArquivoNovo;

implementation

uses untLikoNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadLikoGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    Liko: TLikoDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Liko := TLikoDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadLikoGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Liko.RegistraAcao := pRegistrAcao;
  Liko.RegistraProgresso := pRegistraProgresso;

  If Liko.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
