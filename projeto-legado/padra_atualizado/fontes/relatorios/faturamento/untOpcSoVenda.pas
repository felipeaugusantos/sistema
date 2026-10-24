unit untOpcSoVenda;

interface

uses
  {Libc}Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,  Menus {Qt}, ClipBrd,
  BitBtnLockedIncrem;

type
  TfrmOpcSoVenda = class(TForm)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    pblTitulo: TPanel;
    pnlBotoes: TPanel;
    lblTitulo: TLabel;
    lblMensagem: TLabel;
    btnVenda: TBitBtnLocked;
    btnTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnVendaClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intRetorno   : Integer;
    blnSaiComEsc : Boolean;
  end;

var
  frmOpcSoVenda: TfrmOpcSoVenda;

implementation

{$R *.dfm}

procedure TfrmOpcSoVenda.FormCreate(Sender: TObject);
begin
  intRetorno   := 0;
  blnSaiComEsc := False;
end;

procedure TfrmOpcSoVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (blnSaiComEsc) Then
  Begin
    intRetorno := 0;
    Close;
  End;
end;

procedure TfrmOpcSoVenda.btnVendaClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

procedure TfrmOpcSoVenda.btnTodosClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

end.
