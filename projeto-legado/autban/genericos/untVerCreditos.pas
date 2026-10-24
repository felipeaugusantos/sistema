unit untVerCreditos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, Grids, DBGridCitel, DBGrids, AppEvnts,
  Menus, ComCtrls, Buttons, ExtCtrls, DB, UniClientDataSet, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxClasses, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridLevel, cxGrid;

type
  TfrmVerCreditos = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    pnlCabecalho: TPanel;
    lblCliente: TLabel;
    btnFechar: TBitBtnLocked;
    dbgCreditos: TcxGrid;
    dbgCreditosLevel1: TcxGridLevel;
    dbgCreditosDBTableView1: TcxGridDBTableView;
    dbgCreditosDBTableView1NUMDUP: TcxGridDBColumn;
    dbgCreditosDBTableView1PARCEL: TcxGridDBColumn;
    dbgCreditosDBTableView1ESPDOC: TcxGridDBColumn;
    dbgCreditosDBTableView1CODEMP: TcxGridDBColumn;
    dbgCreditosDBTableView1DTACAD: TcxGridDBColumn;
    dbgCreditosDBTableView1DTAVEN: TcxGridDBColumn;
    dbgCreditosDBTableView1VALDUP: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    Label1: TLabel;
    edtVlrTotal: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgCreditosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsCreditos: TUniClientDataSet;
    dtsCreditos: TDataSource;
  end;

var
  frmVerCreditos: TfrmVerCreditos;

implementation

{$R *.dfm}

procedure TfrmVerCreditos.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TfrmVerCreditos.dbgCreditosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnFechar.Click;
end;

procedure TfrmVerCreditos.FormCreate(Sender: TObject);
begin
  inherited;

  dtsCreditos := TDataSource.Create(Self);
  cdsCreditos := TUniClientDataSet.Create(Self);

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMDUP';
    DataType := ftString;
    Size     := 12;
  End;

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PARCEL';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ESPDOC';
    DataType := ftString;
    Size     := 2;
  End;

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODEMP';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DTACAD';
    DataType := ftDate;
  End;

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DTAVEN';
    DataType := ftDate;
  End;

  With cdsCreditos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALDUP';
    DataType := ftFloat;
  End;

  cdsCreditos.CreateDataSet;

  TFloatField(cdsCreditos.FieldByName('VALDUP')).DisplayFormat := '#,##0.00';
  TDateField (cdsCreditos.FieldByName('DTACAD')).DisplayFormat := 'dd/mm/yyyy';
  TDateField (cdsCreditos.FieldByName('DTAVEN')).DisplayFormat := 'dd/mm/yyyy';

  dtsCreditos.DataSet    := cdsCreditos;
  dbgCreditosDBTableView1.DataController.DataSource := dtsCreditos;

end;

procedure TfrmVerCreditos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnFechar.Click;
end;

procedure TfrmVerCreditos.FormShow(Sender: TObject);
Var fltPraNum: Double;
begin
  inherited;

  fltPraNum := 0;

  With cdsCreditos Do
  Begin

    First;

    While (Not Eof) Do
    Begin
      fltPraNum := fltPraNum + FieldByName('VALDUP').AsFloat;
      Next;
    End;
    edtVlrTotal.Text := FloatToStr(fltPraNum);
  End;

end;

end.
