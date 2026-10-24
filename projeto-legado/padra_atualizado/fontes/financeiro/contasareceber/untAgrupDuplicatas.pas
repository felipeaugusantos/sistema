{***************************}
{* qryConCli -> CADCLI     *}
{* qryConEmp -> CADEMP     *}
{************************JB*}

{***************************}
{* qryConPor -> CADPOR     *}
{************************RV*}

{***************************}
{* qryConVen -> CADOPE     *}
{************************RV*}



unit untAgrupDuplicatas;

interface

uses
  Windows, Types, Classes, Controls, Forms, StdCtrls, untPaiSimples, Grids,
  DBGridCitel, DBGrids, Mask, untFuncoesSimples, Uni, MaskEditFocus, EditFocus, ComCtrls,
  Buttons, ExtCtrls, DB, Menus, AppEvnts, MemoFocus, UniClientDataSet,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  TypesRel, untFuncoesEtiquetas, untImpBoletoIndiv,cxControls, cxContainer, cxEdit,
  cxProgressBar, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxCore,  untFuncoes,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untAltDtaVenc, untParcelamento,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, untTLock, cxCheckBox, untLiberacao,
  untMsgLiberacao, untTLogLibRec, System.Generics.Collections, untPgtOnlineUtil,
  untPgtOnlineApi;

type
  TfrmAgrupDuplicatas = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    edtNomCli: TEditFocus;
    Panel1: TPanel;
    Label4: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    shpMultSel: TShape;
    btnConfirma: TBitBtnLocked;
    btnSairAgrup: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnRegraAgrup: TBitBtnLocked;
    GbpEmpresa: TGroupBox;
    edtCodEmp: TEditFocus;
    rdbOrigem: TRadioButton;
    rdbFatu: TRadioButton;
    edtNomEmp: TEditFocus;
    btnObsCli: TBitBtnLocked;
    btnContaCorrente: TBitBtnLocked;
    Label15: TLabel;
    edtNomVen: TEditFocus;
    edtCodven: TEditFocus;
    chkLimFil: TCheckBox;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    edtNomPorBai: TEditFocus;
    edtCodPorBai: TEditFocus;
    edtNosNum: TEditFocus;
    edtHistor: TMemoFocus;
    grdDuplicatas: TcxGrid;
    grdDuplicatasDBTableView1: TcxGridDBTableView;
    grdDuplicatasDBTableView1DBColumn1: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_NUMDUP: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_ESPDOC: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_NOMCLI: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_FANSOB: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_NOMPOR: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_CODEMP: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_DTACAD: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_DTAVEN: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_TIPFOR: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_VALDUP: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_JURATR: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_VALCOR: TcxGridDBColumn;
    grdDuplicatasDBTableView1CTR_MARDES: TcxGridDBColumn;
    grdDuplicatasLevel1: TcxGridLevel;
    grdDuplicatasDBTableView1CTR_CODCND: TcxGridDBColumn;
    FlwPnlBotoesBaixa: TFlowPanel;
    grdDuplicatasDBTableView1CTR_CODCLI: TcxGridDBColumn;
    btnHistDocumentos: TBitBtnLocked;
    pnlCabecalho2: TPanel;
    lblPeriodo: TLabel;
    lblPeriodoa: TLabel;
    lblCndPag: TLabel;
    rdbDtaCad: TRadioButton;
    rdbDtaVen: TRadioButton;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnCarrTitulos: TBitBtnLocked;
    edtDesCnd: TEditFocus;
    edtCodCnd: TEditFocus;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtDesPrj: TEditFocus;
    edtCodPrj: TEditFocus;
    chkEnviarEmail: TCheckBox;
    pnlInfoVenda: TPanel;
    gbEndEntrega: TGroupBox;
    Label57: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label149: TLabel;
    edtEndEnt: TEditFocus;
    edtCidEnt: TEditFocus;
    edtCepEnt: TEditFocus;
    edtBaiEnt: TEditFocus;
    edtRefEnt: TEditFocus;
    edtEstado: TEditFocus;
    edtNomCid: TEditFocus;
    gbNota: TGroupBox;
    lblMsg001: TLabel;
    lblmsg002: TLabel;
    edtMsg001: TEditFocus;
    edtMsg002: TEditFocus;
    btnRecalculaJuros: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairAgrupClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRegraAgrupClick(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure btnObsCliClick(Sender: TObject);
    procedure btnContaCorrenteClick(Sender: TObject);
    procedure edtCodvenKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure grdDuplicatasDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdDuplicatasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDuplicatasDBTableView1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHistDocumentosClick(Sender: TObject);
    procedure edtCodPrjExit(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodvenExit(Sender: TObject);
    procedure grdDuplicatasDBTableView1ColumnSizeChanged(
      Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure btnRecalculaJurosClick(Sender: TObject);

  private
    { Private declarations }
    arrDuplicata: TarrDuplicata;
    arrDupAgr: Array Of TDuplicatasAgrupadas;
    stlLisSel: TStringList;

    FCodBco    : String;
    FValMor    : Double;
    FCodPor    : String;
    FNosNum    : String;
    FAgrVen    : String;
    FCenCus    : String;
    blnUsaTelaCnd: Boolean;
    arrCndPag  : TConsultasArray;
    arrEmpresa : TConsultasArray;
    arrClientes: TConsultasArray;
    arrPortador: TConsultasArray;
    arrPrj     : TConsultasArray;
    arrVen     : TConsultasArray;
    qryGenRec: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    qryConPor: TUniQuery;
    qryConVen: TUniQuery;
    cdsCtaRec: TUniClientDataSet;
    dtsCtaRec: TDataSource;
    stlAutIncDupMar: TStringList;

    strNumAgr      : String;
    strEmpresa     : String;
    strPortador    : String;
    strClientes    : String;
    strRegSel      : String;
    strCodCnd      : String;
    intEtiQtd,
    intTotalMarcado: Integer;

    blnFecharForm: Boolean;
    blnShowMenu : Boolean;
    blnMarcar: Boolean;
    blnDescontoAteVencimento: Boolean;

    arrDuplicAgr: TArrDigDuplicArray;
    arrDuplicIPI: TArrDigDuplicArray;
    arrDuplicRet: TArrDigDuplicArray;
    arrDuplicAce: TArrDigDuplicArray;
    arrDuplicFre: TArrDigDuplicArray;
    arrDuplicCbs: TArrDigDuplicArray;
    arrDuplicIbs: TArrDigDuplicArray;
    arrDuplicIs : TArrDigDuplicArray;

    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;
    intColAtu: Integer;
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;
    cpuCampos: TCamposUso;
    blnEndCob: Boolean;
    acaoMarca: String;
    intQtdDupMarcada : Integer;
    fltTotalAgrup: Double;
    blnGravou: Boolean;

    strEmpCod: String;

    arrDupDocs: TArrDigDuplicArray;
    objLock   : TLock;
    objLogLibRec : TLogLibRec;
    FAgrupContaReceber: Boolean;

    FParcelasAcerto: Boolean;

    FPercJurosAplicado : Double;
    FDicBaixa  : TDictionary <String,Variant>;

    function fExisteDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
    procedure RecalculaJuros;
    procedure CalculaJuros(APerJur, APerMul: Double; AAplJur: String);
    function LiberaRecalculoJuros(APerJur: Double; APerMul: Double; AAplJur: String; AConfirma: Boolean): Boolean;

    function fGeraLinkPagamento(const AstrLinkPgtFormaEnvio, AstrLinkPgtDestinatario: String): Boolean ;

    Const NFF: String = 'NF_IF_NS_NV_IV_EL_EV_AG_';

    procedure pLimpaGrid;
    function RotinaAgrupaCreditos:Boolean;
    procedure pLimpaDados(blnLimFil: Boolean);
    procedure pSelecionaDuplicata;
    function fMarcaDuplicata(blnMarcar: Boolean): Boolean;
    procedure pSelecionaDataVencimento;

    procedure pAgruparDuplicatas;
    function  fControleTrava: Boolean;
    function  fListaAutoincremClientes: TStringList;
    procedure pImpEtiquetasMatricial;
    procedure pImpArrLinhasEti;
    function  fRetornaSQLCli: String;
    procedure pAtualizaCamposUso(qryImpEti: TUniQuery);
    procedure pAtualizaDtaVenc(dtaDtaVen: TDateTime);
    procedure pImpRegistro(qryImpEti: TUniQuery);
    procedure pLiberaDupsMarcadas;
    function fVerificaParcelasMarcadas: Boolean;

    {*****************************************}
    {* PROCEDURES ATRIBUIDAS AOS EVENTOS DA  *}
    {* qryTemporaria                         *}
    {**************************************MV*}
    procedure pAtualizaDados(DataSet: TDataSet);

    function fDeletaDuplicatas(arrDupSel: Array Of TDuplicataCtr): Boolean;
    function fGravaAgrupamentos( strCodCli, strCodEmp: String; dtaDtaAgr: TDateTime; strConPag: String): Boolean;

//    function fDocumentosBaixados(strCodCli: String): Boolean; overload;
    function fDocumentosBaixados: Boolean; overload;
    function fVerificarCadRecBaixado(strNumDoc, strEspDoc, strCliFor, strCodEmp, strParcel, strSeqBai: String; lstDoc: TStringList): Boolean;
    procedure pGeraResumo(lstCtrBaixadas: TStringList);

    procedure pCarregaCliente;
    function fVerificaExiste: Boolean; overload;
//    function fVerificaExiste(strCodCli: String): Boolean; overload;
    function fChamaDesconto(strCodCli, strCodEmp, strNomCli: String; fltTotCli: Double):Boolean;
    procedure pRetornaTotal(strCodCli, strCodEmp: String; Var fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre: Double; strParcela: String = '');
    procedure pRetornaTotalReforma(const strCodCli, strCodEmp: String; Var fltTotCbs, fltTotIbs, fltTotIs: Double);
    function fAtualizaValoresTemporaria(strCodCli, strCodEmp, strTotCli, strValor: String; strAcrDes: String):Boolean;
    function fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
    function fCriaListaClientes: TStringList;
    function fCriaListaEmpresas: TStringList;
    function fVerificaDuplicatasClientes: Boolean;
    function fAplicaTaxaJurosAgrupamento(strCodCli, strCodEmp, strCodCnd, strConPag: String; fltTotAgr: Double): Boolean;
    procedure pCalculaValorCorrigido;
    function fNumeroDuplicatasAvulsa: String;
    function fAgrupandoNotasAvulsas: Boolean;
    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pFecharTelaAgrupandoNotasAvulsas;
    function fTemMovimento: Boolean;
    function fVerificaEspeciesMarcadas(Dataset: TUniClientDataset): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    function RetornaDataCadastroFinalPeriodo:TDateTime;
    function fPermiteFecharAgrupF11: Boolean;
    procedure pConfirmarAgrupamento;
    function fValidaValorAgrupamento(strNumAgr, strCodCli, strEmpAgr: String): Boolean;

    function RetornaVendedorDaDuplicataComMaiorValor(ADuplicatas: TUniClientDataSet): String;
    procedure pUtilizaRotinaProjeto;
    function fUtilizaCredEmpresa(): Boolean;
    function fRealizarAgrupamento: Boolean;
    function fLiberarAgrupDupCtr(ADuplicatas: TUniClientDataSet): Boolean;

    procedure CalculaValorCorrigidoAcertoDeContas;
    function fRetornaAutoIncAgrupado(const AintParc: Integer): TArrayAutoIncAgrupado;
    function fDocumentosComPendenciaCancelamento : Boolean;
  protected
    procedure pCriaTemporaria;
    procedure pCalculaTotalDuplicatas(edtValTot: TEditFocus; blnFiltrar: Boolean);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaVendedor;
  public
    { Public declarations }
    blnUsouValDupOriComDesmembramento: Boolean;
    strCondicaoNotaAvulsa: String;
    arrDocsAgrupar: Array Of TDocAgrupamento;
    strPortadorNotaAvulsa: String;
    blnF11: Boolean;
    blnFatVen: Boolean;
    blnAtivarTransacaoNaGravacaoAgrupamento: Boolean;
    objParcelamento: TParcelamento;
    FDuplicatasJagrupadas: String;
    AFormVeio: String;
    FSelTodas: Boolean; // Para realizar o agrupamento todas os titulos carregados no grid devem estar selecionados.

    taAgrupouF11: TTipoAgrupF11;
    arrDocumentos: TDocumentosArray;
    intCx: Integer;
    property AgrupContaReceber: Boolean read FAgrupContaReceber write FAgrupContaReceber default False;
  published
    {*****************************************}
    {* PROPRIEDADES QUE SERÃO USADAS PARA A  *}
    {* IMPRESSÃO DO BOLETO                   *}
    {**************************************MV*}
    property strCodBco: String read FCodBco write FCodBco;
    property fltValMor: Double read FValMor write FValMor;
    property strCodPor: String read FCodPor write FCodPor;
    property strNosNum: String read FNosNum write FNosNum;
    property strAgrVen: String read FAgrVen write FAgrVen;
    property strCenCus: String read FCenCus write FCenCus;

    property ParcelasAcerto: Boolean read FParcelasAcerto write FParcelasAcerto;
  end;


implementation

uses SysUtils, Variants, Graphics, strUtils, UniDataSetProvider,
  untPesqAux, untConsultas, untCancelamentoDocResumo, untFatMostraObsCliente,
  untCtrAgrupDupRecibo, untPai,untDigCndPagamento, untCadConfRelatorios,
  untDigPortador, untDigDesconto, untFuncoesConsulta, untCadRec,
  untCarnePagto, untDigQtdEti, untFuncMacro, untCfgRel, untFuncoesAuxiliares,
  untDuplicatas, untGravando, untCndPagRenegociacao, untBoleto,
  untConstantes, untRelCtrLogAcompDuplicNovo, untAtualizaOcorrenciasCRM,
  untTypesCRM, untTEnvioEmail, untMostraDebCtrChq2, untCtrRecalculoJuros,
  untLogCanAgrupamento, untDtoLogCan;

{$R *.dfm}

{ TfrmAgrupDuplicatas }

function TfrmAgrupDuplicatas.fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);
  With Result Do
  Begin
    Data := cdsCtaRec.Data;
    If Not fEmptyStr(strFiltro) Then
    Begin
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
    End;
  End;
End;

{**************************************}
{* CRIA UM STRING LIST COM OS CODIGOS *}
{* DOS CLIENTES SELEC. NAS DUPLICATAS *}
{***********************************AN*}
function TfrmAgrupDuplicatas.fCriaListaClientes: TStringList;
var
  cdsGen: TUniClientDataSet;
  strCliente: String;
Begin
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin
    DisableControls;
    IndexFieldNames := 'CTR_CODCLI';
    Result := TStringList.Create;
    Result.Clear;
    strCliente := '';
    First;

    While Not Eof Do
    Begin
      If Not SameText(strCliente, FieldByName('CTR_CODCLI').AsString) Then
      Begin
        strCliente := FieldByName('CTR_CODCLI').AsString;
        Result.Add(strCliente);
      End;

      Next;
    End;
    EnableControls;
  End;
  FreeAndNil(cdsGen);
End;

function TfrmAgrupDuplicatas.fCriaListaEmpresas: TStringList;
var
  cdsGen: TUniClientDataSet;
  strEmpresa: String;
Begin
  If (fCfgSis('AGRTPR', varInteger) = 3) Then
  Begin
    cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
    With cdsGen Do
    Begin
      DisableControls;
      IndexFieldNames := 'CTR_CODEMP';
      Result := TStringList.Create;
      Result.Clear;
      strEmpresa := '';
      First;

      While Not Eof Do
      Begin
        If Not SameText(strEmpresa, FieldByName('CTR_CODEMP').AsString) Then
        Begin
          strEmpresa := FieldByName('CTR_CODEMP').AsString;
          Result.Add(strEmpresa);
        End;

        Next;
      End;

      EnableControls;
    End;
    FreeAndNil(cdsGen);
  End
  Else
  Begin
    Result := TStringList.Create;
    Result.Clear;
    Result.Add(VS_strCodEmp);
  End;
end;

{*************************************************}
{* VERIFICA O VALOR DAS DUPLICATAS SELECIONADAS. *}
{* PELO MENOS UM CLIENTE DEVE TER DUPLICATAS COM *}
{* VALOR DIFERENTE DE ZERO PARA CONTIN A AGRUPAR *}
{**********************************************AN*}
function TfrmAgrupDuplicatas.fVerificaDuplicatasClientes: Boolean;
  Var
    cdsGen: TUniClientDataSet;
    fldVal: TAggregateField;
    strFiltro: String;
    intCont: Integer;
    stlClientes: TStringList;
begin
  Result := False;
  Try
    stlClientes := fCriaListaClientes;
    cdsGen := TUniClientDataSet.Create(Self);
    fldVal := fCriaAggregateField(cdsGen, 'FLDVAL', 'SUM(CTR_VALCOR)', '#,##0.00');
    strFiltro := 'CTR_MARDES = ' + QuotedStr('M') + ' AND CTR_CODCLI = ';

    With cdsGen Do
    Begin
      Data := cdsCtaRec.Data;

      For intCont := 0 To stlClientes.Count-1 Do
      Begin
        AggregatesActive := False;

        Filtered := False;
        Filter := strFiltro + QuotedStr(stlClientes[intCont]);
        Filtered := True;

        AggregatesActive := True;
        If (fldVal.Value <> Null) And (fldVal.Value <> 0) Then
        Begin
          Result := True;
          Break;
        End;
      End;
      Application.ProcessMessages;
    End;

    If Not Result Then
      fMensagem('', 'Nenhuma Duplicata foi selecionada ou Total dos Agrupamentos é igual a zero!', ['&OK']);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.fVerificaDuplicatasClientes]');
  End;

  FreeAndNil(stlClientes);
  FreeAndNil(cdsGen);
end;

function TfrmAgrupDuplicatas.fTemMovimento: Boolean;
  Var
    qryAux : TUniQuery;
    strSQL : String;

begin

  Result := False;

  qryAux := fCriaQuery(Nil);

  With cdsCtaRec Do
  Begin
    DisableControls;
    Filtered := False;
    Filter   := ' CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;
    First;

    strSQL := '';
    strSQL := strSQL + ' SELECT *                   ';
    strSQL := strSQL + '   FROM                     ';
    strSQL := strSQL + ' MOVGER                     ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   GER_NUMDOC = :NUMDOC     ';
    strSQL := strSQL + '   AND GER_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND GER_CODCLI = :CODCLI ';
    strSQL := strSQL + '   AND GER_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND GER_NUMFAT IS NOT NULL   ';
    strSQL := strSQL + '   AND GER_NUMFAT <> ""         ';
    strSQL := strSQL + '   AND GER_NUMFAT <> GER_NUMDOC ';
    strSQL := strSQL + '   AND GER_TIPFAT <> GER_ESPDOC ';
    strSQL := strSQL + '   AND GER_EMPFAT <> GER_CODEMP ';

    While Not Eof Do
    Begin
      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := cdsCtaRec.FieldByName('NRODUP').AsString;
        ParamByName('ESPDOC').AsString := cdsCtaRec.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODCLI').AsString := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;
        ParamByName('CODEMP').AsString := cdsCtaRec.FieldByName('CTR_CODEMP').AsString;
        Open;

        If RecordCount > 0 Then
        Begin
          Result := True;
          cdsCtaRec.EnableControls;
          Break;
        End;
      End;

      Next;
    End;

    Filtered := False;
    EnableControls;
  End;

  FreeAndNil(qryAux);
end;

function TfrmAgrupDuplicatas.fUtilizaCredEmpresa: Boolean;
  Var
    cdsDupSel: TUniClientDataSet;
    strAuxEmp: String;
begin
  Result := False;

  If Not fCfgSis('EMPORI', VarBoolean) Then
    Exit;

  cdsDupSel          := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsDupSel, cdsCtaRec);

  Try
    cdsDupSel.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    cdsDupSel.Filtered := True;
    cdsDupSel.IndexFieldNames := 'CTR_CODEMP';

    strEmpCod := '';
    strAuxEmp := '';
    While Not cdsDupSel.Eof Do
    Begin
      If ((cdsDupSel.FieldByName('CTR_ESPDOC').AsString = 'CC') Or (cdsDupSel.FieldByName('CTR_VALDUP').AsFloat < 0)) And
         (VS_strCodEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString) Then
      Begin
        Result := True;

        If strAuxEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString Then
        Begin
          strEmpCod := strEmpCod + cdsDupSel.FieldByName('CTR_CODEMP').AsString + ', ';
          strAuxEmp := cdsDupSel.FieldByName('CTR_CODEMP').AsString;
        End;
      End;

      cdsDupSel.Next;
    End;

    strEmpCod := Copy(strEmpCod, 1, Length(strEmpCod) - 2); // Para remover a vírgula adicional do final

  Finally
    FreeAndNil(cdsDupSel);
  End;
end;

function TfrmAgrupDuplicatas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
        edtNomEmp.Text := 'TODOS'
      Else
        pDesmarcaLista(edtCodEmp, arrEmpresa, 'TMP_EMPRESA');

      If ((Not fEmptyStr(edtCodEmp.Text)) Or (High(arrEmpresa) >= 0)) And fCfgSis('EMPAGR', varBoolean) Then
      Begin
        If (High(arrEmpresa) >= 0 ) Then
        Begin
          For intIndex := 0 To High(arrEmpresa) Do
          Begin
            If Pos(arrEmpresa[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso a empresa + ' + arrEmpresa[intIndex].strCodigo + '!', ['&Ok']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;

    End
    {*****************************************}
    {* VALIDA O CÓDIGO DO VENDEDOR           *}
    {**************************************MV*}
    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
        edtNomVen.Text := 'TODOS'
      Else
      Begin
        pCarregaVendedor;
        If qryConVen.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodPrj) And pnlProjeto.Visible  Then
    Begin
      If Not fEmptyStr(edtCodPrj.Text) Then
      Begin
        If (edtCodPrj.Text <> '000000') Then
          edtDesPrj.Text := fRetNomeProjeto(edtCodPrj.Text);

        If fEmptyStr(edtDesPrj.Text) Then
        Begin
          fMensagem('', 'Projeto não encontrado !', ['&Ok']);
          Result := False;
          edtDesPrj.Clear;
        End;
      End
      Else
        edtDesPrj.Text := 'TODOS';
    End
    Else If (Sender = edtCodCnd) And pnlCabecalho2.Visible  Then
    Begin
      If Not fEmptyStr(edtCodCnd.Text) Then
      Begin
        If (edtCodCnd.Text <> '000') Then
          edtDesCnd.Text := fRetDesConPag(edtCodCnd.Text);

        If fEmptyStr(edtDesCnd.Text) Then
        Begin
          fMensagem('', 'Condição de Pagamento não encontrada!', ['&Ok']);
          Result := False;
          edtDesCnd.Clear;
        End;
      End
      Else
        edtDesCnd.Text := 'TODOS';
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pDesmarcaLista(edtCodCli, arrClientes, 'TMP_CLIENTE');

        If edtCodCli.Text <> '00000000' Then
        Begin
          pCarregaCliente;

          If blnBuscaPorChave Then
          Begin
            pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
            frmFatMostraObsCliente.pMostraObsCliente(edtCodCli.Text);
          End;
        End;
      End
      Else
      Begin
        edtNomCli.Text := 'TODOS';
        Result := True;
      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO PORTADOR               *}
    {**************************************RV*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        pDesmarcaLista(edtCodPor, arrPortador, 'TMP_PORTADOR');

        {*REQ*145940**********RP*}
        If (High(arrEmpresa) > 0) Then
        Begin
            If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmpresa) Then
              Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
      Begin
        edtNomPor.Text := 'TODOS';
        Result := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser digitada!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmAgrupDuplicatas.fValidaValorAgrupamento(strNumAgr, strCodCli,
  strEmpAgr: String): Boolean;
var
  qryValores: TUniQuery;
  fltValDupAgr,
  fltValCadRec: Double;
begin
  fltValDupAgr := 0;
  fltValCadRec := 0;

  qryValores := fCriaQuery();
  With qryValores Do
  Begin
    sql.Clear;
    sql.Text := ' SELECT ' +
                '   SUM(CTR_VALDUP +             ' +
                '       IFNULL(CTR_JURSUJ, 0) +  ' +
                '       IFNULL(CTR_DESCOB, 0) -  ' +
    IIF(blnDescontoAteVencimento,
                '       IF(CTR_DTAVEN >= CURRENT_DATE, IFNULL(CTR_DESSUJ, 0), 0) + ',
                '       IFNULL(CTR_DESSUJ, 0) + ') +
                '       CTR_VALJUR-CTR_VALDES) AS VALAGR ' +
                ' FROM ' +
                '   DUPAGR ' +
                ' WHERE ' +
                '   CTR_NUMAGR = :NUMAGR AND ' +
                '   CTR_CODCLI = :CODCLI AND ' +
                '   CTR_EMPAGR = :CODEMP '      +
                ' GROUP BY CTR_NUMAGR, CTR_CODCLI, CTR_EMPAGR ';

    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strEmpAgr;

    Open;

    If Not IsEmpty Then
      fltValDupAgr := FieldByName('VALAGR').AsFloat;

    Close;
  End;

  With qryValores Do
  Begin
    sql.Clear;
    sql.Text := ' SELECT ' +
                '   SUM(CTR_VALDUP) AS VALAGR ' +
                ' FROM ' +
                '   CADREC ' +
                ' WHERE ' +
                '   CTR_NUMDUP = :NUMAGR AND ' +
                '   CTR_CODCLI = :CODCLI AND ' +
                '   CTR_CODEMP = :CODEMP AND ' +
                '   CTR_ESPDOC = "AG" ' +
                ' GROUP BY CTR_NUMDUP, CTR_CODCLI, CTR_CODEMP ';

    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strEmpAgr;

    Open;

    If Not IsEmpty Then
      fltValCadRec := FieldByName('VALAGR').AsFloat;

    Close;
  End;
  FreeAndNil(qryValores);

  Result := (fltValCadRec = fltValDupAgr);
