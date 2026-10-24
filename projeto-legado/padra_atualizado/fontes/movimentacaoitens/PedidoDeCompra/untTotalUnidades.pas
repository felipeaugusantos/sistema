unit untTotalUnidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit;

type
  TfrmTotalUnidades = class(TfrmPai)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dtsUnidades: TDataSource;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    procedure cxGrid1DBTableView1Column3GetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
  public
    class procedure pChamaTela(DataSet: TDataSet);
    { Public declarations }
  end;



implementation

{$R *.dfm}

uses untResumoPedido, untFuncoesSimples;

procedure TfrmTotalUnidades.cxGrid1DBTableView1Column3GetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If AText = 'K' Then
   AText := 'Kilo'
  Else if AText = 'L' Then
   AText := 'Litro'
end;

class procedure TfrmTotalUnidades.pChamaTela(DataSet: TDataSet);
var
  frmTotalUnidades: TfrmTotalUnidades;
begin
  pCriarFormularios(TfrmTotalUnidades, frmTotalUnidades);
  frmTotalUnidades.dtsUnidades.DataSet := DataSet;
  frmTotalUnidades.ShowModal;

  FreeAndNil(frmTotalUnidades)


end;

end.



