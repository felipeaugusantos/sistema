{*************************}
{* qryConEmp -> CADEMP   *}
{**********************JB*}
unit untRedeCardBaixaCartoes;

interface

uses
  System.SysUtils, Winapi.Windows, System.Variants, System.StrUtils,
  System.Types, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Graphics, Vcl.AppEvnts, Vcl.Grids, Vcl.Dialogs, Vcl.Mask, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Menus, Datasnap.DBClient,
  System.Generics.Collections, System.Math, REST.Client, Rest.Types, ComObj,
  System.ImageList, Vcl.ImgList,

  HTTPSend, blcksock, ssl_openssl, synautil, MaskEditFocus, EditFocus,
  QColorLabel, Uni, UniClientDataSet, UniDataSetProvider, frxClass, frxDBSet,
  BitBtnLockedIncrem, cxProgressBar, MemDS, DBAccess, Provider,
  frxExportCSVTestabilidade, frxExportText, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridCitel, cxClasses, cxGridLevel, cxGrid,
  frxExportXLS, frxExportCSV, frxExportPDF, cxImageComboBox,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCurrencyEdit,

  untLibCartoesPaiSimples, untTRedeCardBaixaCartoes,
  untTBanMca, untTLibCartoesConfiguracaoGrids,

  untTRedeCardFuncoes, untLibCartoesInterfacesTipos, untLibCartoesConfiguracaoGrids,

  {$WARNINGS OFF}Vcl.FileCtrl{$WARNINGS ON};

type
  TfrmRedeCardBaixaCartoes = class(TfrmPaiSimples)
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
    shpNegociado: TShape;
    lblNegociado: TLabel;
    lblNegociadoA: TLabel;
    grdDuplicDadosNEGOCIACAO: TcxGridDBColumn;
    grdDuplicDadosNEGOCIADO_ANTERIORMENTE: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMPOK: TcxGridDBColumn;
    grdDuplicDadosBAN_NOMBAN: TcxGridDBColumn;
    grdDuplicDadosCARTAO: TcxGridDBColumn;
    frxDBPreviaCartoesConc: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxPreviaCartoesConc: TfrxReport;
    btnPreviaCartoesConc: TBitBtnLocked;
    dtsPreviaCartoesConc: TDataSource;
    btnConfigurarGrid: TBitBtnLocked;
    grdDuplicDadosESTABE: TcxGridDBColumn;
    grdDuplicDadosREGISTROTRANSFERENCIA: TcxGridDBColumn;
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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRelatorioClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnPreviaCartoesConcClick(Sender: TObject);
    procedure btnConfigurarGridClick(Sender: TObject);
    function frxPreviaCartoesConcUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    FDataInicialConciliacao: TDate;
    FDataFinalConciliacao: TDate;
    FExibirCartoesPendente: Boolean;

    qryBaiCar: TUniQuery;
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

    arrNumNsu: Array of String;

    blnConfirmaBaixa: Boolean; //Tratamento para trabalhar o Commit/Rollback nas Baixas

    arrBaiSinCar: Array Of TArrBaiSinCar;
    arrBaiSinDeb: Array Of TArrBaiSinCar; //array para gravação de cancelamentos/ajsutes na movban
    FArrayNegociacao: Array Of TArrBaiSinCar; //array para lançamento de negociação de recebíveis

    FRegistroCTPDETFrete,
    FRegistroCTPDETAjuste: TArrBaiSinCar;
    FCTPDETSintetico: Array Of TArrBaiSinCar;

    FRegistrosConciliar: TStringList;

    cdsCloneConsulta: TUniClientDataSet;

    FLiberacaoTransferencia: Boolean;

    FCartoesPendentesDeConciliacao: TUniQuery;

    FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

    procedure pAbreConciliacao; //ABRIR A TELA PARA CONCILIAÇÃO

    procedure pCalculaTotalDuplicatas;

    procedure pLimpaDados;

    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    procedure pCriaAgrFields;
    procedure pManipulaPanels(Habilita: Boolean);

    function fVerificaPorCta: Boolean;
    function fValidaPortadores: String;
    function fValidaEventos : Boolean;

    function fGetCartoes: String;

    function fBaixaDuplicatas: Boolean;
    function fGravaCartoes(pgbStatus: TcxProgressBar): Boolean;
    function fGravaCartoesSin(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure CartoesPendentesDeConciliacao;
    function ExportarCSVCartoesPendentesDeConciliacao(cxProgress: TcxProgressBar): Boolean;
    function fSetaDupBaixadasRede(arrNumNsu: Array of String):Boolean ;
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
    function fRetornaValorAntecipacao: String;

    procedure AdicionarRegistroCTPDetNoArraySintetico(ARegistroCTPDetFrete,
                                                      ARegistroCTPDetAjuste: TArrBaiSinCar;
                                                      APlanoDeContas: String;
                                                      ARegistros: TUniClientDataset);

    function ApenasBaixaDeTransferencias: Boolean;
    procedure ExibirPorcentagemTaxaDeAntecipacao;
    procedure pVisualizaNroPedido;
    procedure HabilitaPreviaCartoesConc;
    procedure pAtualizaDataMovimentobancarioMovCar( sAutoInc : String; ADataAlterada: TDateTime);
    function fGetEmpresaAjuste(ADataset: TUniClientDataset): string;
  protected
    strRcxTcc: String;
    dtaDtaIni: TDate;
    dtaDtaFim: TDate;
    lstNomArq: TStringList;
    lstSemArq: TStringList;
    intQtdSem: Integer;
    fltValSem: Integer;
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

    property RegistrosConciliar: TStringList read FRegistrosConciliar write FRegistrosConciliar;
    property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes read FFiltrosRelatorio write FFiltrosRelatorio;

    property DataInicialConciliacao: TDate   Read FDataInicialConciliacao Write FDataInicialConciliacao;
    property DataFinalConciliacao  : TDate   Read FDataFinalConciliacao   Write FDataFinalConciliacao;
    property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente   Write FExibirCartoesPendente;


    { Public declarations }
  end;

implementation

uses untLibCartoesBaixaCtcValor, untLibCartoesBaixaCtcAnaSin,
     untTLibCartoesMovCar, untTLibCartoesMovBan, untLibCartoesGravando,
     untLibCartoesFiltroInconsistencias,untLibCartoesDigValor,
     untTLibCartoesCadPag;

{$R *.dfm}

{ TfrmBaixaCartoes }

function TfrmRedeCardBaixaCartoes.fRetornaChaveGrid: String;
begin
  Result := Concat(Self.Name, '.', grdDuplicDados.Name);

  If Not objConcil.strTabCon.IsEmpty Then
    Result := Concat(Result, '.', objConcil.strTabCon);
end;


function TfrmRedeCardBaixaCartoes.fRetornaValorAntecipacao: String;
begin
  Result := FormatFloat('#,##0.00',cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat);
end;

function TfrmRedeCardBaixaCartoes.frxPreviaCartoesConcUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fTime')) Then
    Result := TRedeCardFuncoes.fTime(Params[0]);
end;

function TfrmRedeCardBaixaCartoes.fSetaDupBaixadasRede(arrNumNsu: array of String): Boolean;
  Var
    strSQL     : String;
    strNsu     : String;
    intCont    : Integer;

    LCfgEstabelecimento: String;

    strEmpresasAjustes: String;

    cdsDatas: TUniClientDataSet;
begin

  Self.Enabled := False;

  Try
    cdsBaicar.Filter := 'MCA_MARDES=''M'' ';
    cdsDatas := TRedeCardFuncoes.CriarClientDataSet(cdsBaicar);
    cdsDatas.Open;
    dtaDtaIni := 0;
    dtaDtaFim := 0;
    cdsDatas.First;
    While Not cdsDatas.Eof Do
    Begin
      If dtaDtaIni > cdsDatas.FieldByName('MCA_DTAREC').AsDateTime Then
        dtaDtaIni :=  cdsDatas.FieldByName('MCA_DTAREC').AsDateTime;

      If dtaDtaFim < cdsDatas.FieldByName('MCA_DTAREC').AsDateTime Then
        dtaDtaFim :=  cdsDatas.FieldByName('MCA_DTAREC').AsDateTime;

      cdsDatas.Next;
    End;
    FreeAndNil(cdsDatas);

    {***************************************}
    {* MARCAÇÃO DE CONCILIAÇÃO DOS DÉBITOS *}
    {************************************AJ*}
    strNsu := '';

    For intCont := 0 To Length(arrNumNsu) - 1 Do
      strNsu := strNsu + '"' + arrNumNsu[intCont] + '",';

    strNsu := Copy(strNsu, 1, Length(strNsu) - 1);

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   RED_EVDR05 ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   RED_CONCIL = 1 ';
    strSQL := strSQL + ' WHERE              ';
    strSQL := strSQL + '   RED_NUM_CV IN    ';
    strSQL := strSQL + '   (' + strNsu + ')        ';

    If Not strNsu.IsEmpty Then
      TRedeCardFuncoes.ExecutaSQL(strSQL);

    {************************}
    {* MARCAÇÃO DOS AJUSTES *}
    {*********************AJ*}
    If (VS_FuncoesExternas.fICfgSis('BAIDEB') = 'S') And
       (Length(arrBaiSinDeb) > 0) Then
    Begin
      strEmpresasAjustes := '';
      For intCont := 0 To Length(arrBaiSinDeb) - 1 Do
      Begin
        LCfgEstabelecimento := VS_FuncoesExternas.fICfgSis('REDEST',varString, arrBaiSindeb[intCont].strCodEmp);
        If Not LCfgEstabelecimento.IsEmpty Then
        Begin
          If Pos(LCfgEstabelecimento, strEmpresasAjustes) <= 0 Then
            strEmpresasAjustes := strEmpresasAjustes + '"' + LCfgEstabelecimento + '",';
        End;

        LCfgEstabelecimento := VS_FuncoesExternas.fICfgSis('REDECO',varString, arrBaiSindeb[intCont].strCodEmp);
        If Not LCfgEstabelecimento.IsEmpty Then
        Begin
          If Pos(LCfgEstabelecimento, strEmpresasAjustes) <= 0 Then
            strEmpresasAjustes := strEmpresasAjustes + '"' + LCfgEstabelecimento + '",';
        End;
      End;
      strEmpresasAjustes := LeftStr(strEmpresasAjustes, strEmpresasAjustes.Length - 1);

      TRedeCardFuncoes.ExecutaSQL('UPDATE RED_EFIR34 SET RED_CONCIL=1 ' +
                  ' WHERE RED_DTALAN BETWEEN ' +
                  FormatDateTime('yyyy-mm-dd', dtaDtaIni).QuotedString + ' AND ' +
                  FormatDateTime('yyyy-mm-dd', dtaDtaFim).QuotedString + ' AND ' +
                  'RED_NUM_PV IN (' + strEmpresasAjustes + ') AND ' +
                  'RED_REGDEB IN ("035", "045") ');
    End;

    cdsBaicar.Filtered := True;
    Result := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
      Result := False;
    End;
  End;

  Self.Enabled := True;
end;

function TfrmRedeCardBaixaCartoes.fValidaEventos: Boolean;
begin
  Result := True;

  cdsBaiCar.DisableControls;
  cdsBaiCar.first;
  while not cdsBaiCar.eof do
    begin
      if ((cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'N') and
         (TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_EVECRE').AsString) or
          TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_EVETAX').AsString)) or
         (not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString) and
          TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_EVEDEB').AsString)))
         or
         ((cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'S') and
          (TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('MCA_EVECAN').AsString)))
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

function TfrmRedeCardBaixaCartoes.fValidaPortadores: String;
  Var
    qryValPor: TUniQuery;
    strPortad: String;
begin
  qryValPor := VS_FuncoesExternas.fICriaQuery;
  strPortad := '';
  With cdsBaiCar Do
  Begin
    First;
    While Not Eof Do
    Begin
      If Pos(FieldByName('CAR_PORBAI').AsString, strPortad) <= 0 Then
        strPortad := strPortad + '"' + FieldByName('CAR_PORBAI').AsString + '",';
      If Pos(FieldByName('CAR_PORTAX').AsString, strPortad) <= 0 Then
        strPortad := strPortad + '"' + FieldByName('CAR_PORTAX').AsString + '",';
      If (Not TRedeCardFuncoes.fEmptyStr(FieldByName('CAR_PORBAD').AsString)) And (Pos(FieldByName('CAR_PORBAD').AsString, strPortad) <= 0) Then
        strPortad := strPortad + '"' + FieldByName('CAR_PORBAD').AsString + '",';

      Next;
    End;
    First;
  End;

  With qryValPor Do
  Begin
    SQL.Add('SELECT POR_CODPOR FROM CADPOR WHERE ');
    SQL.Add(' (POR_PERBAI="N" OR POR_PERBAI IS NULL) AND ');
    SQL.Add(' POR_CODPOR IN (' + TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(strPortad), '""',
                                     LeftStr(strPortad, Length(strPortad) - 1)) + ') ');
    SQL.Add(' ORDER BY POR_CODPOR');
    Open;

    Result := '';
    If RecordCount > 0 Then
    Begin
      While Not Eof Do
      Begin
        Result := Result + FieldByName('POR_CODPOR').AsString + ', ';

        Next;
      End;
      Result := Copy(Result, 1, Length(Result) - 2);
    End;
    Close;
  End;
  FreeAndNil(qryValPor);
end;

procedure TfrmRedeCardBaixaCartoes.grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var strMarDes,
    strResCai,
    strDtaTra,
    strAjuste,

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
    strResCai := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_RESCAI.Index]);
    strDtaTra := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_DTATRA.Index]);
    strAjuste := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_AJUSTE.Index]);
    LTFLiberada := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_TRFLIB.Index]);

    LNegociacao := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosNEGOCIACAO.Index]);
    LNegociadoAnteriormente := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosNEGOCIADO_ANTERIORMENTE.Index]);
    LEstabelecimento := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosESTABE.Index]);
    LTransferencia := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosREGISTROTRANSFERENCIA.Index]);

    If (strMarDes = 'M') And (strAjuste <> 'S') Then
      ACanvas.Font.Color := clBlue
    Else If (TRedeCardFuncoes.FExisteCampoLiberacaoTransferencia) And (LTFLiberada = 'N') And (strResCai = '1') And (FLiberacaoTransferencia) Then
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

