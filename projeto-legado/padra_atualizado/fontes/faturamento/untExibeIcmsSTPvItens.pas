unit untExibeIcmsSTPvItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmExibeIcmsSTPvItens = class(TfrmPai)
    DBGridCitel1: TDBGridCitel;
    dtsDados: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataSet : TDataSet;
  end;

var
  frmExibeIcmsSTPvItens: TfrmExibeIcmsSTPvItens;

implementation

{$R *.dfm}

procedure TfrmExibeIcmsSTPvItens.FormShow(Sender: TObject);
begin
  inherited;
  dtsDados.DataSet := DataSet;
end;

end.
