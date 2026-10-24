unit untImpEtiDespachoSelecaoCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, UniClientDataSet, untImpEtiDespacho, untFuncoesSimples;

type
  TfrmImpEtiDespachoSelecaoCaixas = class(TfrmPaiSimples)
    Panel1: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    Panel2: TPanel;
    dbgSelecaoCaixas: TDBGridCitel;
    dtsSelecaoCaixas: TDataSource;
    cdsSelecaoCaixas: TUniClientDataSet;
    cdsSelecaoCaixasFGC_IMPRIM: TBooleanField;
    cdsSelecaoCaixasFGC_CAI_ID: TStringField;
    cdsSelecaoCaixasFGO_NUMDOC: TStringField;
    cdsSelecaoCaixasFGO_ESPDOC: TStringField;
    cdsSelecaoCaixasFGO_CODEMP: TStringField;
    cdsSelecaoCaixasFGC_NUMFAT: TStringField;
    cdsSelecaoCaixasFGC_TIPFAT: TStringField;
    cdsSelecaoCaixasFGC_EMPFAT: TStringField;
    cdsSelecaoCaixasCLI_BAIRRO: TStringField;
    cdsSelecaoCaixasCLI_C_E_P_: TStringField;
    cdsSelecaoCaixasCLI_CODCLI: TStringField;
    cdsSelecaoCaixasCLI_ENDERE: TStringField;
    cdsSelecaoCaixasCLI_ENDNUM: TStringField;
    cdsSelecaoCaixasCLI_ENDCOM: TStringField;
    cdsSelecaoCaixasCLI_CODCID: TStringField;
    cdsSelecaoCaixasCLI_FANSOB: TStringField;
    cdsSelecaoCaixasFGO_DTAENT: TDateField;
    cdsSelecaoCaixasFDO_CODVEN: TStringField;
    cdsSelecaoCaixasFDO_CODVE2: TStringField;
    cdsSelecaoCaixasFDO_NUMCMP: TStringField;
    cdsSelecaoCaixasFGO_SEPEXP: TStringField;
    cdsSelecaoCaixasFGO_OPEEXP: TStringField;
    cdsSelecaoCaixasREG_DESREG: TStringField;
    cdsSelecaoCaixasTRA_NOMTRA: TStringField;
    cdsSelecaoCaixasFGC_FDOINC: TStringField;
    cdsSelecaoCaixasFDO_TOTPES: TFloatField;
    cdsSelecaoCaixasFGO_PESBRU: TFloatField;
    cdsSelecaoCaixasFGO_CODROT: TStringField;
    cdsSelecaoCaixasFGC_DETINC: TStringField;
    cdsSelecaoCaixasREG_CODREG: TStringField;
    cdsSelecaoCaixasSEPAUT: TStringField;
    cdsSelecaoCaixasENDENT: TStringField;
    cdsSelecaoCaixasCEPENT: TStringField;
    cdsSelecaoCaixasCIDENT: TStringField;
    cdsSelecaoCaixasESTENT: TStringField;
    cdsSelecaoCaixasBAIENT: TStringField;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure dbgSelecaoCaixasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgSelecaoCaixasDblClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmImpEtiDespachoSelecaoCaixas.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  cdsSelecaoCaixas.DisableControls;
  cdsSelecaoCaixas.First;
  while not cdsSelecaoCaixas.eof do
  begin
    cdsSelecaoCaixas.Edit;
    cdsSelecaoCaixasFGC_IMPRIM.AsBoolean := True;
    cdsSelecaoCaixas.Post;
    cdsSelecaoCaixas.Next;
  end;
  cdsSelecaoCaixas.First;
  cdsSelecaoCaixas.EnableControls;
end;

procedure TfrmImpEtiDespachoSelecaoCaixas.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnFecharComEscape := false;
  close;
end;

procedure TfrmImpEtiDespachoSelecaoCaixas.btnSairClick(Sender: TObject);
begin
  blnFecharComEscape := true;
  inherited;
end;

procedure TfrmImpEtiDespachoSelecaoCaixas.dbgSelecaoCaixasDblClick(
  Sender: TObject);
begin
  inherited;
  cdsSelecaoCaixas.Edit;
  cdsSelecaoCaixasFGC_IMPRIM.asBoolean := not (cdsSelecaoCaixasFGC_IMPRIM.asBoolean);
  cdsSelecaoCaixas.Post;
end;

procedure TfrmImpEtiDespachoSelecaoCaixas.dbgSelecaoCaixasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);

begin
  inherited;

  if (cdsSelecaoCaixasFGC_IMPRIM.asBoolean) then
    dbgSelecaoCaixas.Canvas.Font.Color := clBlue;
  if not (cdsSelecaoCaixasFGC_IMPRIM.asBoolean) then
    dbgSelecaoCaixas.Canvas.Font.Color := clBlack;

  dbgSelecaoCaixas.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmImpEtiDespachoSelecaoCaixas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End

end;

procedure TfrmImpEtiDespachoSelecaoCaixas.FormShow(Sender: TObject);
begin
  inherited;
  cdsSelecaoCaixas.First;
end;

end.