End;

procedure TfrmAgrupDuplicatas.pAtualizaDados(DataSet: TDataSet);
begin

  If DataSet.ControlsDisabled Then
    Exit;

  edtCodPorBai.Text := DataSet.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := DataSet.FieldByName('POR_NOMPOR').AsString;
  edtNosNum.Text    := DataSet.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := DataSet.FieldByName('CTR_HIST01').AsString;


  edtCepEnt.Text    := DataSet.FieldByName('CEP_ENTREGA').AsString;
  edtCidEnt.Text    := DataSet.FieldByName('COD_CIDADE_ENTREGA').AsString;
  edtNomCid.Text    := DataSet.FieldByName('NOME_CIDADE_ENTREGA').AsString;
  edtEstado.Text    := DataSet.FieldByName('ESTADO_ENTREGA').AsString;
  edtEndEnt.Text    := DataSet.FieldByName('ENDERECO_ENTREGA').AsString;
  edtBaiEnt.Text    := DataSet.FieldByName('BAIRRO_ENTREGA').AsString;
  edtRefEnt.Text    := DataSet.FieldByName('REFERENCIA_ENTREGA').AsString;
  edtMsg001.Text    := DataSet.FieldByName('MENSAGEM001').AsString;
  edtMsg002.Text    := DataSet.FieldByName('MENSAGEM002').AsString;

end;

procedure TfrmAgrupDuplicatas.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmAgrupDuplicatas.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryConVen, qryConVen, edtCodVen.Text);
  With qryConVen Do
  Begin
    edtNomVen.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;



procedure TfrmAgrupDuplicatas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If fPermiteFecharAgrupF11 Then
    taAgrupouF11 := taAbortou;

  objLock.pDestravarTodos;
  fGetFuncoesCxGrid.pSalvarView(grdDuplicatasDBTableView1, Self.Name + '.' + grdDuplicatasDBTableView1.Name, grdDuplicatasDBTableView1.DataController.DataSet);

  If Assigned(objLogLibRec) Then
    FreeAndNil(objLogLibRec);

  If Assigned(FDicBaixa) Then
    FreeAndNil(FDicBaixa);
end;

procedure TfrmAgrupDuplicatas.FormCreate(Sender: TObject);
begin
  inherited;
  pZeraDigDuplic(arrDuplicata);
  blnUsouValDupOriComDesmembramento := False;
  taAgrupouF11 := taNone;
  blnF11 := False;
  SetLength(arrDupAgr, 0);
  stlLisSel       := TStringList.Create;
  blnFatVen       := False;
  blnAtivarTransacaoNaGravacaoAgrupamento := True;
  blnFecharForm   := False;
  objParcelamento := nil;
  AFormVeio       := 'AGRUPAMENTO';

  stlAutIncDupMar := TStringList.Create;
  stlAutIncDupMar.Sorted := True;

  qryGenRec := fCriaQuery(Self);

  pZeraDigDuplic(arrDuplicata);
  objLock := TLock.Create;

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriaQuery(Self);
  qryConVen := fCriaQuery(Self);


  cdsCtaRec := TUniClientDataSet.Create(Self);
  cdsCtaRec.AfterScroll := pAtualizaDados;
  dtsCtaRec := fCriaDataSource(cdsCtaRec);
  grdDuplicatasDBTableView1.DataController.DataSource := dtsCtaRec;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  blnDescontoAteVencimento := fCfgSis('UTDEFN') = '2';
  chkEnviarEmail.checked := false;
  objLogLibRec := TLogLibRec.Create;

  FParcelasAcerto := False;
  FDicBaixa  := TDictionary <String,Variant>.Create;
end;

procedure TfrmAgrupDuplicatas.pCalculaTotalDuplicatas(edtValTot: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldValTot: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldValTot := fCriaAggregateField(cdsGen, 'FLDVALTOT', 'SUM(CTR_VALCOR)', '#,##0.00');

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;
    If blnFiltrar Then
    Begin
      Filtered := False;
      Filter := 'CTR_MARDES = ' + QuotedStr('M');
      Filtered := True;
    End;

    AggregatesActive := True;
    edtValTot.Text := FormatFloat('#,##0.00', IIF(fldValTot.Value = Null, 0.00, fldValTot.Value));
  End;

  FreeAndNil(cdsGen);
end;

procedure TfrmAgrupDuplicatas.pCriaTemporaria;
  Var
    strSQL: String;
    strCndPag: String;
    qryCtaRec: TUniQuery;
    dspCtaRec: TUniDataSetProvider;
    intCount: Integer;
    strCodPrj: String;
begin
  Try

    If (fCfgSis('DACPOR', varBoolean)) And
       Not (fEmptyStr(edtCodPor.Text)) Then
    Begin
      If Not fValidaCampos(edtCodPor) Then
      Begin
        blnMudarFoco := False;
        Exit;
      End;
    End;

    pLiberaDupsMarcadas;
    cdsCtaRec.Filtered := False;
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Self);
    dspCtaRec := TUniDataSetProvider.Create(Self);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
    strSQL := strSQL + '  R.CTR_SEQBAI AS CTR_SEQBAI, ';
    strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';
    strSQL := strSQL + '  R.CTR_DTACAD AS CTR_DTACAD, ';

    strSQL := strSQL + '  ENTCLI.ETC_CEPENT AS CEP_ENTREGA,';
    strSQL := strSQL + '  ENTCLI.ETC_CIDENT AS COD_CIDADE_ENTREGA,';
    strSQL := strSQL + '  ENTCLI.ETC_ENDENT AS ENDERECO_ENTREGA,';
    strSQL := strSQL + '  ENTCLI.ETC_BAIENT AS BAIRRO_ENTREGA,';
    strSQL := strSQL + '  ENTCLI.ETC_REFENT AS REFERENCIA_ENTREGA,';
    strSQL := strSQL + '  CADCID.CID_NOMCID AS NOME_CIDADE_ENTREGA,';
    strSQL := strSQL + '  CADCID.CID_ESTADO AS ESTADO_ENTREGA,';
    strSQL := strSQL + '  MOVGER.GER_MEN001 AS MENSAGEM001,';
    strSQL := strSQL + '  MOVGER.GER_MEN002 AS MENSAGEM002,';

    If blnDescontoAteVencimento Then
    Begin
      strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IF(R.CTR_DTAVEN >= CURRENT_DATE, IFNULL(R.CTR_DESSUJ, 0), 0) AS CTR_VALDUP, ';
      strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IF(R.CTR_DTAVEN >= CURRENT_DATE, IFNULL(R.CTR_DESSUJ, 0), 0) AS CTR_VALCOR, ';
    End
    Else
    Begin
      strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALDUP, ';
      strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALCOR, ';
    End;

    strSQL := strSQL + '  0.00 AS CTR_JURATR,  '; //VALOR DE JUROS ATRASO
    strSQL := strSQL + '  R.CTR_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS CTR_AUTOIN, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_CODCLI AS CLI_CODCLI, ';
    strSQL := strSQL + '  C.AUTOINCREM AS CLI_AUTOIN, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS CTR_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_FANSOB AS CTR_FANSOB, ';
    strSQL := strSQL + '  R.CTR_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '  C.CLI_CODREP AS CTR_CODREP, ';
    strSQL := strSQL + '  R.CTR_CODVEN AS CTR_CODVEN, ';
    strSQL := strSQL + '  R.CTR_CODDIG AS CTR_CODDIG, ';
    strSQL := strSQL + '  R.CTR_CODPOR AS CTR_CODPOR, ';
    strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR, ';
    strSQL := strSQL + '  CONCAT(R.CTR_CODPOR, "-", P.POR_NOMPOR) AS CTR_NOMPOR, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_DESCON AS CTR_DESCON, ';
    strSQL := strSQL + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
    strSQL := strSQL + '  R.CTR_ADTCLI AS CTR_ADTCLI, ';
    strSQL := strSQL + '  R.CTR_CODEVE AS CTR_CODEVE, ';
    strSQL := strSQL + '  R.CTR_CODVEL AS CTR_CODVEL, ';
    //strSQL := strSQL + '  R.CTR_HIST01 AS CTR_HIST01, ';  //REPLACE(CTR_HIST01, "<<csq>>" , " "), " "
    strSQL := strSQL + '  REPLACE(R.CTR_HIST01, "<<csq>>" , " ") AS CTR_HIST01, ';
    strSQL := strSQL + '  R.CTR_HIST02 AS CTR_HIST02, ';
    strSQL := strSQL + '  R.CTR_CODCND AS CTR_CODCND, ';
    strSQL := strSQL + '  IF(R.CTR_TIPFOR IS NULL OR CTR_TIPFOR="", "NENHUM", R.CTR_TIPFOR) AS CTR_TIPFOR, ';
    strSQL := strSQL + '  R.CTR_CODCTA AS CTR_CODCTA, ';
    strSQL := strSQL + '  R.CTR_CTASER AS CTR_CTASER, ';
    strSQL := strSQL + '  R.CTR_SERVAL AS CTR_SERVAL, ';
    strSQL := strSQL + '  R.CTR_CARTEI AS CTR_CARTEI, ';
    strSQL := strSQL + '  CTR_CONAPR, ';
    strSQL := strSQL + '  CTR_VALCOM, ';
    strSQL := strSQL + '  CTR_FATCOM, ';
    strSQL := strSQL + '  CTR_COMREP, ';
    strSQL := strSQL + '  CTR_FATREP, ';
    strSQL := strSQL + '  CTR_EMP_PD, ';
    strSQL := strSQL + '  CTR_VALIPI, ';
    strSQL := strSQL + '  CTR_VALRET, ';
    strSQL := strSQL + '  CTR_VALCBS, ';
    strSQL := strSQL + '  CTR_VALIBS, ';
    strSQL := strSQL + '  CTR_VAL_IS, ';
    strSQL := strSQL + '  CTR_VALACE, ';
    strSQL := strSQL + '  CTR_VALFRE, ';
    strSQL := strSQL + '  CTR_SEQCON, ';
    strSQL := strSQL + '  CTR_DIFORI, ';
    strSQL := strSQL + '  CTR_GRVORI, ';
    strSQL := strSQL + '  CTR_VALANT, ';
    strSQL := strSQL + '  R.CTR_DESSUJ, ';
    strSQL := strSQL + '  R.CTR_JURSUJ, ';
    strSQL := strSQL + '  R.CTR_BARCON, ';    
    strSQL := strSQL + '  R.CTR_PERDPO, ';
    strSQL := strSQL + '  R.CTR_QTDDAV, ';
    strSQL := strSQL + '  R.CTR_VALORI, ';
    strSQL := strSQL + '  C.CLI_CODVEN, ';
    strSQL := strSQL + '  CURRENT_TIMESTAMP AS HRAFIL, ';
    strSQL := strSQL + '    (SELECT COUNT(*) FROM  ';
    strSQL := strSQL + '     CADREC C ';
    strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
    strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
    strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
    strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
    strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI) - 1 AS CTR_BAIXAS, ';

    strSQL := strSQL + '    (SELECT IFNULL(CTR_VALCOM, 0) FROM ';
    strSQL := strSQL + '     CADREC C ';
    strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
    strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
    strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
    strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
    strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
    strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_VALCOM_SEQBAI_01, ';


    strSQL := strSQL + '    (SELECT IFNULL(CTR_COMREP, 0) FROM ';
    strSQL := strSQL + '     CADREC C ';
    strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
    strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
    strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
    strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
    strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
    strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_COMREP_SEQBAI_01, ';


    strSQL := strSQL + '    (SELECT SUM(IFNULL(CTR_VALREC, 0)) FROM ';
    strSQL := strSQL + '     CADREC C ';
    strSQL := strSQL + '          WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
    strSQL := strSQL + '            AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
    strSQL := strSQL + '            AND C.CTR_PARCEL = R.CTR_PARCEL ';
    strSQL := strSQL + '            AND C.CTR_CODEMP = R.CTR_CODEMP ';
    strSQL := strSQL + '            AND C.CTR_CODCLI = R.CTR_CODCLI) AS CTR_TOTAL_RECEB, ';

    strSQL := strSQL + '    (SELECT IFNULL(CTR_FATCOM, 0) FROM ';
    strSQL := strSQL + '     CADREC C ';
    strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
    strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
    strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
    strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
    strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
    strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_FATCOM_SEQBAI_01, ';

    strSQL := strSQL + '    (SELECT IFNULL(CTR_FATREP, 0) FROM ';
    strSQL := strSQL + '     CADREC C ';
    strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
    strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
    strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
    strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
    strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
    strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_FATREP_SEQBAI_01, ';

    strSQL := strSQL + '  " " AS CTR_MARDES,  ';
    strSQL := strSQL + '  0.00 AS CTR_VALDES, ';
    strSQL := strSQL + '  "CADREC" AS TABELA, ';
    strSQL := strSQL + '  0.00 AS CTR_JURREP,  ';//VALOR DE JUROS DO REPARCELAMENTO
    strSQL := strSQL + '  CTR_DOCDIV,  ';
    strSQL := strSQL + '  CTR_ESPDIV,  ';
    strSQL := strSQL + '  CTR_EMPDIV,  ';
    strSQL := strSQL + '  CTR_CLIDIV,  ';
    strSQL := strSQL + '  CTR_COMDIV,  ';
    strSQL := strSQL + '  CTR_FATDIV,  ';
    strSQL := strSQL + '  CTR_CODDIV,  ';
    strSQL := strSQL + '  CTR_INCDOC,  ';
    strSQL := strSQL + '  CONCAT(R.CTR_CODCND, "-", N.CND_DESCRI) AS CONDPAG, ';
    strSQL := strSQL + '  R.CTR_EMPPIX, ';
    strSQL := strSQL + '  R.CTR_TX_PIX, ';
    strSQL := strSQL + '  R.CTR_SEQMPX  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN CADCND N ON R.CTR_CODCND = N.CND_CODIGO ';

    strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.FGO_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                  AND FATGOR.FGO_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                  AND FATGOR.FGO_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                  AND FATGOR.FGO_CODEMP = CTR_CODEMP ';

    strSQL := strSQL + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

    strSQL := strSQL + '  LEFT JOIN MOVGER ON MOVGER.GER_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                  AND MOVGER.GER_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                  AND MOVGER.GER_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                  AND MOVGER.GER_CODEMP = CTR_CODEMP ';
    strSQL := strSQL + '                  AND MOVGER.GER_ORIDOC = "V" ';
    strSQL := strSQL + '                  AND MOVGER.GER_TIP_FC = "C" ';

    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM         ';
    strSQL := strSQL + '  LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM  ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CADCID.CID_CODCID = ENTCLI.ETC_CIDENT  ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  R.CTR_DTAREC IS NULL AND ';

    strSQL := strSQL + '  (IFNULL(FGO_BOLADT, 0.00) = 0.00) AND ';

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      strSQL := strSQL + 'IF((R.CTR_VALDUP < 0),IFNULL(R.CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString+',TRUE) AND';

    If blnF11 Then
      strSQL := strSQL + ' R.CTR_ESPDOC = "CC" AND ';

    {*****************************************************}
    {* VERIFICA PERMISSÃO DE AGRUPAMENTO DE CRÉDITO "CC" *}
    {* RQ 28259 ***************************************BB*}
    If (Not RotinaAgrupaCreditos) And (Not blnF11) Then
      strSQL := strSQL + ' R.CTR_VALDUP > 0.00 AND ';

    {*****************************************************}
    {* VERIFICA SE FILTRATA FATURAMENTO FUTURO ***********}
    {**************************************************AJ*}
    If (Not fCfgSis('AGR_FF', varBoolean)) And (Not blnF11) And Not fAgrupandoNotasAvulsas And (AFormVeio <> 'ACERTO') Then
      strSQL := strSQL + '  R.CTR_ESPDOC IN ("NF", "IF", "NS", "IV", "NV", "EL", "EV"' +
                         IIF(RotinaAgrupaCreditos, ',"CC"', EmptyStr) +
                         ') AND ';

    {*****************************************************}
    {* VERIFICA SE FILTRA VENDEDOR DOS DOCUMENTOS*********}
    {**************************************************FA*}

    if not fEmptyStr(edtCodven.Text) then
      strSQL := strSQL + ' CTR_CODVEN = ' + QuotedStr(edtCodVen.Text) + '  AND ';


    If Length(arrDocumentos) > 0 Then
    Begin
      strSQL := strSQL + '  R.CTR_SEQBAI = 0 AND (';

      For intCount := 0 To Length(arrDocumentos)-1 Do
      Begin
        strSQL := strSQL + ' ( ';
        strSQL := strSQL + '  R.CTR_NUMDUP = ' + QuotedStr(arrDocumentos[intCount].strNumDup) + ' AND ';
        strSQL := strSQL + '  R.CTR_ESPDOC = ' + QuotedStr(arrDocumentos[intCount].strEspDoc) + ' AND ';
        strSQL := strSQL + '  R.CTR_PARCEL = ' + QuotedStr(arrDocumentos[intCount].strParcel) + ' AND ';
        strSQL := strSQL + '  R.CTR_CODEMP = ' + QuotedStr(arrDocumentos[intCount].strCodEmp) + ' AND ';
        strSQL := strSQL + '  R.CTR_CODCLI = ' + QuotedStr(arrDocumentos[intCount].strCodCli);
        strSQL := strSQL + ' ) OR ';
      End;

      strSQL := LeftStr(strSQL, Length(strSQL)-3);
      strSQL := strSQL + ' ) ';

    End
    Else If Length(arrDocsAgrupar) <= 0 Then
    Begin
      strSQL := strSQL + '  R.CTR_DTAENV IS NULL AND ';
      strSQL := strSQL + '  IF(CTR_BCOBOL = "778", TRUE, (R.CTR_NOSNUM IS NULL OR R.CTR_NOSNUM = "")) ';

      strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'R.CTR_CODCLI', 'CODCLI');

      If (Not blnF11) Then
      Begin
        strSQL := strSQL + '  AND R.CTR_ESPDOC <> "AG" AND ';
        strSQL := strSQL + '  R.CTR_SEQBAI = 0 ';
        strSQL := strSQL + fStrLocate(edtCodCnd,arrCndPag,'CTR_CODCND','CODCND');

        {***************************************************}
        {* QUANDO OPCAO "ORIGEM (PEDIDO)", REALIZAR FILTRO *}
        {* DA EMPRESA DO PEDIDO (CTR_EMP_PD) ***************}
        {* RQ 30356 *************************************BB*}

        If rdbOrigem.Checked Then
        Begin
          If (Not fEmptyStr(edtCodEmp.Text)) Then
            strSQL := strSQL + ' AND R.CTR_EMP_PD IN (' + fRetArrToSQLIn(arrEmpresa, edtCodEmp.Text) + ') '
          Else If fCfgSis('EMPAGR', varBoolean) Then
            strSQL := strSQL + ' AND R.CTR_EMP_PD IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';
        End
        Else
        Begin
          If (Not fEmptyStr(edtCodEmp.Text)) Then
            strSQL := strSQL + ' AND R.CTR_CODEMP IN (' + fRetArrToSQLIn(arrEmpresa, edtCodEmp.Text) + ') '
          Else If fCfgSis('EMPAGR', varBoolean) Then
            strSQL := strSQL + ' AND R.CTR_CODEMP IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';
        End;

        If Not fEmptyStr(edtCodPor.Text) Then
          strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'R.CTR_CODPOR', 'CODPOR')
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          strSQL := strSQL + '  AND (IFNULL(R.CTR_CODPOR, "") = "" ';
          strSQL := strSQL + '  OR LOCATE(R.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        End;
      End
      Else
      Begin
        If fCfgSis('EMPORI', VarBoolean) Then
          strSQL := strSQL + '  AND R.CTR_CODEMP = ' + QuotedStr(VS_strCodEmp);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If rdbDtaCad.Checked Then
          strSQL := strSQL + '  AND R.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  AND R.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + fNumeroDuplicatasAvulsa;
    End;
    strSQL := strSQL + fStrLocate(edtCodPrj, arrPrj, 'AUX_CODPRJ', 'CODPRJ');

    qryCtaRec.Close;
    qryCtaRec.SQL.Clear;
    qryCtaRec.SQL.Add(strSQL);

    pSetaParam(edtCodPrj.Text, arrPrj ,strCodPrj ,'CODPRJ',qryCtaRec);
    pSetaParam(edtCodCnd.Text,arrCndPag,strCndPag,'CODCND',qryCtaRec);

    If (Length(arrDocsAgrupar) <= 0) and (Length(arrDocumentos) <= 0) Then
    Begin
      pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresa, 'CODEMP', qryCtaRec);

      pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryCtaRec);

      If Not (fCfgSis('DACPOR', varBoolean)) Or
         (fCfgSis('DACPOR', varBoolean)      And
          Not (fEmptyStr(edtCodPor.Text)))   Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryCtaRec);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        qryCtaRec.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        qryCtaRec.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;
    End;

    qryCtaRec.Open;

    If Not qryCtaRec.IsEmpty Then
    Begin
      pSetaClient(qryCtaRec);

      cdsCtaRec.Open;
      TFloatField(cdsCtaRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_JURATR')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_JURREP')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_VALCOR')).DisplayFormat := '#,##0.00';
      cdsCtaRec.IndexFieldNames := 'CTR_CODCLI;CLI_NOMCLI;CTR_DTAVEN;CTR_NUMDUP';
      cdsCtaRec.First;

      pCalculaValorCorrigido;

      If AFormVeio = 'ACERTO' Then
        CalculaValorCorrigidoAcertoDeContas;

      pSetFocus(grdDuplicatas);
    End
    Else
    Begin
      If fAgrupandoNotasAvulsas Then
      Begin
        blnFecharForm := True;
      End;

      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem agrupadas!', ['&O k']);
      pLimpaDados(chkLimFil.Checked);
      pSetFocus(edtCodEmp);

      blnMudarFoco := False;
    End;

    qryCtaRec.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.pCriaTemporaria]');
  End;

  objLogLibRec.CriaTabelaTemporaria;
  cdsCtaRec.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
end;

procedure TfrmAgrupDuplicatas.pLiberaDupsMarcadas;
begin
  If Not Assigned(cdsCtaRec) Then
    Exit;

  cdsCtaRec.Filtered := False;
  cdsCtaRec.Filter := 'CTR_MARDES = '+ QuotedStr('M');
  cdsCtaRec.Filtered := True;

  If Not cdsCtaRec.IsEmpty Then
  Begin
    cdsCtaRec.DisableControls;
    cdsCtaRec.First;

    While Not cdsCtaRec.Eof Do
    Begin
      objLock.fLock_Unlock(cdsCtaRec.FieldByName('TABELA').AsString +
                           cdsCtaRec.FieldByName('NRODUP').AsString +
                           cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
                           cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
                           cdsCtaRec.FieldByName('CTR_CODCLI').AsString +
                           cdsCtaRec.FieldByName('PARDUP').AsString,  False, False, False, '',True,'');

      cdsCtaRec.Next;
    End;
    cdsCtaRec.EnableControls;
  End;

  stlAutIncDupMar.Clear;
end;

function TfrmAgrupDuplicatas.fVerificaEspeciesMarcadas(Dataset: TUniClientDataset): Boolean;
Var SelFF, SelNF: Boolean;
begin
  SelFF := False;
  SelNF := False;
  Result := True;

  With Dataset do
  Begin
    First;
    While Not Eof Do
    Begin
      If (RotinaAgrupaCreditos) And
         (FieldByName('CTR_ESPDOC').AsString = 'CC') Then
      Begin
        Next;
        Continue;
      End;

      If (Pos(FieldByName('CTR_ESPDOC').AsString, NFF) > 0) Then
        SelNF := True
      Else
        SelFF := True;

      If (SelNF) ANd (SelFF) Then
      Begin
        Result := False;
        Exit;
      End;

      Next;
    End;
  End;
end;

procedure TfrmAgrupDuplicatas.pLimpaDados(blnLimFil: Boolean);
begin
  pLiberaDupsMarcadas;
  If blnLimFil Then
  Begin
    mskDtaIni.Text := DateToStr(VS_Date);
    mskDtaFin.Text := DateToStr(VS_Date);
    edtCodEmp.Clear;
    edtNomEmp.Clear;
    edtCodCli.Clear;
    edtNomCli.Clear;
    edtCodPor.Clear;
    edtNomPor.Clear;
    edtCodCnd.Clear;
    edtDesCnd.Clear;
    edtCodVen.Clear;
    edtNomVen.Clear;
    edtCodPrj.Clear;
    edtDesPrj.Clear;
    pLimpaGrid;
  End;
