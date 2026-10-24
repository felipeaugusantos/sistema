unit untFatConsultaItemEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, untTypesSistema, MemDS, DBAccess, Uni;

type
  TfrmFatConsultaItemEntrega = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    cxgItensDBTableView: TcxGridDBTableView;
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGrid;
    dtsItens: TDataSource;
    cxgItensCODIGO: TcxGridDBColumn;
    cxgItensDESCRI: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensTOTVLR: TcxGridDBColumn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCliente: TLabel;
    lblDocumento: TLabel;
    lblData: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FQryItens: TUniQuery;

    procedure pCarregaItensDocumento;
  public
    { Public declarations }
    FAutInc: String;
  end;


implementation

uses untFuncoesSimples, StrUtils;

{$R *.dfm}

procedure TfrmFatConsultaItemEntrega.FormCreate(Sender: TObject);
begin
  inherited;
  FQryItens := fCriaQuery;
  dtsItens.DataSet := FQryItens;
end;

procedure TfrmFatConsultaItemEntrega.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FQryItens);

  inherited;
end;

procedure TfrmFatConsultaItemEntrega.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaItensDocumento;
end;

procedure TfrmFatConsultaItemEntrega.pCarregaItensDocumento;
begin
  FQryItens.Close;
  FQryItens.SQL.Clear;
  FQryItens.SQL.Add('SELECT DET_CODITE AS CODIGO, DET_DESCRI AS DESCRI, DET_QTDITE AS QTDITE, DET_TOTITE AS TOTVLR,');
  FQryItens.SQL.Add('       DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, DET_DTAENT');
  FQryItens.SQL.Add('FROM MOVDET');
  FQryItens.SQL.Add('WHERE DET_SEQGER = :SEQGER');
  FQryItens.ParamByName('SEQGER').AsString := FAutInc;
  FQryItens.Open;
  TFloatField(FQryItens.FieldByName('QTDITE')).DisplayFormat := '#0.0000';
  TFloatField(FQryItens.FieldByName('TOTVLR')).DisplayFormat := '#,##0.00';
  lblDocumento.Caption := FQryItens.FieldByName('DET_NUMDOC').AsString + '-' + FQryItens.FieldByName('DET_ESPDOC').AsString + '-' + FQryItens.FieldByName('DET_CODEMP').AsString;
  lblCliente.Caption := FQryItens.FieldByName('DET_CODCLI').AsString + '-' + fRetNomCliente(FQryItens.FieldByName('DET_CODCLI').AsString);
  lblData.Caption := FormatDateTime('dd/mm/yyyy', FQryItens.FieldByName('DET_DTAENT').AsDateTime);
end;

end.
