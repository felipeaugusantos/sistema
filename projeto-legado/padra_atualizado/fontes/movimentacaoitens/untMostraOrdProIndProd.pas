unit untMostraOrdProIndProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls,
  EditFocus, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel, cxGrid, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, uni, cxLabel;

type
  TfrmMostraOrdProIndProd = class(TfrmPai)
    cxgOrdProIndLVL1: TcxGridLevel;
    cxgOrdProIndTV1: TcxGridDBTableViewCitel;
    cxgOrdProInd: TcxGridCitel;
    pnlProduto: TPanel;
    lblProduto: TLabel;
    edtNomPro: TEditFocus;
    Label1: TLabel;
    edtUnidade: TEditFocus;
    Label2: TLabel;
    edtReferencia: TEditFocus;
    edtCodPro: TEditFocus;
    cxgOrdProIndTV1DTACAD: TcxGridDBColumn;
    cxgOrdProIndTV1NUMOP: TcxGridDBColumn;
    cxgOrdProIndTV1QTD: TcxGridDBColumn;
    cxgOrdProIndLVLPed: TcxGridLevel;
    cxgOrdProIndDBTVPed: TcxGridDBTableViewCitel;
    cxgOrdProIndDBTVPedPEDIDO: TcxGridDBColumn;
    dtsOrdProInd: TDataSource;
    dtsPedOrdPro: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgOrdProIndTV1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgOrdProIndDBTVPedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    strCodIte : String;
    qryOrdProInd : TUniQuery;
    qryPedOrdPro : TUniQuery;
    { Private declarations }
  public
    class procedure pMostraOrdIndPendente(strCodIte: String); static;
    { Public declarations }
  end;

var
  frmMostraOrdProIndProd: TfrmMostraOrdProIndProd;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmMostraOrdProIndProd.cxgOrdProIndDBTVPedKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

procedure TfrmMostraOrdProIndProd.cxgOrdProIndTV1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

procedure TfrmMostraOrdProIndProd.FormCreate(Sender: TObject);
begin
  inherited;
  qryOrdProInd := fCriaQuery(Self);
  qryPedOrdPro := fCriaQuery(Self);

  dtsOrdProInd.DataSet := qryOrdProInd;
  dtsPedOrdPro.DataSet := qryPedOrdPro;
end;

procedure TfrmMostraOrdProIndProd.FormShow(Sender: TObject);
begin
  inherited;
  with fCriaQuery(nil) do
  begin
    SQL.Text := 'SELECT ITE_DESITE, ITE_CODUNI, ITE_REFERE FROM CADITE WHERE ITE_CODITE = :CODITE';
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    edtCodPro.Text     := strCodIte;
    edtNomPro.Text     := FieldByName('ITE_DESITE').AsString;
    edtUnidade.Text    := FieldByName('ITE_CODUNI').AsString;
    edtReferencia.Text := FieldByName('ITE_REFERE').AsString;

    Close;
  end;

  qryPedOrdPro.Close;
  qryPedOrdPro.SQL.Clear;
  qryPedOrdPro.SQL.Add('SELECT                                                             ');
  qryPedOrdPro.SQL.Add('  FDO_SEQOPI,                                                      ');
  qryPedOrdPro.SQL.Add('  CONCAT(FDO_NUMDOC, "-",FDO_ESPDOC, "-", FDO_CODEMP) AS PEDIDO    ');
  qryPedOrdPro.SQL.Add('FROM                                                               ');
  qryPedOrdPro.SQL.Add('  EXTDOR                                                           ');
  qryPedOrdPro.SQL.Add('  INNER JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO       ');
  qryPedOrdPro.SQL.Add('WHERE                                                              ');
  qryPedOrdPro.SQL.Add('  FDO_SEQOPI IS NOT NULL                                           ');
  qryPedOrdPro.SQL.Add('  AND FDO_CODITE = :CODITE                                         ');
  qryPedOrdPro.SQL.Add('ORDER BY                                                           ');
  qryPedOrdPro.SQL.Add('  FDO_CODEMP, FDO_NUMDOC                                           ');

  qryPedOrdPro.ParamByName('CODITE').AsString := strCodIte;
  qryPedOrdPro.Open;

  qryOrdProInd.Close;
  qryOrdProInd.SQL.Clear;
  qryOrdProInd.SQL.Add('SELECT                                                             ');
  qryOrdProInd.SQL.Add('  G.AUTOINCREM,                                                    ');
  qryOrdProInd.SQL.Add('  G.ORD_DTACAD,                                                    ');
  qryOrdProInd.SQL.Add('  G.ORD_CODORD,                                                    ');
  qryOrdProInd.SQL.Add('  SUM(D.ORD_QTDPRO - (SELECT IFNULL(SUM(DET_QTDITE),0)             ');
  qryOrdProInd.SQL.Add('                      FROM ORDBAI                                  ');
  qryOrdProInd.SQL.Add('                      INNER JOIN MOVDET ON DET_SEQGER = ORB_SEQGER ');
  qryOrdProInd.SQL.Add('                      WHERE ORB_SEQOPI = G.AUTOINCREM)) AS QTDPEN  ');
  qryOrdProInd.SQL.Add('FROM                                                               ');
  qryOrdProInd.SQL.Add('  ORDDET D                                                         ');
  qryOrdProInd.SQL.Add('  INNER JOIN ORDGER G ON G.AUTOINCREM = D.ORD_SEQGER               ');
  qryOrdProInd.SQL.Add('WHERE                                                              ');
  qryOrdProInd.SQL.Add('      D.ORD_CODITE = :CODITE                                       ');
  qryOrdProInd.SQL.Add('  AND G.ORD_DTABAI IS NULL                                         ');
  qryOrdProInd.SQL.Add('GROUP BY                                                           ');
  qryOrdProInd.SQL.Add('  G.AUTOINCREM                                                     ');
  qryOrdProInd.SQL.Add('ORDER BY                                                           ');
  qryOrdProInd.SQL.Add('  G.ORD_DTACAD, G.ORD_CODORD                                       ');

  qryOrdProInd.ParamByName('CODITE').AsString := strCodIte;
  qryOrdProInd.Open;
end;

class procedure TfrmMostraOrdProIndProd.pMostraOrdIndPendente(strCodIte : String);
begin
  try
    pCriarFormularios(TfrmMostraOrdProIndProd, frmMostraOrdProIndProd);
    frmMostraOrdProIndProd.strCodIte := strCodIte;
    frmMostraOrdProIndProd.ShowModal;
  finally
    pFreeAndNil(frmMostraOrdProIndProd);
  end;
end;

end.
