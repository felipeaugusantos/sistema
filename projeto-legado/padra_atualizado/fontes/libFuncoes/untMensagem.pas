unit untMensagem;

interface

uses
  {Libc}Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus {Qt}, ClipBrd,
  BitBtnLockedIncrem;

type                
  TfrmMensagem = class(TForm)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    pblTitulo: TPanel;
    pnlBotoes: TPanel;
    imgbotao1: TImage;
    imgbotao2: TImage;
    imgbotao3: TImage;
    lblTitulo: TLabel;
    lblMensagem: TLabel;
    popAreaTransf: TPopupMenu;
    Enviarparareadetransferncia1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure pOnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Enviarparareadetransferncia1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intRetorno   : Integer;
    intFocus     : Integer;
    blnSaiComEsc : Boolean;
  end;

var
  frmMensagem: TfrmMensagem;

implementation

uses untFuncoesGen;

{$R *.dfm}

procedure TfrmMensagem.FormCreate(Sender: TObject);
begin
  intRetorno := 0;
end;


procedure TfrmMensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (blnSaiComEsc) Then
  Begin
    intRetorno := 0;
    Close;
  End;
end;

procedure TfrmMensagem.pOnClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

procedure TfrmMensagem.FormShow(Sender: TObject);
  Var
    intPosicao: Integer;
begin
  For intPosicao := 0 To Self.ComponentCount - 1 Do
  Begin
    If ( Self.Components[intPosicao] Is TBitBtnLocked )      And
       ( Self.Components[intPosicao].Tag = intFocus )  Then
      pSetFocus(( Self.Components[intPosicao] As TBitBtnLocked ));
  End;

  SetForegroundWindow(Self.Handle);

end;

procedure TfrmMensagem.Enviarparareadetransferncia1Click(Sender: TObject);
begin
  Clipboard.AsText := lblTitulo.Caption + #13#10 + lblMensagem.Caption;
end;

end.

