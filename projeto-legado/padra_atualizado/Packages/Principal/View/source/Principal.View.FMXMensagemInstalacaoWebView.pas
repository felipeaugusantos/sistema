unit Principal.View.FMXMensagemInstalacaoWebView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.ListBox,
  FMX.Edit, System.StrUtils, FMX.Effects, System.ImageList, FMX.ImgList,
  FMX.SearchBox, Generics.Collections, System.Actions, FMX.ActnList,
  TaEntregue.Romaneios.Interfaces, FMX.ScrollBox, FMX.Memo,
  Winapi.ShellAPI, Winapi.Windows, Principal.View.Interfaces;

type
  TFMXMensagemInstalacaoWebView = class(TForm)
    layTopo: TLayout;
    recFundoTopo: TRectangle;
    lblCaptionForm: TLabel;
    layFundo: TLayout;
    recFundoLista: TRectangle;
    layEsmaecer: TLayout;
    recFundoEsmaecer: TRectangle;
    StyleBook1: TStyleBook;
    btnFechar: TSpeedButton;
    imgFechar: TImage;
    memMensagem: TMemo;
    layBotao: TLayout;
    recBotaoSelecionar: TRectangle;
    efeSombra: TShadowEffect;
    lblBotaoSelecionar: TLabel;
    memOrientacoes: TMemo;
    lblLink: TLabel;
    imgBaixarAgora: TImage;
    imgX86: TImage;
    imgAceitarBaixar: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure recFundoEsmaecerClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure recBotaoSelecionarClick(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objFuncoes: IFuncoes;
  end;

var
  FMXMensagemInstalacaoWebView: TFMXMensagemInstalacaoWebView;

implementation

{$R *.fmx}


procedure TFMXMensagemInstalacaoWebView.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMXMensagemInstalacaoWebView.FormCreate(Sender: TObject);
begin
  layFundo.Height         := 135;
  layFundo.Width          := 430;

  memMensagem.Visible     := True;
  memMensagem.Opacity     := 1;

  memOrientacoes.Visible  := False;
  memOrientacoes.Opacity  := 0;

  lblBotaoSelecionar.Text := 'Saiba Mais';
end;

procedure TFMXMensagemInstalacaoWebView.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape : Close;
  End;
end;

procedure TFMXMensagemInstalacaoWebView.lblLinkClick(Sender: TObject);
Begin
  If Assigned(objFuncoes) Then
    objFuncoes.BrowserNavigate('https://developer.microsoft.com/pt-br/microsoft-edge/webview2/');
end;

procedure TFMXMensagemInstalacaoWebView.recBotaoSelecionarClick(
  Sender: TObject);
begin
  If (lblBotaoSelecionar.Text = 'Ok') Then
  Begin
    Close;
    Exit;
  End;

  memOrientacoes.Visible := True;

  layFundo.Height := 390;
  layFundo.Width := 560;
  lblCaptionForm.Opacity := 0;
  lblBotaoSelecionar.Opacity := 0;

  memMensagem.Opacity := 0;

  lblCaptionForm.Text := 'Como instalar as bibliotecas do WebView 2?';
  lblBotaoSelecionar.Text := 'Ok';

  memOrientacoes.Opacity := 1;
  lblCaptionForm.Opacity := 1;
  lblBotaoSelecionar.Opacity := 1;

  memMensagem.Visible    := False;
end;

procedure TFMXMensagemInstalacaoWebView.recFundoEsmaecerClick(Sender: TObject);
begin
  Close;
end;

end.