end;

procedure TfrmAgrupDuplicatas.pLimpaGrid;
begin
  cdsCtaRec.Filtered := False;
  cdsCtaRec.Close;

  edtTotalDup.Clear;
  edtTotalSelecionado.Clear;
  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtNosNum.Clear;
  edtHistor.Clear;

  edtCepEnt.Clear;
  edtCidEnt.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtEndEnt.Clear;
  edtBaiEnt.Clear;
  edtRefEnt.Clear;
  edtMsg001.Clear;
  edtMsg002.Clear;
end;

function TfrmAgrupDuplicatas.fNumeroDuplicatasAvulsa: String;
  Var
    intContador: Integer;
begin
  Result := ' ( ';

  For intContador := Low(arrDocsAgrupar) To High(arrDocsAgrupar) Do
  Begin
    Result := Result + ' ( ';
    Result := Result + '  R.CTR_NUMDUP = "' + arrDocsAgrupar[intContador].strNumDoc + '" AND ';
    Result := Result + '  R.CTR_ESPDOC = "' + arrDocsAgrupar[intContador].strEspDoc + '" AND ';
    Result := Result + '  R.CTR_CODEMP = "' + arrDocsAgrupar[intContador].strCodEmp + '" AND ';
    Result := Result + '  R.CTR_CODCLI = "' + arrDocsAgrupar[intContador].strCodCli + '"     ';

    If Not fEmptyStr(arrDocsAgrupar[intContador].strParcel) Then
      Result := Result + '  AND R.CTR_PARCEL = "' + arrDocsAgrupar[intContador].strParcel + '" ';

    Result := Result + ' ) ';

    If intContador < High(arrDocsAgrupar) Then
      Result := Result + ' OR ';
  End;

  Result := Result + ' ) ';
end;

