unit untConfigFluxoOrdemServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxColorComboBox, cxSpinEdit, cxVGrid, cxInplaceContainer,
  Vcl.Samples.Spin, Vcl.Samples.Gauges, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ComCtrls,
  untFatManConsertoFluxoProcesso, untCfgColFlx, Datasnap.DBClient,
  UniClientDataSet, untcxGridDBBandedColumnHelper, cxImageComboBox,
  cxGridBandedTableView, cxGridDBBandedTableView, cxEditRepositoryItems,
  System.ImageList, Vcl.ImgList, cxTextEdit, cxLabel, strUtils;

type
  TfrmConfigFluxoOrdemServico = class(TfrmPai)
    pnlCfgFlx: TPanel;
    pgcCfgFlx: TPageControl;
    tbsColunas: TTabSheet;
    pnlGrdCol: TPanel;
    cxgGrupos: TcxGridCitel;
    cxgGruposTableView1: TcxGridDBTableViewCitel;
    cxgGruposTableView1EXIBIR: TcxGridDBColumn;
    cxgGruposTableView1COLCAP: TcxGridDBColumn;
    cxgGruposTableView1ORDCAM: TcxGridDBColumn;
    cxgGruposTableView1COLNAM: TcxGridDBColumn;
    cxgGruposLevel1: TcxGridLevel;
    pnlCfgCol: TPanel;
    btnUpCol: TSpeedButton;
    btnDownCol: TSpeedButton;
    btnMarCol: TBitBtnLocked;
    btnDesCol: TBitBtnLocked;
    pnlGrdFlx: TPanel;
    dtsVisFlx: TDataSource;
    cdsColFlx: TUniClientDataSet;
    cdsColFlxEXIBIR: TStringField;
    cdsColFlxCOLCAP: TStringField;
    cdsColFlxCOLNAM: TStringField;
    cdsColFlxORDCAM: TIntegerField;
    cdsColFlxCOLTAM: TIntegerField;
    dtsCfgCol: TDataSource;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    cxColunas: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cdsGrpFlx: TUniClientDataSet;
    StringField1: TStringField;
    cdsGrpFlxGRPCAP: TStringField;
    cdsGrpFlxGRPORD: TIntegerField;
    dtsCfgBand: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    dbgVisFlx: TcxGridCitel;
    dbgVisFlxDBView: TcxGridDBBandedTableView;
    dbgVisFlxDBViewColumn1: TcxGridDBBandedColumn;
    dbgVisFlxLVL: TcxGridLevel;
    imgCombo: TImageList;
    cxEditRepository: TcxEditRepository;
    cxEditRepositoryButtonVisibleCenter: TcxEditRepositoryButtonItem;
    cxEditRepositoryTextItem: TcxEditRepositoryTextItem;
    cxEditRepositoryButtonVisibleConsultar: TcxEditRepositoryButtonItem;
    cxEditRepositoryButtonVisibleRealizar: TcxEditRepositoryButtonItem;
    cxEditRepositoryImageComboBoxItem: TcxEditRepositoryImageComboBoxItem;
    Panel1: TPanel;
    btnUpGrp: TSpeedButton;
    btnDowGrp: TSpeedButton;
    btnDesGrp: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    cdsColFlxCOLGRP: TStringField;
    procedure btnDesColClick(Sender: TObject);
    procedure btnMarColClick(Sender: TObject);
    procedure btnUpColClick(Sender: TObject);
    procedure btnDownColClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
    procedure cdsGrpFlxAfterScroll(DataSet: TDataSet);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure btnDesGrpClick(Sender: TObject);
    procedure cxgGruposTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
    procedure btnDowGrpClick(Sender: TObject);
    procedure btnUpGrpClick(Sender: TObject);
    procedure dbgVisFlxDBViewBandPosChanged(Sender: TcxGridBandedTableView;
      ABand: TcxGridBand);
  private
    { Private declarations }
    FblnFecharForm       : Boolean;
    FblnFinalizouFormShow: Boolean;
    procedure pIniciarDados;
    procedure pVisibilidadeGrupo;
    procedure pVisibilidadeColuna;
    procedure pAdicionarBandExibicaoEOrdem(ArecBandFlx: TrecBandFlx);
    procedure pAdicionarColunaExibicaoEOrdem(ArecColFlx: TrecColFlx);
    procedure pAdicionarBandPreVisualizacao(ArecBandFlx: TrecBandFlx);
    procedure pAdicionarColunaPreVisualizacao(AintIndex: Integer; ArecColFlx: TrecColFlx);
    procedure pAlteraOrdemGrupo(AblnSobe: Boolean);
    procedure pAlteraOrdemColuna(AblnSobe: Boolean);
    procedure pIndexarGrupoVisiveis;
    procedure pIndexarColunasVisiveis;
    procedure pMarcarGrupoExibicao(AblnMarcar: Boolean);
    procedure pMarcarColunasExibicao(AblnMarcar: Boolean);
    procedure pAjustaGruposDeExibicao;
    procedure pAjustaColunasDeExibicao;
  public
    { Public declarations }
    blnConfirma                   : Boolean;
    frmFatManConsertoFluxoProcesso: TfrmFatManConsertoFluxoProcesso;
  end;

