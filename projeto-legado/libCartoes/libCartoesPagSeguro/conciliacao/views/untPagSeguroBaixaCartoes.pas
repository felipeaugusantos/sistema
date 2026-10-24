unit untPagSeguroBaixaCartoes;

interface

uses
  System.SysUtils, Winapi.Windows, System.Variants, System.StrUtils,
  System.Types, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Graphics, Vcl.AppEvnts, Vcl.Grids, Vcl.Dialogs, Vcl.Mask, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Menus, Datasnap.DBClient,
  System.Generics.Collections, System.Math, REST.Client, Rest.Types, ComObj,
  System.ImageList, Vcl.ImgList,

  MaskEditFocus, EditFocus,
  QColorLabel, Uni, UniClientDataSet, UniDataSetProvider, frxClass,
  BitBtnLockedIncrem, cxProgressBar, MemDS, DBAccess,
  frxExportCSVTestabilidade,cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridCitel, cxClasses, cxGridLevel, cxGrid,
  cxImageComboBox, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxCurrencyEdit,

  untLibCartoesPaiSimples, untTPagSeguroBaixaCartoes,
  untTBanMca, untTLibCartoesConfiguracaoGrids,

  untTPagSeguroFuncoes, untLibCartoesInterfacesTipos, untLibCartoesConfiguracaoGrids,
  untTBatchSQL, untTBatchSQL.Helper,

  {$WARNINGS OFF}Vcl.FileCtrl{$WARNINGS ON};

type
  TfrmPagSeguroBaixaCartoes = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    lblCliente: TLabel;
    lblOperadora: TLabel;
    lblPerCar: TLabel;
    lblValorBruto: TLabel;
    lblHistorico: TLabel;
    pnlBotoesBaixa: TPanel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    lblPerCarPercent: TLabel;
    lblValorTaxa: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtPerCar: TEditFocus;
    edtValOri: TEditFocus;
    edtValTax: TEditFocus;
    edtHist01: TEditFocus;
    edtHist02: TEditFocus;
    edtOperad: TEditFocus;
    lblNome: TLabel;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    shpMultSel: TShape;
    pnlInformativos: TPanel;
    flbConciliacao: TFileListBox;
    grpLegendaBaixas: TGroupBox;
    Shape1: TShape;
    Label21: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Shape3: TShape;
    lblNaoTransferidos: TLabel;
    Label27: TLabel;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn;
    grdDuplicDadosMCA_CODEMP: TcxGridDBColumn;
    grdDuplicDadosMCA_DTAVEN: TcxGridDBColumn;
    grdDuplicDadosMCA_DTACAD: TcxGridDBColumn;
    grdDuplicDadosMCA_VALTOT: TcxGridDBColumn;
    grdDuplicDadosMCA_VALSTA: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn;
    grdDuplicDadosPARDUP: TcxGridDBColumn;
    grdDuplicDadosMCA_MARDES: TcxGridDBColumn;
    grdDuplicNivel: TcxGridLevel;
    grdDuplicDadosMCA_RESCAI: TcxGridDBColumn;
    grdDuplicDadosMCA_DTATRA: TcxGridDBColumn;
    grdDuplicDadosMCA_EMPRCX: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn;
    lblDataTransacao: TLabel;
    edtDtaCup: TEditFocus;
    pnlAjustaTotal1: TPanel;
    lblRecebendo: TLabel;
    edtQtdSel: TEditFocus;
    edtQtdDup: TEditFocus;
    lblTotal: TLabel;
    lblQtdTotal: TLabel;
    lblTotalBruto: TLabel;
    edtTotDup: TEditFocus;
    edtTotSel: TEditFocus;
    pnlAjustaTotal2: TPanel;
    lblTotalAjustes: TLabel;
    edtAjuTot: TEditFocus;
    edtAjuSel: TEditFocus;
    pnlAjustaTotalPix: TPanel;
    lblTotalPix: TLabel;
    edtTotPix: TEditFocus;
    pnlAjustaTotal3: TPanel;
    lblTotalLiquido: TLabel;
    edtTotDupLiq: TEditFocus;
    edtTotSelLiq: TEditFocus;
    Shape4: TShape;
    Label29: TLabel;
    Label30: TLabel;
    grdDuplicDadosMCA_AJUSTE: TcxGridDBColumn;
    btnAjuVal: TBitBtnLocked;
    pnlDadosConcil: TPanel;
    edtPonVen: TEditFocus;
    lblPontoDeVenda: TLabel;
    edtPorBai: TEditFocus;
    lblPortadorBaixa: TLabel;
    edtCtaBai: TEditFocus;
    lblPlanoContasBaixa: TLabel;
    edtPorTax: TEditFocus;
    lblPortadorTaxa: TLabel;
    edtForTax: TEditFocus;
    lblFornecedorTaxa: TLabel;
    edtCtaTax: TEditFocus;
    lblPlanoDeContasTaxa: TLabel;
    edtPorDeb: TEditFocus;
    lblPortadorDebito: TLabel;
    edtCtaDeb: TEditFocus;
    lblPlanoContasDebito: TLabel;
    edtEveDeb: TEditFocus;
    lblCentroCustosDebito: TLabel;
    grdDuplicDadosSIT_CAD: TcxGridDBColumn;
    imgSitCad: TImageList;
    edtCtaAnt: TEditFocus;
    lblPlanoContasAntecipacao: TLabel;
    btnRelatorio: TBitBtnLocked;
    FlwBotoesBaixa: TFlowPanel;
    lblCentroCustosBaixa: TLabel;
    edtEventoBaixa: TEditFocus;
    lblCentroDeCustosTaxa: TLabel;
    edtEventoTaxaBaixa: TEditFocus;
    pnlAntecipacao: TPanel;
    lblAntTax: TLabel;
    edtAntTax: TEditFocus;
    pnlMarketPlace: TPanel;
    lblFreteMkt: TLabel;
    edtValorFrete: TEditFocus;
    lblAjustesMkt: TLabel;
    edtValorAjuste: TEditFocus;
    pnlCupomMarketPlace: TPanel;
    lblCupomMarketPlace: TLabel;
    edtCupomMarketPlace: TEditFocus;
    pnlPorcenTaxaAntecipacao: TPanel;
    lblPorcenTaxaAnt: TLabel;
    edtPorcentagemTaxaAntecipacao: TEditFocus;
    grdDuplicDadosMCA_TRFLIB: TcxGridDBColumn;
    grdDuplicDadosNEGOCIACAO: TcxGridDBColumn;
    grdDuplicDadosNEGOCIADO_ANTERIORMENTE: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMPOK: TcxGridDBColumn;
    grdDuplicDadosBAN_NOMBAN: TcxGridDBColumn;
    grdDuplicDadosCARTAO: TcxGridDBColumn;
    btnConfigurarGrid: TBitBtnLocked;
    grdDuplicDadosESTABE: TcxGridDBColumn;
    grdDuplicDadosREGISTROTRANSFERENCIA: TcxGridDBColumn;
    grdDuplicDadosREGISTROPIXCARTAO: TcxGridDBColumn;
    Shape5: TShape;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAjuValClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnConfigurarGridClick(Sender: TObject);
    function frxPreviaCartoesConcUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    FDataInicialConciliacao: TDate;
    FDataFinalConciliacao: TDate;
    FExibirCartoesPendente: Boolean;

    FConfiguracaoGrid: TConfiguracaoGrids;

    cdsCadPor,
    cdsCadCta: TUniClientDataSet;

    strPorCar: String;
    strCtaCar: String;
    strEventoCredito : String;
    strPorTax: String;
    strCtaTax: String;
    strForTax: String;
    strEventoTaxa : String;
    strPorBad: String;
    strCtaBad: String;
    strEveDeb: String;
    strCtaAnt: String;

    {*****************************************}
    {* DADOS ESPECIFICOS DA BAIXA SINTÉTICA  *}
    {**************************************MV*}
    dtaDtaDoc: TDateTime;
    strNumDoc: String;
    strHisDoc: String;

    dtaDtaPag: TDateTime;

    strSeqLan   : String;
    strSeqLanTax: String;
    strSeqLanCre: String;
    strSeqLanAnt: String;

    strValorFiltro: String;
    strCampoFiltro: String;

    dtsBaiCar: TDataSource;
    blnAcesso: Boolean;

    blnConfirmaBaixa: Boolean; //Tratamento para trabalhar o Commit/Rollback nas Baixas

    arrBaiSinCar: Array Of TArrBaiSinCar;
    arrBaiSinDeb: Array Of TArrBaiSinCar; //array para gravação de cancelamentos/ajsutes na movban
    FArrayNegociacao: Array Of TArrBaiSinCar; //array para lançamento de negociação de recebíveis

    cdsCloneConsulta: TUniClientDataSet;

    FLiberacaoTransferencia: Boolean;

    FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

    procedure pAbreConciliacao; //ABRIR A TELA PARA CONCILIAÇÃO

    procedure pCalculaTotalDuplicatas;

    procedure pLimpaDados;

    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAtualizaDados(DataSet: TDataSet);

    procedure pManipulaPanels(Habilita: Boolean);

    function fVerificaPorCta: Boolean;
    function fValidaPortadores: String;
    function fValidaEventos : Boolean;

    function fBaixaDuplicatas: Boolean;
    function fGravaCartoes(pgbStatus: TcxProgressBar): Boolean;
    function fGravaCartoesSin(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure pCarregaArrayNegociacao;

    procedure pCarregaArrBaiSinCar;
    procedure pCarregaArrAjustes;
    function fAdicionaCartoesPorEmpresa(strCodEmp: String; strIdenti: String;
      var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
      strPorCar: String = ''; strCtaCar: String = ''; strPorBad: String = ''; strCtaBad: String = '';
      strPorTax: String = ''; strCtaTax: String = ''; strForTax: String = ''; AstrEventoCredito : String = '';
      AstrEventoTaxa : String = ''; strEveDeb: String = '';
      strCtaAnt: String = ''; intAutoIncremInicial: Int64 = 0): Integer;

    function VerificacoesParaBaixa: Boolean;
    function fRegistroInformativoPix: Boolean;
    function fRetornaValorAntecipacao: String;

    function ApenasBaixaDeTransferencias: Boolean;
    procedure ExibirPorcentagemTaxaDeAntecipacao;
    procedure pVisualizaNroPedido;
    procedure pAtualizaDataMovimentobancarioMovCar( sAutoInc : String; ADataAlterada: TDateTime);
    function fGetEmpresaAjuste(ADataset: TUniClientDataset): string;
  protected
    strRcxTcc: String;
    dtaDtaIni: TDate;
    dtaDtaFim: TDate;
    intCtpCon: Integer;

    function fRetornaChaveGrid(): String;
  public
    blnConcil,
    blnInconsist,
    blnGraAju   : Boolean;
    cdsBaiCar   : TUniClientDataSet; //DATASET DA GRID DE BUSCA
    objConcil   : TCamposConcil;

    fltValorBaixa: Double;
    strCodPorFix: String;
    dteDtaRecFix: TDateTime;
    arrSeqLanLoc: TStringArray;

    property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes read FFiltrosRelatorio write FFiltrosRelatorio;

    property DataInicialConciliacao: TDate   Read FDataInicialConciliacao Write FDataInicialConciliacao;
    property DataFinalConciliacao  : TDate   Read FDataFinalConciliacao   Write FDataFinalConciliacao;
    property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente   Write FExibirCartoesPendente;


    { Public declarations }
  end;

implementation

uses untLibCartoesDigValor,untLibCartoesBaixaCtcAnaSin,
     untTLibCartoesMovCar, untTLibCartoesMovBan, untLibCartoesGravando,
     untTLibCartoesCadPag;

{$R *.dfm}

{ TfrmBaixaCartoes }

function TfrmPagSeguroBaixaCartoes.fRetornaChaveGrid: String;
begin
  Result := Concat(Self.Name, '.', grdDuplicDados.Name);

  If Not objConcil.TabelaConciliacao.IsEmpty Then
    Result := Concat(Result, '.', objConcil.TabelaConciliacao);
end;

function TfrmPagSeguroBaixaCartoes.fRegistroInformativoPix: Boolean;
begin
  Result := cdsBaiCar.FieldByName('REGISTROPIXCARTAO').AsString.Equals('S');
end;

function TfrmPagSeguroBaixaCartoes.fRetornaValorAntecipacao: String;
begin
  Result := FormatFloat('#,##0.00',cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat);
end;

function TfrmPagSeguroBaixaCartoes.frxPreviaCartoesConcUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fTime')) Then
    Result := TPagSeguroFuncoes.fTime(Params[0]);
end;

function TfrmPagSeguroBaixaCartoes.fValidaEventos: Boolean;
begin
  Result := True;

  cdsBaiCar.DisableControls;
  cdsBaiCar.first;
  while not cdsBaiCar.eof do
  begin
    If fRegistroInformativoPix Then
    Begin
      cdsBaiCar.Next;
      Continue;
    End;

    if ((cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'N') and
       (TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_EVECRE').AsString) or
        TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_EVETAX').AsString)) or
       (not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString) and
        TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_EVEDEB').AsString)))
       or
       ((cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'S') and
        (TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('MCA_EVECAN').AsString)))
         then
      begin
        cdsBaiCar.EnableControls;
        cdsBaiCar.First;
        Exit(False);
      end;

    cdsBaiCar.Next;
  end;

  cdsBaiCar.First;
  cdsBaiCar.EnableControls;
end;

function TfrmPagSeguroBaixaCartoes.fValidaPortadores: String;
  Var
    qryValPor: TUniQuery;
    strPortad: String;
begin
  qryValPor := Nil;
  strPortad := '';

  Try
    qryValPor := VS_FuncoesExternas.fICriaQuery;

    cdsBaiCar.First;
    While Not cdsBaiCar.Eof Do
    Begin
      If fRegistroInformativoPix Then
      Begin
        cdsBaiCar.Next;
        Continue;
      End;

      If Pos(cdsBaiCar.FieldByName('CAR_PORBAI').AsString, strPortad) <= 0 Then
        strPortad := strPortad + '"' + cdsBaiCar.FieldByName('CAR_PORBAI').AsString + '",';
      If Pos(cdsBaiCar.FieldByName('CAR_PORTAX').AsString, strPortad) <= 0 Then
        strPortad := strPortad + '"' + cdsBaiCar.FieldByName('CAR_PORTAX').AsString + '",';
      If (Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString)) And (Pos(cdsBaiCar.FieldByName('CAR_PORBAD').AsString, strPortad) <= 0) Then
        strPortad := strPortad + '"' + cdsBaiCar.FieldByName('CAR_PORBAD').AsString + '",';

      cdsBaiCar.Next;
    End;
    cdsBaiCar.First;

    qryValPor.SQL.Add('SELECT POR_CODPOR FROM CADPOR WHERE ');
    qryValPor.SQL.Add(' (POR_PERBAI="N" OR POR_PERBAI IS NULL) AND ');
    qryValPor.SQL.Add(' POR_CODPOR IN (' + TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(strPortad), '""',
                                     LeftStr(strPortad, Length(strPortad) - 1)) + ') ');
    qryValPor.SQL.Add(' ORDER BY POR_CODPOR');
    qryValPor.Open;

    Result := '';
    If qryValPor.RecordCount > 0 Then
    Begin
      While Not Eof Do
      Begin
        Result := Result + qryValPor.FieldByName('POR_CODPOR').AsString + ', ';

        qryValPor.Next;
      End;
      Result := Copy(Result, 1, Length(Result) - 2);
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(qryValPor);
  End;
end;

procedure TfrmPagSeguroBaixaCartoes.grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var strMarDes,
    strResCai,
    strDtaTra,
    strAjuste,
    strPix,
    LTFLiberada,
    LNegociacao,
    LNegociadoAnteriormente,
    LEstabelecimento,
    LTransferencia: String;
begin
  inherited;

  With cdsBaiCar do
  Begin
    If Not Active Then
      Exit;

    strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_MARDES.Index]);
    strPix    := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosREGISTROPIXCARTAO.Index]);
    strResCai := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_RESCAI.Index]);
    strDtaTra := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_DTATRA.Index]);
    strAjuste := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_AJUSTE.Index]);
    LTFLiberada := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_TRFLIB.Index]);

    LNegociacao := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosNEGOCIACAO.Index]);
    LNegociadoAnteriormente := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosNEGOCIADO_ANTERIORMENTE.Index]);
    LEstabelecimento := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosESTABE.Index]);
    LTransferencia := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosREGISTROTRANSFERENCIA.Index]);

    If (strPix = 'S') Then
      ACanvas.Font.Color := clTeal
    Else If (strMarDes = 'M') And (strAjuste <> 'S') Then
      ACanvas.Font.Color := clBlue
    Else If (TPagSeguroFuncoes.FExisteCampoLiberacaoTransferencia) And (LTFLiberada = 'N') And (strResCai = '1') And (FLiberacaoTransferencia) Then
      ACanvas.Font.Color := clGreen
    Else
    If (strRcxTcc = '2') And (strResCai = '1') And (strDtaTra ='') Then
      ACanvas.Font.Color := clGreen
    Else
    If strAjuste = 'S' Then
      ACanvas.Font.Color := clRed;

    If LNegociacao = 'S' Then
      ACanvas.Font.Color := clGreen;

    If LNegociadoAnteriormente = 'S' Then
    Begin
      ACanvas.Font.Color := clBlue;

      If Not AViewInfo.Selected Then
        ACanvas.Brush.Color := clMoneyGreen;
    End;
  End;
