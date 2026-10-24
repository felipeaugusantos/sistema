unit untMenuGirEst;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, Buttons, ExtCtrls, Grids, {Qt,} Menus,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmMenuGirEst = class(TfrmPai)
    stgOpcoes: TStringGrid;
    procedure stgOpcoesDblClick(Sender: TObject);
    procedure stgOpcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgOpcoesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intLinha: Integer;
    blnConfirma: Boolean;
  end;

var
  frmMenuGirEst: TfrmMenuGirEst;

implementation

{$R *.dfm}

procedure TfrmMenuGirEst.stgOpcoesDblClick(Sender: TObject);
  Var
    Key: Word;
    Shift: TShiftState;
begin
  inherited;
  Key := VK_Return;
  stgOpcoesKeyDown(Sender, Key, Shift);
end;

procedure TfrmMenuGirEst.stgOpcoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return)   And
     (stgOpcoes.Enabled) Then
  Begin
    stgOpcoes.Enabled := False;
    blnConfirma := True;
    Close;
  End
  Else If (Key = Vk_Escape) Then
    Close;
end;

procedure TfrmMenuGirEst.stgOpcoesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  intLinha := ARow;
end;

procedure TfrmMenuGirEst.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  intLinha := 0;

  stgOpcoes.ColWidths[0] := 170;

  stgOpcoes.Cells[0, 0] := '3 MESES';
  stgOpcoes.Cells[0, 1] := '6 MESES';
  stgOpcoes.Cells[0, 2] := '12 MESES';
end;

end.
