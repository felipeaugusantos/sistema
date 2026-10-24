unit untFatItensRomaneioInform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem;

type
  TfrmFatItensRomaneioInform = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    Panel1: TPanel;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    memInform: TMemoFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatItensRomaneioInform: TfrmFatItensRomaneioInform;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatItensRomaneioInform.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatItensRomaneioInform.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(memInform);
  memInform.SelStart := 0;
end;

procedure TfrmFatItensRomaneioInform.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

end.