const
  FstrColunas: Array [0..6] of string = ('CONSULTA_OS', 'EDITAR_OS', 'IMP', 'ETI', 'TRESP', 'TDEV', 'ORDEXE');

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

{ TfrmConfigFluxoOrdemServico }

procedure TfrmConfigFluxoOrdemServico.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  pMarcarGrupoExibicao(True);
  pAjustaGruposDeExibicao;
end;

procedure TfrmConfigFluxoOrdemServico.btnDesColClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigFluxoOrdemServico.btnDesGrpClick(Sender: TObject);
begin
  inherited;
  pMarcarGrupoExibicao(False);
  pAjustaGruposDeExibicao;
end;

procedure TfrmConfigFluxoOrdemServico.btnDowGrpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemGrupo(False);
  pIndexarGrupoVisiveis;
end;

procedure TfrmConfigFluxoOrdemServico.btnDownColClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigFluxoOrdemServico.btnGravarClick(Sender: TObject);
var
  LarrBand: TArrayOfBandFlx;
  LarrCol : TArrayOfColFlx;
begin
  inherited;

  TCfgColFlx.pSalvarEstado(dbgVisFlxDBView, LarrBand, LarrCol);
  TCfgColFlx.pGravarDadosNoBanco(LarrBand, LarrCol);
  blnConfirma := True;
end;

procedure TfrmConfigFluxoOrdemServico.btnMarColClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigFluxoOrdemServico.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColFlx.pSetarPadrao(dbgVisFlxDBView);
  pAjustaGruposDeExibicao;
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigFluxoOrdemServico.btnUpColClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigFluxoOrdemServico.btnUpGrpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemGrupo(True);
  pIndexarGrupoVisiveis;
end;

procedure TfrmConfigFluxoOrdemServico.cdsGrpFlxAfterScroll(DataSet: TDataSet);
begin
  inherited;

  cdsColFlx.Filtered := False;
  cdsColFlx.Filter := 'COLGRP=' + QuotedStr(cdsGrpFlx.FieldByName('GRPCAP').AsString);
  cdsColFlx.Filtered := True;
end;

procedure TfrmConfigFluxoOrdemServico.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if (cdsColFlx.State = dsEdit) and (cdsColFlx.FieldByName('EXIBIR').AsString = 'N') then
  begin
    if (MatchStr(cdsColFlx.FieldByName('COLNAM').AsString, FstrColunas)) then
    begin
      cdsColFlx.FieldByName('EXIBIR').AsString := 'S';
      fMensagem('ATENÇÃO!', 'Esta coluna não pode ser removida do grid do Fluxo.', ['&OK']);
      Exit;
    end;
  end;

  pVisibilidadeColuna;
end;

procedure TfrmConfigFluxoOrdemServico.cxgGruposTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if (cdsGrpFlx.State = dsEdit) and (cdsGrpFlx.FieldByName('EXIBIR').AsString = 'N') then
  begin
    if (cdsGrpFlx.FieldByName('GRPCAP').AsString = 'Dados da Ordem de Serviço') then
    begin
      cdsGrpFlx.FieldByName('EXIBIR').AsString := 'S';
      fMensagem('ATENÇÃO!', 'Este grupo não pode ser removido do grid do Fluxo.', ['&OK']);
      Exit;
    end;
  end;

  pVisibilidadeGrupo;
end;

procedure TfrmConfigFluxoOrdemServico.dbgVisFlxDBViewBandPosChanged(
  Sender: TcxGridBandedTableView; ABand: TcxGridBand);
