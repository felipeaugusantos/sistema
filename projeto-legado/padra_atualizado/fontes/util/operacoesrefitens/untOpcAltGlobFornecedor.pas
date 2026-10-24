unit untOpcAltGlobFornecedor;

interface

uses
  {Libc}Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus {Qt}, ClipBrd,
  BitBtnLockedIncrem;

type
  TfrmOpcAltGlobFornecedor = class(TForm)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    pblTitulo: TPanel;
    pnlBotoes: TPanel;
    lblTitulo: TLabel;
    lblMensagem: TLabel;
    btnValor: TBitBtnLocked;
    btnFator: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnValorClick(Sender: TObject);
    procedure btnFatorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intRetorno   : Integer;
    blnSaiComEsc : Boolean;
  end;

var
  frmOpcAltGlobFornecedor: TfrmOpcAltGlobFornecedor;

implementation

{$R *.dfm}

procedure TfrmOpcAltGlobFornecedor.FormCreate(Sender: TObject);
begin
  intRetorno   := 0;
  blnSaiComEsc := False;
end;

procedure TfrmOpcAltGlobFornecedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (blnSaiComEsc) Then
  Begin
    intRetorno := 0;
    Close;
  End;
end;

procedure TfrmOpcAltGlobFornecedor.btnValorClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

procedure TfrmOpcAltGlobFornecedor.btnFatorClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

end.
