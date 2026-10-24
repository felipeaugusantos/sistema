unit untDocsResumoISS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, Uni, UniClientDataSet,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmDocsResumoISS = class(TfrmPai)
    cxGridDocsView: TcxGridDBTableViewCitel;
    cxGridDocsLevel1: TcxGridLevel;
    cxGridDocs: TcxGridCitel;
    pnlSuperior: TPanel;
    lblEmpRaiz: TLabel;
    lblCidade: TLabel;
    lblInfoEmpRaiz: TLabel;
    lblInfoCidade: TLabel;
    cxGridFIS_DTADOC: TcxGridDBColumn;
    cxGridFIS_NUMDOC: TcxGridDBColumn;
    cxGridFIS_ESPDOC: TcxGridDBColumn;
    cxGridFIS_VLCON1: TcxGridDBColumn;
    cxGridFIS_BASISS: TcxGridDBColumn;
    cxGridFIS_ALQISS: TcxGridDBColumn;
    cxGridFIS_VALISS: TcxGridDBColumn;
    procedure cxGridDocsViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsCadFis: TUniClientDataSet;
    dtsCadFis: TDataSource;

    procedure pCarregaDocs;
    procedure pConfiguraDts;
  public
    { Public declarations }

    strAutIncDocs: String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmDocsResumoISS }

procedure TfrmDocsResumoISS.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsCadFis) then
    FreeAndNil(dtsCadFis);

  if Assigned(cdsCadFis) then
    FreeAndNil(cdsCadFis);
end;

procedure TfrmDocsResumoISS.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocs;
end;

procedure TfrmDocsResumoISS.pCarregaDocs;
var
  qryCadFis: TUniQuery;
begin
  qryCadFis := fCriaQuery(Self);
  try
    qryCadFis.Close;
    qryCadFis.SQL.Text :=
    ' SELECT  '+
    '   FIS_DTADOC, '+
    '   FIS_NUMDOC, '+
    '   FIS_ESPDOC, '+
    '   COALESCE(FIS_VLCON1, 0) AS FIS_VLCON1, '+
    '   COALESCE(FIS_BASISS, 0) AS FIS_BASISS, '+
    '   COALESCE(FIS_ALQISS, 0) AS FIS_ALQISS, '+
    '   COALESCE(FIS_VALISS, 0) AS FIS_VALISS, '+
    '   ORDEM       '+
    ' FROM( '+
    '   SELECT '+
    '     FIS_DTADOC, '+
    '     FIS_NUMDOC, '+
    '     FIS_ESPDOC, '+
    '     FIS_VLCON1, '+
    '     FIS_BASISS, '+
    '     FIS_ALQISS, '+
    '     FIS_VALISS, '+
    '     1 AS ORDEM  '+
    '   FROM '+
    '     CADFIS '+
    '   WHERE '+
    '     AUTOINCREM IN ('+strAutIncDocs+') '+

    '   UNION '+

    '   SELECT '+
    '     "" AS FIS_DTADOC, '+
    '     "" AS FIS_NUMDOC, '+
    '     "Total" AS FIS_ESPDOC, '+
    '     SUM(FIS_VLCON1) AS FIS_VLCON1, '+
    '     SUM(FIS_BASISS) AS FIS_BASISS, '+
    '     0.00 AS FIS_ALQISS, '+
    '     SUM(FIS_VALISS) AS FIS_VALISS, '+
    '     2 AS ORDEM '+
    '   FROM '+
    '     CADFIS '+
    '   WHERE '+
    '     AUTOINCREM IN ('+strAutIncDocs+') '+
    ' ) DOCS '+
    ' ORDER BY '+
    '   ORDEM, '+
    '   FIS_DTADOC, '+
    '   FIS_ESPDOC, '+
    '   FIS_NUMDOC ';

    qryCadFis.Open;

    cdsCadFis := fCriaClientDatset(qryCadFis);
    dtsCadFis := fCriaDataSource(cdsCadFis);
    pConfiguraDts;
  finally
    FreeAndNil(qryCadFis);
  end;
end;

procedure TfrmDocsResumoISS.pConfiguraDts;
begin
  TFloatField(cdsCadFis.FieldByName('FIS_VLCON1')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadFis.FieldByName('FIS_BASISS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadFis.FieldByName('FIS_ALQISS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadFis.FieldByName('FIS_VALISS')).DisplayFormat := '#,##0.00';

  pSetaClient(cdsCadFis);
  cxGridDocsView.DataController.DataSource := dtsCadFis;
end;

procedure TfrmDocsResumoISS.cxGridDocsViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not Assigned(cdsCadFis) then
    Exit;

  if not cdsCadFis.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridFIS_NUMDOC.Index]) = '' then
  begin
    ACanvas.Brush.Color := clBtnFace;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Font.Color := clBlack;
  end;
end;

end.
