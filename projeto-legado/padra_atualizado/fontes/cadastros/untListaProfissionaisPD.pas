unit untListaProfissionaisPD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, UniClientDataSet;

type
  TfrmListaProfissionaisPD = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    dbgProf: TDBGridCitel;
    cdsProfi: TUniClientDataSet;
    cdsProfiCODIGO: TStringField;
    cdsProfiPROFIS: TStringField;
    dtsProfi: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmListaProfissionaisPD.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProfi.CreateDataSet;
  pSetFocus(dbgProf);
end;

procedure TfrmListaProfissionaisPD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

end.
