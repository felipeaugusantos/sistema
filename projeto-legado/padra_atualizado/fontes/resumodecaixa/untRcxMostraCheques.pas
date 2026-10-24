unit untRcxMostraCheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, UniDataSetProvider, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxMostraCheques = class(TfrmPaiSimples)
    Panel1: TPanel;
    dbgCheque: TDBGridCitel;
    dsCheques: TDataSource;
    BitBtn1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    fltValTot : Double;
  end;

var
  frmRcxMostraCheques: TfrmRcxMostraCheques;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmRcxMostraCheques.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(dsCheques.DataSet.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';
  pSetFocus(dbgCheque);
end;

procedure TfrmRcxMostraCheques.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dsCheques.DataSet.First;
  fltValTot := 0;
  While Not dsCheques.DataSet.Eof Do
  Begin
    fltValTot := fltValTot + dsCheques.DataSet.fieldbyname('CHQ_VALCHQ').AsFloat;
    dsCheques.DataSet.Next;
  End;
end;

procedure TfrmRcxMostraCheques.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxMostraCheques.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxMostraCheques.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) Then
  Begin
    If Not dsCheques.DataSet.IsEmpty Then dsCheques.DataSet.Delete;
  End
  Else If (Key = VK_Return) Then
    btnConfirma.Click
  Else If (Key = VK_Escape) Then
    Close;

end;

end.