procedure TfrmAgrupDuplicatas.pSelecionaDuplicata;
begin

  If cdsCtaRec.IsEmpty Then
    Exit;

  Try
    cdsCtaRec.AfterScroll := Nil;
    cdsCtaRec.DisableControls;

    stlLisSel.Clear;
    blnMarcar := IIF(cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M', True, False);

    If fControleTrava Then
    Begin
      fMarcaDuplicata(cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M');
      pCalculaTotalDuplicatas(edtTotalSelecionado, True);
    End;

  Finally
    cdsCtaRec.EnableControls;
    cdsCtaRec.AfterScroll := pAtualizaDados;
  End;

end;

procedure TfrmAgrupDuplicatas.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmAgrupDuplicatas.pUtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
  pnlCabecalho2.Visible := pnlCabecalho.Visible;
  pnlProjeto.Visible := pnlCabecalho.Visible;
end;

procedure TfrmAgrupDuplicatas.RecalculaJuros;
Var
  LConfirma   : Boolean;
  LEncMarcado : Boolean;
  LAplJur     : String;
  LPerJur     : Double;
  LPerMul     : Double;
  LRecNo      : Integer;
  LJurAnt     : Double;
  LPerMulAnt  : Double;
begin
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;

  LConfirma  := FDicBaixa['blnConfirma'];
  LAplJur    := FDicBaixa['strAplJur'];
  LJurAnt    := fCfgSis('JURAGR', varDouble);
  LPerMulAnt := fCfgSis('MULATR', varDouble);

  LEncMarcado := False;
  LRecNo := cdsCtaRec.RecNo;

  If (cdsCtaRec.Locate('CTR_MARDES', 'M', [])) Then
    LEncMarcado := True;

  cdsCtaRec.RecNo := LRecNo;

  Try
    cdsCtaRec.AfterScroll := Nil;
    cdsCtaRec.DisableControls;

    If (LConfirma) Then
    Begin
      If (LAplJur = 'T') And (LEncMarcado) Then
      Begin
        fMensagem('', 'Para efetuar o recálculo do juros, nenhuma duplicata pode estar selecionada!', ['&Ok']);
        Screen.Cursor := crDefault;
        Exit;
      End
      Else If (LAplJur = 'D') And (cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M') Then
      Begin
        fMensagem('', 'Para efetuar o recálculo do juros a duplicata não pode estar selecionada!', ['&Ok']);
        Screen.Cursor := crDefault;
        Exit;
      End
      Else If (LAplJur = 'D') Then
      Begin
        If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          fMensagem('ATENÇÃO', 'Não é possível efetuar o recálculo do juros pois a duplicata possui Pix gerado e ativo!', ['&Ok']);
          Screen.Cursor := crDefault;
          Exit;
        End;
      End;

      LPerJur := fStrToFloat(FDicBaixa['fltPerJur']);
      LPerMul := fStrToFloat(FDicBaixa['fltPerMul']);

      FPercJurosAplicado := LPerJur;

      LConfirma := LiberaRecalculoJuros(LPerJur, LPerMul, LAplJur, LConfirma);

      If (Not LConfirma) Then
        CalculaJuros(LJurAnt, LPerMulAnt, LAplJur);

    End;

    If LConfirma Then
    Begin
      Try
        pCalculaTotalDuplicatas(edtTotalSelecionado, False);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    cdsCtaRec.RecNo := LRecNo;
    cdsCtaRec.EnableControls;
    cdsCtaRec.AfterScroll := pAtualizaDados;
  End;

  Screen.Cursor := crDefault;
end;

function TfrmAgrupDuplicatas.RetornaDataCadastroFinalPeriodo: TDateTime;
begin
  Result := IIF(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)),VS_Date,StrToDateTime(mskDtaFin.Text));

  If (Result > VS_Date) Then
  Begin
    Result := VS_Date;
  End;
end;

function TfrmAgrupDuplicatas.RetornaVendedorDaDuplicataComMaiorValor(
  ADuplicatas: TUniClientDataSet): String;
  Var
    LCopiaDuplicatas: TUniClientDataset;
begin
  Result := '';

  If Not Assigned(ADuplicatas) Then
    Exit;

  If ADuplicatas.IsEmpty Then
    Exit;

  LCopiaDuplicatas := TUniClientDataset.Create(Nil);

  LCopiaDuplicatas.Data := ADuplicatas.Data;

  LCopiaDuplicatas.Filter   := 'CTR_MARDES=''M'' AND CTR_CODCLI=' + ADuplicatas.FieldByName('CTR_CODCLI').AsString.QuotedString;
  LCopiaDuplicatas.Filtered := True;

  LCopiaDuplicatas.IndexFieldNames := 'CTR_VALDUP';
  LCopiaDuplicatas.Open;
  LCopiaDuplicatas.Last;

  While Not LCopiaDuplicatas.Bof Do
  Begin
    Result := LCopiaDuplicatas.FieldByName('CTR_CODVEN').AsString;

    If Not Result.IsEmpty Then
      Break;

    LCopiaDuplicatas.Prior;
  End;

  FreeAndNil(LCopiaDuplicatas);
end;

function TfrmAgrupDuplicatas.RotinaAgrupaCreditos: Boolean;
begin
  Result := True;

  If Not fCfgSis('AGC_CC', varBoolean) Then
    Exit;

  Result := fCfgSis('AGP_CC', varBoolean);
end;

{*************************************************}
{* FAZ A TRAVA OU A LIBERAÇÃO DE UMA DOCUMENTO.  *}
{**********************************************MA*}

function TfrmAgrupDuplicatas.fControleTrava;
  Var
    strChaLck: String;
Begin
  Result := False;
  {*****************************************}
  {* ESTOU IGNORANDO A PARCELA PARA FORMAR *}
  {* A CHAVE DA TRAVA POIS NA CONFIRMAÇÃO  *}
  {* DE DOCUMENTOS, NÃO TEM PARCELA, SO-   *}
  {* MENTE O NUMERO DO DOCUMENTO.          *}
  {**************************************MV*}
  strChaLck := 'CADREC' +
               cdsCtaRec.FieldByName('NRODUP').AsString +
               cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
               cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
               cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

  If  blnMarcar Then
  Begin

    If Not fEmptyStr(fGetHostLock(strChaLck)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
      stlLisSel.Add(cdsCtaRec.FieldByName('NRODUP').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_CODEMP').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

      Exit;
    End;

    strChaLck := strChaLck + cdsCtaRec.FieldByName('PARDUP').AsString;
    If Not objLock.fLock_Unlock(strChaLck, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
      stlLisSel.Add(cdsCtaRec.FieldByName('NRODUP').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_CODEMP').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

      stlAutIncDupMar.Add(cdsCtaRec.FieldByName('TABELA').AsString +
                          cdsCtaRec.FieldByName('NRODUP').AsString +
                          cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
                          cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
                          cdsCtaRec.FieldByName('CTR_CODCLI').AsString +
                          cdsCtaRec.FieldByName('PARDUP').AsString);

      Exit;
    End;

    If Not fExisteDuplicata(cdsCtaRec.FieldByName('NRODUP').AsString,
                            cdsCtaRec.FieldByName('PARDUP').AsString,
                            cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                            cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                            cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                            cdsCtaRec.FieldByName('CTR_SEQBAI').AsInteger) Then
    Begin
      fMensagem('','Essa duplicata ja foi agrupada!',['&OK']);
      stlLisSel.Add(cdsCtaRec.FieldByName('NRODUP').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_CODEMP').AsString + '-' +
                    cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

      Exit;
    End;
    Result := True;
  End
  Else
  Begin
    {*******************************************}
    {* SE NÃO POSSUIR OUTRAS PARCELAS MARCADAS *}
    {* DESTRAVA TAMBÉM A CONTA COMPLETA        *}
    {****************************************AJ*}
    If (acaoMarca = 'btnDesmarca') Or (Not fVerificaParcelasMarcadas) Then
      objLock.fLock_Unlock(strChaLck, False);

    strChaLck := strChaLck + cdsCtaRec.FieldByName('PARDUP').AsString;
    objLock.fLock_Unlock(strChaLck, False);
    Result := True;
  End;
end;

function TfrmAgrupDuplicatas.fMarcaDuplicata(blnMarcar: Boolean): Boolean;
begin
  With cdsCtaRec Do
  Begin
    Result := (Not blnMarcar) Or
              ((blnMarcar) And
              (fRetUltimaAlteracaoCadRec(FieldByName('NRODUP').AsString,
                                         FieldByName('PARDUP').AsString,
                                         FieldByName('CTR_ESPDOC').AsString,
                                         FieldByName('CTR_CODCLI').AsString,
                                         FieldByName('CTR_CODEMP').AsString) < FieldByName('HRAFIL').AsDateTime));
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível selecionar a duplicata, pois essa sofreu uma alteração. Recarregue os títulos novamente.', ['&OK'], 0);
      objLock.fLock_Unlock('CADREC' +
               FieldByName('NRODUP').AsString +
               FieldByName('CTR_ESPDOC').AsString +
               FieldByName('CTR_CODEMP').AsString +
               FieldByName('CTR_CODCLI').AsString +
               FieldByName('PARDUP').AsString, False);
      Exit;
    End;

    If blnMarcar Then
    Begin
       If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO','A duplicata não pode ser selecionada pois possui um Pix gerado e ativo!',['OK']);

        Exit(False);
      End;
    End;


    Edit;
    FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');

    if (FieldByName('CTR_MARDES').AsString = 'D') and (intTotalMarcado > 0) then
    begin
      Dec(intTotalMarcado);
    end
    else
    begin
      Inc(intTotalMarcado);
    end;

    Post;
  End;
end;

procedure TfrmAgrupDuplicatas.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmAgrupDuplicatas.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliAgrupDup, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatas.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd,edtDesCnd,arrCndPag,fRetDesConPag,Nil,'da Condição de Pagamento');
end;

procedure TfrmAgrupDuplicatas.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not fCfgSisL('USACND', varBoolean) Then
    Exit;

  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCndPag, False) Then
  Begin
    If fValidaCampos(edtCodCnd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatas.pAgruparDuplicatas;
  Var
    blnConfirma                 : Boolean;
    strCndPag                   : String;
    fltTotCli,
    fltTotIPI,
    fltTotRet,
    fltTotAce,
    fltTotFre                   : Double;
    fltTotCbs,
    fltTotIbs,
    fltTotIs                    : Double;
    blnDtaVen                   : Boolean;
    intQtdImp                   : Integer;
    dtaDtaCad                   : TDateTime;
    LDataBase                   : TDateTime;
    intDiaVenc                  : Integer;
    intContCli                  : Integer;
    intContEmp                  : Integer;
    stlCodCli                   : TStringList;
    stlCodEmp                   : TStringList;
    strNomCli                   : String;
    blnEditavel                 : Boolean;
    cdsTmpCtr                   : TUniClientDataSet;
    cdsCtrBkp                   : TUniClientDataSet;
    blnSabDomFeriadosComoDiaUtil: Boolean;
    blnMostrarTela              : Boolean;
    intDup                      : Integer;
    frmDigQtdEti                : TfrmDigQtdEti;
    frmDigCndPagamento          : TfrmDigCndPagamento;
    frmCndPagRenegociacao       : TfrmCndPagRenegociacao;
    blnAnexosSalvos             : Boolean;
    blnPDF                      : Boolean;
    strCodCid                   : String;
    blnRepetirCndPag            : Boolean;
    strLinkPgtFormaEnvio        : String;
    strLinkPgtDestinatario      : String;
    arrAutoIncsAgrupado         : TArrayAutoIncAgrupado;

  function fTotalDuplicata(arrDup: TArrDigDuplicArray): Double;
  Var
    duplicata: TArrDigDuplic;
  begin
    Result := 0;
    For duplicata In arrDup Do
      Result := Result + duplicata.curValor;
  end;

  function fTemDataVencDiferente(strCodCli, strCodEmp: String): Boolean;
  var
    cdsGen: TUniClientDataSet;
    strFiltro: String;
    dtaData: TDateTime;
  Begin
    strFiltro := 'CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(strCodCli);
    If (fCfgSis('AGRTPR', varInteger) = 3) Then
      strFiltro := strFiltro + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
    cdsGen := fCriaClientCtaRec(strFiltro);

    With cdsGen Do
    Begin
      dtaData := FieldByName('CTR_DTAVEN').AsDateTime;

      strFiltro := strFiltro + ' AND CTR_DTAVEN <> ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dtaData));
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;

      Result := Not IsEmpty;
    End;
    FreeAndNil(cdsGen);
  End;

  procedure pCarregaInfDuplicatas(strCodCli, strCodEmp: String);
  var
    cdsGen: TUniClientDataSet;
    fld1, fld2: TAggregateField;

  Begin
    cdsGen := TUniClientDataSet.Create(Self);

    {***************************************}
    {* CARREGANDO A MENOR DATA DE CADASTRO *}
    {************************************AN*}
    fld1 := fCriaAggregateField(cdsGen, 'FLD1', 'MIN(CTR_DTACAD)');

    {*****************************************}
    {* CARREGANDO A MAIOR DATA DE VENCIMENTO *}
    {**************************************AN*}
    fld2 := fCriaAggregateField(cdsGen, 'FLD2', 'MAX(CTR_DTAVEN)');

    With cdsGen Do
    Begin
      Data := cdsCtaRec.Data;
      Filtered := False;
      Filter := 'CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(strCodCli);
      If (fCfgSis('AGRTPR', varInteger) = 3) Then
        Filter := Filter + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
      Filtered := True;

      AggregatesActive := True;

      dtaDtaCad  := fld1.Value;

      intDiaVenc := fFloatToInt(fld2.Value - VS_DATE);
    End;

    FreeAndNil(cdsGen);
  End;

  {****************************************************}
  {* FAZ UMA COPIA DO CLIENTDATASET COM AS DUPLICATAS *}
  {* MARCADAS NO CASO DE UM CANCELAMENTO POR CONTA DO *}
  {* USUARIO. SE CANCELADO É RESTAURADO O CLIENTDTSET *}
  {* COM OS DADOS DO INICIO DO AGRUPAMENTO            *}
  {*************************************************AN*}
  procedure pBackupCtaRec;
  Begin
    If Not Assigned(cdsCtrBkp) Then
    Begin
      cdsCtrBkp := TUniClientDataSet.Create(Self);
      cdsCtrBkp.Data := cdsCtaRec.Data;
      cdsCtrBkp.IndexFieldNames := cdsCtaRec.IndexFieldNames;
      cdsCtrBkp.RecNo := cdsCtaRec.RecNo;
    End Else
    Begin
      cdsCtaRec.Data := cdsCtrBkp.Data;
      cdsCtaRec.IndexFieldNames := cdsCtrBkp.IndexFieldNames;
      cdsCtaRec.RecNo := cdsCtrBkp.RecNo;

      TFloatField(cdsCtaRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_JURREP')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_JURATR')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_VALCOR')).DisplayFormat := '#,##0.00';

      FreeAndNil(cdsCtrBkp);
    End;
  End;

  {*************************************************}
  {* QUANDO TEMOS MAIS DE UM CLIENTE SELECIONADO É *}
  {* NECESSÁRIO DELETAR DO CLIENTDATASET "BACKUP"  *}
  {* AS DUPLICATAS QUE JA FORAM AGRUPADAS, POIS O  *}
  {* USUARIO AINDA PODE CANCELAR O AGRUPAMENTO DAS *}
  {* DUPLICATAS DE UM SEGUNDO CLIENTE              *}
  {**********************************************AN*}
  procedure pDeletaDuplicatasBackup(strCodCli, strCodEmp: String);
  var
    intRecNo: Integer;
    strCampos: String;
    varValores: Array of Variant;
  Begin
    With cdsCtrBkp Do
    Begin
      intRecNo := RecNo;
      If (fCfgSis('AGRTPR', varInteger) = 3) Then
      Begin
        strCampos := 'CTR_CODCLI;CTR_CODEMP;CTR_MARDES';
        varValores := VarArrayOf([strCodCli, strCodEmp, 'M']);
      End
      Else
      Begin
        strCampos := 'CTR_CODCLI;CTR_MARDES';
        varValores := VarArrayOf([strCodCli, 'M']);
      End;

      First;
      While cdsCtrBkp.Locate(strCampos, varValores, []) Do
      Begin
        cdsCtrBkp.Delete;
      End;

      RecNo := IIF(intRecNo > RecordCount, 1, intRecNo);
    End;
  End;

  procedure pConcluirAgrupamento;
    Var
      intCont  : Integer;
      prmDllRel: TParamDllEtiquetas;
      strDupAgr: String;
      arrDestinatarios: TStringArray;
      arrArquivos     : TStringArray;
      strMSBOEM       : string;
      blnEnviarEmail  : boolean;

  Begin
    {************************************}
    {* IMPRESSÃO DO COMPROVANTE         *}
    {*********************************JB*}

    blnEnviarEmail := chkEnviarEmail.checked;
    if blnEnviarEmail then
    begin
      blnAnexosSalvos := false;
      Try
        pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);

        If AFormVeio = 'ACERTO' Then
        Begin
          If FParcelasAcerto Then
            frmCtrAgrupDupRecibo.objParcelamento := Self.objParcelamento;
        End;

        If Length(arrDupAgr) > 0 Then
        Begin
          For intCont := 0 To Length(arrDupAgr) - 1 Do
            frmCtrAgrupDupRecibo.pImprimeComprovante(arrDupAgr[intCont].strNumAgr, Self.Name, 1,blnEnviarEmail);
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[Erro ao salvar comprovante agrupamento contas a receber]');
      End;

      //enviar e-mails
      for intCont := low(frmCtrAgrupDupRecibo.arrArqAgrupamentos) to high(frmCtrAgrupDupRecibo.arrArqAgrupamentos) do
      begin
        if frmCtrAgrupDupRecibo.arrArqAgrupamentos[intCont].strEmail <> '' then
        begin
          strMSBOEM := fCfgSis('MSBOEM', varString);
          pCriarArrayAnexosEDestinatarios(frmCtrAgrupDupRecibo.arrArqAgrupamentos[intCont].strarqanexos, frmCtrAgrupDupRecibo.arrArqAgrupamentos[intCont].strEmail, arrDestinatarios, arrArquivos);
          TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, 'Agrupamentos', arrDestinatarios, [], [], ['Segue duplicatas em anexo.', strMSBOEM], arrArquivos, False);
          strArqBoletos := '';
        end;
      end;
      pDestroiModulo(frmCtrAgrupDupRecibo);
      exit;
    end;

    intQtdImp := fGetMenu('Imprimir um comprovante?', ['Não Imprimir', '1 Via', '2 Vias', '3 Vias', '4 Vias'], 2) - 1;

    If intQtdImp > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);

        If AFormVeio = 'ACERTO' Then
        Begin
          If FParcelasAcerto Then
            frmCtrAgrupDupRecibo.objParcelamento := Self.objParcelamento;
        End;

        If Length(arrDupAgr) > 0 Then
        Begin
          For intCont := 0 To Length(arrDupAgr) - 1 Do
            frmCtrAgrupDupRecibo.pImprimeComprovante(arrDupAgr[intCont].strNumAgr, Self.Name, intQtdImp,False,arrDupAgr[intCont].strCodCli,arrDupAgr[intCont].strEmpAgr);
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[Erro ao imprimir comprovante agrupamento contas a receber]');
      End;

      pFreeAndNil(frmCtrAgrupDupRecibo);
    End;

    strDupAgr := '';
    For intCont := 0 To Length(arrDupAgr) - 1 Do
      strDupAgr := strDupAgr + arrDupAgr[intCont].strNumAgr + ', ';

    strDupAgr := Copy(strDupAgr, 1, Length(strDupAgr)-2);

    fMensagem('','Agrupamento(s) n° ' + strDupAgr + ' gerado(s) com sucesso!', ['&O k']);

    {*********************************************************}
    {* OPÇÃO PARA IMPRIMIR ETIQUETAS DO CLIENTE NA MESMA     *}
    {* ORDEM EM QUE FOI GERADA O AGRUPAMENTO.                *}
    {******************************************************MA*}

    If fCfgSis('IMPETI', varBoolean) Then
    Begin
      If (fMensagem('', 'Deseja imprimir etiqueta de Cliente?', ['&Sim', '&Não']) = 1) Then
      Begin

        strRegSel := '';
        intEtiQtd := 0;

        Try
          pCriarFormularios(TfrmDigQtdEti, frmDigQtdEti);

          frmDigQtdEti.showModal;
          intEtiQtd := frmDigQtdEti.intQtdEti;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmAgrupDuplicatas.pAgruparDuplicatas.pConcluirAgrupamento]');
          End;
        End;

        pFreeAndNil(frmDigQtdEti);

        If (fMensagem('', 'Deseja imprimir o Endereço?', ['&Faturamento', '&Cobrança']) = 1) Then
          blnEndCob := False
        Else
          blnEndCob := True;

        strRegSel := fListaAutoincremClientes.CommaText;

        prmDllRel := TParamDllEtiquetas.Create;

        With prmDllRel Do
        Begin
          If (fCfgSis('ETICLI') = 'L') Then
            tpeTipEtq := tpeClienteLaser
          Else
            tpeTipEtq := tpeClienteArgox;

          intQtdEti := intEtiQtd;
          strLisReg := strRegSel;
          blnEdrCob := blnEndCob;
          strCamBus := '""';
        End;

        If (Pos(fCfgSis('ETICLI'), 'LA') > 0) Then
          fImprimeEtiqueta(prmDllRel)
        Else
          pImpEtiquetasMatricial;

        pFreeAndNil(prmDllRel);

      End;
    End;

  End;

  procedure pCancelaAgrupamento;
  begin
    pBackupCtaRec;
    pCalculaTotalDuplicatas(edtTotalSelecionado, True);
    pSetFocus(grdDuplicatas);
    FreeAndNil(stlCodCli);
    FreeAndNil(stlCodEmp);

    {****************************************************************}
    {*  SE ANTES DE SER CANCELADO JA TINHA REALIZADO UM AGRUPAMENTO *}
    {* SERA CHAMADA A ROTINA DE CONCLUSAO DO AGRUPAMENTO            *}
    {*************************************************************AN*}
    If Length(arrDupAgr) > 0 Then
      pConcluirAgrupamento;
  end;

  {*****************************************************************}
  {* SE O OPERADOR TEM ACESSO CHAMA A TELA DE IMPRESSÃO DE BOLETOS *}
  {*REQ. 31703 20/04/2014****************************************JU*}
  procedure pChamaImpressaoBoleto;
    var
      qryAgpDup: TUniQuery;
      intConta_: Integer;
      arrDupCtr: TArrDupCtr;
      strSqlCon,
      strSqlExe: String;

    function fGetSqlAgrup: String;
    Begin
      Result := ' SELECT R.* FROM DUPAGR D' +
                ' JOIN CADREC R ON R.CTR_NUMDUP = D.CTR_NUMAGR AND ' +
                '                  R.CTR_CODCLI = D.CTR_CODCLI AND ' +
                '                  R.CTR_ESPDOC = "AG" AND ' +
                '                  R.CTR_CODEMP = "(CODEMP)" ' +
                ' WHERE D.CTR_NUMAGR = "(NUMAGR)"  ' +
                '   AND D.CTR_CODCLI = "(CODCLI)"  ' +
                ' GROUP BY R.CTR_NUMDUP, R.CTR_PARCEL ';
    End;

  Begin
    strSqlExe := '';
    if Length(arrDupAgr) > 0 then
    Begin
      For intConta_ := 0 To Length(arrDupAgr)-1 Do
      Begin
        strSqlCon := '';
        strSqlCon := fGetSqlAgrup;
        strSqlCon := StringReplace(strSqlCon, '(NUMAGR)', arrDupAgr[intConta_].strNumAgr, []);
        strSqlCon := StringReplace(strSqlCon, '(CODEMP)', arrDupAgr[intConta_].strEmpAgr, []);
        strSqlCon := StringReplace(strSqlCon, '(CODCLI)', arrDupAgr[intConta_].strCodCli, []);

        If Not fEmptyStr(strSqlExe) Then
          StrSqlExe := StrSqlExe + ' UNION ALL ' + strSqlCon
        Else
          StrSqlExe := strSqlCon;
      End;

      qryAgpDup := fCriaQuery;

      With qryAgpDup Do
      Begin
        Sql.Clear;
        Sql.Text := StrSqlExe;
        Open;

        If Not IsEmpty Then
        Begin
          SetLength(arrDupCtr,0);
          While Not Eof Do
          Begin
            If FieldByName('CTR_VALDUP').AsFloat > 0 Then
            Begin
              SetLength(arrDupCtr,Length(arrDupCtr)+1);
              arrDupCtr[Length(arrDupCtr)-1].strNumDup := FieldByName('CTR_NUMDUP').AsString;
              arrDupCtr[Length(arrDupCtr)-1].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
              arrDupCtr[Length(arrDupCtr)-1].strCodEmp := FieldByName('CTR_CODEMP').AsString;
              arrDupCtr[Length(arrDupCtr)-1].strCodCli := FieldByName('CTR_CODCLI').AsString;
              arrDupCtr[Length(arrDupCtr)-1].strParcel := FieldByName('CTR_PARCEL').AsString;
              arrDupCtr[Length(arrDupCtr)-1].strAutoIn := FieldByName('AUTOINCREM').AsString;
            End;

            Next;
          End;

          If Length(arrDupCtr) > 0 Then
            TBoleto.fImprimirBoletos(arrDupCtr, blnFatVen, True, 'Deseja imprimir boletos?', self.Name);
        End;
      End;
    End;
  End;

begin
  blnConfirma := False;
  blnUsaTelaCnd := False;
  blnRepetirCndPag := False;

  blnSabDomFeriadosComoDiaUtil := fCfgSis('FSDUDP', varBoolean);
  SetLength(arrDupAgr, 0);

  stlCodCli := fCriaListaClientes;
  stlCodEmp := fCriaListaEmpresas;
  If stlCodCli.Count = 0 Then
  Begin
    fMensagem('Aviso', 'Nenhuma Duplicata foi selecionada!', ['&Ok']);
    FreeAndNil(stlCodCli);
    FreeAndNil(stlCodEmp);
    Exit;
  End;

  {*******************************************************************}
  {* SALVA UMA COPIA TEMPORARIA DO CLIENTDATASET DE CONTAS A RECEBER *}
  {****************************************************************AN*}
  pBackupCtaRec;

  {*************************************************}
  {* LOOP PARA PROCESSAR AS DUPLICATAS POR CLIENTE *}
  {**********************************************AN*}
  For intContCli := 0 To stlCodCli.Count-1 Do
  Begin
    For intContEmp := 0 To stlCodEmp.Count-1 Do
    Begin
      strNomCli := fRetNomCliente(stlCodCli[intContCli]);
      blnDtaVen := False;

      SetLength(arrLogLib, 0);
      objLogLibRec.pLimpaTmpLogLib;

      {*******************************************}
      {* SOMA DOS DOCUMENTOS MARCADOS            *}
      {****************************************AC*}
      pRetornaTotal(stlCodCli[intContCli], stlCodEmp[intContEmp], fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre);
      pRetornaTotalReforma(stlCodCli[intContCli], stlCodEmp[intContEmp], fltTotCbs, fltTotIbs, fltTotIs);

      If fltTotCli = 0 Then
      Begin
        fMensagem('Atenção','Total de Duplicatas do Cliente: ' + stlCodCli[intContCli] + ' - ' + strNomCli +
                  iif(fCfgSis('AGRTPR', varInteger) = 3, ' / Empresa ' + stlCodEmp[intContEmp] + ' - ' + fRetNomeEmpresa(stlCodEmp[intContEmp]), '') + ' = ' +
                  FormatFloat('#,##0.00', fltTotCli) + '. Duplicatas não agrupadas.' ,['&Ok']);
      End Else
      Begin

        {*******************************************************************************}
        {* CHAMA A TELA DE DESCONTO ESPECIAL.SE HOUVER DESCONTO ATUALIZA O VALOR TOTAL *}
        {****************************************************************************AC*}
        If (fCfgSis('DESAGR', varBoolean)) And (fltTotCli > 0) And
           (Not fAgrupandoNotasAvulsas) And (Not Assigned(objParcelamento)) Then
        Begin
          If fChamaDesconto(stlCodCli[intContCli], stlCodEmp[intContEmp], strNomCli, fltTotCli) Then
          Begin
            pCalculaTotalDuplicatas(edtTotalSelecionado, True);
            pRetornaTotal(stlCodCli[intContCli], stlCodEmp[intContEmp], fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre);
            pRetornaTotalReforma(stlCodCli[intContCli], stlCodEmp[intContEmp], fltTotCbs, fltTotIbs, fltTotIs);
          End
          Else
          Begin
            pCancelaAgrupamento;
            Exit;
          End;
        End;

        {*****************************************}
        {* VERIFICA SE POSSSUI DUPLICATAS        *}
        {* COM DATA DE VENCIMENTO DIFERENTES E   *}
        {* SE A MAIOR DATA DE VENCIMENTO É MENOR *}
        {* QUE A DATA DO SISTEMA (ATUAL),        *}
        {* PEGA A MENOR DATA DE CADASTRO,        *}
        {* PEGA O VALOR TOTAL DAS DUPLICATAS     *}
        {**************************************JC*}
        If fTemDataVencDiferente(stlCodCli[intContCli], stlCodEmp[intContEmp]) Then
          blnDtaVen := True;

        pCarregaInfDuplicatas(stlCodCli[intContCli], stlCodEmp[intContEmp]);

        If (intDiaVenc <= 0) Then
          blnDtaVen := True;

        strNumAgr := '';
        strCodBco := '';
        strNosNum := '';
        fltValMor := 0.0;
        strLinkPgtFormaEnvio   := '';
        strLinkPgtDestinatario := '';
        If Assigned(objParcelamento) Then
        Begin
          strCndPag   := '';
          dtaDtaCad   := objParcelamento.dtaDataBase;
          fltTotCli   := objParcelamento.fltTotalParcelas;
          blnConfirma := True;
        End
        Else If Not fEmptyStr(strCondicaoNotaAvulsa) Then
        Begin
          strCndPag := strCondicaoNotaAvulsa;
          blnConfirma := True;
        End
        Else If Length(arrDocumentos) > 0 Then
        Begin

          Try
            pCriarFormularios(TfrmCndPagRenegociacao, frmCndPagRenegociacao);
            frmCndPagRenegociacao.ShowModal;

            strCndPag   := frmCndPagRenegociacao.mskCndPag.Text;
            blnConfirma := frmCndPagRenegociacao.blnConfirma;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
          FreeandNil(frmCndPagRenegociacao);

        End
        {***************************************}
        {* SE A DATA DE VENCIMENTO DAS         *}
        {* DUPLICATAS DO CLIENTE FOR DIFERENTE *}
        {* CHAMA A TELA CONDIÇÃO DE PAGAMENTO  *}
        {************************************LB*}
        Else If (blnDtaVen) Or (Not fCfgSis('CALVEN', varBoolean))  Then
        Begin
          {*****************************************}
          {* CHAMA A TELA DE CONDIÇÃO DE PAGAMENTO *}
          {**************************************MA*}

          Try

            pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
            frmDigCndPagamento.Caption   := 'Condição Pagto (Cliente: ' + strNomCli + ')';
            frmDigCndPagamento.fraDigCndPagamento.strCliAgr := stlCodCli[intContCli];
            frmDigCndPagamento.fraDigCndPagamento.strCodCli := stlCodCli[intContCli];
            frmDigCndPagamento.fraDigCndPagamento.blnTelaAgrupamento := True;
            frmDigCndPagamento.fraDigCndPagamento.chkCndPagTodos.Visible := FAgrupContaReceber and (stlCodCli.Count > 1);
            frmDigCndPagamento.fraDigCndPagamento.EspDoc := 'AG' ;

            If (fCfgSis('USAFPG', varBoolean)) Then
            Begin
              frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Visible := False;
              frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Height;
            End;

            If ((intContCli = 0) And (Not blnRepetirCndPag)) Or
               ((intContCli > 0) And (Not blnRepetirCndPag)) Then
            Begin
              frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := fRetCondicaoPagtoFaixaValor(fltTotCli);

              If Not fEmptyStr(frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text) Then
                frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := fRetCondicaoPagtoFaixaValor(fltTotCli, True);
            End;

            frmDigCndPagamento.fraDigCndPagamento.blnTamForm     := True;
            frmDigCndPagamento.fraDigCndPagamento.edtTotDup.Text := FloatToStrF(fltTotCli,ffFixed,12,2);

            {**************************************************************}
            {* CARREGANDO UM CDS TEMPORARIO PARA EXIBIR OS ITENS MARCADOS *}
            {* PARA EXIBI-LOS NO TELA DE CONDICAO DE PAGAMENTO            *}
            {***********************************************************AN*}
            If (fCfgSis('AGRTPR', varInteger) = 3) Then
              cdsTmpCtr := fCriaClientCtaRec('CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(stlCodCli[intContCli]) + ' AND CTR_CODEMP = ' + QuotedStr(stlCodEmp[intContEmp]))
            Else
              cdsTmpCtr := fCriaClientCtaRec('CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(stlCodCli[intContCli]));
            TFloatField(cdsTmpCtr.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
            TFloatField(cdsTmpCtr.FieldByName('CTR_JURREP')).DisplayFormat := '#,##0.00';
            TFloatField(cdsTmpCtr.FieldByName('CTR_JURATR')).DisplayFormat := '#,##0.00';
            TFloatField(cdsTmpCtr.FieldByName('CTR_VALCOR')).DisplayFormat := '#,##0.00';

            frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[5].Visible   := True;
            frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[5].FieldName := 'CTR_VALCOR';

            frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.DataSource := fCriaDataSource(cdsTmpCtr);

            If ((intContCli = 0) And (Not blnRepetirCndPag)) Or
               ((intContCli > 0) And (Not blnRepetirCndPag)) Then
            Begin
              frmDigCndPagamento.ShowModal;

              blnUsaTelaCnd := True;
              strCndPag   := frmDigCndPagamento.fraDigCndPagamento.strCndPag;
              strLinkPgtFormaEnvio := frmDigCndPagamento.fraDigCndPagamento.LinkPgtFormaEnvio ;
              strLinkPgtDestinatario := frmDigCndPagamento.fraDigCndPagamento.LinkPgtDestinatario ;

              If Not fEmptyStr(frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text) Then
                strCodCnd   := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text
              else
                strCodCnd := '';

              blnConfirma := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;
            end;

            If blnConfirma And (fltTotCli > 0) And fCfgSis('SISCRE', varBoolean) Then
            Begin
              If fAplicaTaxaJurosAgrupamento(stlCodCli[intContCli],
                                             stlCodEmp[intContEmp],
                                             frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text,
                                             frmDigCndPagamento.fraDigCndPagamento.strCndPag,
                                             fltTotCli) Then
              Begin
                pCalculaTotalDuplicatas(edtTotalSelecionado, True);
                pRetornaTotal(stlCodCli[intContCli], stlCodEmp[intContEmp], fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre);
                pRetornaTotalReforma(stlCodCli[intContCli], stlCodEmp[intContEmp], fltTotCbs, fltTotIbs, fltTotIs);
              End
              Else
                blnConfirma := False;
            End;

            if blnConfirma And Not blnRepetirCndPag then
              blnRepetirCndPag := frmDigCndPagamento.fraDigCndPagamento.chkCndPagTodos.Checked;

          Except
            On E: Exception Do
            Begin
              blnConfirma := False;
              blnRepetirCndPag := False;
              pMensagensErro(E.Message, '[frmAgrupDuplicatas.pAgruparDuplicatas]');
            End;
          End;

          pFreeAndNil(frmDigCndPagamento);

          If Not blnConfirma Then
          Begin
            pCancelaAgrupamento;
            Exit;
          End;


        End
        Else
        Begin
          strCndPag     := '01'+ fPadL(IntToStr(intDiaVenc),3,'0');
          blnUsaTelaCnd := False;
          blnConfirma   := True;
        End;

        {*****************************************}
        {* PEDE VALORES DAS PARCELAS             *}
        {**************************************MA*}
        If blnConfirma Then
        Begin
          If Assigned(objParcelamento) Then
          Begin
            SetLength(arrDuplicAgr, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicIPI, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicRet, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicAce, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicFre, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicCbs, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicIbs, Length(objParcelamento.arrParcelas));
            SetLength(arrDuplicIs,  Length(objParcelamento.arrParcelas));

            For intDup := 0 To Length(objParcelamento.arrParcelas) -1 Do
            Begin
              arrDuplicAgr[intDup].strSequen := objParcelamento.arrParcelas[intDup].strNumeroParcela;
              arrDuplicAgr[intDup].dtaDtaVen := DateToStr(objParcelamento.arrParcelas[intDup].dtaVencimento);

              If fFormataFloat(objParcelamento.arrParcelas[intDup].fltValorParcela,2) =
                 fFormataFloat((objParcelamento.arrParcelas[intDup].fltAmortizacao + objParcelamento.arrParcelas[intDup].fltJuros),2) Then
              Begin
                arrDuplicAgr[intDup].curValor  := objParcelamento.arrParcelas[intDup].fltAmortizacao;
                arrDuplicAgr[intDup].curJuros  := objParcelamento.arrParcelas[intDup].fltJuros;
              End
              Else
                arrDuplicAgr[intDup].curValor  := objParcelamento.arrParcelas[intDup].fltValorParcela;

              arrDuplicIPI[intDup].curValor  := fFormataFloat(fltTotIPI * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
              arrDuplicRet[intDup].curValor  := fFormataFloat(fltTotRet * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
              arrDuplicAce[intDup].curValor  := fFormataFloat(fltTotAce * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
              arrDuplicFre[intDup].curValor  := fFormataFloat(fltTotFre * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
              arrDuplicCbs[intDup].curValor  := fFormataFloat(fltTotCbs * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
              arrDuplicIbs[intDup].curValor  := fFormataFloat(fltTotIbs * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
              arrDuplicIs[intDup].curValor   := fFormataFloat(fltTotIs  * arrDuplicAgr[intDup].curValor / objParcelamento.fltTotalParcelas, 2);
            End;

            arrDuplicIPI[0].curValor  := arrDuplicIPI[0].curValor + fFormataFloat(fltTotIPI - fTotalDuplicata(arrDuplicIPI), 2);
            arrDuplicRet[0].curValor  := arrDuplicRet[0].curValor + fFormataFloat(fltTotRet - fTotalDuplicata(arrDuplicRet), 2);
            arrDuplicAce[0].curValor  := arrDuplicAce[0].curValor + fFormataFloat(fltTotAce - fTotalDuplicata(arrDuplicAce), 2);
            arrDuplicFre[0].curValor  := arrDuplicFre[0].curValor + fFormataFloat(fltTotFre - fTotalDuplicata(arrDuplicFre), 2);
            arrDuplicCbs[0].curValor  := arrDuplicCbs[0].curValor + fFormataFloat(fltTotCbs - fTotalDuplicata(arrDuplicCbs), 2);
            arrDuplicIbs[0].curValor  := arrDuplicIbs[0].curValor + fFormataFloat(fltTotIbs - fTotalDuplicata(arrDuplicIbs), 2);
            arrDuplicIs[0].curValor   := arrDuplicIs[0].curValor  + fFormataFloat(fltTotIs  - fTotalDuplicata(arrDuplicIs), 2);
          End
          Else
          Begin
            blnMostrarTela := blnDtaVen Or (Not fCfgSis('CALVEN', varBoolean));

            If (fAgrupandoNotasAvulsas) Then
              blnMostrarTela := False;

            If fCfgSis('AGRVEN', varBoolean) Then
               blnEditavel := True
            Else
               blnEditavel := False;

            LDataBase := VS_Date;

            If (AgrupContaReceber And (fCfgSis('DTAAGR') = '3')) Then
              LDataBase := RetornaDataCadastroFinalPeriodo;

            strCodCid := fRetCidCliente(stlCodCli[intContCli]);
            fDigDuplic(arrDuplicata, strCndPag, 0, fltTotCli, blnMostrarTela,
                       blnEditavel, False, LDataBase, True, 0, 'N', True, False, 0, False,
                       Nil, '', blnSabDomFeriadosComoDiaUtil, blnEditavel, Nil, '',
                       False, True, '', '', Nil, False, True, Nil, False, False, 0, AFormVeio,
                       strCodCid, '', True);

            blnConfirma := arrDuplicata[0].strSequen <> '';
            SetLength(arrDuplicAgr, Length(arrDuplicata));

            If blnConfirma And (fRetornaCndPag(arrDuplicata, VS_Date) <> strCndPag)  then
            Begin
              If  Not (VS_blnCalculaPrazoMedioCND) And (blnEditavel) Then
              Begin
                If Assigned(cdsTmpCtr) Then
                  blnConfirma := fLiberarAgrupDupCtr(cdsTmpCtr);
              End;
            End;

            For intDup := 0 To Length(arrDuplicata) -1 Do
            Begin
              arrDuplicAgr[intDup] := arrDuplicata[intDup];
            End;

            fDigDuplicVar(strCndPag, 0, fltTotIPI, False, False, False, VS_Date, False, arrDuplicIPI, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotRet, False, False, False, VS_Date, False, arrDuplicRet, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotAce, False, False, False, VS_Date, False, arrDuplicAce, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotFre, False, False, False, VS_Date, False, arrDuplicFre, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotCbs, False, False, False, VS_Date, False, arrDuplicCbs, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotIbs, False, False, False, VS_Date, False, arrDuplicIbs, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotIs,  False, False, False, VS_Date, False, arrDuplicIs,  0, 'N', False);
          End;

          FreeAndNil(cdsTmpCtr);

          {If Length(arrDocumentos) > 0 Then
          Begin
            SetLength(arrDupDocs, 26);

            fDigDuplicSemTelaVar(False, arrDupDocs, intQtdPar, curTotalRes, strCndPag, 0, fltTotCli,
                                 False, False,VS_Date, False, 0, 'N', True, False, 0.0, Nil,
                                 blnSabDomFeriadosComoDiaUtil, False);
            blnConfirma := arrDupDocs[0].strSequen <> '';
            fDigDuplicVar(strCndPag, 0, fltTotIPI, False, False, False, VS_Date, False, arrDuplicIPI, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotRet, False, False, False, VS_Date, False, arrDuplicRet, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotAce, False, False, False, VS_Date, False, arrDuplicAce, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotFre, False, False, False, VS_Date, False, arrDuplicFre, 0, 'N', False);

          End
          Else
          Begin
            blnMostrarTela := blnDtaVen Or (Not fCfgSis('CALVEN', varBoolean));

            If (fAgrupandoNotasAvulsas) Then
              blnMostrarTela := False;

            If fCfgSis('AGRVEN', varBoolean) Then
               blnEditavel := True
            Else
               blnEditavel := False;

            fDigDuplic(strCndPag, 0, fltTotCli, blnMostrarTela,
                       blnEditavel, False, VS_Date, True, 0, 'N', True, False, 0, False,
                       Nil, '', blnSabDomFeriadosComoDiaUtil, blnEditavel, Nil, '', False, True, '', '', Nil, False, True);

            fDigDuplicVar(strCndPag, 0, fltTotIPI, False, False, False, VS_Date, False, arrDuplicIPI, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotRet, False, False, False, VS_Date, False, arrDuplicRet, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotAce, False, False, False, VS_Date, False, arrDuplicAce, 0, 'N', False);
            fDigDuplicVar(strCndPag, 0, fltTotFre, False, False, False, VS_Date, False, arrDuplicFre, 0, 'N', False);

            If fAgrupandoNotasAvulsas And blnUsouValDupOriComDesmembramento Then
            Begin
              For intIdxPar := Low(arrDuplicata) To High(arrDuplicata) Do
              Begin
                If Not fEmptyStr(arrDuplicata[intIdxPar].strSequen) Then
                Begin
                  pRetornaTotal(stlCodCli[intContCli],
                                stlCodEmp[intContEmp],
                                fltTotDupPar,
                                fltTotIPIPar,
                                fltTotRetPar,
                                fltTotAcePar,
                                fltTotFrePar,
                                arrDuplicata[intIdxPar].strSequen);

                  arrDuplicata[intIdxPar].curValor := fltTotDupPar;
                  arrDuplicIPI[intIdxPar].curValor := fltTotIPIPar;
                  arrDuplicRet[intIdxPar].curValor := fltTotRetPar;
                  arrDuplicAce[intIdxPar].curValor := fltTotAcePar;
                  arrDuplicFre[intIdxPar].curValor := fltTotFrePar;
                End;
              End;
            End;

            blnConfirma := arrDuplicata[0].strSequen <> '';
          end; }
        End;

        //Req 159806
        //Acontece que a LCKATC não replica e, se a duplicata foi alterada por outra loja no meio da rotina,
        //é necessário verificar novamente as alterações
        Try
          If blnConfirma Then
          Begin
            If (fCfgSis('AGRTPR', varInteger) = 3) Then
              cdsTmpCtr := fCriaClientCtaRec('CTR_MARDES=''M'' AND CTR_CODCLI=' + stlCodCli[intContCli].QuotedString + ' AND CTR_CODEMP=' + stlCodEmp[intContEmp].QuotedString)
            Else
              cdsTmpCtr := fCriaClientCtaRec('CTR_MARDES=''M'' AND CTR_CODCLI=' + stlCodCli[intContCli].QuotedString);

            blnConfirma := Not untCadRec.ValidaSeAlgumDosDocumentosSofreuAlteracao(cdsTmpCtr);

            FreeAndNil(cdsTmpCtr);

            If Not blnConfirma Then
            Begin
              If blnF11 Then
              Begin
                fMensagem('ATENÇÃO','Existem duplicatas que sofreram altrerações por outro usuário. Refaça o processo no caixa da seleção de modalidade para que o sistema atualize os dados!',['&OK']);
                taAgrupouF11 := taAviso;
                blnF11 := False;
                Close;
              End
              Else
              Begin
                fMensagem('ATENÇÃO!', 'Existem duplicatas que sofreram altrerações por outro usuário. Realize a pesquisa novamente para efetuar o agrupamento corretamente!', ['&OK']);
                grdDuplicatas.Enabled := True;
                btnConfirma.Enabled   := True;
                pnlCabecalho.Enabled  := True;
                pnlBotoesBaixa.Enabled:= True;
              End;
            End;
          End;
        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.pAgruparDuplicatas]');
          End;
        End;

        If Not blnConfirma Then
        Begin
          pCancelaAgrupamento;
          Exit;
        End;

        {***********************************}
        {* GRAVA AGRUPAMENTO               *}
        {********************************LB*}
        If blnConfirma Then
        Begin
          {*******************************************************************}
          {* PRIMEIRO GRAVA E DEPOIS VERIFICA SE EXISTE MAIS QUE UM CLIENTE  *}
          {* PARA DELETAR AS DUPLICATAS AGRUPADAS DO CLIENTDATASET DE BACKUP *}
          {****************************************************************AN*}
          fltTotalAgrup    := fltTotCli;
          Try
            If (fGravaAgrupamentos(stlCodCli[intContCli], stlCodEmp[intContEmp], dtaDtaCad, strCndPag)) And (stlCodCli.Count > 1) Then
              pDeletaDuplicatasBackup(stlCodCli[intContCli], stlCodEmp[intContEmp]);
          Finally
            If blnAtivarTransacaoNaGravacaoAgrupamento Then
            Begin
              If fInTransaction Then
                fRollBack;
            End;
          End;
        End;
      End;
    End;
  End;

  {***********************************************}
  {* CHAMA A IMPRESSAO DO COMPROVANTE E MENSAGEM *}
  {********************************************AN*}
  if blnGravou Then
  begin
    If blnConfirma And (Length(arrDupAgr) > 0) Then
       pConcluirAgrupamento;

    pLimpaDados(chkLimFil.Checked);
    If Not chkLimFil.Checked Then
      btnCarrTitulos.Click;

    If fAgrupandoNotasAvulsas Then
    Begin
      pFecharTelaAgrupandoNotasAvulsas;
    End
    Else If blnF11 Then
    Begin
      blnF11 := False;
      taAgrupouF11 := taNone;
      Close;
    End
    Else
      pSetFocus(edtCodEmp);

    if fGeraLinkPagamento(strLinkPgtFormaEnvio, strLinkPgtDestinatario) then
    begin
      arrAutoIncsAgrupado := fRetornaAutoIncAgrupado(StrToInt(LeftStr(strCndPag, 2))) ;
      fEnviaLinkPagtoOnlineCtrAgr(arrAutoIncsAgrupado,
                                  fltTotCli,
                                  strCndPag,
                                  strLinkPgtFormaEnvio,
                                  strLinkPgtDestinatario) ;
    end
    else
    begin

      {*****************************************************************}
      {* SE O OPERADOR TEM ACESSO CHAMA A TELA DE IMPRESSÃO DE BOLETOS *}
      {**REQ. 31703 20/04/2014***************************************JU*}
      If fVerificaAcessoSistema('frmImpBoletosIndiv') Then
      Begin
        pChamaImpressaoBoleto;
      End;

    end ;
  end
  else
  begin
    pCancelaAgrupamento;
    Exit;
  end;

  FreeAndNil(stlCodCli);
  FreeAndNil(cdsCtrBkp);
end;

procedure TfrmAgrupDuplicatas.pFecharTelaAgrupandoNotasAvulsas;
begin
  SetLength(arrDocsAgrupar, 0);
  Close;
end;

{function TfrmAgrupDuplicatas.fDocumentosBaixados(strCodCli: String): Boolean;
  Var
    cdsAux: TUniClientDataSet;
    lstDoc: TStringList;
Begin

  Try
    Result := False;
    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data := cdsCtaRec.Data;
    lstDoc := TStringList.Create;

    cdsAux.Filter := ' CTR_MARDES = '+ QuotedStr('M') + ' AND CTR_CODCLI = ' + QuotedStr(strCodCli);
    cdsAux.Filtered := True;
    cdsAux.First;

    While Not cdsAux.Eof Do
    Begin
      Application.ProcessMessages;

      fVerificarCadRecBaixado(cdsAux.FieldByName('NRODUP').AsString,
                              cdsAux.FieldByName('CTR_ESPDOC').AsString,
                              cdsAux.FieldByName('CTR_CODCLI').AsString,
                              cdsAux.FieldByName('CTR_CODEMP').AsString,
                              cdsAux.FieldByName('PARDUP').AsString,
                              cdsAux.FieldByName('CTR_SEQBAI').AsString,
                              lstDoc);
      cdsAux.Next;
    End;

    If lstDoc.Count > 0 Then
    Begin
      Result := True;
      pGeraResumo(lstDoc);
    End;

  Except
    On E: Exception Do
    Begin
      Result := True;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(lstDoc);

end;}


function TfrmAgrupDuplicatas.fDocumentosBaixados: Boolean;
  Var
    cdsAux: TUniClientDataSet;
    lstDoc: TStringList;
Begin

  Try
    Result := False;
    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data := cdsCtaRec.Data;
    lstDoc := TStringList.Create;

    cdsAux.Filter := ' CTR_MARDES = '+ QuotedStr('M');
    cdsAux.Filtered := True;

    While Not cdsAux.Eof Do
    Begin
      Application.ProcessMessages;

      fVerificarCadRecBaixado(cdsAux.FieldByName('NRODUP').AsString,
                              cdsAux.FieldByName('CTR_ESPDOC').AsString,
                              cdsAux.FieldByName('CTR_CODCLI').AsString,
                              cdsAux.FieldByName('CTR_CODEMP').AsString,
                              cdsAux.FieldByName('PARDUP').AsString,
                              cdsAux.FieldByName('CTR_SEQBAI').AsString,
                              lstDoc);
      cdsAux.Next;
    End;

    If lstDoc.Count > 0 Then
    Begin
      Result := True;
      pGeraResumo(lstDoc);
    End;

  Finally
    FreeAndNil(lstDoc);
  end;

end;

function TfrmAgrupDuplicatas.fVerificarCadRecBaixado(strNumDoc, strEspDoc, strCliFor,
  strCodEmp, strParcel, strSeqBai: String; lstDoc: TStringList): Boolean;
  Var
    qryAux: TUniQuery;
begin

  Try
    Result := True;

    qryAux := fCriaQuery;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  CTR_NUMDUP, ');
    qryAux.SQL.Add('  CTR_PARCEL, ');
    qryAux.SQL.Add('  CTR_ESPDOC, ');
    qryAux.SQL.Add('  CTR_CODEMP  ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add(' CADREC ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    qryAux.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  CTR_PARCEL = :PARCEL AND ');
    qryAux.SQL.Add('  CTR_SEQBAI = :SEQBAI AND ');
    qryAux.SQL.Add('  CTR_DTAREC IS NOT NULL   ');

    qryAux.ParamByName('NUMDUP').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCliFor;
    qryAux.ParamByName('PARCEL').AsString := strParcel;
    qryAux.ParamByName('SEQBAI').AsString := strSeqBai;
    qryAux.Open;

    While (Not qryAux.Eof) Do
    Begin
      lstDoc.Add(qryAux.FieldByName('CTR_NUMDUP').AsString +
                 qryAux.FieldByName('CTR_PARCEL').AsString + ' - ' +
                 qryAux.FieldByName('CTR_ESPDOC').AsString + ' Loja: ' +
                 qryAux.FieldByName('CTR_CODEMP').AsString);
      qryAux.Next;
    End;

    qryAux.Close;
    FreeAndNil(qryAux);

  Except
    Result := False;
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmAgrupDuplicatas.pGeraResumo(lstCtrBaixadas: TStringList);
  Var
    blnGerarResumo: Boolean;
    intContador: Integer;
    frmCancelamentoDocResumo : TfrmCancelamentoDocResumo;
begin

  blnGerarResumo := (lstCtrBaixadas.Count > 0);

  If (blnGerarResumo) Then
  Begin

    Try
      pCriarFormularios(TfrmCancelamentoDocResumo, frmCancelamentoDocResumo);
      frmCancelamentoDocResumo.memResumo.Lines.Add('Duplicatas que já foram baixadas e portanto não podem ser agrupadas!');
      frmCancelamentoDocResumo.memResumo.Lines.Add('');

      For intContador := 0 To lstCtrBaixadas.Count -1 Do
        frmCancelamentoDocResumo.memResumo.Lines.Add(lstCtrBaixadas[intContador]);

      frmCancelamentoDocResumo.memResumo.Lines.Add('');
      frmCancelamentoDocResumo.memResumo.Lines.Add('Feche a tela de Agrupamento e abra novamente para atualizar a lista');
      frmCancelamentoDocResumo.memResumo.Lines.Add('das duplicatas em aberto...');

      frmCancelamentoDocResumo.Caption := 'Resumo do Agrupamento de Duplicatas';
      frmCancelamentoDocResumo.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRcxSelDocumentos.pGeraResumo]');
      End;
    End;

    pFreeAndNil(frmCancelamentoDocResumo);

  End;

end;

procedure TfrmAgrupDuplicatas.btnConfirmaClick(Sender: TObject);
begin
  if cdsCtaRec.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  If Not fRealizarAgrupamento Then
    Exit;

  TfrmGravando.fExecutarModalA(pConfirmarAgrupamento, 'Aguarde, Realizando Agrupamento...', '');
end;

procedure TfrmAgrupDuplicatas.pConfirmarAgrupamento;
  Var
    blnConfirma: Boolean;
    cdsClone: TUniClientDataSet;
    frmDigPortador : TfrmDigPortador;
    strEmpSemAcesso: String;

  procedure pClonaDuplicatasMarcadas;
  Begin
    cdsClone := TUniClientDataSet.Create(Self);

    pCloneDataSet(cdsClone, cdsCtaRec);

    With cdsClone Do
    Begin
      Filtered := False;
      Filter := 'CTR_MARDES = ''M''';
      Filtered := True;
    End;
    intQtdDupMarcada := cdsClone.Recordcount;
  End;

  function fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
  Begin
    Result := True;

    With cdsClone Do
    Begin
      First;

      While Not Eof Do
      Begin

        If stlAutIncDupMar.IndexOf(FieldByName('TABELA').AsString +
                                   FieldByName('NRODUP').AsString +
                                   FieldByName('CTR_ESPDOC').AsString +
                                   FieldByName('CTR_CODEMP').AsString +
                                   FieldByName('CTR_CODCLI').AsString +
                                   FieldByName('PARDUP').AsString) <> -1 Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;

  function fVerificaDuplicatasExcluidas: Boolean;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  Begin
    Result := True;

    With cdsClone Do
    Begin
      First;
      qryTmp := fCriaQuery;

      While Not Eof Do
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + FieldByName('TABELA').AsString;
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CTR_NUMDUP = :NRODUP AND ';
        strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '   CTR_PARCEL = :PARDUP     ';

        qryTmp.Params.Clear;
        qryTmp.SQL.Clear;
        qryTmp.SQL.Add(strSQL);
        qryTmp.ParamByName('NRODUP').AsString := FieldByName('NRODUP').AsString;
        qryTmp.ParamByName('ESPDOC').AsString := FieldByName('CTR_ESPDOC').AsString;
        qryTmp.ParamByName('CODEMP').AsString := FieldByName('CTR_CODEMP').AsString;
        qryTmp.ParamByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
        qryTmp.ParamByName('PARDUP').AsString := FieldByName('PARDUP').AsString;

        qryTmp.Open;

        If Not qryTmp.IsEmpty Then
        Begin
          If qryTmp.FieldByName('QTD').AsInteger = 0 Then
          begin
            Result := False;
            Break;
          end;
        End
        Else
        begin
          Result := False;
          Break;
        end;

        Next;
      End;

      FreeAndNil(qryTmp);
    End;
  End;
begin
  inherited;
  grdDuplicatas.Enabled := False;
  btnConfirma.Enabled   := False;
  pnlCabecalho.Enabled  := False;
  pnlBotoesBaixa.Enabled:= False;

  strAgrVen := '';

  If (cdsCtaRec.IsEmpty) Or (Not fVerificaCampos) Or (Not fVerificaDuplicatasClientes) Then
  Begin
    grdDuplicatas.Enabled := True;
    btnConfirma.Enabled   := True;
    pnlCabecalho.Enabled  := True;
    pnlBotoesBaixa.Enabled:= True;

    Exit;
  End;

  If Not fVerificaExiste Then
  Begin
    If blnF11 Then
    Begin
      fMensagem('ATENÇÃO','Existem duplicatas selecionadas que já foram agrupadas. Refaça o processo no caixa da seleção de modalidade para que o sistema atualize os dados!',['&OK']);
      taAgrupouF11 := taAviso;
      blnF11 := False;
      Close;
    End
    Else
    Begin
      fMensagem('','Existem duplicatas selecionadas que ja foram agrupadas!' +#13#10+
                   'Duplicata: ' + FDuplicatasJagrupadas ,['&OK']);
      grdDuplicatas.Enabled := True;
      btnConfirma.Enabled   := True;
      pnlCabecalho.Enabled  := True;
      pnlBotoesBaixa.Enabled:= True;

      Exit;
    End;
  End;

  If fDocumentosComPendenciaCancelamento Then
  Begin
    If blnF11 Then
    Begin
      taAgrupouF11 := taAviso;
      blnF11 := False;
      Close;
    End
    Else
    Begin
      grdDuplicatas.Enabled := True;
      btnConfirma.Enabled   := True;
      pnlCabecalho.Enabled  := True;
      pnlBotoesBaixa.Enabled:= True;
      Exit;
    End;
  End;

  If fDocumentosBaixados Then
  Begin
    If blnF11 Then
    Begin
      fMensagem('ATENÇÃO','Existem duplicatas selecionadas que já foram baixadas. Refaça o processo no caixa da seleção de modalidade para que o sistema atualize os dados!',['&OK']);
      taAgrupouF11 := taAviso;
      blnF11 := False;
      Close;
    End
    Else
    Begin
      grdDuplicatas.Enabled := True;
      btnConfirma.Enabled   := True;
      pnlCabecalho.Enabled  := True;
      pnlBotoesBaixa.Enabled:= True;

      Exit;
    End;
  End;

  If ((fCfgSis('PROCTR', varInteger) = 2) Or
      ((fCfgSis('PROCTR', varInteger) = 1) And
       (fCfgSis('AGDPIF') = 'S'))) And
     (fTemMovimento)                     Then
  Begin
    fMensagem('', 'O sistema está configurado para não permitir agrupamento de documentos já confirmados em NF!', ['&Ok']);
    grdDuplicatas.Enabled := True;
    btnConfirma.Enabled   := True;
    pnlCabecalho.Enabled  := True;
    pnlBotoesBaixa.Enabled:= True;

    Exit;
  End;

  pClonaDuplicatasMarcadas;

  {************************************************************}
  {* VERIFICA SE AS DUPLICATAS SELECIONADAS SÃO DO MESMO TIPO *}
  {*********************************************************AJ*}
  if (Not fVerificaEspeciesMarcadas(cdsClone) And
     ((AFormVeio = 'AGRUPAMENTO') or ((AFormVeio = 'ACERTO') And (fCfgSis('ESPACE') = 'S')))) then
  Begin
    fMensagem('ATENÇÃO!', 'As duplicatas de espécie NF, IF, NS, NV, IV, EL e EV não podem ser agrupadas com outras espécies de duplicatas' +
                          IIF(RotinaAgrupaCreditos, ', exceto CC', '') + '!', ['&OK']);
    cdsCtaRec.Locate('CTR_NUMDUP;CTR_ESPDOC', VarArrayOf([cdsClone.FieldByName('CTR_NUMDUP').AsString, cdsClone.FieldByName('CTR_ESPDOC').AsString]), []);
    grdDuplicatas.Enabled := True;
    btnConfirma.Enabled   := True;
    pnlCabecalho.Enabled  := True;
    pnlBotoesBaixa.Enabled:= True;
    pSetFocus(grdDuplicatas);
    FreeAndNil(cdsClone);
    Exit;
  End;


  If Not fDuplicatasJaUtilizadasPorOutrosUsuarios Then
  Begin
    FreeAndNil(cdsClone);

    If blnF11 Then
    Begin
      fMensagem('ATENÇÃO','Existem duplicatas que estão sendo agrupadas e as mesma foram utilizadas por outro usuário. Refaça o processo no caixa da seleção de modalidade para que o sistema atualize os dados!',['&OK']);
      taAgrupouF11 := taAviso;
      blnF11 := False;
      Close;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que estão sendo agrupadas e as mesma foram utilizadas por outro usuário. Realize a pesquisa novamente para efetuar o agrupamento corretamente!', ['&OK']);
      grdDuplicatas.Enabled := True;
      btnConfirma.Enabled   := True;
      pnlCabecalho.Enabled  := True;
      pnlBotoesBaixa.Enabled:= True;

      Exit;
    End;
  End;

  {********************************************************************}
  {* REALIZADO ESSE TRATAMENTO DEVIDO AO DESAGRUPAMENTO DE DUPLICATAS *}
  {********************************************************************}
  If Not fVerificaDuplicatasExcluidas Then
  Begin
    FreeAndNil(cdsClone);

    If blnF11 Then
    Begin
      fMensagem('ATENÇÃO','Existem duplicatas que foram excluídas por outro usuário. Refaça o processo no caixa da seleção de modalidade para que o sistema atualize os dados!',['&OK']);
      taAgrupouF11 := taAviso;
      blnF11 := False;
      Close;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que foram excluídas por outro usuário. Realize a pesquisa novamente para efetuar o agrupamento corretamente!', ['&OK']);
      grdDuplicatas.Enabled := True;
      btnConfirma.Enabled   := True;
      pnlCabecalho.Enabled  := True;
      pnlBotoesBaixa.Enabled:= True;

      Exit;
    End;
  End;

  If fAgrupandoNotasAvulsas And Assigned(objParcelamento) And
     (fStrToFloat(edtTotalDup.Text) > fStrToFloat(edtTotalSelecionado.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário que todas as duplicatas estejam selecionadas!', ['&OK']);
    FreeAndNil(cdsClone);
    Exit;
  End;

  If fUtilizaCredEmpresa Then
  Begin
    fMensagem('ATENÇÃO!', 'O(s) crédito(s) selecionado(s) pertence(m) a(s) empresa(s) '+ strEmpCod + #13 +
                          'e o mesmo só poderá ser utilizado na empresa de origem.', ['&OK']);
    grdDuplicatas.Enabled := True;
    btnConfirma.Enabled   := True;
    pnlCabecalho.Enabled  := True;
    pnlBotoesBaixa.Enabled:= True;
    Exit;
  End;

  If  (fMensagem('', 'Confirma agrupamento?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnConfirma := True;

    If (Not fAgrupandoNotasAvulsas) Or fEmptyStr(strPortadorNotaAvulsa) Then
    Begin
      Try
        pCriarFormularios(TfrmDigPortador, frmDigPortador);
        frmDigPortador.bolMostraVendedor := (fCfgSis('OPAGCR', varInteger) = 2);
        frmDigPortador.blnValidarPDD := (AFormVeio = 'AGRUPAMENTO');
        frmDigPortador.pnlCentroCusto.Visible := True;
        If Not fEmptyStr(edtCodPor.Text) Then
        Begin
          frmDigPortador.edtPorBai.Text    := edtCodPor.Text;
          frmDigPortador.edtCodPorBai.Text := edtNomPor.Text;
        End;

        frmDigPortador.ShowModal;
        blnConfirma := frmDigPortador.blnConfirma;

        If blnConfirma Then
        Begin
          {*REQ*145940**********RP*}
          If Not fEmpresasTemAcessoPortador(frmDigPortador.strCodPor,
                                            cdsClone,
                                            'CTR_CODEMP',
                                            strEmpSemAcesso,
                                            'CTR_MARDES = ''M''') Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
            grdDuplicatas.Enabled := True;
            btnConfirma.Enabled   := True;
            pnlCabecalho.Enabled  := True;
            pnlBotoesBaixa.Enabled:= True;
            Exit;
          End;

          strCodPor := frmDigPortador.strCodPor;
          strAgrVen := frmDigPortador.strCodVen;
          strCenCus := frmDigPortador.strEvento;
        End;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message,'[TfrmAgrupDuplicatas.btnConfirmaClick]');
        End;
      End;
      pFreeAndNil(frmDigPortador);
    End
    Else
      strCodPor := strPortadorNotaAvulsa;

    If blnConfirma Then
    begin
       TfrmGravando.fExecutarModal(pAgruparDuplicatas,'Aguarde ... ','');
    end;

    If Assigned(cdsClone) Then
    Begin
      With cdsClone Do
      Begin
        First;

        While Not Eof Do
        Begin
          objLock.fLock_Unlock(FieldByName('TABELA').AsString +
                               FieldByName('NRODUP').AsString +
                               FieldByName('CTR_ESPDOC').AsString +
                               FieldByName('CTR_CODEMP').AsString +
                               FieldByName('CTR_CODCLI').AsString +
                               FieldByName('PARDUP').AsString, False);

          Next;
        End;
      End;

      FreeAndNil(cdsClone);
    End;
    if Length(arrDocumentos) > 0 then
      Close;
  End;

  grdDuplicatas.Enabled := True;
  btnConfirma.Enabled   := True;
  pnlCabecalho.Enabled  := True;
  pnlBotoesBaixa.Enabled:= True;
end;

procedure TfrmAgrupDuplicatas.btnContaCorrenteClick(Sender: TObject);
begin
  If Not (cdsCtaRec.IsEmpty) Then
    TfrmMostraDebCtrChq2.pMostraContaCorrente(cdsCtaRec.FieldByName('CTR_CODCLI').AsString)
  Else
    fMensagem('','Selecione um cliente para consultar a Conta Corrente!',['&O k']);
end;

procedure TfrmAgrupDuplicatas.btnHistDocumentosClick(Sender: TObject);
  Var
    frmRelCtrLogAcompDuplicNovo : TfrmRelCtrLogAcompDuplicNovo;
begin
  Try
    pCriarFormularios(TfrmRelCtrLogAcompDuplicNovo, frmRelCtrLogAcompDuplicNovo);
    frmRelCtrLogAcompDuplicNovo.blnVeioAgrupamento := True;
    frmRelCtrLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.btnHistDocumentos]');
  End;
  pFreeAndNil(frmRelCtrLogAcompDuplicNovo);
end;

function TfrmAgrupDuplicatas.fGeraLinkPagamento(const AstrLinkPgtFormaEnvio,
  AstrLinkPgtDestinatario: String): Boolean;
begin
  Result := False ;

  if fEmptyStr(AstrLinkPgtFormaEnvio) then
    Exit ;

  if fEmptyStr(AstrLinkPgtDestinatario) then
    Exit ;

  Result := True ;
end;

function TfrmAgrupDuplicatas.fGravaAgrupamentos( strCodCli, strCodEmp: String; dtaDtaAgr: TDateTime; strConPag: String): Boolean;
  Var
    intContador: Integer;
    intTamAnt: Integer;
    blnConfirma: Boolean;
    blnDivValor: Boolean;
    dagAgrup: TDadosAgrup;
    arrDupSel: Array Of TDuplicataCtr;
    strEmpDuplic: String;
    strCodCliAG: String;
    fltTotAgr,
    fltTotIPI,
    fltTotRet,
    fltTotAce,
    fltTotFre: Double;
    strDupAgr: String;
    cdsGenCtr: TUniClientDataSet;
    strCodigoBarrasContrato: String;
    objCarnePagto: TCarnePagamento;
    fltValCom    : Double;
    fltComRep    : Double;
    fltValDes    : Double;
    fltPerDPo    : Double;
    intQtdDAV    : Integer;
    strHistorico : String;
    intQtdParcel,
    intCnt       : Integer;
    LDataTrocaPortador    : TDateTime;

  function fTemEmpresaDiferente(strCodCli: String): Boolean;
  var
    cdsGen: TUniClientDataSet;
    strFiltro: String;
    strCodEmp: String;
  Begin
    strFiltro := 'CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(strCodCli);
    cdsGen := fCriaClientCtaRec(strFiltro);

    With cdsGen Do
    Begin
      strCodEmp := FieldByName('CTR_CODEMP').AsString;

      strFiltro := strFiltro + ' AND CTR_CODEMP <> ' + QuotedStr(strCodEmp);
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;

      Result := Not IsEmpty;
    End;
    FreeAndNil(cdsGen);
  End;

  function fCodVen: String;
  var
    strCodVen: String;
  Begin
    If (fCfgSis('OPAGCR', varInteger) = 2) Then
    Begin
      If Not fEmptyStr(strAgrVen) Then
        Result := strAgrVen
      Else
        Result := cdsGenCtr.FieldByName('CTR_CODVEN').AsString;
    End
    Else If (fCfgSis('OPAGCR', varInteger) = 1) Then
      Result := cdsGenCtr.FieldByName('CLI_CODVEN').AsString
    Else If (fCfgSis('OPAGCR', varInteger) = 3) Then
    Begin
      strCodVen := RetornaVendedorDaDuplicataComMaiorValor(cdsGenCtr);

      If strCodVen.IsEmpty Then
        strCodVen := strLoginUsuarioLogado;

      Result := strCodVen;
    End;
  End;

  function fEmpVen(codVen:String): String;
  var
    strSQL : String;
  Begin
    {************************************************}
    {* CARREGANDO A EMPRESA REFERENTE AS DUPLICATAS *}
    {*********************************************FA*}
    If (fCfgSis('AGRTPR', varInteger) = 4) Then
    begin
       strSQL := 'SELECT OPE_CODEMP FROM CADOPE WHERE OPE_CODOPE = ' + QuotedStr(codVen);

       with qryConVen do
       begin
         Close;
         SQL.Text := strSQL;
         Open;
         Result := FieldByName('OPE_CODEMP').AsString;
       end;
    end else
    If (fCfgSis('AGRTPR', varInteger) = 3) Then
      Result := strCodEmp
    Else If fCfgSis('AGRTPR', varInteger) = 1 Then
       Result := VS_strCodEmp
    Else
    Begin
      If fTemEmpresaDiferente(strCodCli) Then
        Result := VS_strCodEmp
      Else
        Result := cdsGenCtr.FieldByName('CTR_CODEMP').AsString;
    End;


  End;

begin
  blnGravou   := False;
  blnDivValor := False;
  intQtdParcel := 0;

  {************************************************}
  {* RETORNA VALOR TOTAL DAS DUPLICATAS AGRUPADAS *}
  {*********************************************AC*}
  pRetornaTotal(strCodCli, strCodEmp, fltTotAgr, fltTotIPI, fltTotRet, fltTotAce, fltTotFre);

  Screen.Cursor := crHourGlass;

  If Not Assigned(objParcelamento) And (fCfgSis('DTAAGR') = '2') Then
    dtaDtaAgr := VS_Date
  Else If (AgrupContaReceber And (fCfgSis('DTAAGR') = '3')) Then
  Begin
    dtaDtaAgr := RetornaDataCadastroFinalPeriodo;
  End;

  LDataTrocaPortador := VS_Date;

  If not (AFormVeio = 'AGRUPAMENTO') Then
  Begin
    If Not fValidaPortadorDataPDD(strCodPor, strCodEmp, LDataTrocaPortador, False) Then
    Begin
      fMensagem('ATENÇÃO', 'Operação cancelada!', ['&O k']);
      Result := False;
      Exit;
    End;
  End;

  strNumAgr   := fSeqAgrupamentoCtr;

  strCodigoBarrasContrato := '';

  If fCfgSis('SISCRE', varBoolean) Then
    strCodigoBarrasContrato := TCarnePagamento.fNovoNumeroContrato(ContratoReparcelamento);

  {***************************************************}
  {* CRIANDO UM CLIENTDATASET COM OS DADOS DO PADRAO *}
  {* DO FORM PARA CONCLUIR O AGRUPAMENTO DE DUPLIC   *}
  {************************************************AN*}
  If (fCfgSis('AGRTPR', varInteger) = 3) Then
    cdsGenCtr := fCriaClientCtaRec('CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(strCodCli) + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp))
  Else
    cdsGenCtr := fCriaClientCtaRec('CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(strCodCli));

  With cdsGenCtr Do
  Begin
    Try
      DisableControls;
      {*****************************************}
      {* INICIA A TRANSAÇÃO                    *}
      {**************************************MV*}
      If blnAtivarTransacaoNaGravacaoAgrupamento Then
        fStartTransaction;

      First;
      While Not Eof Do
      Begin
        {*****************************************}
        {* FORMATA AS OBSERVAÇÕES                *}
        {**************************************MV*}
        If fEmptyStr(dagAgrup.strObsAg1) Then
        Begin
          dagAgrup.strObsAg1 := 'REF. DOC. ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString);
        End
        Else If Length(dagAgrup.strObsAg1) < 98 Then
        Begin
          dagAgrup.strObsAg1 := Copy(dagAgrup.strObsAg1 + ' / ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString), 1, 120);
        End
        Else If Length(dagAgrup.strObsAg2) < 112 Then
        Begin
          dagAgrup.strObsAg2 := Copy(dagAgrup.strObsAg2 + ' / ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString), 1, 120);
        End
        Else If Length(dagAgrup.strObsAg3) < 112 Then
        Begin
          dagAgrup.strObsAg3 := Copy(dagAgrup.strObsAg3 + ' / ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString), 1, 120);
        End;

        {*****************************************}
        {* SALVA AS DUPLICATAS QUE SERÃO ATUALI- *}
        {* ZADAS                                 *}
        {**************************************MV*}
        intTamAnt := Length(arrDupSel);
        SetLength(arrDupSel, intTamAnt+1);

        arrDupSel[intTamAnt].strNumDup := FieldByName('NRODUP').AsString;
        arrDupSel[intTamAnt].strParcel := FieldByName('PARDUP').AsString;
        arrDupSel[intTamAnt].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
        arrDupSel[intTamAnt].strCodEmp := FieldByName('CTR_CODEMP').AsString;
        arrDupSel[intTamAnt].strCodCli := FieldByName('CTR_CODCLI').AsString;
        arrDupSel[intTamAnt].strAutoIn := FieldByName('CTR_AUTOIN').AsString;

        {*****************************************}
        {* NUMERO DAS DUPLICATAS AGRUPADAS       *}
        {**************************************RV*}
        If (RecNo = 1) Then
          strDupAgr := FieldByName('CTR_NUMDUP').AsString
        Else
          strDupAgr := strDupAgr + '/' + FieldByName('CTR_NUMDUP').AsString;

        Application.ProcessMessages;
        Next;
      End;

      blnConfirma := True;
      If blnConfirma Then
      Begin
        fltPerDPo := 0.0;
        intQtdDAV := 0;

        If fCfgSis('DESPON', varBoolean) Then
        Begin
          If fCfgSis('TDEPON') = '1' Then
          Begin
            fltPerDPo := fCampoTabela('CND_PERDPO','CADCND',['CND_CODIGO'],[strCodCnd]);
            intQtdDAV := fCampoTabela('CND_QTDDAV','CADCND',['CND_CODIGO'],[strCodCnd]);
          End
          Else If fCfgSis('TDEPON') = '2' Then
          Begin
            fltPerDPo := fCampoTabela('CLI_PERDPO','CADCLI',['CLI_CODCLI'],[FieldByName('CTR_CODCLI').AsString]);
            intQtdDAV := fCampoTabela('CLI_QTDDAV','CADCLI',['CLI_CODCLI'],[FieldByName('CTR_CODCLI').AsString]);
          End;
        End;

        {*********************************************************}
        {* SUBSTITUI ARRDUPLICATAS CASO VENHA COM ARRDOCUMENTOS  *}
        {******************************************************FA*}
        If (Length(arrDocumentos) <= 0) Then
        Begin
          SetLength(arrDupDocs, 24);

          For intContador := 0 To Length(arrDuplicata) -1 Do
          Begin
            arrDupDocs[intContador].intNumDup := arrDuplicata[intContador].intNumDup;
            arrDupDocs[intContador].strSequen := arrDuplicata[intContador].strSequen;
            arrDupDocs[intContador].curValor  := arrDuplicata[intContador].curValor;
            arrDupDocs[intContador].dtaDtaVen := arrDuplicata[intContador].dtaDtaVen;
            arrDupDocs[intContador].strUsaChq := arrDuplicata[intContador].strUsaChq;
            arrDupDocs[intContador].strHist02 := arrDuplicata[intContador].strHist02;
          End;
        End;

        {If (Length(arrDocumentos) > 0) Then
        Begin

          For intContador := 0 To Length(arrDupDocs) -1 Do
          Begin

           // SetLength(arrDuplicata, intContador + 1);

           arrDuplicata[intContador].intNumDup   :=    arrDupDocs[intContador].intNumDup;
           arrDuplicata[intContador].strSequen   :=    arrDupDocs[intContador].strSequen;
           arrDuplicata[intContador].curValor    :=    arrDupDocs[intContador].curValor;
           arrDuplicata[intContador].dtaDtaVen   :=    arrDupDocs[intContador].dtaDtaVen;
           arrDuplicata[intContador].strUsaChq   :=    arrDupDocs[intContador].strUsaChq;
           arrDuplicata[intContador].strHist02   :=    arrDupDocs[intContador].strHist02;
          End;
        End;}
        {*****************************************}
        {* GRAVA AS DUPLICATAS AGRUPADAS         *}
        {**************************************MV*}
        For intContador := 0 To Length(arrDuplicAgr) -1 Do
        Begin

          {*****************************************}
          {* CHEGOU AO FIM DA MATRIZ.              *}
          {**************************************MV*}
          If fEmptyStr(arrDuplicAgr[intContador].strSequen) Then
            Break;

          If intQtdParcel <= 0 Then
          Begin
            For intCnt := Low(arrDuplicAgr) To High(arrDuplicAgr) Do
            Begin
               If Not fEmptyStr(arrDuplicAgr[intCnt].strSequen) Then
                 Inc(intQtdParcel);
            End;
          End;

          strHistorico := 'REF. AGRUPAMENTO Nro. ' + strNumAgr+ ' - PARC. ' + IntToStr(intContador+1) + ' / ' +
                          IntToStr(intQtdParcel) + ' - DOC(S): ' + strDupAgr;

{          If Assigned(objParcelamento) Then
            strHistorico := strHistorico + STRING_QUEBRA + STRING_QUEBRA +
                            AnsiReplaceStr(objParcelamento.strDadosNegociacao, STRING_ENTER, STRING_QUEBRA);}

          strEmpDuplic := fEmpVen(fCodVen);
          strCodCliAG  := FieldByName('CTR_CODCLI').AsString;

          blnConfirma := fGravaCadRec(Self.Name,
                                      'INCLUSÃO',
                                      strNumAgr,
                                      arrDuplicAgr[intContador].strSequen,
                                      0,
                                      'AG',
                                      FieldByName('CTR_CODCLI').AsString,
                                      //VS_strCodEmp,//FieldByName('CTR_CODEMP').AsString,
                                      strEmpDuplic,
                                      fCodVen,
                                      FieldByName('CTR_CODDIG').AsString,
                                      strCodPor,
                                      dtaDtaAgr,
                                      StrToDate(arrDuplicAgr[intContador].dtaDtaVen),
                                      arrDuplicAgr[intContador].curValor,
                                      arrDuplicAgr[intContador].curValor,
                                      0,
                                      'N',
                                      strHistorico,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0.0,
                                      0,
                                      FieldByName('CTR_ADTCLI').AsString,
                                      IIF( fEmptyStr(strCenCus), FieldByName('CTR_CODEVE').AsString, strCenCus),
                                      FieldByName('CTR_CODVEL').AsString,
                                      '',
                                      IIF(blnUsaTelaCnd, strCodCnd, FieldByName('CTR_CODCND').AsString),
                                      False,
                                      FieldByName('CTR_CODCTA').AsString,
                                      0,
                                      arrDuplicAgr[intContador].curValor,
                                      dagAgrup.strObsAg1,
                                      dagAgrup.strObsAg2,
                                      dagAgrup.strObsAg3,
                                      FieldByName('CTR_CTASER').AsString,
                                      FieldByName('CTR_SERVAL').AsFloat,
                                      0,  //intResCai
                                      0,  //fltVlrCom
                                      0,  //fltFatCom
                                      '', //strEmpBai
                                      '', // Empresa de Origem
                                      '', //strDocDiv
                                      '', //strEspDiv
                                      '', //strEmpDiv
                                      '', //strCliDiv
                                      0,  //fltVlrRep
                                      0,  //fltFatRep
                                      FieldByName('CTR_CODREP').AsString,
                                      iif(Assigned(arrDuplicIPI),arrDuplicIPI[intContador].curValor,0),
                                      arrDuplicRet[intContador].curValor,
                                      'N',
                                      0,
                                      arrDuplicAgr[intContador].curJuros,// CTR_JURSUR
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      strCodigoBarrasContrato,
                                      fltPerDPo, //fltPerDpo
                                      intQtdDAV,
                                      0,
                                      '',
                                      arrDuplicAce[intContador].curValor,
                                      arrDuplicFre[intContador].curValor,
                                      0,
                                      0,
                                      0,
                                      0,
                                      '',
                                      0,
                                      'INCLUSÃO',
                                      '',
                                      '',
                                      '',
                                      'N',
                                      'N',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0,
                                      0,
                                      '',
                                      arrDuplicCbs[intContador].curValor,
                                      arrDuplicIbs[intContador].curValor,
                                      arrDuplicIs[intContador].curValor);

          If Not blnConfirma Then
            Break;

          If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(strNumAgr,
                                                     'AG',
                                                     strEmpDuplic,
                                                     FieldByName('CTR_CODCLI').AsString,
                                                     arrDuplicAgr[intContador].strSequen,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                     afcAgrupaDuplicatas);
          End;
        End;

      End;

      {************************************}
      {*     GRAVA AUXREC REQ 158857      *}
      {*********************************JL*}
      If not (AFormVeio = 'AGRUPAMENTO') Then
        if blnConfirma then
          if Length(arrDuplicAgr) > 1 then
          begin
            {Se chegou aqui então é por que vai gerar várias duplicatas novas - renegociação.
             Então preciso salvar um registro na AUXREC para cada duplicata nova.}
            For intContador := 0 To Length(arrDuplicAgr) -1 Do
            begin
              {*****************************************}
              {* CHEGOU AO FIM DA MATRIZ.              *}
              {**************************************MV*}
              If fEmptyStr(arrDuplicAgr[intContador].strSequen) Then
                Break;

              TGravaAlteracaoDePortador.SalvarManualmente(FieldByName('CTR_CODPOR').AsString,
                                                          strCodPor,
                                                          strNumAgr,
                                                          arrDuplicAgr[intContador].strSequen,
                                                          'AG',
                                                          strEmpDuplic,
                                                          FieldByName('CTR_CODCLI').AsString,
                                                          '0',
                                                          False,
                                                          LDataTrocaPortador);
            end;
          end
          else
          begin
            {Se chegou aqui então é por que vai gerar somente uma nova - agrupamento.
             Então preciso salvar um registro na AUXREC para cada duplicata de origem.}
            First;
            While Not Eof Do
            Begin
              TGravaAlteracaoDePortador.SalvarManualmente(FieldByName('CTR_CODPOR').AsString,
                                                          strCodPor,
                                                          FieldByName('NRODUP').AsString,
                                                          FieldByName('PARDUP').AsString,
                                                          FieldByName('CTR_ESPDOC').AsString,
                                                          FieldByName('CTR_CODEMP').AsString,
                                                          FieldByName('CTR_CODCLI').AsString,
                                                          FieldByName('CTR_SEQBAI').AsString,
                                                          False,
                                                          LDataTrocaPortador);
              Next;
            end;
          end;

      If blnConfirma And Assigned(objParcelamento) Then
        blnConfirma := fGravaHistoricoParcelamento(strNumAgr, 'AG', strEmpDuplic, FieldByName('CTR_CODCLI').AsString, objParcelamento.ToString);

      if untCadRec.ValidaSeAlgumDosDocumentosSofreuAlteracao(cdsGenCtr) then
      begin
        fMensagem('ATENÇÃO',
                  'Uma ou mais duplicatas que estão sendo agrupadas ' +
                  'foram modificadas em outra estação. Não é possível finalizar o agrupamento. ' +
                  'Por favor, recarregue as duplicatas e tente novamente.',
                  ['&OK']);
        Exit(False);
      end;

      If blnConfirma Then
      Begin
        {*****************************************}
        {* DELETA AS DUPLICATAS ORIGINAIS        *}
        {**************************************MV*}
        blnConfirma := fDeletaDuplicatas(arrDupSel);

      End;



      {*******************************************}
      {* WHILE PARA GRAVACAO DO DUPAGR           *}
      {****************************************AF*}
      If blnConfirma Then
      Begin
        First;
        While Not Eof Do
        Begin
          {*****************************************}
          {* GRAVA A TABELA DUPAGR                 *}
          {**************************************MV*}

          {***********************************************************}
          {* SE EU ESTIVER AGRUPANDO UMA PARCELA QUE JÁ TEVE BAIXA   *}
          {* CALCULO O CTR_VALCOM DO AGRUPAMENTO DESCONTANDO O VALOR *}
          {* JÁ PAGO DE COMISSÃO QUE ESTARÁ NA DUPLICATA CUJO        *}
          {* CTR_SEQBAI É 1                                          *}
          {********************************************************VA*}
          fltValCom := FieldByName('CTR_VALCOM').AsFloat;
          If (FieldByName('CTR_BAIXAS').AsInteger > 0) Then
            fltValCom := (FieldByName('CTR_VALCOM_SEQBAI_01').AsFloat)
                       - (FieldByName('CTR_TOTAL_RECEB').AsFloat * FieldByName('CTR_FATCOM_SEQBAI_01').AsFloat);



          fltComRep := FieldByName('CTR_COMREP').AsFloat;
          If (FieldByName('CTR_BAIXAS').AsInteger > 0) Then
            fltComRep := (FieldByName('CTR_COMREP_SEQBAI_01').AsFloat)
                       - (FieldByName('CTR_TOTAL_RECEB').AsFloat * FieldByName('CTR_FATREP_SEQBAI_01').AsFloat);

          If blnDescontoAteVencimento Then
          Begin
            If FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date Then
              fltValDes := FieldByName('CTR_DESSUJ').AsFloat
            Else
              fltValDes := 0;
          End
          Else
            fltValDes := FieldByName('CTR_DESSUJ').AsFloat;

          blnConfirma := fGravaDupAgr(strNumAgr,
                                      FieldByName('NRODUP').AsString,
                                      FieldbyName('PARDUP').AsString,
                                      FieldByName('CTR_SEQBAI').AsInteger,
                                      FieldByName('CTR_ESPDOC').AsString,
                                      FieldByName('CTR_CODCLI').AsString,
                                      FieldByName('CTR_CODEMP').AsString,
                                      FieldByName('CTR_CODPOR').AsString,
                                      FieldByName('CTR_CODVEN').AsString,
                                      FieldByName('CTR_CODDIG').AsString,
                                      FieldByName('CTR_DTACAD').AsDateTime,
                                      FieldByName('CTR_DTAVEN').AsDateTime,

                                      FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                                      FieldByName('CTR_VALORI').AsFloat,

                                      FieldByName('CTR_DESCOB').AsFloat,
                                      FieldByName('CTR_DESCON').AsString,
                                      FieldByName('CTR_HIST01').AsString,
                                      FieldByName('CTR_HIST02').AsString,
                                      FieldByName('CTR_ADTCLI').AsString,
                                      FieldByName('CTR_CODEVE').AsString,
                                      FieldByName('CTR_CODVEL').AsString,
                                      FieldByName('CTR_TIPFOR').AsString,
                                      FieldByName('CTR_CODCND').AsString,
                                      IIF(FieldByName('CTR_CONAPR').AsInteger = 1, True, False),
                                      strEmpDuplic,
                                      FieldByName('CTR_CODCTA').AsString,
                                      FieldByName('CTR_EMP_PD').AsString,
                                      FieldByName('CTR_SEQCON').AsInteger,
                                      FieldByName('CTR_DIFORI').AsFloat,
                                      FieldByName('CTR_VALANT').AsFloat,
                                      FieldByName('CTR_GRVORI').AsFloat,
                                      FieldByName('CTR_CTASER').AsString,
                                      FieldByName('CTR_SERVAL').AsFloat,
                                      fltValCom,
                                      fltValCom/fltTotAgr,
                                      FieldByName('CTR_VALCOR').AsFloat/fltTotAgr,
                                      FieldByName('CTR_VALDES').AsFloat,
                                      FieldByName('CTR_JURATR').AsFloat + FieldByName('CTR_JURREP').AsFloat,
                                      strConPag,
                                      FieldByName('CTR_CODREP').AsString,
                                      fltComRep,
                                      fltComRep/fltTotAgr,
                                      FieldByName('CTR_VALIPI').AsFloat,
                                      FieldByName('CTR_VALRET').AsFloat,
                                      FieldByName('CTR_DESSUJ').AsFloat,
                                      FieldByName('CTR_JURSUJ').AsFloat,
                                      FieldByName('CTR_BARCON').AsString,
                                      FieldByName('CTR_PERDPO').AsFloat,
                                      FieldByName('CTR_QTDDAV').AsInteger,
                                      FieldByName('CTR_VALACE').AsFloat,
                                      FieldByName('CTR_VALFRE').AsFloat,
                                      0,
                                      FieldByName('CTR_DOCDIV').AsString,
                                      FieldByName('CTR_ESPDIV').AsString,
                                      FieldByName('CTR_EMPDIV').AsString,
                                      FieldByName('CTR_CLIDIV').AsString,
                                      FieldByName('CTR_COMDIV').AsFloat,
                                      FieldByName('CTR_FATDIV').AsFloat,
                                      FieldByName('CTR_CODDIV').AsString,
                                      0,
                                      '',
                                      FieldByName('CTR_INCDOC').AsString,
                                      FieldByName('CTR_SEQMPX').AsString,
                                      FieldByName('CTR_VALCBS').AsFloat,
                                      FieldByName('CTR_VALIBS').AsFloat,
                                      FieldByName('CTR_VAL_IS').AsFloat);

          If Not blnConfirma Then
            Break;

          If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('NRODUP').AsString,
                                                     FieldByName('CTR_ESPDOC').AsString,
                                                     FieldByName('CTR_CODEMP').AsString,
                                                     FieldByName('CTR_CODCLI').AsString,
                                                     FieldbyName('PARDUP').AsString,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                     afcAgrupaDuplicatas, True);
          End;

          Next;
          Application.ProcessMessages;

        End;
      End;
      DisableControls;

      If blnConfirma Then
      Begin
        objLogLibRec.pGravarLogLib( strNumAgr, 'AG', VS_strCodEmp, Self.Name );
       // pGeraLogLiberacao(strNumAgr, 'AG', VS_strCodEmp);
        blnGravou   := blnConfirma;
      End;

      objLogLibRec.pDropTabelaLogLib;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        blngravou   := False;
        If blnAtivarTransacaoNaGravacaoAgrupamento Then
          fRollBack;
        pMensagensErro(E.Message, '[untAgrupDuplicatas - grdDuplicatasKeyDown]');
      End;
    End;

  End;

  If (AFormVeio = 'AGRUPAMENTO') and (not fValidaValorAgrupamento(strNumAgr, strCodCli, strEmpDuplic)) Then
  Begin
    blnConfirma := False;
    blnDivValor := True;
  End;

  If blnConfirma Then
  Begin
    SetLength(arrDupAgr, Length(arrDupAgr) + 1);
    arrDupAgr[Length(arrDupAgr)-1].strNumAgr := strNumAgr;
    arrDupAgr[Length(arrDupAgr)-1].strEmpAgr := strEmpDuplic;
    arrDupAgr[Length(arrDupAgr)-1].strCodCli := strCodCliAG;

    If blnAtivarTransacaoNaGravacaoAgrupamento Then
      fCommit;
  End else
  Begin
    If blnAtivarTransacaoNaGravacaoAgrupamento Then
      fRollBack;
  End;

  if blnDivValor Then
  Begin
      fMensagem('ATENÇÃO!','Não foi possível gravar o agrupamento: ' +#13+ 'Nº: ' + strNumAgr + ' Cliente: ' + strCodCli +' - '+ Copy(fRetNomCliente(strCodCli), 1, 50) + #13+#13+
                         'O valor agrupado não corresponde ao valor da duplicata, tente novamente, se o problema persistir entre em contato com a Citel!', ['&O k']);
  End;

  Result := blnConfirma;
  Screen.Cursor := crDefault;
  FreeAndNil(cdsGenCtr);

  If fCfgSis('IMPCAF') = 'S' Then
  begin
    If Result And Not fEmptyStr(strCodigoBarrasContrato) And fCfgSis('IMPCAR', VarBoolean) Then
    Begin
      If (fMensagem('', 'Deseja imprimir contrato e carnê de pagamento?', ['&Sim', '&Não']) = 1) Then
      begin
        Try
          objCarnePagto := TCarnePagamento.Create(Self, strCodigoBarrasContrato);
          objCarnePagto.fImprimirContrato;
          objCarnePagto.fImprimirCarneRecibo;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '');
        End;
      end;

      If Assigned(objCarnePagto) Then
        FreeAndNil(objCarnePagto);
    End;
  end;

end;

function TfrmAgrupDuplicatas.fDeletaDuplicatas(
  arrDupSel: Array Of TDuplicataCtr): Boolean;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGenRec  : TUniQuery;

begin
  Try
    Result := True;

    qryGenRec := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM CADREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'AUTOINCREM IN (';
      For intContador := 0 To Length(arrDupSel) -1 Do
        strSQL := strSQL + '"' + arrDupSel[intContador].strAutoIn + '"' +
                           IIF(intContador < Length(arrDupSel) - 1, ',', ')');

      With qryGenRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        While Not Eof Do
        Begin
          Result := Result And fApagaDuplicataContasReceber(qryGenRec, Self.Name,'',False);
          Next;
        End;

        Close;

      End;

      If Not Result Then
        Raise Exception.Create('Erro ao apagar as duplicatas. Operação cancelada!');
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('Erro ao apagar as duplicatas. Erro gerado: ' + E.Message);
      End;

    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

procedure TfrmAgrupDuplicatas.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAgrupDuplicatas.CalculaJuros(APerJur, APerMul: Double;
  AAplJur: String);
Var
  LJuros : Double;
  LRecNo : Integer;
  LIndexFieldNames: String;
begin
  LRecNo := 0;

  If AAplJur = 'T' Then
  Begin
    LRecNo := cdsCtaRec.RecNo;
    LIndexFieldNames := cdsCtaRec.IndexFieldNames;
    cdsCtaRec.IndexFieldNames := 'CTR_NOMCLI;CTR_DTAVEN';
    cdsCtaRec.First;
  End;

  Try
    While Not cdsCtaRec.Eof Do
    Begin
      If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
      Begin
        cdsCtaRec.Next;
        Continue;
      End;

      If cdsCtaRec.FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
      Begin
        LJuros := fCalculaJurosCadCtr(cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                      cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat,
                                      APerJur,
                                      APerMul);

        cdsCtaRec.Edit;
        cdsCtaRec.FieldByName('CTR_JURATR').AsFloat := LJuros;
        cdsCtaRec.FieldByName('CTR_VALCOR').AsFloat := cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat + LJuros;
        cdsCtaRec.Post;

        FPercJurosAplicado := APerJur;

      End;

      If (AAplJur = 'D') Then
        Break;

      Application.ProcessMessages;
      cdsCtaRec.Next;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  If (AAplJur = 'T') Then
  Begin
    cdsCtaRec.IndexFieldNames := LIndexFieldNames;
    cdsCtaRec.RecNo := LRecNo;
  End;
end;

function TfrmAgrupDuplicatas.fRetornaAutoIncAgrupado(const AintParc: Integer): TArrayAutoIncAgrupado;
var
  LintCnt: Integer ;
  LintParc: Integer ;
begin
  SetLength(Result, 0);
  for LintCnt := Low(arrDupAgr) to High(arrDupAgr) do
  begin
    for LintParc := 1 to AintParc do
    begin
      SetLength(Result, Length(Result)+1);
      Result[High(Result)] := fCampoTabela('AUTOINCREM', 'CADREC', ['CTR_NUMDUP', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_ESPDOC', 'CTR_PARCEL'], [arrDupAgr[LintCnt].strNumAgr, arrDupAgr[LintCnt].strEmpAgr, arrDupAgr[LintCnt].strCodCli, 'AG', uppercase(Chr(64+LintParc))], False) ;
    end ;
  end ;
end ;

procedure TfrmAgrupDuplicatas.CalculaValorCorrigidoAcertoDeContas;
  Var
    LContador: Integer;
begin
  If Not FParcelasAcerto Then
    Exit;

  if Length(arrDocsAgrupar) = 0 Then
    Exit;

  Try
    cdsCtaRec.DisableControls;

    For LContador := 0 To Length(arrDocsAgrupar) - 1 Do
    Begin
      If arrDocsAgrupar[LContador].fltValCor < 0 Then
        Continue;

      If cdsCtaRec.Locate('NRODUP;PARDUP;CTR_ESPDOC;CTR_CODEMP;CTR_CODCLI',
                          VarArrayOf([arrDocsAgrupar[LContador].strNumDoc,
                                      arrDocsAgrupar[LContador].strParcel,
                                      arrDocsAgrupar[LContador].strEspDoc,
                                      arrDocsAgrupar[LContador].strCodEmp,
                                      arrDocsAgrupar[LContador].strCodCli]), [])Then
      Begin
        cdsCtaRec.Edit;
        cdsCtaRec.FieldByName('CTR_JURATR').AsFloat := arrDocsAgrupar[LContador].fltValJur;
        cdsCtaRec.FieldByName('CTR_VALCOR').AsFloat := arrDocsAgrupar[LContador].fltValCor;
        cdsCtaRec.Post;
      End;
    End;
  Finally
    cdsCtaRec.First;
    cdsCtaRec.EnableControls;
  End;
end;

procedure TfrmAgrupDuplicatas.grdDuplicatasDBTableView1ColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;

  If grdDuplicatasDBTableView1.DataController.DataSet.Active Then
     fGetFuncoesCxGrid.pSalvarView(grdDuplicatasDBTableView1,
                                   Self.Name + '.' + grdDuplicatasDBTableView1.Name,
                                   grdDuplicatasDBTableView1.DataController.DataSet);

end;

procedure TfrmAgrupDuplicatas.grdDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean );
var
  strValor: String;
begin
  inherited;

  strValor := VarAsType(grdDuplicatasDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ grdDuplicatasDBTableView1CTR_MARDES.Index], varString);

  If strValor = 'M' Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmAgrupDuplicatas.grdDuplicatasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
 If cdsCtaRec.IsEmpty Then
    Exit;
 (*
  If fAgrupandoNotasAvulsas Then
    Exit;

  pSelecionaDuplicata;
  pSetFocus(Self);
  *)
  If Not blnF11 Then
    pSelecionaDataVencimento
  Else
    fMensagem('ATENÇÃO', 'É necessário que agrupe todas as duplicatas de créditos!', ['&OK']);

end;

procedure TfrmAgrupDuplicatas.grdDuplicatasDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
 If (Key = VK_Escape) Then
  Begin
    If fAgrupandoNotasAvulsas Then
      Close;

    If fPermiteFecharAgrupF11 Then
      Exit;

    pLimpaDados(chkLimFil.Checked);
    pLimpaGrid;
    pSetFocus(edtCodEmp);

    if Length(arrDocumentos) > 0 then
      Close;
  End;

  If cdsCtaRec.IsEmpty Then
    Exit;

  {*****************************************}
  {* MARCA / DESMARCA CHEQUE               *}
  {**************************************MV*}
  If (Key = VK_Return) Then
    pSelecionaDataVencimento;
end;

function TfrmAgrupDuplicatas.LiberaRecalculoJuros(APerJur, APerMul: Double;
  AAplJur: String; AConfirma: Boolean): Boolean;
Var
  LObjLiberacao : TLiberacao;
  LObjTabela    : TRegistroMsgLiberaTabela;
  LObjLinha     : TLinhaMsgLibera;
  LNivel2     : Boolean;
  LNivel3     : Boolean;
  LSenJM2     : String;
  LSenJM3     : String;
  LSumValDup  : Double;
  LSumValCor  : Double;
  LConfirma   : Boolean;
begin
  LConfirma := AConfirma;;

  LObjLiberacao := TLiberacao.Create;

  Try
    CalculaJuros(APerJur, APerMul, AAplJur);

    LObjLiberacao.Clear;
    LObjLiberacao.objMsgLibera.pAddQuebra;
    LObjLiberacao.objMsgLibera.pAddSeparador(125);
    If fCfgSis('SENJM1') <> '' Then
      LObjLiberacao.objMsgLibera.pAddTexto('JUROS MENOR QUE O PERMITIDO', alCentro, teAmbos, '',125)
    else
      LObjLiberacao.objMsgLibera.pAddTexto('ACESSO AO RECÁLCULO DE JUROS', alCentro, teAmbos, '',125);


    LObjTabela := TRegistroMsgLiberaTabela.Create;

    LObjLinha  := TLinhaMsgLibera.Create;
    LObjLinha.enuTipoLinha := tlCabecalho;
    LObjLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
    LObjLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
    LObjLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
    LObjLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
    LObjLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
    LObjLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
    LObjLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
    LObjTabela.lstLinhas.Add(LObjLinha);

    LSumValDup := 0;
    LSumValCor := 0;

    If (AAplJur = 'T') Then
      cdsCtaRec.First;

    While Not cdsCtaRec.Eof Do
    Begin
      If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
      Begin
        cdsCtaRec.Next;
        Continue;
      End;

      LObjLinha  := TLinhaMsgLibera.Create;
      LObjLinha.enuTipoLinha := tlValor;
      LObjLinha.pAddColuna('DOCUMENTO'       ,  fPadR(cdsCtaRec.FieldByName('NRODUP').AsString,12)
                                              + cdsCtaRec.FieldByName('PARDUP').AsString + '-'
                                              + cdsCtaRec.FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
      LObjLinha.pAddColuna('EMP'             ,  cdsCtaRec.FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
      LObjLinha.pAddColuna('CLIENTE'         ,  cdsCtaRec.FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
      LObjLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
      LObjLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
      LObjLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
      LObjLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(cdsCtaRec.FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
      LObjTabela.lstLinhas.Add(LObjLinha);

      LSumValDup := LSumValDup + cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat;
      LSumValCor := LSumValCor + cdsCtaRec.FieldByName('CTR_VALCOR').AsFloat;

      If (AAplJur = 'T') Then
        cdsCtaRec.Next
      Else
        Break;
    End;

    LObjLinha  := TLinhaMsgLibera.Create;
    LObjLinha.enuTipoLinha := tlTotal;
    LObjLinha.pAddColuna(''                , 'TOTAIS'                                 , 89 , alDireita, teAutcom );
    LObjLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(LSumValDup, ffNumber, 9, 2) , 13 , alDireita  );
    LObjLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(LSumValCor, ffNumber, 9, 2) , 16 , alDireita  );
    LObjTabela.lstLinhas.Add(LObjLinha);

    LObjLiberacao.objMsgLibera.lstRegistros.Add(LObjTabela);

    LObjLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', FloatToStrF(APerJur, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
    LObjLiberacao.objMsgLibera.pAddSeparador(125);

    LNivel2 := (APerJur < fCfgSis('JURMN1', varDouble)) And (APerJur >= fCfgSis('JURMN2', varDouble));
    LSenJM2 := fCfgSis('SENJM2');

    LNivel3 := APerJur < fCfgSis('JURMN2', varDouble);
    LSenJM3 := fCfgSis('SENJM3');

    If (fCfgSis('SENJM1') <> '') And (APerJur < fCfgSis('JURMN1', varDouble)) Then
    begin
      LObjLiberacao.strDirAce := 'SENJM1';
      LObjLiberacao.strSenLib := fCfgSis('SENJM1');
      LObjLiberacao.strMsgSen := 'Recalcular Juros';
      LObjLiberacao.strCodOpe := strLoginUsuarioLogado;
      LObjLiberacao.strDirAceNv2 := 'SENJM2';
      LObjLiberacao.strSenLibNv2 := LSenJM2;
      LObjLiberacao.blnNivel2 := LNivel2;
      LObjLiberacao.strDirAceNv3 := 'SENJM3';
      LObjLiberacao.strSenLibNv3 := LSenJM3;
      LObjLiberacao.blnNivel3 := LNivel3;
      LObjLiberacao.objMsgLibera.strTitulo := 'O valor de juros é menor que o permitido.';

      LConfirma := LObjLiberacao.fLibera;

      If LConfirma Then
         objLogLibRec.pInsereLogLigTMP( LObjLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

    End
    Else If (fCfgSis('SENJM1') = '') Or
            ((fCfgSis('JURMN1', varDouble) <= 0) Or
             (fCfgSis('JURMN1', varString) = '')) Then
    Begin

      LObjLiberacao.strDirAce := 'CTRSJU';
      LObjLiberacao.strSenLib := fCfgSis('SENJUR');
      LObjLiberacao.strMsgSen := 'Recalcular Juros';
      LObjLiberacao.strCodOpe := strLoginUsuarioLogado;
      LObjLiberacao.objMsgLibera.strTitulo := 'Permitir recálculo de juros no recebimento.';

      LConfirma := LObjLiberacao.fLibera;

      If LConfirma Then
         objLogLibRec.pInsereLogLigTMP( LObjLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

    End;

    Result := LConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '');
    End;
  End;
end;

procedure TfrmAgrupDuplicatas.btnCarrTitulosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');
  pCalculaTotalDuplicatas(edtTotalDup, False);
  pCalculaTotalDuplicatas(edtTotalSelecionado, True);
    If cdsCtaRec.Active Then
    pSetFocus(grdDuplicatas)

  Else
    pSetFocus(edtCodEmp);
end;

procedure TfrmAgrupDuplicatas.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAgrupDuplicatas.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);

  If cdsCtaRec.Active Then
    pSetFocus(grdDuplicatas)

  Else
    pSetFocus(edtCodEmp);
end;

procedure TfrmAgrupDuplicatas.btnMarcaClick(Sender: TObject);
begin
  if cdsCtaRec.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&OK']);
    Exit;
  end;

  if (intTotalMarcado <= 0) And (TBitBtnLocked(Sender).Name = 'btnDesmarca') then
  begin
    fMensagem('','É necessário selecionar ao menos uma duplicata para desmarcar!',['&O K']);
    Exit;
  end;

  If fAgrupandoNotasAvulsas Then
    Exit;

  If blnF11 Then
  Begin
    If (TBitBtnLocked(Sender).Name = 'btnDesmarca') Or
       (TBitBtnLocked(Sender).Name = 'btnMarca')    Then
    Begin
      If (Not TBitBtnLocked(Sender).Visible) Then
        Exit;
    End;
  End;

  acaoMarca := TBitBtnLocked(Sender).Name;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  if acaoMarca = 'btnMarca' then
    frmGravando.lblGravando.Caption := 'Aguarde... Checando e Marcando Duplicatas'
  else
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Duplicatas';

  frmGravando.ShowModal;

  acaoMarca := '';
end;

procedure TfrmAgrupDuplicatas.btnObsCliClick(Sender: TObject);
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
  Begin
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.pMostraObsCliente(cdsCtaRec.FieldByName('CTR_CODCLI').AsString,False);
  End
  Else
    fMensagem('','Selecione um cliente para consultar a Observação!',['&O k']);

End;

procedure TfrmAgrupDuplicatas.btnRecalculaJurosClick(Sender: TObject);
Var
  frmCtrRecalculoJuros : TfrmCtrRecalculoJuros;
begin
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;

  Try
    pCriarFormularios(TfrmCtrRecalculoJuros, frmCtrRecalculoJuros);

    Try
      frmCtrRecalculoJuros.edtPerJur.Text := FloatToStrF(fCfgSis('JURAGR', varDouble), ffFixed, 12, 2);
      frmCtrRecalculoJuros.blnPerMulta := True;
      frmCtrRecalculoJuros.ShowModal;

      FDicBaixa.AddOrSetValue('fltPerJur',   frmCtrRecalculoJuros.edtPerJur.Text);
      FDicBaixa.AddOrSetValue('strAplJur',   frmCtrRecalculoJuros.edtAplJur.Text);
      FDicBaixa.AddOrSetValue('fltPerMul',   frmCtrRecalculoJuros.edtPerMul.Text);
      FDicBaixa.AddOrSetValue('blnConfirma', frmCtrRecalculoJuros.blnConfirma);
    Finally
      pFreeAndNil(frmCtrRecalculoJuros);
    End
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  TfrmGravando.fExecutarModal(RecalculaJuros,'Aguarde... Recalculando Juros.','');
end;

procedure TfrmAgrupDuplicatas.btnRegraAgrupClick(Sender: TObject);
var
  AMensagem: String;
begin
  inherited;
  AMensagem := #13#10 +
               'Duplicatas que não podem ser agrupadas:                 ' + #13#10 +
               ' - Enviadas para o Banco.                               ' + #13#10 +
               ' - Já recebidas.                                        ' + #13#10 +
               ' - Boleto impresso.                                     ' + #13#10 +
               ' - Com Pix gerado e ativo;                              ' + #13#10;

  if ((AFormVeio = 'AGRUPAMENTO')) or
     ((AFormVeio = 'ACERTO') And (fCfgSis('ESPACE') = 'S')) Then
  begin
    AMensagem := AMensagem +
                 '- Com espécies NF, IF, NS, NV, IV, EL ou EV não podem ' + #13#10 +
                 '  ser agrupadas com outras espécies de duplicatas' +
                 IIF(RotinaAgrupaCreditos, ', exceto CC', '') + '.        ';
  End;


  fMensagem('Regras de Agrupamento', AMensagem, ['&Ok'], 1, False, 2, 0, False,0,False,False,False,260);
end;

function TfrmAgrupDuplicatas.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    intRecNo : Integer;
    blnLckok : Boolean;
    prcScroll: TprcScroll;

    LDuplicataPixGerado: Boolean;
begin
  stlLisSel.Clear;
  LDuplicataPixGerado := False;

  With cdsCtaRec Do
  Begin
    If Not cdsCtaRec.Active Then
      cdsCtaRec.Active := True;

    pDisableControls(cdsCtaRec, prcScroll);
    intRecNo := RecNo;

    blnLckok  := False;

    First;
    pgbStatus.Properties.Max := cdsCtaRec.RecordCount;
    While Not Eof Do
    Begin
      pStep(pgbStatus);
     {**************************************************}
      {* TRATAMENTO DE TRAVA / LIBERAÇÃO DOS DOCUMENTO .*}
      {***********************************************MA*}
      If acaoMarca = 'btnDesmarca' Then
      Begin
        blnMarcar := False;
        blnLckok  := fControleTrava;
      End
      Else
      Begin
        If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          LDuplicataPixGerado := True;

          cdsCtaRec.Next;
          Continue;
        End;

        If FieldByName('CTR_MARDES').AsString <> 'M' Then
        Begin
          blnMarcar := True;
          blnLckok  := fControleTrava;
        End
        Else
          blnLckok  := True;
      End;

      If blnLckok Then
      Begin
        Result := fMarcaDuplicata(acaoMarca = 'btnMarca');
        If Not Result Then
          Break;
      End;

      Next;
    End;

    RecNo := intRecNo;
    pEnableControls(cdsCtaRec, prcScroll);
  End;

  If stlLisSel.Count > 0 Then
  Begin
    If Not blnF11 Then
      fMensagem('ATENÇÃO!', 'Os documentos abaixo não foram marcados pois estão sendo utilizados por outra estação: ' + #13#10 + stlLisSel.Text, ['&Ok'])
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Os documentos abaixo não foram marcados pois ' +
                            'estão sendo utilizados por outra estação: ' + #13#10 + stlLisSel.Text, ['&Ok']);

      If Assigned(objParcelamento) Then
        blnFecharForm := True;

      taAgrupouF11 := taAviso;
      blnF11 := False;
      blnFecharForm := True;
    End;
  End;

  If LDuplicataPixGerado Then
    fMensagem('ATENÇÃO!', 'Alguns documentos não foram selecionados pois possuem Pix gerados e ativos.', ['&Ok']);

  pCalculaTotalDuplicatas(edtTotalSelecionado, True);
  result := True;
end;

procedure TfrmAgrupDuplicatas.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmAgrupDuplicatas.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False,fCfgSis('EMPAGR', varBoolean)) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAgrupDuplicatas.fChamaDesconto(strCodCli, strCodEmp, strNomCli: String; fltTotCli: Double):Boolean;
  Var
    strValDes: String;
begin
  Result := True;

  If fltTotCli = 0 Then
    Exit;

  {*******************************************}
  {* CHAMA O FORM DE DESCONTO                *}
  {****************************************AC*}
  Try
    pCriarFormularios(TfrmDigDesconto, frmDigDesconto);
    frmDigDesconto.lblCliente.Caption := strCodCli + ' - ' + strNomCli;
    frmDigDesconto.edtTotGer.Text := FloatToStrF(fltTotCli, ffNumber, 12, 2);
    frmDigDesconto.blnPermiteAcrescimo := True;
    frmDigDesconto.blnAgrDup := True;
    frmDigDesconto.cdsDupSel := cdsCtaRec;
    frmDigDesconto.ShowModal;

    If frmDigDesconto.ModalResult = mrOk Then
    Begin
      strValDes := IIF(fEmptyStr(frmDigDesconto.edtDesEsp.Text),'0,00',frmDigDesconto.edtDesEsp.Text);
      strValDes := FloatToStrF(fStrToFloat(strValDes), ffNumber, 12, 2);
    End
    Else
    Begin
      strValDes := '0,00';
      Result    := False;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      strValDes := '0,00';
      pMensagensErro(E.Message, '[frmAgrupDuplicatas.fChamaDesconto]');
    End;
  End;
  pFreeAndNil(frmDigDesconto);

  {*******************************************}
  {* CHAMA O DESCONTO SE HOUVER              *}
  {****************************************AC*}
  If fStrToFloat(strValDes) <> 0 Then
  Begin
    If Not fAtualizaValoresTemporaria(strCodCli, strCodEmp, FloatToStrF(fltTotCli, ffNumber, 12, 2), strValDes, 'D') Then
      Result := False;
  End;
end;

procedure TfrmAgrupDuplicatas.pRetornaTotal(strCodCli, strCodEmp: String; Var fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre: Double; strParcela: String = '');
  Var
    cdsGen: TUniClientDataSet;
    fldTotCli, fldTotIPI, fldTotRet, fldTotAce, fldTotFre: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldTotCli := fCriaAggregateField(cdsGen, 'FLDTOTCLI', 'SUM(CTR_VALCOR)', '#,##0.00');
  fldTotIPI := fCriaAggregateField(cdsGen, 'FLDTOTIPI', 'SUM(CTR_VALIPI)', '#,##0.00');
  fldTotRet := fCriaAggregateField(cdsGen, 'FLDTOTRET', 'SUM(CTR_VALRET)', '#,##0.00');
  fldTotAce := fCriaAggregateField(cdsGen, 'FLDTOTACE', 'SUM(CTR_VALACE)', '#,##0.00');
  fldTotFre := fCriaAggregateField(cdsGen, 'FLDTOTFRE', 'SUM(CTR_VALFRE)', '#,##0.00');

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;
    Filtered := False;
    Filter := '';
    Filter := Filter + 'CTR_MARDES = ''M'' AND ';
    Filter := Filter + 'CTR_CODCLI = ' + QuotedStr(strCodCli);
    If Not fEmptyStr(strParcela) Then
      Filter := Filter + ' AND PARDUP = ' + QuotedStr(strParcela);
    If (fCfgSis('AGRTPR', varInteger) = 3) Then
      Filter := Filter + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
    Filtered := True;

    AggregatesActive := True;
    fltTotCli := IIF(fldTotCli.Value = Null, 0, fldTotCli.Value);
    fltTotIPI := IIF(fldTotIPI.Value = Null, 0, fldTotIPI.Value);
    fltTotRet := IIF(fldTotRet.Value = Null, 0, fldTotRet.Value);
    fltTotAce := IIF(fldTotAce.Value = Null, 0, fldTotAce.Value);
    fltTotFre := IIF(fldTotFre.Value = Null, 0, fldTotFre.Value);
  End;

  FreeAndNil(cdsGen);
end;

procedure TfrmAgrupDuplicatas.pRetornaTotalReforma(const strCodCli, strCodEmp: String; Var fltTotCbs, fltTotIbs, fltTotIs: Double);
  Var
    cdsGen: TUniClientDataSet;
    fldTotCbs, fldTotIbs, fldTotIs: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  Try
    fldTotCbs := fCriaAggregateField(cdsGen, 'FLDTOTCBS', 'SUM(CTR_VALCBS)', '#,##0.00');
    fldTotIbs := fCriaAggregateField(cdsGen, 'FLDTOTIBS', 'SUM(CTR_VALIBS)', '#,##0.00');
    fldTotIs  := fCriaAggregateField(cdsGen, 'FLDTOT_IS', 'SUM(CTR_VAL_IS)', '#,##0.00');

    With cdsGen Do
    Begin
      Data := cdsCtaRec.Data;
      Filtered := False;
      Filter := '';
      Filter := Filter + 'CTR_MARDES = ''M'' AND ';
      Filter := Filter + 'CTR_CODCLI = ' + QuotedStr(strCodCli);
      If (fCfgSis('AGRTPR', varInteger) = 3) Then
        Filter := Filter + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
      Filtered := True;

      AggregatesActive := True;
      fltTotCbs := IIF(fldTotCbs.Value = Null, 0, fldTotCbs.Value);
      fltTotIbs := IIF(fldTotIbs.Value = Null, 0, fldTotIbs.Value);
      fltTotIs  := IIF(fldTotIs.Value = Null, 0, fldTotIs.Value);
    End;
  Finally
    FreeAndNil(cdsGen);
  End;
end;

function TfrmAgrupDuplicatas.fAgrupandoNotasAvulsas: Boolean;
begin
  Result := Length(arrDocsAgrupar) > 0;
end;

function TfrmAgrupDuplicatas.fAtualizaValoresTemporaria(strCodCli, strCodEmp, strTotCli, strValor: String; strAcrDes: String):Boolean;
  Var
    fltTotTmp: Double;
    fltTmpVal: Double;
    fltTmpDup: Double;
    fltAux: Double;
    intRecNo: Integer;
begin
  Result   := True;
  intRecNo := -1;

  With cdsCtaRec Do
  Begin
    Try
      DisableControls;
      intRecNo := RecNo;

      Filtered := False;
      Filter := '';
      Filter := Filter + 'CTR_MARDES = ''M'' AND ';
      Filter := Filter + 'CTR_CODCLI = ' + QuotedStr(strCodCli);
      If (fCfgSis('AGRTPR', varInteger) = 3) Then
        Filter := Filter + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
      Filtered := True;

      First;
      fltTotTmp := 0;

      While Not Eof Do
      Begin
        Edit;
        fltAux := fFormataFloat((fStrToFloat(FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 12, 2)) /
                                 fStrToFloat(strTotCli)) * fStrToFloat(strValor), 2);

        If strAcrDes = 'D' Then
        Begin
          FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALCOR').AsFloat - fltAux;
          FieldByName('CTR_VALDES').AsFloat := fltAux;
        End
        Else If strAcrDes = 'A' Then
        Begin
          FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALCOR').AsFloat + fltAux;
          FieldByName('CTR_JURREP').AsFloat := fltAux;
        End;

        Post;

        {**************************************}
        {* VERIFICA DIFERENÇA DE CENTAVOS     *}
        {***********************************AF*}
        fltTotTmp := fltTotTmp + fltAux;
        Next;
      End;

      If fFormataFloat(fltTotTmp, 2) <> fFormataFloat(fStrToFloat(strValor), 2) Then
      Begin
        fltTmpVal := fFormataFloat(fStrToFloat(strValor), 2) - fFormataFloat(fltTotTmp, 2);
        If (fFormataFloat(fltTotTmp, 2) < fFormataFloat(fStrToFloat(strValor), 2)) And (strAcrDes='A') Then
          fltTmpDup := fltTmpVal
        Else
          fltTmpDup := fFormataFloat(fltTotTmp, 2) - fFormataFloat(fStrToFloat(strValor), 2);

        If fFormataFloat(fltTmpVal, 2) <> 0 Then
        Begin
          First;
          Edit;
          FieldByName('CTR_VALCOR').AsFloat := fltTmpDup + FieldByName('CTR_VALCOR').AsFloat;

          If strAcrDes = 'D' Then
            FieldByName('CTR_VALDES').AsFloat := fltTmpVal + FieldByName('CTR_VALDES').AsFloat

          Else If strAcrDes = 'A' Then
            FieldByName('CTR_JURREP').AsFloat := fltTmpVal + FieldByName('CTR_JURREP').AsFloat;

          Post;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.fAtualizaValoresTemporaria]');
      End;
    End;

    Filtered := False;
    Filter := '';
    RecNo := intRecNo;
    EnableControls;
  End;
end;

procedure TfrmAgrupDuplicatas.FormDestroy(Sender: TObject);
begin
  pLiberaDupsMarcadas;

  inherited;

  setLength(arrDupAgr, 0);
  stlLisSel.Clear;
  stlLisSel.Free;
  FreeAndNil(stlAutIncDupMar);
  FreeAndNil(objLock);

  If Assigned(objLogLibRec) Then
    FreeAndNil(objLogLibRec);
end;

procedure TfrmAgrupDuplicatas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F7) Then
  Begin
    btnMarca.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarca.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F2) Then
  Begin
    btnObsCli.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnContaCorrente.Click;
  End
  Else If (Key = VK_F11) Then
  Begin
    btnRecalculaJuros.Click;
  End;
end;

procedure TfrmAgrupDuplicatas.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
  Begin
    pFecharTelaAgrupandoNotasAvulsas;
  End;
end;


procedure TfrmAgrupDuplicatas.FormShow(Sender: TObject);
var
  intRecNo : Integer;

begin
  inherited;
  blnShowMenu := False;
  If fAgrupandoNotasAvulsas Then
  Begin
    btnMarca.Visible := False;
    btnDesmarca.Visible := False;
    pnlCabecalho.Visible := False;

    TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');
    acaoMarca := 'btnMarca';
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fMarcarTodas;
    frmGravando.lblGravando.Caption := 'Aguarde... Checando e Marcando Notas Avulsas';
    frmGravando.ShowModal;

    pSetFocus(grdDuplicatas);
  End
  Else If blnF11 Then
  Begin
    pnlCabecalho.Enabled := False;
    btnMarca.Visible     := False;
    btnDesmarca.Visible  := False;

    If fValidaCampos(edtCodCli, False) Then
      btnCarrTitulos.Click;

    acaoMarca := 'btnMarca';
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fMarcarTodas;
    frmGravando.lblGravando.Caption := 'Aguarde... Checando e Marcando Duplicatas';
    frmGravando.ShowModal;
  End
  Else If Length(arrDocumentos) > 0 Then
  Begin
    pnlCabecalho.Enabled := False;
    pnlCabecalho.Visible := False;

    TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');
    btnMarca.Click;
    // pMarcarTodosDocs;

    pSetFocus(grdDuplicatas);
    pCalculaTotalDuplicatas(edtTotalDup, False);
    pCalculaTotalDuplicatas(edtTotalSelecionado, True);

  End
  Else
  Begin
    blnShowMenu := True;
    fGetFuncoesCxGrid.fCarregarView(grdDuplicatasDBTableView1, Self.Name + '.' + grdDuplicatasDBTableView1.Name, grdDuplicatasDBTableView1.DataController.DataSet, intRecNo);

    {*********************************************************************************************}
    {* FEITO ESSE TRATAMENTO POR CAUSA QUE É GRAVADO AS POSIÇÕES DAS COLUNAS NA TABELA 'CFGCOL'. *}
    {* QUANDO O CAMPO É UM CAMPO NOVO NO GRID, ESSE TRATAMENTO POSICIONA A COLUNA AONDE **********}
    {* INICIALMENTE TEM QUE ESTAR. ***************************************************************}
    {*REQ*140605*******************************************************************************MO*}
    if grdDuplicatasDBTableView1CTR_CODCLI.Visible = False then
    begin
      grdDuplicatasDBTableView1CTR_CODCLI.Index   := grdDuplicatasDBTableView1CTR_NOMCLI.Index;
      grdDuplicatasDBTableView1CTR_CODCLI.Visible := True;
    end;

    If Not fCfgSisL('USACND', varBoolean) Then
    Begin
      lblPeriodo.Top  := lblCndPag.Top;
      lblPeriodoa.Top := lblCndPag.Top;
      mskDtaIni.Top   := edtCodCnd.Top;
      mskDtaFin.Top   := edtCodCnd.Top;
      rdbDtaCad.Top   := edtCodCnd.Top + 3;
      rdbDtaVen.Top   := edtCodCnd.Top + 3;
      btnCarrTitulos.Top := mskDtaFin.Top + 2;

      pnlCabecalho.Height := pnlCabecalho.Height - edtCodCnd.Height;

      lblCndPag.Visible := False;
      edtCodCnd.Visible := False;
      edtDesCnd.Visible := False;
    End;


  End;
  intTotalMarcado := 0;
  pUtilizaRotinaProjeto;
  if blnShowMenu then
  begin
    pSetFocus(edtCodCli);
    blnShowMenu := False;
  end;

end;

{function TfrmAgrupDuplicatas.fVerificaExiste(strCodCli: String): Boolean;
  Var
    cdsGen: TUniClientDataSet;
Begin
  Result := True;
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M') + ' AND CTR_CODCLI = ' + QuotedStr(strCodCli));
  With cdsGen Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If Not fExisteDuplicata(FieldByName('NRODUP').AsString,
                              FieldByName('PARDUP').AsString,
                              FieldByName('CTR_ESPDOC').AsString,
                              FieldByName('CTR_CODEMP').AsString,
                              FieldByName('CTR_CODCLI').AsString,
                              FieldByName('CTR_SEQBAI').AsInteger) Then
      Begin
        Result := False;
        Break;
      End;

      Next;
    End;
    EnableControls;
  End;

  FreeAndNil(cdsGen);
End;}


function TfrmAgrupDuplicatas.fVerificaExiste: Boolean;
  Var
    cdsGen: TUniClientDataSet;
Begin
  Result := True;
  FDuplicatasJagrupadas := '';
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If Not fExisteDuplicata(FieldByName('NRODUP').AsString,
                              FieldByName('PARDUP').AsString,
                              FieldByName('CTR_ESPDOC').AsString,
                              FieldByName('CTR_CODEMP').AsString,
                              FieldByName('CTR_CODCLI').AsString,
                              FieldByName('CTR_SEQBAI').AsInteger) Then
      Begin
        Result := False;
        FDuplicatasJagrupadas := cdsGen.FieldByName('CTR_NUMDUP').AsString;
        Break;
      End;

      Next;
    End;
    EnableControls;
  End;

  FreeAndNil(cdsGen);
End;

function TfrmAgrupDuplicatas.fVerificaParcelasMarcadas: Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, cdsCtaRec);

  cdsClone.Filter := 'NRODUP='     + QuotedStr(cdsCtaRec.FieldByName('NRODUP').AsString) + ' AND ' +
                     'CTR_CODEMP=' + QuotedStr(cdsCtaRec.FieldByName('CTR_CODEMP').AsString) + ' AND ' +
                     'CTR_CODCLI=' + QuotedStr(cdsCtaRec.FieldByName('CTR_CODCLI').AsString) + ' AND ' +
                     'CTR_ESPDOC=' + QuotedStr(cdsCtaRec.FieldByName('CTR_ESPDOC').AsString) + ' AND ' +
                     'PARDUP<>'    + QuotedStr(cdsCtaRec.FieldByName('PARDUP').AsString) + ' AND ' +
                     'CTR_MARDES=' + QuotedStr('M');
  cdsClone.Filtered := True;

  Result := (Not cdsClone.IsEmpty);

  FreeAndNil(cdsClone);
end;

function TfrmAgrupDuplicatas.fExisteDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
  Var
    strSQL: String;
    qryGenRec: TUniQuery;

begin
  Try
    qryGenRec := fCriaQuery;

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(VALOR) AS VALOR FROM (' + strSQL + ') AS TMP');
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If FieldByName('VALOR').AsInteger <> 0 Then
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryGenRec);
  End;
End;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmAgrupDuplicatas.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtNomPor, arrPortador, nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAgrupDuplicatas.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtNomPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
  Begin
    If (fValidaCampos(edtCodPor, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatas.edtCodPrjExit(Sender: TObject);
begin
  inherited;
   pEdtCodSelectExit(edtCodPrj, edtDesPrj, arrPrj, fRetNomeProjeto, Nil, 'do Projeto');
end;

procedure TfrmAgrupDuplicatas.edtCodPrjKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, nil, Key, arrPrj,False) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatas.edtCodvenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVen,  fRetNomeOperador, nil, 'do Vendedor');
end;

procedure TfrmAgrupDuplicatas.edtCodvenKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtNomVen, qryConVen, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAgrupDuplicatas.fAplicaTaxaJurosAgrupamento(strCodCli, strCodEmp, strCodCnd, strConPag: String; fltTotAgr: Double): Boolean;
  var
    fltTxJCnd: Double;
    fltTaxVpr: Double;
    fltValJur: Double;
begin
  Result := True;

  If Not fCfgSis('SISCRE', varBoolean) Then
    Exit;

  fltTxJCnd := fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [strCodCnd]);

  fltTaxVpr := fCalculaTaxVpr(strConPag, fltTxJCnd);

  fltValJur := fFormataFloat(fltTotAgr * ( fltTaxVpr / 100 ), 2);

  If fltValJur > 0 Then
    Result := fAtualizaValoresTemporaria(strCodCli,
                                         strCodEmp,
                                         FloatToStrF(fltTotAgr, ffNumber, 12, 2),
                                         FloatToStrF(fltValJur, ffNumber, 12, 2),
                                         'A');
end;

procedure TfrmAgrupDuplicatas.pCalculaValorCorrigido;
  Const
    fltTaxMulta = 9999;
    intTolerancia = 0;
  var
    fltTaxJurAgr: Double;
    intInd: Integer;

  function fRetIndDocumentos: Integer;
    Var
      intCont: Integer;
  Begin

    Result := -1;

    For intCont := 0 To Length(arrDocumentos)-1 Do
    Begin

      If (arrDocumentos[intCont].strNumDup = cdsCtaRec.FieldByName('NRODUP').AsString) And
         (arrDocumentos[intCont].strEspDoc = cdsCtaRec.FieldByName('CTR_ESPDOC').AsString) And
         (arrDocumentos[intCont].strParcel = cdsCtaRec.FieldByName('PARDUP').AsString) And
         (arrDocumentos[intCont].strCodEmp = cdsCtaRec.FieldByName('CTR_CODEMP').AsString) And
         (arrDocumentos[intCont].strCodCli = cdsCtaRec.FieldByName('CTR_CODCLI').AsString) Then
      Begin
        Result := intCont;
        Break;
      End;

    End;
  End;

begin
  fltTaxJurAgr := fCfgSis('JURAGR', varDouble);

  With cdsCtaRec Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      intInd := fRetIndDocumentos;

      Edit;
      If intInd > -1 Then
      Begin
        FieldByName('CTR_JURATR').AsFloat := arrDocumentos[intInd].fltValJur +
                                             arrDocumentos[intInd].fltValMul;

        FieldByName('CTR_VALCOR').AsFloat := arrDocumentos[intInd].fltValCor;
      End
      Else
      Begin
        If FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
        Begin
          FieldByName('CTR_JURATR').AsFloat := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                                   FieldByName('CTR_VALDUP').AsFloat,
                                                                   fltTaxJurAgr,
                                                                   fltTaxMulta,
                                                                   intTolerancia);

          FieldByName('CTR_VALCOR').AsFloat := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat +
                                                             FieldByName('CTR_JURATR').AsFloat, 2);
        End
        Else
          FieldByName('CTR_VALCOR').AsFloat := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat, 2);
      End;
      Post;
      Next;
    End;

    First;
    EnableControls;
  End;

end;

procedure TfrmAgrupDuplicatas.pSelecionaDataVencimento;
  Var
    frmAltDtaVenc : TfrmAltDtaVenc;
begin

  If fAgrupandoNotasAvulsas Then
    Exit;

  If blnF11 Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário que agrupe todas as duplicatas de créditos!', ['&OK']);
    Exit;
  End;

  If fCfgSis('VENAGR', varBoolean) Then
  BEGIN
    If cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M' Then
    Begin
      Try
        pCriarFormularios(TfrmAltDtaVenc, frmAltDtaVenc);
        frmAltDtaVenc.mskDtaVen.Text := cdsCtaRec.FieldByName('CTR_DTAVEN').AsString;
        frmAltDtaVenc.ShowModal;

        If frmAltDtaVenc.blnConfirma = True Then
        Begin
          pAtualizaDtaVenc(frmAltDtaVenc.dtaDtaVen);
          pSelecionaDuplicata;
          pSetFocus(Self);
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.grgDuplicatasKeyDown]');
      End;

      pFreeAndNil(frmAltDtaVenc);
    End
    Else
    Begin
      pSelecionaDuplicata;
      pSetFocus(Self);
    End;
  END
  ELSE
  BEGIN
    pSelecionaDuplicata;
    pSetFocus(Self);
  END;

end;

function TfrmAgrupDuplicatas.fLiberarAgrupDupCtr(
  ADuplicatas: TUniClientDataSet): Boolean;
Var
  sumValDup,
  sumValCor    : Double;
  objLiberacao : TLiberacao;
  objTabela    : TRegistroMsgLiberaTabela;
  objLinha     : TLinhaMsgLibera;
  APrazoMedio  : Integer;
begin
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  objLiberacao := TLiberacao.Create;

  APrazoMedio := fCfgSis('PRZCND', varInteger);
  Try
    With ADuplicatas Do
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(125);
      objLiberacao.objMsgLibera.pAddTexto(
        'A CONDIÇÃO DE PAGAMENTO SELECIONADA É MAIOR QUE O PRAZO MÉDIO CONFIGURADO: '+
        IntToStr(APrazoMedio) + ' DIAS.', alCentro, teAmbos, '',125);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      sumValDup := 0;
      sumValCor := 0;

      First;
      While Not Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('NRODUP').AsString,12)
                                               + FieldByName('PARDUP').AsString + '-'
                                               + FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
        objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
        objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
        objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
        objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        sumValDup := sumValDup + FieldByName('CTR_VALDUP').AsFloat;
        sumValCor := sumValCor + FieldByName('CTR_VALCOR').AsFloat;

        Next;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''                , 'TOTAIS'                                , 89 , alDireita, teAutcom );
      objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
      objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 16 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


      objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', '', 25 , alDireita, teAmbos, '', 6);
      objLiberacao.objMsgLibera.pAddSeparador(125);
    End;

    objLiberacao.strDirAce := 'CTRPADPMM';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Agrupa Duplicatas Ctr';
    objLiberacao.objMsgLibera.strTitulo := 'Permitir agrupar duplicatas com prazo médio maior que o configurado.';

    Result := objLiberacao.fLibera;

    if Result then
    Begin
      objLiberacao.strCodOpe := objLiberacao.strOperador;
      objLogLibRec.pInsereLogLigTMP(objLiberacao, ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                                    ADuplicatas.FieldByName('CTR_ESPDOC').AsString,
                                    ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                                    Self.Name);
      SetLength(arrLogLib, Length(arrLogLib) - 1);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '');
    End;
  End;
  Screen.Cursor := crDefault;
end;

function TfrmAgrupDuplicatas.fListaAutoincremClientes: TStringList;
Var
  cdsGen: TUniClientDataSet;
Begin

  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin
    DisableControls;
    Result            := TStringList.Create;
    Result.Duplicates := dupIgnore;
    Result.Clear;
    First;
    While Not Eof Do
    Begin
      Result.Add(FieldByName('CLI_AUTOIN').AsString);
      Next;
    End;
    EnableControls;
  End;

  FreeAndNil(cdsGen);
End;

  {*****************************************
  {* CRIA UM STRING LIST COM OS AUTOINCREM *}
  {* DOS CLIENTES SELEC. NAS DUPLICATAS    *}
  {**************************************MA*}
procedure TfrmAgrupDuplicatas.pImpEtiquetasMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    qryCfgRel  : TUniQuery;
    qryImpEti  : TUniQuery;
begin
  intColAtu := 1;
  qryCfgRel := fCriaQuery(Self);
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If (qryCfgRel.FieldByName('REL_IDEIMP').AsString <> 'M') Or (Not fVerificaImpressora(strNomImp)) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  Try
    qryImpEti := fCriaQuery(Self);

    With qryImpEti Do
    Begin
      intQtdTopo := fRetTopoEtiqueta('CLI');

      For intContador := 1 to intQtdTopo Do
      Begin
        pEscreveLinha(untFuncMacro.strArqTxt, ' ', False, strNomImp, strNomPro, strDesPro);
      End;

      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLCli);
      Open;

      First;
      While Not Eof Do
      Begin
        Application.ProcessMessages;
        pAtualizaCamposUso(qryImpEti);
        Application.ProcessMessages;
        pImpRegistro(qryImpEti);
        Application.ProcessMessages;
        Next;
      End;

      {**********************************************************************************}
      {* É NECESSARIO CHAMAR ESSA PROCEDURE NESSE PONTO PARA QUE SAIA A ÚLTIMA ETIQUETA *}
      {*******************************************************************************MV*}
      pImpArrLinhasEti;
    End;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryCfgRel);
      FreeAndNil(qryImpEti);
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.pImpEtiquetasMatricial]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(qryImpEti);
end;

