unit untCadEnqVsPeriodoApuracaoCat42;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, DateEditFocus, Vcl.Mask,
  MaskEditFocus, Uni, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, MemDS, DBAccess, Datasnap.DBClient, UniClientDataSet, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet;

type
  TfrmCadEnqVsPeriodoApuracaoCat42 = class(TfrmPai)
    btnEnquadramentoVsPeriodoApuracao: TBitBtn;
    pnlData: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    mskDtaIni: TDateEditFocus;
    mskDtaFin: TDateEditFocus;
    pnlTitulo: TPanel;
    pnlLista: TPanel;
    cdsLista: TUniClientDataSet;
    dtsLista: TDataSource;
    qryLista: TUniQuery;
    dbGrdLista_: TDBGrid;
    cdsListaCFOP: TStringField;
    cdsListaCST: TStringField;
    pnlInformacao: TPanel;
    pgInformacao: TProgressBar;
    frxReportJ: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    btnImprimir: TBitBtn;
    procedure btnEnquadramentoVsPeriodoApuracaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pValidaDatas;
    procedure pCriaColunaGrid;

    procedure pCarregandoLista(qryAux: TUniQuery; pnlInfo: TPanel;
      pgInfo: TProgressBar);

    function fColetandoDadosSQL(strCodEmp, strDtaIni,
      strDtaFin: string): string;

  public
    { Public declarations }
  end;

var
  frmCadEnqVsPeriodoApuracaoCat42: TfrmCadEnqVsPeriodoApuracaoCat42;

implementation

uses untFuncoes;

{$R *.dfm}

procedure TfrmCadEnqVsPeriodoApuracaoCat42.btnEnquadramentoVsPeriodoApuracaoClick(
  Sender: TObject);
  var
    qryAux: TUniQuery;

begin
  inherited;
  pValidaDatas;

  pnlInformacao.Visible := True;
  pnlInformacao.Caption := 'Coletando Dados ...';
  Application.ProcessMessages;

  qryAux := fCriaQuery(nil);

  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := fColetandoDadosSQL(VS_strCodEmp, mskDtaIni.Text, mskDtaFin.Text);
    qryAux.Open;

    pCarregandoLista(qryAux, pnlInformacao, pgInformacao);

    btnImprimir.Enabled := (qryAux.RecordCount > 0);

  finally
    FreeAndNil(qryAux);
    pnlInformacao.Visible := False;
    pgInformacao.Visible := False;
  end;

end;

procedure TfrmCadEnqVsPeriodoApuracaoCat42.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if (mskDtaIni.Focused) or (mskDtaFin.Focused) then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
  end

end;

procedure TfrmCadEnqVsPeriodoApuracaoCat42.FormShow(Sender: TObject);
begin
  inherited;
  pCriaColunaGrid;
  mskDtaIni.SetFocus;
end;

procedure TfrmCadEnqVsPeriodoApuracaoCat42.btnImprimirClick(Sender: TObject);
  var
    qryAux: TUniQuery;
    strEMP_NOMEMP: string;

begin
  inherited;

  qryAux := fCriaQuery(nil);

  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP';
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    strEMP_NOMEMP := qryAux.FieldByName('EMP_NOMEMP').AsString;

  finally
    FreeAndNil(qryAux);
  end;

  frxReportJ.Script.Variables['NOMEMP'] := strEMP_NOMEMP;
  frxReportJ.Script.Variables['CODEMP'] := 'EMPRESA: ' + VS_strCodEmp;
  frxReportJ.Script.Variables['NOMREL'] := 'RELATÓRIO ENQUADRAMENTO VS PERÍODO DE APURAÇÃO';
  frxReportJ.Script.Variables['PERIODO'] := 'PERIODO: '  + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text));

  frxReportJ.PrintOptions.PrintMode := pmScale;
  frxReportJ.PrintOptions.PrintOnSheet := 9;
  TfrxMemoView(frxReportJ.FindObject('rllZebra')).Color := fCfgSis('CORZEB');

  frxReportJ.ShowReport
end;

function TfrmCadEnqVsPeriodoApuracaoCat42.fColetandoDadosSQL(strCodEmp,
  strDtaIni, strDtaFin: string): string;
  var
    diaI, mesI, anoI, dataI: string;
    diaF, mesF, anoF, dataF: string;

