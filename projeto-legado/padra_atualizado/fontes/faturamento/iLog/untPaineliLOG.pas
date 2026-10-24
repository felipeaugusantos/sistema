unit untPaineliLOG;

interface
{$WARN SYMBOL_DEPRECATED OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxContainer, cxSpinEdit, cxTextEdit, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, System.ImageList, Vcl.ImgList, cxImageList,
  cxEditRepositoryItems, dxBar, dxBarExtItems, cxBarEditItem, cxClasses,
  cxLabel, cxMemo, cxGridLevel, cxGridCustomView, cxGrid, Uni, cxButtonEdit;

Type
  TfrmPaineliLOG = class(TForm)
    pnlCentral: TPanel;
    dbgDocumentosView: TcxGridDBTableView;
    dbgDocumentosLevel1: TcxGridLevel;
    dbgDocumentos: TcxGrid;
    dxBarManager1: TdxBarManager;
    dxBarGroup1: TdxBarGroup;
    mnuBarraPrincipal: TdxBar;
    btnReenviar: TdxBarLargeButton;
    btnSair: TdxBarLargeButton;
    btnAtualizar: TdxBarLargeButton;
    mnuBarraConfig: TdxBar;
    dxBarStatic1: TdxBarStatic;
    edtQtdUltNot: TcxBarEditItem;
    edtRefresh: TcxBarEditItem;
    dxBarStatic3: TdxBarStatic;
    dxBarStatic2: TdxBarStatic;
    dtsRomaneios: TDataSource;
    cxEditRepository1: TcxEditRepository;
    imgImagens: TcxImageList;
    cmbStatusDesc: TcxEditRepositoryImageComboBoxItem;
    tmrAtualizar: TTimer;
    mnuStatus: TdxBar;
    dxBarStatic4: TdxBarStatic;
    btnConfigurar: TdxBarLargeButton;
    btnAjustarMotivo: TdxBarLargeButton;
    cmbStatusImg: TcxEditRepositoryImageComboBoxItem;
    btnAjustarConsumidor: TdxBarLargeButton;
    btnAlterarNCM: TdxBarLargeButton;
    btnStatusSefaz: TdxBarLargeButton;
    dxBarEdit1: TdxBarEdit;
    cxBarEditItem2: TcxBarEditItem;
    dxBarStatic5: TdxBarStatic;
    pnlRodape: TPanel;
    dxBarSubItem1: TdxBarSubItem;
    mnuReimpressao: TdxBarButton;
    edtQtdDiasNfAut: TdxBarSpinEdit;
    dxBarStatic6: TdxBarStatic;
    btnAlterarEReenviar: TdxBarButton;
    edtTamLote: TdxBarSpinEdit;
    dxBarButton2: TdxBarButton;
    cxLabel1: TcxLabel;
    btnReimpressao: TdxBarLargeButton;
    dxBarButton1: TdxBarButton;
    Panel1: TPanel;
    memMsg: TcxMemo;
    memTarefas: TcxMemo;
    dbgDocumentosViewNUMROM: TcxGridDBColumn;
    dbgDocumentosViewEMPROM: TcxGridDBColumn;
    dbgDocumentosViewDTAENT: TcxGridDBColumn;
    dbgDocumentosViewHORENT: TcxGridDBColumn;
    dbgDocumentosViewQTDE_DOC: TcxGridDBColumn;
    dbgDocumentosViewMOTORISTA: TcxGridDBColumn;
    dbgDocumentosViewGER_PLAVEI: TcxGridDBColumn;
    dbgDocumentosViewVEI_DESVEI: TcxGridDBColumn;
    dbgDocumentosViewSTATUS: TcxGridDBColumn;
    dbgDocumentosViewQTD_ENTREG: TcxGridDBColumn;
    dbgDocumentosViewDETALHES: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtRefreshChange(Sender: TObject);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQtdUltNotExit(Sender: TObject);
    procedure edtQtdDiasNfAutExit(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbgDocumentosViewDETALHESPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    FqryRomaneios: TUniQuery;

    procedure InicializaPainel;
    procedure AtualizaGrid(const AFocar: Boolean);
    procedure AtualizarRomaneios;
    function RetornaDataDeCorte: TDateTime;

    procedure qryRomaneiosAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untDocsRomaneioiLog;

{ TfrmPaineliLOG }

procedure TfrmPaineliLOG.AtualizaGrid(const AFocar: Boolean);
begin
  Try
    tmrAtualizar.Enabled := False;

    Try
      dtsRomaneios.DataSet := nil;
    Except
    End;

    FqryRomaneios.AfterScroll := nil;

    Try
      AtualizarRomaneios;
    Except
      Sleep(3000);
      AtualizarRomaneios;
    End;

  Finally
    Try
      dtsRomaneios.DataSet := FqryRomaneios;
    Except
    End;

    FqryRomaneios.AfterScroll := qryRomaneiosAfterScroll;
    qryRomaneiosAfterScroll(FqryRomaneios);

    If AFocar Then
      pSetFocus(dbgDocumentos);

    tmrAtualizar.Enabled := True;
  End;
end;

procedure TfrmPaineliLOG.AtualizarRomaneios;
begin
  FqryRomaneios.Close;
  FqryRomaneios.ParamByName('DataLimite').AsDateTime := RetornaDataDeCorte;
  FqryRomaneios.ParamByName('Limite').AsInteger      := edtQtdUltNot.EditValue;
  FqryRomaneios.ParamByName('EMPROM').AsString       := VS_strCodEmp;
  FqryRomaneios.Open;
end;

procedure TfrmPaineliLOG.btnAtualizarClick(Sender: TObject);
begin
  AtualizaGrid(True);
end;

procedure TfrmPaineliLOG.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPaineliLOG.dbgDocumentosViewDETALHESPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmDocsRomaneioiLog: TfrmDocsRomaneioiLog;
begin
  pCriarFormularios(TfrmDocsRomaneioiLog, frmDocsRomaneioiLog);
  try
    frmDocsRomaneioiLog.NumRom := FqryRomaneios.FieldByName('ILO_NUMROM').AsString;
    frmDocsRomaneioiLog.ShowModal;
  finally
    pFreeAndNil(frmDocsRomaneioiLog);
  end;
end;

procedure TfrmPaineliLOG.edtQtdDiasNfAutExit(Sender: TObject);
begin
  AtualizaGrid(False);
end;

procedure TfrmPaineliLOG.edtQtdUltNotExit(Sender: TObject);
begin
  AtualizaGrid(False);
end;

procedure TfrmPaineliLOG.edtRefreshChange(Sender: TObject);
begin
  tmrAtualizar.Enabled  := False;
  tmrAtualizar.Interval := edtRefresh.EditValue * 1000;
  tmrAtualizar.Enabled  := True;

//  pAtuCfgSisPainel('TMPREF', '', edtRefresh.EditValue);
end;

procedure TfrmPaineliLOG.FormCreate(Sender: TObject);
begin
  FqryRomaneios := fCriaQuery;
  dtsRomaneios.DataSet := FqryRomaneios;
  FqryRomaneios.AfterScroll := qryRomaneiosAfterScroll;
end;

procedure TfrmPaineliLOG.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FqryRomaneios);
end;

procedure TfrmPaineliLOG.FormShow(Sender: TObject);
begin
  InicializaPainel;
end;

procedure TfrmPaineliLOG.InicializaPainel;
begin
  FqryRomaneios.SQL.Add('SELECT');
  FqryRomaneios.SQL.Add('   ILO_NUMROM, ILO_EMPROM, ILO_DTAENT, ILO_HORENT,');
  FqryRomaneios.SQL.Add('   COUNT(*) AS QTDE_DOC, GER_PLAVEI, VEI_DESVEI, ');
  FqryRomaneios.SQL.Add('   CONCAT(GER_CODMOT, " - ", MOT_NOMMOT) AS MOTORISTA,');
  FqryRomaneios.SQL.Add('   ILO_STATUS,');
  FqryRomaneios.SQL.Add('   CASE ILO_STATUS');
  FqryRomaneios.SQL.Add('     WHEN "A" THEN "Aguardando integração"');
  FqryRomaneios.SQL.Add('     WHEN "I" THEN "Integrado"');
  FqryRomaneios.SQL.Add('     WHEN "E" THEN "Erro"');
  FqryRomaneios.SQL.Add('   END AS STATUS,');
  FqryRomaneios.SQL.Add('   CONCAT(');
  FqryRomaneios.SQL.Add('     (SELECT COUNT(*)');
  FqryRomaneios.SQL.Add('      FROM ILOGDET');
  FqryRomaneios.SQL.Add('      WHERE DET_NUMROM = ILO_NUMROM AND');
  FqryRomaneios.SQL.Add('        DET_EMPROM = ILO_EMPROM AND');
  FqryRomaneios.SQL.Add('        DET_STATUS = "E"');
  FqryRomaneios.SQL.Add('     ),');
  FqryRomaneios.SQL.Add('     "/",');
  FqryRomaneios.SQL.Add('     COUNT(*)');
  FqryRomaneios.SQL.Add('   ) as QTD_ENTREG');