end;

procedure TfrmPagSeguroBaixaCartoes.grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Not cdsBaiCar.Active) Then
    Exit;

  If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(grdDuplic);
    pDeletaTemporaria;
  End;
end;

procedure TfrmPagSeguroBaixaCartoes.pAtualizaTemporaria;
begin
  If Not cdsBaiCar.IsEmpty Then
  Begin
    pCalculaTotalDuplicatas;
    cdsBaiCar.First;
    pAtualizaDados(cdsBaiCar);
  End;
end;

procedure TfrmPagSeguroBaixaCartoes.pDeletaTemporaria;
begin
  If Not Assigned(cdsBaiCar) Then
    Exit;

  If cdsBaiCar.Active Then
    cdsBaiCar.EmptyDataSet;

  If Not Assigned(cdsCloneConsulta) Then
    Exit;

  If cdsCloneConsulta.Active THen
    cdsCloneConsulta.EmptyDataset;
end;

procedure TfrmPagSeguroBaixaCartoes.pAbreConciliacao;
  Var
    strDireitos: String;
    qryBusCad  : TUniQuery;
begin
  cdsBaiCar.Close;

  dtsBaiCar := TPagSeguroFuncoes.fCriaDataSource(cdsBaiCar);
  grdDuplicDados.DataController.DataSource := dtsBaiCar;

  cdsBaiCar.Open;

  pnlCupomMarketPlace.Visible := False;

  pnlMarketPlace.Visible := False;

  If Not pnlMarketPlace.Visible Then
  Begin
    lblHistorico.Top := lblHistorico.Top - pnlMarketPlace.Height;
    edtHist01.Top := edtHist01.Top - pnlMarketPlace.Height;
    edtHist02.Top := edtHist02.Top - pnlMarketPlace.Height;
  End;

  grdDuplicDadosMCA_NUMPOK.Visible := False;

  grdDuplicDadosBAN_NOMBAN.Visible := False;
  grdDuplicDadosCARTAO.Visible := False;

  grdDuplicDadosBAN_NOMBAN.Visible := False;
  grdDuplicDadosCARTAO.Visible := False;

  pnlAntecipacao.Visible   := True;
  strDireitos              := '';
  btnConfirma.Left         := 0;
  pnlDadosConcil.Left      := 6;
  pnlDadosConcil.Top       := edtHist02.Top + edtHist02.Height + 5;
  pnlDadosConcil.Visible   := True;
  btnAjuVal.Left           := btnConfirma.Left + btnConfirma.Width + 2;
  btnAjuVal.Visible        := ((VS_FuncoesExternas.fIValidarDirEspecificos(strDireitos, VS_FuncoesExternas.fIRetOperadorLogado, 'frmBaixaCartoes')) And
                              (POS('A', strDireitos) > 0));
  btnRelatorio.Left        := btnAjuVal.Left + btnAjuVal.Width + 2;
  btnRelatorio.Visible     := True;

  qryBusCad := Nil;
  Try
    qryBusCad := VS_FuncoesExternas.fICriaQuery;
    qryBusCad.SQL.Text := 'SELECT POR_CODPOR, POR_NOMPOR FROM CADPOR ORDER BY POR_CODPOR';
    qryBusCad.Open;
    cdsCadPor := TPagSeguroFuncoes.CriarClientDataSet(qryBusCad);
    TPagSeguroFuncoes.FreeAndNilDataSets(qryBusCad);
    qryBusCad := VS_FuncoesExternas.fICriaQuery;
    qryBusCad.SQL.Text := 'SELECT CTA_CODCTA, CTA_DESCTA FROM CADCTA ORDER BY CTA_CODCTA';
    qryBusCad.Open;
    cdsCadCta := TPagSeguroFuncoes.CriarClientDataSet(qryBusCad);
    cdsCadPor.Open;
    cdsCadCta.Open;
  Finally
    TPagSeguroFuncoes.FreeAndNilDataSets(qryBusCad);
  End;

  cdsBaiCar.Filter      := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
  cdsBaiCar.Filtered    := True;
  grdDuplicDados.OnKeyDown   := Nil;
  grdDuplicDados.OnDblClick  := Nil;

  If ApenasBaixaDeTransferencias Then
    Exit;

  //Apenas o recebendo aparecerá
  lblTotal.Visible       := False;
  edtQtdDup.Visible    := False;
  edtTotDup.Visible    := False;
  edtAjuTot.Visible    := False;
  edtTotDupLiq.Visible := False;
  lblRecebendo.Top     := lblTotal.Top;
  edtQtdSel.Top        := edtQtdDup.Top;
  edtTotSel.Top        := edtTotDup.Top;
  edtAjuSel.Top        := edtAjuTot.Top;
  edtTotSelLiq.Top     := edtTotDupLiq.Top;

  pnlAjustaTotal2.Visible := blnGraAju;
  pnlPorcenTaxaAntecipacao.Visible := True;

  cdsBaiCar.IndexFieldNames := 'MCA_AJUSTE;' + cdsBaiCar.IndexFieldNames;

  pAtualizaTemporaria;

  FConfiguracaoGrid := TConfiguracaoGrids.Create(grdDuplic,
                                                 grdDuplicDados,
                                                 fRetornaChaveGrid,
                                                 ['MCA_MARDES', 'MCA_RESCAI', 'MCA_DTATRA', 'MCA_AJUSTE',
                                                 'MCA_TRFLIB', 'NEGOCIACAO', 'NEGOCIACAO_ANT']);

  cdsBaiCar.AfterScroll := pAtualizaDados;
  pSetFocus(btnConfirma);
end;

function TfrmPagSeguroBaixaCartoes.fAdicionaCartoesPorEmpresa(strCodEmp,
  strIdenti: String; var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
  strPorCar: String = ''; strCtaCar: String = ''; strPorBad: String = ''; strCtaBad: String = '';
  strPorTax: String = ''; strCtaTax: String = ''; strForTax: String = ''; AstrEventoCredito : String = '';
  AstrEventoTaxa : String = ''; strEveDeb: String = '';
  strCtaAnt: String = ''; intAutoIncremInicial: Int64 = 0): Integer;
  Var
    LBanMcaDS: TBanMcaDS;
begin
  If Assigned(AListaBanMca) Then
    FreeAndNil(AListaBanMca);

  AListaBanMca := TListaBanMCA.Create;

  cdsCloneConsulta.Filter := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_CODEMP = ' + QuotedStr(strCodEmp) +
                             ' AND MCA_DTAREC = ' + QuotedStr(FormatDateTime('dd-mm-yyyy', dtaDtaRec)) +
                             ' AND MCA_AJUSTE = ' + QuotedStr('N') +
                             ' AND CAR_PORBAI = ' + QuotedStr(strPorCar) +
                             ' AND CAR_CTABAI = ' + QuotedStr(strCtaCar) +
                             ' AND CAR_PORBAD = ' + QuotedStr(strPorBad) +
                             ' AND CAR_CTABAD = ' + QuotedStr(strCtaBad) +
                             ' AND CAR_PORTAX = ' + QuotedStr(strPorTax) +
                             ' AND CAR_CTATAX = ' + QuotedStr(strCtaTax) +
                             ' AND CAR_FORTAX = ' + QuotedStr(strForTax) +
                             ' AND CAR_EVECRE = ' + QuotedStr(AstrEventoCredito) +
                             ' AND CAR_EVETAX = ' + QuotedStr(AstrEventoTaxa) +
                             ' AND CAR_EVEDEB = ' + QuotedStr(strEveDeb) +
                             ' AND CAR_CTAANT = ' + QuotedStr(strCtaAnt);
  cdsCloneConsulta.Filtered := True;

  cdsCloneConsulta.First;
  While Not cdsCloneConsulta.Eof Do
  Begin
    TPagSeguroFuncoes.pProcessMessages;

    LBanMcaDS := TBanMcaDS.Create;
    LBanMcaDS.strNumDup := cdsCloneConsulta.FieldByName('NRODUP').AsString;
    LBanMcaDS.strParcel := cdsCloneConsulta.FieldByName('PARDUP').AsString;
    LBanMcaDS.strCodEmp := cdsCloneConsulta.FieldByName('MCA_CODEMP').AsString;
    LBanMcaDS.strCodCli := cdsCloneConsulta.FieldByName('MCA_CODCLI').AsString;
    LBanMcaDS.strCodCar := cdsCloneConsulta.FieldByName('MCA_CODCAR').AsString;
    LBanMcaDS.strHist01 := cdsCloneConsulta.FieldByName('MCA_HIST01').AsString;
    LBanMcaDS.strHist02 := cdsCloneConsulta.FieldByName('MCA_HIST02').AsString;
    LBanMcaDS.strNumCCD := cdsCloneConsulta.FieldByName('MCA_NUMCCD').AsString;
    LBanMcaDS.strNumNsu := cdsCloneConsulta.FieldByName('MCA_NUMNSU').AsString;
    LBanMcaDS.fltValSta := cdsCloneConsulta.FieldByName('MCA_VALSTA').AsFloat;
    LBanMcaDS.fltValTax := cdsCloneConsulta.FieldByName('MCA_VALTAX').AsFloat;
    LBanMcaDS.fltValRec := cdsCloneConsulta.FieldByName('MCA_VALREC').AsFloat;
    LBanMcaDS.fltFreMkt := cdsCloneConsulta.FieldByName('FRETE_MARKETPLACE').AsFloat;
    LBanMcaDS.fltValAju := cdsCloneConsulta.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
    LBanMcaDS.fltCupMkt := cdsCloneConsulta.FieldByName('CUPOM_MARKETPLACE').AsFloat;
    LBanMcaDS.strIdenti := strIdenti;
    LBanMcaDS.strAutInc := TPagSeguroFuncoes.IIF(intAutoIncremInicial > 0,
                               TPagSeguroFuncoes.fFormataAutInc(intAutoIncremInicial,
                                                               VS_FuncoesExternas.fIRetEmpresaLogada),
                               intAutoIncremInicial);
    AListaBanMca.Add(LBanMcaDS);

    If intAutoIncremInicial > 0 Then
      Inc64(intAutoIncremInicial);

    cdsCloneConsulta.Next;
  End;

  Result := cdsCloneConsulta.RecordCount;
end;

procedure TfrmPagSeguroBaixaCartoes.pAtualizaDados(DataSet: TDataSet);
begin

  edtCodCli.Text := cdsBaiCar.FieldByName('MCA_CODCLI').AsString;
  edtNomCli.Text := cdsBaiCar.FieldByName('CLI_NOMCLI').AsString;
  edtOperad.Text := cdsBaiCar.FieldByName('MCA_CODCAR').AsString +' - ' +
                    cdsBaiCar.FieldByName('CAR_DESCAR').AsString;
  edtDtaCup.Text := FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTACUP').AsDateTime);
  edtPerCar.Text := FormatFloat(',0.000000', cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat);

  If pnlPorcenTaxaAntecipacao.Visible Then
    ExibirPorcentagemTaxaDeAntecipacao;

  edtValOri.Text := FormatFloat('#,##0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat);
  edtValTax.Text := FormatFloat('#,##0.00', cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat);
  edtHist01.Text := cdsBaiCar.FieldByName('MCA_HIST01').AsString;
  edtHist02.Text := cdsBaiCar.FieldByName('MCA_HIST02').AsString;

  edtValorFrete.Text := FormatFloat('#,##0.00', Abs(cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat));
  edtValorAjuste.Text := FormatFloat('#,##0.00', Abs(cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat));
  edtCupomMarketPlace.Text := FormatFloat('#,##0.00', Abs(cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat));

  edtPonVen.Text := cdsBaiCar.FieldByName('MCA_ESTABE').AsString;

  edtForTax.Text := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('FOR_NOMFOR').AsString), '',
                        cdsBaiCar.FieldByName('CAR_FORTAX').AsString + '-' + cdsBaiCar.FieldByName('FOR_NOMFOR').AsString);
  edtEveDeb.Text := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString), '',
                        cdsBaiCar.FieldByName('CAR_EVEDEB').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString);
  edtEventoBaixa.Text := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString), '',
                        cdsBaiCar.FieldByName('CAR_EVECRE').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString);

  if cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S' then
    edtEventoTaxaBaixa.Text := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString), '',
                                   cdsBaiCar.FieldByName('CAR_EVETAX').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString)
  else
    edtEventoTaxaBaixa.Text := cdsBaiCar.FieldByName('MCA_EVECAN').AsString + '-' +
                               TPagSeguroFuncoes.RetornaNomeCentroDeCustos(cdsBaiCar.FieldByName('MCA_EVECAN').AsString);

  edtPorBai.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAI').AsString) Then
  Begin
    cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORBAI').AsString, []);
    edtPorBai.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                      cdsCadPor.FieldByName('POR_NOMPOR').AsString;
  End;


  edtCtaBai.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTABAI').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTABAI').AsString, []);
    edtCtaBai.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;

  edtPorTax.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORTAX').AsString) Then
  Begin
    cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORTAX').AsString, []);
    edtPorTax.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                      cdsCadPor.FieldByName('POR_NOMPOR').AsString;
  End;

  edtCtaTax.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTATAX').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTATAX').AsString, []);
    edtCtaTax.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;


  edtPorDeb.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString) Then
  Begin
    cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORBAD').AsString, []);
    edtPorDeb.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                      cdsCadPor.FieldByName('POR_NOMPOR').AsString;
  End;

  edtCtaDeb.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTABAD').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTABAD').AsString, []);
    edtCtaDeb.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;

  edtCtaAnt.Text := '';
  If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTAANT').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTAANT').AsString, []);
    edtCtaAnt.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;

  edtAntTax.Text := fRetornaValorAntecipacao;

  edtValTax.Text := FormatFloat('#,##0.00', TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat -
                                                                           cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat, 2));

  edtHist02.Hint     := edtHist02.Text;
  edtHist02.ShowHint := True;

  btnAjuVal.Enabled := (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S') And (Not fRegistroInformativoPix);

  lblFornecedorTaxa.Caption   := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S',
                                                      'Fornecedor Taxa:',
                                                      'Fornecedor Canc.:');
  lblCentroDeCustosTaxa.Caption   := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S',
                                                          'Ctr. Custo Taxa:',
                                                          'Ctr. Custo Canc.:');
end;


procedure TfrmPagSeguroBaixaCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  FLiberacaoTransferencia := False;
  If TPagSeguroFuncoes.FExisteCampoLiberacaoTransferencia Then
    FLiberacaoTransferencia := TPagSeguroFuncoes.RetornaValorCfg('CFG_USAAUT', VS_FuncoesExternas.fIRetEmpresaLogada).Equals('S');

  blnConcil   := False;
  blnInconsist:= False;
  blnGraAju   := False;

  SetLength(arrSeqLanLoc, 0);

  pVisualizaNroPedido;
end;


procedure TfrmPagSeguroBaixaCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnAjuVal.Click
  Else If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_ESCAPE) Then
    btnSairBaixa.Click
  Else If (Key = VK_F3) Then
    btnRelatorio.Click;
end;

procedure TfrmPagSeguroBaixaCartoes.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharFormPai Then
    btnSairBaixa.Click;
end;

procedure TfrmPagSeguroBaixaCartoes.pVisualizaNroPedido;
  Var
    LValorCfg: String;
begin
  LValorCfg := TPagSeguroFuncoes.RetornaValorCfg('CFG_NPEDBX');
  grdDuplicDadosMCA_NUMPOK.Visible := LValorCfg.Equals('S');
end;

procedure TfrmPagSeguroBaixaCartoes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(grdDuplic);
end;

procedure TfrmPagSeguroBaixaCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  grdDuplicDados.DataController.DataSource := Nil;

  TPagSeguroFuncoes.FreeAndNilDatasets(cdsCadPor);
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsCadCta);

  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);

  If Assigned(dtsBaiCar) Then
    FreeAndNil(dtsBaiCar);

  SetLength(arrBaiSinCar, 0);
  SetLength(arrBaiSinDeb, 0);
  SetLength(FArrayNegociacao, 0);
  SetLength(arrSeqLanLoc, 0);

  pLimpaDados;
  pDeletaTemporaria;

  TPagSeguroFuncoes.FreeAndNilDatasets(cdsBaiCar);
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsCloneConsulta);

  TLibCartoesMovBan.DestroiDatasetPortadores;