begin
  inherited;
  pAjustaGruposDeExibicao;
end;

procedure TfrmConfigFluxoOrdemServico.FormCreate(Sender: TObject);
begin
  inherited;

  FblnFinalizouFormShow := False;
  FblnFecharForm := False;
  blnConfirma := False;
  cdsGrpFlx.CreateDataSet;
  cdsGrpFlx.IndexFieldNames := 'GRPORD';
  cdsColFlx.CreateDataSet;
  cdsColFlx.IndexFieldNames := 'ORDCAM';
  WindowState := wsMaximized;
end;

procedure TfrmConfigFluxoOrdemServico.FormPaint(Sender: TObject);
begin
  inherited;

  if FblnFecharForm then
    Close;
end;

procedure TfrmConfigFluxoOrdemServico.FormShow(Sender: TObject);
var
  objAfterScroll: TDataSetNotifyEvent;
begin
  inherited;

  if (not Assigned(frmFatManConsertoFluxoProcesso)) then
  begin
    fMensagem('ATENÇÃO!', 'A configuração do fluxo deve ser chamada sempre através da tela de fluxo de conserto de equipamentos!', ['&OK']);
    FblnFecharForm := True;
  end
  Else
  begin
    objAfterScroll := frmFatManConsertoFluxoProcesso.cxgFluxoTBV.DataController.DataSet.AfterScroll;
    frmFatManConsertoFluxoProcesso.cxgFluxoTBV.DataController.DataSet.AfterScroll := nil;

    try
      dtsVisFlx.DataSet := frmFatManConsertoFluxoProcesso.cxgFluxoTBV.DataController.DataSet;
      dtsVisFlx.DataSet.EnableControls;
      pIniciarDados;
      FblnFinalizouFormShow := True;
    finally
      frmFatManConsertoFluxoProcesso.cxgFluxoTBV.DataController.DataSet.AfterScroll := objAfterScroll;
    end;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pAdicionarBandExibicaoEOrdem(ArecBandFlx: TrecBandFlx);
begin
  cdsGrpFlx.Insert;
  cdsGrpFlx.FieldByName('EXIBIR').AsString  := IIF(ArecBandFlx.blnVisible, 'S', 'N');
  cdsGrpFlx.FieldByName('GRPORD').AsInteger := ArecBandFlx.intIndex + 1;
  cdsGrpFlx.FieldByName('GRPCAP').AsString  := ArecBandFlx.strCaption;
  cdsGrpFlx.Post;
  cdsGrpFlx.First;
end;

procedure TfrmConfigFluxoOrdemServico.pAdicionarBandPreVisualizacao(ArecBandFlx: TrecBandFlx);
var
  LcxBand: TcxGridBand;
begin
  LcxBand         := dbgVisFlxDBView.Bands.Add;
  LcxBand.Caption := ArecBandFlx.strCaption;
  LcxBand.Visible := ArecBandFlx.blnVisible;
end;

procedure TfrmConfigFluxoOrdemServico.pAdicionarColunaExibicaoEOrdem(ArecColFlx: TrecColFlx);
begin
  cdsColFlx.Insert;
  cdsColFlx.FieldByName('EXIBIR').AsString  := IIF(ArecColFlx.blnVisible, 'S', 'N');
  cdsColFlx.FieldByName('ORDCAM').AsInteger := ArecColFlx.intIndex + 1;
  cdsColFlx.FieldByName('COLCAP').AsString  := ArecColFlx.strCaption;
  cdsColFlx.FieldByName('COLNAM').AsString  := ArecColFlx.strFieldName;
  cdsColFlx.FieldByName('COLGRP').AsString  := ArecColFlx.strBand;
  cdsColFlx.Post;
  cdsColFlx.First;
end;

procedure TfrmConfigFluxoOrdemServico.pAdicionarColunaPreVisualizacao(AintIndex: Integer; ArecColFlx: TrecColFlx);
var
  LcxColumn: TcxGridDBBandedColumn;
