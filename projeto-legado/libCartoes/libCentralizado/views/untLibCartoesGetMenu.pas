unit untLibCartoesGetMenu;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos;

type
  TfrmLibCartoesGetMenu = class(TForm)
    stgMenu: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure stgMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgMenuDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTelas: ITelasAbertas;
    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;
  protected
    procedure pEscapePressed;
  public
    { Public declarations }
    intLinha   : Integer;
    blnConfirma: Boolean;
    blnSaiComEsc: Boolean;
    arrOpcoes  : Array Of String;
  end;

implementation

{$R *.dfm}

procedure TfrmLibCartoesGetMenu.FormCreate(Sender: TObject);
begin
  pEmpilharTelaAberta;
end;

procedure TfrmLibCartoesGetMenu.FormDestroy(Sender: TObject);
begin
  pRemoverTelaAberta;
end;

procedure TfrmLibCartoesGetMenu.FormShow(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  Constraints.MaxHeight := Constraints.MaxHeight + ((Length(arrOpcoes)-1) * 29);
  Height           := Height + ((Length(arrOpcoes)-1) * 29);

  If Height > 250 Then
    Height := 250;

  stgMenu.RowCount := Length(arrOpcoes);
  blnConfirma      := False;

  stgMenu.Row      := intLinha;

  For intContador := 0 To Length(arrOpcoes)-1 Do
  Begin
    stgMenu.Cells[0, intContador] := arrOpcoes[intContador];
  End;

end;

procedure TfrmLibCartoesGetMenu.stgMenuKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmLibCartoesGetMenu.pEmpilharTelaAberta;
begin
  FTelas := untLibCartoesTelasAbertas.objTelasAbertas;

  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

procedure TfrmLibCartoesGetMenu.pEscapePressed;
begin
  If blnSaiComEsc Then
    Self.Close;
end;

procedure TfrmLibCartoesGetMenu.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

procedure TfrmLibCartoesGetMenu.stgMenuDblClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmLibCartoesGetMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not blnSaiComEsc And Not blnConfirma Then
    Action := caNone
  Else
    intLinha := stgMenu.Row;
end;

end.