end;

procedure TfrmPagSeguroBaixaCartoes.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmPagSeguroBaixaCartoes.pCarregaArrayNegociacao;
  Var
    LDataRecebimento: TDateTime;

    LValorRecebido,
    LValorTaxa: Double;

    LGerarNovo: Boolean;

    LContador: Integer;

    LCodigoEmpresa,
    LPortador,
    LPlanoDeContas,
    LPlanoDeContasTaxa,
    LFornecedor,
    LFiltroAnterior,
    LTipoAjuste: String;
begin
  If Not blnConcil Then
    Exit;

  TPagSeguroFuncoes.pProcessMessages;

  LFiltroAnterior := cdsBaiCar.Filter;
  cdsBaiCar.Filter := 'MCA_AJUSTE=''S'' AND NEGOCIACAO=''S'' ';
  cdsBaiCar.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_FORTAX;MCA_VALREC';
  strCampoFiltro  := '';
  strValorFiltro  := '';
  cdsBaiCar.Filtered := True;

  SetLength(FArrayNegociacao, 0);

  Try
    If cdsBaiCar.IsEmpty Then
      Exit;

    cdsBaiCar.First;
    LCodigoEmpresa := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
    LDataRecebimento := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
    LPortador := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
    LPlanoDeContas := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
    LPlanoDeContasTaxa := cdsBaiCar.FieldByName('PLANODECONTASTXNEGOCIACAO').AsString;
    LFornecedor := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
    LValorRecebido := 0;
    LValorTaxa := 0;
    LTipoAjuste := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

    While Not cdsBaiCar.Eof Do
    Begin
      LGerarNovo := Concat(cdsBaiCar.FieldByName('MCA_CODEMP').AsString,
                           FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAREC').Value),
                           cdsBaiCar.FieldByName('CAR_PORBAI').AsString,
                           cdsBaiCar.FieldByName('CAR_CTABAI').AsString,
                           cdsBaiCar.FieldByName('CAR_FORTAX').AsString,
                           TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C')) <>
                    Concat(LCodigoEmpresa,
                           FormatDateTime('dd/mm/yyyy', LDataRecebimento),
                           LPortador,
                           LPlanoDeContas,
                           LFornecedor,
                           LTipoAjuste);

      If LGerarNovo Then
      Begin
        SetLength(FArrayNegociacao, Length(FArrayNegociacao) + 1);

        LContador := Length(FArrayNegociacao);

        FArrayNegociacao[LContador - 1].fltValDoc := LValorRecebido;
        FArrayNegociacao[LContador - 1].fltValTax := LValorTaxa;
        FArrayNegociacao[LContador - 1].strCodEmp := LCodigoEmpresa;
        FArrayNegociacao[LContador - 1].dtaDtaRec := LDataRecebimento;
        FArrayNegociacao[LContador - 1].strPorBai := LPortador;
        FArrayNegociacao[LContador - 1].strCtaBai := LPlanoDeContas;
        FArrayNegociacao[LContador - 1].PlanoDEContasTaxaNegociacao := LPlanoDeContasTaxa.Trim;
        FArrayNegociacao[LContador - 1].strForTax := LFornecedor;
        FArrayNegociacao[LContador - 1].strNumDoc := strNumDoc;
        FArrayNegociacao[LContador - 1].strHisDoc := 'NEGOCIAÇÃO DE RECEBÍVEIS ' + objConcil.NomeConciliacao.ToUpperInvariant + ' - Emp. ' + LCodigoEmpresa + ' - ' + strHisDoc;
        FArrayNegociacao[LContador - 1].intPagCon := intCtpCon;
        FArrayNegociacao[LContador - 1].strTipAju := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

        LCodigoEmpresa := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
        LDataRecebimento := cdsBaiCar.FieldByName('MCA_DTAREC').Value;

        LValorRecebido := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
        If TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat, 2) > 0 Then
        Begin
          LValorRecebido := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          LValorTaxa := cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat;
        End;

        LPortador := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
        LPlanoDeContas := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
        LFornecedor := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
        LTipoAjuste := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
      End
      Else
      Begin
        If TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat, 2) > 0 Then
        Begin
          LValorRecebido := LValorRecebido + cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          LValorTaxa := LValorTaxa + cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat;
        End
        Else
          LValorRecebido := LValorRecebido + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
      End;

      cdsBaiCar.Next;
    End;

    SetLength(FArrayNegociacao, Length(FArrayNegociacao) + 1);

    LContador := Length(FArrayNegociacao);

    FArrayNegociacao[LContador - 1].fltValDoc := LValorRecebido;
    FArrayNegociacao[LContador - 1].fltValTax := LValorTaxa;
    FArrayNegociacao[LContador - 1].strCodEmp := LCodigoEmpresa;
    FArrayNegociacao[LContador - 1].dtaDtaRec := LDataRecebimento;
    FArrayNegociacao[LContador - 1].strPorBai := LPortador;
    FArrayNegociacao[LContador - 1].strCtaBai := LPlanoDeContas;
    FArrayNegociacao[LContador - 1].PlanoDEContasTaxaNegociacao := LPlanoDeContasTaxa.Trim;
    FArrayNegociacao[LContador - 1].strForTax := LFornecedor;
    FArrayNegociacao[LContador - 1].strNumDoc := strNumDoc;
    FArrayNegociacao[LContador - 1].strHisDoc := 'NEGOCIAÇÃO DE RECEBÍVEIS ' + objConcil.NomeConciliacao.ToUpperInvariant + ' - Emp. ' + LCodigoEmpresa + ' - ' + strHisDoc;
    FArrayNegociacao[LContador - 1].intPagCon := intCtpCon;
    FArrayNegociacao[LContador - 1].strTipAju := LTipoAjuste;
  Finally
    cdsBaiCar.Filter := LFiltroAnterior;
  End;
end;

function TfrmPagSeguroBaixaCartoes.VerificacoesParaBaixa: Boolean;
begin
  Result := True;

  If TBaixaCartoes.VerificaSeHouveAlteracaoNosCartoesAntesDaBaixa(cdsBaiCar) Then
  Begin
    TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'Existem cartões que estão sendo baixados que sofreram uma alteração posterior a pesquisa.' + #13 +
                                             'Carregue os cartões novamente para efetuar as baixas corretamente!', ['&Ok']);
    Result := False;
  End;
end;

function TfrmPagSeguroBaixaCartoes.fVerificaPorCta: Boolean;
begin

  Result := cdsBaiCar.Locate('CAR_PORBAI', '', []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_CTABAI', '', []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_PORTAX;MCA_AJUSTE', VarArrayOf(['', 'N']), []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_CTATAX;MCA_AJUSTE', VarArrayOf(['', 'N']), []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_FORTAX', '', []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_CTAANT;MCA_ANT_SN', VarArrayOf(['', 'S']), []);

  If Result Then
    cdsBaiCar.First;
end;

procedure TfrmPagSeguroBaixaCartoes.pLimpaDados;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtOperad.Clear;
  edtPerCar.Clear;
  edtValOri.Clear;
  edtValTax.Clear;
  edtHist01.Clear;
  edtHist02.Clear;

  edtTotDup.Clear;
  edtQtdDup.Clear;
  edtTotSel.Clear;
  edtQtdSel.Clear;
  edtTotSelLiq.Clear;
  edtTotDupLiq.Clear;
  edtDtaCup.Clear;

  pSetFocus(grdDuplic);
end;

procedure TfrmPagSeguroBaixaCartoes.pManipulaPanels(Habilita: Boolean);
begin
  pnlBotoesBaixa.Enabled := Habilita;
  pnlAux2.Enabled := Habilita;
  pnlDadosDup.Enabled := Habilita;
end;

procedure TfrmPagSeguroBaixaCartoes.pCalculaTotalDuplicatas;
  Var
    prcScroll: TprcScroll;

    LQuantidade: Integer;

    LValorBruto,
    LValorLiquido,
    LValorAjustes,
    LTotalPix: Double;
begin
  TPagSeguroFuncoes.pDisableControls(cdsBaiCar, prcScroll);

  LQuantidade := 0;
  LValorBruto := 0.00;
  LValorLiquido := 0.00;
  LValorAjustes := 0.00;
  LTotalPix := 0.00;

  cdsBaicar.First;
  While Not cdsBaicar.Eof Do
  Begin
    If fRegistroInformativoPix Then
    Begin
      LTotalPix := LTotalPix + cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat;
      cdsBaiCar.Next;
      Continue;
    End;

    If cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString.Equals('S') Then
    Begin
      cdsBaiCar.Next;

      Continue;
    End;

    If Not cdsBaiCar.FieldByName('MCA_AJUSTE').AsString.Equals('S') Then
    Begin
      Inc(LQuantidade);
      LValorBruto := LValorBruto + cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    End
    Else
      LValorAjustes := LValorAjustes + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    LValorLiquido := LValorLiquido + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    cdsBaicar.Next;
  End;

  edtQtdSel.Text := '( ' + LQuantidade.ToString + ' )';
  edtTotSel.Text := FormatFloat(',0.00;-,0.00', LValorBruto);
  edtAjuSel.Text := FormatFloat(',0.00;-,0.00', LValorAjustes);
  edtTotSelLiq.Text := FormatFloat('#,##0.00;-#,##0.00', LValorLiquido);

  pnlAjustaTotalPix.Visible := LTotalPix > 0;
  edtTotPix.Text := FormatFloat('#,##0.00', LTotalPix);

  TPagSeguroFuncoes.pEnableControls(cdsBaiCar, prcScroll);
end;

procedure TfrmPagSeguroBaixaCartoes.btnRelatorioClick(Sender: TObject);
begin
  inherited;
  If (Not TBitBtnLocked(Sender).Visible) Or (Not TBitBtnLocked(Sender).Enabled) Then
    Exit;

  VS_FuncoesExternas.prcIExecutaRelatorio(529,
                                          36343,
                                          [],
                                          ['AUTINC',
                                          'DESCRI',
                                          'EXBARQCON',
                                          'EXBRESBAN',
                                          'EXBTOTPVE',
                                          'ORDENACAO'],
                                          [
                                           FFiltrosRelatorio.AutoIncrem,
                                           FFiltrosRelatorio.FiltrosDescri,
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.ExibeArquivos, 'Sim', 'Não'),
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoBandeira, 'Sim', 'Não'),
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoPontoDeVenda, 'Sim', 'Não'),
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 1, 'Data de Vencimento',
                                                                 TPagSeguroFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 2, 'Número RV',
                                                                                       'Data da Venda'))
                                          ],
                                          nil,
                                          nil,
                                          True);
end;

function TfrmPagSeguroBaixaCartoes.ApenasBaixaDeTransferencias: Boolean;
Var
  LSequenciais: TSequenciaisBaixaCartao;
  strFilAnt: String;
begin
  Result := False;

  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  strFilAnt := cdsBaiCar.Filter;

  try
    cdsBaiCar.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' AND REGISTROPIXCARTAO<>''S'' ';

    If Not cdsBaiCar.IsEmpty Then
      Exit;

    cdsBaiCar.Filter := 'MCA_MARDES=''M'' AND REGISTROPIXCARTAO<>''S'' ';

    If cdsBaiCar.Locate('REGISTROTRANSFERENCIA', 'S', []) Then
    Begin
      Result := True;
      LSequenciais := Nil;
      Try
        If TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'O período selecionado possui apenas registros de transferências para serem lançados.' + #13 +
                                                    'Deseja continuar com os lançamentos?', ['&Sim', '&Não'], 2) = 1 Then
        Begin
          LSequenciais := TSequenciaisBaixaCartao.Create;

          Try
            Inc64(LSequenciais.intSeqLan, cdsBaiCar.RecordCount * 2);
            LSequenciais.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, LSequenciais.intSeqLan), 4, 14).ToInt64;
            LSequenciais.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(LSequenciais.intSeqLan).ToInt64;

            VS_FuncoesExternas.fIStartTransaction;
            TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                      objConcil.NomeConciliacao,
                                                      LSequenciais);

            TBaixaCartoes.MarcarComoConciliado(objConcil,
                                               cdsBaiCar);

            VS_FuncoesExternas.fICommit;

            TPagSeguroFuncoes.fMensagem('AVISO', 'Lançamentos de transferências realizados com sucesso.', ['&Ok']);
          Except
            On E: Exception Do
            Begin
              VS_FuncoesExternas.fIRollBack;
              VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao gravar as transferências.' + #13 +
                             'Erro gerado: ' + E.Message, '[TfrmBaixaCartoes.ApenasBaixaDeTransferencias]');
            End;
          End;
        End;
      Finally
        blnFecharFormPai := True;

        If Assigned(LSequenciais) Then
          FreeAndNil(LSequenciais);
      End;
    End;
  Finally
    cdsBaiCar.Filter := strFilAnt;
  end;
end;

procedure TfrmPagSeguroBaixaCartoes.btnAjuValClick(Sender: TObject);
  Var
    fltValDig: Double;
    blnConfir: Boolean;
    prcScroll: TprcScroll;
    frmDigValor : TfrmDigValor;

    LTextoLiberacao: TStringList;

    LRegistroAlterado: Integer;
begin
  inherited;
  If (Not TBitBtnLocked(Sender).Visible) Or (Not TBitBtnLocked(Sender).Enabled) Then
    Exit;

  If (not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Or (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'S') or (fRegistroInformativoPix) Then
  Begin
    TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'Nenhum cartão válido selecionado!', ['&Ok']);
    Exit;
  End;

  Try
    TPagSeguroFuncoes.pCriarFormularios(TfrmDigValor, frmDigValor);
    frmDigValor.blnPermiteZero      := False;
    frmDigValor.blnPermiteMenorZero := False;
    frmDigValor.blnConciliacao      := True;
    frmDigValor.Caption             := 'Digite o valor a ser ajustado';
    frmDigValor.ShowModal;

    fltValDig := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(frmDigValor.edtValor.Text), 0,
                                      TPagSeguroFuncoes.fStrToFloat(frmDigValor.edtValor.Text) *
                                      TPagSeguroFuncoes.IIF(frmDigValor.cmbTipVal.ItemIndex = 0, 1, -1));

    blnConfir := (fltValDig <> 0) And (frmDigValor.ModalResult = mrOK) ;
  Finally
    FreeAndNil(frmDigValor);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;

  If Not blnConfir Then
    Exit;

  //Cancela se digitar um valor maior ou igual que o valor sem taxa (bruto)
  If TPagSeguroFuncoes.fFormataFloat(fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat, 2) > TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) Then
  Begin
    TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'O valor recebido não pode ser maior que o valor sem taxa do cartão.', ['&Ok']);
    Exit;
  End;

  If TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALREC').AsFloat + fltValDig, 2) <= 0 Then
  Begin
    TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'O valor recebido não pode ser menor ou igual a zero. Verifique o valor ajustado.', ['&OK']);
    Exit;
  End;

  If (Not VS_FuncoesExternas.fIVerificaAcessoSistema('CARAJUVALCON', VS_FuncoesExternas.fIRetOperadorLogado)) Then
  Begin
    LTextoLiberacao := TStringList.Create;

    Try
      LTextoLiberacao.Add('CONCILIAÇÃO DE CARTÕES - AJUSTE DE VALOR');
      LTextoLiberacao.Add('');
      LTextoLiberacao.Add('Totais da Conciliação: ' + objConcil.NomeConciliacao);
      LTextoLiberacao.Add('Data de recebimento: ' + FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime));
      LTextoLiberacao.Add('Valor total bruto: ' + FormatFloat(',0.00', TPagSeguroFuncoes.fStrToFloat(edtTotSel.Text)));
      LTextoLiberacao.Add('Valor total líquido: ' + FormatFloat(',0.00', TPagSeguroFuncoes.fStrToFloat(edtTotSelLiq.Text)));
      LTextoLiberacao.Add('Valor total líquido após ajuste: ' + FormatFloat(',0.00', fltValDig + TPagSeguroFuncoes.fStrToFloat(edtTotSelLiq.Text)));
      LTextoLiberacao.Add('');

      LTextoLiberacao.Add('--------------------------------------------------------------------------------------------------------------------------------------------');
      LTextoLiberacao.Add('| NUM. LIBERAÇÃO | NSU               | EMP. | NUM. NOTA            | DT.CAD.  | DT.VEN   | VALOR BRUTO  | VALOR LIQ. ATUAL |  VALOR AJUST. |');
      LTextoLiberacao.Add(' -------------------------------------------------------------------------------------------------------------------------------------------');
      LTextoLiberacao.Add(Concat('| ',
                                 LeftStr(TPagSeguroFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_NUMCCD').AsString, 15), 15),
                                 '| ',
                                 LeftStr(TPagSeguroFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_NUMNSU').AsString, 17), 17),
                                 ' | ',
                                 LeftStr(TPagSeguroFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_CODEMP').AsString, 4), 4),
                                 ' | ',
                                 LeftStr(TPagSeguroFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_NUMNOT').AsString, 21), 21),
                                 '| ',
                                 FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime),
                                 ' | ',
                                 FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime),
                                 ' | ',
                                 TPagSeguroFuncoes.fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat), 12),
                                 ' | ',
                                 TPagSeguroFuncoes.fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALREC').AsFloat), 16),
                                 ' | ',
                                 TPagSeguroFuncoes.fPadL(FormatFloat(',0.00', fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat), 13),
                                 ' |'));
      LTextoLiberacao.Add('--------------------------------------------------------------------------------------------------------------------------------------------');

      If Not VS_FuncoesExternas.fIPedirLiberacao('CARAJUVALCON',
                                                 'Permitir ajustar valor recebido do cartão na conciliação.',
                                                 LTextoLiberacao.Text) Then
        Exit;
    Finally
      FreeAndNil(LTextoLiberacao);
    End;
  End;

  cdsBaiCar.Edit;
  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat  := fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat  := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat  := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> 0,
                                                                       (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100,
                                                                       0.000000);
  cdsBaiCar.Post;

  LRegistroAlterado := cdsBaiCar.Recno;

  pCalculaTotalDuplicatas;
  TPagSeguroFuncoes.pDisableControls(cdsBaiCar, prcScroll);
  cdsBaiCar.Recno := LRegistroAlterado;
  pAtualizaDados(cdsBaiCar);
  TPagSeguroFuncoes.pEnableControls(cdsBaiCar, prcScroll);
