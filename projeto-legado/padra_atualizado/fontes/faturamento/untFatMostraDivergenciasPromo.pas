unit untFatMostraDivergenciasPromo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmFatMostraDivergenciasPromo = class(TfrmPai)
    dbgItens: TDBGridCitel;
    dtsItens: TDataSource;
    lblMSG: TLabel;
    lblAtencao: TLabel;
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatMostraDivergenciasPromo: TfrmFatMostraDivergenciasPromo;

implementation

{$R *.dfm}

procedure TfrmFatMostraDivergenciasPromo.dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    Close;
end;

end.