procedure TfrmAgrupDuplicatas.pImpRegistro(qryImpEti: TUniQuery);
  Var
    intQtdCol   : Integer;
    intQtdColOri: Integer;
    intContador : Integer;
    intLinhaAtu : Integer;
    intLinha    : Integer;
    intTamLinAnt: Integer;
    intNumCol   : Integer;
    intLinhaEti : Integer;
    strNumCol   : String;
    strLinha    : String;
    strSQL      : String;
    qryCnfEti   : TUniQuery;
    intQtdEti   : Integer;
begin
  intLinhaAtu := 1;
  intLinha    := 0;
  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  Try
    qryCnfEti := fCriaQuery(Self);
    With qryCnfEti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('TIPETI').AsString := 'CLI';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      intQtdEti := intEtiQtd;

      While (intQtdEti > 0) Do
      Begin
        First;

        If FieldByName('CNF_QTDCOL').AsInteger < 1 Then
        Begin
          fMensagem('ATENÇÃO!', 'CONFIGURAR NA TABELA CNFETI A QUANTIDADE DE COLUNAS DA ETIQUETA!', ['&Ok']);
          Exit;
        End;

        intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
        intQtdCol := intQtdColOri;

        If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
          intQtdCol := intQtdEti;

        {*****************************************}
        {* LÊ E INTERPRETA O ID = '00'           *}
        {**************************************MV*}
        If intColAtu <= 1 Then
        Begin
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
          {*****************************************}
          {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
          {**************************************MV*}
          pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, strNomImp, strNomPro, strDesPro);
        End;
        Next;

        If (Length(arrLinhasEti) = 0) Then
        Begin
          SetLength(arrLinhasEti, RecordCount-1);
        End;

        While (Not Eof) Do
        Begin

          If cpuCampos <> Nil Then
            FreeAndNil(cpuCampos);

          pAtualizaCamposUso(qryImpEti);

          strLinha := '';
          For intContador := intColAtu To intQtdCol Do
          Begin

            strNumCol := fStrZero(IntToStr(intContador), 03);
            intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

            intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
            pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfEti);

            arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
            strLinha := ''; //Se desistir da matriz, tirar essa linha

          End;
          Inc(intLinhaEti);

          {*****************************************}
          {* NEXT NO ARQUIVO DE CNF                *}
          {**************************************MV*}
          Next;

        End;

        intLinhaEti := 0;
        Inc(intColAtu, intQtdEti);
        Dec(intQtdEti, (intQtdColOri+1) - (intColAtu - intQtdEti));

        If intColAtu > intQtdColOri Then
        Begin
          pImpArrLinhasEti;
          intColAtu := 1;
        End;

      End;

    End;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryCnfEti);
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.pImpRegistro]');
    End;
  End;

  FreeAndNil(qryCnfEti);
