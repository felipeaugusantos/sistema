unit untMenuTipImp;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, Buttons, ExtCtrls, Grids, {Qt,} Menus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmMenuTipImp = class(TfrmPai)
    stgTipImp: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure stgTipImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgTipImpSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure stgTipImpDblClick(Sender: TObject);
  private
    { Private declarations }
    intLinha: Integer;
  public
    { Public declarations }
    strTipImp: String;
    blnConfirma: Boolean;
  end;


implementation

uses untCfgRel;

{$R *.dfm}

procedure TfrmMenuTipImp.FormCreate(Sender: TObject);
begin
  inherited;
  intLinha := 0;
  stgTipImp.ColWidths[0] := 170;

  stgTipImp.Cells[0, 0] := 'MATRICIAL';
  stgTipImp.Cells[0, 1] := 'JATO DE TINTA'; 
end;

procedure TfrmMenuTipImp.stgTipImpKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return)   And
     (stgTipImp.Enabled) Then
  Begin
    stgTipImp.Enabled := False;
    If intLinha = 0 Then
    Begin
      strTipImp := 'M';
    End
    Else If intLinha = 1 Then
    Begin
      strTipImp := 'J';
    End;
    blnConfirma := True;
    Close;
  End
  Else
  If (Key = VK_Escape) Then
  Begin
    strTipImp := '';
    blnConfirma := False;
    Close;
  End;

end;

procedure TfrmMenuTipImp.stgTipImpSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  intLinha := ARow;
end;

procedure TfrmMenuTipImp.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  strTipImp   := TCfgRel.fCfgSis('TIPIMP');
end;

procedure TfrmMenuTipImp.stgTipImpDblClick(Sender: TObject);
  Var
    Key: Word;
    Shift: TShiftState;
begin
  inherited;
  Key := VK_Return;
  stgTipImpKeyDown(Sender, Key, Shift);
end;

end.

