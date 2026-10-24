unit untImpFaturaContrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Datasnap.DBClient, UniClientDataSet;

type
  TfrmImpFaturaContrato = class(TfrmPai)
    Panel1: TPanel;
    dbgFaturasContrato: TDBGridCitel;
    btnSelectodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    cdsSelecaoFaturas: TUniClientDataSet;
    dtsSelecaoFaturas: TDataSource;
    cdsSelecaoFaturasCTR_NUMDUP: TStringField;
    cdsSelecaoFaturasCTR_ESPDOC: TStringField;
    cdsSelecaoFaturasCTR_CODEMP: TStringField;
    cdsSelecaoFaturasCTR_PARCEL: TStringField;
    cdsSelecaoFaturasCTR_DTAVEN: TDateField;
    cdsSelecaoFaturasCTR_VALDUP: TFloatField;
    cdsSelecaoFaturasCTR_DTAREC: TDateField;
    cdsSelecaoFaturasCTR_VALREC: TFloatField;
    cdsSelecaoFaturasIMPRIM: TBooleanField;
    btnDesmarcartodas: TBitBtnLocked;
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSelectodasClick(Sender: TObject);
    procedure dbgFaturasContratoDblClick(Sender: TObject);
    procedure dbgFaturasContratoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesmarcartodasClick(Sender: TObject);
    procedure dbgFaturasContratoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmImpFaturaContrato.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnFecharComEscape := false;
  close;
end;

procedure TfrmImpFaturaContrato.btnDesmarcartodasClick(Sender: TObject);
begin
  inherited;
  cdsSelecaoFaturas.DisableControls;
  cdsSelecaoFaturas.First;
  while not cdsSelecaoFaturas.eof do
  begin
    cdsSelecaoFaturas.Edit;
    cdsSelecaoFaturasIMPRIM.AsBoolean := False;
    cdsSelecaoFaturas.Post;
    cdsSelecaoFaturas.Next;
  end;
  cdsSelecaoFaturas.First;
  cdsSelecaoFaturas.EnableControls;
end;

procedure TfrmImpFaturaContrato.btnSairClick(Sender: TObject);
begin
  inherited;
  blnFecharComEscape := true;
end;

procedure TfrmImpFaturaContrato.btnSelectodasClick(Sender: TObject);
begin
  inherited;
  cdsSelecaoFaturas.DisableControls;
  cdsSelecaoFaturas.First;
  while not cdsSelecaoFaturas.eof do
  begin
    cdsSelecaoFaturas.Edit;
    cdsSelecaoFaturasIMPRIM.AsBoolean := True;
    cdsSelecaoFaturas.Post;
    cdsSelecaoFaturas.Next;
  end;
  cdsSelecaoFaturas.First;
  cdsSelecaoFaturas.EnableControls;
end;

procedure TfrmImpFaturaContrato.dbgFaturasContratoDblClick(Sender: TObject);
begin
  inherited;
  cdsSelecaoFaturas.Edit;
  cdsSelecaoFaturasIMPRIM.asBoolean := not (cdsSelecaoFaturasIMPRIM.asBoolean);
  cdsSelecaoFaturas.Post;
end;

procedure TfrmImpFaturaContrato.dbgFaturasContratoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If (cdsSelecaoFaturasIMPRIM.asBoolean) then
    dbgFaturasContrato.Canvas.Font.Color := clBlue;
  If not (cdsSelecaoFaturasIMPRIM.asBoolean) then
    dbgFaturasContrato.Canvas.Font.Color := clBlack;

  dbgFaturasContrato.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmImpFaturaContrato.dbgFaturasContratoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    dbgFaturasContratoDblClick(dbgFaturasContrato);
  End
end;

procedure TfrmImpFaturaContrato.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End;

  If Key = VK_F2 Then
  begin
    btnSelectodas.Click;
  End;

  If Key = VK_F3 Then
  begin
    btnDesmarcartodas.Click;
  End;
end;

end.
