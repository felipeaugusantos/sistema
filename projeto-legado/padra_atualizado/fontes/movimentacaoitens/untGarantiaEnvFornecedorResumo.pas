unit untGarantiaEnvFornecedorResumo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFormGrid, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Datasnap.DBClient, UniClientDataSet, Vcl.Mask, Vcl.DBCtrls, DBEditFocus;

type
  TfrmGarantiaEnvFornecedorResumo = class(TfrmGrid)
    grdInfoCODITE: TcxGridDBColumn;
    grdInfoDESITE: TcxGridDBColumn;
    grdInfoREFERE: TcxGridDBColumn;
    grdInfoUNIDAD: TcxGridDBColumn;
    grdInfoQTDREQ: TcxGridDBColumn;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensREFERE: TStringField;
    cdsItensUNIDAD: TStringField;
    cdsItensQTDREQ: TFloatField;
    cdsItensQTDTOT: TAggregateField;
    cdsItensQTDITE: TAggregateField;
    pnlTotais: TPanel;
    pnlQtdTotal: TPanel;
    edtQtdTotal: TDBEditFocus;
    Label1: TLabel;
    pnlQtdItens: TPanel;
    Label2: TLabel;
    edtQtdItens: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGarantiaEnvFornecedorResumo: TfrmGarantiaEnvFornecedorResumo;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmGarantiaEnvFornecedorResumo.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsItensCODITE);
  cdsItens.CreateDataSet;
end;

procedure TfrmGarantiaEnvFornecedorResumo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(grdInfo);
end;

end.
