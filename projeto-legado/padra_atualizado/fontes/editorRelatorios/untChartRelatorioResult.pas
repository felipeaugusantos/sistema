unit untChartRelatorioResult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridChartView, cxGridDBChartView,
  dxGDIPlusClasses;

type
  TfrmChartRelatorioResult = class(TfrmPaiEdit)
    dtsGrafigo: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    pnlMolduraSuperior: TPanel;
    pnlMolduraInferior: TPanel;
    pnlMolduraEsquerda: TPanel;
    pnlMolduraDireita: TPanel;
    Panel5: TPanel;
    shpGrafico: TShape;
    cxgGrafico: TcxGrid;
    cxvGrafico: TcxGridDBChartView;
    cxvGraficoSeries1: TcxGridDBChartSeries;
    cxgGraficoLevel1: TcxGridLevel;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChartRelatorioResult: TfrmChartRelatorioResult;

implementation

{$R *.dfm}

procedure TfrmChartRelatorioResult.FormResize(Sender: TObject);
begin
  inherited;

  If shpGrafico.Visible Then
  Begin
    cxgGrafico.Width := shpGrafico.Width - 20;
    cxgGrafico.Left  := shpGrafico.Left + 10;

    cxgGrafico.Height := shpGrafico.Height - 20;
    cxgGrafico.Top    := shpGrafico.Top + 10;
  End;

end;

end.
