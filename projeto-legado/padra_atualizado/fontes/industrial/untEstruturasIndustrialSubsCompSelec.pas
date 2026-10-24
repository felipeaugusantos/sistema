unit untEstruturasIndustrialSubsCompSelec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, StrUtils,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxCheckBox,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TOperacaoInt = (opiMarcar, opiDesmarcar, opiInverter);

  TfrmEstruturasIndustrialSubsCompSelec = class(TfrmPaiConfirma)
    cxgFormulacaoLevel: TcxGridLevel;
    cxgFormulacaoTableView: TcxGridDBTableViewCitel;
    cxgFormulacao: TcxGridCitel;
    cxgFormulacaoTableViewCODITE: TcxGridDBColumn;
    cxgFormulacaoTableViewDESITE: TcxGridDBColumn;
    cxgFormulacaoTableViewCODCOR: TcxGridDBColumn;
    cxgFormulacaoTableViewDESCOR: TcxGridDBColumn;
    cxgFormulacaoTableViewFORMUL: TcxGridDBColumn;
    cxgFormulacaoTableViewPESREA: TcxGridDBColumn;
    cxgFormulacaoTableViewREFERE: TcxGridDBColumn;
    dtsSource: TDataSource;
    cxgFormulacaoTableViewFORSEL: TcxGridDBColumn;
    btnInverte: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    Label1: TLabel;
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnInverteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure pTodos(opiTipo : TOperacaoInt);
  public
    { Public declarations }
  end;

var
  frmEstruturasIndustrialSubsCompSelec: TfrmEstruturasIndustrialSubsCompSelec;

implementation

{$R *.dfm}

{ TfrmEstruturasIndustrialSubsCompSelec }

procedure TfrmEstruturasIndustrialSubsCompSelec.btnDesmarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pTodos(opiDesmarcar);
end;

procedure TfrmEstruturasIndustrialSubsCompSelec.btnInverteClick(
  Sender: TObject);
begin
  inherited;
  pTodos(opiInverter);
end;

procedure TfrmEstruturasIndustrialSubsCompSelec.btnMarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pTodos(opiMarcar);
end;

procedure TfrmEstruturasIndustrialSubsCompSelec.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    dtsSource.DataSet.Edit;
    dtsSource.DataSet.FieldByName('FORSEL').AsString := IfThen(dtsSource.DataSet.FieldByName('FORSEL').AsString = 'S', 'N', 'S');
    dtsSource.DataSet.Post;
  End;

end;

procedure TfrmEstruturasIndustrialSubsCompSelec.pTodos(opiTipo: TOperacaoInt);
begin
  Try
    dtsSource.DataSet.DisableControls;
    dtsSource.DataSet.First;
    While Not dtsSource.DataSet.Eof Do
    Begin
      dtsSource.DataSet.Edit;

      Case opiTipo Of
        opiMarcar    : dtsSource.DataSet.FieldByName('FORSEL').AsString := 'S';
        opiDesmarcar : dtsSource.DataSet.FieldByName('FORSEL').AsString := 'N';
        opiInverter  : dtsSource.DataSet.FieldByName('FORSEL').AsString := IfThen(dtsSource.DataSet.FieldByName('FORSEL').AsString = 'S', 'N', 'S');
      End;

      dtsSource.DataSet.Post;
      dtsSource.DataSet.Next;
    End;

  Finally
    dtsSource.DataSet.First;
    dtsSource.DataSet.EnableControls;
  End;

end;

end.
