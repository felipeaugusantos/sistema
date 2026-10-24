unit untFatMostraItensFechamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, untConstantes,
  ExtCtrls, untFuncoesSimples, DB, BitBtnLockedIncrem, Grids, Math, untGravando,
  DBGrids, untFuncFat, UniClientDataSet, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, untFuncFatTypes, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, cxGridBandedTableView,
  cxGridDBBandedTableView, Datasnap.DBClient, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatMostraItensFechamento = class(TfrmPai)
    pnlDados: TPanel;
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGrid;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensSIGUNI: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensUNITAR: TFloatField;
    cdsItensTOTITE: TFloatField;
    cdsItensBASICM: TFloatField;
    cdsItensALQICM: TFloatField;
    cdsItensDESESP: TFloatField;
    cdsItensVALFRE: TFloatField;
    cdsItensDESACE: TFloatField;
    cdsItensBASIPI: TFloatField;
    cdsItensALQIPI: TFloatField;
    cdsItensVALIPI: TFloatField;
    cdsItensVALICM: TFloatField;
    cdsItensBASRET: TFloatField;
    cdsItensVALRET: TFloatField;
    cdsItensVLRCON: TFloatField;
    dtsItens: TDataSource;
    cdsItensCODFIS: TStringField;
    cdsItensCLAFIS: TStringField;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensViewCODITE: TcxGridDBBandedColumn;
    cxgItensViewDESITE: TcxGridDBBandedColumn;
    cxgItensViewSIGUNI: TcxGridDBBandedColumn;
    cxgItensViewCODFIS: TcxGridDBBandedColumn;
    cxgItensViewCLAFIS: TcxGridDBBandedColumn;
    cxgItensViewQTDITE: TcxGridDBBandedColumn;
    cxgItensViewUNITAR: TcxGridDBBandedColumn;
    cxgItensViewTOTITE: TcxGridDBBandedColumn;
    cxgItensViewDESESP: TcxGridDBBandedColumn;
    cxgItensViewVALFRE: TcxGridDBBandedColumn;
    cxgItensViewDESACE: TcxGridDBBandedColumn;
    cxgItensViewBASICM: TcxGridDBBandedColumn;
    cxgItensViewALQICM: TcxGridDBBandedColumn;
    cxgItensViewVALICM: TcxGridDBBandedColumn;
    cxgItensViewBASIPI: TcxGridDBBandedColumn;
    cxgItensViewALQIPI: TcxGridDBBandedColumn;
    cxgItensViewVALIPI: TcxGridDBBandedColumn;
    cxgItensViewBASRET: TcxGridDBBandedColumn;
    cxgItensViewVALRET: TcxGridDBBandedColumn;
    cxgItensViewVLRCON: TcxGridDBBandedColumn;
    cdsItensESPDOC: TStringField;
    cxgItensViewESPDOC: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxsBandHeader: TcxStyle;
    cxsFooter: TcxStyle;
    cxsSummary: TcxStyle;
    cxsGroup: TcxStyle;
    cdsItensREFERE: TStringField;
    cdsItensCODFAB: TStringField;
    cxgItensViewREFERE: TcxGridDBBandedColumn;
    cxgItensViewCODFAB: TcxGridDBBandedColumn;
    cdsItensIVA_ST: TFloatField;
    cxgItensViewIVA_ST: TcxGridDBBandedColumn;
    cdsItensCLAIPI: TStringField;
    cdsItensDESMAR: TStringField;
    cxgItensViewClaIPI: TcxGridDBBandedColumn;
    cxgItensViewDesmar: TcxGridDBBandedColumn;
    cxgItensViewALDIFAL: TcxGridDBBandedColumn;
    cdsItensALDIFA: TFloatField;
    cxgItensViewDIFORI: TcxGridDBBandedColumn;
    cxgItensViewDIFDES: TcxGridDBBandedColumn;
    cdsItensDIFDES: TFloatField;
    cdsItensDIFORI: TFloatField;
    cdsItensTOTDIF: TFloatField;
    cxgItensViewTOTDIF: TcxGridDBBandedColumn;
    cxgItensViewPERFCP: TcxGridDBBandedColumn;
    cxgItensViewVALFCP: TcxGridDBBandedColumn;
    cdsItensVALFCP: TFloatField;
    cdsItensPERFCP: TFloatField;
    cdsItensVALFCPST: TFloatField;
    cxgItensViewPERFCPST: TcxGridDBBandedColumn;
    cxgItensViewVALFCPST: TcxGridDBBandedColumn;
    cdsItensBASFCP: TFloatField;
    cdsItensBASFCPST: TFloatField;
    cdsItensPERFCPST: TFloatField;
    cxgItensViewBASFCPST: TcxGridDBBandedColumn;
    cxgItensViewBASFCP: TcxGridDBBandedColumn;
    cxgItensViewCodAbf: TcxGridDBBandedColumn;
    cdsItensCODABF: TStringField;
    cdsItensPERBAS: TFloatField;
    cdsItensPERBASST: TFloatField;
    cxgItensViewPERBAS: TcxGridDBBandedColumn;
    cxgItensViewPEBAST: TcxGridDBBandedColumn;
    btnExportaCSV: TBitBtnLocked;
    cdsItensBASPIS: TFloatField;
    cdsItensALQPIS: TFloatField;
    cdsItensVALPIS: TFloatField;
    cdsItensBASCOF: TFloatField;
    cdsItensALQCOF: TFloatField;
    cdsItensVALCOF: TFloatField;
    cxgItensViewBASPIS: TcxGridDBBandedColumn;
    cxgItensViewALQPIS: TcxGridDBBandedColumn;
    cxgItensViewVALPIS: TcxGridDBBandedColumn;
    cxgItensViewBASCOF: TcxGridDBBandedColumn;
    cxgItensViewALQCOF: TcxGridDBBandedColumn;
    cxgItensViewVALCOF: TcxGridDBBandedColumn;
    cdsItensICMORG: TFloatField;
    cxgItensViewICMORG: TcxGridDBBandedColumn;
    cdsItensBASCBS: TFloatField;
    cdsItensALQCBS: TFloatField;
    cdsItensVALCBS: TFloatField;
    cdsItensBASIBS: TFloatField;
    cdsItensALQIBS: TFloatField;
    cdsItensVALIBS: TFloatField;
    cdsItensBAS_IS: TFloatField;
    cdsItensALQ_IS: TFloatField;
    cdsItensVAL_IS: TFloatField;
    cxgItensViewBASCBS: TcxGridDBBandedColumn;
    cxgItensViewALQCBS: TcxGridDBBandedColumn;
    cxgItensViewVALCBS: TcxGridDBBandedColumn;
    cxgItensViewBASIBS: TcxGridDBBandedColumn;
    cxgItensViewALQIBS: TcxGridDBBandedColumn;
    cxgItensViewVALIBS: TcxGridDBBandedColumn;
    cxgItensViewBAS_IS: TcxGridDBBandedColumn;
    cxgItensViewALQ_IS: TcxGridDBBandedColumn;
    cxgItensViewVAL_IS: TcxGridDBBandedColumn;
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExportaCSVClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    frmFechamentoVenda: TfrmGravando;

    function fCarregarItens(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fAjustaTamanhoColunas(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pExecutarProgresso(fExecutarAcao: TFunctionFormGravando);

    procedure pSimularEmissaoDocumentoVenda;
    procedure pAdicionarItensClientDataSet(strEspecie, strTipoDocumento: String;
      arrItens: TMatrizFechamento);

    function fGetFloatValue(fltValor: Double): Variant;
    function fVaiExibirDesoneracaoZonaFranca: Boolean;
    function fGetDesEsp(const item: TDadosFechamento): Variant;

    { Private declarations }
  public
    { Public declarations }
    fatVenda: TFatVenda;

    blnExibirAcrescimoDesconto: Boolean;
    fltFatorParaNotaEspecial: Double;
    strTipoFatorParaNotaEspecial: String;
    fltFrete: Double;
    fltDespAcessoria: Double;
    strTipoFaturamento: String;
    strTipoOperacao: String;

    class procedure pSimularFechamentoVenda(objVenda: TFatVenda;
      fltFrete, fltDespAcessoria: Double;
      strTipoFaturamento, strTipoOperacao: String; fltFatorNF: Double;
      strTipoFatorNF: String);
  end;

implementation

uses StrUtils, untFuncoesGenerica, untFuncoes, untDuplicatas, untExportaGridCSV;

{$R *.dfm}
{ TfrmFatMostraItensFechamento }

procedure TfrmFatMostraItensFechamento.btnExportaCSVClick(Sender: TObject);
  Var
    objExportaCSV: TExportaGridCSV;
begin
  inherited;

  objExportaCSV := TExportaGridCSV.Create(Self, cxgItensView);
  Try
    objExportaCSV.fExporta;
  Finally
    FreeAndNil(objExportaCSV);
  End;
end;

procedure TfrmFatMostraItensFechamento.cxgItensViewCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not AViewInfo.GridRecord.Focused) And
    (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmFatMostraItensFechamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnExibirAcrescimoDesconto   := True;
  fltFatorParaNotaEspecial     := 0;
  strTipoFatorParaNotaEspecial := '';
  pSetaCodIte(cdsItensCODITE);
  cdsItens.CreateDataSet;

  TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat :=
    fMskDigitos(fCfgSis('DECQTD', varInteger));

  TFloatField(cdsItens.FieldByName('UNITAR')).DisplayFormat :=
    fMskDigitos(fCfgSis('DECUNI', varInteger));

  TFloatField(cdsItens.FieldByName('TOTITE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('DESESP')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('ICMORG')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('VALFRE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('DESACE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('BASICM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('ALQICM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('VALICM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('BASIPI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('ALQIPI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('VALIPI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('IVA_ST')).DisplayFormat := '#,##0.0000';
  TFloatField(cdsItens.FieldByName('BASRET')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('VALRET')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsItens.FieldByName('ALDIFA')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('DIFDES')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('DIFORI')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('TOTDIF')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BASFCP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('VALFCP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('PERFCP')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BASFCPST')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('VALFCPST')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('PERFCPST')).DisplayFormat := fMskDigitos(2);

  TStringField(cdsItens.FieldByName('SIGUNI')).Alignment := taCenter;
  TStringField(cdsItens.FieldByName('CODFIS')).Alignment := taCenter;
  TStringField(cdsItens.FieldByName('CLAFIS')).Alignment := taCenter;

  TFloatField(cdsItens.FieldByName('PERBAS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('PEBAST')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BASPIS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('ALQPIS')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsItens.FieldByName('VALPIS')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BASCOF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('ALQCOF')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsItens.FieldByName('VALCOF')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BASCBS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('ALQCBS')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsItens.FieldByName('VALCBS')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BASIBS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('ALQIBS')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsItens.FieldByName('VALIBS')).DisplayFormat := fMskDigitos(2);

  TFloatField(cdsItens.FieldByName('BAS_IS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('ALQ_IS')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsItens.FieldByName('VAL_IS')).DisplayFormat := fMskDigitos(2);
end;

procedure TfrmFatMostraItensFechamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F8 Then
    btnExportaCSV.Click;
end;

procedure TfrmFatMostraItensFechamento.FormResize(Sender: TObject);
begin
  inherited;
  pExecutarProgresso(fAjustaTamanhoColunas);
end;

procedure TfrmFatMostraItensFechamento.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      btnSair.Click;
  End;
end;

function TfrmFatMostraItensFechamento.fAjustaTamanhoColunas
  (pgbStatus: TcxProgressBar = Nil): Boolean;
var
  intColumn: Integer;
  intTamUti: Integer;
  intDispon: Integer;
  blnExibirNovosImpostos: Boolean;
begin
  pInformacao('Aguarde, Ajustando colunas...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  cxgItensView.Bands[3].Visible := blnExibirAcrescimoDesconto;

  blnExibirNovosImpostos := fSomarNovosImpostosDaReformaAoValorContabil;
  cxgItensView.Bands[cxgItensViewBASCBS.Position.BandIndex].Visible := blnExibirNovosImpostos;
  cxgItensView.Bands[cxgItensViewBASIBS.Position.BandIndex].Visible := blnExibirNovosImpostos;
  cxgItensView.Bands[cxgItensViewBAS_IS.Position.BandIndex].Visible := blnExibirNovosImpostos;

  If blnExibirAcrescimoDesconto Then
  Begin
    cxgItensViewREFERE.Visible := False;
    cxgItensViewCODFAB.Visible := False;
  End;

  cxgItensViewICMORG.Visible := fVaiExibirDesoneracaoZonaFranca;

  cxgItensView.ApplyBestFit;

  intTamUti := 0;
  For intColumn := 0 To cxgItensView.ColumnCount - 1 Do
  Begin
    pProgresso(Succ(intColumn), cxgItensView.ColumnCount, pgbStatus);
    With cxgItensView.Columns[intColumn] Do
      If Visible And cxgItensView.Bands[Position.BandIndex].Visible Then
        Inc(intTamUti, Width);
  End;

  intDispon := Self.Width - intTamUti - 50;

  If intDispon <= 0 Then
    Exit(True);

  For intColumn := 0 To cxgItensView.ColumnCount - 1 Do
  Begin
    pProgresso(Succ(intColumn), cxgItensView.ColumnCount, pgbStatus);
    With cxgItensView.Columns[intColumn] Do
      If Visible And cxgItensView.Bands[Position.BandIndex].Visible Then
        Width := Width + Floor(intDispon * (Width / intTamUti));
  End;

  cxgItensView.ViewData.Expand(True);

  Result := True;
end;

procedure TfrmFatMostraItensFechamento.pExecutarProgresso
  (fExecutarAcao: TFunctionFormGravando);
begin
  Try
    pCriarFormularios(TfrmGravando, frmFechamentoVenda);
    frmFechamentoVenda.fExecutarAcao := fExecutarAcao;
    frmFechamentoVenda.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmFechamentoVenda);
end;

procedure TfrmFatMostraItensFechamento.FormShow(Sender: TObject);
begin
  pExecutarProgresso(fCarregarItens);
  pExecutarProgresso(fAjustaTamanhoColunas);
end;

function TfrmFatMostraItensFechamento.fVaiExibirDesoneracaoZonaFranca: Boolean;
begin
  Result := (fatVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms) And (fatVenda.fltIcmOrg > 0);
end;

function TfrmFatMostraItensFechamento.fGetDesEsp(const item: TDadosFechamento): Variant;
begin
  Result := fGetFloatValue(item.fltDesEsp);
  If (fVaiExibirDesoneracaoZonaFranca) And (item.fltDesEsp > 0) Then
    Result := fGetFloatValue(item.fltDesEsp - item.fltIcmOrg);
end;

function TfrmFatMostraItensFechamento.fGetFloatValue(fltValor: Double): Variant;
begin
  Result := IIF(fltValor = 0, null, fltValor);
end;

procedure TfrmFatMostraItensFechamento.pAdicionarItensClientDataSet(strEspecie,
  strTipoDocumento: String; arrItens: TMatrizFechamento);
Var
  intItem: Integer;
  item: TDadosFechamento;

  procedure pGravarGrupoNovoImposto(const strCamBas, strCamAlq, strCamVal: String;
    const fltBase, fltAliquota, fltValor: Double);
  begin
    If (fltValor <= 0) Then
    Begin
      cdsItens.FieldByName(strCamBas).Value := fGetFloatValue(0);
      cdsItens.FieldByName(strCamAlq).Value := fGetFloatValue(0);
      cdsItens.FieldByName(strCamVal).Value := fGetFloatValue(0);
      Exit;
    End;

    cdsItens.FieldByName(strCamBas).Value := fGetFloatValue(fltBase);
    cdsItens.FieldByName(strCamAlq).Value := fGetFloatValue(fltAliquota);
    cdsItens.FieldByName(strCamVal).Value := fGetFloatValue(fltValor);
  end;

begin
  pInformacao('Aguarde, Carregando produtos...', frmFechamentoVenda.pgbStatus);
  pProgresso(0, 0, frmFechamentoVenda.pgbStatus);

  intItem := 0;
  For item In arrItens Do
  Begin
    pProgresso(fInc(intItem), Length(arrItens), frmFechamentoVenda.pgbStatus);

    cdsItens.Append;
    cdsItens.FieldByName('ALDIFA').AsFloat := item.recDifalFCP.fltAlDifa;
    cdsItens.FieldByName('DIFDES').AsFloat := item.recDifalFCP.fltDifDes;
    cdsItens.FieldByName('DIFORI').AsFloat := item.recDifalFCP.fltDifOri;
    cdsItens.FieldByName('TOTDIF').AsFloat := item.recDifalFCP.fltDifDes +
      item.recDifalFCP.fltDifOri;

    if (item.VisualizarFcpIcms.fltValor > 0) and
       (item.VisualizarFcpIcms.fltAliquota > 0) then
    begin
      cdsItens.FieldByName('BASFCP').AsFloat := item.VisualizarFcpIcms.fltBase;
      cdsItens.FieldByName('PERFCP').AsFloat := item.VisualizarFcpIcms.fltAliquota;
      cdsItens.FieldByName('VALFCP').AsFloat := item.VisualizarFcpIcms.fltValor;
    end
    else
    begin
      cdsItens.FieldByName('BASFCP').AsFloat := 0;
      cdsItens.FieldByName('PERFCP').AsFloat := 0;
      cdsItens.FieldByName('VALFCP').AsFloat := 0;
    end;

    if (item.VisualizarFcpIcmsST.fltValor > 0) and
       (item.VisualizarFcpIcmsST.fltAliquota > 0) then
    begin
      cdsItens.FieldByName('BASFCPST').AsFloat := item.VisualizarFcpIcmsST.fltBase;
      cdsItens.FieldByName('PERFCPST').AsFloat := item.VisualizarFcpIcmsST.fltAliquota;
      cdsItens.FieldByName('VALFCPST').AsFloat := item.VisualizarFcpIcmsST.fltValor;
    end
    else
    begin
      cdsItens.FieldByName('BASFCPST').AsFloat := 0;
      cdsItens.FieldByName('PERFCPST').AsFloat := 0;
      cdsItens.FieldByName('VALFCPST').AsFloat := 0;
    end;

    cdsItens.FieldByName('ESPDOC').AsString := strEspecie + ' ( ' +
      fGetDescricaoEspecie(strEspecie) + ' ) ' + ' - ' + strTipoDocumento;

    cdsItens.FieldByName('CODITE').AsString := item.strCodIte;
    cdsItens.FieldByName('DESITE').AsString := item.strDesIte;
    cdsItens.FieldByName('REFERE').AsString := item.strRefere;
    cdsItens.FieldByName('CODFAB').AsString := item.strCodFab;
    cdsItens.FieldByName('SIGUNI').AsString := item.strSigUni;
    cdsItens.FieldByName('CODFIS').AsString := item.strCodFis;
    cdsItens.FieldByName('CLAFIS').AsString := item.strClaFis;
    cdsItens.FieldByName('QTDITE').Value := fGetFloatValue(item.fltQtdIte);
    cdsItens.FieldByName('UNITAR').Value := fGetFloatValue(item.fltUnitar);
    cdsItens.FieldByName('TOTITE').Value := fGetFloatValue(item.fltTotIte);
    cdsItens.FieldByName('DESESP').Value := fGetDesEsp(item);
    cdsItens.FieldByName('ICMORG').Value := fGetFloatValue(item.fltIcmOrg);
    cdsItens.FieldByName('VALFRE').Value := fGetFloatValue(item.fltValFre);
    cdsItens.FieldByName('DESACE').Value := fGetFloatValue(item.fltDesAce);

    If item.fltValIcm <= 0 Then
    Begin
      cdsItens.FieldByName('BASICM').Value := fGetFloatValue(0);
      cdsItens.FieldByName('ALQICM').Value := fGetFloatValue(0);
      cdsItens.FieldByName('VALICM').Value := fGetFloatValue(0);
      cdsItens.FieldByName('PERBAS').Value := fGetFloatValue(0);
    End
    Else
    Begin
      cdsItens.FieldByName('BASICM').Value := fGetFloatValue(item.fltBasIcm);
      cdsItens.FieldByName('ALQICM').Value := fGetFloatValue(item.fltAlqIcm);
      cdsItens.FieldByName('VALICM').Value := fGetFloatValue(item.fltValIcm);
      cdsItens.FieldByName('PERBAS').Value := fGetFloatValue(item.fltPerBas);
    End;

    If item.fltValIpi <= 0 Then
    Begin
      cdsItens.FieldByName('BASIPI').Value := fGetFloatValue(0);
      cdsItens.FieldByName('ALQIPI').Value := fGetFloatValue(0);
      cdsItens.FieldByName('VALIPI').Value := fGetFloatValue(0);
    End
    Else
    Begin
      cdsItens.FieldByName('BASIPI').Value := fGetFloatValue(item.fltBasIpi);
      cdsItens.FieldByName('ALQIPI').Value := fGetFloatValue(item.fltAlqIpi);
      cdsItens.FieldByName('VALIPI').Value := fGetFloatValue(item.fltValIpi);
    End;

    If item.fltIva_St > 0 Then
      cdsItens.FieldByName('IVA_ST').Value := fGetFloatValue(item.fltIva_St)
    Else
      cdsItens.FieldByName('IVA_ST').Value := fGetFloatValue(0);

    If item.fltValRet <= 0 Then
    Begin
      cdsItens.FieldByName('BASRET').Value := fGetFloatValue(0);
      cdsItens.FieldByName('VALRET').Value := fGetFloatValue(0);
      cdsItens.FieldByName('PEBAST').Value := fGetFloatValue(0);
    End
    Else
    Begin
      cdsItens.FieldByName('BASRET').Value := fGetFloatValue(item.fltBasRet);
      cdsItens.FieldByName('VALRET').Value := fGetFloatValue(item.fltValRet);
      cdsItens.FieldByName('PEBAST').Value := fGetFloatValue(item.fltPeBaST);;
    End;

    cdsItens.FieldByName('VLRCON').Value :=
      fFormataFloat(item.fltTotIte - item.fltDesEsp + item.fltValFre +
      item.fltDesAce + item.fltValIpi + item.fltValRet +
      item.fltValCBS + item.fltValIBS + item.fltVal_IS, 2);

    cdsItens.FieldByName('CLAIPI').Value := item.strClaIpi;
    cdsItens.FieldByName('DESMAR').Value := fRetNomMarca(item.strCodMar);
    cdsItens.FieldByName('CODABF').Value := item.strCodAbf;

    cdsItens.FieldByName('CODFIS').AsString  := fatVenda.fRetornaCstDiferimento(cdsItens.FieldByName('BASICM').AsFloat,
                                                                                cdsItens.FieldByName('CODFIS').AsString);

    cdsItens.FieldByName('BASPIS').Value := fGetFloatValue(item.fltBasPis);
    cdsItens.FieldByName('ALQPIS').Value := fGetFloatValue(item.fltAlqPis);
    cdsItens.FieldByName('VALPIS').Value := fGetFloatValue(item.fltValPis);

    cdsItens.FieldByName('BASCOF').Value := fGetFloatValue(item.fltBasCof);
    cdsItens.FieldByName('ALQCOF').Value := fGetFloatValue(item.fltAlqCof);
    cdsItens.FieldByName('VALCOF').Value := fGetFloatValue(item.fltValCof);

    pGravarGrupoNovoImposto('BASCBS', 'ALQCBS', 'VALCBS', item.fltBasCBS, item.fltAlqCBS, item.fltValCBS);
    pGravarGrupoNovoImposto('BASIBS', 'ALQIBS', 'VALIBS', item.fltBasIBS, item.fltAlqIBS, item.fltValIBS);
    pGravarGrupoNovoImposto('BAS_IS', 'ALQ_IS', 'VAL_IS', item.fltBas_IS, item.fltAlq_IS, item.fltVal_IS);

    cdsItens.Post;
  End;
end;

function TfrmFatMostraItensFechamento.fCarregarItens
  (pgbStatus: TcxProgressBar = Nil): Boolean;
const
  arrVarBkp: Array[0..9] of string = ('strOpcDoc', 'strEspDoc', 'strTipFat',
    'strTipPed', 'strTipOpe', 'fltValFre', 'fltDesAce', 'fltDesEsp', 'fltFatNot',
    'strTipFatNEs');
Var
  arrItensBkp: TMatrizFechamento;
begin
  inherited;
  Result := True;
  arrItensBkp  := fatVenda.arrMatItens;
  fatVenda.pSetBackupVar(arrVarBkp);
  Try
    pSimularEmissaoDocumentoVenda;
  Finally
    fatVenda.arrMatItens := arrItensBkp;
    fatVenda.pGetBackupVar(arrVarBkp);
    fatVenda.pCarregaCfgSis;
    fatVenda.blnMeiaNotaComNotaNormal := False;
    fatVenda.blnDesmembrarMeiaNotaComNotaNormal := False;
  End;
  pSetFocus(cxgItens);
end;

procedure TfrmFatMostraItensFechamento.pSimularEmissaoDocumentoVenda;
Var
  objAcertaVencimentos: TAcertaVencimentosMeiaNotaComNotaNormal;
  informacoesDocumento: TInfoDocVenda;
begin
  pInformacao('Aguarde, Simulando Fechamento da Venda...',
    frmFechamentoVenda.pgbStatus);
  pProgresso(0, 0, frmFechamentoVenda.pgbStatus);

  fatVenda.strOpcDoc := IIF((Pos(fatVenda.strOpcDoc, 'OR_PD_VN_') > 0), fatVenda.strOpcDoc, 'VN'); //Necessario para simular a emissão da Venda
  fatVenda.fltValFre := fltFrete;
  fatVenda.fltDesAce := fltDespAcessoria;
  fatVenda.strTipPed := strTipoFaturamento;
  fatVenda.strTipOpe := strTipoOperacao;
  fatVenda.fltFatNot := fltFatorParaNotaEspecial;
  fatVenda.strTipFatNEs := strTipoFatorParaNotaEspecial;
  fatVenda.pDefineTipoFaturamentoExpedicao;
  fatVenda.pPreparaParaEmitirMeiaNotaNotaNormal;
  fatVenda.pCalculaTotGer;
  fatVenda.pCalculaTotalParaCadRec;

  fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0,
    fatVenda.fltTotCadRec, False, False, False, VS_Date, False,
    fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean));

  If Not fatVenda.fEhGravacaoSimplesVenda Then
  Begin
    objAcertaVencimentos := TAcertaVencimentosMeiaNotaComNotaNormal.Create;

    If fatVenda.fDesmembrarVenda(frmFechamentoVenda.pgbStatus,
      objAcertaVencimentos.fSetarStatus(stgSimulandoGravacao)) Then
    Begin
      For informacoesDocumento In objAcertaVencimentos.arrInfoDocumentos Do
        With informacoesDocumento Do
          pAdicionarItensClientDataSet(strEspDoc, strTipDoc, arrItens);
    End
    Else
      pAdicionarItensClientDataSet(fatVenda.strEspDoc, '',
        fatVenda.arrMatItens);

    FreeAndNil(objAcertaVencimentos);
  End
  Else
    pAdicionarItensClientDataSet(fatVenda.strEspDoc, '', fatVenda.arrMatItens);
end;

class procedure TfrmFatMostraItensFechamento.pSimularFechamentoVenda
  (objVenda: TFatVenda; fltFrete, fltDespAcessoria: Double;
  strTipoFaturamento, strTipoOperacao: String; fltFatorNF: Double;
  strTipoFatorNF: String);
var
  frmFatMostraItens: TfrmFatMostraItensFechamento;

  function fCadCliente(strField: String): Variant;
  begin
    Result := fCampoTabela('CLI_' + strField, 'CADCLI', ['CLI_CODCLI'],
      [objVenda.strCodCli]);
  end;

begin
  Try
    pCriarFormularios(TfrmFatMostraItensFechamento, frmFatMostraItens);

    frmFatMostraItens.fatVenda := objVenda;
    frmFatMostraItens.fltFrete := fltFrete;
    frmFatMostraItens.fltDespAcessoria := fltDespAcessoria;
    frmFatMostraItens.strTipoFaturamento := strTipoFaturamento;
    frmFatMostraItens.strTipoOperacao := strTipoOperacao;

    If fCfgSis('SOLFNE', varBoolean) Then
    Begin
      frmFatMostraItens.fltFatorParaNotaEspecial := fltFatorNF;
      frmFatMostraItens.strTipoFatorParaNotaEspecial := strTipoFatorNF;
    End
    Else
    Begin
      frmFatMostraItens.fltFatorParaNotaEspecial := fCadCliente('FTNFES');
      frmFatMostraItens.strTipoFatorParaNotaEspecial := fCadCliente('TFTNES');
    End;

    frmFatMostraItens.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmFatMostraItens);
end;

end.
