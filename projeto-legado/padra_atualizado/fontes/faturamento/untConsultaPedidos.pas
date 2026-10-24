unit untConsultaPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Uni, ArquivosBanco.View,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, ArquivosBanco.AnexoPedido,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  BitBtnLockedIncrem, ComCtrls, untZClient, cxLookAndFeels, Clipbrd,
  cxLookAndFeelPainters, strUtils, cxNavigator, frxClass, frxExportCSVTestabilidade,
  ComboBoxFocus, untFuncoesConsulta, untTypesSistema, MemoFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxButtonEdit, untSalvaDadosInterface,
  UniClientDataSet, cxContainer, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxCalc, Datasnap.DBClient, Datasnap.Provider,
  UniDataSetProvider, PNGImage;

type
  TfrmConsultaPedidos = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    cxgConsultaLevel1: TcxGridLevel;
    cxgConsulta: TcxGrid;
    dtsConsul: TDataSource;
    cxgConsultaView: TcxGridDBBandedTableView;
    cxgConsultaNumPed: TcxGridDBBandedColumn;
    cxgConsultaDtaPed: TcxGridDBBandedColumn;
    cxgConsultaHorPed: TcxGridDBBandedColumn;
    cxgConsultaCodEmp: TcxGridDBBandedColumn;
    cxgConsultaCodCli: TcxGridDBBandedColumn;
    cxgConsultaNomCli: TcxGridDBBandedColumn;
    cxgConsultaEspOri: TcxGridDBBandedColumn;
    cxgConsultaDocOri: TcxGridDBBandedColumn;
    cxgConsultaEspBai: TcxGridDBBandedColumn;
    cxgConsultaDocBai: TcxGridDBBandedColumn;
    cxStyleRepository: TcxStyleRepository;
    cxsTitulo1: TcxStyle;
    cxsTitulo2: TcxStyle;
    cxsFatura: TcxStyle;
    cxsTitulo3: TcxStyle;
    cxsEntFut: TcxStyle;
    cxgConsultaOriPed: TcxGridDBBandedColumn;
    cxgConsultaEmpOri: TcxGridDBBandedColumn;
    cxgConsultaEmpBai: TcxGridDBBandedColumn;
    btnDadosEntrega: TBitBtnLocked;
    btnEnviaEmail: TBitBtnLocked;
    btnObsPed: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    prbProgresso: TProgressBar;
    edtNumPed: TEditFocus;
    Label6: TLabel;
    cxgConsultaJafatu: TcxGridDBBandedColumn;
    cxgConsultaSitped: TcxGridDBBandedColumn;
    cxgConsultaTipAte: TcxGridDBBandedColumn;
    cxgConsultaSepImp: TcxGridDBBandedColumn;
    cxsPedido: TcxStyle;
    cxsPedidoBaixado: TcxStyle;
    btnLibNeg: TBitBtnLocked;
    cxgConsultaEmpConf: TcxGridDBBandedColumn;
    cxgConsultaEspConf: TcxGridDBBandedColumn;
    cxgConsultaNumConf: TcxGridDBBandedColumn;
    cxgConsultaEmiFat: TcxGridDBBandedColumn;
    cxgConsultaEmiBai: TcxGridDBBandedColumn;
    cxgConsultaEmiConf: TcxGridDBBandedColumn;
    lblPedCom: TLabel;
    edtPedCom: TEditFocus;
    cxgConsultaHorExp: TcxGridDBBandedColumn;
    cxgConsultaHorSep: TcxGridDBBandedColumn;
    cxsTitulo5: TcxStyle;
    cxsRomaneio: TcxStyle;
    cxgConsultaDtaRom: TcxGridDBBandedColumn;
    cxgConsultaHorRom: TcxGridDBBandedColumn;
    cxgConsultaDtaRomBai: TcxGridDBBandedColumn;
    cxgConsultaHorRomBai: TcxGridDBBandedColumn;
    cxgConsultaMtrRom: TcxGridDBBandedColumn;
    cxgConsultaRom: TcxGridDBBandedColumn;
    cxgConsultaHorFat: TcxGridDBBandedColumn;
    lblDocFat: TLabel;
    lblEspFat: TLabel;
    lblEmpFat: TLabel;
    edtDocFat: TEditFocus;
    edtEspFat: TEditFocus;
    edtEmpFat: TEditFocus;
    lblEntRet: TLabel;
    cmbEntRet: TComboBox;
    lblDepVen: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblRedLoj: TLabel;
    edtCodRed: TEditFocus;
    edtNomRed: TEditFocus;
    cxgConsultaNumCmp: TcxGridDBBandedColumn;
    cxgConsultaCodVen: TcxGridDBBandedColumn;
    shaVen: TShape;
    pnlOcorrencias: TPanel;
    Panel1: TPanel;
    Label15: TLabel;
    txtOcorrencias: TMemoFocus;
    btnOcorrenciasDocumento: TBitBtnLocked;
    cxgConsultaLibCom: TcxGridDBBandedColumn;
    cxgConsultaLibera: TcxGridDBBandedColumn;
    btnLegenda: TBitBtnLocked;
    cxgConsultaStatus: TcxGridDBBandedColumn;
    cxgConsultaPedCom: TcxGridDBBandedColumn;
    btnRastrea: TBitBtnLocked;
    cxgConsultaTranspRom: TcxGridDBBandedColumn;
    btnObsRomaneio: TBitBtnLocked;
    cxgConsultaDtEntr: TcxGridDBBandedColumn;
    edtPedSite: TEditFocus;
    lblPedSite: TLabel;
    cxgConsultaDetRom: TcxGridDBBandedColumn;
    cxgConsultaDtaIni: TcxGridDBBandedColumn;
    cxgConsultaHorIni: TcxGridDBBandedColumn;
    cxgConsultaDtaChe: TcxGridDBBandedColumn;
    cxgConsultaHorChe: TcxGridDBBandedColumn;
    cxgConsultaEspera: TcxGridDBBandedColumn;
    rdgRomaneio: TRadioGroup;
    cxgConsultaPedBxNEtg: TcxGridDBBandedColumn;
    cxgConsultaHistBai: TcxGridDBBandedColumn;
    lblProduto: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    cbbFaturado: TComboBox;
    lblPedidosFat: TLabel;
    cxgConsultaHorLic: TcxGridDBBandedColumn;
    pnlEntregaFutura: TPanel;
    Label10: TLabel;
    edtDocBxEntFut: TEditFocus;
    Label11: TLabel;
    edtEspBxEntFut: TEditFocus;
    Label12: TLabel;
    edtEmpBxEntFut: TEditFocus;
    btnAnexo: TBitBtnLocked;
    cxgConsultaDtLibCom: TcxGridDBBandedColumn;
    cxgConsultaDtLibFin: TcxGridDBBandedColumn;
    btnExportaCsv: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    pnlLegenda: TPanel;
    lblSemSal: TLabel;
    shpSemSal: TShape;
    lblOcultaFiltro: TLabel;
    cxgProdutosDBTableView: TcxGridDBTableView;
    cxgProdutosLevel: TcxGridLevel;
    cxgProdutos: TcxGrid;
    dtsProdutos: TDataSource;
    cxgProdutosCODITE: TcxGridDBColumn;
    cxgProdutosFDO_QTDITE: TcxGridDBColumn;
    cxgProdutosDESTINO: TcxGridDBColumn;
    cxgProdutosFDO_DTENTR: TcxGridDBColumn;
    cxgProdutosFATURA: TcxGridDBColumn;
    cxgProdutosORI_QTDITE: TcxGridDBColumn;
    cxgProdutosGER_NUMROM: TcxGridDBColumn;
    cxgProdutosSTATUSITEM: TcxGridDBColumn;
    cxgProdutosGER_QTDROM: TcxGridDBColumn;
    cxgProdutosMOT_NOMOT: TcxGridDBColumn;
    cxgProdutosGER_DTABAI: TcxGridDBColumn;
    cxgProdutosTRA_NOMTRA: TcxGridDBColumn;
    cxgProdutosGER_OBSBAI: TcxGridDBColumn;
    cxgProdutosFDO_NUMCMP: TcxGridDBColumn;
    cxgProdutosFDO_NITCMP: TcxGridDBColumn;
    cxgProdutosFDO_NUMLOT: TcxGridDBColumn;
    pnlPedidos: TPanel;
    cdsItensPedido: TUniClientDataSet;
    pnlRodape: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    lblTotPed: TLabel;
    lblTotItePed: TLabel;
    dtpItensPedido: TUniDataSetProvider;
    cdsItensCache: TUniClientDataSet;
    cdsItensCacheAUTOINCREM: TStringField;
    cdsItensCacheSTATUS: TStringField;
    cxgProdutosTRANSFERENCIA: TcxGridDBColumn;
    cxgProdutosREQUISICAO: TcxGridDBColumn;
    cxgProdutosPEDIDODECOMPRAREQUISICAO: TcxGridDBColumn;
    cxgProdutosDATAENTREGAPEDIDO: TcxGridDBColumn;
    cxgConsultaNomFan: TcxGridDBBandedColumn;
    cxgProdutosNUMLOTFAT: TcxGridDBColumn;
    tmrProdutos: TTimer;
    cxCtrEnt: TcxStyle;
    cxsTitulo6: TcxStyle;
    cxgConsultaViewSaitaCtrlEnt: TcxGridDBBandedColumn;
    cxgConsultaViewChegadaCtrlEnt: TcxGridDBBandedColumn;
    cxgConsultaViewMotoristaCtrlEnt: TcxGridDBBandedColumn;
    cxgConsultaHorLib: TcxGridDBBandedColumn;
    cxgProdutosREFERE: TcxGridDBColumn;
    cxgProdutosCODFAB: TcxGridDBColumn;
    cxgProdutosCODBAR: TcxGridDBColumn;
    cxgProdutosMARCA: TcxGridDBColumn;
   	cxgProdutosNOTA_DE_ENTRADA: TcxGridDBColumn;
    cxgConsultaSituac: TcxGridDBBandedColumn;
    btnPODLalaMove: TBitBtnLocked;
    cxgConsultaViewLAL_NOMMOT: TcxGridDBBandedColumn;
    cxgConsultaViewLAL_PLAVEI: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnDadosEntregaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEnviaEmailClick(Sender: TObject);
    procedure btnObsPedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure btnLibNegClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure btnOcorrenciasDocumentoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLegendaClick(Sender: TObject);
    procedure btnRastreaClick(Sender: TObject);
    procedure btnObsRomaneioClick(Sender: TObject);
    procedure cxgConsultaDetRomPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnexoClick(Sender: TObject);
    procedure btnExportaCsvClick(Sender: TObject);
    procedure lblOcultaFiltroClick(Sender: TObject);
    procedure cxgProdutosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure tmrProdutosTimer(Sender: TObject);
    procedure cxgConsultaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgConsultaViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgConsultaViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgProdutosDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgConsultaSituacGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure dtsConsulDataChange(Sender: TObject; Field: TField);
    procedure btnPODLalaMoveClick(Sender: TObject);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    qryCadEmp: TUniQuery;
    cdsConsul: TZClient;
    cdsConAux: TZClient;
    qryFatura: TUniQuery;
    qryBaixas: TUniQuery;
    qryRomane: TUniQuery;
    qryEntreg: TUniQuery;
    qryDesmembramentos: TUniQuery;
    qryCtrEnt: TUniQuery;

    arrProdutos,
    arrLinRed,
    arrLinDep: TConsultasArray;
    strProdutos,
    strLinRed,
    strLinDep,
    strNumDocFat,
    strEspFat,
    strEmpFat,
    strCodCli: String;
    strNumDoc: String;

    stlPedidosCarregadosAutInc: TStringList;

    blnLibVen: Boolean;

    objSalInt : TSalvaInterface;

    blnFiltrosBaixaEntregaFutura : Boolean;

    qryItensPedido: TUniQuery;
    blnCarregouPedidos: Boolean;

    function fMotoristaPlacaLalaMove(const ARecord: TcxCustomGridRecord) : String;
    Function fStrMovDetFatura: String;
    Function fStrMovDetFaturaPD: String;
    Function fStrMovDetBaixas: String;
    Function fIdentificaPedidosVinculados: String;

    function fSqlConsulta(blnVazio: Boolean; strFgoAutoIncrem: String = ''): String;
    Function fSQLDesmembramentos: string;
    Function fSQLFatura: String;
    Function fSQLBaixas: String;

    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pCarregaVendedor;
    Procedure pAbreConsulta;
    procedure pSetaParametrosConsulta(AQuery: TUniQuery);
    Procedure pFechaConsulta;
    Procedure pProcessaPedidos;
    procedure pCompletaFatura;
    procedure pCompletaBaixas;
    procedure pCompletaCtrEnt;
    function fTemRegistroMovDet(var stlAutInc: TStringList): Boolean;
    procedure pCompletaRomane;
    procedure pCopiaAuxiliar;
    procedure pSetarControles(blnEnabled: Boolean);
    procedure pAtualizarOcorrencias;

    procedure pCarregarDesmembramentos(strNumDoc, strEspDoc, strEmpDoc, strOriPed: string);

    function fBuscarOrigemPedido(strNumDoc, strEspDoc, strEmpDoc: string): string;

    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);

    procedure pVerdeVermelho(edtCodVen: TEditFocus; shaVen: TShape; blnLiberado: Boolean);
    procedure pConfiguraIcones(cxConsultaView: TcxGridDBBandedTableView);
    procedure pLimpaNumCmp;
    procedure pCarregaObsRomaneio(strNumRom, strCodEmp, strCodOpe, strNumOri, strEspOri, strEmpOri: string);

    procedure pCarregaDetalhesRomaneio;

    procedure pSalvaFiltros();
    procedure pCarregaFiltros();
    function fCarregarDadosCadCtaReceber: Boolean;
    function fCarregarDadosInfCobranca: Boolean;
    function fCarregarDadosMostraDebCtrChq2: Boolean;
    procedure pCarregaItensPedido;
    procedure pConfiguraIconesProdutos(cxProdutos: TcxGridDBTableView);
    procedure pCarregaProdutos;
    procedure pPedidoEEmpresaInformadoCarregaPedido;
    procedure pCarregaDocumentosControleEntregadores;
    procedure pCompletaDadosControleEntregadores;
    function fGetChaveLayoutGrid(strNomeGrid: String): String;
    procedure pAcionaTimerProdutos;
    procedure pLimpaNavegacaoProdutos;
    function fRetornaSituacaoLalaMove(strPrefixo: string): String;
    procedure pExibirFotoPODLalamove;
    procedure pExibirImagem(const objPngImage : TPngImage);
  public
    { Public declarations }
    cdsInfCob, cdsInfDuplicatas : TUniClientDataSet;
    blnCadCtaReceber, blnInfCobranca, blnMostraDebCtrChq2 : Boolean;
    blnChamouPelaExpedicao: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  published
    property NumDoc: String read strNumDoc write strNumDoc;
    property NumDocFat : String read strNumDocFat write strNumDocFat;
    property EspFat    : String read strEspFat write strEspFat;
    property EmpFat    : String read strEmpFat write strEmpFat;
    property CodCli    : String read strCodCli write strCodCli;
  end;


implementation

uses untConstantes, untFuncoesSimples, untConsultas,untPesqAux,
  untInfPedido, untTelAcompEntregaEmail,
  untEnderecoEntrega, untGravando, untFuncoesRel, untFuncoesRel2,
  untLegenda, untFuncoesGenerica,
  untTSituacaoPedidoVenda, cxImageComboBox, untDigPedRastreamento,
  untObservacao, untDetalhesRomaneio, untExportaGridCSV,
  Winapi.ShellAPI, System.Net.HttpClientComponent, System.Net.HttpClient,
  untImagem;

{$R *.dfm}


procedure TfrmConsultaPedidos.pCarregaCliente;
begin
  pPesquisaCadCli(Nil, qryCadCli, edtCodCli.Text);
  edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmConsultaPedidos.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryCadEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;



procedure TfrmConsultaPedidos.pCarregaObsRomaneio(strNumRom, strCodEmp, strCodOpe, strNumOri, strEspOri, strEmpOri: string);
var
  qryObsRom: TUniQuery;
  strLinha: string;
begin
  qryObsRom := fCriaQuery;
  try
    qryObsRom.Close;
    qryObsRom.SQL.Clear;
    qryObsRom.SQL.Add(' SELECT GER_OBSERV, GER_NUMROM, GER_OPEALT, GER_DTAALT, GER_HORALT ');
    qryObsRom.SQL.Add('   FROM LOGROM ');
    qryObsRom.SQL.Add('  WHERE GER_NUMROM = :NUMROM');
    qryObsRom.SQL.Add('    AND GER_CODEMP = :CODEMP');
    qryObsRom.SQL.Add('    AND GER_OPEALT = :OPEALT');
    qryObsRom.ParamByName('NUMROM').AsString := strNumRom;
    qryObsRom.ParamByName('CODEMP').AsString := strCodEmp;
    qryObsRom.ParamByName('OPEALT').AsString := strCodOpe;
    qryObsRom.Open;

    if (qryObsRom.isEmpty) and (not fEmptyStr(strNumOri)) then
    begin
      qryObsRom.Close;
      qryObsRom.SQL.Clear;
      qryObsRom.SQL.Add(' SELECT GER_OBSERV, GER_NUMROM, GER_OPEALT, GER_DTAALT, GER_HORALT ');
      qryObsRom.SQL.Add('   FROM LOGROM ');
      qryObsRom.SQL.Add('  WHERE GER_NUMDOC = :NUMDOC');
      qryObsRom.SQL.Add('    AND GER_ESPDOC = :ESPDOC');
      qryObsRom.SQL.Add('    AND GER_EMPDOC = :EMPDOC');
      qryObsRom.ParamByName('NUMDOC').AsString := strNumOri;
      qryObsRom.ParamByName('ESPDOC').AsString := strEspOri;
      qryObsRom.ParamByName('EMPDOC').AsString := strEmpOri;
      qryObsRom.Open;
    end;

    if not qryObsRom.IsEmpty then
    begin
      try
        pCriarFormularios(TfrmObservacao, frmObservacao);
        frmObservacao.lblMensagem.Caption := 'Romaneio';
        frmObservacao.memObs.Lines.Clear;
        while not qryObsRom.Eof do
        begin
          strLinha := 'Romaneio: ' + qryObsRom.FieldByName('GER_NUMROM').AsString + '  ' +
                      'Vendedor: ' + qryObsRom.FieldByName('GER_OPEALT').AsString + '  ' +
                      'Data/Hora: ' + qryObsRom.FieldByName('GER_DTAALT').AsString + ' ' + qryObsRom.FieldByName('GER_HORALT').AsString;


          frmObservacao.memObs.Lines.Add(strLinha);
          frmObservacao.memObs.Lines.Add('');
          frmObservacao.memObs.Lines.Add(qryObsRom.FieldByName('GER_OBSERV').AsString);
          frmObservacao.memObs.Lines.Add('----------------------------------------------------------------------------');

          qryObsRom.Next;
        end;
        frmObservacao.ShowModal;
      finally
        pFreeAndNil(frmObservacao);
      end;
    end
    else
      fMensagem('ATENÇÃO!', 'Não há observações para esse documento!', ['&OK']);
  finally
    FreeAndNil(qryObsRom);
  end;
end;

procedure TfrmConsultaPedidos.pCarregaProdutos;
var
  strStatus: String;
  fltTotItePed: Integer;
  stlItensPed: TStringList;