begin
  LcxColumn                             := dbgVisFlxDBView.CreateColumn;
  LcxColumn.DataBinding.FieldName       := ArecColFlx.strFieldName;
  LcxColumn.Caption                     := ArecColFlx.strCaption;
  LcxColumn.Width                       := ArecColFlx.intWidth;
  LcxColumn.Visible                     := ArecColFlx.blnVisible;
  LcxColumn.DataBinding.Field.Alignment := ArecColFlx.Alignment;
  LcxColumn.Position.BandIndex          := TcxGridDBBandedColumnHelper.fFindBandByNameView(dbgVisFlxDBView, ArecColFlx.strBand).Index;
  LcxColumn.PropertiesClassName         := ArecColFlx.strClassName;

  if LcxColumn.PropertiesClassName = 'TcxTextEditProperties' then
    LcxColumn.Properties := cxEditRepositoryTextItem.Properties
  else if LcxColumn.PropertiesClassName = 'TcxImageComboBoxProperties' then
  begin
    LcxColumn.Properties := cxEditRepositoryImageComboBoxItem.Properties;
    LcxColumn.Options.ShowEditButtons := isebNever;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pAjustaColunasDeExibicao;
var
  intCnt,
  LRecNo: Integer;
begin
  LRecNo := cdsColFlx.RecNo;
  cdsColFlx.Filtered := False;
  cdsColFlx.DisableControls;

  try
    for intCnt := 0 To Pred(dbgVisFlxDBView.ColumnCount) do
    begin
      if cdsColFlx.Locate('COLNAM', dbgVisFlxDBView.Columns[intCnt].DataBinding.FieldName, []) then
      begin
        cdsColFlx.Edit;
        cdsColFlx.FieldByName('ORDCAM').AsInteger := dbgVisFlxDBView.Columns[intCnt].Position.ColIndex + 1;
        cdsColFlx.FieldByName('EXIBIR').AsString  := IIF(dbgVisFlxDBView.Columns[intCnt].Visible, 'S', 'N');
        cdsColFlx.Post;
      end;
    end;
  finally
    cdsColFlx.EnableControls;
    cdsGrpFlxAfterScroll(cdsGrpFlx);
    cdsColFlx.RecNo := LRecNo;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pAjustaGruposDeExibicao;
var
  intCnt,
  LRecNo: Integer;
begin
  LRecNo := cdsGrpFlx.RecNo;
  cdsGrpFlx.DisableControls;
  cdsGrpFlx.AfterScroll := nil;

  try
    for intCnt := 0 To Pred(dbgVisFlxDBView.Bands.Count) do
    begin
      if cdsGrpFlx.Locate('GRPCAP', dbgVisFlxDBView.Bands[intCnt].Caption, []) then
      begin
        cdsGrpFlx.Edit;
        cdsGrpFlx.FieldByName('GRPORD').AsInteger := intCnt + 1;
        cdsGrpFlx.FieldByName('EXIBIR').AsString  := IIF(dbgVisFlxDBView.Bands[intCnt].Visible, 'S', 'N');
        cdsGrpFlx.Post;
      end;
    end;
  finally
    cdsGrpFlx.EnableControls;
    cdsGrpFlx.AfterScroll := cdsGrpFlxAfterScroll;
    cdsGrpFlx.RecNo := LRecNo;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pAlteraOrdemColuna(AblnSobe: Boolean);
var
  LstrCodAtu: String;
begin
  if cdsColFlx.RecordCount < 2 then
    Exit;

  if (cdsColFlx.FieldByName('ORDCAM').AsInteger = 1) And AblnSobe then
    Exit;

  if (cdsColFlx.FieldByName('ORDCAM').AsInteger = cdsColFlx.RecordCount) And (not AblnSobe) then
    Exit;

  cdsColFlx.DisableControls;
  try
    LstrCodAtu := cdsColFlx.FieldByName('COLNAM').AsString;

    if AblnSobe then
    begin
      cdsColFlx.Prior;
      cdsColFlx.Edit;
      cdsColFlx.FieldByName('ORDCAM').AsInteger := Succ(cdsColFlx.FieldByName('ORDCAM').AsInteger);
      cdsColFlx.Post;

      if cdsColFlx.Locate('COLNAM', LstrCodAtu, []) then
      begin
        cdsColFlx.Edit;
        cdsColFlx.FieldByName('ORDCAM').AsInteger := Pred(cdsColFlx.FieldByName('ORDCAM').AsInteger);
        cdsColFlx.Post;
      end;
    end
    else
    begin
      cdsColFlx.Next;
      cdsColFlx.Edit;
      cdsColFlx.FieldByName('ORDCAM').AsInteger := Pred(cdsColFlx.FieldByName('ORDCAM').AsInteger);
      cdsColFlx.Post;

      if cdsColFlx.Locate('COLNAM', LstrCodAtu, []) then
      begin
        cdsColFlx.Edit;
        cdsColFlx.FieldByName('ORDCAM').AsInteger := Succ(cdsColFlx.FieldByName('ORDCAM').AsInteger);
        cdsColFlx.Post;
      end;
    end;
  finally
    cdsColFlx.EnableControls;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pAlteraOrdemGrupo(AblnSobe: Boolean);