end;

procedure TfrmPagSeguroBaixaCartoes.btnConfigurarGridClick(Sender: TObject);
  Var
    LConfiguracaoGrids: TfrmConfiguracaoGrids;

    LprcScroll: TprcScroll;
begin
  inherited;

  If Not cdsBaiCar.Active Then
  Begin
    TPagSeguroFuncoes.fMensagem('AVISO', 'É necessario o carregamento dos cartões para utilização da configuração', ['&Ok']);
    Exit;
  End;

  TPagSeguroFuncoes.pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  LprcScroll := cdsBaiCar.AfterScroll;
  Try
    cdsBaiCar.AfterScroll := Nil;
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := fRetornaChaveGrid;
    LConfiguracaoGrids.DatasetCampos := grdDuplicDados.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(grdDuplicDados);
  Finally
    FreeAndNil(LConfiguracaoGrids);
    VS_FuncoesExternas.pITrimAppMemorySize;

    cdsBaiCar.AfterScroll := LprcScroll;
    pAtualizaDados(cdsBaiCar);
  End;
end;

procedure TfrmPagSeguroBaixaCartoes.btnConfirmaClick(Sender: TObject);
  Var
    LRegistroAtual: Integer;

    strPortad,
    strFilAnt : String;
    fltValSel: Double;
    prcScroll: TprcScroll;
    blnConfir: Boolean;
