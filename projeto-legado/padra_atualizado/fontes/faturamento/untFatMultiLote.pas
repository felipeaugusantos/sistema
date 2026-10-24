unit untFatMultiLote;

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
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.Provider,
  Datasnap.DBClient, UniClientDataSet;

type
  TfrmFatMultiLote = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    pnlBotoesMostra: TPanel;
    btnCancelar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    grdMultiLoteDBTableView1: TcxGridDBTableView;
    grdMultiLoteLevel1: TcxGridLevel;
    grdMultiLote: TcxGrid;
    dtsMultiLote: TDataSource;
    grdMultiLoteDBTableViewNUMLOT: TcxGridDBColumn;
    grdMultiLoteDBTableViewDESARM: TcxGridDBColumn;
    grdMultiLoteDBTableViewQTDITE: TcxGridDBColumn;
    cdsMultiLote: TUniClientDataSet;
    cdsMultiLoteLOT_NUMLOT: TStringField;
    cdsMultiLoteAMZ_DESCRI: TStringField;
    cdsMultiLoteQTDITE: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatMultiLote: TfrmFatMultiLote;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMultiLote.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmFatMultiLote.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMultiLote.CreateDataSet;
end;

procedure TfrmFatMultiLote.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(grdMultiLote);
end;

end.