end;

procedure TfrmAgrupDuplicatas.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
    Exit;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
      blnUltimoReg := True;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;

function TfrmAgrupDuplicatas.fPermiteFecharAgrupF11: Boolean;
  Var
    dtaIniTmp,
    dtaFinTmp: TDate;
    crTmp: TChamaRotina;
begin
  Result := blnF11 And fExisteCredComProfissionalDevMerc(edtCodCli.Text,
                                                         dtaIniTmp,
                                                         dtaFinTmp,
                                                         crTmp);
end;

function TfrmAgrupDuplicatas.fRealizarAgrupamento: Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;

  If AgrupContaReceber Then
  Begin

    If (fCfgSis('DTAAGR') = '3') And
        Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
        (StrToDateTime(mskDtaFin.Text) > VS_Date) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de cadastro do AG será ' + FormatDateTime('dd/mm/yyyy', VS_Date) +
                            ' pois a data final informada no filtro do período é posterior a hoje.',['&Ok']);
    End
    Else If (fCfgSis('DTAAGR') = '3') And fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi informado a data final no filtro do periodo. O AG será cadastrado com a data ' + FormatDateTime('dd/mm/yyyy', VS_Date),['&Ok']);
    End;

  End;

  If Not FSelTodas Then
    Exit;

  Try
    cdsClone := TUniClientDataSet.Create(Nil);
    pCloneDataSet(cdsClone, cdsCtaRec);
    cdsClone.Filtered := False;
    cdsClone.Filter   := ' CTR_MARDES <> ' + QuotedStr('M');
    cdsClone.Filtered := True;

    Result := (cdsClone.RecordCount = 0);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Para realizar o agrupamento é necessário que todas as duplicatas estejam marcadas. Por Favor, Reinicie a operação!', ['&OK']);
    End;
  Finally
    Begin
      FreeAndNil(cdsClone);
    End
  End
