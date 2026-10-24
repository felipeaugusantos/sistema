unit untMensagemExplicativa;

interface

uses
  {$IF Defined(UNIDAC)}
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
    Vcl.Buttons, Vcl.ExtCtrls,
  {$ELSE}
    SysUtils, Windows, StdCtrls, Mask, Controls, Buttons, Classes, ExtCtrls, Forms,
  {$IFEND}
    BitBtnLockedIncrem;

type
  TfrmMensagemExplicativa = class(TForm)
    mmoInstru: TMemo;
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMensagemExplicativa: TfrmMensagemExplicativa;

implementation

{$R *.dfm}

procedure TfrmMensagemExplicativa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMensagemExplicativa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) Then
    Close;
end;

end.