begin
  diaI := Copy(strDtaIni, 1, 2);
  mesI := Copy(strDtaIni, 4, 2);
  anoI := Copy(strDtaIni, 7, 4);
  dataI := anoI + '-' + mesI + '-' + diaI;

  diaF := Copy(strDtaFin, 1, 2);
  mesF := Copy(strDtaFin, 4, 2);
  anoF := Copy(strDtaFin, 7, 4);
  dataF := anoF + '-' + mesF + '-' + diaF;

  Result := '    SET @CODEMP = "'+strCodEmp+'";';
  Result := Result + ' SET @DTAINI = "'+dataI+'";';
  Result := Result + ' SET @DTAFIN = "'+dataF+'";';
  Result := Result + ' SET @SEQUENCIAL = 0; ';

  Result := Result + ' DROP TABLE IF EXISTS CAT_42_TAB1; ';

  Result := Result + ' CREATE TABLE CAT_42_TAB1 ';
  Result := Result + ' SELECT @SEQUENCIAL := RIGHT( CONCAT( "000", @SEQUENCIAL + 1 ), 3 ) AS SEQUENCIAL, ';
  Result := Result + '        CONCAT( SUBSTRING( ENQ_CLAFIS,001,4 ), "_", SUBSTRING( ENQ_CLAFIS,005,4 ), "_", SUBSTRING( ENQ_CLAFIS,009,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,013,4 ), "_", SUBSTRING( ENQ_CLAFIS,017,4 ), "_", SUBSTRING( ENQ_CLAFIS,021,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,025,4 ), "_", SUBSTRING( ENQ_CLAFIS,029,4 ), "_", SUBSTRING( ENQ_CLAFIS,033,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,037,4 ), "_", SUBSTRING( ENQ_CLAFIS,041,4 ), "_", SUBSTRING( ENQ_CLAFIS,045,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,049,4 ), "_", SUBSTRING( ENQ_CLAFIS,053,4 ), "_", SUBSTRING( ENQ_CLAFIS,057,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,061,4 ), "_", SUBSTRING( ENQ_CLAFIS,065,4 ), "_", SUBSTRING( ENQ_CLAFIS,069,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,073,4 ), "_", SUBSTRING( ENQ_CLAFIS,077,4 ), "_", SUBSTRING( ENQ_CLAFIS,081,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,085,4 ), "_", SUBSTRING( ENQ_CLAFIS,089,4 ), "_", SUBSTRING( ENQ_CLAFIS,093,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,097,4 ), "_", SUBSTRING( ENQ_CLAFIS,101,4 ), "_", SUBSTRING( ENQ_CLAFIS,105,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,109,4 ), "_", SUBSTRING( ENQ_CLAFIS,113,4 ), "_", SUBSTRING( ENQ_CLAFIS,117,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,121,4 ), "_", SUBSTRING( ENQ_CLAFIS,125,4 ), "_", SUBSTRING( ENQ_CLAFIS,129,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,133,4 ), "_", SUBSTRING( ENQ_CLAFIS,137,4 ), "_", SUBSTRING( ENQ_CLAFIS,141,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,145,4 ), "_", SUBSTRING( ENQ_CLAFIS,149,4 ), "_", SUBSTRING( ENQ_CLAFIS,153,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,157,4 ), "_", SUBSTRING( ENQ_CLAFIS,161,4 ), "_", SUBSTRING( ENQ_CLAFIS,165,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,169,4 ), "_", SUBSTRING( ENQ_CLAFIS,173,4 ), "_", SUBSTRING( ENQ_CLAFIS,177,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,181,4 ), "_", SUBSTRING( ENQ_CLAFIS,185,4 ), "_", SUBSTRING( ENQ_CLAFIS,189,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,193,4 ), "_", SUBSTRING( ENQ_CLAFIS,197,4 ), "_", SUBSTRING( ENQ_CLAFIS,201,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,205,4 ), "_", SUBSTRING( ENQ_CLAFIS,209,4 ), "_", SUBSTRING( ENQ_CLAFIS,213,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,217,4 ), "_", SUBSTRING( ENQ_CLAFIS,221,4 ), "_", SUBSTRING( ENQ_CLAFIS,225,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,229,4 ), "_", SUBSTRING( ENQ_CLAFIS,233,4 ), "_", SUBSTRING( ENQ_CLAFIS,237,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,241,4 ), "_", SUBSTRING( ENQ_CLAFIS,245,4 ), "_", SUBSTRING( ENQ_CLAFIS,249,4 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CLAFIS,253,4 ), "_", SUBSTRING( ENQ_CLAFIS,257,4 ), "_", SUBSTRING( ENQ_CLAFIS,261,4 ) ) AS ENQ_CLAFIS, ';

  Result := Result + '        CONCAT( SUBSTRING( ENQ_CODFIS,001,2 ), "_", SUBSTRING( ENQ_CODFIS,003,2 ), "_", SUBSTRING( ENQ_CODFIS,005,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,007,2 ), "_", SUBSTRING( ENQ_CODFIS,009,2 ), "_", SUBSTRING( ENQ_CODFIS,011,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,013,2 ), "_", SUBSTRING( ENQ_CODFIS,015,2 ), "_", SUBSTRING( ENQ_CODFIS,017,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,019,2 ), "_", SUBSTRING( ENQ_CODFIS,021,2 ), "_", SUBSTRING( ENQ_CODFIS,023,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,025,2 ), "_", SUBSTRING( ENQ_CODFIS,027,2 ), "_", SUBSTRING( ENQ_CODFIS,029,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,031,2 ), "_", SUBSTRING( ENQ_CODFIS,033,2 ), "_", SUBSTRING( ENQ_CODFIS,035,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,037,2 ), "_", SUBSTRING( ENQ_CODFIS,039,2 ), "_", SUBSTRING( ENQ_CODFIS,041,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,043,2 ), "_", SUBSTRING( ENQ_CODFIS,045,2 ), "_", SUBSTRING( ENQ_CODFIS,047,2 ), "_", ';
  Result := Result + '                SUBSTRING( ENQ_CODFIS,049,2 ), "_", SUBSTRING( ENQ_CODFIS,051,2 ), "_", SUBSTRING( ENQ_CODFIS,053,2 ) ) AS ENQ_CODFIS ';
  Result := Result + ' FROM CADENQ; ';

  Result := Result + ' DROP TABLE IF EXISTS CAT_42_TAB2; ';

  Result := Result + ' CREATE TABLE CAT_42_TAB2 ';
  Result := Result + ' SELECT DET_DTAENT, ';
  Result := Result + '   DET_NUMDOC, ';
  Result := Result + '   DET_ESPDOC, ';
  Result := Result + '   DET_CODEMP, ';
  Result := Result + '   DET_TIP_FC, ';
  Result := Result + '   DET_CODCLI, ';
  Result := Result + '   DET_CODFOR, ';
  Result := Result + '   DET_CLAFIS, ';
  Result := Result + '   DET_CODFIS, ';
  Result := Result + '   DET_CODITE  ';
  Result := Result + ' FROM MOVDET ';
  Result := Result + ' WHERE ';
  Result := Result + ' DET_CODEMP = @CODEMP AND ';
  Result := Result + ' DET_ESPDOC IN ( "NF", "NV", "EL", "IF", "IV" ) AND ';
  Result := Result + ' DET_DTAENT BETWEEN @DTAINI AND @DTAFIN ';
  Result := Result + ' UNION ALL ';
  Result := Result + ' SELECT DET_DTAENT, ';
  Result := Result + '   DET_NUMDOC, ';
  Result := Result + '   DET_ESPDOC, ';
  Result := Result + '   DET_CODEMP, ';
  Result := Result + '   DET_TIP_FC, ';
  Result := Result + '   DET_CODCLI, ';
  Result := Result + '   DET_CODFOR, ';
  Result := Result + '   DET_CLAFIS, ';
  Result := Result + '   DET_CODFIS, ';
  Result := Result + '   DET_CODITE ';
  Result := Result + ' FROM NOTDET ';
  Result := Result + ' WHERE ';
  Result := Result + ' DET_CODEMP = @CODEMP AND ';
  Result := Result + ' DET_ESPDOC IN ( "NF", "NV", "EL", "IF", "IV" ) AND ';
  Result := Result + ' DET_DTAENT BETWEEN @DTAINI AND @DTAFIN; ';

  Result := Result + ' DROP TABLE IF EXISTS CAT_42_TAB3; ';

  Result := Result + ' CREATE TABLE CAT_42_TAB3 ';
  Result := Result + ' SELECT A.*, ';
  Result := Result + '        ( SELECT GROUP_CONCAT( SEQUENCIAL ) FROM CAT_42_TAB1 WHERE LOCATE(        A.DET_CLAFIS     , ENQ_CLAFIS ) > 0 ) AS CLAFIS, ';
  Result := Result + '        ( SELECT GROUP_CONCAT( SEQUENCIAL ) FROM CAT_42_TAB1 WHERE LOCATE( RIGHT( A.DET_CODFIS, 2 ), ENQ_CODFIS ) > 0 ) AS CODFIS ';
  Result := Result + ' FROM CAT_42_TAB2 A ';
  Result := Result + ' HAVING ';
  Result := Result + '     CLAFIS IS NULL                                      OR ';
  Result := Result + '   ( LOCATE( SUBSTRING( CLAFIS, 001, 003 ), CODFIS ) = 0 AND ';
  Result := Result + '     LOCATE( SUBSTRING( CLAFIS, 004, 003 ), CODFIS ) = 0 AND ';
  Result := Result + '     LOCATE( SUBSTRING( CLAFIS, 007, 003 ), CODFIS ) = 0 AND ';
  Result := Result + '     LOCATE( SUBSTRING( CLAFIS, 010, 003 ), CODFIS ) = 0 AND ';
  Result := Result + '     LOCATE( SUBSTRING( CLAFIS, 013, 003 ), CODFIS ) = 0 ); ';

  Result := Result + ' SELECT DISTINCT DET_CLAFIS AS CLAFIS, ';
  Result := Result + '                 RIGHT( DET_CODFIS, 2 ) AS CODFIS ';
  Result := Result + ' FROM CAT_42_TAB3 ';
  Result := Result + ' HAVING ';
  Result := Result + ' ( CLAFIS < 5000 AND CODFIS NOT IN ( "00", "20" ) ) OR ';
  Result := Result + '   CLAFIS > 5000 ';
  Result := Result + ' ORDER BY DET_CLAFIS, RIGHT( DET_CODFIS, 2 ); ';