begin
  inherited;

  {***********************************}
  {* VALIDA OS PORTADORES PARA DAR   *}
  {* ANDAMENTO NA BAIXA DOS CARTÕES  *}
  {* PARA CONCILIAÇÃO AUTOMÁTICA     *}
  {********************************AJ*}
  TPagSeguroFuncoes.pDisableControls(cdsBaiCar, prcScroll);
  blnConfir := True;

  strFilAnt := cdsBaiCar.Filter;
  cdsBaiCar.Filter := TPagSeguroFuncoes.IIF(strFilAnt.IsEmpty, '', '(' + strFilAnt + ') AND ') + 'REGISTROPIXCARTAO<>''S'' ';

  cdsBaiCar.Filtered := True;

  try
    If (fVerificaPorCta) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'Para baixa através de conciliação automática, é necessário que todos os cartões selecionados estejam com as configurações de Portadores e Planos de Contas configurados.' + #13 +
                                               'Para cancelamentos/ajustes, o Código do Estabelecimento da operadora do cartão também deve estar vinculado a empresa da baixa.' + #13 +
                                               'Para baixa de antecipações, é necessário que todos os cartões selecionados estejam com a configuração de Planos de Contas para antecipação configurado.',
                                               ['OK'], 1, False, 1, 0, False, 0);
      blnConfir := False;
    End;

    strPortad := fValidaPortadores;
    If (blnConfir) And (Not TPagSeguroFuncoes.fEmptyStr(strPortad)) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'O(s) portador(res) ' + strPortad + ' não possui(em) permissão para realizar baixa!',['&O K']);
      blnConfir := False;
    End;

    If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) and not(fValidaEventos) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'Para baixa através de conciliação automática, é necessário que todos os cartões envolvidos '+
      'estejam com os Centro de Custos configurados. Também é necessário que e os Centro de Custos de cancelamento\ajuste estejam parametrizados '+
      'na empresa correspondente ao ponto de venda.',
      ['OK']);
      blnConfir := False;
    End;

    If ((Not TPagSeguroFuncoes.fEmptyStr(edtTotSel.Text))  And
       (TPagSeguroFuncoes.fStrToFloat(edtTotSel.Text) = 0)) And
      ((Not TPagSeguroFuncoes.fEmptyStr(edtAjuSel.Text))  And
       (TPagSeguroFuncoes.fStrToFloat(edtAjuSel.Text) = 0)) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'Não é possível efetuar a baixa pois não possui valor selecionado.', ['&OK']);
      TPagSeguroFuncoes.pEnableControls(cdsBaiCar, prcScroll);
      Exit;
    End;

    If Not cdsBaiCar.IsEmpty  Then
    Begin
      If blnConfir Then
      Begin
        LRegistroAtual := cdsBaiCar.RecNo;

        blnConfir := cdsBaiCar.Locate('MCA_MARDES', 'M', []);

        cdsBaiCar.RecNo := LRegistroAtual;

        If Not blnConfir Then
        Begin
          TPagSeguroFuncoes.fMensagem('','É necessário selecionar ao menos um registro!',['&O K']);
          blnConfir := False;
        End;
      End;

    End
    Else If blnConfir Then
    Begin
      TPagSeguroFuncoes.fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
      blnConfir := False;
    End;

    //Limite de valor de lançamentos se a tela for chamada pela nova
    //tela de conciliação bancária
    if (blnConfir) And (fltValorBaixa > 0) And (strCodPorFix <> '') then
    begin
      fltValSel := 0;
      if edtTotSelLiq.Text <> '' then
         fltValSel := TPagSeguroFuncoes.fStrToFloat(edtTotSelLiq.Text);

      if  TPagSeguroFuncoes.fFormataFloat(fltValSel, 2) < TPagSeguroFuncoes.fFormataFloat(fltValorBaixa, 2) then
      begin
        TPagSeguroFuncoes.fMensagem('ATENÇÃO!', 'Não é possível efetuar a baixa, o valor é menor que o valor para baixa!' + #13 + #13 +
                                                  'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa), ['&Ok']);
        blnConfir := False;
      end;
    end;

    If (blnConfir) And (TBaixaCartoes.VerificaSeHaCartoesBaixadosAntesDaBaixa(cdsBaiCar)) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO!', 'Existem cartões marcados que foram baixados por outro usuário. Realize a pesquisa novamente para efetuar a baixa desses cartões!', ['&OK']);
      blnConfir := False;
    End;

    If (blnConfir) And
       (((Not TPagSeguroFuncoes.fEmptyStr(edtTotSel.Text))  And
         (TPagSeguroFuncoes.fStrToFloat(edtTotSel.Text) > 0)) Or
        ((Not TPagSeguroFuncoes.fEmptyStr(edtAjuSel.Text))  And
         (TPagSeguroFuncoes.fStrToFloat(edtAjuSel.Text) <> 0))) Then
    Begin
      pManipulaPanels(False);

      TPagSeguroFuncoes.FreeAndNilDatasets(cdsCloneConsulta);
      TBaixaCartoes.LiberaBatchSQL;

      If fBaixaDuplicatas Then
      Begin

        TPagSeguroFuncoes.fMensagem('AVISO', 'Baixa de cartão realizada com sucesso!', ['&O k']);

        btnSairBaixa.Click;

        if (fltValorBaixa > 0) and (strCodPorFix <> '') then
        begin
          btnSairBaixa.Click;
          Exit;
        end;

      End;
      pManipulaPanels(True);
      TPagSeguroFuncoes.pEnableControls(cdsBaiCar, prcScroll);
      pSetFocus(grdDuplic);
    End
    Else
      TPagSeguroFuncoes.pEnableControls(cdsBaiCar, prcScroll);
  Finally
    cdsBaiCar.Filter   := strFilAnt;
    cdsBaiCar.Filtered := Not strFilAnt.IsEmpty;
  End;
end;

function TfrmPagSeguroBaixaCartoes.fGravaCartoes(pgbStatus: TcxProgressBar): Boolean;
  Var
    intMax       : Integer;
    strNumDup    : String;
    strHistor    : String;
    blnConfirma  : Boolean;
    cdsAux       : TUniClientDataSet;
    objSequencias: TSequenciaisBaixaCartao;

    LValorTotalTaxa,
    LValorCredito,
    LValorTotalCtp: Double;

    LSeqLanFrete,
    LSeqLanAjuste,
    LSeqLanCupom: String;

    LListaBanMca: TListaBanMCA;

    LBanMcaDS: TBanMcaDS;

    LExecutaScripts: TUniQuery;
begin
  LListaBanMca := Nil;
  LBanMcaDS := Nil;
  cdsAux := Nil;
  LExecutaScripts := Nil;
  objSequencias := Nil;
  Try
    Try
      cdsAux := TPagSeguroFuncoes.CriarClientDataSet(cdsBaiCar);

      cdsAux.DisableControls;
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N') + ' AND REGISTROPIXCARTAO = ' + QuotedStr('N');
      cdsAux.Filtered := True;
      intMax := cdsAux.RecordCount;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := intMax;
      blnConfirma := True;
      TPagSeguroFuncoes.pProcessMessages;

      LSeqLanFrete := EmptyStr;
      LSeqLanAjuste := EmptyStr;
      LSeqLanCupom := EmptyStr;

      VS_FuncoesExternas.fIStartTransaction;
      intCtpCon := VS_FuncoesExternas.fIRetCtpCon;
      VS_FuncoesExternas.fICommit;

      pCarregaArrAjustes;

      objSequencias := TBaixaCartoes.RetornaSequenciaisParaBaixaAnalitica(cdsAux,
                                                                          False,
                                                                          Not TPagSeguroFuncoes.fEmptyStr(strPorBad),
                                                                          False,
                                                                          Length(arrBaiSinDeb));
      objSequencias.SequencialControleBaixaPagar := intCtpCon;
      objSequencias.NumeroDocumentoBaixa := strNumDoc;

      strHistor := strHisDoc;

      {************************************}
      {* GRAVA OS LANÇAMENTOS DOS AJUSTES *}
      {*********************************AJ*}
      If (Length(arrBaiSinDeb) > 0) Then
      Begin
        TBaixaCartoes.GravaMovBanAjustes(arrBaiSinDeb, objSequencias.intSeqLan, objSequencias.intContadorAutIncMovBan);
        TBaixaCartoes.GravaCadPagAjustes(arrBaiSinDeb, objSequencias.intSequencialCadPag, objSequencias.intContadorAutIncCadPag);

        Inc64(objSequencias.intSeqLan, Length(arrBaiSinDeb));
        Inc64(objSequencias.intSequencialCadPag, Length(arrBaiSinDeb));
        Inc64(objSequencias.intContadorAutIncMovBan, Length(arrBaiSinDeb));
        Inc64(objSequencias.intContadorAutIncCadPag, Length(arrBaiSinDeb));
      End;

      pCarregaArrayNegociacao;
      If Length(FArrayNegociacao) > 0 Then
      Begin
        TBaixaCartoes.GravaMovBanAjustes(FArrayNegociacao);
        TBaixaCartoes.GravaCadPagAjustes(FArrayNegociacao);
      End;

      While Not cdsAux.Eof Do
      Begin
        TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);

        If cdsAux.FieldByName('MCA_MARDES').AsString = 'M' Then
        Begin
          If Not TPagSeguroFuncoes.fEmptyStr(cdsAux.FieldByName('HISTORICO_BAIXA').AsString) Then
          Begin
            If (Pos(cdsAux.FieldByName('HISTORICO_BAIXA').AsString,strHistor) <= 0) Then
              strHistor := cdsAux.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHistor;

            If (Pos(cdsAux.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
              strHisDoc := cdsAux.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
          End;

          If TPagSeguroFuncoes.fEmptyStr(strHistor) Then
            strHisDoc := 'Rec. ' + cdsAux.FieldByName('CAR_DESCAR').AsString;

          If Assigned(LListaBanMca) Then
            FreeAndNil(LListaBanMca);
          If Assigned(LBanMcaDS) Then
            FreeAndNil(LBanMcaDS);

          LBanMcaDS := TBanMcaDS.Create;
          LBanMcaDS.strNumDup := cdsAux.FieldByName('NRODUP').AsString;
          LBanMcaDS.strParcel := cdsAux.FieldByName('PARDUP').AsString;
          LBanMcaDS.strCodEmp := cdsAux.FieldByName('MCA_CODEMP').AsString;
          LBanMcaDS.strCodCli := cdsAux.FieldByName('MCA_CODCLI').AsString;
          LBanMcaDS.strCodCar := cdsAux.FieldByName('MCA_CODCAR').AsString;
          LBanMcaDS.strHist01 := cdsAux.FieldByName('MCA_HIST01').AsString;
          LBanMcaDS.strHist02 := cdsAux.FieldByName('MCA_HIST02').AsString;
          LBanMcaDS.strNumCCD := cdsAux.FieldByName('MCA_NUMCCD').AsString;
          LBanMcaDS.strNumNsu := cdsAux.FieldByName('MCA_NUMNSU').AsString;
          LBanMcaDS.fltValSta := cdsAux.FieldByName('MCA_VALSTA').AsFloat;
          LBanMcaDS.fltValTax := cdsAux.FieldByName('MCA_VALTAX').AsFloat;
          LBanMcaDS.fltValRec := cdsAux.FieldByName('MCA_VALREC').AsFloat;
          LBanMcaDS.fltFreMkt := cdsAux.FieldByName('FRETE_MARKETPLACE').AsFloat;
          LBanMcaDS.fltValAju := cdsAux.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
          LBanMcaDS.fltCupMkt := cdsAux.FieldByName('CUPOM_MARKETPLACE').AsFloat;
          LBanMcaDS.strIdenti := 'VALSTA';
          LBanMcaDS.strAutInc := TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

          Inc64(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create(False);
          LListaBanMca.Add(LBanMcaDS);

          LValorCredito := cdsAux.FieldByName('MCA_VALSTA').AsFloat;

          {*****************************************}
          {* GRAVA MOVBAN DO CARTÃO                *}
          {**************************************MV*}
          strSeqLanCre  := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTABAI').AsString,  // Centro de Custo
                                                         cdsAux.FieldByName('CAR_PORBAI').AsString,  // Portador
                                                         VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                         cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                         TPagSeguroFuncoes.fTime(),                              // Hora do Lançamento
                                                         strNumDoc,                           // Documento
                                                         'C',                                  // Credito / Debito
                                                         VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                         LValorCredito,                        // Valor Documento
                                                         strHisDoc + ' - Ref.Emp. ' + cdsAux.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                                         '',                                   // Historico 2
                                                         cdsAux.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                         '',                                   // Fornecedor
                                                         '',                                   // Numero da Duplicata
                                                         0,                                    // Sequencial Duplicata
                                                         '',                                   // Parcela da Duplicata
                                                         cdsAux.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                         '',                                   // Série
                                                         cdsAux.FieldByName('CAR_EVECRE').AsString, // Código do Evento
                                                         '',                                   // Documento da Baixa
                                                         0,
                                                         intCtpCon,
                                                         '',
                                                         '',
                                                         objSequencias.intSeqLan.ToString,
                                                         TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                         '',
                                                         '',
                                                         1,
                                                         True,
                                                         LListaBanMca,
                                                         EmptyStr,
                                                         'S',
                                                         EmptyStr,
                                                         EmptyStr,
                                                         TBaixaCartoes.BatchSQL);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanCre));

          If blnConfirma Then
            pAtualizaDataMovimentobancarioMovCar(cdsAux.FieldByName('AUTOINC').AsString, cdsAux.FieldByName('MCA_DTAREC').AsDateTime);

          If blnConfirma And
             (Not TPagSeguroFuncoes.fEmptyStr(cdsAux.FieldByName('CAR_PORBAD').AsString)) Then
          Begin
            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
              arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanCre;
            end;

            LBanMcaDS.strIdenti := 'VALSTA';
            LBanMcaDS.strAutInc := TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

            Inc64(objSequencias.intContadorAutIncBanMca);

            {*****************************************}
            {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
            {**************************************MV*}
            strSeqLan   := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTABAD').AsString,  // Centro de Custo
                                                         cdsAux.FieldByName('CAR_PORBAD').AsString,  // Portador
                                                         VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                         cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                         TPagSeguroFuncoes.fTime(),                              // Hora do Lançamento
                                                         strNumDoc,                            // Documento
                                                         'D',                                  // Credito / Debito
                                                         VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                         cdsAux.FieldByName('MCA_VALSTA').AsFloat +
                                                             Abs(cdsAux.FieldByName('CUPOM_MARKETPLACE').AsFloat),    // Valor Documento
                                                         strHisDoc + ' - Ref.Emp. ' + cdsAux.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                                         '',                                   // Historico 2
                                                         cdsAux.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                         '',                                   // Fornecedor
                                                         '',                                   // Numero da Duplicata
                                                         0,                                    // Sequencial Duplicata
                                                         '',                                   // Parcela da Duplicata
                                                         cdsAux.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                         '',                                   // Série
                                                         cdsAux.FieldByName('CAR_EVEDEB').AsString,  // Codigo do Evento
                                                         '',                                   // Documento da Baixa
                                                         0,
                                                         intCtpCon,
                                                         '',
                                                         '',
                                                         objSequencias.intSeqLan.ToString,
                                                         TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                         '',
                                                         '',
                                                         1,
                                                         True,
                                                         LListaBanMca,
                                                         EmptyStr,
                                                         'S',
                                                         EmptyStr,
                                                         EmptyStr,
                                                         TBaixaCartoes.BatchSQL);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLan));
          End;

          {************************************}
          {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
          {*********************************JU*}

          If (cdsAux.FieldByName('MCA_VALTAX').Value <> 0) And (blnConfirma) Then
          Begin
            LBanMcaDS.strIdenti := 'VALTAX';
            LBanMcaDS.strAutInc := TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

            Inc64(objSequencias.intContadorAutIncBanMca);

            LValorTotalTaxa := TPagSeguroFuncoes.fFormataFloat(cdsAux.FieldByName('MCA_VALTAX').AsFloat -
                                                              cdsAux.FieldByName('MCA_ANTTAX').AsFloat, 2);

            {*****************************************}
            {* GRAVA MOVBAN DA TAXA                  *}
            {**************************************MV*}
            strSeqLanTax := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTATAX').AsString,  // Centro de Custo
                                                          cdsAux.FieldByName('CAR_PORTAX').AsString,  // Portador
                                                          VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                          cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                          TPagSeguroFuncoes.fTime(),                              // Hora do Lançamento
                                                          strNumDoc,                            // Documento
                                                          'D',                                  // Credito / Debito
                                                          VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                          LValorTotalTaxa,                      // Valor Documento
                                                          TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
                                                              strHisDoc + ' - Ref.Emp. ' + cdsAux.FieldByName('MCA_CODEMP').AsString),// Historico 1
                                                          '',                                   // Historico 2
                                                          cdsAux.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                          cdsAux.FieldByName('CAR_FORTAX').AsString,  // Fornecedor
                                                          '',                                   // Numero da Duplicata
                                                          0,                                    // Sequencial Duplicata
                                                          '',                                   // Parcela da Duplicata
                                                          cdsAux.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                          '',                                   // Série
                                                          cdsAux.FieldByName('CAR_EVETAX').AsString,  // Código do Evento
                                                          '',
                                                          0,
                                                          intCtpCon,
                                                          '',
                                                          '',
                                                          objSequencias.intSeqLan.ToString,
                                                          TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                          '',
                                                          '',
                                                          1,
                                                          True,
                                                          LListaBanMca,
                                                          EmptyStr,
                                                          'S',
                                                          EmptyStr,
                                                          EmptyStr,
                                                          TBaixaCartoes.BatchSQL);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanTax));

            {************************}
            {* GRAVA CADPAG DA TAXA *}
            {*********************AF*}
            If (blnConfirma) Then
            Begin
              if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
              begin
                SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
                arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
              end;

              strNumDup := 'G' + TPagSeguroFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

              LValorTotalCtp := LValorTotalTaxa;

              blnConfirma := TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                                           'INCLUSAO DA TAXA - CARTOES BX_ANA',
                                                           cdsAux.FieldByName('CAR_FORTAX').AsString,
                                                           strNumDup,
                                                           'A',
                                                           cdsAux.FieldByName('MCA_CODEMP').AsString,
                                                           cdsAux.FieldByName('CAR_CTATAX').AsString,
                                                           'CRT',
                                                           0,
                                                           cdsAux.FieldByName('MCA_DTAREC').Value,
                                                           cdsAux.FieldByName('MCA_DTAREC').AsDateTime,
                                                           0,
                                                           LValorTotalCtp,
                                                           'N',
                                                           'N',
                                                           'N',
                                                           TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
                                                                     strHisDoc + ' - Ref.Emp. ' + cdsAux.FieldByName('MCA_CODEMP').AsString),
                                                           '',
                                                           'Pag. de Taxas Ref. Aos Cartões',
                                                           cdsAux.FieldByName('CAR_PORTAX').AsString,
                                                           cdsAux.FieldByName('CAR_CTATAX').AsString,
                                                           strSeqLanTax,
                                                           VS_FuncoesExternas.fIRetOperadorLogado,
                                                           cdsAux.FieldByName('MCA_DTAREC').Value,
                                                           LValorTotalCtp,
                                                           0,
                                                           0,
                                                           VS_FuncoesExternas.fIRetEmpresaLogada,
                                                           cdsAux.FieldByName('CAR_EVETAX').AsString,
                                                           '',
                                                           cdsAux.FieldByName('CAR_PORTAX').AsString,
                                                           '',
                                                           0.0,
                                                           0.0,
                                                           intCtpCon,
                                                           False,
                                                           0,
                                                           '',
                                                           0,
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           LValorTotalCtp,
                                                           0,
                                                           0,
                                                           0,
                                                           '',
                                                           0,
                                                           0,
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '0',
                                                           '',
                                                           '',
                                                           TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                           EmptyStr,
                                                           'N',
                                                           EmptyStr,
                                                           EmptyStr,
                                                           EmptyStr,
                                                           EmptyStr,
                                                           0,
                                                           EmptyStr,
                                                           0,
                                                           EmptyStr,
                                                           0,
                                                           0,
                                                           0,
                                                           0,
                                                           EmptyStr,
                                                           EmptyStr,
                                                           'N',
                                                           EmptyStr,
                                                           EmptyStr,
                                                           TBaixaCartoes.BatchSQL);

              Inc64(objSequencias.intContadorAutIncCadPag);
              Inc64(objSequencias.intContadorAutIncLogCtp);
              Inc64(objSequencias.intSequencialCadPag);
            End;
          End;

          {******************************}
          {* GRAVA TAXAS DE ANTECIPAÇÃO *}
          {***************************AJ*}
          If (cdsAux.FieldByName('MCA_ANTTAX').Value <> 0) And (blnConfirma) Then
          Begin
            LBanMcaDS.strIdenti := 'ANTTAX';
            LBanMcaDS.strAutInc := TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

            Inc64(objSequencias.intContadorAutIncBanMca);

            {*****************************************}
            {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO   *}
            {**************************************AJ*}
            strSeqLanAnt := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTAANT').AsString,  // Centro de Custo
                                                          cdsAux.FieldByName('CAR_PORTAX').AsString,  // Portador
                                                          VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                          cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                          TPagSeguroFuncoes.fTime(),                              // Hora do Lançamento
                                                          strNumDoc,                            // Documento
                                                          'D',                                  // Credito / Debito
                                                          VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                          cdsAux.FieldByName('MCA_ANTTAX').AsFloat,    // Valor Documento
                                                          TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(strHistor), 'Pag. de Tx Antecip. Ref. Aos Cartões',
                                                              'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + cdsAux.FieldByName('MCA_CODEMP').AsString),// Historico 1
                                                          '',                                   // Historico 2
                                                          cdsAux.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                          cdsAux.FieldByName('CAR_FORTAX').AsString,  // Fornecedor
                                                          '',                                   // Numero da Duplicata
                                                          0,                                    // Sequencial Duplicata
                                                          '',                                   // Parcela da Duplicata
                                                          cdsAux.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                          '',                                   // Série
                                                          '',                                   // Código do Evento
                                                          '',
                                                          0,
                                                          intCtpCon,
                                                          '',
                                                          '',
                                                          objSequencias.intSeqLan.ToString,
                                                          TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                          '',
                                                          '',
                                                          1,
                                                          True,
                                                          LListaBanMca,
                                                          EmptyStr,
                                                          'S',
                                                          EmptyStr,
                                                          EmptyStr,
                                                          TBaixaCartoes.BatchSQL);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanAnt));

            {***************************************}
            {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
            {************************************AJ*}
            If (blnConfirma) Then
            Begin
              if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
              begin
                SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
                arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
              end;

              strNumDup := 'G' + TPagSeguroFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

              blnConfirma := TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                                           'INCLUSAO DA TAXA - CARTOES BX_ANA',
                                                           cdsAux.FieldByName('CAR_FORTAX').AsString,
                                                           strNumDup,
                                                           'A',
                                                           cdsAux.FieldByName('MCA_CODEMP').AsString,
                                                           cdsAux.FieldByName('CAR_CTAANT').AsString,
                                                           'CRT',
                                                           0,
                                                           cdsAux.FieldByName('MCA_DTAREC').Value,
                                                           cdsAux.FieldByName('MCA_DTAREC').AsDateTime,
                                                           0,
                                                           cdsAux.FieldByName('MCA_ANTTAX').AsFloat,
                                                           'N',
                                                           'N',
                                                           'N',
                                                           TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(strHistor), 'Pag. de Tx Atecip. Ref. Aos Cartões',
                                                                     strHisDoc + ' - Ref.Emp. ' + cdsAux.FieldByName('MCA_CODEMP').AsString),
                                                           '',
                                                           'Pag. de Tx Antecip. Ref. Aos Cartões',
                                                           cdsAux.FieldByName('CAR_PORTAX').AsString,
                                                           cdsAux.FieldByName('CAR_CTAANT').AsString,
                                                           strSeqLanAnt,
                                                           VS_FuncoesExternas.fIRetOperadorLogado,
                                                           cdsAux.FieldByName('MCA_DTAREC').Value,
                                                           cdsAux.FieldByName('MCA_ANTTAX').AsFloat,
                                                           0,
                                                           0,
                                                           VS_FuncoesExternas.fIRetEmpresaLogada,
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           0.0,
                                                           0.0,
                                                           intCtpCon,
                                                           False,
                                                           0,
                                                           '',
                                                           0,
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           cdsAux.FieldByName('MCA_ANTTAX').AsFloat,
                                                           0,
                                                           0,
                                                           0,
                                                           '',
                                                           0,
                                                           0,
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '',
                                                           '0',
                                                           '',
                                                           '',
                                                           TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                           EmptyStr,
                                                           'N',
                                                           EmptyStr,
                                                           EmptyStr,
                                                           EmptyStr,
                                                           EmptyStr,
                                                           0,
                                                           EmptyStr,
                                                           0,
                                                           EmptyStr,
                                                           0,
                                                           0,
                                                           0,
                                                           0,
                                                           EmptyStr,
                                                           EmptyStr,
                                                           'N',
                                                           EmptyStr,
                                                           EmptyStr,
                                                           TBaixaCartoes.BatchSQL);

              Inc64(objSequencias.intContadorAutIncCadPag);
              Inc64(objSequencias.intContadorAutIncLogCtp);
              Inc64(objSequencias.intSequencialCadPag);
            End;
          End;

          If blnConfirma Then
          Begin

            {*****************************************}
            {* BAIXA UM REGISTRO                     *}
            {**************************************MV*}
            blnConfirma := TLibCartoesMovCar.BaixaCartao(Self.Name,
                                                         'BAIXA DE CARTÕES (' + Self.Caption + ')',
                                                         cdsAux.FieldByName('AUTOINC').AsString,
                                                         cdsAux.FieldByName('NRODUP').AsString,
                                                         cdsAux.FieldByName('PARDUP').AsString,
                                                         cdsAux.FieldByName('MCA_CODCLI').AsString,
                                                         cdsAux.FieldByName('MCA_CODEMP').AsString,
                                                         cdsAux.FieldByName('MCA_DTAREC').Value,
                                                         cdsAux.FieldByName('MCA_VALREC').AsFloat,
                                                         VS_FuncoesExternas.fIRetOperadorLogado,
                                                         strHisDoc,
                                                         cdsAux.FieldByName('CAR_PORBAI').AsString,
                                                         cdsAux.FieldByName('CAR_CTABAI').AsString,
                                                         strSeqLanCre,
                                                         cdsAux.FieldByName('CAR_PORTAX').AsString,
                                                         cdsAux.FieldByName('CAR_CTATAX').AsString,
                                                         strSeqLanTax,
                                                         cdsAux.FieldByName('CAR_FORTAX').AsString,
                                                         cdsAux.FieldByName('CAR_CTABAD').AsString,
                                                         cdsAux.FieldByName('CAR_PORBAD').AsString,
                                                         strSeqLan,
                                                         cdsAux.FieldByName('MCA_CHACON').AsString,
                                                         cdsAux.FieldByName('CAR_EVEDEB').AsString,
                                                         TPagSeguroFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                              '', cdsAux.FieldByName('CAR_CTAANT').AsString),
                                                         TPagSeguroFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                              '', strSeqLanAnt),
                                                         TPagSeguroFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                              0, cdsAux.FieldByName('MCA_ANTTAX').AsFloat),
                                                         TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                         cdsAux.FieldByName('CAR_EVECRE').AsString,
                                                         cdsAux.FieldByName('CAR_EVETAX').AsString,
                                                         cdsAux.FieldByName('FRETE_MARKETPLACE').AsFloat,
                                                         cdsAux.FieldByName('AJUSTE_MARKETPLACE').AsFloat,
                                                         cdsAux.FieldByName('MCA_VALTAX').AsFloat,
                                                         cdsAux.FieldByName('CUPOM_MARKETPLACE').AsFloat,
                                                         cdsAux.FieldByName('ALTERAR_BRUTO').AsString.Equals('S'),
                                                         cdsAux.FieldByName('MCA_VALSTA').AsFloat,
                                                         LSeqLanFrete,
                                                         LSeqLanAjuste,
                                                         LSeqLanCupom,
                                                         TBaixaCartoes.BatchSQL,
                                                         cdsAux.FieldByName('MCA_DTAREC').AsDateTime);

            Inc64(objSequencias.intContadorAutIncLogMca);
          End;

        End;

        If Not blnConfirma Then
          Break;

          cdsAux.Next;
      End;

      If blnConfirma Then
      Begin
        VS_FuncoesExternas.fIStartTransaction;

        TBaixaCartoes.BatchSQL.OnProgress :=
          procedure(Sender: TObject; ALote, ATotalLotes: Integer)
          begin
            if Not Assigned(pgbStatus) then
              Exit;

            pgbStatus.Position := ALote;
            pgbStatus.Properties.Max := ATotalLotes;
            TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando baixa.');
          end;

        LExecutaScripts := VS_FuncoesExternas.fICriaQuery;
        blnConfirma := TBaixaCartoes.BatchSQL.Execute(LExecutaScripts, True);

        //Req: 449872 - transferências gravam direto (fora do lote), na mesma transação da baixa
        If blnConfirma Then
          TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                    objConcil.NomeConciliacao,
                                                    objSequencias);

        If blnConfirma Then
        Begin
          VS_FuncoesExternas.fICommit;

          pgbStatus.Visible := False;
          TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Finalizando baixa.');

          VS_FuncoesExternas.fIStartTransaction;
          TBaixaCartoes.MarcarComoConciliado(objConcil,
                                             cdsBaiCar);
          VS_FuncoesExternas.fICommit;
        End;
      End;

      If Not blnConfirma Then
        Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!')
      Else
        blnConfirmaBaixa := True;
    Except
      On E: Exception Do
      Begin
        If TPagSeguroFuncoes.EstaEmTransacao Then
          VS_FuncoesExternas.fIRollBack;

        blnConfirmaBaixa := False;
        Result := false;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoes]');
        Exit;
      End;
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(cdsAux);

    If Assigned(LListaBanMca) Then
      FreeAndNil(LListaBanMca);

    If Assigned(LBanMcaDS) Then
      FreeAndNil(LBanMcaDS);

    If Assigned(objSequencias) Then
      FreeAndnIl(objSequencias);

    TPagSeguroFuncoes.FreeAndNilDatasets(LExecutaScripts);
  End;

  Result := True;
end;

