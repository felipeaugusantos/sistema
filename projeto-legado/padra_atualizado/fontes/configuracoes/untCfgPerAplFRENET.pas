unit untCfgPerAplFRENET;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, UniClientDataSet,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Uni, UniDataSetProvider;

type
  TfrmPerAplFRENET = class(TfrmPai)
    dbgPerApl: TDBGridCitel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPerAplKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryPerApl : TUniQuery;
    dtsPerApl : TDataSource;

    procedure pBeforeInsert(DataSet: TDataSet);
    procedure pBeforeDelete(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);

  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmPerAplFRENET.dbgPerAplKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    qryPerApl.Next;
end;

procedure TfrmPerAplFRENET.FormCreate(Sender: TObject);
begin
  inherited;
  qryPerApl  := fCriaQuery(Self);
  qryPerApl.BeforePost   := pBeforePost;
  qryPerApl.BeforeInsert := pBeforeInsert;
  qryPerApl.BeforeDelete := pBeforeDelete;

  dtsPerApl := fCriaDataSource(qryPerApl);
  dbgPerApl.DataSource := dtsPerApl;
end;

procedure TfrmPerAplFRENET.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(qryPerApl) then pFreeAndNil(qryPerApl);
  if Assigned(dtsPerApl) then pFreeAndNil(dtsPerApl);
end;

procedure TfrmPerAplFRENET.FormShow(Sender: TObject);
begin
  inherited;

  qryPerApl.Close;
  qryPerApl.SQL.Clear;
  qryPerApl.SQL.Add(' SELECT ');
  qryPerApl.SQL.Add('    PER_ESTADO, ');
  qryPerApl.SQL.Add('    PER_DESCRI, ');
  qryPerApl.SQL.Add('    PER_PERCEN ');
  qryPerApl.SQL.Add(' FROM ');
  qryPerApl.SQL.Add('    PERAPL ');
  qryPerApl.Open;

  If Not qryPerApl.IsEmpty Then
    TFloatField(qryPerApl.FieldByName('PER_PERCEN')).DisplayFormat := '#,####0.00';
end;

procedure TfrmPerAplFRENET.pBeforeInsert(DataSet: TDataSet);
begin
  If dbgPerApl.Focused Then
    Abort;
end;

procedure TfrmPerAplFRENET.pBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TfrmPerAplFRENET.pBeforePost(DataSet: TDataSet);
begin
  If fEmptyStr(qryPerApl.FieldByName('PER_PERCEN').AsString) Then
    qryPerApl.FieldByName('PER_PERCEN').Value := 0.00;
end;

end.