begin
  If Not Self.Showing Then
    Exit;

  stlItensPed := TStringList.Create;
  fltTotItePed := 0;
  cdsItensPedido.Close;
  qryItensPedido.Close;
  qryItensPedido.ParamByName('NUMDOC').AsString := cdsConsul.FieldByName('NUMDOC').AsString;
  qryItensPedido.ParamByName('ESPDOC').AsString := 'PD';
  qryItensPedido.ParamByName('CODEMP').AsString := cdsConsul.FieldByName('CODEMP').AsString;
  qryItensPedido.Open;

  cdsItensPedido.DisableControls;

  try
    cdsItensPedido.Open;
    cdsItensPedido.First;

    while not cdsItensPedido.Eof do
    begin
      if cdsItensCache.Locate('AUTOINCREM',cdsItensPedido.FieldByName('FDO_AUTINC').AsString,[]) then
      begin
        strStatus := cdsItensCache.FieldByName('STATUS').AsString;
      end
      else
      begin
        strStatus := TStatus.New(
          TParamStatus.New()
            .NumDoc(cdsConsul.FieldByName('NUMDOC').AsString)
            .EspDoc('PD')
            .CodEmp(cdsConsul.FieldByName('CODEMP').AsString)
            .SeqFdo(cdsItensPedido.FieldByName('FDO_AUTINC').AsString)
        ).fGetStatus().fGetDescricao;

        if (strStatus = spvBaixado) then
        begin
          if (cdsItensPedido.FieldByName('FDO_QTDBAI').AsFloat > 0) then
          begin
            strStatus := 'Faturado';
          end
          else
          begin
            strStatus := 'Baixado não Entregue';
          end;
        end;

        if (strStatus = spvFaturado) and (cdsConsul.FieldByName('TIPFAT').AsString = 'PD') then
        begin
          if (cdsItensPedido.FieldByName('FDO_QTDBAI').AsFloat > 0) then
          begin
            strStatus := 'Faturado';
          end
          else
          begin
            strStatus := 'Desmembrado';
          end;
        end;

        cdsItensCache.Append;
        cdsItensCache.FieldByName('AUTOINCREM').AsString := cdsItensPedido.FieldByName('FDO_AUTINC').AsString;
        cdsItensCache.FieldByName('STATUS').AsString := strStatus;
        cdsItensCache.Post;
      end;

      cxgProdutosSTATUSITEM.EditValue := strStatus;
      cdsItensPedido.Edit;
      cdsItensPedido.FieldByName('STATUSITEM').AsString := strStatus;
      cdsItensPedido.Post;

      If (stlItensPed.IndexOf(cdsItensPedido.FieldByName('FDO_CODITE').AsString) = -1) Then
      Begin
        stlItensPed.Add(cdsItensPedido.FieldByName('FDO_CODITE').AsString);
      End;

      Inc(fltTotItePed);

      cdsItensPedido.Next;
    end;

    pConfiguraIconesProdutos(cxgProdutosDBTableView);
    lblTotItePed.Caption := FormatFloat('#0.0000', fltTotItePed);
    tmrProdutos.Enabled := False;
  finally
    cdsItensPedido.First;
    cdsItensPedido.EnableControls;
    FreeAndNil(stlItensPed);
  end;
end;

procedure TfrmConsultaPedidos.pCarregaVendedor;
  Var
    strCodOpe : String;
begin
  if not blnLibVen then
  begin
    strCodOpe := fRetCodVendedor(edtCodVen.Text);
    edtNomVen.Text := fRetNomeOperador(strCodOpe);
  end
  else
    edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
end;

function TfrmConsultaPedidos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Not (fEmptyStr(edtNumPed.Text) And (Sender = edtNumPed))) And
     (Sender <> edtCodVen) Then
    pSetarControles(fEmptyStr(edtNumPed.Text) And fEmptyStr(edtPedCom.Text) And fEmptyStr(edtDocFat.Text) And fEmptyStr(edtDocBxEntFut.Text));

  If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      edtNomCli.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaCliente;
      If (qryCadCli.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      edtNomEmp.Text := 'TODAS';
    End
    Else
    Begin
      pCarregaEmpresa;
      If qryCadEmp.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End
      Else
        pPedidoEEmpresaInformadoCarregaPedido;
    End;
  End

  Else If (Sender = edtCodVen) Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
    Begin
      if not blnLibVen then
        Result := fValidaGerSubVen(blnLibVen, 'V', edtCodVen, edtNomVen, 'Vendedor 1')
      else
        edtNomVen.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaVendedor;
      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And  (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
      Result := False;
    End

    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And  (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))  Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
      Result := False;
    End

    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConsultaPedidos.lblOcultaFiltroClick(Sender: TObject);
begin
  inherited;

  if pnlCabecalho.Visible then
  begin
    lblOcultaFiltro.Caption := 'Mostra Filtros';
    pnlCabecalho.Visible := False;
  end
  else
  begin
    lblOcultaFiltro.Caption := 'Oculta Filtros';
    pnlCabecalho.Visible := True;
    pnlCabecalho.Top := 0;
  end;
end;

procedure TfrmConsultaPedidos.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  If (edtEspFat.Enabled) Or (edtEmpFat.Enabled) Then
  Begin
    If (Not fEmptyStr(edtDocFat.Text)) And (fEmptyStr(edtEspFat.Text) Or fEmptyStr(edtEmpFat.Text)) Then
    Begin
      pMensagemOk('Ao fazer busca por "Documento de Faturamento" a "Espécie" e a "Empresa" devem ser preenchidas!');
      pSetFocus(edtDocFat);
      Exit;
    End;
  End;

  If blnFiltrosBaixaEntregaFutura Then
  Begin
    If (edtEspBxEntFut.Enabled) Or (edtEmpBxEntFut.Enabled) Then
    Begin
      If (Not fEmptyStr(edtDocBxEntFut.Text)) And (fEmptyStr(edtEspBxEntFut.Text) Or fEmptyStr(edtEmpBxEntFut.Text)) Then
      Begin
        pMensagemOk('Ao fazer busca por "Documento de Faturamento de Baixa da Entrega Futura" a "Espécie" e a "Empresa" devem ser preenchidas!');
        pSetFocus(edtDocBxEntFut);
        Exit;
      End;
    End;
  End;

  pnlOcorrencias.Visible := False;
  TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde, Carregando Pedidos...', '');
  blnCarregouPedidos := True;
  cdsItensCache.Open;
  cdsItensCache.EmptyDataSet;
  cdsConsul.First;
end;

procedure TfrmConsultaPedidos.btnAnexoClick(Sender: TObject);
begin
  inherited;
  If cdsConsul.IsEmpty Then
  Begin
    pMensagemOk('Selecione um pedido!');
    Exit;
  End;

  TfrmArquivosBanco.pShowArquivos(
    TArquivosBancoAnexoPedido.New
      .fValorFK(cdsConsul.FieldByName('AUTOIN').AsString));
end;

procedure TfrmConsultaPedidos.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  pFechaConsulta;
end;

procedure TfrmConsultaPedidos.btnDadosEntregaClick(Sender: TObject);
  Var
    objEndEnt: TEnderecoEntrega;
begin
  inherited;
  If (Not cdsConsul.IsEmpty) And
     ffrmSenha(strSenha) And
     fVerificaAcessoSistema('ENENC', fRetCodVendedor(strSenha)) Then
  Begin
    objEndEnt := TEnderecoEntrega.Create(Self);
    objEndEnt.fAlteraEnderecoEntrega(True, cdsConsul.FieldByName('CODCLI').AsString, True);
    FreeAndNil(objEndEnt);
  End;

  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaPedidos.btnEnviaEmailClick(Sender: TObject);
begin
  inherited;

  If cdsConsul.IsEmpty Then
  Begin
    pMensagemOk('Selecione um pedido!');
    Exit;
  End;

  With cdsConsul Do
  pEnviaEmail(FieldByName('NUMDOC').AsString,
              FieldByName('ESPDOC').AsString,
              FieldByName('CODEMP').AsString,
              FieldByName('NUMORI').AsString,
              FieldByName('ESPORI').AsString,
              FieldByName('EMPORI').AsString,
              FieldByName('CLIORI').AsString,              
              Handle);

  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaPedidos.btnExportaCsvClick(Sender: TObject);
  Var
    objExportaCSV: TExportaGridCSV;
begin
  inherited;
  objExportaCSV := TExportaGridCSV.Create(Self, cxgConsultaView);
  Try
    If (Not objExportaCSV.fExporta) Then
      pMensagemOk('Ocorreu um erro ao gerar o arquivo csv!');
  Finally
    FreeAndNil(objExportaCSV);
  End;
end;

procedure TfrmConsultaPedidos.btnLegendaClick(Sender: TObject);
begin
  inherited;
  If Not btnLegenda.Visible Then
    Exit;

  pShowLegenda(Self, TSituacaoPedidoVenda.fRetornaLegenda);
end;

procedure TfrmConsultaPedidos.btnLibNegClick(Sender: TObject);
begin
  inherited;

  If Not btnLibNeg.Enabled Then
    Exit;

  With cdsConsul Do
  Begin

    If (Not Active) Or (IsEmpty) Then
    Begin
      Exit;
    End;

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(71, 5206, [],
                          ['NUMDOC','CODEMP'],
                          [FieldByName('NUMDOC').AsString,
                          FieldByName('CODEMP').AsString],
                          Sender,
                          nil,
                          True);
    End;

  End;

  pSetFocus(cxgConsulta);

end;

procedure TfrmConsultaPedidos.btnObsPedClick(Sender: TObject);
  Var
    frmInfPedido: TfrmInfPedido;
begin
  inherited;
  Try
    If cdsConsul.IsEmpty Then
    Begin
      pMensagemOk('Selecione um pedido!');
      Exit;
    End;

    pCriarFormularios(TfrmInfPedido, frmInfPedido);

    With cdsConsul Do
    Begin
      frmInfPedido.strNumDoc := FieldByName('NUMDOC').AsString;
      frmInfPedido.strEspDoc := FieldByName('ESPDOC').AsString;
      frmInfPedido.strCodEmp := FieldByName('CODEMP').AsString;
      frmInfPedido.strCodCli := FieldByName('CODCLI').AsString;

      frmInfPedido.strNumOri := FieldByName('NUMORI').AsString;
      frmInfPedido.strEspOri := FieldByName('ESPORI').AsString;
      frmInfPedido.strEmpOri := FieldByName('EMPORI').AsString;
    End;  

    frmInfPedido.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmInfPedido);
  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaPedidos.btnObsRomaneioClick(Sender: TObject);
begin
  inherited;
  pCarregaObsRomaneio(cdsConsul.FieldByName('NUMROM').AsString, cdsConsul.FieldByName('CODEMP').AsString, cdsConsul.FieldByName('CODVEN').AsString,
                      cdsConsul.FieldByName('NUMORI').AsString, cdsConsul.FieldByName('ESPORI').AsString, cdsConsul.FieldByName('EMPORI').AsString);
end;

procedure TfrmConsultaPedidos.btnOcorrenciasDocumentoClick(Sender: TObject);
var
  qryOco: TUniQuery;
begin
  inherited;

  if (cdsConsul.Active) and (not cdsConsul.IsEmpty) then
  begin
    if btnOcorrenciasDocumento.Caption = '[F3] Ocorrências do Documento' then
    begin
      btnOcorrenciasDocumento.Caption := '[F3] Ocultar Ocorrências';
      btnOcorrenciasDocumento.Refresh;

      try
        qryOco := fCriaQuery;

        with qryOco, SQL do
        begin
          Close;
          Clear;
          Append(' SELECT CONCAT(OCO_CODOCO, "-", OCO_DESOCO) AS OCORRE, ');
          Append(' CONCAT("Operador: ", GER_CODOPE, " - ", OPE_NOMOPE) AS OPERADOR, ');
          Append(' GER_DTAOCO, GER_HRAOCO, ');
          Append(' GER_OBSCPL ');
          Append(' FROM ROMOCO ');
          Append(' LEFT JOIN CADOCO ON GER_CODOCO = OCO_CODOCO ');
          Append(' LEFT JOIN CADOPE ON GER_CODOPE = OPE_CODOPE ');
          Append(' WHERE ROMOCO.AUTOINCREM = ' +QuotedStr(cdsConsul.FieldByName('ROM_AUTINC').AsString));
          Open;

          txtOcorrencias.Lines.Clear;

          if RecordCount > 0 then
          begin
            while not qryOco.Eof do
            begin
              txtOcorrencias.Lines.Add(qryOco.FieldByName('OPERADOR').AsString);
              txtOcorrencias.Lines.Add(Format('Data/Hora: %s - %s',
                                       [FormatDateTime('dd/mm/yyyy', qryOco.FieldByName('GER_DTAOCO').AsDateTime),
                                        FormatDateTime('hh:nn', qryOco.FieldByName('GER_HRAOCO').AsDateTime)]
                                       ));
              txtOcorrencias.Lines.Add(qryOco.FieldByName('OCORRE').AsString);
              txtOcorrencias.Lines.Add(qryOco.FieldByName('GER_OBSCPL').AsString);
              txtOcorrencias.Lines.Add('==============================================');
              qryOco.Next;
            end;
          end
          else
          begin
            txtOcorrencias.Lines.Add(' Nenhuma ocorrência para o documento selecionado ');
            txtOcorrencias.Lines.Add('==============================================');
          end;

          pnlOcorrencias.Visible := True;
        end;

      finally
        FreeAndNil(qryOco);
      end;
    end
    else
    begin
      btnOcorrenciasDocumento.Caption := '[F3] Ocorrências do Documento';
      btnOcorrenciasDocumento.Refresh;
      pnlOcorrencias.Visible := False;
    end;
  end;
end;

procedure TfrmConsultaPedidos.btnRastreaClick(Sender: TObject);
  Var
    frmDigPedRastreamento: TfrmDigPedRastreamento;
begin
  inherited;

  If cdsConsul.IsEmpty Then
  Begin
    pMensagemOk('Selecione um pedido!');
    Exit;
  End;

  pCriarFormularios(TfrmDigPedRastreamento, frmDigPedRastreamento);
  frmDigPedRastreamento.strNumDoc := cdsConsul.FieldByName('NUMDOC').AsString;
  frmDigPedRastreamento.strSeqFgo := cdsConsul.FieldByName('AUTOIN').AsString;
  frmDigPedRastreamento.strEspOri := cdsConsul.FieldByName('ESPORI').AsString;
  frmDigPedRastreamento.strEmpOri := cdsConsul.FieldByName('EMPORI').AsString;
  frmDigPedRastreamento.strNumOri := cdsConsul.FieldByName('NUMORI').AsString;
  frmDigPedRastreamento.strCodCli := cdsConsul.FieldByName('CODCLI').AsString;
  frmDigPedRastreamento.strEspDoc := cdsConsul.FieldByName('ESPDOC').AsString;
  frmDigPedRastreamento.strCodEmp := cdsConsul.FieldByName('CODEMP').AsString;
  frmDigPedRastreamento.ShowModal;
end;

procedure TfrmConsultaPedidos.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaPedidos.pCarregaDetalhesRomaneio;
var
  frmDetalhesRomaneio: TfrmDetalhesRomaneio;
begin
  if not fEmptyStr(cdsConsul.FieldByName('ROM_AUTINC').AsString) then
  begin
    try
      pCriarFormularios(TfrmDetalhesRomaneio, frmDetalhesRomaneio);
      frmDetalhesRomaneio.strSeqGer := cdsConsul.FieldByName('ROM_AUTINC').AsString;
      frmDetalhesRomaneio.ShowModal;
    finally
      pFreeAndNil(frmDetalhesRomaneio);
    end;
  end;
end;

procedure TfrmConsultaPedidos.pCarregaDocumentosControleEntregadores;
begin
  qryEntreg.Close;
  qryEntreg.SQL.Clear;
  qryEntreg.SQL.Add('SELECT G.ENG_PROENT, G.ENG_DTACAD, G.ENG_HRACAD, D.END_DTABAI, D.END_HRABAI, M.MOT_NOMMOT');
  qryEntreg.SQL.Add('FROM COMENG G ');
  qryEntreg.SQL.Add('INNER JOIN COMEND D');
  qryEntreg.SQL.Add('ON(G.AUTOINCREM = D.END_SEQENG)');
  qryEntreg.SQL.Add('LEFT JOIN CADMOT M');
  qryEntreg.SQL.Add('ON(G.ENG_CODENT = M.MOT_CODMOT)');
  qryEntreg.SQL.Add('WHERE END_NUMDOC = :NUMDOC');
  qryEntreg.SQL.Add('AND END_ESPDOC = :ESPDOC');
  qryEntreg.SQL.Add('AND END_EMPDOC = :EMPDOC');
end;

procedure TfrmConsultaPedidos.cxgConsultaDetRomPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregaDetalhesRomaneio, 'Aguarde, carregando detalhes...', '');
end;

procedure TfrmConsultaPedidos.cxgConsultaSituacGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  var
    strMotoristaPlaca : String;
begin
  inherited;
  if fEmptyStr(AText) then
    Exit;
  AText := fRetornaSituacaoLalaMove(AText);
  strMotoristaPlaca := fMotoristaPlacaLalaMove(ARecord);
  if fEmptyStr(AText) then
    AText := strMotoristaPlaca
  else
  begin
    if fEmptyStr(strMotoristaPlaca) then
      exit;
    AText := AText + ' - ' + strMotoristaPlaca;
  end;
end;

procedure TfrmConsultaPedidos.cxgConsultaViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregaProdutos, 'Aguarde, Carregando produtos do pedido...', '');
end;

procedure TfrmConsultaPedidos.cxgConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      If AViewInfo.GridView.Site.Focused Then
      Begin
        If (AViewInfo.Item.Focused) Then
          ACanvas.Brush.Color := clWhite
        Else
          ACanvas.Font.Color := clBlack;
      End
      Else
        ACanvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen)
    End
    Else
      ACanvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  End;

  With cxgConsulta Do
  Begin
    If Not Active Then
      Exit;
    If (cxgConsultaView.Columns[AViewInfo.Item.Index].Position.BandIndex = 0) And (Not AViewInfo.GridRecord.Selected) Then
    Begin
      If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaJAFATU.Index] = 1) Then
        ACanvas.Font.Color := clGreen
      Else If ACanvas.Font.Color = clHighlightText Then
        ACanvas.Font.Color := clYellow
      Else
        ACanvas.Font.Color := clBlack;
    End;
  End;
end;

procedure TfrmConsultaPedidos.cxgConsultaViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_HOME,
    VK_END,
    VK_PRIOR,
    VK_NEXT,
    VK_UP,
    VK_DOWN: pLimpaNavegacaoProdutos;
  End;
end;

procedure TfrmConsultaPedidos.cxgConsultaViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_HOME,
    VK_END,
    VK_PRIOR,
    VK_NEXT,
    VK_UP,
    VK_DOWN: pAcionaTimerProdutos;
  End;
end;

procedure TfrmConsultaPedidos.cxgProdutosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      If AViewInfo.GridView.Site.Focused Then
      Begin
        If (AViewInfo.Item.Focused) Then
          ACanvas.Brush.Color := clWhite
        Else
          ACanvas.Font.Color := clBlack;
      End
      Else
        ACanvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen)
    End
    Else
      ACanvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  End;
end;

procedure TfrmConsultaPedidos.cxgProdutosDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  AGridSite: TcxGridSite;
  AGridView: TcxGridTableView;
  AValue: string;
begin
  inherited;

  if (Key = Ord('C')) and (ssCtrl in Shift) then
  begin
    AGridSite := Sender as TcxGridSite;
    AGridView := AGridSite.GridView as TcxGridTableView;
    AValue := VarToStr(AGridView.Controller.FocusedColumn.EditValue);
    Clipboard.AsText := AValue;
    Key := 0;
  end;
end;

procedure TfrmConsultaPedidos.dtsConsulDataChange(Sender: TObject;
  Field: TField);
var
  LFldPOD : TField;
begin
  inherited;
    LFldPOD := dtsConsul.DataSet.FindField('LAL_URLPOD');
    btnPODLalaMove.Visible := Assigned(LFldPOD) and (not fEmptyStr(LFldPOD.AsString));
end;

procedure TfrmConsultaPedidos.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidos.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep, edtDesDep, arrLinDep, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmConsultaPedidos.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrLinDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidos.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidos.edtCodProdutoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProduto, edtDesProduto, arrProdutos, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmConsultaPedidos.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, nil, Key, arrProdutos, False) then
  begin
    fValidaCampos(edtCodProduto, True);
    Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConsultaPedidos.edtCodRedExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodRed, edtNomRed ,arrLinRed, nil, fRetNomeRedeLoja, 'de Rede de Lojas');