{*****************************************}
{* BAIXA AS DUPLICATAS SELECIONADAS      *}
{**************************************MV*}
function TfrmPagSeguroBaixaCartoes.fBaixaDuplicatas: Boolean;
  Var
    blnBaiAna   : Boolean;
    blnConfirma : Boolean;
    Key         : Char;

    frmLibCartoesBaixaCtcAnaSin : TfrmLibCartoesBaixaCtcAnaSin;
begin
  Result       := False;
  blnBaiAna    := VS_FuncoesExternas.fICfgSis('CTC_AS') = 'A';
  strSeqLan    := '';
  strSeqLanTax := '';
  strSeqLanCre := '';

  TLibCartoesMovBan.CarregaDatasetPortadores;

  {***************************************}
  {* VERIFICA SE POSSUI INCONSISTÊNCIAS  *}
  {* DE CONCILIAÇÃO PARA PEDIR O DIREITO *}
  {* DE ACESSO PARA CONTINUAR A BAIXA    *}
  {************************************AJ*}
  If (blnInconsist) Then
  Begin
    If Not VS_FuncoesExternas.fIPedirLiberacao('CARBAIINC',
                                               'Realizar a baixa de cartões de crédito com inconsistências',
                                               'Permitir realizar a baixa de cartões de crédito com inconsistências.') Then
      Exit;
  End;

  {*****************************************}
  {* CHAMA A TELA DE BAIXA                 *}
  {**************************************MV*}
  Try
    cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE=' + QuotedStr('N') + ' AND REGISTROPIXCARTAO<>' + QuotedStr('S');
    cdsBaiCar.Filtered := True;

    TPagSeguroFuncoes.FreeAndNilDatasets(cdsCloneConsulta);
    cdsCloneConsulta := TPagSeguroFuncoes.CriarClientDataSet(cdsBaiCar);

    TPagSeguroFuncoes.pCriarFormularios(TfrmLibCartoesBaixaCtcAnaSin, frmLibCartoesBaixaCtcAnaSin);
    Try
      frmLibCartoesBaixaCtcAnaSin.blnBaiAna    := blnBaiAna;
      frmLibCartoesBaixaCtcAnaSin.blnZeraTx    := False;
      frmLibCartoesBaixaCtcAnaSin.dtaMaxDta    := TBaixaCartoes.CalculaDataMinimaParaPortador(cdsBaiCar);
      frmLibCartoesBaixaCtcAnaSin.strCodEmp    := VS_FuncoesExternas.fIRetEmpresaLogada;
      frmLibCartoesBaixaCtcAnaSin.blnConcil    := True;
      frmLibCartoesBaixaCtcAnaSin.blnVemBxCart := True;

      frmLibCartoesBaixaCtcAnaSin.mskDtaDoc.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.edtPorCar.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.fraPlanoDeContasCar.MskCodCta.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.edtPorTax.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.edtCodFor.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.fraPlanoDeContasTax.MskCodCta.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.edtPorDeb.Enabled := False;
      frmLibCartoesBaixaCtcAnaSin.fraPlanoDeContasDeb.MskCodCta.Enabled := False;

      if strCodPorFix <> '' then
      begin
        frmLibCartoesBaixaCtcAnaSin.strPortadorExtrato := strCodPorFix;
        frmLibCartoesBaixaCtcAnaSin.edtPorCar.Text := strCodPorFix;
        Key := #13;
        frmLibCartoesBaixaCtcAnaSin.edtPorCarKeyPress(nil, Key);
        frmLibCartoesBaixaCtcAnaSin.edtPorCar.Enabled := False;
        frmLibCartoesBaixaCtcAnaSin.mskDtaDoc.Date    := dteDtaRecFix;
        frmLibCartoesBaixaCtcAnaSin.mskDtaDoc.Enabled := False;
      end;

      frmLibCartoesBaixaCtcAnaSin.showModal;

      If Not frmLibCartoesBaixaCtcAnaSin.blnConfirma Or Not VerificacoesParaBaixa Then
      Begin
        cdsBaiCar.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
        cdsBaiCar.Filtered := True;
        Exit;
      End;

      strNumDoc := frmLibCartoesBaixaCtcAnaSin.strNumDoc;
      strHisDoc := frmLibCartoesBaixaCtcAnaSin.strHisDoc;

      blnConfirma := frmLibCartoesBaixaCtcAnaSin.blnConfirma;

      If (Not blnBaiAna) And (blnConfirma) Then
      Begin
        dtaDtaDoc := frmLibCartoesBaixaCtcAnaSin.dtaDtaDoc;

        blnConfirma := TBaixaCartoes.ValidaDadosDigitadosBaixaSintetica(cdsCloneConsulta,
                                                                        DateToStr(dtaDtaDoc),
                                                                        strPorCar,
                                                                        strPorTax,
                                                                        strPorBad);
        If Not blnConfirma Then
        Begin
          cdsBaiCar.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
          cdsBaiCar.Filtered := True;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao validar os dados dos cartões. ' + #13 +
                       'Erro gerado: ' + E.Message, '[frmBaixaCartoes.fBaixaDuplicatas]');
      End;
    End;
  Finally
    FreeAndNil(frmLibCartoesBaixaCtcAnaSin);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;

  //FECHAMENTO FINANCEIRO
  //VERIFICA A DATA DA BAIXA DO DOCUMENTO SINTÉTICO
  if dtaDtaDoc > 0 then
  Begin
    if VS_FuncoesExternas.fIFechamentoFinanceiroJaRealizado(VS_FuncoesExternas.fIRetEmpresaLogada, dtaDtaDoc, Self.Name) then
      blnConfirma := False;
  End;

  {*****************************************}
  {* CASO OCORREU UM ERRO, SAI             *}
  {**************************************MV*}
  If Not blnConfirma Then
  Begin
    cdsBaiCar.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    cdsBaiCar.Filtered := True;

    pSetFocus(grdDuplic);
    Exit;
  End;

  {*****************************************}
  {* PROCESSA AS DUPLITAS MARCADAS         *}
  {**************************************MV*}
  TPagSeguroFuncoes.pProcessMessages;
  TBaixaCartoes.LiberaBatchSQL;
  Try
    TBaixaCartoes.BatchSQL := TBatchHelper.CreateBatchSQL();

    cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    cdsBaiCar.First;

    {*******************}
    {* BAIXA SINTÉTICA *}
    {****************AJ*}
    If blnConfirma Then
    Begin
      If Not blnBaiAna  Then
      Begin
        Try
          blnConfirmaBaixa := TPagSeguroFuncoes.ExecutaAguarde(fGravaCartoesSin, 'Aguarde... Processando registros conciliados.');
          blnConfirma := blnConfirmaBaixa;
        Except
          On E: Exception Do
          Begin
            VS_FuncoesExternas.fIRollBack;
            blnConfirma := False;
            VS_FuncoesExternas.pIMensagensErro(E.Message,'[untBaixaCartoes.fGravaCartoesSin]');
          End;
        End;
      End

      {*******************}
      {* BAIXA ANALÍTICA *}
      {*******************}
      Else
      Begin

        Try
          blnConfirmaBaixa := TPagSeguroFuncoes.ExecutaAguarde(fGravaCartoes, 'Aguarde... Processando registros conciliados.');
          blnConfirma := blnConfirmaBaixa;
        Except
          On E: Exception Do
          Begin
            VS_FuncoesExternas.fIRollBack;
            blnConfirma := False;
            VS_FuncoesExternas.pIMensagensErro(E.Message, '[untBaixaCartoes.fGravaCartoes]');
          End;
        End;
      End;

    End;
  Finally
    TBaixaCartoes.LiberaBatchSQL;

    If Assigned(cdsCloneConsulta) Then
      FreeAndNil(cdsCloneConsulta);
  End;

  Result := blnConfirma;
end;

procedure TfrmPagSeguroBaixaCartoes.ExibirPorcentagemTaxaDeAntecipacao;
  Var
    LValorDaAntecipacao: Double;
    LPorcenTaxaAntecipacao : Double;
