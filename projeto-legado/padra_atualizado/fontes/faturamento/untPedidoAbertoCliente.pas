unit untPedidoAbertoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  EditFocus, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPedidoAbertoCliente = class(TfrmPai)
    dbePedidos: TcxGrid;
    cxGridDados: TcxGridDBTableView;
    cxGridNivel: TcxGridLevel;
    dtsPedidos: TDataSource;
    cxGridDadosDTAENT: TcxGridDBColumn;
    cxGridDadosNUMDOC: TcxGridDBColumn;
    cxGridDadosNUMEMP: TcxGridDBColumn;
    cxGridDadosCODVEN: TcxGridDBColumn;
    cxGridDadosCONPAG: TcxGridDBColumn;
    cxGridDadosPREVIS: TcxGridDBColumn;
    cxGridDadosVLRCON: TcxGridDBColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    pnlCliente: TPanel;
    lbl1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    pnlTit: TPanel;
    cxGridDadosTOTABE: TcxGridDBColumn;
    cxGridDadosVALADT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridDadosCONPAGGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    qryPed: TUniQuery;
    procedure pPedidosEmAberto;
  public
    { Public declarations }
    strCodCli: String;
    class procedure pMostrarPedidosEmAberto(Const strCodCli: String);
  end;

var
  frmPedidoAbertoCliente: TfrmPedidoAbertoCliente;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

{ TfrmPedidoAbertoCliente }

procedure TfrmPedidoAbertoCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryPed);
end;

procedure TfrmPedidoAbertoCliente.FormShow(Sender: TObject);
begin
  inherited;
  pPedidosEmAberto;
  edtCodCliente.Text := strCodCli;
  edtDesCliente.Text := fRetNomCliente(strCodCli);
end;

procedure TfrmPedidoAbertoCliente.cxGridDadosCONPAGGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := fFormataCondPag(AText);
end;

class procedure TfrmPedidoAbertoCliente.pMostrarPedidosEmAberto(
  const strCodCli: String);
  Var
    frmPedidos: TfrmPedidoAbertoCliente;
begin
  Try
    pCriarFormularios(TfrmPedidoAbertoCliente, frmPedidos);
    frmPedidos.strCodCli := strCodCli;
    frmPedidos.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
  pFreeAndNil(frmPedidos);
end;

procedure TfrmPedidoAbertoCliente.pPedidosEmAberto;
begin
  qryPed := fCriaQuery(Self);

  dtsPedidos.DataSet := qryPed;

  qryPed.Close;
  qryPed.SQL.Clear;
  qryPed.SQL.Add('SELECT');
  qryPed.SQL.Add('  DTAENT,');
  qryPed.SQL.Add('  PREVIS,');
  qryPed.SQL.Add('  NUMDOC,');
  qryPed.SQL.Add('  NOMEMP,');
  qryPed.SQL.Add('  CODVEN,');
  qryPed.SQL.Add('  CONPAG,');
  qryPed.SQL.Add('  IFNULL(VLRCON, 0) AS VLRCON,');
  qryPed.SQL.Add('  IFNULL(TOTABE, 0) AS TOTABE,');
  qryPed.SQL.Add('  IFNULL(VALADT, 0) AS VALADT ');
  qryPed.SQL.Add('FROM ');
  qryPed.SQL.Add('(' + fGetSqlPedidosEmAberto + ') AS PEDIDOS ');
  qryPed.ParamByName('CODCLI').AsString := strCodCli;
  qryPed.Open;

  (qryPed.FieldByName('VLRCON') As TFloatField).DisplayFormat := ',0.00';
  (qryPed.FieldByName('TOTABE') As TFloatField).DisplayFormat := ',0.00';
  (qryPed.FieldByName('VALADT') As TFloatField).DisplayFormat := ',0.00';

  cxGridDados.ViewData.Expand(True);
  cxGridDados.DataController.GotoFirst;
end;

end.
