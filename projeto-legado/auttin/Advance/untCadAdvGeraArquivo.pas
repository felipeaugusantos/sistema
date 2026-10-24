unit untCadAdvGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadAdvGeraArquivo = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAdvGeraArquivo: TfrmCadAdvGeraArquivo;

implementation

uses untAdvanceIndustrialDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadAdvGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    advance: TAdvanceIndustrialDinamica;
begin
  Try
    btnConfirmaGeracao.Enabled := False;
    advance := TAdvanceIndustrialDinamica.Create(Self);
    advance.RegistraAcao := pRegistrAcao;
    advance.RegistraProgresso := pRegistraProgresso;

    advance.pProcessaArquivos;
    
    fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK']);

    btnConfirmaGeracao.Enabled := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadAdvGeraArquivo.btnConfirmaGeracaoClick]');
    End;
  End;

  FreeAndNil(advance);
end;

end.
