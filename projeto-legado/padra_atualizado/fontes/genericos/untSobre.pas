unit untSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, dxGDIPlusClasses;

type
  TfrmSobre = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    lblVersao: TLabel;
    lblLink: TLabel;
    pnlFones: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure lblLinkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses  untfuncoesSimples, untFuncAutban, untFuncoesRel2, untInicializaDllPedido,
  untDllOpeProd, untDllOpeProdFuncoes, untDllTransfCodFuncoes, untFuncoesEtiquetas, untLibNfe,
  untVersaoProg;

{$R *.dfm}

procedure TfrmSobre.lblLinkClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('LNKSIT', strLoginUsuarioLogado) Then
    pBrowserNavigate('https://www.citelsoftware.com.br/')
  Else
    fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso!', ['&Ok']);
end;

procedure TfrmSobre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End;
end;

procedure TfrmSobre.FormShow(Sender: TObject);
  {$I rev.inc}
begin
  lblVersao.Caption := 'Autcom V. ' + fPADR(TVersaoExecutavel.GetVersaoArquivo, 20) +
    ' Rev: ' + SVN_REVISION + '    Conexão: ' + fGetConnectionID;
end;

end.