procedure TfrmRedeCardBaixaCartoes.grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmRedeCardBaixaCartoes.pAtualizaTemporaria;
begin
  If Not cdsBaiCar.IsEmpty Then
  Begin
    pCalculaTotalDuplicatas;
    cdsBaiCar.First;
    pAtualizaDados(cdsBaiCar);
  End;
end;

procedure TfrmRedeCardBaixaCartoes.pDeletaTemporaria;
begin
  If cdsBaiCar.Active Then
    cdsBaiCar.EmptyDataSet;
end;

procedure TfrmRedeCardBaixaCartoes.pAbreConciliacao;
  Var
    strDireitos: String;
    qryBusCad  : TUniQuery;
begin
  cdsBaiCar.Close;
  pCriaAgrFields;

  dtsBaiCar := TRedeCardFuncoes.fCriaDataSource(cdsBaiCar);
  cdsBaiCar.AggregatesActive := True;
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

  if MatchStr(objConcil.strTabCon, ['RED_APPGTO','STO_STPGTO']) then
  Begin
    grdDuplicDadosBAN_NOMBAN.Visible := True;
    grdDuplicDadosCARTAO.Visible := True;
  End;

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

  lblNaoTransferidos.Caption := 'Neg. Recebíveis';
  lblNegociadoA.Visible := MatchStr(objConcil.strNomCon.ToUpper, ['CIELO']);
  lblNegociado.Visible := lblNegociadoA.Visible;
  shpNegociado.Visible := lblNegociadoA.Visible;

  {*********************************************}
  {* CRIA DATASETS PARA CADASTRO DE PORTADORES *}
  {* E PLANO DE CONTAS (CONCILIAÇÃO)           *}
  {******************************************AJ*}
  qryBusCad := VS_FuncoesExternas.fICriaQuery;
  qryBusCad.SQL.Text := 'SELECT POR_CODPOR, POR_NOMPOR FROM CADPOR ORDER BY POR_CODPOR';
  qryBusCad.Open;
  cdsCadPor := TRedeCardFuncoes.CriarClientDataSet(qryBusCad);
  FreeAndNil(qryBusCad);
  qryBusCad := VS_FuncoesExternas.fICriaQuery;
  qryBusCad.SQL.Text := 'SELECT CTA_CODCTA, CTA_DESCTA FROM CADCTA ORDER BY CTA_CODCTA';
  qryBusCad.Open;
  cdsCadCta := TRedeCardFuncoes.CriarClientDataSet(qryBusCad);
  FreeAndNil(qryBusCad);
  cdsCadPor.Open;
  cdsCadCta.Open;

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
  pnlPorcenTaxaAntecipacao.Visible := MatchStr(objConcil.strTabCon, ['PAG_SEPGTO','RED_APPGTO']);

  pAtualizaTemporaria;
  cdsBaiCar.AfterScroll := pAtualizaDados;
  pSetFocus(btnConfirma);

  FConfiguracaoGrid := TConfiguracaoGrids.Create(grdDuplic,
                                                 grdDuplicDados,
                                                 fRetornaChaveGrid,
                                                 ['MCA_MARDES', 'MCA_RESCAI', 'MCA_DTATRA', 'MCA_AJUSTE',
                                                 'MCA_TRFLIB', 'NEGOCIACAO', 'NEGOCIACAO_ANT']);
end;

function TfrmRedeCardBaixaCartoes.fAdicionaCartoesPorEmpresa(strCodEmp,
  strIdenti: String; var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
  strPorCar: String = ''; strCtaCar: String = ''; strPorBad: String = ''; strCtaBad: String = '';
  strPorTax: String = ''; strCtaTax: String = ''; strForTax: String = ''; AstrEventoCredito : String = '';
  AstrEventoTaxa : String = ''; strEveDeb: String = '';
  strCtaAnt: String = ''; intAutoIncremInicial: Int64 = 0): Integer;
  Var
    LBanMcaDS: TBanMcaDS;
begin
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
    Application.ProcessMessages;

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
    LBanMcaDS.strAutInc := TRedeCardFuncoes.IIF(intAutoIncremInicial > 0,
                               TRedeCardFuncoes.fFormataAutInc(intAutoIncremInicial,
                                                               VS_FuncoesExternas.fIRetEmpresaLogada),
                               intAutoIncremInicial);
    AListaBanMca.Add(LBanMcaDS);

    If intAutoIncremInicial > 0 Then
      Inc64(intAutoIncremInicial);

    cdsCloneConsulta.Next;
  End;

  Result := cdsCloneConsulta.RecordCount;
end;

procedure TfrmRedeCardBaixaCartoes.pAtualizaDados(DataSet: TDataSet);
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

  edtForTax.Text := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('FOR_NOMFOR').AsString), '',
                        cdsBaiCar.FieldByName('CAR_FORTAX').AsString + '-' + cdsBaiCar.FieldByName('FOR_NOMFOR').AsString);
  edtEveDeb.Text := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString), '',
                        cdsBaiCar.FieldByName('CAR_EVEDEB').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString);
  edtEventoBaixa.Text := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString), '',
                        cdsBaiCar.FieldByName('CAR_EVECRE').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString);

  if cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S' then
    edtEventoTaxaBaixa.Text := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString), '',
                                   cdsBaiCar.FieldByName('CAR_EVETAX').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString)
  else
    edtEventoTaxaBaixa.Text := cdsBaiCar.FieldByName('MCA_EVECAN').AsString + '-' +
                               TRedeCardFuncoes.RetornaNomeCentroDeCustos(cdsBaiCar.FieldByName('MCA_EVECAN').AsString);

  edtPorBai.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAI').AsString) Then
  Begin
    cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORBAI').AsString, []);
    edtPorBai.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                      cdsCadPor.FieldByName('POR_NOMPOR').AsString;
  End;


  edtCtaBai.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTABAI').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTABAI').AsString, []);
    edtCtaBai.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;

  edtPorTax.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORTAX').AsString) Then
  Begin
    cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORTAX').AsString, []);
    edtPorTax.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                      cdsCadPor.FieldByName('POR_NOMPOR').AsString;
  End;

  edtCtaTax.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTATAX').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTATAX').AsString, []);
    edtCtaTax.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;


  edtPorDeb.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString) Then
  Begin
    cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORBAD').AsString, []);
    edtPorDeb.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                      cdsCadPor.FieldByName('POR_NOMPOR').AsString;
  End;

  edtCtaDeb.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTABAD').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTABAD').AsString, []);
    edtCtaDeb.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;

  edtCtaAnt.Text := '';
  If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('CAR_CTAANT').AsString) Then
  Begin
    cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTAANT').AsString, []);
    edtCtaAnt.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                      cdsCadCta.FieldByName('CTA_DESCTA').AsString;
  End;

  edtAntTax.Text := fRetornaValorAntecipacao;

  edtValTax.Text := FormatFloat('#,##0.00', TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat -
                                                                           cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat, 2));

  edtHist02.Hint     := edtHist02.Text;
  edtHist02.ShowHint := True;

  btnAjuVal.Enabled := (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S');
  lblFornecedorTaxa.Caption   := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S',
                                                      'Fornecedor Taxa:',
                                                      'Fornecedor Canc.:');
  lblCentroDeCustosTaxa.Caption   := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S',
                                                          'Ctr. Custo Taxa:',
                                                          'Ctr. Custo Canc.:');
