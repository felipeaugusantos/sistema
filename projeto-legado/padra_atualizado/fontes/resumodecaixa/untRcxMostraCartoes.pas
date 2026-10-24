unit untRcxMostraCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, Menus,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmRcxMostraCartoes = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    lsvCartoes: TListView;
    btnConfirma: TBitBtnLocked;
    procedure lsvCartoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    stlDeletados: TStringList;
    blnConfirma : Boolean;
  end;


implementation

{$R *.dfm}

procedure TfrmRcxMostraCartoes.lsvCartoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    Close;
  End;
end;

procedure TfrmRcxMostraCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma  := False;
  stlDeletados := TStringList.Create;
end;

procedure TfrmRcxMostraCartoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmRcxMostraCartoes.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmRcxMostraCartoes.FormShow(Sender: TObject);
begin
  inherited;
  lsvCartoes.ItemIndex   := 0;
  lsvCartoes.ItemFocused := lsvCartoes.Items[0];
  lsvCartoes.Selected    := lsvCartoes.Items[0];
end;

end.
