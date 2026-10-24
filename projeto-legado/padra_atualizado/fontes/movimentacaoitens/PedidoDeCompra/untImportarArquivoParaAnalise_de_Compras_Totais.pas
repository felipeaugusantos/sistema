unit untImportarArquivoParaAnalise_de_Compras_Totais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit;

type
  TfrmImportarArquivoParaAnalise_de_Compras_Totais = class(TfrmPaiConfirma)
    cxDadosDB: TcxGridDBTableView;
    cxDadosLvl: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    cxDadosCODFOR: TcxGridDBColumn;
    cxDadosNOMFOR: TcxGridDBColumn;
    cxDadosTOTPED: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