begin
  LValorDaAntecipacao := 0.00;
  edtPorcentagemTaxaAntecipacao.Text := FormatFloat(',0.000000', LValorDaAntecipacao);

  If Not cdsBaiCar.FieldByName('MCA_ANTTAX').IsNull Then
    LValorDaAntecipacao := cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;

  If (LValorDaAntecipacao > 0) And (TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) > 0) Then
  Begin
    LPorcenTaxaAntecipacao := ((LValorDaAntecipacao / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100);

    edtPorcentagemTaxaAntecipacao.Text := FormatFloat(',0.000000', LPorcenTaxaAntecipacao);

    edtPerCar.Text := FormatFloat(',0.000000',(cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat -  LPorcenTaxaAntecipacao));
  end;

  edtPorcentagemTaxaAntecipacao.Text := Concat(edtPorcentagemTaxaAntecipacao.Text,' %');
End;

function TfrmPagSeguroBaixaCartoes.fGetEmpresaAjuste(ADataset: TUniClientDataset): string;
begin
  Result := ADataset.FieldByName('MCA_CODEMP').AsString;
end;

procedure TfrmPagSeguroBaixaCartoes.pCarregaArrAjustes;
  Var
    strCodEmp: String;
    dtaDtaRec: TDateTime;
    fltValDoc: Double;
    blnVerifi: Boolean;
    strPorBai,
    strCtaBai,
    strTaxaFo,
    strFilAnt,
    strTipAju,
    strEventoCancelamentoAjuste: String;
begin
  TPagSeguroFuncoes.pProcessMessages;
  strFilant := cdsBaiCar.Filter;

  cdsBaiCar.Filter := 'MCA_AJUSTE=''S'' AND REGISTROTRANSFERENCIA=''N'' AND NEGOCIACAO <> ''S'' ';

  cdsBaiCar.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_FORTAX;MCA_VALREC;MCA_EVECAN';
  strCampoFiltro  := '';
  strValorFiltro  := '';
  cdsBaiCar.Filtered := True;
  SetLength(arrBaiSinDeb, 0);

  If cdsBaiCar.RecordCOunt > 0 Then
  Begin
    cdsBaiCar.First;
    strCodEmp                   := fGetEmpresaAjuste(cdsBaiCar);
    dtaDtaRec                   := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
    strPorBai                   := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
    strCtaBai                   := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
    strTaxaFo                   := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
    strEventoCancelamentoAjuste := cdsBaiCar.FieldByName('MCA_EVECAN').AsString;
    fltValDoc                   := 0;
    strTipAju                   := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

    While Not cdsBaiCar.Eof Do
    Begin
      blnVerifi := (fGetEmpresaAjuste(cdsBaiCar) <> strCodEmp) Or
                   (cdsBaiCar.FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                   (cdsBaiCar.FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                   (cdsBaiCar.FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                   (cdsBaiCar.FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                   (cdsBaiCar.FieldByName('MCA_EVECAN').AsString <> strEventoCancelamentoAjuste) Or
                   (TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C') <> strTipAju);

      If blnVerifi Then
      Begin
        SetLength(arrBaiSinDeb, Length(arrBaiSinDeb) + 1);

        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValDoc := fltValDoc;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValTax := 0;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCodEmp := strCodEmp;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].dtaDtaRec := dtaDtaRec;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strPorBai := strPorBai;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCtaBai := strCtaBai;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strForTax := strTaxaFo;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strNumDoc := strNumDoc;

        If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString) Then
        Begin
          If (Pos(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
            strHisDoc := cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
        End;

        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := strHisDoc + ' - Canc./Ajuste Cartões';
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := intCtpCon;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := TPagSeguroFuncoes.IIF(fltValDoc < 0, 'D', 'C');
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;

        strCodEmp                   := fGetEmpresaAjuste(cdsBaiCar);
        dtaDtaRec                   := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
        fltValDoc                   := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
        strPorBai                   := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
        strCtaBai                   := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
        strTaxaFo                   := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
        strEventoCancelamentoAjuste := cdsBaiCar.FieldByName('MCA_EVECAN').AsString;
        strTipAju                   := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
      End
      Else
        fltValDoc := fltValDoc + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

      cdsBaiCar.Next;
    End;

    SetLength(arrBaiSinDeb, Length(arrBaiSinDeb) + 1);

    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValDoc := fltValDoc;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValTax := 0;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCodEmp := strCodEmp;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].dtaDtaRec := dtaDtaRec;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strPorBai := strPorBai;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCtaBai := strCtaBai;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strForTax := strTaxaFo;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strNumDoc := strNumDoc;

    If Not TPagSeguroFuncoes.fEmptyStr(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString) Then
    Begin
      If (Pos(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
        strHisDoc := cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
    End;

    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(strHisDoc),'', strHisDoc + ' - ')+ 'Canc./Ajuste Cartões - Emp. ' + strCodEmp;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := intCtpCon;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := strTipAju;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;
  End;

  cdsBaiCar.Filter := strFilAnt;
end;

procedure TfrmPagSeguroBaixaCartoes.pCarregaArrBaiSinCar;
  Var
    strCodEmp: String;
    dtaDtaRec: TDateTime;

    fltValDoc,
    fltValTax,
    fltValAnt,
    LFreteMarketPlace,
    LAjusteMarketPlace,
    LCupomMarketPlace,
    LSubtrairFrete: Double;

    blnVerifi: Boolean;

    strPorBai,
    strCtaBai,
    strPorDeb,
    strCtaDeb,
    strTaxaPo,
    strTaxaCt,
    strTaxaFo,
    SEventoCredito,
    SEventoTaxa,
    strEvento,
    strCtaAnt,
    strFilAnt,

    LPlanoDeContasFrete,
    LPlanoDeCOntasAjuste,
    LPlanoDeContasCupom: String;

    intQtdCar: Integer;
begin

  TPagSeguroFuncoes.pProcessMessages;
  SetLength(arrBaiSinCar, 0);

  cdsBaiCar.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;'+
                               'CAR_PORBAD;CAR_CTABAD;CAR_EVEDEB;CAR_CTAANT;CAR_EVECRE;CAR_EVETAX';
  strFilAnt := cdsBaiCar.Filter;
  cdsBaiCar.Filter := 'MCA_MARDES=' + QuotedStr('M') + 'AND MCA_AJUSTE=' + QuotedStr('N') + ' AND NEGOCIACAO=''N'' AND REGISTROPIXCARTAO=''N'' ';
  cdsBaiCar.Filtered := True;

  If cdsBaiCar.IsEmpty Then
    Exit;

  cdsBaiCar.First;
  strCodEmp := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
  dtaDtaRec := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
  strPorBai      := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
  strCtaBai      := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
  strPorDeb      := cdsBaiCar.FieldByName('CAR_PORBAD').AsString;
  strCtaDeb      := cdsBaiCar.FieldByName('CAR_CTABAD').AsString;
  strTaxaPo      := cdsBaiCar.FieldByName('CAR_PORTAX').AsString;
  strTaxaCt      := cdsBaiCar.FieldByName('CAR_CTATAX').AsString;
  strTaxaFo      := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
  SEventoCredito := cdsBaiCar.FieldByName('CAR_EVECRE').AsString;
  SEventoTaxa    := cdsBaiCar.FieldByName('CAR_EVETAX').AsString;
  strEvento      := cdsBaiCar.FieldByName('CAR_EVEDEB').AsString;
  strCtaAnt      := cdsBaiCar.FieldByName('CAR_CTAANT').AsString;
  fltValDoc      := 0;
  fltValTax      := 0;
  fltValAnt      := 0;
  intQtdCar      := 0;
  LFreteMarketPlace := 0;
  LAjusteMarketPlace := 0;
  LCupomMarketPlace := 0;
  LSubtrairFrete := 0;

  LPlanoDeContasFrete := cdsBaiCar.FieldByName('CAR_CTAFRE').AsString;
  LPlanoDeContasAjuste := cdsBaiCar.FieldByName('CAR_CTAAJU').AsString;
  LPlanoDeContasCupom := cdsBaiCar.FieldByName('CAR_CTACUP').AsString;

  While Not cdsBaiCar.Eof Do
  Begin
    blnVerifi := (cdsBaiCar.FieldByName('MCA_CODEMP').AsString <> strCodEmp) Or
                 (cdsBaiCar.FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                 (cdsBaiCar.FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                 (cdsBaiCar.FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                 (cdsBaiCar.FieldByName('CAR_PORBAD').AsString <> strPorDeb) Or
                 (cdsBaiCar.FieldByName('CAR_CTABAD').AsString <> strCtaDeb) Or
                 (cdsBaiCar.FieldByName('CAR_PORTAX').AsString <> strTaxaPo) Or
                 (cdsBaiCar.FieldByName('CAR_CTATAX').AsString <> strTaxaCt) Or
                 (cdsBaiCar.FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                 (cdsBaiCar.FieldByName('CAR_EVECRE').AsString <> SEventoCredito) Or
                 (cdsBaiCar.FieldByName('CAR_EVETAX').AsString <> SEventoTaxa) Or
                 (cdsBaiCar.FieldByName('CAR_EVEDEB').AsString <> strEvento) Or
                 (cdsBaiCar.FieldByName('CAR_CTAANT').AsString <> strCtaAnt);

    If blnVerifi Then
    Begin
      SetLength(arrBaiSinCar, Length(arrBaiSinCar) + 1);

      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValDoc        := fltValDoc + Abs(LCupomMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValTax        := fltValTax;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCodEmp        := strCodEmp;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].dtaDtaRec        := dtaDtaRec;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBai        := strPorBai;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBai        := strCtaBai;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoCredito := SEventoCredito;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBad        := strPorDeb;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBad        := strCtaDeb;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorTax        := strTaxaPo;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strForTax        := strTaxaFo;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaTax        := strTaxaCt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoTaxa    := SEventoTaxa;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEveDeb        := strEvento;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaAnt        := strCtaAnt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValAnt        := fltValAnt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].intQtdCar        := intQtdCar;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].FreteMarketPlace := Abs(LFreteMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].AjusteMarketPlace := Abs(LAjusteMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].CupomMarketPlace := Abs(LCupomMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].SubtrairFrete := Abs(LSubtrairFrete);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasFreteMkt := LPlanoDeContasFrete;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasAjusteMkt := LPlanoDeContasAjuste;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasCupomMkt := LPlanoDeContasCupom;

      strCodEmp      := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
      dtaDtaRec      := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
      fltValDoc      := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      fltValTax      := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
      strPorBai      := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
      strCtaBai      := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
      strPorDeb      := cdsBaiCar.FieldByName('CAR_PORBAD').AsString;
      strCtaDeb      := cdsBaiCar.FieldByName('CAR_CTABAD').AsString;
      strTaxaPo      := cdsBaiCar.FieldByName('CAR_PORTAX').AsString;
      strTaxaCt      := cdsBaiCar.FieldByName('CAR_CTATAX').AsString;
      strTaxaFo      := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
      SEventoCredito := cdsBaiCar.FieldByName('CAR_EVECRE').AsString;
      SEventoTaxa    := cdsBaiCar.FieldByName('CAR_EVETAX').AsString;
      strEvento      := cdsBaiCar.FieldByName('CAR_EVEDEB').AsString;
      strCtaAnt      := cdsBaiCar.FieldByName('CAR_CTAANT').AsString;
      fltValAnt      := cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;
      LFreteMarketPlace := cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat;
      LAjusteMarketPlace := cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
      LCupomMarketPlace := cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat;
      LPlanoDeContasFrete := cdsBaiCar.FieldByName('CAR_CTAFRE').AsString;
      LPlanoDeContasAjuste := cdsBaiCar.FieldByName('CAR_CTAAJU').AsString;
      LPlanoDeContasCupom := cdsBaiCar.FieldByName('CAR_CTACUP').AsString;
      LSubtrairFrete := cdsBaiCar.FieldByName('SUBTRAIR_FRETE').AsFloat;
      intQtdCar      := 1;
    End
    Else
    Begin
      fltValDoc := fltValDoc + cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      fltValTax := fltValTax + cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
      fltValAnt := fltValAnt + cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;
      LFreteMarketPlace := LFreteMarketPlace + cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat;
      LAjusteMarketPlace := LAjusteMarketPlace + cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
      LCupomMarketPlace := LCupomMarketPlace + cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat;
      LSubtrairFrete := LSubtrairFrete + cdsBaiCar.FieldByName('SUBTRAIR_FRETE').AsFloat;

      Inc(intQtdCar);
    End;

    cdsBaiCar.Next;
  End;

  SetLength(arrBaiSinCar, Length(arrBaiSinCar) + 1);

  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValDoc        := fltValDoc + Abs(LCupomMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValTax        := fltValTax;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCodEmp        := strCodEmp;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].dtaDtaRec        := dtaDtaRec;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBai        := strPorBai;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBai        := strCtaBai;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBad        := strPorDeb;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBad        := strCtaDeb;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorTax        := strTaxaPo;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strForTax        := strTaxaFo;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaTax        := strTaxaCt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoCredito := SEventoCredito;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoTaxa    := SEventoTaxa;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEveDeb        := strEvento;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaAnt        := strCtaAnt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValAnt        := fltValAnt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].intQtdCar        := intQtdCar;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].FreteMarketPlace := Abs(LFreteMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].AjusteMarketPlace := Abs(LAjusteMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].CupomMarketPlace := Abs(LCupomMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasFreteMkt := LPlanoDeContasFrete;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasAjusteMkt := LPlanoDeContasAjuste;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasCupomMkt := LPlanoDeContasCupom;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].SubtrairFrete := Abs(LSubtrairFrete);

  cdsBaiCar.Filter := strFilAnt;
end;

procedure TfrmPagSeguroBaixaCartoes.FormShow(Sender: TObject);
begin
  inherited;
  dtaDtaPag := 0;
  blnAcesso := VS_FuncoesExternas.fIVerificaAcessoSistema('CARBAITODOS');

  pnlMarketPlace.Left := 0;

  pAbreConciliacao;

  btnConfigurarGrid.Visible := TPagSeguroFuncoes.fTabelaExiste('CFGCOL_GRD');
end;

function TfrmPagSeguroBaixaCartoes.fGravaCartoesSin(pgbStatus: TcxProgressBar = Nil) : Boolean;
  Var
    blnConfirma,
    blnCadPag    : Boolean;
    strNumDup    : String;
    intCont      : Integer;
    cdsAux       : TUniClientDataSet;
    objSequencias: TSequenciaisBaixaCartao;

    LValorTotalTaxa,
    LValorBruto,
    LValorTotalCtp: Double;

    LListaBanMca: TListaBanMCA;

    LSeqLanFrete,
    LSeqLanAjuste,
    LSeqLanCupom: String;

    LExecutaScripts: TUniQuery;
begin
  strSeqLan    := '';
  strSeqLanTax := '';
  strSeqLanCre := '';
  strSeqLanAnt := '';
  strNumDup    := '';
  blnConfirma := True;

  cdsAux := Nil;
  objSequencias := Nil;
  LListaBanMca := Nil;
  LExecutaScripts := Nil;
  Try
    Try
      cdsAux := TPagSeguroFuncoes.CriarClientDataSet(cdsBaiCar);

      cdsAux.DisableControls;
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N') + ' AND REGISTROPIXCARTAO = ' + QuotedStr('N');
      cdsAux.Filtered := True;

      cdsAux.First;

      pgbStatus.Position := 0;

      VS_FuncoesExternas.fIStartTransaction;
      intCtpCon := VS_FuncoesExternas.fIRetCtpCon;
      VS_FuncoesExternas.fICommit;

      pCarregaArrBaiSinCar;
      pCarregaArrAjustes;

      pgbStatus.Properties.Max := Length(arrBaiSinCar) * 4;

      objSequencias := TBaixaCartoes.RetornaSequenciaisParaBaixaSintetica(arrBaiSinCar,
                                                                          cdsAux,
                                                                          False,
                                                                          Not TPagSeguroFuncoes.fEmptyStr(strPorBad),
                                                                          False,
                                                                          Length(arrBaiSinDeb));
      objSequencias.SequencialControleBaixaPagar := intCtpCon;
      objSequencias.NumeroDocumentoBaixa := strNumDoc;

      {************************************}
      {* GRAVA OS LANÇAMENTOS DOS AJUSTES *}
      {*********************************AJ*}
      If (Length(arrBaiSinDeb) > 0) Then
      Begin
        TBaixaCartoes.GravaMovBanAjustes(arrBaiSinDeb, objSequencias.intSeqLan, objSequencias.intContadorAutIncMovBan);
        TBaixaCartoes.GravaCadPagAjustes(arrBaiSinDeb, objSequencias.intSequencialCadPag, objSequencias.intContadorAutIncCadPag);

        Inc64(objSequencias.intSeqLan, Length(arrBaiSinDeb));
        Inc64(objSequencias.intSequencialCadPag, Length(arrBaiSinDeb));
        Inc64(objSequencias.intContadorAutIncMovBan, Length(arrBaiSinDeb));
        Inc64(objSequencias.intContadorAutIncCadPag, Length(arrBaiSinDeb));
      End;

      pCarregaArrayNegociacao;
      If Length(FArrayNegociacao) > 0 Then
      Begin
        TBaixaCartoes.GravaMovBanAjustes(FArrayNegociacao);
        TBaixaCartoes.GravaCadPagAjustes(FArrayNegociacao);
      End;

      For intCont := 0 To Length(arrBaiSinCar) - 1 Do
      Begin
        If Not blnConfirma Then
          Break;

        strPorCar        := arrBaiSinCar[intCont].strPorBai;
        strCtaCar        := arrBaiSinCar[intCont].strCtaBai;
        strPorBad        := arrBaiSinCar[intCont].strPorBad;
        strCtaBad        := arrBaiSinCar[intCont].strCtaBad;
        strPorTax        := arrBaiSinCar[intCont].strPorTax;
        strCtaTax        := arrBaiSinCar[intCont].strCtaTax;
        strForTax        := arrBaiSinCar[intCont].strForTax;
        strEventoCredito := arrBaiSinCar[intCont].strEventoCredito;
        strEventoTaxa    := arrBaiSinCar[intCont].strEventoTaxa;
        strEveDeb        := arrBaiSinCar[intCont].strEveDeb;
        strCtaAnt        := arrBaiSinCar[intCont].strCtaAnt;

        Inc64(objSequencias.intContadorAutIncBanMca,
              fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                         'VALSTA',
                                         LListaBanMca,
                                         arrBaiSinCar[intCont].dtaDtaRec,
                                         strPorCar,
                                         strCtaCar,
                                         strPorBad,
                                         strCtaBad,
                                         strPorTax,
                                         strCtaTax,
                                         strForTax,
                                         strEventoCredito,
                                         strEventoTaxa,
                                         strEveDeb,
                                         strCtaAnt,
                                         objSequencias.intContadorAutIncBanMca));

        LValorBruto := arrBaiSinCar[intCont].fltValDoc;

        {*****************************************}
        {* GRAVA MOVBAN DO CARTÃO                *}
        {**************************************MV*}
        strSeqLanCre  := TLibCartoesMovBan.GravaMovBan(strCtaCar,                      // Centro de Custo
                                                       strPorCar,                      // Portador
                                                       VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                       arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                       TPagSeguroFuncoes.fTime(),                        // Hora do Lançamento
                                                       strNumDoc,                      // Documento
                                                       'C',                            // Credito / Debito
                                                       VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                       LValorBruto,                    // Valor Documento
                                                       strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                       '',                             // Historico 2
                                                       '',                             // Cliente
                                                       '',                             // Fornecedor
                                                       '',                             // Numero da Duplicata
                                                       0,                              // Sequencial Duplicata
                                                       '',                             // Parcela da Duplicata
                                                       arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                       '',                             // Série
                                                       strEventoCredito,               // Código do Evento
                                                       '',                             // Documento da Baixa
                                                       0,
                                                       intCtpCon,
                                                       '',
                                                       '',
                                                       objSequencias.intSeqLan.ToString,
                                                       TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                       '',
                                                       '',
                                                       1,
                                                       True,
                                                       LListaBanMca,
                                                       EmptyStr,
                                                       'S',
                                                       EmptyStr,
                                                       EmptyStr,
                                                       TBaixaCartoes.BatchSQL);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanCre));
        arrBaiSinCar[intCont].strSeqLanCre := strSeqLanCre;

        TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);

        If (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanCre)) And (Not TPagSeguroFuncoes.fEmptyStr(strPorBad)) Then
        Begin
          if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
          begin
            SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
            arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanCre;
          end;

          Inc64(objSequencias.intContadorAutIncBanMca,
                fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                           'VALSTA',
                                           LListaBanMca,
                                           arrBaiSinCar[intCont].dtaDtaRec,
                                           strPorCar,
                                           strCtaCar,
                                           strPorBad,
                                           strCtaBad,
                                           strPorTax,
                                           strCtaTax,
                                           strForTax,
                                           strEventoCredito,
                                           strEventoTaxa,
                                           strEveDeb,
                                           strCtaAnt,
                                           objSequencias.intContadorAutIncBanMca));

          {*****************************************}
          {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
          {**************************************MV*}
          strSeqLan   := TLibCartoesMovBan.GravaMovBan(strCtaBad,                      // Centro de Custo
                                                       strPorBad,                      // Portador
                                                       VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                       arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                       TPagSeguroFuncoes.fTime(),                        // Hora do Lançamento
                                                       strNumDoc,                      // Documento
                                                       'D',                            // Credito / Debito
                                                       VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                       arrBaiSinCar[intCont].fltValDoc,// Valor Documento
                                                       strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                       '',                             // Historico 2
                                                       '',                             // Cliente
                                                       '',                             // Fornecedor
                                                       '',                             // Numero da Duplicata
                                                       0,                              // Sequencial Duplicata
                                                       '',                             // Parcela da Duplicata
                                                       arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                       '',                             // Série
                                                       strEveDeb,                      // Código do Evento
                                                       '',                             // Documento da Baixa
                                                       0,
                                                       intCtpCon,
                                                       '',
                                                       '',
                                                       objSequencias.intSeqLan.ToString,
                                                       TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                       '',
                                                       '',
                                                       1,
                                                       True,
                                                       LListaBanMca,
                                                       EmptyStr,
                                                       'S',
                                                       EmptyStr,
                                                       EmptyStr,
                                                       TBaixaCartoes.BatchSQL);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLan));
          arrBaiSinCar[intCont].strSeqLanDeb := strSeqLan;
        End;

        TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);

        {************************************}
        {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
        {*********************************JU*}

        If (arrBaiSinCar[intCont].fltValTax > 0) And (blnConfirma) Then
        Begin
          Inc64(objSequencias.intContadorAutIncBanMca,
                fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                           'VALTAX',
                                           LListaBanMca,
                                           arrBaiSinCar[intCont].dtaDtaRec,
                                           strPorCar,
                                           strCtaCar,
                                           strPorBad,
                                           strCtaBad,
                                           strPorTax,
                                           strCtaTax,
                                           strForTax,
                                           strEventoCredito,
                                           strEventoTaxa,
                                           strEveDeb,
                                           strCtaAnt,
                                           objSequencias.intContadorAutIncBanMca));

          LValorTotalTaxa := TPagSeguroFuncoes.fFormataFloat(arrBaiSinCar[intCont].fltValTax -
                                                            arrBaiSinCar[intCont].fltValAnt, 2);

          {*****************************************}
          {* GRAVA MOVBAN DA TAXA                  *}
          {**************************************MV*}
          strSeqLanTax := TLibCartoesMovBan.GravaMovBan(strCtaTax,                      // Centro de Custo
                                                        strPorTax,                      // Portador
                                                        VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                        arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                        TPagSeguroFuncoes.fTime(),                        // Hora do Lançamento
                                                        strNumDoc,                      // Documento
                                                        'D',                            // Credito / Debito
                                                        VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                        LValorTotalTaxa,                // Valor Documento
                                                        strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                        '',                             // Historico 2
                                                        '',                             // Cliente
                                                        strForTax,                      // Fornecedor
                                                        '',                             // Numero da Duplicata
                                                        0,                              // Sequencial Duplicata
                                                        '',                             // Parcela da Duplicata
                                                        arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                        '',                             // Série
                                                        //'',                           // Sequencial de Lançamento
                                                        strEventoTaxa,                  // Código do Evento
                                                        '',                             // Documento da Baixa
                                                        0,
                                                        intCtpCon,
                                                        '',
                                                        '',
                                                        objSequencias.intSeqLan.ToString,
                                                        TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                        '',
                                                        '',
                                                        1,
                                                        True,
                                                        LListaBanMca,
                                                        EmptyStr,
                                                        'S',
                                                        EmptyStr,
                                                        EmptyStr,
                                                        TBaixaCartoes.BatchSQL);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanTax));
          arrBaiSinCar[intCont].strSeqLanTax := strSeqLanTax;

          {************************}
          {* GRAVA CADPAG DA TAXA *}
          {*********************AF*}
          If (blnConfirma) Then
          Begin
            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
              arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
            end;

            strNumDup := 'G' + TPagSeguroFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

            LValorTotalCtp := LValorTotalTaxa;

            blnCadPag :=  TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                            'INCLUSAO TAXA - CARTOES BX_SIN',
                                            strForTax,
                                            strNumDup,
                                            'A',
                                            arrBaiSinCar[intCont].strCodEmp,
                                            strCtaTax,
                                            'CRT',
                                            0,
                                            arrBaiSinCar[intCont].dtaDtaRec,
                                            arrBaiSinCar[intCont].dtaDtaRec,
                                            0,
                                            LValorTotalCtp,
                                            'N',
                                            'N',
                                            'N',
                                            strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                            '',
                                            strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                            strPorTax,
                                            strCtaTax,
                                            strSeqLanTax,
                                            VS_FuncoesExternas.fIRetOperadorLogado,
                                            arrBaiSinCar[intCont].dtaDtaRec,
                                            LValorTotalCtp,
                                            0,
                                            0,
                                            VS_FuncoesExternas.fIRetEmpresaLogada,
                                            strEventoTaxa,
                                            '',
                                            strPorTax,
                                            strNumDoc,
                                            0.0,
                                            0.0,
                                            intCtpCon,
                                            False,
                                            0,
                                            '',
                                            0,
                                            '',
                                            '',
                                            '',
                                            '',
                                            TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            LValorTotalCtp,
                                            0,
                                            0,
                                            0,
                                            '',
                                            0,
                                            0,
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '0',
                                            '',
                                            '',
                                            TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada),
                                            EmptyStr,
                                            'N',
                                            EmptyStr,
                                            EmptyStr,
                                            EmptyStr,
                                            EmptyStr,
                                            0,
                                            EmptyStr,
                                            0,
                                            EmptyStr,
                                            0,
                                            0,
                                            0,
                                            0,
                                            EmptyStr,
                                            EmptyStr,
                                            'N',
                                            EmptyStr,
                                            EmptyStr,
                                            TBaixaCartoes.BatchSQL);

            Inc64(objSequencias.intContadorAutIncCadPag);
            Inc64(objSequencias.intContadorAutIncLogCtp);
            Inc64(objSequencias.intSequencialCadPag);

            blnConfirma := blnCadPag;
          End;
        End;

        TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);

        {*********************************}
        {* GRAVA A TAXA DE ANTECIPAÇÃO   *}
        {******************************AJ*}
        If (arrBaiSinCar[intCont].fltValAnt > 0) And (blnConfirma) Then
        Begin
          Inc64(objSequencias.intContadorAutIncBanMca,
                fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                           'VALSTA',
                                           LListaBanMca,
                                           arrBaiSinCar[intCont].dtaDtaRec,
                                           strPorCar,
                                           strCtaCar,
                                           strPorBad,
                                           strCtaBad,
                                           strPorTax,
                                           strCtaTax,
                                           strForTax,
                                           strEventoCredito,
                                           strEventoTaxa,
                                           strEveDeb,
                                           strCtaAnt,
                                           objSequencias.intContadorAutIncBanMca));

          {***************************************}
          {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO *}
          {************************************AJ*}
          strSeqLanAnt := TLibCartoesMovBan.GravaMovBan(strCtaAnt,                      // Centro de Custo
                                                        strPorTax,                      // Portador
                                                        VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                        arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                        TPagSeguroFuncoes.fTime(),                        // Hora do Lançamento
                                                        strNumDoc,                      // Documento
                                                        'D',                            // Credito / Debito
                                                        VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                        arrBaiSinCar[intCont].fltValAnt,// Valor Documento
                                                        'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                        '',                             // Historico 2
                                                        '',                             // Cliente
                                                        strForTax,                      // Fornecedor
                                                        '',                             // Numero da Duplicata
                                                        0,                              // Sequencial Duplicata
                                                        '',                             // Parcela da Duplicata
                                                        arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                        '',                             // Série
                                                        '',                             // Código do Evento
                                                        '',                             // Documento da Baixa
                                                        0,
                                                        intCtpCon,
                                                        '',
                                                        '',
                                                        objSequencias.intSeqLan.ToString,
                                                        TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                        '',
                                                        '',
                                                        1,
                                                        True,
                                                        LListaBanMca,
                                                        EmptyStr,
                                                        'S',
                                                        EmptyStr,
                                                        EmptyStr,
                                                        TBaixaCartoes.BatchSQL);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TPagSeguroFuncoes.fEmptyStr(strSeqLanAnt));
          arrBaiSinCar[intCont].strSeqLanAnt := strSeqLanAnt;

          {***************************************}
          {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
          {************************************AJ*}
          If (blnConfirma) Then
          Begin
            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
              arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
            end;

            strNumDup := 'G' + TPagSeguroFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

            blnCadPag :=  TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                                        'INCLUSAO TAXA - CARTOES BX_SIN',
                                                        strForTax,
                                                        strNumDup,
                                                        'A',
                                                        arrBaiSinCar[intCont].strCodEmp,
                                                        strCtaAnt,
                                                        'CRT',
                                                        0,
                                                        arrBaiSinCar[intCont].dtaDtaRec,
                                                        arrBaiSinCar[intCont].dtaDtaRec,
                                                        0,
                                                        arrBaiSinCar[intCont].fltValAnt,
                                                        'N',
                                                        'N',
                                                        'N',
                                                        'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                                        '',
                                                        'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                                        strPorTax,
                                                        strCtaAnt,
                                                        strSeqLanTax,
                                                        VS_FuncoesExternas.fIRetOperadorLogado,
                                                        arrBaiSinCar[intCont].dtaDtaRec,
                                                        arrBaiSinCar[intCont].fltValAnt,
                                                        0,
                                                        0,
                                                        VS_FuncoesExternas.fIRetEmpresaLogada,
                                                        '',
                                                        '',
                                                        '',
                                                        strNumDoc,
                                                        0.0,
                                                        0.0,
                                                        intCtpCon,
                                                        False,
                                                        0,
                                                        '',
                                                        0,
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        arrBaiSinCar[intCont].fltValAnt,
                                                        0,
                                                        0,
                                                        0,
                                                        '',
                                                        0,
                                                        0,
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        '0',
                                                        '',
                                                        '',
                                                        TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                        EmptyStr,
                                                        'N',
                                                        EmptyStr,
                                                        EmptyStr,
                                                        EmptyStr,
                                                        EmptyStr,
                                                        0,
                                                        EmptyStr,
                                                        0,
                                                        EmptyStr,
                                                        0,
                                                        0,
                                                        0,
                                                        0,
                                                        EmptyStr,
                                                        EmptyStr,
                                                        'N',
                                                        EmptyStr,
                                                        EmptyStr,
                                                        TBaixaCartoes.BatchSQL);

            Inc64(objSequencias.intContadorAutIncCadPag);
            Inc64(objSequencias.intContadorAutIncLogCtp);
            Inc64(objSequencias.intSequencialCadPag);

            blnConfirma := blnCadPag;
          End;
        End;

        TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);
      End;


      cdsAux.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORBAD;CAR_CTABAD;'+
                                'CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;CAR_EVEDEB;CAR_EVECRE;CAR_EVETAX';
      intCont := 0;

      cdsAux.First;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max :=  cdsAux.RecordCount;

      While (Not cdsAux.Eof) And (blnConfirma) Do
      Begin
        TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);

        //Acha a empresa para gravar os dados corretos
        If (arrBaiSinCar[intCont].strCodEmp        <> cdsAux.FieldByName('MCA_CODEMP').AsString) Or
           (arrBaiSinCar[intCont].dtaDtaRec        <> cdsAux.FieldByName('MCA_DTAREC').Value) Or
           (arrBaiSinCar[intCont].strPorBai        <> cdsAux.FieldByName('CAR_PORBAI').AsString) Or
           (arrBaiSinCar[intCont].strCtaBai        <> cdsAux.FieldByName('CAR_CTABAI').AsString) Or
           (arrBaiSinCar[intCont].strPorBad        <> cdsAux.FieldByName('CAR_PORBAD').AsString) Or
           (arrBaiSinCar[intCont].strCtaBad        <> cdsAux.FieldByName('CAR_CTABAD').AsString) Or
           (arrBaiSinCar[intCont].strPorTax        <> cdsAux.FieldByName('CAR_PORTAX').AsString) Or
           (arrBaiSinCar[intCont].strCtaTax        <> cdsAux.FieldByName('CAR_CTATAX').AsString) Or
           (arrBaiSinCar[intCont].strForTax        <> cdsAux.FieldByName('CAR_FORTAX').AsString) Or
           (arrBaiSinCar[intCont].strEventoCredito <> cdsAux.FieldByName('CAR_EVECRE').AsString) Or
           (arrBaiSinCar[intCont].strEventoTaxa    <> cdsAux.FieldByName('CAR_EVETAX').AsString) Or
           (arrBaiSinCar[intCont].strEveDeb        <> cdsAux.FieldByName('CAR_EVEDEB').AsString) Or
           (arrBaiSinCar[intCont].strCtaAnt        <> cdsAux.FieldByName('CAR_CTAANT').AsString) Then
        Begin
          For intCont := 0 to Length(arrBaiSinCar) - 1 Do
          Begin
            If (arrBaiSinCar[intCont].strCodEmp        = cdsAux.FieldByName('MCA_CODEMP').AsString) And
               (arrBaiSinCar[intCont].dtaDtaRec        = cdsAux.FieldByName('MCA_DTAREC').Value)    And
               (arrBaiSinCar[intCont].strPorBai        = cdsAux.FieldByName('CAR_PORBAI').AsString) And
               (arrBaiSinCar[intCont].strCtaBai        = cdsAux.FieldByName('CAR_CTABAI').AsString) And
               (arrBaiSinCar[intCont].strPorBad        = cdsAux.FieldByName('CAR_PORBAD').AsString) And
               (arrBaiSinCar[intCont].strCtaBad        = cdsAux.FieldByName('CAR_CTABAD').AsString) And
               (arrBaiSinCar[intCont].strPorTax        = cdsAux.FieldByName('CAR_PORTAX').AsString) And
               (arrBaiSinCar[intCont].strCtaTax        = cdsAux.FieldByName('CAR_CTATAX').AsString) And
               (arrBaiSinCar[intCont].strForTax        = cdsAux.FieldByName('CAR_FORTAX').AsString) And
               (arrBaiSinCar[intCont].strEventoCredito = cdsAux.FieldByName('CAR_EVECRE').AsString) And
               (arrBaiSinCar[intCont].strEventoTaxa    = cdsAux.FieldByName('CAR_EVETAX').AsString) And
               (arrBaiSinCar[intCont].strEveDeb        = cdsAux.FieldByName('CAR_EVEDEB').AsString) And
               (arrBaiSinCar[intCont].strCtaAnt        = cdsAux.FieldByName('CAR_CTAANT').AsString) Then
              Break;
          End;
        End;

        If (cdsAux.FieldByName('MCA_MARDES').AsString = 'M') And (cdsAux.FieldByName('MCA_AJUSTE').AsString = 'N') Then
        Begin
          {*****************************************}
          {* BAIXA UM REGISTRO                     *}
          {**************************************MV*}
          blnConfirma := TLibCartoesMovCar.BaixaCartao(Self.Name,
                                                       'BAIXA DE CARTÕES (' + Self.Caption + ')',
                                                       cdsAux.FieldByName('AUTOINC').AsString,
                                                       cdsAux.FieldByName('NRODUP').AsString,
                                                       cdsAux.FieldByName('PARDUP').AsString,
                                                       cdsAux.FieldByName('MCA_CODCLI').AsString,
                                                       cdsAux.FieldByName('MCA_CODEMP').AsString,
                                                       arrBaiSinCar[intCont].dtaDtaRec,
                                                       cdsAux.FieldByName('MCA_VALREC').AsFloat,
                                                       VS_FuncoesExternas.fIRetOperadorLogado,
                                                       strHisDoc,
                                                       arrBaiSinCar[intCont].strPorBai,
                                                       arrBaiSinCar[intCont].strCtaBai,
                                                       arrBaiSinCar[intCont].strSeqLanCre,
                                                       arrBaiSinCar[intCont].strPorTax,
                                                       arrBaiSinCar[intCont].strCtaTax,
                                                       arrBaiSinCar[intCont].strSeqLanTax,
                                                       arrBaiSinCar[intCont].strForTax,
                                                       arrBaiSinCar[intCont].strCtaBad,
                                                       arrBaiSinCar[intCont].strPorBad,
                                                       arrBaiSinCar[intCont].strSeqLanDeb,
                                                       cdsAux.FieldByName('MCA_CHACON').AsString,
                                                       arrBaiSinCar[intCont].strEveDeb,
                                                       TPagSeguroFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                            '', arrBaiSinCar[intCont].strCtaAnt),
                                                       TPagSeguroFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                            '', arrBaiSinCar[intCont].strSeqLanAnt),
                                                       TPagSeguroFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                            0, cdsAux.FieldByName('MCA_ANTTAX').AsFloat),
                                                       TPagSeguroFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                       arrBaiSinCar[intCont].strEventoCredito,
                                                       arrBaiSinCar[intCont].strEventoTaxa,
                                                       cdsAux.FieldByName('FRETE_MARKETPLACE').AsFloat,
                                                       cdsAux.FieldByName('AJUSTE_MARKETPLACE').AsFloat,
                                                       cdsAux.FieldByName('MCA_VALTAX').AsFloat,
                                                       cdsAux.FieldByName('CUPOM_MARKETPLACE').AsFloat,
                                                       cdsAux.FieldByName('ALTERAR_BRUTO').AsString.Equals('S'),
                                                       cdsAux.FieldByName('MCA_VALSTA').AsFloat,
                                                       arrBaiSinCar[intCont].SeqLanFreteMkt,
                                                       arrBaiSinCar[intCont].SeqLanAjusteMkt,
                                                       arrBaiSinCar[intCont].SeqLanCupomMkt,
                                                       TBaixaCartoes.BatchSQL,
                                                       arrBaiSinCar[intCont].dtaDtaRec);

          Inc64(objSequencias.intContadorAutIncLogMca);

          If (blnConfirma) Then
            pAtualizaDataMovimentobancarioMovCar(cdsAux.FieldByName('AUTOINC').AsString, arrBaiSinCar[intCont].dtaDtaRec);

        End;

        If Not blnConfirma Then
          Break;

        cdsAux.Next;
      End;

      If blnConfirma Then
      Begin
        VS_FuncoesExternas.fIStartTransaction;

        TBaixaCartoes.BatchSQL.OnProgress :=
          procedure(Sender: TObject; ALote, ATotalLotes: Integer)
          begin
            if Not Assigned(pgbStatus) then
              Exit;

            pgbStatus.Position := ALote;
            pgbStatus.Properties.Max := ATotalLotes;
            TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando baixa.');
          end;

        LExecutaScripts := VS_FuncoesExternas.fICriaQuery;
        blnConfirma := TBaixaCartoes.BatchSQL.Execute(LExecutaScripts, True);

        //Req: 449872 - transferências gravam direto (fora do lote), na mesma transação da baixa
        If blnConfirma Then
          TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                    objConcil.NomeConciliacao,
                                                    objSequencias);

        If blnConfirma Then
        Begin
          VS_FuncoesExternas.fICommit;

          pgbStatus.Visible := False;
          TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Finalizando baixa.');

          VS_FuncoesExternas.fIStartTransaction;
          TBaixaCartoes.MarcarComoConciliado(objConcil,
                                             cdsBaiCar);
          VS_FuncoesExternas.fICommit;
        End;
      End;

      SetLength(arrBaiSinCar, 0);

      If Not blnConfirma Then
        Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!')
      Else
        blnConfirmaBaixa := True;
    Except
      On E: Exception Do
      Begin
        If TPagSeguroFuncoes.EstaEmTransacao Then
          VS_FuncoesExternas.fIRollBack;

        blnConfirmaBaixa := False;
        Result := false;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoesSin]');

        Exit;
      End;
    End;
  Finally
    blnConfirmaBaixa := blnConfirma;
    TPagSeguroFuncoes.FreeAndNilDatasets(cdsAux);
    TPagSeguroFuncoes.FreeAndNilDatasets(cdsCloneConsulta);

    If Assigned(objSequencias) Then
      FreeAndNil(objSequencias);

    If Assigned(LListaBanMca) Then
      FreeAndNil(LListaBanMca);

    TPagSeguroFuncoes.FreeAndNilDatasets(LExecutaScripts);

    SetLength(arrBaiSinCar, 0);
    SetLength(arrBaiSinDeb, 0);
  End;

  Result :=  True;
End;

procedure TfrmPagSeguroBaixaCartoes.pAtualizaDataMovimentobancarioMovCar( sAutoInc : String; ADataAlterada: TDateTime);
Var
  qryAltCrt : TUniQuery;
begin
  qryAltCrt := Nil;
  Try
    qryAltCrt := VS_FuncoesExternas.fICriaQuery;
    qryAltCrt.SQL.Add(' UPDATE MOVCAR ');
    qryAltCrt.SQL.Add('    SET MCA_DTABAN = :DTABAN ');
    qryAltCrt.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
    qryAltCrt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
    qryAltCrt.ParamByName('AUTOIN').AsString   := sAutoInc;

    TBatchHelper.AddQueryToBatch(TBaixaCartoes.BatchSQL, qryAltCrt);
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(qryAltCrt);
  End;
End;

end.