  FqryRomaneios.SQL.Add(' FROM ROMILOG');

  FqryRomaneios.SQL.Add(' LEFT JOIN ROMGERX ON');
  FqryRomaneios.SQL.Add('   ILO_NUMROM = GER_NUMROM AND');
  FqryRomaneios.SQL.Add('   ILO_EMPROM = GER_EMPROM');

  FqryRomaneios.SQL.Add(' LEFT JOIN CADMOT ON GER_CODMOT = MOT_CODMOT');

  FqryRomaneios.SQL.Add(' LEFT JOIN CADVEI ON GER_PLAVEI = VEI_PLAVEI');

  FqryRomaneios.SQL.Add('WHERE ILO_DTAENT >= :DataLimite');
  FqryRomaneios.SQL.Add('  AND ILO_EMPROM = :EMPROM');

  FqryRomaneios.SQL.Add('GROUP BY ILO_NUMROM, ILO_EMPROM');

  FqryRomaneios.SQL.Add('ORDER BY ILO_DTAENT DESC, ILO_HORENT DESC');

  FqryRomaneios.SQL.Add('  LIMIT :Limite ');

  tmrAtualizar.Interval := edtRefresh.EditValue * 1000;
  AtualizaGrid(True);
end;

procedure TfrmPaineliLOG.qryRomaneiosAfterScroll(DataSet: TDataSet);
var
  LQry: TUniQuery;
begin
  If (Not DataSet.Active) then
    Exit;