var
  LstrCodAtu: String;
begin
  if cdsGrpFlx.RecordCount < 2 then
    Exit;

  if (cdsGrpFlx.FieldByName('GRPORD').AsInteger = 1) And AblnSobe then
    Exit;

  if (cdsGrpFlx.FieldByName('GRPORD').AsInteger = cdsGrpFlx.RecordCount) And (not AblnSobe) then
    Exit;

  cdsGrpFlx.DisableControls;
  cdsGrpFlx.AfterScroll := nil;

  try
    LstrCodAtu := cdsGrpFlx.FieldByName('GRPCAP').AsString;

    if AblnSobe then
    begin
      cdsGrpFlx.Prior;
      cdsGrpFlx.Edit;
      cdsGrpFlx.FieldByName('GRPORD').AsInteger := Succ(cdsGrpFlx.FieldByName('GRPORD').AsInteger);
      cdsGrpFlx.Post;

      if cdsGrpFlx.Locate('GRPCAP', LstrCodAtu, []) then
      begin
        cdsGrpFlx.Edit;
        cdsGrpFlx.FieldByName('GRPORD').AsInteger := Pred(cdsGrpFlx.FieldByName('GRPORD').AsInteger);
        cdsGrpFlx.Post;
      end;
    end
    else
    begin
      cdsGrpFlx.Next;
      cdsGrpFlx.Edit;
      cdsGrpFlx.FieldByName('GRPORD').AsInteger := Pred(cdsGrpFlx.FieldByName('GRPORD').AsInteger);
      cdsGrpFlx.Post;

      if cdsGrpFlx.Locate('GRPCAP', LstrCodAtu, []) then
      begin
        cdsGrpFlx.Edit;
        cdsGrpFlx.FieldByName('GRPORD').AsInteger := Succ(cdsGrpFlx.FieldByName('GRPORD').AsInteger);
        cdsGrpFlx.Post;
      end;
    end;
  finally
    cdsGrpFlx.EnableControls;
    cdsGrpFlx.AfterScroll := cdsGrpFlxAfterScroll;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pIndexarColunasVisiveis;
var
  LcxColumn : TcxGridDBBandedColumn;
  intRecNo: Integer;
begin
  cdsColFlx.DisableControls;
  intRecNo := cdsColFlx.RecNo;

  try
    cdsColFlx.First;

    while not cdsColFlx.Eof do
    begin
      LcxColumn := TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(dbgVisFlxDBView, cdsColFlx.FieldByName('COLNAM').AsString);

      if (LcxColumn <> Nil) then
        LcxColumn.Position.ColIndex := cdsColFlx.FieldByName('ORDCAM').AsInteger - 1;

      cdsColFlx.Next;
    end;

    cdsColFlx.First;
  finally
    cdsColFlx.RecNo := intRecNo;
    cdsColFlx.EnableControls;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pIndexarGrupoVisiveis;
var
  LcxBand : TcxGridBand;
  intRecNo: Integer;
begin
  cdsGrpFlx.DisableControls;
  intRecNo := cdsGrpFlx.RecNo;

  try
    cdsGrpFlx.First;

    while not cdsGrpFlx.Eof do
    begin
      LcxBand := TcxGridDBBandedColumnHelper.fFindBandByNameView(dbgVisFlxDBView, cdsGrpFlx.FieldByName('GRPCAP').AsString);

      if (LcxBand <> Nil) then
        LcxBand.Position.ColIndex := cdsGrpFlx.FieldByName('GRPORD').AsInteger - 1;

      cdsGrpFlx.Next;
    end;

    cdsGrpFlx.First;
  finally
    cdsGrpFlx.RecNo := intRecNo;
    cdsGrpFlx.EnableControls;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pIniciarDados;
