unit untRelacaoItensPedRefOR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, DBGridCitel, Vcl.DBGrids, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, UniClientDataSet;

type
  TfrmRelacaoItensPedRefOR = class(TfrmPaiSimples)
    dbgDados: TDBGridCitel;
    pnlLegenda: TPanel;
    shpDigAcm: TShape;
    Label1: TLabel;
    Label2: TLabel;
    shpDigAbx: TShape;
    dsDados: TDataSource;
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FcdsDados: TUniClientDataSet;
  public
    { Public declarations }
    property cdsDados: TUniClientDataSet Read FcdsDados Write FcdsDados;
  end;

var
  frmRelacaoItensPedRefOR: TfrmRelacaoItensPedRefOR;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmRelacaoItensPedRefOR.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If (cdsDados.RecNo Mod 2) = 0 Then
  Begin
    dbgDados.Canvas.Brush.Color := StrToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
    dbgDados.Canvas.FillRect(Rect);
  End;

  If cdsDados.FieldByName('QTDDIF').AsFloat > 0 Then
    dbgDados.Canvas.Font.Color := clBlue
  Else If cdsDados.FieldByName('QTDDIF').AsFloat < 0 Then
    dbgDados.Canvas.Font.Color := clRed;

  dbgDados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmRelacaoItensPedRefOR.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmRelacaoItensPedRefOR.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('CTLEST') = '1' Then
    dbgDados.Columns[2].Title.Caption := 'Nº Lote'
  Else
    dbgDados.Columns[2].Title.Caption := 'Armazém';

  dsDados.DataSet   := cdsDados;
  cdsDados.Filtered := False;
  cdsDados.Filter   := '(QTDDIF <> 0)';
  cdsDados.Filtered := True;
end;

end.