end;

function TfrmAgrupDuplicatas.fRetornaSQLCli: String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.CLI_CODCLI, ';
  strSQL := strSQL + '  CLI_QTDETI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_CGCCPF, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  CLI_STATUS, ';

  If blnEndCob Then
  Begin
    {*******************************************}
    {* DADOS PARA COBRANÇA                     *}
    {****************************************JB*}
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL,CONCAT(CLI_ENDERE, IF(IFNULL(CLI_ENDNUM, " ") = " "," ", CONCAT(", ", CLI_ENDNUM))), CLI_ENDCOB ) AS CLI_ENDERE, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_ENDCOM, "") AS CLI_ENDCOM, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_C_E_P_, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID) AS CID_NOMCID, ';
    strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS CID_ESTADO ';

  End
  Else
  Begin
    {*******************************************}
    {* DADOS PARA FATURAMENTO                  *}
    {****************************************JB*}
    strSQL := strSQL + '  CONCAT(CLI_ENDERE,IF(IFNULL(CLI_ENDNUM, "") = "", "", CONCAT(", ", CLI_ENDNUM))) AS CLI_ENDERE, ';
    strSQL := strSQL + '  CLI_ENDCOM, ';
    strSQL := strSQL + '  CLI_BAIRRO, ';
    strSQL := strSQL + '  CLI_C_E_P_, ';
    strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID, ';
    strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO  ';

  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI C ';
  strSQL := strSQL + '  JOIN CADCID          D1 ON CLI_CODCID    = D1.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID     D2 ON CLI_CIDCOB    = D2.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CLI_INFCRE CC ON CC.CLI_CODCLI = C.CLI_CODCLI  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + ' C.AUTOINCREM IN (' + strRegSel + ') ';

  Result := strSQL;
