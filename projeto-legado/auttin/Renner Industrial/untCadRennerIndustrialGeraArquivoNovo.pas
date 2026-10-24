unit untCadRennerIndustrialGeraArquivoNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadRennerIndustrialGeraArquivoNovo = class(TfrmPaiGeraArq)
    rgOpcoes: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadRennerIndustrialGeraArquivoNovo: TfrmCadRennerIndustrialGeraArquivoNovo;

implementation

uses untRennerIndustrialNova, Math, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadRennerIndustrialGeraArquivoNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    RennerIndustrial: TRennerIndustrialDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    RennerIndustrial := TRennerIndustrialDinamica.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadRennerIndustrialGeraArquivoNovo.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  RennerIndustrial.RegistraAcao := pRegistrAcao;
  RennerIndustrial.RegistraProgresso := pRegistraProgresso;

  If RennerIndustrial.fProcessarArquivos(rgOpcoes.ItemIndex) Then
    fMensagem('', 'Cadastro realizado com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
