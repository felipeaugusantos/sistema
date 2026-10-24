unit untConfirmaCancelamentoTAsVinculadas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.StdCtrls, MemoFocus, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxGrid, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, MemDS, DBAccess, Uni, cxLabel;

type
  TfrmConfirmaCancelamentoTAsVinculadas = class(TfrmPaiConfirma)
    cxgDocumentosDBTBV: TcxGridDBTableViewCitel;
    cxgDocumentosLVL: TcxGridLevel;
    cxgDocumentos: TcxGridCitel;
    Panel1: TPanel;
    lblMensagem: TLabel;
    cxgDocumentosDBTBVDOCUMENTO: TcxGridDBColumn;
    cxgDocumentosDBTBVDET_NUMLOT: TcxGridDBColumn;
    cxgDocumentosDBTBVDET_QTDITE: TcxGridDBColumn;
    cxgDocumentosDBTBVPRODUTO: TcxGridDBColumn;
    cxgDocumentosDBTBVENTSAI: TcxGridDBColumn;
    cxgDocumentosDBTBVCLIENTE: TcxGridDBColumn;
    dtsDocumentos: TDataSource;
    lblAviso: TLabel;
    dtsFaturamentos: TDataSource;
    pnlLotesFaturados: TPanel;
    cxGridCitel1: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Splitter1: TSplitter;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    qryQuery : TUniQuery;
    qryLotesComFaturamento: TUniQuery;
    blnTemItemMarmore: Boolean;
    function fTemItemMamore(strAutoIncremDocumento: String): Boolean;
    procedure pCarregaLotesComFaturamento(strAutoIncremDocumento: String);
    { Private declarations }
  public
    strAutoIncremDocumento : String;

    class function fMensagemDocumentos(strAutoincrem : String) : boolean;
    { Public declarations }
  end;

var
  frmConfirmaCancelamentoTAsVinculadas: TfrmConfirmaCancelamentoTAsVinculadas;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

class function TfrmConfirmaCancelamentoTAsVinculadas.fMensagemDocumentos(
  strAutoincrem: String): boolean;
begin
  pCriarFormularios(TfrmConfirmaCancelamentoTAsVinculadas, frmConfirmaCancelamentoTAsVinculadas);
  frmConfirmaCancelamentoTAsVinculadas.strAutoIncremDocumento := strAutoincrem;
  frmConfirmaCancelamentoTAsVinculadas.ShowModal;

  result := frmConfirmaCancelamentoTAsVinculadas.ModalResult = mrOk;

  pFreeAndNil(frmConfirmaCancelamentoTAsVinculadas);

end;

procedure TfrmConfirmaCancelamentoTAsVinculadas.FormCreate(Sender: TObject);
begin
  inherited;
  blnTemItemMarmore := False;
  qryLotesComFaturamento := fCriaQuery(Self);
  qryQuery := fCriaQuery(Self);
  dtsDocumentos.DataSet := qryQuery;
    lblAviso.Visible := False;
  If fCfgSis('MARMOR', varBoolean) then
  Begin
    lblAviso.Visible := True;
    lblAviso.Caption := 'Atenção! O lote "A DEFINIR" não será excluido pois é um lote de controle do sistema.' + #$A#$D +
                        'Os lotes não serão excluido quanto tiverem saldo mesmo após o cancelamento do documento.'
  End;
end;

