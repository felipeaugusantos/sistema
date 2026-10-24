unit untGetMenu;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade {Qt};

type
  TfrmGetMenu = class(TfrmPaiSimples)
    stgMenu: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure stgMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgMenuDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    procedure pEscapePressed; override;
  public
    { Public declarations }
    intLinha   : Integer;
    blnConfirma: Boolean;
    blnSaiComEsc: Boolean;
    arrOpcoes  : Array Of String;
  end;

var
  frmGetMenu: TfrmGetMenu;

implementation

{$R *.dfm}

procedure TfrmGetMenu.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    intHeight  : Integer;
begin
  inherited;

  Constraints.MaxHeight := Constraints.MaxHeight + ((Length(arrOpcoes)-1) * 29);

  intHeight := Height + ((Length(arrOpcoes)-1) * 29);

  If intHeight > 250 Then
    intHeight := 250;

  Height := intHeight;

  stgMenu.RowCount := Length(arrOpcoes);
  blnConfirma      := False;

  stgMenu.Row      := intLinha;

  For intContador := 0 To Length(arrOpcoes)-1 Do
  Begin
    stgMenu.Cells[0, intContador] := arrOpcoes[intContador];
  End;

end;

procedure TfrmGetMenu.stgMenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Then
  Begin
    blnConfirma := True;
    Close;
  End
  Else If (Key = VK_Escape) Then
  Begin
    If blnSaiComEsc Then
      Close;
  End;

end;

procedure TfrmGetMenu.pEscapePressed;
begin
  If blnSaiComEsc Then
    inherited;

end;

procedure TfrmGetMenu.stgMenuDblClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmGetMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not blnSaiComEsc And Not blnConfirma Then
    Action := caNone
  Else
    intLinha := stgMenu.Row;
end;

end.

