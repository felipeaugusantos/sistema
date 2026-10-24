unit untFatLibProgredirTabPreco;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, Menus, EditFocus, AppEvnts, DB, BitBtnLockedIncrem;

type
  TfrmFatLibProgredirTabPreco = class(TfrmPaiSimples)
    dbgItens: TDBGridCitel;
    btnLiberar: TBitBtnLocked;
    dtsItens: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLiberarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    intRecNo: Integer;

    procedure pScroll(DataSet: TDataSet);

  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

var
  frmFatLibProgredirTabPreco: TfrmFatLibProgredirTabPreco;

implementation

uses untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatLibProgredirTabPreco.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatLibProgredirTabPreco.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then btnSair.Click;
  If Key = VK_RETURN Then pSetFocus(btnLiberar);
  If Key = VK_F10    Then btnLiberar.Click;

  If Key In [VK_Escape, VK_RETURN, VK_F10] Then Key := 0;
end;

procedure TfrmFatLibProgredirTabPreco.dbgItensDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If dbgItens.DataSource.DataSet.RecordCount > 0 Then
  Begin

    If (Column.Field.DataSet.RecNo Mod 2) = 0 Then
      dbgItens.Canvas.Brush.Color := fCfgSis('CORZEB')
    Else
      dbgItens.Canvas.Brush.Color := clWindow;

    If dbgItens.Focused And (intRecNo = Column.Field.DataSet.RecNo) Then
    Begin
      dbgItens.Canvas.Brush.Color := clBlue;
      dbgItens.Canvas.Font.Color  := clWhite;
    End;

    dbgItens.Canvas.FillRect(Rect);
    dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);

  End;
end;

procedure TfrmFatLibProgredirTabPreco.FormShow(Sender: TObject);
begin
  inherited;
  btnLiberar.Align := alLeft;
  btnSair.Align    := alRight;
  dtsItens.DataSet.AfterScroll := pScroll;
  dtsItens.DataSet.First;
end;

procedure TfrmFatLibProgredirTabPreco.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmFatLibProgredirTabPreco.btnLiberarClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  btnSair.Click;
end;

procedure TfrmFatLibProgredirTabPreco.pScroll(DataSet: TDataSet);
begin
  If DataSet.Active Then intRecNo := DataSet.RecNo;
end;

procedure TfrmFatLibProgredirTabPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsItens.DataSet.AfterScroll := Nil;
end;

end.