end;

procedure TfrmConsultaPedidos.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqRedeLojas(Self, edtCodRed, edtNomRed, Nil, Key, arrLinRed, False) Then
  Begin
    If (fValidaCampos(edtCodRed, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidos.edtCodVenExit(Sender: TObject);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If blnLibVen Then
    pEdtCodSelectExit(edtCodVen, edtNomVen, arrSel, fRetNomVendRep, nil, 'do Vendedor');

  fValidaCampos(edtCodVen, True);
end;

procedure TfrmConsultaPedidos.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    qryConOpe: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryConOpe := fCriaQuery(Self);

    if (blnLibVen) and (fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel)) then
    Begin
      If (fValidaCampos(edtCodVen, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryConOpe);
  End;
end;

procedure TfrmConsultaPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pSalvaFiltros;
  fGetFuncoesCxGrid.pSalvarView(cxgProdutosDBTableView, fGetChaveLayoutGrid(cxgProdutosDBTableView.Name), cdsItensPedido);
  fGetFuncoesCxGrid.pSalvarView(cxgConsultaView, fGetChaveLayoutGrid(cxgConsultaView.Name), cdsConsul);
end;

procedure TfrmConsultaPedidos.FormCreate(Sender: TObject);
  Var
    blnExibiInformacoeDetalhadas: Boolean;
    intRecNo: Integer;
begin
  inherited;
  stlPedidosCarregadosAutInc := TStringList.Create;

  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.blnDeleteNaoEncontrados := False;

  blnExibiInformacoeDetalhadas := fCfgSis('ACPDDT',varBoolean);

  rdgRomaneio.Visible       := (fCfgSis('OPCROM') = '1');

  qryCadCli := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  qryFatura := fCriaQuery(Self);
  qryBaixas := fCriaQuery(Self);
  qryRomane := fCriaQuery(Self);
  qryEntreg := fCriaQuery(Self);
  qryCtrEnt := fCriaQuery(Self);

  qryFatura.SQL.Text := fSQLFatura;

  qryDesmembramentos := fCriaQuery(Self);
  qryDesmembramentos.SQL.Text := fSQLDesmembramentos;

  cdsConsul := TZClient.Create(Self);
  dtsConsul.DataSet := cdsConsul;

  cdsConsul.AfterOpen   := pAfterOpen;
  cdsConsul.AfterScroll := pAfterScroll;

  cdsConAux := TZClient.Create(Self, fSqlConsulta(True));
  cdsConAux.fAbreClient(True, 'TfrmConsultaPedidos.FormCreate');
  cxgConsultaView.ApplyBestFit();

  fGetFuncoesCxGrid.fCarregarView(cxgConsultaView, fGetChaveLayoutGrid(cxgConsultaView.Name), cdsConsul, intRecNo);

  cxgConsultaHorExp.Visible := blnExibiInformacoeDetalhadas;
  cxgConsultaHorLic.Visible := blnExibiInformacoeDetalhadas;
  cxgConsultaHorSep.Visible := blnExibiInformacoeDetalhadas;
  cxgConsultaHorFat.Visible := blnExibiInformacoeDetalhadas;
  cxgConsultaView.Bands[4].Visible := blnExibiInformacoeDetalhadas;

  cxgConsultaDtaIni.Visible := fCfgSis('MATDIS',varBoolean);
  cxgConsultaHorIni.Visible := fCfgSis('MATDIS',varBoolean);
  cxgConsultaDtaChe.Visible := (fCfgSis('MATDIS',varBoolean) and (fCfgSis('CTRCHE',varBoolean)));
  cxgConsultaHorChe.Visible := (fCfgSis('MATDIS',varBoolean) and (fCfgSis('CTRCHE',varBoolean)));
  cxgConsultaEspera.Visible := (fCfgSis('MATDIS',varBoolean) and (fCfgSis('CTRCHE',varBoolean)));

  cxgConsultaSitped.Visible := (fCfgSis('HABREM',varBoolean)) And
                               (fCfgSis('TRAREM') = '2') And
                               (fCfgSis('LIBPED', varBoolean));

  cxgConsultaTipAte.Visible := (fCfgSis('TIPATE',varBoolean)) And
                               (fCfgSis('PEDTPA',varBoolean));

  cxgConsultaStatus.Visible := fCfgSis('EXISTA', varBoolean);

  cxgConsultaView.Bands[5].Visible := fCfgSis('CTRENT',varBoolean);

  pCriarModuloLegenda;

  blnFiltrosBaixaEntregaFutura := fUsaPedidoBaixaEntregaFutura;

  NumDoc       := EmptyStr;
  strNumDocFat := EmptyStr;
  strEspFat    := EmptyStr;
  strEmpFat    := EmptyStr;
  strCodCli    := EmptyStr;
  blnCadCtaReceber    := False;
  blnInfCobranca      := False;
  blnMostraDebCtrChq2 := False;
  cdsInfCob := TUniClientDataSet.Create(Self);
  cdsInfDuplicatas := TUniClientDataSet.Create(Self);
  qryItensPedido := fCriaQuery;
  dtpItensPedido.DataSet := qryItensPedido;
  blnCarregouPedidos := False;
  cdsItensCache.CreateDataSet;
  qryItensPedido.CachedUpdates := True;
  qryItensPedido.Options.SetFieldsReadOnly := False;
  blnChamouPelaExpedicao := False;

end;

procedure TfrmConsultaPedidos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlPedidosCarregadosAutInc);
  FreeAndNil(objSalInt);
  FreeAndNil(qryItensPedido);

  FreeAndNil(qryEntreg);
  FreeAndNil(qryCtrEnt);

  inherited;
end;

procedure TfrmConsultaPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F1    :
      Begin
        If (Shift = [ssAlt]) Then
          btnLegenda.Click;
      End;
    VK_F2    : btnDadosEntrega.Click;
    VK_F3    : btnOcorrenciasDocumento.Click;
    VK_F4    : btnRastrea.Click;
    VK_F5    : btnLibNeg.Click;
    VK_F6    :
      if btnObsRomaneio.Visible then
      begin
         btnObsRomaneio.Click;
      end;
    VK_F7    : btnAnexo.Click;
    VK_F8    : btnObsPed.Click;
    VK_F9    : btnEnviaEmail.Click;
    VK_F11   : btnExportaCsv.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmConsultaPedidos.FormShow(Sender: TObject);
var
  intRecNo: Integer;
begin
  inherited;
  if not blnChamouPelaExpedicao then
    edtCodEmp.Text := VS_strCodEmp;

  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  edtNumPed.MaxLength := fTamDocCadRec;
  edtNumPed.TamCampo  := fTamDocCadRec;

  blnLibVen := fVerificaAcessoSistema('VDACEN');
  btnRastrea.Visible := fVerificaAcessoSistema('VALRTM');

  pVerdeVermelho(edtCodVen, shaVen, blnLibVen);

  edtEmpFat.Text := VS_strCodEmp;

  pnlEntregaFutura.Visible := blnFiltrosBaixaEntregaFutura;

  If blnFiltrosBaixaEntregaFutura Then
    edtEmpBxEntFut.Text := VS_strCodEmp;

  pSetFocus(edtNumPed);
  pCarregaItensPedido;
  fGetFuncoesCxGrid.fCarregarView(cxgProdutosDBTableView, fGetChaveLayoutGrid(cxgProdutosDBTableView.Name), cdsItensPedido, intRecNo);

  If (fCarregarDadosMostraDebCtrChq2) Then
  Begin
    pCarregaFiltros;

    edtPedCom.Clear;
    edtDocBxEntFut.Clear;
    edtDocFat.Clear;
    edtNumPed.Clear;

    If (not fEmptyStr(strNumDocFat)) Then
    begin
      if (cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString = 'PD') then
        edtNumPed.Text := strNumDocFat
      else
        edtDocFat.Text := strNumDocFat;
    end;

    If (not fEmptyStr(strEspFat)) Then
      edtEspFat.Text := strEspFat;

    If (not fEmptyStr(strEmpFat)) Then
    begin
      edtEmpFat.Text := strEmpFat;
      edtCodEmp.Text := strEmpFat;
      edtNomEmp.Text := fRetNomeEmpresa(strEmpFat);
    end;

    If (not fEmptyStr(strCodCli)) Then
      edtCodCli.Text := strCodCli;

    If cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString = 'AG' then
      fMensagem('ATENÇÃO!', 'Esse documento é um Agrupamento, portanto não possui acompanhamento de entrega vinculado!', ['&OK']);

    blnMostraDebCtrChq2 := False;

    If (not fEmptyStr(strEspFat)) and (strEspFat = 'CC') and (not fVerificaCtrManual(strNumDocFat, strEspFat, strEmpFat, strCodCli)) Then
      fMensagem('ATENÇÃO!','Esse titulo não possui rastreamento de entrega.',['&O k'])
    Else
      btnAdicionar.Click;
  End
  Else If (fCarregarDadosInfCobranca) Then
  Begin
    edtPedCom.Clear;
    edtDocBxEntFut.Clear;
    edtDocFat.Clear;
    edtNumPed.Clear;

    btnAdicionar.Click;
    pCarregaFiltros;
  End
  Else If (blnCadCtaReceber) Then
  Begin
    pCarregaFiltros;

    edtDocFat.Clear;
    edtEspFat.Clear;
    edtEmpFat.Clear;
    edtCodCli.Clear;

    If (not fEmptyStr(NumDocFat)) Then
      If (EspFat = 'PD') then
        edtNumPed.Text := NumDocFat
      else
        edtDocFat.Text := NumDocFat;

    If (not fEmptyStr(EspFat)) Then
      edtEspFat.Text := EspFat;

    If (not fEmptyStr(EmpFat)) Then
      edtEmpFat.Text := EmpFat;

    If (not fEmptyStr(strCodCli)) Then
      edtCodCli.Text := strCodCli;

    If (not fEmptyStr(EspFat)) and (EspFat <> 'AG') and (not fVerificaCtrManual(NumDocFat, EspFat, EmpFat, CodCli)) Then
      fMensagem('ATENÇÃO!','Esse titulo não possui rastreamento de entrega.',['&O k'])
    Else
      btnAdicionar.Click;
  End
  Else
  Begin
    pCarregaFiltros;

    If (not fEmptyStr(strNumDocFat)) Then
      edtDocFat.Text := strNumDocFat;

    If (not fEmptyStr(strEspFat)) Then
      edtEspFat.Text := strEspFat;

    If (not fEmptyStr(strEmpFat)) Then
      edtEmpFat.Text := strEmpFat;

    If (not fEmptyStr(strCodCli)) Then
      edtCodCli.Text := strCodCli;

    If (Not fEmptyStr(strNumDoc)) Then
      edtNumPed.Text := strNumDoc;
  End;

  if blnChamouPelaExpedicao then
    btnAdicionar.Click;
end;

function TfrmConsultaPedidos.fBuscarOrigemPedido(strNumDoc, strEspDoc, strEmpDoc: string): string;
var
  qryOrigem: TUniQuery;
begin
  Result := strNumDoc + '-' + strEspDoc + '-' + strEmpDoc;
  qryOrigem := fCriaQuery;
  try
    qryOrigem.SQL.Add(' SELECT ');
    qryOrigem.SQL.Add('   DISTINCT FDO_NUMDOC AS NUMDOC, FDO_ESPDOC AS ESPDOC, FDO_CODEMP AS CODEMP ');
    qryOrigem.SQL.Add(' FROM ');
    qryOrigem.SQL.Add('   FATDOR A ');
    qryOrigem.SQL.Add(' WHERE A.FDO_NUMFAT = :NUMDOC ');
    qryOrigem.SQL.Add('   AND A.FDO_EMPFAT = :CODEMP ');
    qryOrigem.SQL.Add('   AND A.FDO_TIPFAT = :ESPDOC ');
    qryOrigem.ParamByName('NUMDOC').AsString := strNumDoc;
    qryOrigem.ParamByName('ESPDOC').AsString := strEspDoc;
    qryOrigem.ParamByName('CODEMP').AsString := strEmpDoc;
    qryOrigem.Open;
    If Not qryOrigem.IsEmpty Then
    Begin
      Result := fBuscarOrigemPedido(qryOrigem.FieldByName('NUMDOC').AsString,
                                    qryOrigem.FieldByName('ESPDOC').AsString,
                                    qryOrigem.FieldByName('CODEMP').AsString);
    End;
  finally
    FreeAndNil(qryOrigem);
  end;
end;

Function TfrmConsultaPedidos.fCarregarDadosCadCtaReceber() : Boolean;
Begin
  Result := (blnCadCtaReceber) and
            ((not fEmptyStr(strNumDocFat)) or
             (not fEmptyStr(strEspFat)) or
             (not fEmptyStr(strEmpFat)));
end;

Function TfrmConsultaPedidos.fCarregarDadosInfCobranca() : Boolean;
Begin
  Result := (blnInfCobranca) and (not cdsInfDuplicatas.IsEmpty) and (not  cdsInfCob.IsEmpty);
end;

Function TfrmConsultaPedidos.fCarregarDadosMostraDebCtrChq2() : Boolean;
Begin
  Result := (blnMostraDebCtrChq2) and (not cdsInfDuplicatas.IsEmpty);
end;

function TfrmConsultaPedidos.fGetChaveLayoutGrid(strNomeGrid: String): String;
begin
  Result := Self.Name + '.' + strNomeGrid + '.' + strLoginUsuarioLogado + '.' + VS_strCodEmp;
end;

Procedure TfrmConsultaPedidos.pAbreConsulta;
Begin
  Try
    blnCarregouPedidos := False;
    cxgConsulta.Enabled := False;
    If fCfgSis('EXISTA', varBoolean) Then
      pConfiguraIcones(cxgConsultaView);

    With cdsConsul, qryQuery Do
    Begin
      Close;

      SQL.Text := fSqlConsulta(False);

      pSetaParametrosConsulta(qryQuery);

      fAbreClient(True, 'TfrmConsultaPedidos.pAbreConsulta');

      Try
        dtsConsul.Enabled := False;

        cdsConAux.EmptyDataSet;

        lblTotPed.Caption := IntToStr(RecordCount);

        pProcessaPedidos;

        cdsConsul.IndexFieldNames := 'DTAENT;HORENT;NUMDOC;ESPDOC;JAFATU;ESPORI;NUMORI;' +
                                     'EMPORI;ESPBAI;NUMBAI;EMPBAI;EMPCONF;ESPCONF;NUMCONF';

        cxgConsulta.Enabled := True;
      Finally
        dtsConsul.Enabled := True;

        cxgConsultaView.ViewData.Expand(True);
        cxgConsultaView.NavigatorButtons.First.Click;
        cxgConsultaView.ApplyBestFit();
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmConsultaPedidos.pAbreConsulta');
    End;
  End;

  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaPedidos.pAfterOpen(DataSet: TDataSet);
begin
 btnLibNeg.Enabled := cdsConsul.FieldByName('SITPED').AsString = 'LIBERACAO NEGADA';
end;

procedure TfrmConsultaPedidos.pAfterScroll(DataSet: TDataSet);
begin
  btnLibNeg.Enabled := cdsConsul.FieldByName('SITPED').AsString = 'LIBERACAO NEGADA';

  btnObsRomaneio.Visible := not fEmptyStr(cdsConsul.FieldByName('NUMROM').AsString);

  if pnlOcorrencias.Visible then
    pAtualizarOcorrencias;
end;

procedure TfrmConsultaPedidos.pAtualizarOcorrencias;
var
  qryOco: TUniQuery;
begin
  inherited;

  try
    qryOco := fCriaQuery;

    with qryOco, SQL do
    begin
      Close;
      Clear;
      Append(' SELECT CONCAT(OCO_CODOCO, "-", OCO_DESOCO) AS OCORRE, ');
      Append(' GER_OBSCPL, GER_DTAOCO, GER_HRAOCO ');
      Append(' FROM ROMOCO ');
      Append(' LEFT JOIN CADOCO ON GER_CODOCO = OCO_CODOCO ');
      Append(' WHERE ROMOCO.AUTOINCREM = ' +QuotedStr(cdsConsul.FieldByName('ROM_AUTINC').AsString));
      Open;

      txtOcorrencias.Lines.Clear;

      if (RecordCount > 0) then
      begin
        while not Eof do
        begin
          txtOcorrencias.Lines.Add(FormatDateTime('dd/mm/yyyy', FieldByName('GER_DTAOCO').AsDateTime) +' '
                                   +FormatDateTime('hh:nn', FieldByName('GER_HRAOCO').AsDateTime));
          txtOcorrencias.Lines.Add(FieldByName('OCORRE').AsString);
          txtOcorrencias.Lines.Add(FieldByName('GER_OBSCPL').AsString);
          txtOcorrencias.Lines.Add('==============================================');
          Next;
        end;
      end
      else
      begin
        txtOcorrencias.Lines.Add(' Nenhuma ocorrência para o documento selecionado ');
        txtOcorrencias.Lines.Add('==============================================');
      end;

      pnlOcorrencias.Visible := True;
    end;
  finally
    FreeAndNil(qryOco);
  end;
end;

procedure TfrmConsultaPedidos.btnPODLalaMoveClick(Sender: TObject);
begin
  inherited;
  pExibirFotoPODLalamove;
end;

Function TfrmConsultaPedidos.fStrMovDetFatura: String;
  Var
    strSql: String;
Begin
  strSql := '';
  strSQL := strSQL + '  SELECT DISTINCT ';
  strSQL := strSQL + '    DET_CODEMP AS EMPORI, ';
  strSQL := strSQL + '    DET_NUMDOC AS NUMORI, ';
  strSQL := strSQL + '    DET_ESPDOC AS ESPORI, ';
  strSQL := strSQL + '    DET_CODCLI AS CLIORI, ';
  strSQL := strSQL + '    DET_DTAENT AS EMIFAT, ';
  strSQL := strSQL + '    (SELECT GER_HORENT FROM MOVGER WHERE MOVGER.AUTOINCREM = MOVDET.DET_SEQGER) AS HRAFAT, ';
  strSQL := strSQL + '    IFNULL(NULLIF(DET_TIPFAT, ""), N.GER_ESPDOC) AS ESPCONF, ';
  strSQL := strSQL + '    IFNULL(NULLIF(DET_NUMFAT, ""), N.GER_NUMDOC) AS NUMCONF, ';
  strSQL := strSQL + '    IFNULL(NULLIF(DET_EMPFAT, ""), N.GER_CODEMP) AS EMPCONF, ';
  strSQL := strSQL + '    IFNULL(DET_DTAFAT, N.GER_DTAENT) AS EMICONF ';
  strSQL := strSQL + '  FROM MOVDET ';
  strSQL := strSQL + '  LEFT JOIN CNFMNO C ON DET_NUMDOC = MNO_NUMFAT ';
  strSQL := strSQL + '                    AND DET_ESPDOC = MNO_ESPFAT ';
  strSQL := strSQL + '                    AND DET_CODEMP = MNO_EMPFAT ';
  strSQL := strSQL + '  LEFT JOIN NOTGER N ON MNO_SEQGER = N.AUTOINCREM ';
  strSQL := strSQL + '  WHERE DET_NUM_PD = :NUMDOC ';
  strSQL := strSQL + '    AND DET_ESP_PD = :ESPDOC ';
  strSQL := strSQL + '    AND DET_EMP_PD = :CODEMP ';
  strSQL := strSQL + '    AND DET_ESPDOC <> "PR"   ';

  Result := strSQL;
End;

function TfrmConsultaPedidos.fStrMovDetFaturaPD: String;
  Var
    strSql: String;
Begin
  strSql := '';
  strSQL := strSQL + '  SELECT DISTINCT ';
  strSQL := strSQL + '    FDO_EMPFAT AS EMPORI, ';
  strSQL := strSQL + '    FDO_NUMFAT AS NUMORI, ';
  strSQL := strSQL + '    FDO_TIPFAT AS ESPORI, ';
  strSQL := strSQL + '    FDO_CODCLI AS CLIORI, ';
  strSQL := strSQL + '    FDO_DTAENT AS EMIFAT, ';
  strSQL := strSQL + '    (SELECT FGO_HORENT FROM FATGOR WHERE FATGOR.AUTOINCREM=FATDOR.FDO_SEQGER) AS HRAFAT, ';
  strSQL := strSQL + '    ""         AS ESPCONF,';
  strSQL := strSQL + '    ""         AS NUMCONF,';
  strSQL := strSQL + '    ""         AS EMPCONF,';
  strSQL := strSQL + '    NULL       AS EMICONF ';
  strSQL := strSQL + '  FROM  ';
  strSQL := strSQL + '    FATDOR ';
  strSQL := strSQL + '  WHERE  ';
  strSQL := strSQL + '    FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '    FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    FDO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    FDO_TIPFAT = "PD" ';

  Result := strSQL;
end;

function TfrmConsultaPedidos.fTemRegistroMovDet(var stlAutInc: TStringList): Boolean;
var
  strSql: string;
  qryAux: TUniQuery;
begin
  Result := False;
  if fEmptyStr(cdsConsul.FieldByName('NUMORI').AsString) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
  qryAux := fCriaQuery();
  try
    qryAux.SQL.Add(strSql);
    qryAux.ParamByName('NUMDOC').AsString := cdsConsul.FieldByName('NUMORI').AsString;
    qryAux.ParamByName('ESPDOC').AsString := cdsConsul.FieldByName('ESPORI').AsString;
    qryAux.ParamByName('CODEMP').AsString := cdsConsul.FieldByName('EMPORI').AsString;
    qryAux.Open;

    Result := not qryAux.IsEmpty;

    If Result Then
    Begin

      stlAutInc.Clear;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        stlAutInc.Add(qryAux.FieldByName('AUTOINCREM').AsString);
        qryAux.Next;
      End;

    End;

  finally
    FreeAndNil(qryAux);
  end;

end;

function TfrmConsultaPedidos.fSQLDesmembramentos: string;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   DISTINCT A.FDO_SEQGER AS AUTOIN ';
  Result := Result + ' FROM ';
  Result := Result + '   FATDOR A ';
  Result := Result + ' WHERE A.FDO_NUMFAT = :NUMDOC ';
  Result := Result + '   AND A.FDO_EMPFAT = :CODEMP ';
  Result := Result + '   AND A.FDO_TIPFAT = :ESPDOC ';
  Result := Result + ' UNION ';
  Result := Result + ' SELECT ';
  Result := Result + '   DISTINCT FATGOR.AUTOINCREM AS AUTOIN ';
  Result := Result + ' FROM ';
  Result := Result + '   FATDOR JOIN FATGOR ';
  Result := Result + '     ON FGO_NUMDOC = FATDOR.FDO_NUMFAT ';
  Result := Result + '    AND FGO_ESPDOC = FATDOR.FDO_TIPFAT ';
  Result := Result + '    AND FGO_CODEMP = FATDOR.FDO_EMPFAT ';
  Result := Result + ' WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '   AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '   AND FDO_CODEMP = :CODEMP ';
  Result := Result + '   AND FDO_TIPFAT = :ESPDOC ';
end;

Function TfrmConsultaPedidos.fSQLFatura: String;
Begin
  Result := fStrMovDetFatura +
            ' UNION ALL ' +
            fStrMovDetFaturaPD;
End;

Function TfrmConsultaPedidos.fStrMovDetBaixas: String;
  Var
    strSql: String;
Begin
  strSql := '';
  strSQL := strSQL + '  SELECT DISTINCT ';
  strSQL := strSQL + '    DET_CODEMP AS EMPBAI, ';
  strSQL := strSQL + '    DET_NUMDOC AS NUMBAI, ';
  strSQL := strSQL + '    DET_ESPDOC AS ESPBAI, ';
  strSQL := strSQL + '    DET_CODCLI AS CLIBAI, ';
  strSQL := strSQL + '    DET_DTAENT AS EMIBAI  ';

  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    MOVDET ';
  strSQL := strSQL + '  WHERE  ';
  strSQL := strSQL + '    DET_DOCFUT = :NUMDOC AND  ';
  strSQL := strSQL + '    DET_ESPFUT = :ESPDOC AND  ';
  strSQL := strSQL + '    DET_EMPFUT = :CODEMP AND  ';
  strSQL := strSQL + '    DET_ESPDOC <> "PR"  ';

  Result := strSQL;
End;

function TfrmConsultaPedidos.fRetornaSituacaoLalaMove(
  strPrefixo: string): String;
begin
  case AnsiIndexStr(UpperCase(strPrefixo), ['PEN','AND','FIN','EMC','CAN']) of

    0: Result := 'Entrega não iniciada';
    1: Result := 'Entrega em andamento';
    2: Result := 'Entrega realizada';
    3: Result := 'Em cancelamento';
    4: Result := 'Cancelada';
    -1: Result := '';
  end;
end;


Function TfrmConsultaPedidos.fSQLBaixas: String;
Begin
  Result := fStrMovDetBaixas;
End;

procedure TfrmConsultaPedidos.pCompletaBaixas;
  Var
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strNomCli,
    strSitPed,
    strTipAte,
    strSepImp,
    strEmpOri,
    strNumOri,
    strEspOri,
    strCliOri,
    strOriPed: String;
    stlAutInc: TStringList;
    intJafatu: Integer;
    dtaDtaEnt,
    hraHraEnt: TDateTime;
Begin

  With cdsConsul Do
  Begin

    stlAutInc := TStringList.Create;
    stlAutInc.Clear;

    Try

      if not fTemRegistroMovDet(stlAutInc) then
        Exit;

      qryBaixas.Close;
      qryBaixas.SQL.Clear;
      qryBaixas.SQL.Text := fSQLBaixas;

      if (stlAutInc.Count > 0) then
      begin

        qryBaixas.SQL.Add(' UNION ALL ');

        qryBaixas.SQL.Add(' SELECT DISTINCT ');
        qryBaixas.SQL.Add('   FDO_CODEMP AS EMPBAI, ');
        qryBaixas.SQL.Add('   FDO_NUMDOC AS NUMBAI, ');
        qryBaixas.SQL.Add('   FDO_ESPDOC AS ESPBAI, ');
        qryBaixas.SQL.Add('   FDO_CODCLI AS CLIBAI, ');
        qryBaixas.SQL.Add('   FDO_DTAENT AS EMIBAI  ');
        qryBaixas.SQL.Add(' FROM ');
        qryBaixas.SQL.Add('   FATDOR F ');
        qryBaixas.SQL.Add('   INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ');
        qryBaixas.SQL.Add(' WHERE ');
        qryBaixas.SQL.Add('   FDO_INCFUT IN (' + fCommaText(stlAutInc, True) + ')');

      end;

      qryBaixas.ParamByName('NUMDOC').AsString := FieldByName('NUMORI').AsString;
      qryBaixas.ParamByName('ESPDOC').AsString := FieldByName('ESPORI').AsString;
      qryBaixas.ParamByName('CODEMP').AsString := FieldByName('EMPORI').AsString;
      qryBaixas.Open;

      If Not qryBaixas.IsEmpty Then
      Begin
        Edit;

        FieldByName('EMPBAI').AsString := qryBaixas.FieldByName('EMPBAI').AsString;
        FieldByName('NUMBAI').AsString := qryBaixas.FieldByName('NUMBAI').AsString;
        FieldByName('ESPBAI').AsString := qryBaixas.FieldByName('ESPBAI').AsString;
        FieldByName('CLIBAI').AsString := qryBaixas.FieldByName('CLIBAI').AsString;

        If (FieldByName('EMIBAI').Value = Null) Then
          FieldByName('EMIBAI').Value := Null
        Else
          FieldByName('EMIBAI').AsDateTime := qryBaixas.FieldByName('EMIBAI').AsDateTime;

        Post;

        strNumDoc := FieldByName('NUMDOC').AsString;
        strEspDoc := FieldByName('ESPDOC').AsString;
        strCodEmp := FieldByName('CODEMP').AsString;
        strCodCli := FieldByName('CODCLI').AsString;
        strNomCli := FieldByName('NOMCLI').AsString;
        strSitPed := FieldByName('SITPED').AsString;
        strTipAte := FieldByName('TIPATE').AsString;
        strSepImp := FieldByName('SEPIMP').AsString;
        intJafatu := FieldByName('JAFATU').AsInteger;
        dtaDtaEnt := FieldByName('DTAENT').AsDateTime;
        hraHraEnt := FieldByName('HORENT').AsDateTime;

        strOriPed := FieldByName('ORIPED').AsString;
        strEmpOri := FieldByName('EMPORI').AsString;
        strNumOri := FieldByName('NUMORI').AsString;
        strEspOri := FieldByName('ESPORI').AsString;
        strCliOri := FieldByName('CLIORI').AsString;

        qryBaixas.Next;

        While Not qryBaixas.Eof Do
        Begin
          cdsConAux.Insert;

          cdsConAux.FieldByName('NUMDOC').AsString   := strNumDoc;
          cdsConAux.FieldByName('CODEMP').AsString   := strCodEmp;
          cdsConAux.FieldByName('ESPDOC').AsString   := strEspDoc;
          cdsConAux.FieldByName('CODCLI').AsString   := strCodCli;
          cdsConAux.FieldByName('NOMCLI').AsString   := strNomCli;
          cdsConAux.FieldByName('SITPED').AsString   := strSitPed;
          cdsConAux.FieldByName('TIPATE').AsString   := strTipAte;
          cdsConAux.FieldByName('SEPIMP').AsString   := strSepImp;
          cdsConAux.FieldByName('JAFATU').AsInteger  := intJafatu;

          cdsConAux.FieldByName('DTAENT').AsDateTime := dtaDtaEnt;
          cdsConAux.FieldByName('HORENT').AsDateTime := hraHraEnt;

          cdsConAux.FieldByName('EMPORI').AsString   := strEmpOri;
          cdsConAux.FieldByName('NUMORI').AsString   := strNumOri;
          cdsConAux.FieldByName('ESPORI').AsString   := strEspOri;
          cdsConAux.FieldByName('CLIORI').AsString   := strCliOri;

          cdsConAux.FieldByName('ORIPED').AsString   := strOriPed;

          cdsConAux.FieldByName('EMPBAI').AsString   := qryBaixas.FieldByName('EMPBAI').AsString;
          cdsConAux.FieldByName('NUMBAI').AsString   := qryBaixas.FieldByName('NUMBAI').AsString;
          cdsConAux.FieldByName('ESPBAI').AsString   := qryBaixas.FieldByName('ESPBAI').AsString;
          cdsConAux.FieldByName('CLIBAI').AsString   := qryBaixas.FieldByName('CLIBAI').AsString;
          cdsConAux.FieldByName('EMIBAI').AsDateTime := qryBaixas.FieldByName('EMIBAI').AsDateTime;

          cdsConAux.Post;

          qryBaixas.Next;
        End;

      End; {If Not qryBaixas.IsEmpty Then}

    Finally
      If Assigned(stlAutInc) Then
        FreeAndNil(stlAutInc);
    End;

  End;

End;

procedure TfrmConsultaPedidos.pCompletaCtrEnt;
Begin
  qryCtrEnt.Close;
  qryCtrEnt.SQL.Clear;
  qryCtrEnt.SQL.Add('SELECT G.ENG_DTACAD, ');
  qryCtrEnt.SQL.Add('       G.ENG_HRACAD, ');
  qryCtrEnt.SQL.Add('       G.ENG_DTABAI, ');
  qryCtrEnt.SQL.Add('       G.ENG_HRABAI, ');
  qryCtrEnt.SQL.Add('       G.ENG_CODENT, ');
  qryCtrEnt.SQL.Add('       M.MOT_NOMMOT  ');
  qryCtrEnt.SQL.Add('FROM COMENG G        ');
  qryCtrEnt.SQL.Add('INNER JOIN COMEND D  ');
  qryCtrEnt.SQL.Add('ON(G.AUTOINCREM = D.END_SEQENG)');
  qryCtrEnt.SQL.Add('LEFT JOIN CADMOT M');
  qryCtrEnt.SQL.Add('ON(G.ENG_CODENT = M.MOT_CODMOT)');
  qryCtrEnt.SQL.Add('WHERE D.END_NUMDOC = :NUMDOC');
  qryCtrEnt.SQL.Add('  AND D.END_ESPDOC = :ESPDOC');
  qryCtrEnt.SQL.Add('  AND D.END_EMPDOC = :EMPDOC');
  qryCtrEnt.ParamByName('NUMDOC').AsString := cdsConsul.FieldByName('NUMORI').AsString;
  qryCtrEnt.ParamByName('ESPDOC').AsString := cdsConsul.FieldByName('ESPORI').AsString;
  qryCtrEnt.ParamByName('EMPDOC').AsString := cdsConsul.FieldByName('EMPORI').AsString;
  qryCtrEnt.Open;
  If Not qryCtrEnt.IsEmpty Then
  Begin
    cdsConsul.Edit;
    cdsConsul.FieldByName('DTASAI').AsDateTime := qryCtrEnt.FieldByName('ENG_DTACAD').AsDateTime +
                                                  qryCtrEnt.FieldByName('ENG_HRACAD').AsDateTime ;
    cdsConsul.FieldByName('DTACHG').AsDateTime := qryCtrEnt.FieldByName('ENG_DTABAI').AsDateTime +
                                                  qryCtrEnt.FieldByName('ENG_HRABAI').AsDateTime ;
    cdsConsul.FieldByName('MOTORA').AsString   := qryCtrEnt.FieldByName('ENG_CODENT').AsString + '-' +
                                                  qryCtrEnt.FieldByName('MOT_NOMMOT').AsString;
    cdsConsul.Post;

    qryCtrEnt.Next;
  End;
End;

procedure TfrmConsultaPedidos.pCompletaDadosControleEntregadores;
begin
  cdsConsul.Edit;
  cdsConsul.FieldByName('NUMROM').Value := qryEntreg.FieldByName('ENG_PROENT').Value;
  cdsConsul.FieldByName('DTAROM').Value := qryEntreg.FieldByName('ENG_DTACAD').Value;
  cdsConsul.FieldByName('HORROM').Value := qryEntreg.FieldByName('ENG_HRACAD').Value;
  cdsConsul.FieldByName('DTAROB').Value := qryEntreg.FieldByName('END_DTABAI').Value;
  cdsConsul.FieldByName('HORROB').Value := qryEntreg.FieldByName('END_HRABAI').Value;
  cdsConsul.FieldByName('MTRROM').Value := qryEntreg.FieldByName('MOT_NOMMOT').Value;
  cdsConsul.Post;
end;

procedure TfrmConsultaPedidos.pCompletaFatura;
 Var
   intField: Integer;
Begin
  With cdsConsul Do
  Begin
    qryFatura.Close;
    qryFatura.ParamByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
    qryFatura.ParamByName('ESPDOC').AsString := FieldByName('ESPDOC').AsString;
    qryFatura.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
    qryFatura.Open;

    If Not qryFatura.IsEmpty Then
    Begin

      Edit;

      FieldByName('EMPORI').AsString  := qryFatura.FieldByName('EMPORI').AsString;
      FieldByName('NUMORI').AsString  := qryFatura.FieldByName('NUMORI').AsString;
      FieldByName('ESPORI').AsString  := qryFatura.FieldByName('ESPORI').AsString;
      FieldByName('CLIORI').AsString  := qryFatura.FieldByName('CLIORI').AsString;
      FieldByName('EMPCONF').AsString := qryFatura.FieldByName('EMPCONF').AsString;
      FieldByName('NUMCONF').AsString := qryFatura.FieldByName('NUMCONF').AsString;
      FieldByName('ESPCONF').AsString := qryFatura.FieldByName('ESPCONF').AsString;

      If qryFatura.FieldByName('ESPORI').AsString = 'PD' Then
        FieldByName('STATUS').AsString := 'Desmembrado';

      If (qryFatura.FieldByName('EMIFAT').Value = Null) Then
      Begin
        FieldByName('EMIFAT').Value := Null;
        FieldByName('HRAFAT').Value := Null;
      End
      Else
      Begin
        FieldByName('EMIFAT').AsDateTime := qryFatura.FieldByName('EMIFAT').AsDateTime;
        FieldByName('HRAFAT').AsDateTime := qryFatura.FieldByName('HRAFAT').AsDateTime;
      End;

      If (qryFatura.FieldByName('EMICONF').Value = Null) Then
        FieldByName('EMICONF').Value := Null
      Else
        FieldByName('EMICONF').AsDateTime := qryFatura.FieldByName('EMICONF').AsDateTime;

      Post;

      qryFatura.Next;

      While Not qryFatura.Eof Do
      Begin
        cdsConAux.Insert;

        For intField := 0 To cdsConAux.Fields.Count -1 Do
          cdsConAux.Fields[intField].Value := cdsConsul.Fields[intField].Value;

        cdsConAux.FieldByName('EMPORI').AsString   := qryFatura.FieldByName('EMPORI').AsString;
        cdsConAux.FieldByName('NUMORI').AsString   := qryFatura.FieldByName('NUMORI').AsString;
        cdsConAux.FieldByName('ESPORI').AsString   := qryFatura.FieldByName('ESPORI').AsString;
        cdsConAux.FieldByName('CLIORI').AsString   := qryFatura.FieldByName('CLIORI').AsString;
        cdsConAux.FieldByName('EMIFAT').AsDateTime := qryFatura.FieldByName('EMIFAT').AsDateTime;
        cdsConAux.FieldByName('HRAFAT').AsDateTime := qryFatura.FieldByName('HRAFAT').AsDateTime;

        cdsConAux.FieldByName('EMPCONF').AsString   := qryFatura.FieldByName('EMPCONF').AsString;
        cdsConAux.FieldByName('NUMCONF').AsString   := qryFatura.FieldByName('NUMCONF').AsString;
        cdsConAux.FieldByName('ESPCONF').AsString   := qryFatura.FieldByName('ESPCONF').AsString;

        If (qryFatura.FieldByName('EMICONF').Value = Null) Then
          cdsConAux.FieldByName('EMICONF').Value := Null
        Else
          cdsConAux.FieldByName('EMICONF').AsDateTime := qryFatura.FieldByName('EMICONF').AsDateTime;

        If qryFatura.FieldByName('ESPORI').AsString = 'PD' Then
          cdsConAux.FieldByName('STATUS').AsString := 'Desmembrado';

        cdsConAux.Post;

        qryFatura.Next;
      End;

    End; {If Not qryFatura.IsEmpty Then}

  End;
End;

procedure TfrmConsultaPedidos.pCarregarDesmembramentos(strNumDoc, strEspDoc, strEmpDoc, strOriPed: string);
 Var
   qryPedido: TUniQuery;
   intField: Integer;
Begin
  qryDesmembramentos.Close;
  qryDesmembramentos.ParamByName('NUMDOC').AsString := strNumDoc;
  qryDesmembramentos.ParamByName('ESPDOC').AsString := strEspDoc;
  qryDesmembramentos.ParamByName('CODEMP').AsString := strEmpDoc;
  qryDesmembramentos.Open;

  While Not qryDesmembramentos.Eof Do
  Begin
    If stlPedidosCarregadosAutInc.IndexOf(qryDesmembramentos.FieldByName('AUTOIN').AsString) = -1 Then
    Begin
      qryPedido := fCriaQuery;
      try
        qryPedido.SQL.Text := fSqlConsulta(False, QuotedStr(qryDesmembramentos.FieldByName('AUTOIN').AsString));
        pSetaParametrosConsulta(qryPedido);
        qryPedido.Open;
        While Not qryPedido.Eof Do
        Begin
          cdsConAux.Insert;
          for intField := 0 To cdsConAux.Fields.Count -1 do
            cdsConAux.Fields[intField].Value := qryPedido.Fields[intField].Value;
          cdsConAux.FieldByName('ORIPED').AsString := strOriPed;
          cdsConAux.Post;
          stlPedidosCarregadosAutInc.Add(cdsConAux.FieldByName('AUTOIN').AsString);
          pCarregarDesmembramentos(qryPedido.FieldByName('NUMDOC').AsString,
                                   qryPedido.FieldByName('ESPDOC').AsString,
                                   qryPedido.FieldByName('CODEMP').AsString,
                                   strOriPed);
          qryPedido.Next;
        End;
      finally
        FreeAndNil(qryPedido);
      end;
    End;
    qryDesmembramentos.Next;
  End;
End;

procedure TfrmConsultaPedidos.pCompletaRomane;

  procedure pMudaSQLBuscaRomaneio(blnConsiderarSerie: Boolean);
  begin
    qryRomane.Close;
    qryRomane.SQL.Text := ' SELECT G.GER_NUMROM AS NUMROM, '
                        + '        G.GER_DTAROM AS DTAROM, '
                        + '        G.GER_HORROM AS HORROM, '
                        + '        G.GER_DTAINI AS DTAINI, '
                        + '        G.GER_HORINI AS HORINI, '
                        + '        G.GER_DTACHE AS DTACHE, '
                        + '        G.GER_HORCHE AS HORCHE, '
                        + '        G.GER_HORROM AS HORROM, '
                        + '        G.GER_DTABAI AS DTAROB, '
                        + '        G.GER_HORBAI AS HORROB, '
                        + '        TIMESTAMPDIFF(SECOND,   '
                        + '                      CONCAT(G.GER_DTACHE, " ", GER_HORCHE), '
                        + '                      CONCAT(G.GER_DTABAI, " ", GER_HORBAI) '
                        + '                      ) AS TMPENT, '
                        + '        G.AUTOINCREM,           '
                        + '        O.MOT_NOMMOT AS MTRROM, '
                        + '        T.TRA_NOMTRA AS NOMTRA  '
                        + ' FROM ROMGERX G LEFT JOIN CADMOT O ON G.GER_CODMOT = O.MOT_CODMOT '
                        + ' LEFT JOIN CADTRA T ON G.GER_CODTRA = T.TRA_CODTRA                '
                        + ' WHERE G.GER_NUMDOC = :NUMDOC   '
                        + '   AND G.GER_ESPDOC = :ESPDOC   '
                        + '   AND G.GER_CODEMP = :CODEMP   ';

   If blnConsiderarSerie Then
     qryRomane.SQL.Text := qryRomane.SQL.Text
                        + '   AND G.GER_SERIE_ = :SERDOC   ';
  end;

  procedure pCompletaDadosRomaneio;
  Begin
    With cdsConsul Do
    Begin
      Edit;
      FieldByName('NUMROM').Value := qryRomane.FieldByName('NUMROM').Value;
      FieldByName('DTAROM').Value := qryRomane.FieldByName('DTAROM').Value;
      FieldByName('HORROM').Value := qryRomane.FieldByName('HORROM').Value;
      FieldByName('DTAINI').Value := qryRomane.FieldByName('DTAINI').Value;
      FieldByName('HORINI').Value := qryRomane.FieldByName('HORINI').Value;
      FieldByName('DTACHE').Value := qryRomane.FieldByName('DTACHE').Value;
      FieldByName('HORCHE').Value := qryRomane.FieldByName('HORCHE').Value;
      FieldByName('DTAROB').Value := qryRomane.FieldByName('DTAROB').Value;
      FieldByName('HORROB').Value := qryRomane.FieldByName('HORROB').Value;
      if not qryRomane.FieldByName('TMPENT').IsNull then
        FieldByName('ESPERA').Value := fRetTempo(qryRomane.FieldByName('TMPENT').Value);
      FieldByName('MTRROM').Value := qryRomane.FieldByName('MTRROM').Value;
      FieldByName('NOMTRA').Value := qryRomane.FieldByName('NOMTRA').Value;
      FieldByName('ROM_AUTINC').Value := qryRomane.FieldByName('AUTOINCREM').Value;
      Post;
    End;
  End;
begin
  With cdsConsul Do
  Begin
    pMudaSQLBuscaRomaneio(False);
    qryRomane.ParamByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
    qryRomane.ParamByName('ESPDOC').AsString := FieldByName('ESPDOC').AsString;
    qryRomane.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
    qryRomane.Open;

    If (Not qryRomane.IsEmpty) Then
    Begin
      pCompletaDadosRomaneio;
    End
    Else
    Begin
      pMudaSQLBuscaRomaneio(False);
      qryRomane.ParamByName('NUMDOC').AsString := FieldByName('NUMORI').AsString;
      qryRomane.ParamByName('ESPDOC').AsString := FieldByName('ESPORI').AsString;
      qryRomane.ParamByName('CODEMP').AsString := FieldByName('EMPORI').AsString;
      qryRomane.Open;

      If (Not qryRomane.IsEmpty) Then
      Begin
        pCompletaDadosRomaneio
      End
      Else
      Begin
        pMudaSQLBuscaRomaneio(False);
        qryRomane.ParamByName('NUMDOC').AsString := FieldByName('NUMBAI').AsString;
        qryRomane.ParamByName('ESPDOC').AsString := FieldByName('ESPBAI').AsString;
        qryRomane.ParamByName('CODEMP').AsString := FieldByName('EMPBAI').AsString;
        qryRomane.Open;

        If (Not qryRomane.IsEmpty) Then
        Begin
          pCompletaDadosRomaneio
        End
        Else If (Not fCfgSis('ROMLOT', varBoolean)) And (Not fEmptyStr(FieldByName('NUMORI').AsString)) Then
        Begin
          pCarregaDocumentosControleEntregadores;
          qryEntreg.ParamByName('NUMDOC').AsString := FieldByName('NUMORI').AsString;
          qryEntreg.ParamByName('ESPDOC').AsString := FieldByName('ESPORI').AsString;
          qryEntreg.ParamByName('EMPDOC').AsString := FieldByName('EMPORI').AsString;
          qryEntreg.Open;

          If (Not qryEntreg.IsEmpty) Then
          Begin
            pCompletaDadosControleEntregadores;
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmConsultaPedidos.pConfiguraIcones(cxConsultaView: TcxGridDBBandedTableView);
  Var
    item: TcxImageComboBoxItem;
    coluna: TcxGridDBBandedColumn;
    strKey: String;
begin

  coluna := cxConsultaView.GetColumnByFieldName('STATUS');

  If Assigned(coluna) Then
  Begin
    With coluna Do
    begin
      Visible         := True;
      Width           := 25;
      Index           := 0;
      SortIndex       := -1;
      Options.Editing := False;

      If Not SameText(PropertiesClassName, 'TcxImageComboBoxProperties') Then
      Begin
        PropertiesClass := TcxImageComboBoxProperties;

        With TcxImageComboBoxProperties(Properties) Do
        Begin
          Images := frmModuloLegenda.imglLegenda;
          For strKey In TSituacaoPedidoVenda.fRetornaLegenda.Keys Do
          Begin
            item := Items.Add;
            item.ImageIndex := TSituacaoPedidoVenda.fRetornaLegenda.Items[strKey];
            item.Value      := strKey;
            item.Description:= item.Value;
          End;

          item := Items.Add;
          item.ImageIndex := -1;
          item.Value      := 'Desmembrado';
          item.Description:= item.Value;
        End;
      End;
    End;
  End;
end;

procedure TfrmConsultaPedidos.pConfiguraIconesProdutos(
  cxProdutos: TcxGridDBTableView);
var
  item: TcxImageComboBoxItem;
  coluna: TcxGridDBColumn;
  strKey: String;
begin

  coluna := cxProdutos.GetColumnByFieldName('STATUSITEM');

  If Not Assigned(coluna) Then
    Exit;

  coluna.Visible         := True;
  coluna.SortIndex       := -1;
  coluna.Options.Editing := False;

  If Not SameText(coluna.PropertiesClassName, 'TcxImageComboBoxProperties') Then
  Begin
    coluna.PropertiesClass := TcxImageComboBoxProperties;

    TcxImageComboBoxProperties(coluna.Properties).Images := frmModuloLegenda.imglLegenda;
    For strKey In TSituacaoPedidoVenda.fRetornaLegenda.Keys Do
    Begin
      item := TcxImageComboBoxProperties(coluna.Properties).Items.Add;
      item.ImageIndex := TSituacaoPedidoVenda.fRetornaLegenda.Items[strKey];
      item.Value      := strKey;
      item.Description:= item.Value;
    End;

    item := TcxImageComboBoxProperties(coluna.Properties).Items.Add;
    item.ImageIndex := -1;
    item.Value      := 'Desmembrado';
    item.Description:= item.Value;

    item := TcxImageComboBoxProperties(coluna.Properties).Items.Add;
    item.ImageIndex := -1;
    item.Value      := 'Baixado não Entregue';
    item.Description:= item.Value;
  End;
end;

procedure TfrmConsultaPedidos.pCopiaAuxiliar;
Begin
  With cdsConAux Do
  Begin

    prbProgresso.Position := 0;
    prbProgresso.Max := RecordCount;
    prbProgresso.Visible := True;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      pCopiaRegistroDataSet(cdsConAux, cdsConsul);

      Next;

      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    EmptyDataSet;
  End;
End;

procedure TfrmConsultaPedidos.pEscapePressed;
begin
  If (Not cdsConsul.IsEmpty) Then
    btnCancelaItem.Click
  Else
    btnSair.Click;
end;

procedure TfrmConsultaPedidos.pProcessaPedidos;
Begin
  With cdsConsul Do
  Begin
    DisableControls;

    prbProgresso.Position := 0;
    prbProgresso.Max := RecordCount;
    prbProgresso.Visible := True;
    Application.ProcessMessages;

    stlPedidosCarregadosAutInc.Clear;

    First;
    While Not Eof Do
    Begin
      stlPedidosCarregadosAutInc.Add(FieldByName('AUTOIN').AsString);
      cdsConsul.Edit;
      cdsConsul.FieldByName('ORIPED').AsString := fBuscarOrigemPedido(cdsConsul.FieldByName('NUMDOC').AsString,
                                                                      cdsConsul.FieldByName('ESPDOC').AsString,
                                                                      cdsConsul.FieldByName('CODEMP').AsString);
      cdsConsul.Post;
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    First;
    While Not Eof Do
    Begin
      pCarregarDesmembramentos(cdsConsul.FieldByName('NUMDOC').AsString,
                               cdsConsul.FieldByName('ESPDOC').AsString,
                               cdsConsul.FieldByName('CODEMP').AsString,
                               cdsConsul.FieldByName('ORIPED').AsString);
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    pCopiaAuxiliar;

    First;
    While Not Eof Do
    Begin
      pCompletaFatura;
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    If fCfgSis('CTRENT',varBoolean) Then
    Begin
      First;
      While Not Eof Do
      Begin
        pCompletaCtrEnt;
        Next;
        prbProgresso.StepBy(1);
        Application.ProcessMessages;
      End;
    End;

    pCopiaAuxiliar;

    prbProgresso.Position := 0;
    prbProgresso.Max := RecordCount;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      pCompletaBaixas;
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    pCopiaAuxiliar;

    prbProgresso.Position := 0;
    prbProgresso.Max := RecordCount;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      pCompletaRomane;
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    pCopiaAuxiliar;

    First;
    While Not Eof Do
    Begin
      pLimpaNumCmp;
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    pCopiaAuxiliar;

    prbProgresso.Visible := False;
    EnableControls;
  End;
End;

Procedure TfrmConsultaPedidos.pFechaConsulta;
Begin
  cdsConsul.Close;
  qryCadCli.Close;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  edtCodRed.Clear;
  edtNomRed.Text := 'TODAS';
  edtNumPed.Clear;
  edtPedCom.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtDocFat.Clear;
  edtEspFat.Clear;
  edtEmpFat.Text := VS_strCodEmp;
  cmbEntRet.ItemIndex := 0;
  edtCodDep.Clear;
  edtDesDep.Text := 'TODOS';
  edtPedSite.Clear;

  If blnFiltrosBaixaEntregaFutura Then
  Begin
    edtDocBxEntFut.Clear;
    edtEspBxEntFut.Clear;
    edtEmpBxEntFut.Text := VS_strCodEmp;
  End;

  pDesmarcaLista(edtCodDep, arrLinDep);
  pDesmarcaLista(edtCodRed, arrLinRed);
  pDesmarcaLista(edtCodProduto, arrProdutos);
  pSetarControles(True);
  pSetFocus(edtNumPed);
End;

procedure TfrmConsultaPedidos.pLimpaNumCmp;
  function fLimpaNumCmp(sNumCmp: string): tstringlist;
  var sValor   : string;
      iCont    : integer;
      stlNumCmp: TStringList;
  begin
    result    := TStringList.Create;
    stlNumCmp := TStringList.Create;
    sNumCmp := AnsiReplaceStr(sNumCmp, ';', ',');
    stlNumCmp.CommaText := sNumCmp;
    stlNumCmp.Sorted := true;
    sValor := '';
    for iCont := 0 to stlNumCmp.Count-1 do
    begin
      if sValor <> stlNumCmp.strings[iCont] then
         result.add(stlNumCmp.strings[iCont]);
      sValor := stlNumCmp.strings[iCont];
    end;
  end;
begin
  With cdsConsul Do
  Begin
    if not FieldByName('NUMCMP').isNull then
    begin
      Edit;
      FieldByName('NUMCMP').Value := fLimpaNumCmp(FieldByName('NUMCMP').Value).commatext;
      Post;
    end;
  End;
end;

Function TfrmConsultaPedidos.fIdentificaPedidosVinculados: String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
    strAutoIncrem : String;
  Function fSQLEntFut(strNumPed, strCodEmp : String): String;
    Var
      strAux: String;
      qryTmp: TUniQuery;
  Begin
    Try
      strAux := '';
      Result := '';

      strAux := strAux + 'SELECT ';
      strAux := strAux + '  D.AUTOINCREM ';
      strAux := strAux + 'FROM ';
      strAux := strAux + '  FATDOR F ';
      strAux := strAux + '  INNER JOIN MOVDET D ON F.FDO_NUMFAT = D.DET_NUMDOC ';
      strAux := strAux + '                     AND F.FDO_TIPFAT = D.DET_ESPDOC ';
      strAux := strAux + '                     AND F.FDO_EMPFAT = D.DET_CODEMP ';
      strAux := strAux + 'WHERE ';
      strAux := strAux + '  FDO_NUMDOC  = :NUMDOC AND ';
      strAux := strAux + '  FDO_CODEMP  = :CODEMP AND ';
      strAux := strAux + '  FDO_ESPDOC  = "PD"    AND ';
      strAux := strAux + '  FDO_TIPFAT <> "PD"        ';

      qryTmp := fCriaQuery;
      qryTmp.Close;
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add(strAux);
      qryTmp.ParamByName('NUMDOC').AsString := strNumPed;
      qryTmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmp.Open;
      If Not qryTmp.isEmpty Then
      Begin
        While Not qryTmp.Eof do
        Begin
          Result := Result + QuotedStr(qryTmp.FieldByName('AUTOINCREM').asString)+ ',';
          qryTmp.Next;
        End;
        Result := Copy(Result, 1, Length(Result)-1);
      End;
    Finally
      FreeAndNil(qryTmp);
    End;
  End;

  function fGetSqlAgrupamentoDup(strDocFat, strEmpFat : String) : String;
  Begin
    Result := '';

    if (fEmptyStr(strDocFat)) or (fEmptyStr(strEmpFat)) then
      Exit;

    Result := Result + ' SELECT ';
    Result := Result + '   DISTINCT F.FDO_SEQGER ';
    Result := Result + ' FROM DUPAGR DUP ';
    Result := Result + ' INNER JOIN MOVDET D ON D.DET_NUMDOC = DUP.CTR_NUMDUP AND ';
    Result := Result + '                        D.DET_ESPDOC = DUP.CTR_ESPDOC AND ';
    Result := Result + '                        D.DET_CODEMP = DUP.CTR_CODEMP AND ';
    Result := Result + '                        D.DET_CODCLI = DUP.CTR_CODCLI  ';
    Result := Result + ' LEFT JOIN FATDOR F ON D.DET_NUM_PD = F.FDO_NUMDOC AND ';
    Result := Result + '                       D.DET_ESP_PD = F.FDO_ESPDOC AND ';
    Result := Result + '                       D.DET_EMP_PD = F.FDO_CODEMP AND ';
    Result := Result + '                       D.DET_CODITE = F.FDO_CODITE AND ';
    Result := Result + '                       D.DET_IND_PD = F.FDO_SEQIND     ';
    Result := Result + ' WHERE CTR_NUMAGR = '+QuotedStr(strDocFat)+' AND  ';
    Result := Result + '       CTR_CODEMP = '+QuotedStr(strEmpFat)+' AND  ';
    Result := Result + '       F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
    Result := Result + '       F.FDO_SEQGER IS NOT NULL ';
  End;

begin

  qryTmp := fCriaQuery;
  Result := '';
  strSQL := '';

  Try

    If Not fEmptyStr(edtNumPed.Text) Then
    Begin
      //PESQUISA O PRÓPIO PEDIDO
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   FDO_SEQGER ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   FATDOR ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '   FDO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   FDO_ESPDOC = "PD"        ';

      //PESQUISA PEDIDOS VINCULADOS
      strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   FDO_SEQGER ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   FATDOR ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '   FDO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   FDO_ESPDOC = "PD"    AND ';
      strSQL := strSQL + '   FDO_TIPFAT = "PD" ';

      If Not fEmptyStr(fSQLEntFut(edtNumPed.Text, edtCodEmp.Text)) Then
      Begin
        strSQL := strSQL + ' UNION ALL ';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   FDO_SEQGER ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   FATDOR F INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ';
        strSQL := strSQL + ' WHERE F.FDO_ESPDOC = "PD" ';
        strSQL := strSQL + '   AND E.FDO_INCFUT IN (' + fSQLEntFut(edtNumPed.Text, edtCodEmp.Text) + ') ';
      End;

      strSQL := strSQL + ' UNION ALL ';

      //PEDIDO DE ORIGEM
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   C.AUTOINCREM ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   FATGOR A ';
      strSQL := strSQL + '   INNER JOIN EXTGOR B ';
      strSQL := strSQL + '     ON B.FGO_SEQFGO = A.AUTOINCREM ';
      strSQL := strSQL + '   INNER JOIN FATGOR C ';
      strSQL := strSQL + '     ON B.FGO_NUMORI = C.FGO_NUMDOC ';
      strSQL := strSQL + '     AND B.FGO_ESPORI = C.FGO_ESPDOC ';
      strSQL := strSQL + '     AND B.FGO_EMPORI = C.FGO_CODEMP ';
      strSQL := strSQL + ' WHERE A.FGO_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '   AND A.FGO_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND A.FGO_ESPDOC = "PD" ';

      strSQL := strSQL + ' UNION ALL ';

      //DESMEMBRAMENTOS - ORIGEM
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   DISTINCT A.FDO_SEQGER ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   FATDOR A ';
      strSQL := strSQL + ' WHERE A.FDO_NUMFAT = :NUMDOC ';
      strSQL := strSQL + '   AND A.FDO_EMPFAT = :CODEMP ';
      strSQL := strSQL + '   AND A.FDO_TIPFAT = "PD" ';

      strSQL := strSQL + ' UNION ALL ';

      //DESMEMBRAMENTOS - FILHOS
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   FATGOR.AUTOINCREM AS AUTOIN ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   FATDOR JOIN FATGOR ';
      strSQL := strSQL + '     ON FGO_NUMDOC = FATDOR.FDO_NUMFAT ';
      strSQL := strSQL + '    AND FGO_ESPDOC = FATDOR.FDO_TIPFAT ';
      strSQL := strSQL + '    AND FGO_CODEMP = FATDOR.FDO_EMPFAT ';
      strSQL := strSQL + ' WHERE FDO_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '   AND FDO_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND FDO_ESPDOC = "PD" ';
      strSQL := strSQL + '   AND FDO_TIPFAT = "PD" ';
    End;

    //PESQUISA POR DOCUMENTO DE FATURAMENTO
    If Not fEmptyStr(edtDocFat.Text) Then
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   F.FDO_SEQGER ';
      strSQL := strSQL + ' FROM MOVDET D LEFT JOIN MOVAUX A ON D.AUTOINCREM = A.DET_SEQGER ';
      strSQL := strSQL + '               LEFT JOIN FATDOR F ON A.DET_INC_PD = F.AUTOINCREM ';
      strSQL := strSQL + ' WHERE F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
      strSQL := strSQL + '       D.DET_NUMDOC = '+QuotedStr(edtDocFat.Text)+' AND ';
      strSQL := strSQL + '       D.DET_ESPDOC = '+QuotedStr(edtEspFat.Text)+' AND ';
      strSQL := strSQL + '       D.DET_CODEMP = '+QuotedStr(edtEmpFat.Text)+' AND ';
      strSQL := strSQL + '       F.FDO_SEQGER IS NOT NULL ';

      strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   F.FDO_SEQGER ';
      strSQL := strSQL + ' FROM MOVDET D LEFT JOIN FATDOR F ON D.DET_NUM_PD = F.FDO_NUMDOC AND ';
      strSQL := strSQL + '                                     D.DET_ESP_PD = F.FDO_ESPDOC AND ';
      strSQL := strSQL + '                                     D.DET_EMP_PD = F.FDO_CODEMP AND ';
      strSQL := strSQL + '                                     D.DET_CODITE = F.FDO_CODITE AND ';
      strSQL := strSQL + '                                     D.DET_IND_PD = F.FDO_SEQIND ';
      strSQL := strSQL + ' WHERE F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
      strSQL := strSQL + '       D.DET_NUMDOC = '+QuotedStr(edtDocFat.Text)+' AND ';
      strSQL := strSQL + '       D.DET_ESPDOC = '+QuotedStr(edtEspFat.Text)+' AND ';
      strSQL := strSQL + '       D.DET_CODEMP = '+QuotedStr(edtEmpFat.Text)+' AND ';
      strSQL := strSQL + '       F.FDO_SEQGER IS NOT NULL ';

      If (fCarregarDadosCadCtaReceber) and (edtEspFat.Text = 'AG') and
         (not fEmptyStr(fGetSqlAgrupamentoDup(edtDocFat.Text, edtEmpFat.Text)))
      Then
      Begin
        If Not fEmptyStr(strSQL) Then
          strSQL := strSQL + ' UNION ALL ';

        strSQL := strSQL + fGetSqlAgrupamentoDup(edtDocFat.Text, edtEmpFat.Text);
      End;
    End;

    If (fCarregarDadosMostraDebCtrChq2) Then
    Begin
      strAutoIncrem := '';
      cdsInfDuplicatas.First;
      While not cdsInfDuplicatas.Eof Do
      Begin
        If (cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString = 'AG') and
           (not fEmptyStr(fGetSqlAgrupamentoDup(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString)))
        Then
        Begin
          If Not fEmptyStr(strSQL) Then
            strSQL := strSQL + ' UNION ALL ';

          strSQL := strSQL + fGetSqlAgrupamentoDup(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString);
        End
        Else If (cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString = 'FF') and
                (Not fEmptyStr(fSQLEntFut(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString))) Then
        Begin
          If Not fEmptyStr(strSQL) Then
            strSQL := strSQL + ' UNION ALL ';
          strSQL := strSQL + ' SELECT ';
          strSQL := strSQL + '   FDO_SEQGER ';
          strSQL := strSQL + ' FROM ';
          strSQL := strSQL + '   FATDOR F INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ';
          strSQL := strSQL + ' WHERE F.FDO_ESPDOC = "PD" ';
          strSQL := strSQL + '   AND E.FDO_INCFUT IN (' + fSQLEntFut(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString) + ') ';
        End
        Else
          strAutoIncrem := strAutoIncrem + QuotedStr(cdsInfDuplicatas.FieldByName('SEQDUP').AsString)+',';

        cdsInfDuplicatas.Next;
      End;

      If (not fEmptyStr(strAutoIncrem)) Then
      Begin
          strAutoIncrem := LeftStr(strAutoIncrem, Length(strAutoIncrem) -1);
          If Not fEmptyStr(strSQL) Then
            strSQL := strSQL + ' UNION ALL ';

          strSQL := strSQL + ' SELECT DISTINCT FDO_SEQGER ';
          strSQL := strSQL + ' FROM ( ';
          strSQL := strSQL + '       SELECT ';
          strSQL := strSQL + '         DISTINCT F.FDO_SEQGER ';
          strSQL := strSQL + '       FROM CADREC ';
          strSQL := strSQL + '       INNER JOIN MOVDET D ON D.DET_NUMDOC = CTR_NUMDUP AND ';
          strSQL := strSQL + '                              D.DET_ESPDOC = CTR_ESPDOC AND ';
          strSQL := strSQL + '                              D.DET_CODEMP = CTR_CODEMP AND ';
          strSQL := strSQL + '                              D.DET_CODCLI = CTR_CODCLI ';
          strSQL := strSQL + '       LEFT JOIN FATDOR F ON D.DET_NUM_PD = F.FDO_NUMDOC AND ';
          strSQL := strSQL + '                             D.DET_ESP_PD = F.FDO_ESPDOC AND ';
          strSQL := strSQL + '                             D.DET_EMP_PD = F.FDO_CODEMP AND ';
          strSQL := strSQL + '                             D.DET_CODITE = F.FDO_CODITE AND ';
          strSQL := strSQL + '                             D.DET_IND_PD = F.FDO_SEQIND ';
          strSQL := strSQL + '       WHERE CADREC.AUTOINCREM IN ('+strAutoIncrem+') AND ';
          strSQL := strSQL + '             F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
          strSQL := strSQL + '             F.FDO_SEQGER IS NOT NULL ';
          strSQL := strSQL + '       ';
          strSQL := strSQL + '       UNION ALL ';
          strSQL := strSQL + '       ';
          strSQL := strSQL + '       SELECT ';
          strSQL := strSQL + '         DISTINCT F.FDO_SEQGER ';
          strSQL := strSQL + '       FROM CADREC ';
          strSQL := strSQL + '       INNER JOIN FATDOR F ON F.FDO_NUMDOC = CTR_NUMDUP AND ';
          strSQL := strSQL + '                              F.FDO_ESPDOC = CTR_ESPDOC AND ';
          strSQL := strSQL + '                              F.FDO_CODEMP = CTR_CODEMP AND ';
          strSQL := strSQL + '                              F.FDO_CODCLI = CTR_CODCLI ';
          strSQL := strSQL + '       WHERE CADREC.AUTOINCREM IN ('+strAutoIncrem+') AND ';
          strSQL := strSQL + '             F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
          strSQL := strSQL + '             F.FDO_SEQGER IS NOT NULL ';
          strSQL := strSQL + ' ) AS TMP ';
      End;

    End
    Else If (fCarregarDadosInfCobranca) Then
    Begin
      strAutoIncrem := '';
      cdsInfDuplicatas.First;
      While not cdsInfCob.Eof do
      Begin
        cdsInfDuplicatas.Filtered := False;
        cdsInfDuplicatas.Filter   := 'CTR_CODCLI = ' + QuotedStr(cdsInfCob.FieldByName('CLI_CODCLI').AsString);
        cdsInfDuplicatas.Filtered := True;
        cdsInfDuplicatas.First;

        While not cdsInfDuplicatas.Eof Do
        Begin
          If (cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString = 'AG') and
             (not fEmptyStr(fGetSqlAgrupamentoDup(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString)))
          Then
          Begin
            If Not fEmptyStr(strSQL) Then
              strSQL := strSQL + ' UNION ALL ';

            strSQL := strSQL + fGetSqlAgrupamentoDup(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString);
          End
          Else If (cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString = 'FF') and
                  (Not fEmptyStr(fSQLEntFut(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString))) Then
          Begin
            If Not fEmptyStr(strSQL) Then
              strSQL := strSQL + ' UNION ALL ';
            strSQL := strSQL + ' SELECT ';
            strSQL := strSQL + '   FDO_SEQGER ';
            strSQL := strSQL + ' FROM ';
            strSQL := strSQL + '   FATDOR F INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ';
            strSQL := strSQL + ' WHERE F.FDO_ESPDOC = "PD" ';
            strSQL := strSQL + '   AND E.FDO_INCFUT IN (' + fSQLEntFut(cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString, cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString) + ') ';
          End
          Else
            strAutoIncrem := strAutoIncrem + QuotedStr(cdsInfDuplicatas.FieldByName('AUTOINCREM').AsString)+',';

          cdsInfDuplicatas.Next;
        End;

        cdsInfDuplicatas.Filtered := False;
        cdsInfDuplicatas.Filter   := '';
        cdsInfDuplicatas.Filtered := True;

        cdsInfCob.Next;
      End;

      If (not fEmptyStr(strAutoIncrem)) Then
      Begin
          strAutoIncrem := LeftStr(strAutoIncrem, Length(strAutoIncrem) -1);
          If Not fEmptyStr(strSQL) Then
            strSQL := strSQL + ' UNION ALL ';

          strSQL := strSQL + ' SELECT DISTINCT FDO_SEQGER ';
          strSQL := strSQL + ' FROM ( ';
          strSQL := strSQL + '       SELECT ';
          strSQL := strSQL + '         DISTINCT F.FDO_SEQGER ';
          strSQL := strSQL + '       FROM CADREC ';
          strSQL := strSQL + '       INNER JOIN MOVDET D ON D.DET_NUMDOC = CTR_NUMDUP AND ';
          strSQL := strSQL + '                              D.DET_ESPDOC = CTR_ESPDOC AND ';
          strSQL := strSQL + '                              D.DET_CODEMP = CTR_CODEMP AND ';
          strSQL := strSQL + '                              D.DET_CODCLI = CTR_CODCLI ';
          strSQL := strSQL + '       LEFT JOIN FATDOR F ON D.DET_NUM_PD = F.FDO_NUMDOC AND ';
          strSQL := strSQL + '                             D.DET_ESP_PD = F.FDO_ESPDOC AND ';
          strSQL := strSQL + '                             D.DET_EMP_PD = F.FDO_CODEMP AND ';
          strSQL := strSQL + '                             D.DET_CODITE = F.FDO_CODITE AND ';
          strSQL := strSQL + '                             D.DET_IND_PD = F.FDO_SEQIND ';
          strSQL := strSQL + '       WHERE CADREC.AUTOINCREM IN ('+strAutoIncrem+') AND ';
          strSQL := strSQL + '             F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
          strSQL := strSQL + '             F.FDO_SEQGER IS NOT NULL ';
          strSQL := strSQL + '       ';
          strSQL := strSQL + '       UNION ALL ';
          strSQL := strSQL + '       ';
          strSQL := strSQL + '       SELECT ';
          strSQL := strSQL + '         DISTINCT F.FDO_SEQGER ';
          strSQL := strSQL + '       FROM CADREC ';
          strSQL := strSQL + '       INNER JOIN FATDOR F ON F.FDO_NUMDOC = CTR_NUMDUP AND ';
          strSQL := strSQL + '                              F.FDO_ESPDOC = CTR_ESPDOC AND ';
          strSQL := strSQL + '                              F.FDO_CODEMP = CTR_CODEMP AND ';
          strSQL := strSQL + '                              F.FDO_CODCLI = CTR_CODCLI ';
          strSQL := strSQL + '       WHERE CADREC.AUTOINCREM IN ('+strAutoIncrem+') AND ';
          strSQL := strSQL + '             F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
          strSQL := strSQL + '             F.FDO_SEQGER IS NOT NULL ';
          strSQL := strSQL + ' ) AS TMP ';
      End;

    End;

    //PESQUISA POR NÚMERO DA BAIXA DE ENTREGA FUTURA
    If Not fEmptyStr(edtDocBxEntFut.Text) Then
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   F.FDO_SEQGER ';
      strSQL := strSQL + ' FROM MOVDET D LEFT JOIN MOVDET E ON D.DET_DOCFUT = E.DET_NUMDOC AND ';
      strSQL := strSQL + '                                     D.DET_ESPFUT = E.DET_ESPDOC AND ';
      strSQL := strSQL + '                                     D.DET_EMPFUT = E.DET_CODEMP ';
      strSQL := strSQL + '               LEFT JOIN MOVAUX A ON E.AUTOINCREM = A.DET_SEQGER ';
      strSQL := strSQL + '               LEFT JOIN FATDOR F ON A.DET_INC_PD = F.AUTOINCREM ';
      strSQL := strSQL + ' WHERE F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
      strSQL := strSQL + '       D.DET_NUMDOC = '+QuotedStr(edtDocBxEntFut.Text)+' AND ';
      strSQL := strSQL + '       D.DET_ESPDOC = '+QuotedStr(edtEspBxEntFut.Text)+' AND ';
      strSQL := strSQL + '       D.DET_CODEMP = '+QuotedStr(edtEmpBxEntFut.Text)+' AND ';
      strSQL := strSQL + '       F.FDO_SEQGER IS NOT NULL ';

      strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   F.FDO_SEQGER ';
      strSQL := strSQL + ' FROM FATDOR D LEFT JOIN EXTDOR T ON D.AUTOINCREM = T.FDO_SEQFDO ';
      strSQL := strSQL + '               LEFT JOIN MOVAUX A ON T.FDO_INCFUT = A.DET_SEQGER ';
      strSQL := strSQL + '               LEFT JOIN FATDOR F ON A.DET_INC_PD = F.AUTOINCREM ';
      strSQL := strSQL + ' WHERE F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
      strSQL := strSQL + '       D.FDO_NUMDOC = '+QuotedStr(edtDocBxEntFut.Text)+' AND ';
      strSQL := strSQL + '       D.FDO_ESPDOC = '+QuotedStr(edtEspBxEntFut.Text)+' AND ';
      strSQL := strSQL + '       D.FDO_CODEMP = '+QuotedStr(edtEmpBxEntFut.Text)+' AND ';
      strSQL := strSQL + '       F.FDO_SEQGER IS NOT NULL ';

    End;

    //PESQUISA POR PEDIDO DE COMPRA
    If Not fEmptyStr(edtPedCom.Text) Then
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   FDO_SEQGER ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   FATDOR F INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   F.FDO_ESPDOC NOT IN ("PR", "OR") AND ';
      strSQL := strSQL + '   E.FDO_NUMCMP = '+QuotedStr(edtPedCom.Text);

      strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + ' SELECT CMP_SEQGER AS FDO_SEQGER ';
      strSQL := strSQL + ' FROM NUMCMP ';
      strSQL := strSQL + ' WHERE CMP_NUMCMP = ' +QuotedStr(edtPedCom.Text);
    End;

    If Not fEmptyStr(strSQL) Then
    Begin
      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        If FindParam('NUMDOC') <> Nil Then
          ParamByName('NUMDOC').AsString := edtNumPed.Text;
        If FindParam('CODEMP') <> Nil Then
          ParamByName('CODEMP').AsString := edtCodEmp.Text;
        Open;

        If Not IsEmpty Then
        Begin
          While Not Eof Do
          Begin
            pIncrementaListaStr(FieldByName('FDO_SEQGER').AsString, Result, True);
            Next;
          End;
        End
        Else
        Begin
          If (Not fEmptyStr(edtNumPed.Text)) Or
             (Not fEmptyStr(edtPedCom.Text)) Or
             (Not fEmptyStr(edtDocFat.Text)) Or
             (Not fEmptyStr(edtDocBxEntFut.Text)) Then
          Result := '"<FALSE>"';
        End;

        Close;
      End;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmConsultaPedidos.pSalvaFiltros;
begin
  if blnChamouPelaExpedicao then
    Exit;

  objSalInt.fAtualizaDados();
  objSalInt.pAddMultiSelecao(arrProdutos, 'CODPRD');
  objSalInt.pAddMultiSelecao(arrLinRed,   'LINRED');
  objSalInt.pAddMultiSelecao(arrLinDep,   'LINDEP');

  objSalInt.fSalvaDados('', Self.Name, strLoginUsuarioLogado, True);
end;

procedure TfrmConsultaPedidos.pCarregaFiltros;
begin
  if blnChamouPelaExpedicao then
    Exit;

  objSalInt.fCarregaDados('', Self, Self.Name, strLoginUsuarioLogado);
  objSalInt.pCarregaMultiSelecao(arrProdutos, 'CODPRD');
  objSalInt.pCarregaMultiSelecao(arrLinRed,   'LINRED');
  objSalInt.pCarregaMultiSelecao(arrLinDep,   'LINDEP');
end;

procedure TfrmConsultaPedidos.pCarregaItensPedido;
begin
  qryItensPedido.Close;
  qryItensPedido.SQL.Clear;

  qryItensPedido.SQL.Add('SELECT                                                                                                                                                                           ');
  qryItensPedido.SQL.Add('	F.*,                                                                                                                                                                           ');
  qryItensPedido.SQL.Add('	IFNULL(CONCAT(ORI.DET_NUMDOC,"-",ORI.DET_ESPDOC,"-",ORI.DET_CODEMP),CONCAT(F.FDO_NUMFAT,"-",F.FDO_TIPFAT,"-",F.FDO_EMPFAT)) AS FATURA,                                         ');
  qryItensPedido.SQL.Add('	ORI.DET_QTDITE AS ORI_QTDITE,                                                                                                                                                  ');
  qryItensPedido.SQL.Add('	CONCAT(BAI.DET_NUMDOC,"-",BAI.DET_ESPDOC,"-",BAI.DET_CODEMP) AS BAIXA,                                                                                                         ');
  qryItensPedido.SQL.Add('	BAI.DET_QTDITE AS BAI_QTDITE,                                                                                                                                                  ');
  qryItensPedido.SQL.Add('  CONCAT(F.ENTRET, " ", IFNULL(F.FDO_MOTFUT,"")) AS DESTINO,                                                                                                                     ');
  qryItensPedido.SQL.Add('	(SELECT SUM(IFNULL(DET_QTDBAI, 0))                                                                                                                                             ');
  qryItensPedido.SQL.Add('	FROM ROMDETX                                                                                                                                                                   ');
  qryItensPedido.SQL.Add('	WHERE                                                                                                                                                                          ');
  qryItensPedido.SQL.Add('		    ROMDETX.DET_NUMROM = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_NUMROM,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_NUMROM,RBAI.DET_NUMROM))                                     ');
  qryItensPedido.SQL.Add('		AND ROMDETX.DET_EMPROM = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_EMPROM,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_EMPROM,RBAI.DET_EMPROM))                                     ');
  qryItensPedido.SQL.Add('		AND ROMDETX.DET_AUTINC = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_AUTINC,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_AUTINC,RBAI.DET_AUTINC))                                     ');
  qryItensPedido.SQL.Add('		AND ROMDETX.DET_CODITE = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_CODITE,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_CODITE,RBAI.DET_CODITE))                                     ');
  qryItensPedido.SQL.Add('		AND ROMDETX.DET_CODEMP = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_CODEMP,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_CODEMP,RBAI.DET_CODEMP))                                     ');
  qryItensPedido.SQL.Add('		AND ROMDETX.DET_NUMDOC = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_NUMDOC,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_NUMDOC,RBAI.DET_NUMDOC))                                     ');
  qryItensPedido.SQL.Add('		AND ROMDETX.DET_ESPDOC = IF(ROPD.DET_AUTINC IS NOT NULL,ROPD.DET_ESPDOC,IF(RORI.DET_AUTINC IS NOT NULL,RORI.DET_ESPDOC,RBAI.DET_ESPDOC))) AS GER_QTDROM,                     ');
  qryItensPedido.SQL.Add('	(SELECT IFNULL(OBS_OBSERV, "")                                                                                                                                                 ');
  qryItensPedido.SQL.Add('	FROM ROMGERX                                                                                                                                                                   ');
  qryItensPedido.SQL.Add('		LEFT JOIN ROMOBSX ON ROMGERX.GER_NUMROM = OBS_NUMROM AND ROMGERX.GER_EMPROM = OBS_EMPROM                                                                                     ');
  qryItensPedido.SQL.Add('	WHERE                                                                                                                                                                          ');
  qryItensPedido.SQL.Add('		    GER_NUMROM = RGER.GER_NUMROM                                                                                                                                             ');
  qryItensPedido.SQL.Add('		AND GER_EMPROM = RGER.GER_EMPROM                                                                                                                                             ');
  qryItensPedido.SQL.Add('		AND OBS_ESPDOC = RGER.GER_ESPDOC                                                                                                                                             ');
  qryItensPedido.SQL.Add('		AND OBS_NUMDOC = RGER.GER_NUMDOC                                                                                                                                             ');
  qryItensPedido.SQL.Add('	LIMIT 1) GER_OBSBAI,                                                                                                                                                           ');
  qryItensPedido.SQL.Add('	RGER.GER_NUMROM,                                                                                                                                                               ');
  qryItensPedido.SQL.Add('	RGER.GER_CODEMP,                                                                                                                                                               ');
  qryItensPedido.SQL.Add('	(CASE RGER.GER_STATUS                                                                                                                                                          ');
  qryItensPedido.SQL.Add('		WHEN "A" THEN "ROMANEIO ATIVO"                                                                                                                                               ');
  qryItensPedido.SQL.Add('		WHEN "P" THEN "PRÉ-ROMANEIO"                                                                                                                                                 ');
  qryItensPedido.SQL.Add('	END) AS GER_STATUS,                                                                                                                                                            ');
  qryItensPedido.SQL.Add('	CONCAT_WS(" ",DATE_FORMAT(RGER.GER_DTALIB, "%d/%m/%Y"),DATE_FORMAT(RGER.GER_HORLIB, "%H:%i"),(SELECT OPE_NOMOPE                                                                ');
  qryItensPedido.SQL.Add('        FROM CADOPE                                                                                                                                                              ');
  qryItensPedido.SQL.Add('	WHERE OPE_CODOPE = RGER.GER_OPELIB)) AS GER_LIBROM,																																                                                             ');
  qryItensPedido.SQL.Add('	CONCAT_WS(" ",DATE_FORMAT(RGER.GER_DTABAI, "%d/%m/%Y"),DATE_FORMAT(RGER.GER_HORBAI, "%H:%i"),RGER.GER_NOMREC) AS GER_DTABAI,                                                   ');
  qryItensPedido.SQL.Add('	MOT_NOMMOT,                                                                                                                                                                    ');
  qryItensPedido.SQL.Add('	TRA_NOMTRA,                                                                                                                                                                    ');
  qryItensPedido.SQL.Add('	COALESCE(ORI.DET_NUMLOT, "") AS NUMLOTFAT                                                                                                                                      ');
  qryItensPedido.SQL.Add('FROM                                                                                                                                                                             ');
  qryItensPedido.SQL.Add('	(SELECT                                                                                                                                                                        ');
  qryItensPedido.SQL.Add('		FATDOR.AUTOINCREM AS FDO_AUTINC,                                                                                                                                             ');
  qryItensPedido.SQL.Add('		CONCAT(FDO_CODITE, " - ", FDO_DESCRI) AS CODITE,                                                                                                                             ');
  qryItensPedido.SQL.Add('		(CASE                                                                                                                                                                        ');
  qryItensPedido.SQL.Add('			WHEN EXTDOR.FDO_ENTRET = "E" THEN                                                                                                                                          ');
  qryItensPedido.SQL.Add('			/*ENTREGA*/                                                                                                                                                                ');
  qryItensPedido.SQL.Add('				(CASE                                                                                                                                                                    ');
  qryItensPedido.SQL.Add('					WHEN FATDOR.FDO_ENTFUT = "S" THEN "ENT-F"                                                                                                                              ');
  qryItensPedido.SQL.Add('					/*ENTREGA FUTURA*/                                                                                                                                                     ');
  qryItensPedido.SQL.Add('					WHEN FATDOR.FDO_ENTFUT = "N" THEN "ENT-I"                                                                                                                              ');
  qryItensPedido.SQL.Add('					/*ENTREGA IMEDIATA*/                                                                                                                                                   ');
  qryItensPedido.SQL.Add('				END)                                                                                                                                                                     ');
  qryItensPedido.SQL.Add('			WHEN EXTDOR.FDO_ENTRET = "R" THEN                                                                                                                                          ');
  qryItensPedido.SQL.Add('			/*RETIRADA*/                                                                                                                                                               ');
  qryItensPedido.SQL.Add('				(CASE                                                                                                                                                                    ');
  qryItensPedido.SQL.Add('					WHEN COALESCE(CFGSIS.SIS_VALCFG, "") <> "S" THEN "RET"                                                                                                                 ');
  qryItensPedido.SQL.Add('					/*RETIRA, COM CFG_CLARET DESLIGADA*/                                                                                                                                   ');
  qryItensPedido.SQL.Add('					WHEN EXTDOR.FDO_LOCRET = "C" THEN "RET-C"                                                                                                                              ');
  qryItensPedido.SQL.Add('					/*RETIRA, COM CFG_CLARET LIGADA, CAMPO LOGRET = C ( CAIXA )*/                                                                                                          ');
  qryItensPedido.SQL.Add('					WHEN EXTDOR.FDO_LOCRET = "E" THEN "RET-E"                                                                                                                              ');
  qryItensPedido.SQL.Add('					/*RETIRA, COM CFG_CLARET LIGADA, CAMPO LOGRET = E ( EXPEDICAO )*/                                                                                                      ');
  qryItensPedido.SQL.Add('				END)                                                                                                                                                                     ');
  qryItensPedido.SQL.Add('		END) ENTRET,                                                                                                                                                                 ');
  qryItensPedido.SQL.Add('		FDO_CODITE,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_DESCRI,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_QTDITE,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_NUMDOC,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_ESPDOC,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_CODEMP,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_NUMFAT,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_TIPFAT,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_EMPFAT,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_QTDBAI,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		IF(FDO_ENTFUT = "S", "SIM", "NÃO") AS FDO_ENTFUT,                                                                                                                            ');
  qryItensPedido.SQL.Add('		CASE FDO_MOTFUT                                                                                                                                                              ');
  qryItensPedido.SQL.Add('			WHEN "F" THEN "FALTA PRODUTO"                                                                                                                                              ');
  qryItensPedido.SQL.Add('			WHEN "A" THEN "AGUARDA CLIENTE"                                                                                                                                            ');
  qryItensPedido.SQL.Add('			WHEN "P" THEN "PREVISÃO ENTREGA"                                                                                                                                           ');
  qryItensPedido.SQL.Add('		END AS FDO_MOTFUT,                                                                                                                                                           ');
  qryItensPedido.SQL.Add('		FDO_DTAFUT,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		FDO_NUMLOT,                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('		CAST(" " AS CHAR(50)) AS STATUSITEM,                                                                                                                                         ');
  qryItensPedido.SQL.Add('		EXTDOR.FDO_NUMCMP,                                                                                                                                                           ');
  qryItensPedido.SQL.Add('		EXTDOR.FDO_DTENTR,                                                                                                                                                           ');
  qryItensPedido.SQL.Add('		SUM(EXTDOR.FDO_QTDEXP) AS FDO_QTDEXP,                                                                                                                                        ');
  qryItensPedido.SQL.Add('		EXTDOR.FDO_NITCMP,                                                                                                                                                           ');
  qryItensPedido.SQL.Add('    PD.PCD_DTAENT AS DATA_ENTREGA_PEDIDO,                                                                                                                                        ');
  qryItensPedido.SQL.Add('		CONCAT(IFNULL(RC.RCD_CODIGO, RP.RCD_CODIGO),"-",IFNULL(RC.RCD_CODEMP, RP.RCD_CODEMP)) AS REQUISICAO,                                                                         ');
  qryItensPedido.SQL.Add('		CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,"-",PD.PCD_CODEMP) AS PEDIDO_DE_COMPRA_REQUISICAO,                                                                                    ');
  qryItensPedido.SQL.Add('    CAST(GROUP_CONCAT(PT.PRE_NUMDOC,"-",PT.PRE_ESPDOC,"-",PT.PRE_EMPDOC,                                                                                                         ');
  qryItensPedido.SQL.Add('                      (SELECT CONCAT(" / ", FGO_EMPEXP)                                                                                                                          ');
  qryItensPedido.SQL.Add('                       FROM FATGOR                                                                                                                                               ');
  qryItensPedido.SQL.Add('                       INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM                                                                                                       ');
  qryItensPedido.SQL.Add('                       WHERE FGO_NUMDOC = PT.PRE_NUMDOC AND FGO_ESPDOC = PT.PRE_ESPDOC AND FGO_CODEMP = PT.PRE_EMPDOC                                                            ');
  qryItensPedido.SQL.Add('                      ) SEPARATOR " | ") AS CHAR(200)) AS TRANSFERENCIA,                                                                                                                            ');
  qryItensPedido.SQL.Add('		(SELECT GROUP_CONCAT((SELECT CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP)                                                                                                ');
  qryItensPedido.SQL.Add('		 FROM MOVDET                                                                                                                                                                 ');
  qryItensPedido.SQL.Add('		 WHERE AUTOINCREM = BQ.BAI_AUTDET) SEPARATOR ", ")) AS NOTA_DE_ENTRADA,                                                                                                      ');
  qryItensPedido.SQL.Add('    I.ITE_REFERE AS REFERE,                                                                                                                                                      ');
  qryItensPedido.SQL.Add('    I.ITE_CODFAB AS CODFAB,                                                                                                                                                      ');
  qryItensPedido.SQL.Add('    I.ITE_CODBAR AS CODBAR,                                                                                                                                                      ');
  qryItensPedido.SQL.Add('    CONCAT(IFNULL(I.ITE_CODMAR,""),"-",MAR_DESMAR) AS MARCA,                                                                                                                     ');
  qryItensPedido.SQL.Add('    FDO_SEQIND                                                                                                                                                                   ');
  qryItensPedido.SQL.Add('		FROM FATDOR                                                                                                                                                                  ');
  qryItensPedido.SQL.Add('			LEFT JOIN CFGSIS ON CFGSIS.SIS_CODEMP = FATDOR.FDO_CODEMP AND CFGSIS.SIS_CODCFG = "CFG_LOCRET"                                                                             ');
  qryItensPedido.SQL.Add('			LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM                                                                                                                  ');
  qryItensPedido.SQL.Add('			LEFT JOIN FDOABS AB ON AB.ABS_SEQFDO = FATDOR.AUTOINCREM                                                                                                                   ');
  qryItensPedido.SQL.Add('			LEFT JOIN PREPRQ RQ ON RQ.AUTOINCREM = AB.ABS_SEQPRQ                                                                                                                       ');
  qryItensPedido.SQL.Add('			LEFT JOIN MOVRCD RC ON RC.AUTOINCREM = RQ.PRQ_SEQRCD                                                                                                                       ');
  qryItensPedido.SQL.Add('			LEFT JOIN MOVRCD RP ON RP.RCD_DOCPDV = FATDOR.FDO_NUMDOC AND RP.RCD_ESPPDV = FATDOR.FDO_ESPDOC AND RP.RCD_EMPPDV = FATDOR.FDO_CODEMP AND RP.RCD_CODITE = FATDOR.FDO_CODITE ');
  qryItensPedido.SQL.Add('			LEFT JOIN PCMDET PD ON PD.AUTOINCREM = IFNULL(RC.RCD_SEQPCD, RP.RCD_SEQPCD)                                                                                                ');
  qryItensPedido.SQL.Add('			LEFT JOIN BAIREQ BQ ON BQ.BAI_AUTREQ = IFNULL(RC.AUTOINCREM, RP.AUTOINCREM)                                                                                                ');
  qryItensPedido.SQL.Add('      LEFT JOIN PREPTE PT ON AB.ABS_SEQPTE = PT.AUTOINCREM                                                                                                                       ');
  qryItensPedido.SQL.Add('      LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE                                                                                                                            ');
  qryItensPedido.SQL.Add('      LEFT JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR                                                                                                                          ');
  qryItensPedido.SQL.Add('		WHERE                                                                                                                                                                        ');
  qryItensPedido.SQL.Add('			    FDO_NUMDOC = :NUMDOC                                                                                                                                                   ');
  qryItensPedido.SQL.Add('			AND FDO_ESPDOC = :ESPDOC                                                                                                                                                   ');
  qryItensPedido.SQL.Add('			AND FDO_CODEMP = :CODEMP                                                                                                                                                   ');
  qryItensPedido.SQL.Add('		GROUP BY                                                                                                                                                                     ');
  qryItensPedido.SQL.Add('			FDO_CODITE,                                                                                                                                                                ');
  qryItensPedido.SQL.Add('			FDO_NUMFAT,                                                                                                                                                                ');
  qryItensPedido.SQL.Add('			FDO_TIPFAT,                                                                                                                                                                ');
  qryItensPedido.SQL.Add('			FDO_EMPFAT,                                                                                                                                                                ');
  qryItensPedido.SQL.Add('			FDO_SEQIND                                                                                                                                                                 ');
  qryItensPedido.SQL.Add(') AS F                                                                                                                                                                           ');
  qryItensPedido.SQL.Add('	LEFT JOIN (SELECT                                                                                                                                                              ');
  qryItensPedido.SQL.Add('	             AUTOINCREM,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_CODITE,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_NUMDOC,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_ESPDOC,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_CODEMP,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_NUM_PD,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_ESP_PD,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_EMP_PD,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_IND_PD,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_NITCMP,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             DET_NUMLOT,                                                                                                                                                       ');
  qryItensPedido.SQL.Add('	             SUM(DET_QTDITE) AS DET_QTDITE                                                                                                                                     ');
  qryItensPedido.SQL.Add('						FROM MOVDET                                                                                                                                                          ');
  qryItensPedido.SQL.Add('							LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM                                                                                                          ');
  qryItensPedido.SQL.Add('						WHERE                                                                                                                                                                ');
  qryItensPedido.SQL.Add('							    DET_NUM_PD = :NUMDOC                                                                                                                                           ');
  qryItensPedido.SQL.Add('							AND DET_ESP_PD = :ESPDOC                                                                                                                                           ');
  qryItensPedido.SQL.Add('							AND DET_EMP_PD = :CODEMP                                                                                                                                           ');
  qryItensPedido.SQL.Add('						GROUP BY                                                                                                                                                             ');
  qryItensPedido.SQL.Add('							DET_CODITE,                                                                                                                                                        ');
  qryItensPedido.SQL.Add('							DET_NUMDOC,                                                                                                                                                        ');
  qryItensPedido.SQL.Add('							DET_ESPDOC,                                                                                                                                                        ');
  qryItensPedido.SQL.Add('							DET_CODEMP,                                                                                                                                                        ');
  qryItensPedido.SQL.Add('							DET_IND_PD) AS ORI ON ORI.DET_CODITE = FDO_CODITE AND ORI.DET_NUM_PD = FDO_NUMDOC AND ORI.DET_ESP_PD = FDO_ESPDOC                                                  ');
  qryItensPedido.SQL.Add('                             AND ORI.DET_EMP_PD = FDO_CODEMP AND ORI.DET_ESPDOC <> "PR" AND ORI.DET_NITCMP = IFNULL(FDO_NITCMP,0) AND ORI.DET_IND_PD = FDO_SEQIND                ');
  qryItensPedido.SQL.Add('	LEFT JOIN MOVDET BAI ON FDO_CODITE = BAI.DET_CODITE AND RIGHT(BAI.DET_CLAFIS, 3) <> "999" AND ORI.DET_NUMDOC = BAI.DET_DOCFUT                                                  ');
  qryItensPedido.SQL.Add('											AND ORI.DET_ESPDOC = BAI.DET_ESPFUT AND ORI.DET_CODEMP = BAI.DET_EMPFUT                                                                                    ');
  qryItensPedido.SQL.Add('	LEFT JOIN ROMDETX ROPD ON ROPD.DET_CODITE = FDO_CODITE AND ROPD.DET_AUTINC = FDO_AUTINC AND ROPD.DET_NUMDOC = FDO_NUMDOC                                                       ');
  qryItensPedido.SQL.Add('												AND ROPD.DET_ESPDOC = FDO_ESPDOC AND ROPD.DET_CODEMP = FDO_CODEMP                                                                                        ');
  qryItensPedido.SQL.Add('	LEFT JOIN ROMDETX RORI ON RORI.DET_CODITE = FDO_CODITE AND RORI.DET_AUTINC = ORI.AUTOINCREM AND RORI.DET_NUMDOC = ORI.DET_NUMDOC                                               ');
  qryItensPedido.SQL.Add('												AND RORI.DET_ESPDOC = ORI.DET_ESPDOC AND RORI.DET_CODEMP = ORI.DET_CODEMP                                                                                ');
  qryItensPedido.SQL.Add('	LEFT JOIN ROMDETX RBAI ON RBAI.DET_CODITE = FDO_CODITE AND RBAI.DET_NUMDOC = BAI.DET_NUMDOC AND RBAI.DET_ESPDOC = BAI.DET_ESPDOC                                               ');
  qryItensPedido.SQL.Add('												AND RBAI.DET_CODEMP = BAI.DET_CODEMP                                                                                                                     ');
  qryItensPedido.SQL.Add('	LEFT JOIN ROMGERX RGER ON RGER.AUTOINCREM = IF(ROPD.DET_NUMROM IS NOT NULL,ROPD.DET_SEQGER,IF(RORI.DET_NUMROM IS NOT NULL,RORI.DET_SEQGER,RBAI.DET_SEQGER))                    ');
  qryItensPedido.SQL.Add('	LEFT JOIN CADMOT ON RGER.GER_CODMOT = MOT_CODMOT                                                                                                                               ');
  qryItensPedido.SQL.Add('	LEFT JOIN CADTRA ON RGER.GER_CODTRA = TRA_CODTRA                                                                                                                               ');
  qryItensPedido.SQL.Add('ORDER BY                                                                                                                                                                         ');
  qryItensPedido.SQL.Add('	CODITE                                                                                                                                                                         ');
end;

procedure TfrmConsultaPedidos.pPedidoEEmpresaInformadoCarregaPedido;
begin
  If fEmptyStr(edtNumPed.Text) Then
    Exit;

  If fEmptyStr(edtCodEmp.Text) Then
    Exit;

  btnAdicionar.Click;
end;

procedure TfrmConsultaPedidos.pSetaParametrosConsulta(AQuery: TUniQuery);
begin
  With AQuery Do
  Begin
    If (FindParam('DTAINI') <> Nil) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If (FindParam('CODCLI') <> Nil) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If (FindParam('CODEMP') <> Nil) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If (FindParam('CODVEN') <> Nil) Then
    Begin
      if not blnLibVen then
        ParamByName('CODVEN').AsString := fRetCodVendedor(edtCodVen.Text)
      else
        ParamByName('CODVEN').AsString := edtCodVen.Text;
    End;

    pSetaParam(edtCodDep.Text, arrLinDep, strLinDep, 'CODDEP', AQuery);
    pSetaParam(edtCodRed.Text, arrLinRed, strLinRed, 'CODRED', AQuery);
    pSetaParam(edtCodProduto.Text, arrProdutos, strProdutos, 'CODITE', AQuery);

    If (Not fEmptyStr(edtPedCom.Text)) Then
      ParamByName('NUMCMP').AsString := '%' + edtPedCom.Text + '%';
  End;
end;

procedure TfrmConsultaPedidos.pSetarControles(blnEnabled: Boolean);
begin
  If (Not blnEnabled) Then
  Begin
    edtCodRed.Clear;
    edtNomRed.Text := 'TODAS';
    edtCodCli.Clear;
    edtNomCli.Clear;
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    cmbEntRet.ItemIndex := 0;
    edtCodDep.Clear;
    edtDesDep.Text := 'TODOS';

    If (blnLibVen) Then
    Begin
      edtCodVen.Clear;
      edtNomVen.Clear;
    End;

    pDesmarcaLista(edtCodDep, arrLinDep);
    pDesmarcaLista(edtCodRed, arrLinRed);
    pDesmarcaLista(edtCodProduto, arrProdutos);
  End;
  edtCodRed.Enabled   := blnEnabled;
  edtCodCli.Enabled   := blnEnabled;
  cbbFaturado.Enabled := blnEnabled;
  rdgRomaneio.Enabled := blnEnabled;
  edtCodVen.Enabled := blnEnabled;
  mskDtaIni.Enabled := blnEnabled;
  mskDtaFin.Enabled := blnEnabled;
  cmbEntRet.Enabled := blnEnabled;
  edtCodDep.Enabled := blnEnabled;

  edtNumPed.Enabled := (fEmptyStr(edtPedCom.Text)) And (fEmptyStr(edtDocFat.Text)) And (fEmptyStr(edtDocBxEntFut.Text));
  edtPedCom.Enabled := (fEmptyStr(edtNumPed.Text)) And (fEmptyStr(edtDocFat.Text)) And (fEmptyStr(edtDocBxEntFut.Text));
  edtDocFat.Enabled := (fEmptyStr(edtPedCom.Text)) And (fEmptyStr(edtNumPed.Text)) And (fEmptyStr(edtDocBxEntFut.Text));
  edtEspFat.Enabled := edtDocFat.Enabled;
  edtEmpFat.Enabled := edtDocFat.Enabled;

  If Not edtNumPed.Enabled Then
    edtNumPed.Clear;
  If Not edtPedCom.Enabled Then
    edtPedCom.Clear;
  If Not edtDocFat.Enabled Then
    edtDocFat.Clear;

  If blnFiltrosBaixaEntregaFutura Then
  Begin
    edtDocBxEntFut.Enabled := (fEmptyStr(edtPedCom.Text)) And (fEmptyStr(edtNumPed.Text)) And (fEmptyStr(edtDocFat.Text));
    edtEspBxEntFut.Enabled := edtDocBxEntFut.Enabled;
    edtEmpBxEntFut.Enabled := edtDocBxEntFut.Enabled;

    If Not edtDocBxEntFut.Enabled Then
      edtDocBxEntFut.Clear;
  End;

  If (Not blnLibVen) Then
    edtCodVen.Enabled := True;
end;

procedure TfrmConsultaPedidos.pVerdeVermelho(edtCodVen: TEditFocus;
  shaVen: TShape; blnLiberado: Boolean);
begin
  If (Not blnLibVen) Then
  Begin
    edtCodVen.MaxLength := 10;
    edtCodVen.TamCampo  := 10;
    edtCodVen.CompZeros := False;
    edtCodVen.PasswordChar := '*';
    edtCodVen.TipoTexto := ttAlfanumerico;
    shaVen.Brush.Color  := clRed;
  End
  Else
    shaVen.Brush.Color  := clGreen;
end;

procedure TfrmConsultaPedidos.tmrProdutosTimer(Sender: TObject);
begin
  inherited;
  tmrProdutos.Enabled := False;

  If (Not blnCarregouPedidos) Then
    Exit;

  TfrmGravando.fExecutarModal(pCarregaProdutos, 'Aguarde, Carregando produtos do pedido...', '');
end;

procedure TfrmConsultaPedidos.pAcionaTimerProdutos;
begin
  PostMessage(Application.Handle, WM_MESSAGENAVEGANDOGRIDCONSULTA, 0, 0);

  If (Not Self.Showing) Then
    Exit;

  Try
    tmrProdutos.Enabled := False;
    tmrProdutos.Enabled := True;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ': ' + SysErrorMessage(GetLastError));
  End;
end;

procedure TfrmConsultaPedidos.pLimpaNavegacaoProdutos;
begin
  tmrProdutos.Enabled := False;

  If (qryItensPedido.RecordCount > 0) Then
    cdsItensPedido.EmptyDataSet;

  Application.ProcessMessages;
end;

function TfrmConsultaPedidos.fSqlConsulta(blnVazio: Boolean; strFgoAutoIncrem: String = ''): String;
  Var
    strSQL: String;
    strFiltros: String;

    Function fRetSQLNeg: String;
    Begin
      Result := '';
      Result := Result + ' SELECT COUNT(AUTOINCREM) AS QTD ';
      Result := Result + '  FROM NEGPED ';
      Result := Result + ' WHERE NPD_NUMDOC = FGO_NUMDOC ';
      Result := Result + '   AND NPD_CODCLI = FGO_CODCLI ';
      Result := Result + '   AND NPD_CODEMP = FGO_CODEMP ';
      Result := Result + ' LIMIT 1 ';
    End;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';

  strSQL := strSQL + '  FATGOR.AUTOINCREM AS AUTOIN, ';

  strSQL := strSQL + '  FGO_JAFATU AS JAFATU, ';
  strSQL := strSQL + '  FGO_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMPED, ';
  strSQL := strSQL + '  FGO_EMPEXP AS EMPEXP, ';
  strSQL := strSQL + '  FGO_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  FGO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  FGO_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  FGO_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  FGO_HORENT AS HORENT, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '  CLI_FANSOB AS NOMFAN, ';
  strSQL := strSQL + '  FGO_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  FGO_TIPFAT AS TIPFAT, ';

  strSQL := strSQL + '  IF(FGO_LIBERA > 0,                       "PEDIDO LIBERADO", ';
  strSQL := strSQL + '  IF(FGO_ENVLIB = "S",                     "PEDIDO EM ANALISE", ';
  strSQL := strSQL + '  IF(IFNULL((' + fRetSQLNeg + '), 0) <> 0, "LIBERACAO NEGADA", ';
  strSQL := strSQL + '                                           "PEDIDO NAO ENVIADO PARA LIBERACAO"))) AS SITPED, ';

  strSQL := strSQL + '  TPA_DESCRI AS TIPATE, ';

  strSQL := strSQL + '  IF(FGO_SEPIMP = "0" OR FGO_SEPIMP IS NULL, "NÃO", "SIM") AS SEPIMP, ';

  strSQL := strSQL + '  CAST("" AS CHAR(20)) AS ORIPED, ';

  strSQL := strSQL + '  CAST("" AS CHAR(3) ) AS EMPORI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(12)) AS NUMORI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(2) ) AS ESPORI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(8) ) AS CLIORI, ';
  strSQL := strSQL + '  CAST(NULL AS TIME)   AS HRAFAT, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS EMIFAT, ';

  strSQL := strSQL + '  CAST("" AS CHAR(3) ) AS EMPBAI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(12)) AS NUMBAI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(2) ) AS ESPBAI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(8) ) AS CLIBAI, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS EMIBAI, ';

  strSQL := strSQL + '  CAST("" AS CHAR(3) ) AS EMPCONF, ';
  strSQL := strSQL + '  CAST("" AS CHAR(2) ) AS ESPCONF, ';
  strSQL := strSQL + '  CAST("" AS CHAR(12)) AS NUMCONF, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS EMICONF, ';

  strSQL := strSQL + fGetSQLNumCmp() + '  AS NUMCMP, ';

  strSQL := strSQL + '  FGO_HRBXSE           AS HORSEP, ';
  strSQL := strSQL + '  FGO_HRLBEX           AS HOREXP, ';
  strSQL := strSQL + '  CAST("" AS CHAR(6))  AS NUMROM, ';
  strSQL := strSQL + '  CAST("" AS CHAR(20))  AS ROM_AUTINC, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS DTAROM, ';
  strSQL := strSQL + '  CAST(NULL AS TIME)   AS HORROM, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS DTAINI, ';
  strSQL := strSQL + '  CAST(NULL AS TIME)   AS HORINI, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS DTACHE, ';
  strSQL := strSQL + '  CAST(NULL AS TIME)   AS HORCHE, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)   AS DTAROB, ';
  strSQL := strSQL + '  CAST(NULL AS TIME)   AS HORROB, ';
  strSQL := strSQL + '  CAST("" AS CHAR(20)) AS ESPERA, ';
  strSQL := strSQL + '  CAST("" AS CHAR(15)) AS MTRROM, ';
  strSQL := strSQL + '  CAST("" AS CHAR(40)) AS NOMTRA, ';
  strSQL := strSQL + '  FGO_HORLIC           AS HORLIC, ';
  strSQL := strSQL + '  LAL_SITUAC           AS SITUAC,  ';
  strSQL := strSQL + '  IFNULL(LAL_NOMMOT, "") AS LAL_NOMMOT,  ';
  strSQL := strSQL + '  IFNULL(LAL_PLAVEI, "") AS LAL_PLAVEI,  ';
  strSQL := strSQL + '  IFNULL(LAL_URLPOD, "") AS LAL_URLPOD,  ';

  strSQL := strSQL + '  IF(FGO_LIBCOM > 0, "Liberado", "Não Liberado") AS FGO_LIBCOM, ';
  strSQL := strSQL + '  IF(FGO_LIBERA > 0, "Liberado", "Não Liberado") AS FGO_LIBERA, ';
  strSQL := strSQL + '  IFNULL(STA_DESCRI, "") AS STATUS, ';
  strSQL := strSQL + '(SELECT GROUP_CONCAT(IF(IFNULL(PCD_NUMPED, "") = "", "",     ';
  strSQL := strSQL + '                        CONCAT(PCD_NUMPED,"-",PCD_ESPDOC,"-",';
  strSQL := strSQL + '                               PCD_CODEMP))) AS NUMPED       ';
  strSQL := strSQL + '   FROM PCMDET PC                                            ';
  strSQL := strSQL + '   JOIN MOVRCD RD ON RD.RCD_SEQPCD = PC.AUTOINCREM           ';
  strSQL := strSQL + '  WHERE RCD_DOCPDV = FGO_NUMDOC                              ';
  strSQL := strSQL + '    AND RCD_ESPPDV = FGO_ESPDOC                              ';
  strSQL := strSQL + '    AND RCD_EMPPDV = FGO_CODEMP                  ) AS PEDCOM,';
  strSQL := strSQL + '(SELECT PC.PCD_DTAENT                                        ';
  strSQL := strSQL + '    FROM PCMDET PC                                           ';
  strSQL := strSQL + '    JOIN MOVRCD RD ON RD.RCD_SEQPCD = PC.AUTOINCREM          ';
  strSQL := strSQL + '    WHERE RCD_DOCPDV = FGO_NUMDOC                            ';
  strSQL := strSQL + '    AND RCD_ESPPDV = FGO_ESPDOC                              ';
  strSQL := strSQL + '    AND RCD_EMPPDV = FGO_CODEMP                              ';
  strSQL := strSQL + '    AND PC.PCD_DTAENT IS NOT NULL LIMIT 1 ) AS DTENTR,       ';
  strSQL := strSQL + 'IF(IFNULL(FGO_HISBAI,"")<>"",FGO_HISBAI,"")       AS HISBAI, ';
  strSQL := strSQL + 'IF(IFNULL(FGO_MOTBAI,"")<>"","SIM","")            AS PBNENT, ';
  strSQL := strSQL + 'FGO_DTALIC           AS DTALIC, ';
  strSQL := strSQL + 'FGO_DTALIB           AS DTALIB, ';
  strSQL := strSQL + 'FGO_HORLIB           AS HORLIB, ';

  strSQL := strSQL + '  CAST(NULL AS DATETIME)   AS DTASAI,       ';
  strSQL := strSQL + '  CAST(NULL AS DATETIME)   AS DTACHG,       ';
  strSQL := strSQL + '  CAST("" AS CHAR(60)) AS MOTORA        ';

  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  FATGOR      ';
  strSQL := strSQL + '  INNER JOIN CADCLI ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI ';

  If Not fEmptyStr(edtCodProduto.Text) Then
    strSQL := strSQL + '  INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';

  strSQL := strSQL + '   LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '   LEFT JOIN CADTPA ON CADTPA.TPA_CODIGO = EXTGOR.FGO_CODTPA ';
  strSQL := strSQL + '   LEFT JOIN CADOPE ON FATGOR.FGO_CODVEN = CADOPE.OPE_CODOPE ';
  strSQL := strSQL + '   LEFT JOIN FGOSTA S ON FGO_STATUS = STA_CODIGO ';
  strSQL := strSQL + '   LEFT JOIN MOVLAL ON (FGO_NUMDOC = LAL_NUMPED AND FGO_ESPDOC = LAL_ESPPED AND FGO_CODEMP = LAL_EMPPED) ';

  strSQL := strSQL + 'WHERE ';

  If blnVazio Then
  Begin
    strSQL := strSQL + ' FALSE';
  End
  Else If (fCarregarDadosMostraDebCtrChq2) Then
  Begin
    If fEmptyStr(strFgoAutoIncrem) Then
      strFgoAutoIncrem := fIdentificaPedidosVinculados;

    If (Not fEmptyStr(strFgoAutoIncrem)) Then
      strSQL := strSQL + ' FATGOR.AUTOINCREM IN ('+strFgoAutoIncrem+') '
    Else
      strSQL := strSQL + ' FALSE';
  End
  Else If (fCarregarDadosInfCobranca) Then
  Begin
    If fEmptyStr(strFgoAutoIncrem) Then
      strFgoAutoIncrem := fIdentificaPedidosVinculados;

    If (Not fEmptyStr(strFgoAutoIncrem)) Then
      strSQL := strSQL + ' FATGOR.AUTOINCREM IN ('+strFgoAutoIncrem+') '
    Else
      strSQL := strSQL + ' FALSE';
  End
  Else
  Begin
    If fEmptyStr(strFgoAutoIncrem) Then
      strFgoAutoIncrem := fIdentificaPedidosVinculados;

    If (Not fEmptyStr(strFgoAutoIncrem)) Then
      strFiltros := strFiltros + '  AND FATGOR.AUTOINCREM IN ('+strFgoAutoIncrem+') ';

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      strFiltros := strFiltros + '  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If (Not fEmptyStr(edtCodCli.Text)) Then
      strFiltros := strFiltros + '  AND FGO_CODCLI = :CODCLI ';

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      strFiltros := strFiltros + '  AND FGO_CODEMP = :CODEMP ';

    If (Not fEmptyStr(edtCodVen.Text)) Then
      strFiltros := strFiltros + '  AND FGO_CODVEN = :CODVEN ';

    If (cmbEntRet.ItemIndex > 0) Then
      strFiltros := strFiltros + '  AND FGO_ENTFAT = '+QuotedStr(IIF(cmbEntRet.ItemIndex=1,'S','N'));

    strFiltros := strFiltros + fStrLocate(edtCodDep, arrLinDep, 'OPE_CODDEP', 'CODDEP');
    strFiltros := strFiltros + fStrLocate(edtCodRed, arrLinRed, 'CLI_CODRED', 'CODRED');
    strFiltros := strFiltros + fStrLocate(edtCodProduto, arrProdutos, 'FDO_CODITE', 'CODITE');

    strFiltros := strFiltros + ' AND EXTGOR.FGO_LOC_PD <> "S" ';

    Case cbbFaturado.ItemIndex Of
      1: strFiltros := strFiltros + '  AND FGO_JAFATU = 0 ';
      2: strFiltros := strFiltros + '  AND (FGO_JAFATU = 1 AND IFNULL( FGO_MOTBAI, "" ) = "") ';
      3: strFiltros := strFiltros + '  AND (FGO_JAFATU = 1 AND IFNULL( FGO_MOTBAI, "" ) <> "") ';
    End;

    If rdgRomaneio.Visible Then
    Begin
      Case rdgRomaneio.ItemIndex Of
        1: strFiltros := strFiltros + '  AND IFNULL(FGO_NUMROM,"") <> "" ';
        2: strFiltros := strFiltros + '  AND IFNULL(FGO_NUMROM,"") = "" ';
      End;
    End;

    if not fEmptyStr(edtPedSite.text) then
      strFiltros := strFiltros + ' AND FGO_NUMPOK = '+QuotedStr(edtPedSite.text);

    If (Not fEmptyStr(strFiltros)) Then
      strSQL := strSQL + '  FGO_ESPDOC NOT IN ("PR", "OR") ' + strFiltros
    Else If (Not fEmptyStr(edtPedCom.Text)) Then
      strSQL := strSQL + ' TRUE '
    Else
      strSQL := strSQL + ' FALSE ';

    If (Not fEmptyStr(edtPedCom.Text)) Then
      strSQL := strSQL + '  HAVING (NUMCMP LIKE :NUMCMP) ';
  End;

  Result := strSQL;
End;

function TfrmConsultaPedidos.fMotoristaPlacaLalaMove(const ARecord: TcxCustomGridRecord) : String;
var
  strNom, strPla: String;
begin
  Result := '';
  strNom := VarToStr(ARecord.Values[cxgConsultaViewLAL_NOMMOT.Index]);
  strPla := VarToStr(ARecord.Values[cxgConsultaViewLAL_PLAVEI.Index]);
  if not fEmptyStr(strNom) then
    Result := 'Motorista: ' + strNom;
  if not fEmptyStr(strPla) then
  begin
    if not fEmptyStr(Result) then
      Result := Result + ' - ';
    Result := Result + 'Placa: ' + strPla;
  end;
end;

procedure TfrmConsultaPedidos.pExibirFotoPODLalamove;
var
  strURL      : string;
  objHttp     : TNetHTTPClient;
  objStream   : TMemoryStream;
  objPng      : TPngImage;
  objResponse : IHTTPResponse;
  blnAbrirNoNavegador: Boolean;
begin
  if cdsConsul.IsEmpty then
    Exit;
  strURL := cdsConsul.FieldByName('LAL_URLPOD').AsString;
  if fEmptyStr(strURL) then
  begin
    fMensagem('ATENÇÃO!', 'Este pedido não possui foto de comprovante de entrega.', ['&Ok']);
    Exit;
  end;

  blnAbrirNoNavegador := False;
  objHttp   := TNetHTTPClient.Create(nil);
  objStream := TMemoryStream.Create;
  objPng    := TPngImage.Create;
  try
    // 1) Rede: erro aqui é erro de verdade -> log
    try
      objResponse := objHttp.Get(strURL, objStream);
    except
      on E: Exception do
      begin
        pGravarErro(True, E.Message, E.StackTrace);
        blnAbrirNoNavegador := True;
      end;
    end;

    if (not blnAbrirNoNavegador) and (objResponse.StatusCode <> 200) then
      blnAbrirNoNavegador := True;

    // 2) Decodificação: erro de formato (JPG, etc.) é fluxo esperado -> sem log
    if not blnAbrirNoNavegador then
    begin
      try
        objStream.Position := 0;
        objPng.LoadFromStream(objStream);
        if objPng.Empty then
          blnAbrirNoNavegador := True
        else
          pExibirImagem(objPng);
      except
        on EInvalidGraphic do
          blnAbrirNoNavegador := True;   // POD em JPG/outro formato
        // demais exceções aqui são genuinamente inesperadas:
        on E: Exception do
        begin
          pGravarErro(True, E.Message, E.StackTrace);
          blnAbrirNoNavegador := True;
        end;
      end;
    end;

    if blnAbrirNoNavegador then
      ShellExecute(0, 'open', PChar(strURL), nil, nil, SW_SHOWNORMAL);
  finally
    FreeAndNil(objHttp);
    FreeAndNil(objStream);
    FreeAndNil(objPng);
  end;
end;

procedure TfrmConsultaPedidos.pExibirImagem(const objPngImage : TPngImage);
  Var
    frmImagem: TfrmImagem;
begin
  pCriarFormularios(TfrmImagem, frmImagem);
  try
    frmImagem.imgFoto.Visible := True;
    frmImagem.imgFoto.Picture.Assign(objPngImage);
    frmImagem.btnTamFig.Visible := True;
    frmImagem.lbl1.Visible := True;
    frmImagem.Caption := 'Comprovante de Entrega - LalaMove';
    frmImagem.ShowModal;
  finally
    pFreeAndNil(frmImagem);
  end;
end;

end.
