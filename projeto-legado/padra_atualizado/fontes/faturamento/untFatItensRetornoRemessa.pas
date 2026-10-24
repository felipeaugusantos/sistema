unit untFatItensRetornoRemessa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, UniClientDataSet, DBGridCitel;

type
  TfrmFatItensRetornoRemessa = class(TfrmPaiSimples)
    Panel1: TPanel;
    Panel2: TPanel;
    FlowPanel1: TFlowPanel;
    btnCancelar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensDET_NUMDOC: TStringField;
    cdsItensCLI_NOMCLI: TStringField;
    cdsItensOPE_NOMOPE: TStringField;
    cdsItensDET_DTAENT: TDateField;
    cdsItensDET_CODEMP: TStringField;
    cdsItensDET_ESPDOC: TStringField;
    cdsItensDET_CODITE: TStringField;
    cdsItensDET_DESITE: TStringField;
    cdsItensDET_QTDITE: TFloatField;
    DBGridCitel1: TDBGridCitel;
    cdsItensGER_CODTRA: TStringField;
    cdsItensTRA_NOMTRA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatItensRetornoRemessa.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmFatItensRetornoRemessa.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsItensDET_CODITE);
  cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;
end;

procedure TfrmFatItensRetornoRemessa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirma);
end;

end.
