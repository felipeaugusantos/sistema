unit untRateioPlanCtas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.Grids, Vcl.DBGrids, System.UITypes,
  Vcl.StdCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Data.DB,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient,
  Uni, StrUtils, DbGridCitel, DBAccess;

type
  THackDBGrid = class(TDBGridCitel);

  TFrmRateioPlanCtas = class(TfrmPaiSimples)
    gridCtpDet: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    dsCtpDet: TUniDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FqryCtpDet: TUniQuery;
  public
    procedure pSetarCtpDet(ANumDup, AParcel, ASerie, ACodEmp, ACodFor: String);
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TFrmRateioPlanCtas }

procedure TFrmRateioPlanCtas.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmRateioPlanCtas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(gridCtpDet);
end;

procedure TFrmRateioPlanCtas.FormDestroy(Sender: TObject);
begin
  FqryCtpDet.Free;
  inherited;
end;

procedure TFrmRateioPlanCtas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

procedure TFrmRateioPlanCtas.pSetarCtpDet(ANumDup, AParcel, ASerie, ACodEmp, ACodFor: String);
  ResourceString
    SQL = 'SELECT' +
      '   CTPDET.CTP_CODEMP,' +
      '   CONCAT(CADCTA.CTA_CODCTA, '' - '', CTA_DESCTA) CTA_DESCTA,' +
      '   CTP_FATCAL * CADPAG.CTP_VALORI VALORRATEADO' +
      ' FROM' +
      '   CTPDET' +
      '   JOIN CADCTA' +
      '     ON CADCTA.CTA_CODCTA = CTPDET.CTP_CODCTA' +
      '   JOIN CADPAG ' +
      '     ON CADPAG.CTP_NUMDUP = CTPDET.CTP_NUMDUP ' +
      '    AND CADPAG.CTP_PARCEL = CTPDET.CTP_PARCEL ' +
      '    AND CADPAG.CTP_SERIE_ = CTPDET.CTP_SERIE_ ' +
      '    AND CADPAG.CTP_CODFOR = CTPDET.CTP_CODFOR ' +
      '    AND CADPAG.CTP_CODEMP = CTPDET.CTP_EMPORI ' +
      ' WHERE CTPDET.CTP_NUMDUP = :NUMDUP' +
      '   AND CTPDET.CTP_PARCEL = :PARCEL' +
      '   AND %s' +
      '   AND CTPDET.CTP_EMPORI = :EMPORI' +
      '   AND CTPDET.CTP_CODFOR = :CODFOR';

begin
  FqryCtpDet := fCriaQuery;
  If (fEmptyStr(ASerie)) Then
    FqryCtpDet.SQL.Text := Format(SQL, ['((CTPDET.CTP_SERIE_ IS NULL) OR (CTPDET.CTP_SERIE_ = "")) '])
  Else
    FqryCtpDet.SQL.Text := Format(SQL, ['CTPDET.CTP_SERIE_ = :SERIE_ ']);

  FqryCtpDet.ParamByName('NUMDUP').AsString := ANumDup;
  FqryCtpDet.ParamByName('PARCEL').AsString := AParcel;

  If (Not fEmptyStr(ASerie)) Then
    FqryCtpDet.ParamByName('SERIE_').AsString := ASerie;

  FqryCtpDet.ParamByName('EMPORI').AsString := ACodEmp;
  FqryCtpDet.ParamByName('CODFOR').AsString := ACodFor;
  FqryCtpDet.Open;
  TFloatField(FqryCtpDet.FieldByName('VALORRATEADO')).DisplayFormat := fMskDigitos(2);
  dsCtpDet.Dataset := FqryCtpDet;
end;

end.