  if (DataSet.IsEmpty) then
    Exit;

  if (DataSet.ControlsDisabled) Then
    Exit;

  memMsg.Lines.Clear;

  If DataSet.FieldByName('ILO_STATUS').AsString = 'E' Then
  Begin
    LQry := fCriaQuery;
    try
      LQry.SQL.Add('SELECT ERR_MENSAG');
      LQry.SQL.Add('FROM ILOGERR');
      LQry.SQL.Add('WHERE ERR_NUMROM = :NUMROM');
      LQry.SQL.Add('  AND ERR_EMPROM = :EMPROM');
      LQry.SQL.Add('ORDER BY ERR_DTAENT DESC, ERR_HORENT DESC');
      LQry.SQL.Add('LIMIT 1');

      LQry.ParamByName('NUMROM').AsString := DataSet.FieldByName('ILO_NUMROM').AsString;
      LQry.ParamByName('EMPROM').AsString := DataSet.FieldByName('ILO_EMPROM').AsString;
      LQry.Open;

      memMsg.Lines.Add(LQry.FieldByName('ERR_MENSAG').AsString);
    finally
      FreeAndNil(LQry);
    end;
  End;
end;

procedure TfrmPaineliLOG.tmrAtualizarTimer(Sender: TObject);
begin
  If Self.WindowState <> wsMinimized Then
    AtualizaGrid(False);
end;

function TfrmPaineliLOG.RetornaDataDeCorte: TDateTime;
begin
  Result := Date - edtQtdDiasNfAut.Value;
end;


end.
