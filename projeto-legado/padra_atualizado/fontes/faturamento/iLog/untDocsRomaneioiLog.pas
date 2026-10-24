unit untDocsRomaneioiLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxImageComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Uni;

type
  TfrmDocsRomaneioiLog = class(TfrmPai)
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgDocumentosGER_DTAROM: TcxGridDBColumn;
    cxgDocumentosGER_HORROM: TcxGridDBColumn;
    cxgDocumentosGER_DTAENT: TcxGridDBColumn;
    cxgDocumentosGER_NUMDOC: TcxGridDBColumn;
    cxgDocumentosGER_CODEMP: TcxGridDBColumn;
    cxgDocumentosGER_NOMCLI: TcxGridDBColumn;
    cxgDocumentosCID_NOMCID: TcxGridDBColumn;
    cxgDocumentosGER_CODVEN: TcxGridDBColumn;
    cxgDocumentosTRA_NOMTRA: TcxGridDBColumn;
    cxgDocumentosGER_VLRCON: TcxGridDBColumn;
    cxgDocumentosLevel: TcxGridLevel;
    dtsDocumentos: TDataSource;
    cxgDocumentosSTATUS: TcxGridDBColumn;
    cxgDocumentosDET_DTAOCO: TcxGridDBColumn;
    cxgDocumentosDET_HOROCO: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FqryDocumentos: TUniQuery;
    FNumRom: string;
    procedure pCarregaDocumentos;
    { Private declarations }
  public
    { Public declarations }
    property NumRom: string read FNumRom write FNumRom;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmDocsRomaneioiLog.FormCreate(Sender: TObject);
begin
  inherited;
  FqryDocumentos := fCriaQuery;
  dtsDocumentos.DataSet := FqryDocumentos;
end;

procedure TfrmDocsRomaneioiLog.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FqryDocumentos);
end;

procedure TfrmDocsRomaneioiLog.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos;
end;

procedure TfrmDocsRomaneioiLog.pCarregaDocumentos;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_STATUS, ';
  strSQL := strSQL + '  CASE DET_STATUS';
  strSQL := strSQL + '    WHEN "D" THEN "Devolvido"';
  strSQL := strSQL + '    WHEN "I" THEN "Integrado"';
  strSQL := strSQL + '    WHEN "E" THEN "Entregue"';
  strSQL := strSQL + '  END AS STATUS,';
  strSQL := strSQL + '  DET_DTAOCO,';
  strSQL := strSQL + '  DET_HOROCO,';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_EMPROM, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_DTAROM, ';
  strSQL := strSQL + '  DATE_FORMAT(GER_HORROM, "%H:%i") AS GER_HORROM, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  "N" DESTACAR, ';
  strSQL := strSQL + '  GER_KMINI, ';
  strSQL := strSQL + '  GER_KMFIM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ILOGDET';
  strSQL := strSQL + '  INNER JOIN ROMGERX R ON DET_NUMROM = GER_NUMROM AND ';
  strSQL := strSQL + '                          DET_EMPROM = GER_EMPROM AND ';
  strSQL := strSQL + '                          DET_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '                          DET_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '                          DET_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '                          DET_CODCLI = GER_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  DET_EMPROM = :EMPROM ';

  FqryDocumentos.Close;
  FqryDocumentos.SQL.Clear;
  FqryDocumentos.SQL.Add(strSQL);
  FqryDocumentos.ParamByName('NUMROM').AsString := FNumRom;
  FqryDocumentos.ParamByName('EMPROM').AsString := VS_strCodEmp;
  FqryDocumentos.Open;
  cxgDocumentosTableView.ApplyBestFit();
end;

end.
