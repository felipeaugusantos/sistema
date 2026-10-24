unit untCadMazGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadMazGeraArquivos = class(TfrmPaiGeraArq)
    rgOpcao: TRadioGroup;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMazGeraArquivos: TfrmCadMazGeraArquivos;

implementation

uses untMaza, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMazGeraArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    tinta : TMaza;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    tinta := TMaza.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar as formulas', 'TfrmCadMazGeraArquivos.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  tinta.RegistraAcao := pRegistrAcao;
  tinta.RegistraProgresso := pRegistraProgresso;

  tinta.pProcessarArquivos(rgOpcao.ItemIndex);
  fMensagem('', 'Fórmulas cadastradas com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

end.
