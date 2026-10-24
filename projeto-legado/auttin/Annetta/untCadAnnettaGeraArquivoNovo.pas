unit untCadAnnettaGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAnnettaGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAnnettaGeraArquivoNovo: TfrmCadAnnettaGeraArquivoNovo;

implementation

uses untAnnettaNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadAnnettaGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    Annetta: TAnnettaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    Annetta := TAnnettaDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadAnnettaGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  Annetta.RegistraAcao := pRegistrAcao;
  Annetta.RegistraProgresso := pRegistraProgresso;

  If Annetta.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
