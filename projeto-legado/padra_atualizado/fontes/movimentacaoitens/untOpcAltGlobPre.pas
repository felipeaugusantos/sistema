unit untOpcAltGlobPre;

interface

uses
  {Libc}Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,  Menus {Qt}, ClipBrd,
  BitBtnLockedIncrem;

type
  TfrmOpcAltGlobPre = class(TForm)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    pblTitulo: TPanel;
    pnlBotoes: TPanel;
    lblTitulo: TLabel;
    lblMensagem: TLabel;
    btnValor: TBitBtnLocked;
    btnFator: TBitBtnLocked;
    btnOrigem: TBitBtnLocked;
    btnSomar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnValorClick(Sender: TObject);
    procedure btnFatorClick(Sender: TObject);
    procedure btnOrigemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intRetorno   : Integer;
    blnSaiComEsc : Boolean;
  end;

var
  frmOpcAltGlobPre: TfrmOpcAltGlobPre;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmOpcAltGlobPre.FormCreate(Sender: TObject);
begin
  intRetorno   := 0;
  blnSaiComEsc := False;

  btnOrigem.Enabled := Not fCfgSis('FATPRE', VarBoolean);

end;

procedure TfrmOpcAltGlobPre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (blnSaiComEsc) Then
  Begin
    intRetorno := 0;
    Close;
  End;
end;

procedure TfrmOpcAltGlobPre.btnValorClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

procedure TfrmOpcAltGlobPre.btnFatorClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

procedure TfrmOpcAltGlobPre.btnOrigemClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;
  Close;
end;

end.