procedure TfrmConfirmaCancelamentoTAsVinculadas.FormShow(Sender: TObject);
begin
  inherited;
  qryQuery.SQL.Add('SELECT                                                          ');
  qryQuery.SQL.Add('   CONCAT(GER_ESPDOC, "-",                                      ');
  qryQuery.SQL.Add('          GER_NUMDOC, "-",                                      ');
  qryQuery.SQL.Add('          GER_CODEMP, IF(IFNULL(GER_SERIE_,"") = "", "","-"),   ');
  qryQuery.SQL.Add('          GER_SERIE_ ) AS DOCUMENTO,                            ');
  qryQuery.SQL.Add('   CONCAT(GER_CODCLI, "-",                                      ');
  qryQuery.SQL.Add('          CLI_NOMCLI) AS CLIENTE,                               ');
  qryQuery.SQL.Add('   CONCAT(DET_CODITE, "-",                                      ');
  qryQuery.SQL.Add('          ITE_DESITE) AS PRODUTO,                               ');
  qryQuery.SQL.Add('   DET_NUMLOT,                                                  ');
  qryQuery.SQL.Add('   DET_QTDITE,                                                  ');
  qryQuery.SQL.Add('   IF(LEFT(DET_CLAFIS, 1) >= 5, "SAÍDA", "ENTRADA") AS ENTSAI   ');
  qryQuery.SQL.Add(' FROM                                                           ');
  qryQuery.SQL.Add('   AUXMOV                                                       ');
  qryQuery.SQL.Add('   INNER JOIN MOVGER ON MOVGER.AUTOINCREM = AUX_SEQGER          ');
  qryQuery.SQL.Add('   INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM          ');
  qryQuery.SQL.Add('   INNER JOIN CADITE ON ITE_CODITE = DET_CODITE                 ');
  qryQuery.SQL.Add('   LEFT  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI                 ');
  qryQuery.SQL.Add(' WHERE                                                          ');
  qryQuery.SQL.Add('   AUX_SEQDOR = :AUTOINCREM                                     ');
  qryQuery.SQL.Add(' ORDER BY                                                       ');
  qryQuery.SQL.Add('   DOCUMENTO, ENTSAI DESC                                       ');
  qryQuery.ParamByName('AUTOINCREM').AsString := strAutoIncremDocumento;

  qryQuery.Open;


  (qryQuery.FieldByName('DET_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  cxgDocumentosDBTBV.ViewData.Expand(True);

  blnTemItemMarmore := fTemItemMamore(strAutoIncremDocumento);
  cxGridCitel1.Visible := blnTemItemMarmore;
  lblAviso.Visible := blnTemItemMarmore;

  If  blnTemItemMarmore then
  Begin
    pCarregaLotesComFaturamento(strAutoIncremDocumento);
    If qryLotesComFaturamento.IsEmpty Then
      pnlLotesFaturados.Visible := False;

  End;

end;

function TfrmConfirmaCancelamentoTAsVinculadas.fTemItemMamore(strAutoIncremDocumento: String): Boolean;
var qryConsulta: TUniQuery;
begin
  If Not fCfgSis('MARMOR', varBoolean) Then
    Exit(False);

  qryConsulta := fCriaQuery;
  Try

    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD  ');
    qryConsulta.SQL.Add(' FROM                                                           ');
    qryConsulta.SQL.Add('   MOVGER                                                       ');
    qryConsulta.SQL.Add('   INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM          ');
    qryConsulta.SQL.Add('   INNER JOIN CADITE ON ITE_CODITE = DET_CODITE                 ');
    qryConsulta.SQL.Add(' WHERE                                                          ');
    qryConsulta.SQL.Add('   MOVGER.AUTOINCREM = :AUTOINCREM     ');
    qryConsulta.SQL.Add('    AND ITE_GRAMAR = "S"                                ');
    qryConsulta.ParamByName('AUTOINCREM').AsString := strAutoIncremDocumento;
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmConfirmaCancelamentoTAsVinculadas.pCarregaLotesComFaturamento(
  strAutoIncremDocumento: String);
begin
  qryLotesComFaturamento.sql.Clear;
  qryLotesComFaturamento.sql.Add('SELECT  CONCAT(ITE_CODITE, "-",ITE_DESITE) AS ITEM, LOT_NUMLOT, CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-",DET_CODEMP) AS DOCUME FROM (');
  qryLotesComFaturamento.sql.Add('   SELECT ITE_CODITE, ITE_DESITE, CADLOT.LOT_NUMLOT, LOT_CODEMP, LOT_CODITE FROM CADLOT');
  qryLotesComFaturamento.sql.Add('      INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE');
  qryLotesComFaturamento.sql.Add('    WHERE TRUE');
  qryLotesComFaturamento.sql.Add('     AND LOT_MARORI= "'+strAutoIncremDocumento+'"');
  qryLotesComFaturamento.sql.Add('       AND CADLOT.LOT_CHAPA_ = "S"');
  qryLotesComFaturamento.sql.Add('  ) LOT');
  qryLotesComFaturamento.sql.Add('  INNER JOIN MOVDET ON DET_NUMLOT = LOT_NUMLOT AND DET_CODEMP = LOT_CODEMP AND DET_CODITE = LOT_CODITE');
  qryLotesComFaturamento.sql.Add('  WHERE DET_CLAFIS NOT IN("5999", "1999")');
  qryLotesComFaturamento.sql.Add('  AND LOCATE(DET_CLAFIS, "'+VS_strClaVen+'") > 0');
  qryLotesComFaturamento.sql.Add('UNION ALL');
  qryLotesComFaturamento.sql.Add('SELECT CONCAT(ITE_CODITE, "-",ITE_DESITE) AS ITEM,  LOT_NUMLOT,CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-",FDO_CODEMP) AS DOCUME  FROM (');
  qryLotesComFaturamento.sql.Add('   SELECT ITE_CODITE, ITE_DESITE, CADLOT.LOT_NUMLOT, LOT_CODEMP, LOT_CODITE FROM CADLOT');
  qryLotesComFaturamento.sql.Add('      INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE');
  qryLotesComFaturamento.sql.Add('    WHERE TRUE');
  qryLotesComFaturamento.sql.Add('     AND LOT_MARORI= "'+strAutoIncremDocumento+'"');
  qryLotesComFaturamento.sql.Add('       AND CADLOT.LOT_CHAPA_ = "S"');
  qryLotesComFaturamento.sql.Add('  ) LOT');
  qryLotesComFaturamento.sql.Add('  INNER JOIN FATDOR ON FDO_NUMLOT = LOT_NUMLOT AND FDO_CODEMP = LOT_CODEMP AND FDO_CODITE = LOT_CODITE');
  qryLotesComFaturamento.sql.Add('  WHERE FDO_CLAFIS NOT IN("5999", "1999")');
  qryLotesComFaturamento.sql.Add('  AND LOCATE(FDO_CLAFIS, "'+VS_strClaVen+'") > 0');
  qryLotesComFaturamento.Open;
  dtsFaturamentos.DataSet := qryLotesComFaturamento;
End;

end.