end;


procedure TfrmRedeCardBaixaCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  FLiberacaoTransferencia := False;
  If TRedeCardFuncoes.FExisteCampoLiberacaoTransferencia Then
    FLiberacaoTransferencia := TRedeCardFuncoes.RetornaValorCfg('CFG_USAAUT', VS_FuncoesExternas.fIRetEmpresaLogada).Equals('S');

  cdsBaiCar := TUniClientDataSet.Create(Self);
  qryBaiCar := VS_FuncoesExternas.fICriaQuery;
  qryBaiCar.OnFilterRecord := pFilterRecord;
  dtsBaiCar := TRedeCardFuncoes.fCriaDataSource(cdsBaiCar);

  cdsBaiCar.AggregatesActive := True;

  grdDuplicDados.DataController.DataSource := dtsBaiCar;
  {*******************************************}

  blnConcil   := False;
  blnInconsist:= False;
  blnGraAju   := False;

  SetLength(arrSeqLanLoc, 0);

  frxPreviaCartoesConc.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
end;


procedure TfrmRedeCardBaixaCartoes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmRedeCardBaixaCartoes.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharFormPai Then
    btnSairBaixa.Click;
end;

procedure TfrmRedeCardBaixaCartoes.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not TRedeCardFuncoes.fEmptyStr(strCampoFiltro) Then
  Begin
    If strCampoFiltro = 'MCA_VALSTA' Then
      Accept := (Pos(strValorFiltro, FloatToStrF(DataSet.FieldByName(strCampoFiltro).AsFloat, ffNumber, 12, 2)) > 0)
    Else
      Accept := (Pos(strValorFiltro, AnsiUpperCase(DataSet.FieldByName(strCampoFiltro).AsString)) > 0);
  End;
end;

procedure TfrmRedeCardBaixaCartoes.pVisualizaNroPedido;
begin
  grdDuplicDadosMCA_NUMPOK.Visible := TRedeCardFuncoes.RetornaValorCfg('CFG_NPEDBX').Equals('S');
end;

procedure TfrmRedeCardBaixaCartoes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(grdDuplic);
end;

procedure TfrmRedeCardBaixaCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);

  pDeletaTemporaria;
end;

procedure TfrmRedeCardBaixaCartoes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Assigned(cdsCadPor) Then
    FreeAndNil(cdsCadPor);
  If Assigned(cdsCadCta) Then
    FreeAndNil(cdsCadCta);
  If Assigned(FRegistrosConciliar) Then
    FreeAndNil(FRegistrosConciliar);
end;

procedure TfrmRedeCardBaixaCartoes.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRedeCardBaixaCartoes.CartoesPendentesDeConciliacao;
  Var
    LCartoes: String;