var
  intCnt     : Integer;
  LrecBandFlx: TrecBandFlx;
  LrecColFlx : TrecColFlx;
begin
  dtsVisFlx.DataSet.DisableControls;
  cdsGrpFlx.AfterScroll := nil;

  try
    for intCnt := Low(TCfgColFlx.arrBandsOri) To High(TCfgColFlx.arrBandsOri) do
    begin
      LrecBandFlx := TCfgColFlx.arrBandsOri[intCnt];
      pAdicionarBandExibicaoEOrdem(LrecBandFlx);
      pAdicionarBandPreVisualizacao(LrecBandFlx);
    end;

    for intCnt := Low(TCfgColFlx.arrColsOri) To High(TCfgColFlx.arrColsOri) do
    begin
      LrecColFlx := TCfgColFlx.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdem(LrecColFlx);
      pAdicionarColunaPreVisualizacao(intCnt, LrecColFlx);
    end;

    TCfgColFlx.pSetarUltimosDadosCarregados(dbgVisFlxDBView);
    pAjustaGruposDeExibicao;
    pAjustaColunasDeExibicao;
    cdsColFlx.First;
  finally
    dtsVisFlx.DataSet.EnableControls;
    cdsGrpFlx.AfterScroll := cdsGrpFlxAfterScroll;
    cdsGrpFlxAfterScroll(cdsGrpFlx);
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pMarcarColunasExibicao(AblnMarcar: Boolean);
var
  LRecNo: Integer;
begin
  LRecNo := cdsColFlx.RecNo;
  cdsColFlx.DisableControls;

  try
    cdsColFlx.First;

    while not cdsColFlx.Eof do
    begin
      cdsColFlx.Edit;

      if AblnMarcar then
        cdsColFlx.FieldByName('EXIBIR').AsString :=  'S'
      else if (not MatchStr(cdsColFlx.FieldByName('COLNAM').AsString, FstrColunas)) then
        cdsColFlx.FieldByName('EXIBIR').AsString :=  'N';

      cdsColFlx.Post;

      pVisibilidadeColuna;

      cdsColFlx.Next;
    end;

    cdsColFlx.First;
  finally
    cdsColFlx.EnableControls;
    cdsColFlx.RecNo := LRecNo;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pMarcarGrupoExibicao(AblnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsGrpFlx.DisableControls;
  intRecNo := cdsGrpFlx.RecNo;
  cdsGrpFlx.AfterScroll := nil;

  try
    cdsGrpFlx.First;

    while not cdsGrpFlx.Eof do
    begin
      cdsGrpFlx.Edit;

      if AblnMarcar then
        cdsGrpFlx.FieldByName('EXIBIR').AsString :=  'S'
      else if (cdsGrpFlx.FieldByName('GRPCAP').AsString <> 'Dados da Ordem de Serviço') then
        cdsGrpFlx.FieldByName('EXIBIR').AsString :=  'N';

      cdsGrpFlx.Post;

      pVisibilidadeGrupo;

      cdsGrpFlx.Next;
    end;

    cdsGrpFlx.First;
  finally
    cdsGrpFlx.RecNo := intRecNo;
    cdsGrpFlx.EnableControls;
    cdsGrpFlx.AfterScroll := cdsGrpFlxAfterScroll;
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pVisibilidadeColuna;
var
  LcxColumn: TcxGridDBBandedColumn;
begin
  inherited;

  if (not fEmptyStr(cdsColFlx.FieldByName('COLNAM').AsString)) then
  begin
    LcxColumn := TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(dbgVisFlxDBView, cdsColFlx.FieldByName('COLNAM').AsString);

    if (LcxColumn <> Nil) then
      LcxColumn.Visible := (cdsColFlx.FieldByName('EXIBIR').AsString = 'S');
  end;
end;

procedure TfrmConfigFluxoOrdemServico.pVisibilidadeGrupo;
var
  LcxBand: TcxGridBand;
begin
  inherited;

  if (not fEmptyStr(cdsGrpFlx.FieldByName('GRPCAP').AsString)) then
  begin
    LcxBand := TcxGridDBBandedColumnHelper.fFindBandByNameView(dbgVisFlxDBView, cdsGrpFlx.FieldByName('GRPCAP').AsString);

    if (LcxBand <> Nil) then
      LcxBand.Visible := (cdsGrpFlx.FieldByName('EXIBIR').AsString = 'S');
  end;
end;

end.