end;

procedure TfrmCadEnqVsPeriodoApuracaoCat42.pCarregandoLista(qryAux: TUniQuery;
  pnlInfo: TPanel; pgInfo: TProgressBar);
begin
  qryLista.Connection := fRetConexao;
  dtsLista.DataSet := cdsLista;
  dbGrdLista_.DataSource := dtsLista;

  cdsLista.Close;
  cdsLista.CreateDataSet;
  cdsLista.Open;

  pnlInfo.Visible := True;
  pnlInfo.Caption := 'Carregando Dados ...';
  Application.ProcessMessages;

  pgInfo.Position := 0;
  pgInfo.Max := qryAux.RecordCount;
  pgInfo.Visible := True;

  qryAux.First;
  while not qryAux.Eof do
  begin
    cdsLista.Append;
    cdsLista.FieldByName('CFOP').AsString := qryAux.FieldByName('CLAFIS').AsString;
    cdsLista.FieldByName('CST').AsString := qryAux.FieldByName('CODFIS').AsString;
    cdsLista.Post;

    pgInfo.Position := pgInfo.Position + 1;
    Application.ProcessMessages;

    qryAux.Next;
  end;

  cdsLista.First;

end;

procedure TfrmCadEnqVsPeriodoApuracaoCat42.pCriaColunaGrid;
begin
  with cdsLista do
  begin

    with FieldDefs.AddFieldDef do
    begin
      DataType := ftString;
      Name := 'CFOP';
      Size := 10;
    end;

    with FieldDefs.AddFieldDef do
    begin
      DataType := ftString;
      Name := 'CST';
      Size := 6;
    end;
  end;

end;

procedure TfrmCadEnqVsPeriodoApuracaoCat42.pValidaDatas;
begin
  if (Not fValidaDatas(mskDtaIni.Text)) then
  begin
    MessageBox(0, 'A data não é válida', 'Data Inválida.', MB_ICONWARNING);
    pSetFocus(mskDtaIni);
    Abort;
  end;

  if (Not fValidaDatas(mskDtaFin.Text)) then
  begin
    MessageBox(0, 'A data não é válida', 'Data Inválida.', MB_ICONWARNING);
    pSetFocus(mskDtaFin);
    Abort;
  end;

  if mskDtaFin.Date < mskDtaIni.Date then
  begin
    MessageBox(0, 'A data Final menor que data Inicial.', 'Datas Inválidas', MB_ICONWARNING);
    pSetFocus(mskDtaFin);
    Abort;
  end;

end;

end.