begin

  If Not Self.FExibirCartoesPendente Then
    Exit;

  LCartoes := fGetCartoes;

  If LCartoes.IsEmpty Then
    Exit;

  Try
    FCartoesPendentesDeConciliacao := VS_FuncoesExternas.fICriaQuery;
    Try
      FCartoesPendentesDeConciliacao.Close;
      FCartoesPendentesDeConciliacao.SQL.Clear;
      FCartoesPendentesDeConciliacao.SQL.Text := 'SELECT                                '+
                                                 '  AUTOINCREM,                         '+
                                                 '  MCA_NUMCCD,                         '+
                                                 '  MCA_NUMNSU,                         '+
                                                 '  MCA_CODEMP,                         '+
                                                 '  MCA_PARCEL,                         '+
                                                 '  MCA_CODCAR,                         '+
                                                 '  MCA_DTACAD,                         '+
                                                 '  MCA_DTAVEN,                         '+
                                                 '  MCA_VALSTA,                         '+
                                                 '  MCA_VALDUP                          '+
                                                 'FROM                                  '+
                                                 '  MOVCAR                              '+
                                                 'WHERE MCA_DTAREC IS NULL              '+
                                                 '  AND MCA_CODCAR IN (' + LCartoes + ')'+
                                                 '  AND MCA_DTAVEN BETWEEN :DTAINI      '+
                                                 '  AND :DTAFIN                         '+
                                                 'ORDER BY MCA_CODCAR, MCA_DTAVEN       ';

      FCartoesPendentesDeConciliacao.ParamByName('DTAINI').AsDateTime := Self.FDataInicialConciliacao;
      FCartoesPendentesDeConciliacao.ParamByName('DTAFIN').AsDateTime := Self.DataFinalConciliacao;

      FCartoesPendentesDeConciliacao.Open;

      If FCartoesPendentesDeConciliacao.IsEmpty Then
        Exit;

      VS_FuncoesExternas.fIMensagem('AVISO', 'A seguir será exibido os cartões pendentes de conciliação.', ['&Ok']);

      VS_FuncoesExternas.prcIExecutaRelatorio(466,
                                              33623,
                                              [],
                                              ['DTAINI', 'DTAFIN', 'CARTOES'],
                                              [FormatDateTime('dd/mm/yyyy', dtaDtaIni),
                                               FormatDateTime('dd/mm/yyyy', dtaDtaFim),
                                               LCartoes.Replace(',', '_').Replace('''', EmptyStr)],
                                              Nil,
                                              Nil,
                                              True);

      If VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Exportar para CSV?', ['&Sim', '&Não'], 2) = 1 Then
        TRedeCardFuncoes.ExecutaAguarde(ExportarCSVCartoesPendentesDeConciliacao,
                                        'Aguarde... Gerando arquivo CSV.');
    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(FCartoesPendentesDeConciliacao);
  End;

end;

procedure TfrmRedeCardBaixaCartoes.pCarregaArrayNegociacao;
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

  //Apenas para conciliação automática
  Application.ProcessMessages;

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
    LTipoAjuste := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

    While Not cdsBaiCar.Eof Do
    Begin
      LGerarNovo := Concat(cdsBaiCar.FieldByName('MCA_CODEMP').AsString,
                           FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAREC').Value),
                           cdsBaiCar.FieldByName('CAR_PORBAI').AsString,
                           cdsBaiCar.FieldByName('CAR_CTABAI').AsString,
                           cdsBaiCar.FieldByName('CAR_FORTAX').AsString,
                           TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C')) <>
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
        FArrayNegociacao[LContador - 1].strHisDoc := 'NEGOCIAÇÃO DE RECEBÍVEIS ' + objConcil.strNomCon.ToUpperInvariant + ' - Emp. ' + LCodigoEmpresa + ' - ' + strHisDoc;
        FArrayNegociacao[LContador - 1].intPagCon := intCtpCon;
        FArrayNegociacao[LContador - 1].strTipAju := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

        LCodigoEmpresa := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
        LDataRecebimento := cdsBaiCar.FieldByName('MCA_DTAREC').Value;

        LValorRecebido := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
        If TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat, 2) > 0 Then
        Begin
          LValorRecebido := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          LValorTaxa := cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat;
        End;

        LPortador := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
        LPlanoDeContas := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
        LFornecedor := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
        LTipoAjuste := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
      End
      Else
      Begin
        If TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat, 2) > 0 Then
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
    FArrayNegociacao[LContador - 1].strHisDoc := 'NEGOCIAÇÃO DE RECEBÍVEIS ' + objConcil.strNomCon.ToUpperInvariant + ' - Emp. ' + LCodigoEmpresa + ' - ' + strHisDoc;
    FArrayNegociacao[LContador - 1].intPagCon := intCtpCon;
    FArrayNegociacao[LContador - 1].strTipAju := LTipoAjuste;
  Finally
    cdsBaiCar.Filter := LFiltroAnterior;
  End;
end;

function TfrmRedeCardBaixaCartoes.VerificacoesParaBaixa: Boolean;
begin
  Result := True;
  
  If TBaixaCartoes.VerificaSeHouveAlteracaoNosCartoesAntesDaBaixa(cdsBaiCar) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Existem cartões que estão sendo baixados que sofreram uma alteração posterior a pesquisa.' + #13 +
                                             'Carregue os cartões novamente para efetuar as baixas corretamente!', ['&Ok']);
    Result := False;
  End;
end;

function TfrmRedeCardBaixaCartoes.fVerificaPorCta: Boolean;
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

procedure TfrmRedeCardBaixaCartoes.pLimpaDados;
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

procedure TfrmRedeCardBaixaCartoes.pManipulaPanels(Habilita: Boolean);
begin
  pnlBotoesBaixa.Enabled := Habilita;
  pnlAux2.Enabled := Habilita;
  pnlDadosDup.Enabled := Habilita;
end;

procedure TfrmRedeCardBaixaCartoes.pCalculaTotalDuplicatas;
  Var
    prcScroll: TprcScroll;
begin
  TRedeCardFuncoes.pDisableControls(cdsBaiCar, prcScroll);

  edtAjuTot.Text    := FormatFloat('#,##0.00;-#,##0.00', TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_AJUTOT'));
  edtAjuSel.Text    := FormatFloat('#,##0.00;-#,##0.00', TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_AJUSEL'));
  edtTotDup.Text    := FormatFloat('#,##0.00;-#,##0.00', TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_VALSTA') +
                                                         (TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_AJUSEL') * TRedeCardFuncoes.IIF(TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_VALSTA') >= 0, 1, -1)));
  edtTotDupLiq.Text := FormatFloat('#,##0.00;-#,##0.00', TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_VALTOT'));
  edtQtdDup.Text    := '( ' + IntToStr(TRedeCardFuncoes.fIntAggregate(cdsBaiCar, 'TOT_SELQTD')) + ' )';
  edtTotSel.Text    := FormatFloat('#,##0.00;-#,##0.00', TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_SELSTA'));
  edtTotSelLiq.Text := FormatFloat('#,##0.00;-#,##0.00', TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_SELTOT') +
                                                         (TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_AJUSEL') * TRedeCardFuncoes.IIF(TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_SELSTA') >= 0, 1, -1)));
  edtQtdSel.Text    := '( ' + IntToStr(TRedeCardFuncoes.fIntAggregate(cdsBaiCar, 'TOT_SELQTD')) + ' )';

  TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);
end;

procedure TfrmRedeCardBaixaCartoes.btnRelatorioClick(Sender: TObject);
begin
  inherited;
  If (Not TBitBtnLocked(Sender).Visible) Or (Not TBitBtnLocked(Sender).Enabled) Then
    Exit;

  VS_FuncoesExternas.prcIExecutaRelatorio(470,
                                          33914,
                                          [],
                                          ['AUTINC',
                                           'DESCRI',
                                           'EXBARQCON',
                                           'EXBRESBAN',
                                           'EXBTOTPVE',
                                           'EXBREGFAL',
                                           'ORDENACAO'],
                                          [FFiltrosRelatorio.AutoIncrem,
                                           FFiltrosRelatorio.FiltrosDescri,
                                           TRedeCardFuncoes.IIF(FFiltrosRelatorio.ExibeArquivos, 'Sim', 'Não'),
                                           TRedeCardFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoBandeira, 'Sim', 'Não'),
                                           TRedeCardFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoPontoDeVenda, 'Sim', 'Não'),
                                           TRedeCardFuncoes.IIF(FFiltrosRelatorio.ExibeFaltantes, 'Sim', 'Não'),
                                           TRedeCardFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 0, 'Data da Venda',
                                                                TRedeCardFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 1,
                                                                                     'Data de Vencimento', 'Número RV'))
                                           ],
                                          Nil,
                                          Nil,
                                          True);
end;

function TfrmRedeCardBaixaCartoes.ApenasBaixaDeTransferencias: Boolean;
  Var
    LSequenciais: TSequenciaisBaixaCartao;
begin
  Result := False;

  If Not cdsBaiCar.IsEmpty Then
    Exit;

  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';

  If cdsBaiCar.Locate('REGISTROTRANSFERENCIA', 'S', []) Then
  Begin
    Result := True;

    If VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'O período selecionado possui apenas registros de transferências para serem lançados.' + #13 +
                                                'Deseja continuar com os lançamentos?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      LSequenciais := TSequenciaisBaixaCartao.Create;

      Try
        Inc64(LSequenciais.intSeqLan, cdsBaiCar.RecordCount * 2);
        LSequenciais.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, LSequenciais.intSeqLan), 4, 14).ToInt64;
        LSequenciais.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(LSequenciais.intSeqLan).ToInt64;

        VS_FuncoesExternas.fIStartTransaction;
        TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                  objConcil.strNomCon,
                                                  LSequenciais);

        If MatchStr(objConcil.strTabCon, ['RED_EFIR34']) Then
          TBaixaCartoes.MarcarComoConciliado(objConcil,
                                             cdsBaiCar)
        Else
          TBaixaCartoes.MarcarComoConciliadoRedeCardAPI(objConcil,
                                                        cdsBaiCar);
        VS_FuncoesExternas.fICommit;

        VS_FuncoesExternas.fIMensagem('AVISO', 'Lançamentos de transferências realizados com sucesso.', ['&Ok']);
      Except
        On E: Exception Do
        Begin
          VS_FuncoesExternas.fIRollBack;
          VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao gravar as transferências.' + #13 +
                         'Erro gerado: ' + E.Message, '[TfrmBaixaCartoes.ApenasBaixaDeTransferencias]');
        End;
      End;
    End;

    blnFecharFormPai := True;

    FreeAndNil(LSequenciais);

  End;

  cdsBaiCar.Filter      := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
end;

procedure TfrmRedeCardBaixaCartoes.btnAjuValClick(Sender: TObject);
  Var
    fltValDig: Double;
    blnConfir: Boolean;
    prcScroll: TprcScroll;
    frmDigValor : TfrmDigValor;

    LTextoLiberacao: TStringList;
begin
  inherited;
  If (Not TBitBtnLocked(Sender).Visible) Or (Not TBitBtnLocked(Sender).Enabled) Then
    Exit;

  If (not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Or (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'S') Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Nenhum cartão válido selecionado!', ['&Ok']);
    Exit;
  End;

  TRedeCardFuncoes.pCriarFormularios(TfrmDigValor, frmDigValor);
  frmDigValor.blnPermiteZero      := False;
  frmDigValor.blnPermiteMenorZero := False;
  frmDigValor.blnConciliacao      := True;
  frmDigValor.Caption             := 'Digite o valor a ser ajustado';
  frmDigValor.ShowModal;

  fltValDig := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(frmDigValor.edtValor.Text), 0,
                                    TRedeCardFuncoes.fStrToFloat(frmDigValor.edtValor.Text) *
                                    TRedeCardFuncoes.IIF(frmDigValor.cmbTipVal.ItemIndex = 0, 1, -1));


  blnConfir := (fltValDig <> 0) And (frmDigValor.ModalResult = mrOK) ;

  FreeAndNil(frmDigValor);

  If Not blnConfir Then
    Exit;

  //Cancela se digitar um valor maior ou igual que o valor sem taxa (bruto)
  If TRedeCardFuncoes.fFormataFloat(fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat, 2) > TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'O valor recebido não pode ser maior que o valor sem taxa do cartão.', ['&Ok']);
    Exit;
  End;

  If TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALREC').AsFloat + fltValDig, 2) <= 0 Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'O valor recebido não pode ser menor ou igual a zero. Verifique o valor ajustado.', ['&OK']);
    Exit;
  End;

  If (Not VS_FuncoesExternas.fIVerificaAcessoSistema('CARAJUVALCON', VS_FuncoesExternas.fIRetOperadorLogado)) Then
  Begin
    LTextoLiberacao := TStringList.Create;

    Try
      LTextoLiberacao.Add('CONCILIAÇÃO DE CARTÕES - AJUSTE DE VALOR');
      LTextoLiberacao.Add('');
      LTextoLiberacao.Add('Totais da Conciliação: ' + objConcil.strNomCon);
      LTextoLiberacao.Add('Data de recebimento: ' + FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime));
      LTextoLiberacao.Add('Valor total bruto: ' + FormatFloat(',0.00', TRedeCardFuncoes.fStrToFloat(edtTotSel.Text)));
      LTextoLiberacao.Add('Valor total líquido: ' + FormatFloat(',0.00', TRedeCardFuncoes.fStrToFloat(edtTotSelLiq.Text)));
      LTextoLiberacao.Add('Valor total líquido após ajuste: ' + FormatFloat(',0.00', fltValDig + TRedeCardFuncoes.fStrToFloat(edtTotSelLiq.Text)));
      LTextoLiberacao.Add('');

      LTextoLiberacao.Add('--------------------------------------------------------------------------------------------------------------------------------------------');
      LTextoLiberacao.Add('| NUM. LIBERAÇÃO | NSU               | EMP. | NUM. NOTA            | DT.CAD.  | DT.VEN   | VALOR BRUTO  | VALOR LIQ. ATUAL |  VALOR AJUST. |');
      LTextoLiberacao.Add(' -------------------------------------------------------------------------------------------------------------------------------------------');
      LTextoLiberacao.Add(Concat('| ',
                                 LeftStr(TRedeCardFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_NUMCCD').AsString, 15), 15),
                                 '| ',
                                 LeftStr(TRedeCardFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_NUMNSU').AsString, 17), 17),
                                 ' | ',
                                 LeftStr(TRedeCardFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_CODEMP').AsString, 4), 4),
                                 ' | ',
                                 LeftStr(TRedeCardFuncoes.fPadR(cdsBaiCar.FieldByName('MCA_NUMNOT').AsString, 21), 21),
                                 '| ',
                                 FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime),
                                 ' | ',
                                 FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime),
                                 ' | ',
                                 TRedeCardFuncoes.fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat), 12),
                                 ' | ',
                                 TRedeCardFuncoes.fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALREC').AsFloat), 16),
                                 ' | ',
                                 TRedeCardFuncoes.fPadL(FormatFloat(',0.00', fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat), 13),
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
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat  := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> 0,
                                                                       (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100,
                                                                       0.000000);
  cdsBaiCar.Post;

  TRedeCardFuncoes.pDisableControls(cdsBaiCar, prcScroll);
  TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);
  pCalculaTotalDuplicatas;
end;

procedure TfrmRedeCardBaixaCartoes.btnConfigurarGridClick(Sender: TObject);
Var
  LConfiguracaoGrids: TfrmConfiguracaoGrids;
begin
  inherited;

  If Not cdsBaiCar.Active Then
  Begin
    VS_FuncoesExternas.fIMensagem('AVISO', 'É necessario o carregamento dos cartões para utilização da configuração', ['&Ok']);
    Exit;
  End;

  TRedeCardFuncoes.pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  Try
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := fRetornaChaveGrid;
    LConfiguracaoGrids.DatasetCampos := grdDuplicDados.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(grdDuplicDados);
  Finally
    FreeAndNil(LConfiguracaoGrids);
  End;
end;

procedure TfrmRedeCardBaixaCartoes.btnConfirmaClick(Sender: TObject);
  Var
    LRegistroAtual: Integer;

    strPortad: String;
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
  TRedeCardFuncoes.pDisableControls(cdsBaiCar, prcScroll);
  blnConfir := True;

  If (fVerificaPorCta) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Para baixa através de conciliação automática, é necessário que todos os cartões selecionados estejam com as configurações de Portadores e Planos de Contas configurados.' + #13 +
                                             'Para cancelamentos/ajustes, o Código do Estabelecimento da operadora do cartão também deve estar vinculado a empresa da baixa.' + #13 +
                                             'Para baixa de antecipações, é necessário que todos os cartões selecionados estejam com a configuração de Planos de Contas para antecipação configurado.',
                                             ['OK'], 1, False, 1, 0, False, 0);
    blnConfir := False;
  End;

  strPortad := fValidaPortadores;
  If (blnConfir) And (Not TRedeCardFuncoes.fEmptyStr(strPortad)) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'O(s) portador(res) ' + strPortad + ' não possui(em) permissão para realizar baixa!',['&O K']);
    blnConfir := False;
  End;

  If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) and not(fValidaEventos) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Para baixa através de conciliação automática, é necessário que todos os cartões envolvidos '+
    'estejam com os Centro de Custos configurados. Também é necessário que e os Centro de Custos de cancelamento\ajuste estejam parametrizados '+
    'na empresa correspondente ao ponto de venda.',
    ['OK']);
    blnConfir := False;
  End;

  If ((Not TRedeCardFuncoes.fEmptyStr(edtTotSel.Text))  And
     (TRedeCardFuncoes.fStrToFloat(edtTotSel.Text) = 0)) And
    ((Not TRedeCardFuncoes.fEmptyStr(edtAjuSel.Text))  And
     (TRedeCardFuncoes.fStrToFloat(edtAjuSel.Text) = 0)) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Não é possível efetuar a baixa pois não possui valor selecionado.', ['&OK']);
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
        VS_FuncoesExternas.fIMensagem('','É necessário selecionar ao menos um registro!',['&O K']);
        blnConfir := False;
      End;
    End;

  End
  Else If blnConfir Then
  Begin
    VS_FuncoesExternas.fIMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    blnConfir := False;
  End;

  //Limite de valor de lançamentos se a tela for chamada pela nova
  //tela de conciliação bancária
  if (blnConfir) And (fltValorBaixa > 0) And (strCodPorFix <> '') then
  begin
    fltValSel := 0;
    if edtTotSelLiq.Text <> '' then
       fltValSel := TRedeCardFuncoes.fStrToFloat(edtTotSelLiq.Text);

    if  TRedeCardFuncoes.fFormataFloat(fltValSel, 2) < TRedeCardFuncoes.fFormataFloat(fltValorBaixa, 2) then
    begin
      VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Não é possível efetuar a baixa, o valor é menor que o valor para baixa!' + #13 + #13 +
                                                'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa), ['&Ok']);
      blnConfir := False;
    end;
  end;

  If (blnConfir) And (TBaixaCartoes.VerificaSeHaCartoesBaixadosAntesDaBaixa(cdsBaiCar)) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Existem cartões marcados que foram baixados por outro usuário. Realize a pesquisa novamente para efetuar a baixa desses cartões!', ['&OK']);
    blnConfir := False;
  End;

  If (blnConfir) And
     (((Not TRedeCardFuncoes.fEmptyStr(edtTotSel.Text))  And
       (TRedeCardFuncoes.fStrToFloat(edtTotSel.Text) > 0)) Or
      ((Not TRedeCardFuncoes.fEmptyStr(edtAjuSel.Text))  And
       (TRedeCardFuncoes.fStrToFloat(edtAjuSel.Text) <> 0))) Then
  Begin
    pManipulaPanels(False);

    If Assigned(cdsCloneConsulta) Then
      FreeAndNil(cdsCloneConsulta);

    If fBaixaDuplicatas Then
    Begin

      VS_FuncoesExternas.fIMensagem('AVISO', 'Baixa de cartão realizada com sucesso!', ['&O k']);

      btnSairBaixa.Click;

      if (fltValorBaixa > 0) and (strCodPorFix <> '') then
      begin
        btnSairBaixa.Click;
        Exit;
      end;

    End;
    pManipulaPanels(True);
    TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);
    pSetFocus(grdDuplic);
  End
  Else
    TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);

end;

function TfrmRedeCardBaixaCartoes.fGravaCartoes(pgbStatus: TcxProgressBar): Boolean;
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
begin
  Application.ProcessMessages;
  Try
    cdsAux := TRedeCardFuncoes.CriarClientDataSet(cdsBaiCar);

    cdsAux.DisableControls;
    cdsAux.Filtered := False;
    cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');
    cdsAux.Filtered := True;
    intMax := cdsAux.RecordCount;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := intMax;
    blnConfirma := True;
    Application.ProcessMessages;

    LSeqLanFrete := EmptyStr;
    LSeqLanAjuste := EmptyStr;
    LSeqLanCupom := EmptyStr;

    VS_FuncoesExternas.fIStartTransaction;
    intCtpCon := VS_FuncoesExternas.fIRetCtpCon;
    VS_FuncoesExternas.fICommit;

    pCarregaArrAjustes;

    objSequencias := TBaixaCartoes.RetornaSequenciaisParaBaixaAnalitica(cdsAux,
                                                                        False,
                                                                        Not TRedeCardFuncoes.fEmptyStr(strPorBad),
                                                                        False,
                                                                        Length(arrBaiSinDeb));
    objSequencias.SequencialControleBaixaPagar := intCtpCon;
    objSequencias.NumeroDocumentoBaixa := strNumDoc;

    strHistor := strHisDoc;

    VS_FuncoesExternas.fIStartTransaction;

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
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);

      If cdsAux.FieldByName('MCA_MARDES').AsString = 'M' Then
      Begin
        TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(FRegistroCTPDetFrete,
                                                              FRegistroCTPDetAjuste,
                                                              cdsAux);

        If Not TRedeCardFuncoes.fEmptyStr(cdsAux.FieldByName('HISTORICO_BAIXA').AsString) Then
        Begin
          If (Pos(cdsAux.FieldByName('HISTORICO_BAIXA').AsString,strHistor) <= 0) Then
            strHistor := cdsAux.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHistor;

          If (Pos(cdsAux.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
            strHisDoc := cdsAux.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
        End;

        If TRedeCardFuncoes.fEmptyStr(strHistor) Then
          strHisDoc := 'Rec. ' + cdsAux.FieldByName('CAR_DESCAR').AsString;

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
        LBanMcaDS.strAutInc := TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

        Inc64(objSequencias.intContadorAutIncBanMca);

        LListaBanMca := TListaBanMCA.Create;
        LListaBanMca.Add(LBanMcaDS);

        LValorCredito := cdsAux.FieldByName('MCA_VALSTA').AsFloat;

        {*****************************************}
        {* GRAVA MOVBAN DO CARTÃO                *}
        {**************************************MV*}
        strSeqLanCre  := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTABAI').AsString,  // Centro de Custo
                                                       cdsAux.FieldByName('CAR_PORBAI').AsString,  // Portador
                                                       VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                       cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                       TRedeCardFuncoes.fTime(),                              // Hora do Lançamento
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
                                                       TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                       '',
                                                       '',
                                                       1,
                                                       True,
                                                       LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLanCre));

        If blnConfirma Then
          pAtualizaDataMovimentobancarioMovCar(cdsAux.FieldByName('AUTOINC').AsString, cdsAux.FieldByName('MCA_DTAREC').AsDateTime);

        If blnConfirma And
           (Not TRedeCardFuncoes.fEmptyStr(cdsAux.FieldByName('CAR_PORBAD').AsString)) Then
        Begin
          if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
          begin
            SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
            arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanCre;
          end;

          LBanMcaDS.strIdenti := 'VALSTA';
          LBanMcaDS.strAutInc := TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

          Inc64(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          {*****************************************}
          {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
          {**************************************MV*}
          strSeqLan   := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTABAD').AsString,  // Centro de Custo
                                                       cdsAux.FieldByName('CAR_PORBAD').AsString,  // Portador
                                                       VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                       cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                       TRedeCardFuncoes.fTime(),                              // Hora do Lançamento
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
                                                       TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                       '',
                                                       '',
                                                       1,
                                                       True,
                                                       LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLan));
        End;

        {************************************}
        {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
        {*********************************JU*}

        If (cdsAux.FieldByName('MCA_VALTAX').Value <> 0) And (blnConfirma) Then
        Begin
          LBanMcaDS.strIdenti := 'VALTAX';
          LBanMcaDS.strAutInc := TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

          Inc64(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          LValorTotalTaxa := TRedeCardFuncoes.fFormataFloat(cdsAux.FieldByName('MCA_VALTAX').AsFloat -
                                                            cdsAux.FieldByName('MCA_ANTTAX').AsFloat, 2);

          {*****************************************}
          {* GRAVA MOVBAN DA TAXA                  *}
          {**************************************MV*}
          strSeqLanTax := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTATAX').AsString,  // Centro de Custo
                                                        cdsAux.FieldByName('CAR_PORTAX').AsString,  // Portador
                                                        VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                        cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                        TRedeCardFuncoes.fTime(),                              // Hora do Lançamento
                                                        strNumDoc,                            // Documento
                                                        'D',                                  // Credito / Debito
                                                        VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                        LValorTotalTaxa,                      // Valor Documento
                                                        TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
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
                                                        TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                        '',
                                                        '',
                                                        1,
                                                        True,
                                                        LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLanTax));

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

            strNumDup := 'G' + TRedeCardFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

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
                                                         TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
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
                                                         TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                                         TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

            Inc64(objSequencias.intContadorAutIncCadPag);
            Inc64(objSequencias.intContadorAutIncLogCtp);
            Inc64(objSequencias.intSequencialCadPag);

            If blnConfirma Then
              TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceAnalitico(strNumDup,
                                                                      cdsAux.FieldByName('CAR_FORTAX').AsString,
                                                                      cdsAux.FieldByName('MCA_CODEMP').AsString,
                                                                      'CRT',
                                                                      cdsAux.FieldByName('CAR_CTATAX').AsString,
                                                                      cdsAux.FieldByName('CAR_EVETAX').AsString,
                                                                      LValorTotalTaxa,
                                                                      FRegistroCTPDetFrete,
                                                                      FRegistroCTPDetAjuste);

          End;
        End;

        {******************************}
        {* GRAVA TAXAS DE ANTECIPAÇÃO *}
        {***************************AJ*}
        If (cdsAux.FieldByName('MCA_ANTTAX').Value <> 0) And (blnConfirma) Then
        Begin
          LBanMcaDS.strIdenti := 'ANTTAX';
          LBanMcaDS.strAutInc := TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

          Inc64(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          {*****************************************}
          {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO   *}
          {**************************************AJ*}
          strSeqLanAnt := TLibCartoesMovBan.GravaMovBan(cdsAux.FieldByName('CAR_CTAANT').AsString,  // Centro de Custo
                                                        cdsAux.FieldByName('CAR_PORTAX').AsString,  // Portador
                                                        VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                        cdsAux.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                        TRedeCardFuncoes.fTime(),                              // Hora do Lançamento
                                                        strNumDoc,                            // Documento
                                                        'D',                                  // Credito / Debito
                                                        VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                        cdsAux.FieldByName('MCA_ANTTAX').AsFloat,    // Valor Documento
                                                        TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(strHistor), 'Pag. de Tx Antecip. Ref. Aos Cartões',
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
                                                        TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                        '',
                                                        '',
                                                        1,
                                                        True,
                                                        LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLanAnt));

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

            strNumDup := 'G' + TRedeCardFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

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
                                                         TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(strHistor), 'Pag. de Tx Atecip. Ref. Aos Cartões',
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
                                                         TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                                         TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

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
                                                       TRedeCardFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                            '', cdsAux.FieldByName('CAR_CTAANT').AsString),
                                                       TRedeCardFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                            '', strSeqLanAnt),
                                                       TRedeCardFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                            0, cdsAux.FieldByName('MCA_ANTTAX').AsFloat),
                                                       TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                                       LSeqLanCupom);

          Inc64(objSequencias.intContadorAutIncLogMca);

          If (blnConfirma) and objConcil.strTabCon.Equals('RED_EFIR34') Then
          Begin
            SetLength(arrNumNsu, Length(arrNumNsu) + 1);

            arrNumNsu[Length(arrNumNsu) - 1] := TRedeCardFuncoes.fPadL(cdsAux.FieldByName('MCA_NUMNSU').AsString, 14, '0');
          End;

        End;

      End;

      If Not blnConfirma Then
        Break;

        cdsAux.Next;
    End;

    If blnConcil Then
    Begin
      If blnConfirma Then
        TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                  objConcil.strNomCon,
                                                  objSequencias);
    End;

    If blnConfirma Then
    Begin
      If MatchStr(objConcil.strTabCon, ['RED_EFIR34']) Then
        TBaixaCartoes.MarcarComoConciliado(objConcil,
                                           cdsBaiCar)
      Else
        TBaixaCartoes.MarcarComoConciliadoRedeCardAPI(objConcil,
                                                      cdsBaiCar);
    End;

    If Not blnConfirma Then
      Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!')
    Else
      blnConfirmaBaixa := True;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;
      blnConfirmaBaixa := False;
      Result := false;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoes]');
      FreeAndNil(cdsAux);
      Exit;
    End;
  End;

  FreeAndNil(cdsAux);

  If Assigned(LListaBanMca) Then
    FreeAndNil(LListaBanMca);

  If Assigned(objSequencias) Then
    FreeAndnIl(objSequencias);

  Result := True;
end;

function TfrmRedeCardBaixaCartoes.fGetCartoes: String;
  Var
    stlCartos: TStringList;
    intIndice: Integer;
    prcScroll: TprcScroll;
Begin
  stlCartos := TStringList.Create;
  stlCartos.Sorted := True;
  stlCartos.Clear;

  TRedeCardFuncoes.pDisableControls(cdsBaiCar, prcScroll);
  cdsBaiCar.First;
  While Not cdsBaiCar.Eof Do
  Begin
    If (cdsBaiCar.FieldByName('MCA_MARDES').AsString <> 'M') Then
    Begin
      cdsBaiCar.Next;
      Continue;
    End;

    If cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'N' Then
    Begin
      If Not stlCartos.Find(cdsBaiCar.FieldByName('MCA_CODCAR').AsString.QuotedString, intIndice) Then
        stlCartos.Add(cdsBaiCar.FieldByName('MCA_CODCAR').AsString.QuotedString);
    End;

    cdsBaiCar.Next;
  End;

  Result := stlCartos.CommaText;
  stlCartos.Clear;
  FreeAndNil(stlCartos);

  TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);
End;

{*****************************************}
{* BAIXA AS DUPLICATAS SELECIONADAS      *}
{**************************************MV*}
function TfrmRedeCardBaixaCartoes.fBaixaDuplicatas: Boolean;
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
    cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE=' + QuotedStr('N');
    cdsBaiCar.Filtered := True;

    cdsCloneConsulta := TRedeCardFuncoes.CriarClientDataSet(cdsBaiCar);

    TRedeCardFuncoes.pCriarFormularios(TfrmLibCartoesBaixaCtcAnaSin, frmLibCartoesBaixaCtcAnaSin);
    frmLibCartoesBaixaCtcAnaSin.blnBaiAna    := blnBaiAna;
    frmLibCartoesBaixaCtcAnaSin.blnZeraTx    := TRedeCardFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_VALTAX') = 0;
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
      
      FreeAndNil(frmLibCartoesBaixaCtcAnaSin);
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

  FreeAndNil(frmLibCartoesBaixaCtcAnaSin);

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
  Application.ProcessMessages;
  Try
    cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    cdsBaiCar.First;
    Application.ProcessMessages;

    {*******************}
    {* BAIXA SINTÉTICA *}
    {****************AJ*}
    If blnConfirma Then
    Begin
      If Not blnBaiAna  Then
      Begin
        Try
          blnConfirmaBaixa := TRedeCardFuncoes.ExecutaAguarde(fGravaCartoesSin, 'Aguarde... Gravando cartões');
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
          blnConfirmaBaixa := TRedeCardFuncoes.ExecutaAguarde(fGravaCartoes, 'Aguarde... Gravando cartões');
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

    If blnConfirma Then
      blnConfirma := fSetaDupBaixadasRede(arrNumNsu);
  Finally
    If blnConfirma Then
      VS_FuncoesExternas.fICommit
    Else
      VS_FuncoesExternas.fIRollBack;
  End;

  CartoesPendentesDeConciliacao;

  If Assigned(cdsCloneConsulta) Then
    FreeAndNil(cdsCloneConsulta);

  Result := blnConfirma;
end;

procedure TfrmRedeCardBaixaCartoes.HabilitaPreviaCartoesConc;
begin
  If (objConcil.strNomCon.ToUpper = 'REDECARD API') Then
  Begin
    btnPreviaCartoesConc.Visible := True;
  End;
end;

procedure TfrmRedeCardBaixaCartoes.btnPreviaCartoesConcClick(Sender: TObject);
begin
  If Not Assigned(cdsBaiCar) Or (cdsBaiCar.IsEmpty) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Sem dados para imprimir!', ['&O k']);
    Exit;
  End;

  VS_FuncoesExternas.prcIExecutaRelatorio(471,
                                          34105,
                                          [],
                                          ['AUTINC'],
                                          [FFiltrosRelatorio.AutoIncrem],
                                          Nil,
                                          Nil,
                                          True);
end;

procedure TfrmRedeCardBaixaCartoes.ExibirPorcentagemTaxaDeAntecipacao;
  Var
    LValorDaAntecipacao: Double;
    LPorcenTaxaAntecipacao : Double;
begin
  LValorDaAntecipacao := 0.00;
  edtPorcentagemTaxaAntecipacao.Text := FormatFloat(',0.000000', LValorDaAntecipacao);

  If Not cdsBaiCar.FieldByName('MCA_ANTTAX').IsNull Then
    LValorDaAntecipacao := cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;

  If (LValorDaAntecipacao > 0) And (TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) > 0) Then
  Begin
    LPorcenTaxaAntecipacao := ((LValorDaAntecipacao / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100);

    edtPorcentagemTaxaAntecipacao.Text := FormatFloat(',0.000000', LPorcenTaxaAntecipacao);

    edtPerCar.Text := FormatFloat(',0.000000',(cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat -  LPorcenTaxaAntecipacao));
  end;

  edtPorcentagemTaxaAntecipacao.Text := Concat(edtPorcentagemTaxaAntecipacao.Text,' %');
End;

function TfrmRedeCardBaixaCartoes.ExportarCSVCartoesPendentesDeConciliacao(
  cxProgress: TcxProgressBar): Boolean;
  Var
    svdCsv: TSaveDialog;
    strLinha,
    strNomArq: String;
    stlCsv: TStringList;
begin
  Result := True;

  cxProgress.Position := 0;
  cxProgress.Properties.Max := FCartoesPendentesDeConciliacao.RecordCount;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin
    strNomArq := svdCsv.FileName;

    If Not TRedeCardFuncoes.fEmptyStr(strNomArq) Then
    Begin
      stlCsv := TStringList.Create;

      stlCsv.Clear;

      strLinha := TRedeCardFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada);
      stlCsv.Add(strLinha);
      stlCsv.Add('');

      strLinha := 'CARTÕES PENDENTES DE CONCILIAÇÃO';
      stlCsv.Add(strLinha);
      stlCsv.Add('');

      strLinha := 'PERÍODO DE ' + FormatDateTime('dd/mm/yyyy', Self.FDataInicialConciliacao) + ' ATÉ ' + FormatDateTime('dd/mm/yyyy', Self.DataFinalConciliacao);
      stlCsv.Add(strLinha);
      stlCsv.Add('');

      strLinha := 'NUM. LIBERAÇÃO;NSU;EMPRESA;PARCELA;CARTÃO;DATA DE CADASTRO;DATA DE VENCIMENTO;VALOR S/ TAXA;VALOR LIQUIDO';
      stlCsv.Add(strLinha);

      FCartoesPendentesDeConciliacao.First;
      While Not FCartoesPendentesDeConciliacao.Eof Do
      Begin
        strLinha := FCartoesPendentesDeConciliacao.FieldByName('MCA_NUMCCD').AsString + ';' +
                    FCartoesPendentesDeConciliacao.FieldByName('MCA_NUMNSU').AsString + ';' +
                    FCartoesPendentesDeConciliacao.FieldByName('MCA_CODEMP').AsString + ';' +
                    FCartoesPendentesDeConciliacao.FieldByName('MCA_PARCEL').AsString + ';' +
                    FCartoesPendentesDeConciliacao.FieldByName('MCA_CODCAR').AsString + ';' +
                    FormatDateTime('dd/mm/yyyy',FCartoesPendentesDeConciliacao.FieldByName('MCA_DTACAD').AsDateTime) + ';' +
                    FormatDateTime('dd/mm/yyyy',FCartoesPendentesDeConciliacao.FieldByName('MCA_DTAVEN').AsDateTime) + ';' +
                    FormatFloat('#,##0.00',FCartoesPendentesDeConciliacao.FieldByName('MCA_VALSTA').AsFloat) + ';' +
                    FormatFloat('#,##0.00',FCartoesPendentesDeConciliacao.FieldByName('MCA_VALDUP').AsFloat);
        stlCsv.Add(strLinha);
        TRedeCardFuncoes.pStepStatusGravacao(cxProgress);

        FCartoesPendentesDeConciliacao.Next;
      End;

      stlCsv.SaveToFile(strNomArq);
      FreeAndNil(stlCsv);

      VS_FuncoesExternas.fIMensagem('AVISO','Arquivo CSV gerado com sucesso!', ['&O K']);
    End;
  End;

  FreeAndNil(svdCsv);
end;

function TfrmRedeCardBaixaCartoes.fGetEmpresaAjuste(ADataset: TUniClientDataset): string;
begin
  Result := ADataset.FieldByName('MCA_CODEMP').AsString;
end;

procedure TfrmRedeCardBaixaCartoes.pCarregaArrAjustes;
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
  //Apenas para conciliação automática
  Application.ProcessMessages;

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
    strTipAju                   := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

    While Not cdsBaiCar.Eof Do
    Begin
      blnVerifi := (fGetEmpresaAjuste(cdsBaiCar) <> strCodEmp) Or
                   (cdsBaiCar.FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                   (cdsBaiCar.FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                   (cdsBaiCar.FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                   (cdsBaiCar.FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                   (cdsBaiCar.FieldByName('MCA_EVECAN').AsString <> strEventoCancelamentoAjuste) Or
                   (TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C') <> strTipAju);

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

        If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString) Then
        Begin
          If (Pos(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
            strHisDoc := cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
        End;

        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := strHisDoc + ' - Canc./Ajuste Cartões';
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := intCtpCon;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := TRedeCardFuncoes.IIF(fltValDoc < 0, 'D', 'C');
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;

        strCodEmp                   := fGetEmpresaAjuste(cdsBaiCar);
        dtaDtaRec                   := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
        fltValDoc                   := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
        strPorBai                   := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
        strCtaBai                   := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
        strTaxaFo                   := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
        strEventoCancelamentoAjuste := cdsBaiCar.FieldByName('MCA_EVECAN').AsString;
        strTipAju                   := TRedeCardFuncoes.IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
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

    If Not TRedeCardFuncoes.fEmptyStr(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString) Then
    Begin
      If (Pos(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
        strHisDoc := cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
    End;

    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(strHisDoc),'', strHisDoc + ' - ')+ 'Canc./Ajuste Cartões - Emp. ' + strCodEmp;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := intCtpCon;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := strTipAju;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;
  End;

  cdsBaiCar.Filter := strFilAnt;
end;

procedure TfrmRedeCardBaixaCartoes.pCarregaArrBaiSinCar;
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

  Application.ProcessMessages;
  SetLength(arrBaiSinCar, 0);
  SetLength(FCTPDETSintetico, 0);

  cdsBaiCar.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;'+
                               'CAR_PORBAD;CAR_CTABAD;CAR_EVEDEB;CAR_CTAANT;CAR_EVECRE;CAR_EVETAX';
  strFilAnt := cdsBaiCar.Filter;
  cdsBaiCar.Filter := 'MCA_MARDES=' + QuotedStr('M') + 'AND MCA_AJUSTE=' + QuotedStr('N') + ' AND NEGOCIACAO=''N'' ';
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
    TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(FRegistroCTPDetFrete,
                                                          FRegistroCTPDetAjuste,
                                                          cdsBaiCar);

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

    AdicionarRegistroCTPDetNoArraySintetico(FRegistroCTPDetFrete,
                                            FRegistroCTPDetAjuste,
                                            strTaxaCt,
                                            cdsBaiCar);

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

procedure TfrmRedeCardBaixaCartoes.AdicionarRegistroCTPDetNoArraySintetico(ARegistroCTPDetFrete,
                                                                   ARegistroCTPDetAjuste: TArrBaiSinCar;
                                                                   APlanoDeContas: String;
                                                                   ARegistros: TUniClientDataset);
  Var
    LGravarFrete,
    LGravarAjuste: Boolean;

    LContador,
    LPosicaoFrete,
    LPosicaoAjuste: Integer;

    LChaveComparacao,
    LChaveArrayOriginal: String;
begin
  If Not TBaixaCartoes.ValidaGravacaoCTPDet(LGravarFrete, LGravarAjuste, APlanoDeContas, FRegistroCTPDetFrete, FRegistroCTPDetAjuste) Then
    Exit;

  LChaveArrayOriginal := Concat(ARegistros.FieldByName('MCA_CODEMP').AsString,
                                ARegistros.FieldByName('MCA_DTAREC').AsString,
                                ARegistros.FieldByName('CAR_PORBAI').AsString,
                                ARegistros.FieldByName('CAR_CTABAI').AsString,
                                ARegistros.FieldByName('CAR_PORBAD').AsString,
                                ARegistros.FieldByName('CAR_CTABAD').AsString,
                                ARegistros.FieldByName('CAR_PORTAX').AsString,
                                ARegistros.FieldByName('CAR_CTATAX').AsString,
                                ARegistros.FieldByName('CAR_FORTAX').AsString,
                                ARegistros.FieldByName('CAR_EVECRE').AsString,
                                ARegistros.FieldByName('CAR_EVETAX').AsString,
                                ARegistros.FieldByName('CAR_EVEDEB').AsString,
                                ARegistros.FieldByName('CAR_CTAANT').AsString);


  LPosicaoFrete := -1;
  LPosicaoAjuste := -1;
  For LContador := 0 To Length(FCTPDetSintetico) - 1 Do
  Begin
    LChaveComparacao := Concat(FCTPDetSintetico[LContador].strCodEmp,
                               DateTimeToStr(FCTPDetSintetico[LContador].dtaDtaRec),
                               FCTPDetSintetico[LContador].strPorBai,
                               FCTPDetSintetico[LContador].strCtaBai,
                               FCTPDetSintetico[LContador].strPorBad,
                               FCTPDetSintetico[LContador].strCtaBad,
                               FCTPDetSintetico[LContador].strPorTax,
                               FCTPDetSintetico[LContador].strCtaTax,
                               FCTPDetSintetico[LContador].strForTax,
                               FCTPDetSintetico[LContador].strEventoCredito,
                               FCTPDetSintetico[LContador].strEventoTaxa,
                               FCTPDetSintetico[LContador].strEveDeb,
                               FCTPDetSintetico[LContador].strCtaAnt);

    If LChaveComparacao <> LChaveArrayOriginal Then
      Continue;

    If LGravarFrete Then
      LPosicaoFrete := TRedeCardFuncoes.IIF(ARegistroCTPDetFrete.strCtaTax = FCTPDetSintetico[LContador].PlanoDeContasParaCTPDet,
                           LContador,
                           LPosicaoFrete);

    If LGravarAjuste Then
      LPosicaoAjuste := TRedeCardFuncoes.IIF(ARegistroCTPDetAjuste.strCtaTax = FCTPDetSintetico[LContador].PlanoDeContasParaCTPDet,
                            LContador,
                            LPosicaoAjuste);
  End;

  If LGravarFrete Then
  Begin
    If LPosicaoFrete = -1 THen
    Begin
      LPosicaoFrete := Length(FCTPDetSintetico);

      SetLength(FCTPDetSintetico, Length(FCTPDetSintetico) + 1);

      FCTPDetSintetico[LPosicaoFrete].strCodEmp := ARegistros.FieldByName('MCA_CODEMP').AsString;
      FCTPDetSintetico[LPosicaoFrete].dtaDtaRec := ARegistros.FieldByName('MCA_DTAREC').Value;
      FCTPDetSintetico[LPosicaoFrete].strPorBai := ARegistros.FieldByName('CAR_PORBAI').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaBai := ARegistros.FieldByName('CAR_CTABAI').AsString;
      FCTPDetSintetico[LPosicaoFrete].strPorBad := ARegistros.FieldByName('CAR_PORBAD').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaBad := ARegistros.FieldByName('CAR_CTABAD').AsString;
      FCTPDetSintetico[LPosicaoFrete].strPorTax := ARegistros.FieldByName('CAR_PORTAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaTax := ARegistros.FieldByName('CAR_CTATAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strForTax := ARegistros.FieldByName('CAR_FORTAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEventoCredito := ARegistros.FieldByName('CAR_EVECRE').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEventoTaxa := ARegistros.FieldByName('CAR_EVETAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEveDeb := ARegistros.FieldByName('CAR_EVEDEB').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaAnt :=ARegistros.FieldByName('CAR_CTAANT').AsString;

      FCTPDetSintetico[LPosicaoFrete].PlanoDeContasParaCTPDet := ARegistroCTPDetFrete.strCtaTax;

      FCTPDetSintetico[LPosicaoFrete].fltValTax := 0.00;
    End;

    FCTPDetSintetico[LPosicaoFrete].fltValTax := FCTPDetSintetico[LPosicaoFrete].fltValTax +
                                                 TRedeCardFuncoes.fFormataFloat(ARegistroCTPDetFrete.fltValTax, 2);
  End;

  If LGravarAjuste Then
  Begin
    If ARegistroCTPDetAjuste.strCtaTax = ARegistroCTPDetFrete.strCtaTax Then
      LPosicaoAjuste := LPosicaoFrete;

    If LPosicaoAjuste = -1 THen
    Begin
      LPosicaoAjuste := Length(FCTPDetSintetico);

      SetLength(FCTPDetSintetico, Length(FCTPDetSintetico) + 1);

      FCTPDetSintetico[LPosicaoAjuste].strCodEmp := ARegistros.FieldByName('MCA_CODEMP').AsString;
      FCTPDetSintetico[LPosicaoAjuste].dtaDtaRec := ARegistros.FieldByName('MCA_DTAREC').Value;
      FCTPDetSintetico[LPosicaoAjuste].strPorBai := ARegistros.FieldByName('CAR_PORBAI').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaBai := ARegistros.FieldByName('CAR_CTABAI').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strPorBad := ARegistros.FieldByName('CAR_PORBAD').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaBad := ARegistros.FieldByName('CAR_CTABAD').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strPorTax := ARegistros.FieldByName('CAR_PORTAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaTax := ARegistros.FieldByName('CAR_CTATAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strForTax := ARegistros.FieldByName('CAR_FORTAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEventoCredito := ARegistros.FieldByName('CAR_EVECRE').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEventoTaxa := ARegistros.FieldByName('CAR_EVETAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEveDeb := ARegistros.FieldByName('CAR_EVEDEB').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaAnt :=ARegistros.FieldByName('CAR_CTAANT').AsString;

      FCTPDetSintetico[LPosicaoAjuste].PlanoDeContasParaCTPDet := ARegistroCTPDetAjuste.strCtaTax;
    End;

    FCTPDetSintetico[LPosicaoAjuste].fltValTax := FCTPDetSintetico[LPosicaoAjuste].fltValTax +
                                                  TRedeCardFuncoes.fFormataFloat(ARegistroCTPDetAjuste.fltValTax, 2);
  End;
end;

procedure TfrmRedeCardBaixaCartoes.FormShow(Sender: TObject);
begin
  inherited;
  pVisualizaNroPedido;

  dtaDtaPag := 0;
  blnAcesso := VS_FuncoesExternas.fIVerificaAcessoSistema('CARBAITODOS');

  If Not blnConcil Then
    pCriaAgrFields;

  pnlMarketPlace.Left := 0;

  pAbreConciliacao;

  HabilitaPreviaCartoesConc;

  btnConfigurarGrid.Visible := TRedeCardFuncoes.fTabelaExiste('CFGCOL_GRD');
end;

procedure TfrmRedeCardBaixaCartoes.pCriaAgrFields;
begin
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALSTA';
    FieldName     := 'TOT_VALSTA';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_VALSTA)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTOT';
    FieldName     := 'TOT_VALTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_VALTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELSTA';
    FieldName     := 'TOT_SELSTA';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELSTA)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELTOT';
    FieldName     := 'TOT_SELTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELQTD';
    FieldName     := 'TOT_SELQTD';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELQTD)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTAX';
    FieldName     := 'TOT_VALTAX';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_TOTTAX)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_AJUTOT';
    FieldName     := 'TOT_AJUTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_AJUTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_AJUSEL';
    FieldName     := 'TOT_AJUSEL';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_AJUSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
end;

function TfrmRedeCardBaixaCartoes.fGravaCartoesSin(pgbStatus: TcxProgressBar = Nil) : Boolean;
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
begin

  Application.ProcessMessages;
  strSeqLan    := '';
  strSeqLanTax := '';
  strSeqLanCre := '';
  strSeqLanAnt := '';
  strNumDup    := '';
  blnConfirma := True;

  cdsAux := TRedeCardFuncoes.CriarClientDataSet(cdsBaiCar);

  cdsAux.DisableControls;
  cdsAux.Filtered := False;
  cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');
  cdsAux.Filtered := True;

  cdsAux.First;

  Try
    Application.ProcessMessages;
    pgbStatus.Position := 0;

    VS_FuncoesExternas.fIStartTransaction;
    intCtpCon := VS_FuncoesExternas.fIRetCtpCon;
    VS_FuncoesExternas.fICommit;

    pCarregaArrBaiSinCar;
    pCarregaArrAjustes;

    pgbStatus.Properties.Max := Length(arrBaiSinCar);

    objSequencias := TBaixaCartoes.RetornaSequenciaisParaBaixaSintetica(arrBaiSinCar,
                                                                        cdsAux,
                                                                        False,
                                                                        Not TRedeCardFuncoes.fEmptyStr(strPorBad),
                                                                        False,
                                                                        Length(arrBaiSinDeb));
    objSequencias.SequencialControleBaixaPagar := intCtpCon;
    objSequencias.NumeroDocumentoBaixa := strNumDoc;

    VS_FuncoesExternas.fIStartTransaction;

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
                                                     TRedeCardFuncoes.fTime(),                        // Hora do Lançamento
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
                                                     TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                     '',
                                                     '',
                                                     1,
                                                     True,
                                                     LListaBanMca);

      Inc64(objSequencias.intSeqLan);
      Inc64(objSequencias.intContadorAutIncMovBan);

      blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLanCre));
      arrBaiSinCar[intCont].strSeqLanCre := strSeqLanCre;

      If (Not TRedeCardFuncoes.fEmptyStr(strSeqLanCre)) And (Not TRedeCardFuncoes.fEmptyStr(strPorBad)) Then
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
                                                     TRedeCardFuncoes.fTime(),                        // Hora do Lançamento
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
                                                     TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                     '',
                                                     '',
                                                     1,
                                                     True,
                                                     LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLan));
        arrBaiSinCar[intCont].strSeqLanDeb := strSeqLan;
      End;

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

        LValorTotalTaxa := TRedeCardFuncoes.fFormataFloat(arrBaiSinCar[intCont].fltValTax -
                                                          arrBaiSinCar[intCont].fltValAnt, 2);

        {*****************************************}
        {* GRAVA MOVBAN DA TAXA                  *}
        {**************************************MV*}
        strSeqLanTax := TLibCartoesMovBan.GravaMovBan(strCtaTax,                      // Centro de Custo
                                                      strPorTax,                      // Portador
                                                      VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                      arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                      TRedeCardFuncoes.fTime(),                        // Hora do Lançamento
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
                                                      TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                      '',
                                                      '',
                                                      1,
                                                      True,
                                                      LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLanTax));
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

          strNumDup := 'G' + TRedeCardFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

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
                                          TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                          TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

          Inc64(objSequencias.intContadorAutIncCadPag);
          Inc64(objSequencias.intContadorAutIncLogCtp);
          Inc64(objSequencias.intSequencialCadPag);

          blnConfirma := blnCadPag;

          If blnConfirma Then
            TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceSintetico(strNumDup,
                                                                    strForTax,
                                                                    arrBaiSinCar[intCont].strCodEmp,
                                                                    'CRT',
                                                                    arrBaiSinCar[intCont],
                                                                    FCTPDetSintetico);
        End;
      End;

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
                                                      TRedeCardFuncoes.fTime(),                        // Hora do Lançamento
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
                                                      TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                      '',
                                                      '',
                                                      1,
                                                      True,
                                                      LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TRedeCardFuncoes.fEmptyStr(strSeqLanAnt));
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

          strNumDup := 'G' + TRedeCardFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

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
                                                      TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                                      TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

          Inc64(objSequencias.intContadorAutIncCadPag);
          Inc64(objSequencias.intContadorAutIncLogCtp);
          Inc64(objSequencias.intSequencialCadPag);

          blnConfirma := blnCadPag;
        End;
      End;

      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
    End;


    cdsAux.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORBAD;CAR_CTABAD;'+
                              'CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;CAR_EVEDEB;CAR_EVECRE;CAR_EVETAX';
    intCont := 0;

    cdsAux.First;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max :=  cdsAux.RecordCount;

    While (Not cdsAux.Eof) And (blnConfirma) Do
    Begin
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);

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
                                                     TRedeCardFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                          '', arrBaiSinCar[intCont].strCtaAnt),
                                                     TRedeCardFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                          '', arrBaiSinCar[intCont].strSeqLanAnt),
                                                     TRedeCardFuncoes.IIF(cdsAux.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                          0, cdsAux.FieldByName('MCA_ANTTAX').AsFloat),
                                                     TRedeCardFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                                     arrBaiSinCar[intCont].SeqLanCupomMkt);

        Inc64(objSequencias.intContadorAutIncLogMca);

        If blnConfirma and objConcil.strTabCon.Equals('RED_EFIR34') Then
        Begin
          SetLength(arrNumNsu, Length(arrNumNsu) + 1);

          arrNumNsu[Length(arrNumNsu) - 1] := TRedeCardFuncoes.fPadL(cdsAux.FieldByName('MCA_NUMNSU').AsString, 14, '0');
        End;

        If (blnConfirma) Then
           pAtualizaDataMovimentobancarioMovCar(cdsAux.FieldByName('AUTOINC').AsString, arrBaiSinCar[intCont].dtaDtaRec);

      End;

      If Not blnConfirma Then
        Break;

      cdsAux.Next;
    End;

    If blnConcil Then
    Begin
      If blnConfirma Then
          TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                    objConcil.strNomCon,
                                                    objSequencias);
    End;

    If (blnConcil) And (blnConfirma) Then
    Begin
      If MatchStr(objConcil.strTabCon, ['RED_EFIR34']) Then
        TBaixaCartoes.MarcarComoConciliado(objConcil,
                                           cdsBaiCar)
      Else
        TBaixaCartoes.MarcarComoConciliadoRedeCardAPI(objConcil,
                                                      cdsBaiCar);
    End;

    SetLength(arrBaiSinCar, 0);

    If Not blnConfirma Then
      Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!')
    Else
      blnConfirmaBaixa := True;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;
      blnConfirmaBaixa := False;
      Result := false;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoesSin]');
      FreeAndNil(cdsAux);

      If Assigned(cdsCloneConsulta) Then
        FreeAndNil(cdsCloneConsulta);

      Exit;
    End;
  End;

  blnConfirmaBaixa := blnConfirma;
  FreeAndNil(cdsAux);

  If Assigned(cdsCloneConsulta) Then
    FreeAndNil(cdsCloneConsulta);

  If Assigned(objSequencias) Then
    FreeAndnIl(objSequencias);

  Result :=  True;
End;

procedure TfrmRedeCardBaixaCartoes.pAtualizaDataMovimentobancarioMovCar( sAutoInc : String; ADataAlterada: TDateTime);
Var
  qryAltCrt : TUniQuery;
begin
  qryAltCrt := VS_FuncoesExternas.fICriaQuery;

  Try
     qryAltCrt.Close;
     qryAltCrt.SQL.Clear;
     qryAltCrt.SQL.Add(' UPDATE MOVCAR ');
     qryAltCrt.SQL.Add('    SET MCA_DTABAN = :DTABAN ');
     qryAltCrt.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
     qryAltCrt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
     qryAltCrt.ParamByName('AUTOIN').AsString   := sAutoInc;
     qryAltCrt.ExecSQL;

     If Assigned(qryAltCrt) Then
        FreeAndNil(qryAltCrt);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmBaixaCartoes.pAtualizaDataMovimentobancarioMovCar] ' +E.Message);
    End;
  End;
End;

end.

