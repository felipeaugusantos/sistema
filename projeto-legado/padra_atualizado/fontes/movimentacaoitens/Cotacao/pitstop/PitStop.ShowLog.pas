unit PitStop.ShowLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Uni, untFuncoesSimples, untPai,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxMemo;

type
  TfrmLogPitStop = class(TfrmPai)
    cxgPitStopLog: TcxGridDBTableViewCitel;
    cxlLog: TcxGridLevel;
    cxPitStopLog: TcxGridCitel;
    dtsLog: TDataSource;
    cxgPitStopLogColumn1: TcxGridDBColumn;
    cxgPitStopLogColumn2: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    qryConsulta: TUniQuery;
    { Private declarations }
  public
    { Public declarations }

    class procedure pShowLogPitStop(ANumCot, ACodFor: string);
    class function fServicoConectado(ANumCot, ACodFor: string; var lCON_ID_CON: String): Boolean;


  end;

var
  frmLogPitStop: TfrmLogPitStop;

implementation

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmLogPitStop.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery;
end;

procedure TfrmLogPitStop.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  inherited;
end;

class function TfrmLogPitStop.fServicoConectado(ANumCot,
  ACodFor: string; var lCON_ID_CON: String): Boolean;
var qry: TUniQuery;
begin
  lCON_ID_CON := '';
  qry := fCriaQuery;
  Try
    qry.SQl.Add('SELECT CON_ID_CON FROM CONPIT');
    qry.SQl.Add('WHERE CON_COTGER = (SELECT AUTOINCREM FROM COTGER WHERE COT_NUMCOT = "' + ANumCot+ '")');
    qry.SQl.Add('AND CON_CODFOR = "'+ACodFor+'"');
    qry.SQl.Add('AND CON_STATUS <> -1');
    qry.Open;

    lCON_ID_CON := qry.FieldByName('CON_ID_CON').AsString;

    qry.SQL.Clear;
    qry.SQl.Add('SELECT (SELECT COUNT(1) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE ID = CON_CONNEC) EXECUTANDO FROM CONPIT');
    qry.SQl.Add('WHERE CON_ID_CON = "'+lCON_ID_CON+'"');
    qry.Open;
    Result :=  qry.FieldByName('EXECUTANDO').AsInteger > 0;
  Finally
    FreeAndNil(qry);
  End;

end;

class procedure TfrmLogPitStop.pShowLogPitStop(ANumCot, ACodFor: string);
var qry: TUniQuery;
    lCON_ID_CON: String;
begin
  lCON_ID_CON := '';
  qry := fCriaQuery;
  Try
    qry.SQl.Add('SELECT CON_ID_CON FROM CONPIT');
    qry.SQl.Add('WHERE CON_COTGER = (SELECT AUTOINCREM FROM COTGER WHERE COT_NUMCOT = "' + ANumCot+ '")');
    qry.SQl.Add('AND CON_CODFOR = "'+ACodFor+'"');
    qry.SQl.Add('AND CON_STATUS <> -1');
    qry.Open;

    lCON_ID_CON := qry.FieldByName('CON_ID_CON').AsString;
  Finally
    FreeAndNil(qry);
  End;

  If Not fEmptyStr(lCON_ID_CON) Then
  Begin
    pCriarFormularios(TfrmLogPitStop, frmLogPitStop);
    Try
      frmLogPitStop.qryConsulta.SQL.Add('SELECT LOG_DTAOCO,');
      frmLogPitStop.qryConsulta.SQL.Add('       LOG_RETAPI');
      frmLogPitStop.qryConsulta.SQL.Add('  FROM LOG_PITSTOP');
      frmLogPitStop.qryConsulta.SQL.Add(' WHERE LOG_ID_CON = "'+lCON_ID_CON+'"');
      frmLogPitStop.qryConsulta.SQL.Add(' ORDER BY LOG_DTAOCO DESC');
      frmLogPitStop.qryConsulta.Open;
      frmLogPitStop.dtsLog.DataSet := frmLogPitStop.qryConsulta;
      frmLogPitStop.ShowModal;
    Finally
      FreeAndNil(frmLogPitStop)
    End;
  End;
end;

end.
