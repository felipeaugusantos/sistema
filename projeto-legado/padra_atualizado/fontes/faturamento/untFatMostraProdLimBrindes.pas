unit untFatMostraProdLimBrindes;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, AppEvnts {Qt,},
  BitBtnLockedIncrem, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatMostraProdLimBrindes = class(TfrmPaiSimples)
    dbeItens: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESCRI: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensMAXBRI: TFloatField;
    dtsItens: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure dbeItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatMostraProdLimBrindes: TfrmFatMostraProdLimBrindes;

implementation

{$R *.dfm}

procedure TfrmFatMostraProdLimBrindes.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdLimBrindes.dbeItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnFechar.Click;
end;

procedure TfrmFatMostraProdLimBrindes.FormCreate(Sender: TObject);
begin
  cdsItens.CreateDataSet;
  cdsItens.Open;
  dbeItens.DataSource := dtsItens;
end;

procedure TfrmFatMostraProdLimBrindes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsItens.Close;
end;

End.