end;

procedure TfrmAgrupDuplicatas.pAtualizaCamposUso(qryImpEti: TUniQuery);
begin
  // Finaliza Campos Uso
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);

  // Atribui Campos Uso
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;

  cpuCampos.AdicionaCampos(qryImpEti, 'CADCLI');

end;

procedure TfrmAgrupDuplicatas.pAtualizaDtaVenc(dtaDtaVen: TDateTime);
begin
  With cdsCtaRec Do
  Begin
    Edit;
    FieldByName('CTR_DTAVEN').AsDateTime := dtaDtaVen;
    Post;
  End;
end;

function TfrmAgrupDuplicatas.fDocumentosComPendenciaCancelamento : Boolean;
  Var
    stlPendencias : TStringList;
    frmCancelamentoDocResumo : TfrmCancelamentoDocResumo;
Begin
  stlPendencias := TLogCanAgrupamento.VerificarPendencias(
    cdsCtaRec,
    function(ADataSet: TUniClientDataSet; const APendencia: TDtoLogCan): String
    Begin
      ADataSet.Filtered := False;
      ADataSet.Filter := Format('CTR_MARDES = %s AND NRODUP = %s AND CTR_ESPDOC = %s AND CTR_CODEMP = %s AND CTR_CODCLI = %s',
        [QuotedStr('M'), QuotedStr(APendencia.strNumDoc), QuotedStr(APendencia.strEspDoc), QuotedStr(APendencia.strCodEmp), QuotedStr(APendencia.strCliFor)]);
      ADataSet.Filtered := True;
      If Not ADataSet.IsEmpty Then
        Result := APendencia.strNumDoc + '-' + APendencia.strEspDoc + '-' + APendencia.strCodEmp + ' - Cliente: ' + APendencia.strCliFor
      Else
        Result := '';
    End,
    'C'
  );
  Try
    Result := stlPendencias.Count > 0;
    If Result Then
    Begin
      pCriarFormularios(TfrmCancelamentoDocResumo, frmCancelamentoDocResumo);
      Try
        frmCancelamentoDocResumo.Caption := 'Duplicatas com pendencia no cancelamento não podem ser agrupadas';
        frmCancelamentoDocResumo.memResumo.Lines.Text := stlPendencias.Text;
        frmCancelamentoDocResumo.memResumo.Lines.Insert(0, frmCancelamentoDocResumo.Caption);
        frmCancelamentoDocResumo.memResumo.Lines.Insert(1, '');
        frmCancelamentoDocResumo.memResumo.Lines.Insert(2, '');
        frmCancelamentoDocResumo.ShowModal;
      Finally
        pFreeAndNil(frmCancelamentoDocResumo);
      End;
    End;
  Finally
    FreeAndNil(stlPendencias);
  End;
end;

end.


