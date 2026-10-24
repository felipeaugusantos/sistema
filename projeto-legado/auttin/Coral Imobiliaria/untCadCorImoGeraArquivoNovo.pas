unit untCadCorImoGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCorImoGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCorImoGeraArquivoNovo: TfrmCadCorImoGeraArquivoNovo;

implementation

uses untCoralImobiliariaNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCorImoGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    coral: TCoralImobiliariaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    coral := TCoralImobiliariaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadCorImoGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  coral.RegistraAcao := pRegistrAcao;
  coral.RegistraProgresso := pRegistraProgresso;

  If coral.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
