unit untCadGlobalColorGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadGlobalColorGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadGlobalColorGeraArquivoNovo: TfrmCadGlobalColorGeraArquivoNovo;

implementation

uses untGlobalColorNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadGlobalColorGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    GlobalColor: TGlobalColorDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    GlobalColor := TGlobalColorDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadGlobalColorGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  GlobalColor.RegistraAcao := pRegistrAcao;
  GlobalColor.RegistraProgresso := pRegistraProgresso;

  If GlobalColor.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
