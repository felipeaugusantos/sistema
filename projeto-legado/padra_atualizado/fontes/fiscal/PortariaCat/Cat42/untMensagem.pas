unit untMensagem;

interface

uses
  {Libc}Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, untConstantes, Menus {Qt}, ClipBrd;

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

{$R *.dfm}

procedure TfrmMensagem.FormCreate(Sender: TObject);
begin
  intRetorno := 0;
end;


procedure TfrmMensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_Escape) And (blnSaiComEsc) then
  begin
    intRetorno := 0;
    Close;
  end;
end;

procedure TfrmMensagem.pOnClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtn).Tag;
  Close;
end;

procedure TfrmMensagem.FormShow(Sender: TObject);
  Var
    intPosicao: Integer;
begin
  For intPosicao := 0 To Self.ComponentCount - 1 Do
  begin
    if ( Self.Components[intPosicao] Is TBitBtn )      And
       ( Self.Components[intPosicao].Tag = intFocus )  then
      ( Self.Components[intPosicao] As TBitBtn ).SetFocus;
  end;

  SetForegroundWindow(Self.Handle);

end;

procedure TfrmMensagem.Enviarparareadetransferncia1Click(Sender: TObject);
begin
  Clipboard.AsText := lblTitulo.Caption + #13#10 + lblMensagem.Caption;
end;

end.
